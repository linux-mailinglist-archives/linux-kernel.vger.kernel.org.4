Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73D5E7A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiIWL6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiIWL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:58:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C3AEE1D;
        Fri, 23 Sep 2022 04:58:09 -0700 (PDT)
Date:   Fri, 23 Sep 2022 11:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663934287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i03ueGjuv9MXq9D254vKOx55F55SuESMpzw6hrHEEi0=;
        b=rppYjrSk7/wgCe2lu4BqRuaTxn2l1tme1m+87lVna4P8r3zz2JnhR4OtnkqKcfsMCW25OM
        0jkqnUQghaY/UA3q0HE8nIBkAinmIrE+XBuIx6UVkS+o4fs2WVfVkR3kKVC+jsViAmQL5R
        mrZw2ChXLkuWOr2FsccZIw3k/WBdwJVq7QS5+fV95934JxhpxKJVopS1vACvpa7nE5Llvj
        1+cpIcju1yQU887hghmFfUgNivgLjej9ia1vAO25d9ymro2NcRgYu54DrSL31bAOadL2bN
        B8o9imF9hlkCHBDF2lGQ0UWzrmIdhwZAH30VtbE5uDkPXgONW0L3nmkD1fdFiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663934287;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=i03ueGjuv9MXq9D254vKOx55F55SuESMpzw6hrHEEi0=;
        b=iyX/i3nWH8cO7WxOMKGgW5HayOY6sNuh73cHg6qPNkHNnMzNk7S9bQRjMQpf09UveyQqjw
        oOOtLGKp6bP+tEBw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Track patch allocation size
 explicitly
Cc:     Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166393428565.401.8875317837868783254.tip-bot2@tip-bot2>
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

Commit-ID:     712f210a457d9c32414df246a72781550bc23ef6
Gitweb:        https://git.kernel.org/tip/712f210a457d9c32414df246a72781550bc23ef6
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 21 Sep 2022 20:10:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 23 Sep 2022 13:46:26 +02:00

x86/microcode/AMD: Track patch allocation size explicitly

In preparation for reducing the use of ksize(), record the actual
allocation size for later memcpy(). This avoids copying extra
(uninitialized!) bytes into the patch buffer when the requested
allocation size isn't exactly the size of a kmalloc bucket.
Additionally, fix potential future issues where runtime bounds checking
will notice that the buffer was allocated to a smaller value than
returned by ksize().

Fixes: 757885e94a22 ("x86, microcode, amd: Early microcode patch loading support for AMD")
Suggested-by: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/lkml/CA+DvKQ+bp7Y7gmaVhacjv9uF6Ar-o4tet872h4Q8RPYPJjcJQA@mail.gmail.com/
---
 arch/x86/include/asm/microcode.h    | 1 +
 arch/x86/kernel/cpu/microcode/amd.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7f7800e..74ecc2b 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -9,6 +9,7 @@
 struct ucode_patch {
 	struct list_head plist;
 	void *data;		/* Intel uses only this one */
+	unsigned int size;
 	u32 patch_id;
 	u16 equiv_cpu;
 };
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 5f38dd7..e7410e9 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -788,6 +788,7 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 		kfree(patch);
 		return -EINVAL;
 	}
+	patch->size = *patch_size;
 
 	mc_hdr      = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id     = mc_hdr->processor_rev_id;
@@ -869,7 +870,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 		return ret;
 
 	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
-	memcpy(amd_ucode_patch, p->data, min_t(u32, ksize(p->data), PATCH_MAX_SIZE));
+	memcpy(amd_ucode_patch, p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
 
 	return ret;
 }
