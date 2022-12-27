Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8279E6568D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiL0J1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiL0J1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:27:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D265DB;
        Tue, 27 Dec 2022 01:27:38 -0800 (PST)
Date:   Tue, 27 Dec 2022 09:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672133256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07xF+6hRsc8ELTl0SNyOAwoLSpIteGOwrjyGZCLRCn8=;
        b=RLE07RZ/tyYyMP4j3LN60BcXEAEeLNlrwcYZL79TCgA02kLeeuX/HpOLtYIrPBAUSXM23K
        1IV3mR4o/FtiROktP4o/D1mwbYs8fw0lw5f2q3ZKqApljBWbjioB0ueWqzdpZYCnC3xFm1
        5eIJAmDiXnaNNpeD3pgiT5xBme3onXykiE+0aDQsCszKrQMOa5ON9gL4LO0OrFYYEXCwDz
        tU+17DixqGKYd5MuFecK98HpLccLm5HI7nwor7wGda7f0h2xxSuPtNDFlS/tFGD6h/WRPx
        oUA7+IiKxCYv9R/zfL0NaQjOl3aoCMD9D5EuZxfHwl5262tchbB2TeC/YCBG+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672133256;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=07xF+6hRsc8ELTl0SNyOAwoLSpIteGOwrjyGZCLRCn8=;
        b=8bGUdMimCid6n2lBETtuNL/1nNrhGbVUAjcBLJUP7fFo1hUDYrDf9nrIlXomK9LH+nDU0i
        LSxFz4w+VBG2zNCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Handle multiple glued
 containers properly
Cc:     Borislav Petkov <bp@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221219210656.5140-2-bp@alien8.de>
References: <20221219210656.5140-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167213325509.4906.5221750679090599711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     ba73e369b706a853cdafa60570854fecec9f9fdd
Gitweb:        https://git.kernel.org/tip/ba73e369b706a853cdafa60570854fecec9f9fdd
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 19 Dec 2022 22:06:56 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 26 Dec 2022 06:41:05 +01:00

x86/microcode/AMD: Handle multiple glued containers properly

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20221219210656.5140-2-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 339c966..d144f91 100644
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
@@ -350,6 +351,7 @@ skip:
 		size -= patch_size + SECTION_HDR_SIZE;
 	}
 
+out:
 	/*
 	 * If we have found a patch (desc->mc), it means we're looking at the
 	 * container which has a patch for this CPU so return 0 to mean, @ucode
@@ -364,7 +366,6 @@ skip:
 		return 0;
 	}
 
-out:
 	return orig_size - size;
 }
 
