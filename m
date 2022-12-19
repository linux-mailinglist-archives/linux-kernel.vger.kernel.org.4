Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053F165149E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiLSVHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiLSVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 16:07:06 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C079FDD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 13:07:05 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 857C31EC06C0;
        Mon, 19 Dec 2022 22:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671484024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWS8nVwHrnKk4rH61ugvHQLrpBwE7+W6H6dxrqdsAWY=;
        b=UrXJ2WkQ46Y6tqCiuC2RagX1T8hbsDwOvf3lZodEivJ4pPknHhehIPDiPXAVHo4Te+A8Ps
        6LPZxsJj+tB+IDrgnNXM9Q5N4Syve98fZwX3ifItpHCQlaPVSZ6OmsPodEnU3GW1o33kfX
        Q+KfPD9T5mhnwFAeHCCNV0mHxpR3iVY=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] x86/microcode/AMD: Handle multiple glued containers properly
Date:   Mon, 19 Dec 2022 22:06:56 +0100
Message-Id: <20221219210656.5140-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221219210656.5140-1-bp@alien8.de>
References: <20221219210656.5140-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

It can happen that - especially during testing - the microcode
blobs of all families are all glued together in the initrd. The
current code doesn't check whether the current container matched
a microcode patch and continues to the next one, which leads to
save_microcode_in_initrd_amd() to look at the next and thus wrong one:

  microcode: parse_container: ucode: 0xffff88807e9d9082
  microcode: verify_patch: buf: 0xffff88807e9d90ce, buf_size: 26428
  microcode: verify_patch: proc_id: 0x8082, patch_fam: 0x17, this family: 0x17
  microcode: verify_patch: buf: 0xffff88807e9d9d56, buf_size: 23220
  microcode: verify_patch: proc_id: 0x8012, patch_fam: 0x17, this family: 0x17
  microcode: parse_container: MATCH: eq_id: 0x8012, patch proc_rev_id: 0x8012

<-- matching patch found

  microcode: verify_patch: buf: 0xffff88807e9da9de, buf_size: 20012
  microcode: verify_patch: proc_id: 0x8310, patch_fam: 0x17, this family: 0x17
  microcode: verify_patch: buf: 0xffff88807e9db666, buf_size: 16804
  microcode: Invalid type field (0x414d44) in container file section header.
  microcode: Patch section fail

<-- checking chokes on the microcode magic value of the next container.

  microcode: parse_container: saving container 0xffff88807e9d9082
  microcode: save_microcode_in_initrd_amd: scanned containers, data: 0xffff88807e9d9082, size: 9700a

and now if there's a next (and last container) it'll use that in
save_microcode_in_initrd_amd() and not find a proper patch, ofc.

Fix that by moving the out: label up, before the desc->mc check which
jots down the pointer of the matching patch and is used to signal to the
caller that it has found a matching patch in the current container.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 339c9666c8bc..d144f918a896 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -330,8 +330,9 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		ret = verify_patch(x86_family(desc->cpuid_1_eax), buf, size, &patch_size, true);
 		if (ret < 0) {
 			/*
-			 * Patch verification failed, skip to the next
-			 * container, if there's one:
+			 * Patch verification failed, skip to the next container, if
+			 * there is one. Before exit, check whether that container has
+			 * found a patch already. If so, use it.
 			 */
 			goto out;
 		} else if (ret > 0) {
@@ -350,6 +351,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		size -= patch_size + SECTION_HDR_SIZE;
 	}
 
+out:
 	/*
 	 * If we have found a patch (desc->mc), it means we're looking at the
 	 * container which has a patch for this CPU so return 0 to mean, @ucode
@@ -364,7 +366,6 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 		return 0;
 	}
 
-out:
 	return orig_size - size;
 }
 
-- 
2.35.1

