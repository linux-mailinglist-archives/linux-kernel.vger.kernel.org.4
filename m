Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841AA66E3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjAQQp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjAQQpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:45:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14E12844;
        Tue, 17 Jan 2023 08:45:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE8FAB81912;
        Tue, 17 Jan 2023 16:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16761C433F0;
        Tue, 17 Jan 2023 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673973943;
        bh=1IWjxsYC2i9SE5mqZ6V2NsIEjkQYLC+eGmlQwfHJm8o=;
        h=From:To:Cc:Subject:Date:From;
        b=tZfehrK5DYMJiaHeNzSfw3EmMD5tZBCc0Tk+yr8EvLlSk6t6d0urIIEO7Zbk00UHM
         mnmFrsyxwXgdbu/bDLLh3uwzId5RA/oVqKtscvX1iz8cLp89+HK9LgO81HW2wKw7zO
         yzq802015UgMDl25c/1xbVeaXK0IO7j2aWoslTiT8YiAlzZdfnuZ1PFW21NmDPK5+H
         h5tJoLwRAZYdv6ie7sPlWwJSnMrVBWvd+xGSg7D8WxbQgzbOQebAg0gb9VLMqneeFd
         8mefG57ilOMP03QxUDO7XUUxz41P0AMcrTfniflp5uXIqnkd0HviG3/+TSUVBe67p6
         6LL6/7Ai9joiw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ipaq-micro-ts - fix DEFINE_SIMPLE_DEV_PM_OPS typo
Date:   Tue, 17 Jan 2023 17:45:33 +0100
Message-Id: <20230117164539.1631336-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The previous change was not properly build tested and needs
a trivial spelling change:

ipaq-micro-ts.c:146:8: error: type defaults to 'int' in declaration of 'DEFINE_SIMPLE_DEV_PM' [-Werror=implicit-int]

Fixes: 144ff5e03d74 ("Input: ipaq-micro-ts - use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/ipaq-micro-ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ipaq-micro-ts.c b/drivers/input/touchscreen/ipaq-micro-ts.c
index d8e25b502968..94720c41c9be 100644
--- a/drivers/input/touchscreen/ipaq-micro-ts.c
+++ b/drivers/input/touchscreen/ipaq-micro-ts.c
@@ -143,8 +143,8 @@ static int micro_ts_resume(struct device *dev)
 	return 0;
 }
 
-static DEFINE_SIMPLE_DEV_PM(micro_ts_dev_pm_ops,
-			    micro_ts_suspend, micro_ts_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(micro_ts_dev_pm_ops,
+				micro_ts_suspend, micro_ts_resume);
 
 static struct platform_driver micro_ts_device_driver = {
 	.driver	= {
-- 
2.39.0

