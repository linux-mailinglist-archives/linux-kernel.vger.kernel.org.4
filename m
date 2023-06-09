Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C103372A4BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjFIU1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFIU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:27:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B4030DA;
        Fri,  9 Jun 2023 13:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD754601B6;
        Fri,  9 Jun 2023 20:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F83EC433EF;
        Fri,  9 Jun 2023 20:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686342448;
        bh=PdbedDvox8kN3leTnxV87vPVVyrcnnOYnxEDtJT/Fho=;
        h=From:To:Cc:Subject:Date:From;
        b=OueAIQgcxFawvBu+Oku/M31hrN6iro1b/BTfAV/4SoxrvOAxIku6lrtPK0KMtsL60
         xqMj1njKgkS6ddgM00CFkqb2wb581jBMFYwGgEsFUID78Vl3IHlII5SSJATZTzRmAx
         lv7URfhzaixd1bVMTtul8QNn39DkPKA1mgL2adNYdcNm92vULjE6jFFgP7Quc+E3xu
         uj6eNaJ1+YXNpatzyaZC/kw/HBsZwwwb6ZeSsJ8lW6awmzG50BfdpxYgQqNcmPQGgQ
         zHBhYCuYhHuqaR2y5lOCkxWm2GPIfsjIF/dXj7qDj2BfO4yYk/YG/cqdjQ4ZDPccRR
         w7pofeel7H/AA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luca Ellero <l.ellero@asem.it>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ads7846 - fix pointer cast warning
Date:   Fri,  9 Jun 2023 22:27:16 +0200
Message-Id: <20230609202722.3634721-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The previous bugfix caused a warning on 64-bit builds:

drivers/input/touchscreen/ads7846.c:1126:17: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'const void *' [-Wvoid-pointer-to-int-cast]

Change the cast back to something that works on both 32-bit and 64-bit
kernels.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306100442.jStknDT1-lkp@intel.com/
Fixes: 8f7913c04f6a7 ("Input: ads7846 - Fix usage of match data")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I got the report and applied this locally to fix it quickly

 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index fe6fe8acd8a66..faea40dd66d01 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1123,7 +1123,7 @@ static const struct ads7846_platform_data *ads7846_get_props(struct device *dev)
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
-	pdata->model = (u32)device_get_match_data(dev);
+	pdata->model = (uintptr_t)device_get_match_data(dev);
 
 	device_property_read_u16(dev, "ti,vref-delay-usecs",
 				 &pdata->vref_delay_usecs);
-- 
2.39.2

