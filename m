Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7176CD484
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjC2IW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjC2IW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:22:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6FB4ED6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:21:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q19so11683933wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680078096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WewY0DznJP4LApS0GHZeFjLTcqljUJT3mfDrQD/hrs=;
        b=1j+yjVFzgDuEqDrH3wcL6j4lDQph105p+FxdB5PlVelAMl/atkJx91n8nnhjNlyp6k
         7Gchfj9ofuRnBYEFoSDWibQG3PxSjm9l61j4kHzr8i3kVMlF87wXOxuwfN4mSZ02XkFg
         91aUrbYiXIew8Kpm4w38L75Zj1fphTKi5aofFqGKGt6hZ/PSfbmth0UQp1zROHzqoZZr
         otCGq5bPYPDSFRTxrfstKQBTB9JshQK4VEgcOku7pf5LIZr0GintP9TO+jF0EmetGLOb
         5r1B68Pgd0pIIQx7+0Uxgx3l181h/felieYAM64eli3GDO0cx7G2+sLlKMlm1nSo2XE9
         Yd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WewY0DznJP4LApS0GHZeFjLTcqljUJT3mfDrQD/hrs=;
        b=s/d9BVaCb10ClDf/EflxduSPzuemS2S1PnWMxDSyk671xJ+UzseVRcUsknnDjOGdTH
         8VzMjRQFnPQ2uQ1OeEd1wMsaVCcADnSJwdIY3KgB5E1vn4Qy3uH2N46GWpSuhXU2Ytq7
         wkhqMZBsyJETk/OaiWB7qbWN4yLfJ2jjDHQX9WBELASdfKbM2zmgFomx6N0qmx0IF7my
         A2eznM+BsAVWma6D452UaSYGxsazMvwkIpGzALxI+NwEBeWDGWGNOVoD2jPbfICiD7i1
         ElkQ7DHBgKLrtoPRa2QiICWpwA03ph1agrf0wRMKk46f4AoODIF2fhF251MzNTUDOmpa
         tbXw==
X-Gm-Message-State: AAQBX9d2YZCtLwwKTHbCTjmbPX+mTRMozClLHX60psx0+C7zJzDBD9xP
        F+Ue5EEuevAirD0EWfXOjWJong==
X-Google-Smtp-Source: AKy350Z+kqeHRHKVqi6mrMxS4VxHHOKVytdbwzxF+3lbgNW435IPFEJEmKiv6Ii7I0mVXVrMHAdayQ==
X-Received: by 2002:a5d:674e:0:b0:2d2:74d6:6f79 with SMTP id l14-20020a5d674e000000b002d274d66f79mr15795845wrw.59.1680078096581;
        Wed, 29 Mar 2023 01:21:36 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b002d78a96cf5fsm22499173wrf.70.2023.03.29.01.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:21:36 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes v2 2/3] riscv: Do not set initial_boot_params to the linear address of the dtb
Date:   Wed, 29 Mar 2023 10:19:31 +0200
Message-Id: <20230329081932.79831-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329081932.79831-1-alexghiti@rivosinc.com>
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_init_dt_verify() is already called in parse_dtb() and since the dtb
address does not change anymore (it is now in the fixmap region), no need
to reset initial_boot_params by calling early_init_dt_verify() again.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 542eed85ad2c..a059b73f4ddb 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
 #else
-	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
-		unflatten_device_tree();
-	else
-		pr_err("No DTB found in kernel mappings\n");
+	unflatten_device_tree();
 #endif
 	misc_mem_init();
 
-- 
2.37.2

