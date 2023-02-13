Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826C5693DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBMFRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMFRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:17:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF16A5E6;
        Sun, 12 Feb 2023 21:17:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D190260EA5;
        Mon, 13 Feb 2023 05:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3192C433EF;
        Mon, 13 Feb 2023 05:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676265430;
        bh=C35ZgTNa7NZq55JXZvoSKUzjj0qD+wPirGH0nmgNqkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oB3ohZoWH6olf6B1ox51EvqwJ7/PpPuHaa67aaALXFRGk1lt7DsjVlgCudlBxMl6z
         4eswtnKcKSYe4NOPPWZFhNoBj0zpVnd3wPzvK9W9MxHeSv2TwL68NB9GnGLe1k9DBD
         RgGR2uxePXwH4uuww5b6oysXKn928RHkuvwyoJbSUJk70Vo6ASqFZn+Fhw8hmWZLMz
         5smWggEeZ0X1Fbe6XjdjZSpcm3N9tb6IQTpaLnpCsmeDZMQyXk/T/ewUCIc3J6c0Aq
         Cgwv7QdwEGw0ftVmtzwDYewnDNAG4EHe7/yHWn+prYt/Oh+glvC8nCB14RkIk+wf0z
         udlJ2Ltq8iXgw==
Date:   Mon, 13 Feb 2023 10:47:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Linux Phy <linux-phy@lists.infradead.org>
Subject: Re: linux-next: build failure after merge of the phy-next tree
Message-ID: <Y+nH0enRX0OO4UtQ@matsya>
References: <20230213135521.6ebc410b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213135521.6ebc410b@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-23, 13:55, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the phy-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/phy/qualcomm/phy-qcom-snps-eusb2.c: In function 'qcom_snps_eusb2_hsphy_write_mask':
> drivers/phy/qualcomm/phy-qcom-snps-eusb2.c:147:15: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
>   147 |         reg = readl_relaxed(base + offset);
>       |               ^~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-snps-eusb2.c:150:9: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
>   150 |         writel_relaxed(reg, base + offset);
>       |         ^~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-snps-eusb2.c: In function 'qcom_eusb2_default_parameters':
> drivers/phy/qualcomm/phy-qcom-snps-eusb2.c:161:42: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
>   161 |                                          FIELD_PREP(PHY_CFG_TX_PREEMP_TUNE_MASK, 0));
>       |                                          ^~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   80090810f5d3 ("phy: qcom: Add QCOM SNPS eUSB2 driver")

Thanks Stephen for the report, I have fixed it up by adding the missing
headers:

-- >8 --

From: Vinod Koul <vkoul@kernel.org>
Date: Mon, 13 Feb 2023 10:39:26 +0530
Subject: [PATCH] phy: qcom: snps-eusb2: Add missing headers

The driver was missing to include couple of headers explictly which
causes build to fail on other archs

Fix this by adding bitfield.h and iopoll.h explictly

Fixes: 80090810f5d3 ("phy: qcom: Add QCOM SNPS eUSB2 driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
index 40a421cf3dd9..64e835b7ef53 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
@@ -3,8 +3,10 @@
  * Copyright (c) 2023, Linaro Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
-- 
2.39.0

-- 
~Vinod
