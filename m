Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2345702388
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 07:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjEOFuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 01:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbjEOFuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 01:50:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF332684
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:49:51 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53033a0b473so5856022a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 22:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129791; x=1686721791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iGXLwFtJb/ikFg1cYTajKxo15m1ntUjHJP3AtJxPHQ=;
        b=dzjo8FojeRcnufXLfXC0KBxuYEA22LD3hfHOwXg4ZDuLKLv0BrqZuH8SGOB++jp5uO
         wzKiYKHcGFS22nfktsiZ/0soliO+6KwkV1F/CT4cSacQXjZNHJvQslYLfkfOySySRtSC
         8UjaZJDHoN+NS64WsDBJKuPA3FJoVOmbNNpbeSntaVz+MYmRbJtjWSbb0awzzHpNTzQM
         iMrORsenLXTKP1MfGL3i50980w+juwmbTsihGPxC1TFAomikj8sy7z3tZ5zOxuVobKLf
         PO/dJlkFK4Nme80wJtwvZuMrtkTbpTOttq+0KOfxO/f5tg65WVxizgRj349mCeC4zcqw
         YAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129791; x=1686721791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iGXLwFtJb/ikFg1cYTajKxo15m1ntUjHJP3AtJxPHQ=;
        b=SMevbhdO+Yw0pz+EljZDTTLecsQ85h78esrMcy35Lrr3FXH2d6xbnXck+0At5kVmkp
         yWiu8n+AzFav2vPDNtgCh6U8yQbrkyX1hjcM6eEW1KArokLoahx0NXA5tbGuXiGGdazZ
         K3haEBeX8a7xQjY9UuZj3OSc4vxGgmViqYfGt8Pq2NPlenIGH1I6i+mVxscOh/m1yiDv
         DABcQDtMHX7p20VWyTdc9kjfoVDALbxO9d23mTIHCmnG7gx27VDBN3+7fcF9yYavk1pT
         YoCdmJ79875d/RTrkgv3pvVhQG73pThG2eZpUYGnYUYK28RmgsBLY9RJtCIy31GKAPus
         xEwQ==
X-Gm-Message-State: AC+VfDxv0eMOKW12cLojY+PU3TNZMeAVan11hFxuBV3+EQGgZ8UqXPMk
        NnxKZ4pCGApDYXSc6dJrtgIdxA==
X-Google-Smtp-Source: ACHHUZ5Z2n4/ARSq3kgTidyaSTNrk+RwN40D33bxOlnfkr8ZPEoD5Bs6K7sM3BLGphGdcRXft9Eprw==
X-Received: by 2002:a17:902:e5cf:b0:1ad:e3a8:3bf with SMTP id u15-20020a170902e5cf00b001ade3a803bfmr12750021plf.21.1684129790858;
        Sun, 14 May 2023 22:49:50 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:49:50 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH V6 02/21] platform/surface: Disable for RISC-V
Date:   Mon, 15 May 2023 11:19:09 +0530
Message-Id: <20230515054928.2079268-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_ACPI enabled for RISC-V, this driver gets enabled
in allmodconfig build. However, RISC-V doesn't support sub-word
atomics which is used by this driver and hence allmodconfig
build will fail.

There is currently no plan to support this driver for RISC-V. So,
disable this driver for RISC-V even when ACPI is enabled.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index c114f9dd5fe1..88afc38ffdc5 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -4,7 +4,7 @@
 menuconfig SURFACE_AGGREGATOR
 	tristate "Microsoft Surface System Aggregator Module Subsystem and Drivers"
 	depends on SERIAL_DEV_BUS
-	depends on ACPI
+	depends on ACPI && !RISCV
 	select CRC_CCITT
 	help
 	  The Surface System Aggregator Module (Surface SAM or SSAM) is an
-- 
2.34.1

