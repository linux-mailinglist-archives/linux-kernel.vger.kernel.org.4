Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68616DFDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjDLSpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjDLSpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:45:16 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9E340F9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:12 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id q33-20020a056830442100b006a419d3fd20so1535945otv.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325111; x=1683917111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gohAHfVouxgH+hJvQeBGsiMrbLKAn/aPyvmRUBO2xEM=;
        b=YW6v+uz3qLfkDmYU4CXaszKD4ilipn8i1QxYvhvAwxqWKFqzj7dFKLr203+A9asdY9
         xjK0d/O6ztAML6al9g0iq8HgJAAsA5FmEqjokrczDgEanMZjS0B3rfWuahg/KlbImutI
         SEUvvyhmi5Xiv+Olkf2HYaHBd7G9WIUGFkSA4gsr7FXxtXDFjFXU08m1NXTodPKAjQwt
         QMevu8h3Bclig7Tr0zibaVAv8CKgdyzVITy2AP+xO3w9CQvHmME3J1aYyUL86vjqmt9H
         4HNytispBkPMOieHPnA2fM+Z194+6c01Wm5TJK0rf3VqpWPKfrCnAPcvMDIRrYEXzzs5
         XXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325111; x=1683917111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gohAHfVouxgH+hJvQeBGsiMrbLKAn/aPyvmRUBO2xEM=;
        b=WO1Sgsi7ribYBD4NMcwAiM1gwrHOYaQN+M4ZNRRetvHgYM/f9edwYfjvIpxEBQ3Zpa
         r842cTgTYwcB+iUDZw7EhqOSLohKYG56/OBu6jDPKr9cF39QsuzxRb5xPFmuZNbzo648
         UOMvnNAEAbquzhR71fTsXrJ+6tpmHX4sqYOC2nxMufpJ7opc0qPSzBUYmb4K0XuR4orf
         XvDBUHrD5J1F88N+fxSlEUX+pLAoiDSmEo0viPk51mPQARXfDlVEwaqSK0KYH0wtNzRr
         B6VxaN3ePfKP3Lcj3siK2pozDUzPy11eZVB+pjVyMifpTVqaQ3iWdvkp7JilKTID6FtV
         COUg==
X-Gm-Message-State: AAQBX9erYVkhD2wMaKfJhIbzYBGVtIEULOm5qbNfNUtHYp7IIdgS+/CO
        bz5oBzoVuxNWHDsMui5C0Qo0z7iAsw==
X-Google-Smtp-Source: AKy350YXw/BZt/KMMSlZbP+KGx81bHHOzcPZWxyKCSBi/ctfiWFTzfz9f6CbDPKvcIpKh7e5nT/MZw==
X-Received: by 2002:a9d:7a8f:0:b0:6a4:2e4c:de05 with SMTP id l15-20020a9d7a8f000000b006a42e4cde05mr224447otn.1.1681325111484;
        Wed, 12 Apr 2023 11:45:11 -0700 (PDT)
Received: from citadel.. (075-129-116-198.res.spectrum.com. [75.129.116.198])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d77d8000000b00690e990e61asm6706020otl.14.2023.04.12.11.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:45:11 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 2/6] x86/boot: Remove extra call to copy_bootdata()
Date:   Wed, 12 Apr 2023 14:44:58 -0400
Message-Id: <20230412184502.145289-3-brgerst@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230412184502.145289-1-brgerst@gmail.com>
References: <20230412184502.145289-1-brgerst@gmail.com>
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

The call to copy_bootdata() in x86_64_start_reservations() is only
applicable to Xen, since native has already call it.  Xen on the other
hand, has already filled in boot_params and just passes its address in,
so the copy ends up being a no-op and can be removed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/setup.h | 2 +-
 arch/x86/kernel/head64.c     | 8 ++------
 arch/x86/xen/enlighten_pv.c  | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index f37cbff7354c..fd409b7dda74 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -129,7 +129,7 @@ asmlinkage void __init i386_start_kernel(void);
 
 #else
 asmlinkage void __init x86_64_start_kernel(char *real_mode);
-asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
+asmlinkage void __init x86_64_start_reservations(void);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 4a3b195c9002..6e0f53a66678 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -533,15 +533,11 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* set init_top_pgt kernel high mapping*/
 	init_top_pgt[511] = early_top_pgt[511];
 
-	x86_64_start_reservations(real_mode_data);
+	x86_64_start_reservations();
 }
 
-void __init x86_64_start_reservations(char *real_mode_data)
+void __init x86_64_start_reservations(void)
 {
-	/* version is always not zero if it is copied */
-	if (!boot_params.hdr.version)
-		copy_bootdata(__va(real_mode_data));
-
 	sanitize_boot_params(&boot_params);
 
 	x86_early_init_platform_quirks();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5a034a994682..a4db5c28af57 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1430,7 +1430,7 @@ asmlinkage __visible void __init xen_start_kernel(struct start_info *si)
 
 	/* Start the world */
 	cr4_init_shadow(); /* 32b kernel does this in i386_start_kernel() */
-	x86_64_start_reservations((char *)__pa_symbol(&boot_params));
+	x86_64_start_reservations();
 }
 
 static int xen_cpu_up_prepare_pv(unsigned int cpu)
-- 
2.39.2

