Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464F865B62A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbjABSEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbjABSEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:04:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA4BF71;
        Mon,  2 Jan 2023 10:04:18 -0800 (PST)
Date:   Mon, 02 Jan 2023 18:04:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672682656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgKCXWkN7D8Vg195mJtIF+wUSL0imvOrcDn3Mz+6ocs=;
        b=XTwnaTJijdkAETCDOlgxzeUpPCLlUVoBrj9LKH8JSswCopF5mmPDTB2csg7Oh3DnnDOaiW
        k6U2JWU0i7Ow5hkobVWJKArPElSXzpMVgKbpXhmAUOZbLhklyg7RiIVO6YEh8UPt1fxTjQ
        pulpwNAdziO/N6ba3U2WBubxxD6EephJr0ZxDFmu9A6sDnf4Bptxn57Z7pK1/bt+ATtS4j
        CgN1NwxpB39B2N1UKZBcZh73ujshmb7xDBVLD3oH1ZrnB9On1KQ4UeVsXUI52IwMXC+T8a
        LQtvr7TDXPAhutQDhCsrtUsDfHJWBD4LlzvPKhw9hnXr/ElK4wOtN3bMTI5FgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672682656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgKCXWkN7D8Vg195mJtIF+wUSL0imvOrcDn3Mz+6ocs=;
        b=36BKUqqbDT2mfBN84y+MMIO3vC/TFvwzm5Ix81tRFdzfiRtH40hbtBuaozbrsn9FPNRsBk
        yvj1jOskWh6iX+BA==
From:   "tip-bot2 for Takashi Iwai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/kexec: Fix double-free of elf header buffer
Cc:     Takashi Iwai <tiwai@suse.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Baoquan He <bhe@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        <stable@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221122115122.13937-1-tiwai@suse.de>
References: <20221122115122.13937-1-tiwai@suse.de>
MIME-Version: 1.0
Message-ID: <167268265568.4906.5498168349735742588.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d00dd2f2645dca04cf399d8fc692f3f69b6dd996
Gitweb:        https://git.kernel.org/tip/d00dd2f2645dca04cf399d8fc692f3f69b6dd996
Author:        Takashi Iwai <tiwai@suse.de>
AuthorDate:    Tue, 22 Nov 2022 12:51:22 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Jan 2023 18:56:21 +01:00

x86/kexec: Fix double-free of elf header buffer

After

  b3e34a47f989 ("x86/kexec: fix memory leak of elf header buffer"),

freeing image->elf_headers in the error path of crash_load_segments()
is not needed because kimage_file_post_load_cleanup() will take
care of that later. And not clearing it could result in a double-free.

Drop the superfluous vfree() call at the error path of
crash_load_segments().

Fixes: b3e34a47f989 ("x86/kexec: fix memory leak of elf header buffer")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Baoquan He <bhe@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20221122115122.13937-1-tiwai@suse.de
---
 arch/x86/kernel/crash.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88..3055144 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -401,10 +401,8 @@ int crash_load_segments(struct kimage *image)
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
-	if (ret) {
-		vfree((void *)image->elf_headers);
+	if (ret)
 		return ret;
-	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
