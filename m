Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745E773CD9F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 03:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFYBFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFYBFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 21:05:54 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC6110E9
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 18:05:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VlqM4JC_1687655148;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VlqM4JC_1687655148)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 09:05:49 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ASoC: tas2781: No need to set device_driver owner
Date:   Sun, 25 Jun 2023 09:05:47 +0800
Message-Id: <20230625010547.7353-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove .owner field if calls are used which set it automatically.

to silence the warning:
./sound/soc/codecs/tas2781-i2c.c:746:3-8: No need to set .owner here.  The core will do it.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5589
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/tas2781-i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 4c59429a42b7..55cd5e3c23a5 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -743,7 +743,6 @@ MODULE_DEVICE_TABLE(acpi, tasdevice_acpi_match);
 static struct i2c_driver tasdevice_i2c_driver = {
 	.driver = {
 		.name = "tas2781-codec",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(tasdevice_of_match),
 #ifdef CONFIG_ACPI
 		.acpi_match_table = ACPI_PTR(tasdevice_acpi_match),
-- 
2.20.1.7.g153144c

