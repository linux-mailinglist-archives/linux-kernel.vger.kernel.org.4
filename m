Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5B0665AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjAKMFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbjAKMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:04:15 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331EDE09D;
        Wed, 11 Jan 2023 04:02:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b4so2467779edf.0;
        Wed, 11 Jan 2023 04:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSuqfITy3pm9CBhTZW7epwEnvbhgxRePj6Bs2ANFDpM=;
        b=N1zS2hQ1HfEy0d09EjJCAjf3Vqojk+cS720EpMWNIeTlJ2I80nW2qQf8Zy+ZypDx0v
         XLZVBsknEaUA0QubwMJwF8m8lmHgHJoQaZ3PxBPlNxMOc9RfduDJk36yPddNk2nrGU9f
         /dJPghA+Ozl7657uwIVw7oTQm71EA1jsa4Y0c8LCobifFCens8JZzuat5iqaDnz97KlH
         wGBFFGgI/mL07XvMLUELztxBEZ7iWGc4Ep2XSU6Vm4nqr7DcdydTtu9+0BKix56JCn6Y
         9hRSn337QSa097wypWNnESgiPJkv7BfH1PjGJJj0PcWb0RhzjCspRwjITeojGLQmxjyf
         LvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSuqfITy3pm9CBhTZW7epwEnvbhgxRePj6Bs2ANFDpM=;
        b=kAGMX2ianm7ukDxWdpbyMnzgv3TVoBB+HpoPaCd8ufxP2h5sBkoYIGrcO2MjFK8xTM
         1EMSYR8x0iSMx3Xa21jPS1jpf1TKQOwBRDe1zO8poc4PIWgJ4aOg080D1rOwzqBUryIe
         OiI26VMKih5hT2X2ULZdH1+5yb+c2ApQCxoZhP4FHHswELxvVKSi2MkX1N1io9ZEl1Xq
         loQ3s8xAZLvfsSKanyltOnOyNypJmpxwIt5dJBAnglgXa93PePCVvhXfaxL5v76YUEQZ
         Le5nlvE+WSNdkVmtLfIVPe1MEbwfrHK43033BPUASahsxMdjG3Xf75BJuhcGcH5jJGPz
         Jbww==
X-Gm-Message-State: AFqh2kpJkunSmgX2AKKTVJp/8OPsaibrBjHhOa4olrFPlR+WR54KYG2m
        ZrDkEmx5USXZ6ygrrknRS+BNVOE5QJE=
X-Google-Smtp-Source: AMrXdXuNHA9Xyr1zGaRBGq3GFbifwPFLIhsMvnW3acesULec+F01SyfhE+HE+O82bqgEsIdqJF6mTA==
X-Received: by 2002:a05:6402:34f:b0:461:7c4e:c437 with SMTP id r15-20020a056402034f00b004617c4ec437mr66195299edw.1.1673438538628;
        Wed, 11 Jan 2023 04:02:18 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a47e:7f3e:6b25:bafb])
        by smtp.gmail.com with ESMTPSA id p9-20020aa7d309000000b0046776f98d0csm6002410edq.79.2023.01.11.04.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 04:02:18 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] crypto: hisilicon - remove redundant config PCI dependency for some CRYPTO_DEV_HISI configs
Date:   Wed, 11 Jan 2023 13:02:03 +0100
Message-Id: <20230111120203.822-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing dependencies in some Kconfig files, I noticed the redundant
dependency "depends on PCI && PCI_MSI". The config PCI_MSI has always,
since its introduction, been dependent on the config PCI. So, it is
sufficient to just depend on PCI_MSI, and know that the dependency on PCI
is implicitly implied.

Reduce the dependencies of configs CRYPTO_DEV_HISI_SEC2,
CRYPTO_DEV_HISI_QM, CRYPTO_DEV_HISI_ZIP and CRYPTO_DEV_HISI_HPRE.

No functional change and effective change of Kconfig dependendencies.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/crypto/hisilicon/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 743ce4fc3158..4137a8bf131f 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -27,7 +27,7 @@ config CRYPTO_DEV_HISI_SEC2
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_SM4_GENERIC
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	depends on UACCE || UACCE=n
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	depends on ACPI
@@ -42,7 +42,7 @@ config CRYPTO_DEV_HISI_SEC2
 config CRYPTO_DEV_HISI_QM
 	tristate
 	depends on ARM64 || COMPILE_TEST
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	depends on UACCE || UACCE=n
 	depends on ACPI
 	help
@@ -51,7 +51,7 @@ config CRYPTO_DEV_HISI_QM
 
 config CRYPTO_DEV_HISI_ZIP
 	tristate "Support for HiSilicon ZIP accelerator"
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	depends on !CPU_BIG_ENDIAN || COMPILE_TEST
 	depends on UACCE || UACCE=n
@@ -62,7 +62,7 @@ config CRYPTO_DEV_HISI_ZIP
 
 config CRYPTO_DEV_HISI_HPRE
 	tristate "Support for HISI HPRE accelerator"
-	depends on PCI && PCI_MSI
+	depends on PCI_MSI
 	depends on UACCE || UACCE=n
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	depends on ACPI
-- 
2.17.1

