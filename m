Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037286E6A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjDRQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjDRQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:58:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F5B1FDC;
        Tue, 18 Apr 2023 09:58:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id iw7-20020a05600c54c700b003f16fce55b5so221049wmb.0;
        Tue, 18 Apr 2023 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681837110; x=1684429110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htEOM+Ikc90thJKWWRaPX5zt7Zn39hsTXXh/gLC1YqY=;
        b=bIiUqlEBFnNz+aUwyGpmXamGyyUyRc7lKgFR25vAWO8BSgWllEpQ3LdbUi1+srlemg
         6xIWaxA9agtTzwRHb5u4gTiI0We3VYl6hCF4MoPlIAKINd1pN1ZM3S7YHJk+Lqm4/Rx/
         My1jAkm5KFjjVVw9vIbwUNAOnOOCWLGG/3qHYVC1CmJNuBPDi2wL14tAEJjyBC1pMOVz
         gxL19NI/I6VwxDkTVHzH8AXwEqsTli2UAMZJym7zrhCUFnFfSejUAS0j8CvHVGjsOjTo
         OM19jaeW8LZvpTGVmQm91ALEh2RZElazDD5hwVh7qkOyswBO1s4oRGrgI/3m+imCtyU/
         feGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681837110; x=1684429110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htEOM+Ikc90thJKWWRaPX5zt7Zn39hsTXXh/gLC1YqY=;
        b=IUA6AO60D+lKd39SMyHDDo06bWu27smyH4mNlBppsLIj5yGyUJ9iOKYwdoRgjQHDpU
         GS+V7K7cPgQyYSJTInNlij1bNg87No2ze90bSkOVqVhOsy1mrmLB3w8OYKIeDoMOgt0t
         k8oKIT9zE/etnhRx6aU6IdBq7bdCw0lpmmDWmciGSJd6CxxFQQ5DgL201Gkrmw5ZzHl7
         15VjagC/Ed7IfEELwf4WrY8JYIqvq/PzHQSoaLuJ16GGF7y4dDfJw8tf2PWKh0BumQkw
         DFDXKY1yJnViURQHV1Pd1eSYETJKPteT6EzX5j1z+coF55NLdAQRwtrvheMN3i9hENkN
         1pKg==
X-Gm-Message-State: AAQBX9fEj1ob88Y12TR+NkyWOSc68h9jSiQ3hXjqG1edQDBsYBAywhRs
        mHWeijvp9gkmLVd0OJiN1KCDm4Zh6SM=
X-Google-Smtp-Source: AKy350Zn+E40A6SYbpxgTNIvsA0Zo4nSAEFnrZOCzd8EofB9CrkLGStfXPxy364a1GPzJ2hB/nCnEQ==
X-Received: by 2002:a05:600c:22c7:b0:3f0:3ab2:a7e5 with SMTP id 7-20020a05600c22c700b003f03ab2a7e5mr15090656wmg.34.1681837109564;
        Tue, 18 Apr 2023 09:58:29 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id y1-20020a1c4b01000000b003ef5f77901dsm15481832wma.45.2023.04.18.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:58:29 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux OpenRISC <linux-openrisc@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 1/4] openrisc: Properly store r31 to pt_regs on unhandled exceptions
Date:   Tue, 18 Apr 2023 17:58:10 +0100
Message-Id: <20230418165813.1900991-2-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230418165813.1900991-1-shorne@gmail.com>
References: <20230418165813.1900991-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 91993c8c2ed5 ("openrisc: use shadow registers to save regs on
exception") the unhandled exception path was changed to do an early
store of r30 instead of r31.  The entry code was not updated and r31 is
not getting stored to pt_regs.

This patch updates the entry handler to store r31 instead of r30.  We
also remove some misleading commented out store r30 and r31
instructrions.

I noticed this while working on adding floating point exception
handling,  This issue probably would never impact anything since we kill
the process or Oops right away on unhandled exceptions.

Fixes: 91993c8c2ed5 ("openrisc: use shadow registers to save regs on exception")
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/entry.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 54a87bba35ca..a130c4dac48d 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -173,7 +173,6 @@ handler:							;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
 	/* r30 already save */					;\
-/*        l.sw    PT_GPR30(r1),r30*/					;\
 	l.sw    PT_GPR31(r1),r31					;\
 	TRACE_IRQS_OFF_ENTRY						;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
@@ -211,9 +210,8 @@ handler:							;\
 	l.sw    PT_GPR27(r1),r27					;\
 	l.sw    PT_GPR28(r1),r28					;\
 	l.sw    PT_GPR29(r1),r29					;\
-	/* r31 already saved */					;\
-	l.sw    PT_GPR30(r1),r30					;\
-/*        l.sw    PT_GPR31(r1),r31	*/				;\
+	/* r30 already saved */						;\
+	l.sw    PT_GPR31(r1),r31					;\
 	/* Store -1 in orig_gpr11 for non-syscall exceptions */	;\
 	l.addi	r30,r0,-1					;\
 	l.sw	PT_ORIG_GPR11(r1),r30				;\
-- 
2.39.1

