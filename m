Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A0171F4C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjFAVcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B00A195;
        Thu,  1 Jun 2023 14:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D490E649ED;
        Thu,  1 Jun 2023 21:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA003C433D2;
        Thu,  1 Jun 2023 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655141;
        bh=ZayG3JtKeRHBP3Of0x1sbbjcfUFrfkdCXWyh5YaG/eA=;
        h=From:To:Cc:Subject:Date:From;
        b=dHow6iXjWYevbjQ3KEQ4bE5SmRC4qESv9PCCRjo3MZazJoiwBgDufOlI8fwXvn4Z4
         HnEaxdRrvyT0N6smSTH5kxL5aL/LGmFLFe1o+h5Lf/e2G2ODOGil3HVkd1D7E8nKAQ
         /ssQPVfNTow/IiKVw2Mf7WGvL+AfPDov641uyqeMp4wtldDMjyjyKd9guZMJnWx2P4
         jnL/lxvF5fn6Vz+1q5CxgX5+fJR+RHmfZkDRn43jY6+oTX+I3Cz323F6j9ynG3RAwq
         i2OSIkJdTkGYrKgTGWzaAzOcr+ztFZTiZmBeJ2cKh+6karepdZqx9jpzAfCkwgWXIe
         sz9CnHZ8g6Z7Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: hp-wmi-sensors: fix debugfs check
Date:   Thu,  1 Jun 2023 23:31:54 +0200
Message-Id: <20230601213216.3220550-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Checking for Kconfig symbols with #if is wrong:

drivers/hwmon/hp-wmi-sensors.c:1141:5: error: "CONFIG_DEBUG_FS" is not defined, evaluates to 0 [-Werror=undef]

This could be an #ifdef, but an IS_ENABLED() check is even better to
give the best compile coverage.

Fixes: 602bef0fa281f ("hwmon: add HP WMI Sensors driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/hp-wmi-sensors.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/hp-wmi-sensors.c b/drivers/hwmon/hp-wmi-sensors.c
index 7218945bd03fc..ebe2fb5134805 100644
--- a/drivers/hwmon/hp-wmi-sensors.c
+++ b/drivers/hwmon/hp-wmi-sensors.c
@@ -1138,8 +1138,6 @@ static int hp_wmi_update_info(struct hp_wmi_sensors *state,
 	return ret;
 }
 
-#if CONFIG_DEBUG_FS
-
 static int basic_string_show(struct seq_file *seqf, void *ignored)
 {
 	const char *str = seqf->private;
@@ -1341,16 +1339,6 @@ static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
 	}
 }
 
-#else
-
-static void hp_wmi_debugfs_init(struct device *dev, struct hp_wmi_info *info,
-				struct hp_wmi_platform_events *pevents,
-				u8 icount, u8 pcount, bool is_new)
-{
-}
-
-#endif
-
 static umode_t hp_wmi_hwmon_is_visible(const void *drvdata,
 				       enum hwmon_sensor_types type,
 				       u32 attr, int channel)
@@ -1959,7 +1947,8 @@ static int hp_wmi_sensors_init(struct hp_wmi_sensors *state)
 	if (err)
 		return err;
 
-	hp_wmi_debugfs_init(dev, info, pevents, icount, pcount, is_new);
+	if (IS_ENABLED(CONFIG_DEBUG_FS))
+		hp_wmi_debugfs_init(dev, info, pevents, icount, pcount, is_new);
 
 	if (!count)
 		return 0;	/* No connected sensors; debugfs only. */
-- 
2.39.2

