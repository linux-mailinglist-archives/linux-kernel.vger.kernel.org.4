Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641CE69B3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBQU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjBQU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:28:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68F38012
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:28:13 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F7A91EC02FE;
        Fri, 17 Feb 2023 21:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676665691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MLA7uBjN35ddO4l5EJ/C1p9o8IspBo+EjzEONfhFBFM=;
        b=RBf2XDxS3sddQ87x9wzuNiEhLVymDrVyhDiyO9cqqHComU/4lmTHuDthqj4XmzkP1XoG0d
        /Y1eULvPwqcONgm2kkFXM0aaI5d1H2DTx5KUwUW4GDPM7+i3Tei/rGkUmGGLCNeawQn+U+
        VzNKd0IruQeowx249AKAl/WOGjK1e48=
Date:   Fri, 17 Feb 2023 21:28:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        kirill.shutemov@linux.intel.com, Andrew.Cooper3@citrix.com,
        jpoimboe@redhat.com
Subject: Re: [PATCH v3 2/4] x86/alternative: Support relocations in
 alternatives
Message-ID: <Y+/jVguijHJE+c/w@zn.tnic>
References: <20230208171050.490809180@infradead.org>
 <20230208171431.313857925@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208171431.313857925@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 06:10:52PM +0100, Peter Zijlstra wrote:
>  /*
> + * What we start with is:

Some more clarification and de-personalization of this comment. Diff
ontop:

---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 625f05c2b255..e14bc15bf646 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -201,15 +201,21 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
 }
 
 /*
- * What we start with is:
+ * In this context, "source" is where the instructions are placed in the
+ * section .altinstr_replacement, for example during kernel build by the
+ * toolchain.
+ * "Destination" is where the instructions are being patched in by this
+ * machinery.
+ *
+ * The source offset is:
  *
  *   src_imm = target - src_next_ip                  (1)
  *
- * what we want is:
+ * and the target offset is:
  *
  *   dst_imm = target - dst_next_ip                  (2)
  *
- * so what we do is rework (1) as an expression for target like:
+ * so rework (1) as an expression for target like:
  *
  *   target = src_imm + src_next_ip                  (1a)
  *
@@ -217,8 +223,8 @@ static void __init_or_module noinline optimize_nops(u8 *instr, size_t len)
  *
  *   dst_imm = (src_imm + src_next_ip) - dst_next_ip (3)
  *
- * Now, since the instruction stream is 'identical' at src and dst (we copy
- * after all) we can state that:
+ * Now, since the instruction stream is 'identical' at src and dst (it
+ * is being copied after all) it can be stated that:
  *
  *   src_next_ip = src + ip_offset
  *   dst_next_ip = dst + ip_offset                   (4)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
