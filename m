Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F4626843
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 10:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiKLJF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 04:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiKLJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:05:22 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765BF31FAC
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:05:21 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 136so6206463pga.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 01:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95GT+CzPNXJHEEeCgfKVSRCFhHGq9YtSWe72aa0XfkQ=;
        b=Zg44tReFu/Dkdm10k+vsqEyM3jv8PLAlzzlni9UD7FvfoMUyxKgEsl2ZLMuT9uXD++
         xmGOpy8ixIQCGQ9nFY62d5zHmIyBqt9V+TmzbI1/53Qbe2RbyVIhfakd/2Q3EUGr+mlT
         pBC2hho0J+K7Iw3HQVlLJi/tlzs9NL/yMUj0iZcPDVOkqmaadZPDX9w8/w0XzX17xsP4
         NrfrSfV9I4EDzbfdrWYedv85qBABJlu+rPutlUauQau3af/NCEjLukPl8HmRyyZXYxWo
         ufVNUX3bl424BRlzwMMMN6k770sGt1Xyvu4TFGeHk9M+dkLR7nZdYySbzZQ5uo2aO6MJ
         Yrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95GT+CzPNXJHEEeCgfKVSRCFhHGq9YtSWe72aa0XfkQ=;
        b=NeBCs0QkQJ1Rida0trEh93MBFEJZ5n9xkl0oJ3X9f7Bemz7I7E6y1oZghsl+Aightv
         69BtM9E7IoAft53QfwmXnq5qteKfyhVIRQs9lGNBpHUB3WL6XxwbIipJw/NqRMrvuaC8
         PhKAEIF+PgEryV+0t0cFjvC7kGrOmCrdbacp6Fyt7sZClsQFN+H2Df4XOJghbKwQDSx9
         9zIolGDiondSrx76wVghMw8uR9hlm1NRfEl86o+qYox0GbgD7TLA+4mYCf04caSW+0Yo
         EbY8At3I+vXY8NgqcwKLBYXpb+jj0YYqKrugvWb4ziwolcNM5k78i/aAgqeZPn6kEP/4
         UGeA==
X-Gm-Message-State: ANoB5pnYgvjL04/5TIMnP8wwaZYHBR6Xq1viZXTKEmLHaNOTpafexaZl
        mmt2493q3OmkGoVNSD4ZOK+ks4wBJ3xBSToT
X-Google-Smtp-Source: AA0mqf72pC10icczFCZ6doTOF7zUy8z7B+V3YgCUju/LjZRoxaJHMltwLlS7H7wm8x8z65N0TTYqUg==
X-Received: by 2002:a63:5063:0:b0:45f:88b2:1762 with SMTP id q35-20020a635063000000b0045f88b21762mr4553333pgl.341.1668243920882;
        Sat, 12 Nov 2022 01:05:20 -0800 (PST)
Received: from fedora.. ([203.220.17.21])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b00212d9a06edcsm6072611pjb.42.2022.11.12.01.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 01:05:20 -0800 (PST)
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
Subject: [RESEND PATCH v2 2/2] arch/x86/tools/objdump_reformat.awk: Allow for spaces
Date:   Sat, 12 Nov 2022 19:04:17 +1000
Message-Id: <20221112090418.284656-3-samuelzeter@gmail.com>
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

objdump and llvm-objdump have differing output formats. Specifically,
objump will format its output as: address:<tab>hex, whereas
llvm-objdump displays its output as address:<space>hex.

objdump_reformat.awk incorrectly handles this discrepancy due to
the unexpected space and as a result insn_decoder_test fails, as
its input is garbled.

The instruction line being tokenized now handles a space and colon,
or tab delimiter.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index 276e572a6f60..a4120d907277 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -22,7 +22,7 @@ BEGIN {
 }
 
 /^ *[0-9a-f]+:/ {
-	if (split($0, field, "\t") < 3) {
+	if (split($0, field, /: |\t/) < 3) {
 		# This is a continuation of the same insn.
 		prev_hex = prev_hex field[2]
 	} else {
-- 
2.38.1

