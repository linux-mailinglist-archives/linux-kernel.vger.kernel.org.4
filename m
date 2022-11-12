Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C5B626842
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbiKLJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKLJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:05:16 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C2FD4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:05:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id m6so6860496pfb.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0R04nFNy0DCngCUBrZtirCliOmgkwyhcEcHNxIQXNQ=;
        b=LZYK/mAepGZs5cWhglbOU46eQZTa3XI43hwKiwjnyUO/LeNOCpb6RURS1fUVxCRHHs
         4+Hgx8crpZj56lCnfIaaTboqmyrutKSSDA+PRlNkR+DKDNI4i1QJrhxRhw0bwVG/eOq7
         cS/1UqkJQpSVVtkMbFTNhyrXodYKku2TwJ62E7043da40BSFBxYZhf2ZsdGd9enuC2at
         p5+GolSpr7nIhoxPJ9u9h+BitABwxyp9K6GttYpE646rl1J7loFW1kgwbMfjGz2B34HO
         FQ0jDXH1boiZJ0OoF5z9Tskz5wUCp8UPCEtjSYrBwOVNB4Bl8LH8nRSMX+N2kEUzRD8w
         9cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0R04nFNy0DCngCUBrZtirCliOmgkwyhcEcHNxIQXNQ=;
        b=5Fb5okaT/DWhkPF89oNI52nRMJSsyQN+UjdqxUvBb8hvHRPFzz0x8+D1qzBLFJJGt8
         SY5o6+CikrLwKyK+JXGQo3qVSmxcljhN0VlkG27TCKY9f78pjK4B9wioEMMA0zV4AhzJ
         oxb2TOIfltv0muQrKpQMyY02lJUgM7QpPDrIKS80r4xmKHF2Pa4TAteZmHn5329g3BFr
         yv9XV3zpaOs7ZrqLt87xJWiBWlv7gy8P8jvEyoF8/HxzDntjsDB/6myEX2L4y9l7QqAV
         uNhEMwRe+ysCGyWcuqipaDIQx8NK3foUs5S8ZUkkgzEdKpqHEWFiDZftu+gf01+Rmqpj
         t/uQ==
X-Gm-Message-State: ANoB5pmR2vDn75qF8kTrkul0P3C2n+X8x1CGxBlADbQRsaQdCu2o2c0e
        ejDB6CwHy/vky/7FYmDbdnzleun1AjACABNm
X-Google-Smtp-Source: AA0mqf5se48K0xgxyaRfaRO+h4u+KthWO1jIhyM1ZxSLXoPk5RrK9daVAsaH0CDs7lnjtmTe0EmrxQ==
X-Received: by 2002:a63:cf53:0:b0:470:15cd:d425 with SMTP id b19-20020a63cf53000000b0047015cdd425mr4795001pgj.27.1668243914670;
        Sat, 12 Nov 2022 01:05:14 -0800 (PST)
Received: from fedora.. ([203.220.17.21])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b00212d9a06edcsm6072611pjb.42.2022.11.12.01.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 01:05:14 -0800 (PST)
From:   Samuel Zeter <samuelzeter@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Samuel Zeter <samuelzeter@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [RESEND PATCH v2 1/2] arch/x86/tools/objdump_reformat.awk: Ensure regex matches fwait
Date:   Sat, 12 Nov 2022 19:04:16 +1000
Message-Id: <20221112090418.284656-2-samuelzeter@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112090418.284656-1-samuelzeter@gmail.com>
References: <20221112090418.284656-1-samuelzeter@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is "wait" mnemonic in the line being parsed, it is incorrectly
handled by the script, and an extra line of "fwait" in
objdump_reformat's output is inserted. As insn_decoder_test relies
upon the formatted output, the test fails.

This is reproducible when disassembling with llvm-objdump:

Pre-processed lines:
ffffffff81033e72: 9b                    wait
ffffffff81033e73: 48 c7 c7 89 50 42 82  movq

After objdump_reformat.awk:
ffffffff81033e72:       9b      fwait
ffffffff81033e72:                               wait
ffffffff81033e73:       48 c7 c7 89 50 42 82    movq

The regex match now accepts spaces or tabs, along with the "fwait"
instruction.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index f418c91b71f0..276e572a6f60 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -12,7 +12,7 @@ BEGIN {
 	prev_hex = ""
 	prev_mnemonic = ""
 	bad_expr = "(\\(bad\\)|^rex|^.byte|^rep(z|nz)$|^lock$|^es$|^cs$|^ss$|^ds$|^fs$|^gs$|^data(16|32)$|^addr(16|32|64))"
-	fwait_expr = "^9b "
+	fwait_expr = "^9b[ \t]*fwait"
 	fwait_str="9b\tfwait"
 }
 
-- 
2.38.1

