Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234C62C172
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiKPOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiKPOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:52:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675DA391C2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:51:21 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l14so30314712wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypWNmDEaWeWuRqCSCZcnZ4g+Xufg4hTPZzYQMsRk2nI=;
        b=XeISWKV7SOhRGH6DdiHyRtBpcYRw12w5Zb0poKvYNnWIAcKT4QCbYKg0NsWkgkXanZ
         X3lbc9IRd7k60blzUhARtZVmxepqdrY2x9cpIOoDD8oeIRGGatG0+WY8YABtOwFCwXRX
         54FQiMBL4L/ms9KK0jtz5KiBg+JYq71XEKtSitgPwNrTX/ovut2IMeax49lyY0+yCQyO
         DkhNPGRlB+JzM9lsWHCUbXBpgSoOYmBvH+t+oTzHBsh8rgvBE9Jo9xbSSyZl8RRQzWRG
         comfhFeuuIwnC3dMyvY9FDxNtBkyzipxJrt06BEvvZnGaTHYZvsGwnKKgVTXRpWPRyiD
         0bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ypWNmDEaWeWuRqCSCZcnZ4g+Xufg4hTPZzYQMsRk2nI=;
        b=SMxuo7nDOPW2PpiSF5fgBT05VKwLMw7otG+O1V/YfWjmxhaL7RSOorXyUnz2niaDQp
         fx6TnfHUJGB1LOq3Vnq+xAshOrd6CETpv4vKxMoXdyQHEIgTFadoOuuGy15Maw3S8a9V
         uo7X/iQkG2+R2lXiFIYAUCgWHIOXeTxrA4T81SfLwd6YadWJtzxjLPFhw5RVaL1rPzzS
         h7M/CoBoG5A/LL+pHuIcPoVwZ984caJ8CzdAQUuh5PWzZtL6hqmnVLdSIqWWVH+PJMJQ
         6Gqx5W8R7Pl1llvUmJcXY7as3Rb7mEP4e3mjFdRaOYNnF9v/tuaVg5QZahitbsxfB6b5
         m+1g==
X-Gm-Message-State: ANoB5pn6i7+B5bSe5iikAP/PMfHyRBL+liQJKe/tESvynTP4IaMbMY6W
        ocoUdtWR5X15ZQRcXPl7G6mHzAndfwAJbg==
X-Google-Smtp-Source: AA0mqf5SxnDweVseR96Q9F3uj9J0fncsPkHDbQBVgv5tGAxpGPxpATuIBA7c+ptsc30GEwTaSjyZag==
X-Received: by 2002:a5d:61cf:0:b0:236:6fd9:9efa with SMTP id q15-20020a5d61cf000000b002366fd99efamr13384850wrv.101.1668610279923;
        Wed, 16 Nov 2022 06:51:19 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:3f99:5293:49fd:9c5b])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003cfa3a12660sm8641789wms.1.2022.11.16.06.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:51:19 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v5 0/2] soc: ti: Add module build support to the k3 socinfo driver
Date:   Wed, 16 Nov 2022 15:51:01 +0100
Message-Id: <20221116145103.26744-1-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the TI K3 SoC info driver to be built as a module, the
following changes have been made:
- Converted memory allocations to devm and added the remove callback
- Added necessary code to build the driver as a module

v2->v3:
dropped module conversion part of this series while other driver
dependencies on socinfo are worked out.
A dependency issue is introduced by changing subsys_initcall()
to module_platform_driver(). Some drivers using the socinfo information
probe before the socinfo driver itself and it makes their probe fail.

v3->v4:
reintegrated the module build support and added patches for udma and mdio
drivers to allow for deferred probe if socinfo hasn't probed yet.

v4->v5:
Remove the k3 udma and mdio patches from this series and sent them
individually

Nicolas Frayer (2):
  soc: ti: Convert allocations to devm
  soc: ti: Add module build support

 arch/arm64/Kconfig.platforms |  1 -
 drivers/soc/ti/Kconfig       |  3 ++-
 drivers/soc/ti/k3-socinfo.c  | 47 +++++++++++++++++++++++-------------
 3 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.25.1

