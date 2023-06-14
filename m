Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3497730624
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbjFNRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjFNRid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:38:33 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416EF10FE;
        Wed, 14 Jun 2023 10:38:32 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77a62a84855so273308139f.1;
        Wed, 14 Jun 2023 10:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686764311; x=1689356311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AzIfgp2T+o1encwZlg2BP9N2PGCvG8KAxb0WUXTbaA=;
        b=WsaDMIrpnSLwIqqldn34MWu2sKw3HindMBvKSXpBROS/Q7ZdF29tfkcMXzh5LiJV3H
         Z8Sihnu5vkJuwegr9BO4WcCh6Zzd2p7rhdO3JTtDKUEj2EQbSbxoVX4ksYeDuYCUs/JO
         SOj+TUukxh8tv6VYr4opnW7YR3DRTj8ZAPUMy2Mkyuag+8HbM6mHbFaYjxVw3hOGNJXq
         xRvvnvqz9ekWc5uw0K9YiS279Pt7M7mhO+kPanBU4SLe1EpaiUIHG46FPWWb0Qm77c+y
         iY9oxKZxvrBWKy3Zi7+uW/awMZG4M9SKSAbP1qZCaG4dEXp1+0rdtVD+ZscREXmarrRe
         P48w==
X-Gm-Message-State: AC+VfDxR+u1kOEyYajaNviVWAtWvB1KjCG7anS52RuMxCdDIU8ljgmAW
        TYCLBjrGkr6q+L3ObLmxAEUxpvIVFg==
X-Google-Smtp-Source: ACHHUZ4+zkUe4iA37124C8HV/+nPoXe1InO+Fi+eyYwXZkiDrm2NeUOpaRk5ZdFyrjJz8LtEtGs6Cg==
X-Received: by 2002:a05:6e02:684:b0:33b:ef57:65bc with SMTP id o4-20020a056e02068400b0033bef5765bcmr13558330ils.20.1686764311406;
        Wed, 14 Jun 2023 10:38:31 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p20-20020a02c814000000b004165ce4456fsm5009151jao.33.2023.06.14.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 10:38:30 -0700 (PDT)
Received: (nullmailer pid 2433146 invoked by uid 1000);
        Wed, 14 Jun 2023 17:38:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ata: octeon: Add compile test support
Date:   Wed, 14 Jun 2023 11:36:33 -0600
Message-Id: <20230614173633.2430653-2-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614173633.2430653-1-robh@kernel.org>
References: <20230614173633.2430653-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
so other arches can't be enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Tested on allmodconfig build. Not sure if there's other MIPS configs 
where this doesn't work. We'll see what 0-day says.

 drivers/ata/Kconfig          | 4 ++--
 drivers/ata/pata_octeon_cf.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 42b51c9812a0..4572f837e504 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -239,7 +239,7 @@ config AHCI_MVEBU
 
 config AHCI_OCTEON
 	tristate "Cavium Octeon Soc Serial ATA"
-	depends on SATA_AHCI_PLATFORM && CAVIUM_OCTEON_SOC
+	depends on SATA_AHCI_PLATFORM && MIPS && (CAVIUM_OCTEON_SOC || COMPILE_TEST)
 	default y
 	help
 	  This option enables support for Cavium Octeon SoC Serial ATA.
@@ -373,7 +373,7 @@ config PDC_ADMA
 
 config PATA_OCTEON_CF
 	tristate "OCTEON Boot Bus Compact Flash support"
-	depends on CAVIUM_OCTEON_SOC
+	depends on MIPS && (CAVIUM_OCTEON_SOC || COMPILE_TEST)
 	select PATA_TIMINGS
 	help
 	  This option enables a polled compact flash driver for use with
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 57b2166a6d5d..cc9e4b63ded9 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -853,8 +853,8 @@ static int octeon_cf_probe(struct platform_device *pdev)
 					of_node_put(dma_node);
 					return -EINVAL;
 				}
-				cf_port->dma_base = (u64)devm_ioremap(&pdev->dev, res_dma->start,
-									 resource_size(res_dma));
+				cf_port->dma_base = (uintptr_t)devm_ioremap(&pdev->dev, res_dma->start,
+									    resource_size(res_dma));
 				if (!cf_port->dma_base) {
 					put_device(&dma_dev->dev);
 					of_node_put(dma_node);
-- 
2.39.2

