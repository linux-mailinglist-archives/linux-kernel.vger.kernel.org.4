Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABCC69CC09
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjBTN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 08:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjBTN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 08:26:09 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0E7EC6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:26:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ck15so5901387edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5IBUKNSaWiWInXu6OYILwtp7AXbJZx47j7slanBdCf0=;
        b=YN1/tNNMbzVhCzdntm0iWbUPDn3obbvpgGEaXGuYQIFHU53CYcenApq7JiKR1Vt5ru
         O0FGU9G/I4aRWyZrKtsH5ndZLpTDRgWHvG/7Fjosxlf+4vHEEFvlEFciMs3y2e3dO+zA
         nfCuuynPF3LcALUSo0oJpXrKnbx+QVRIlUd/1IhZV5Jh38+XTamHnmhdr3M5lX2XlEwf
         arU3+WL+AuAnxfObJVUEtAB0yHyfyC/Ls/xoYgElZJ2tKmu2McYPwUzukV8SQNf9bFoh
         G63ir9HR28o6QqD8qjR3FAvZpmRC4du1faTmVuiT0mUw26ipSKWKM0SbQprb19Jg2oGS
         VsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IBUKNSaWiWInXu6OYILwtp7AXbJZx47j7slanBdCf0=;
        b=uucNpn0TdbKyHocmFCdp2KDtQu9y+HXiRyb25kkKPm7QrTpLm8UM79o/f0aHggSXfH
         tYuY/kcvYD92Db1Lsl04rA7IurFuZ+bxtcwGpZ5W0yKQxO0BRdlPuYhwwiQ/GPBzw1j0
         ySXEN7+M5HT3JEQ8DHclSDTH/McAuiYgjXvAna9ZgoWysL0IoA06MkQ0aiyBSHfRq9my
         zJbd0Kgqlyk2iI9kId8fE5kCXekRJasnzmGOhkVJ+06l8xEuIS/P8z5bQXPZQrcSBomq
         q+Fggay74HdvLz0oEmtd5fHO/GB9DxaLKJEHfjHOf1F36q9LmTzTrqEpq5Hw9OlYDXCs
         UPtw==
X-Gm-Message-State: AO0yUKV2iDCjwreX7z8esA4W8os3NF3phO5FZA3dALF2UUL0lQipvawd
        xzHnC7iA1iVsxKDGde4HmiI=
X-Google-Smtp-Source: AK7set+1+/Ka5eQkSHnm59WD/Hj3yAoEZ/qdR7R/oiTMZ84mDiL3Si/r/t71enoa93nctxGptIJQFw==
X-Received: by 2002:a17:906:2c52:b0:872:b17a:9b59 with SMTP id f18-20020a1709062c5200b00872b17a9b59mr7890693ejh.38.1676899567433;
        Mon, 20 Feb 2023 05:26:07 -0800 (PST)
Received: from gmail.com (1F2EF163.nat.pool.telekom.hu. [31.46.241.99])
        by smtp.gmail.com with ESMTPSA id z12-20020a1709064e0c00b008c405ebc32esm2840929eju.28.2023.02.20.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 05:26:06 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 20 Feb 2023 14:26:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm change for v6.3
Message-ID: <Y/N07fFHFlotQJEg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/mm git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-02-20

   # HEAD: ebd3ad60a688131de7df1dd05fd2d7c57f542268 x86/cpu: Use cpu_feature_enabled() when checking global pages support

Micro-optimize __flush_tlb_all().

 Thanks,

	Ingo

------------------>
Borislav Petkov (AMD) (1):
      x86/cpu: Use cpu_feature_enabled() when checking global pages support


 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9a85d7..92d73ccede70 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1205,7 +1205,7 @@ void __flush_tlb_all(void)
 	 */
 	VM_WARN_ON_ONCE(preemptible());
 
-	if (boot_cpu_has(X86_FEATURE_PGE)) {
+	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
 		__flush_tlb_global();
 	} else {
 		/*
