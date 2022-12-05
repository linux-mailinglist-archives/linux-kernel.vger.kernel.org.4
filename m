Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9866421D0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiLEDIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiLEDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:08:15 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A22DF16;
        Sun,  4 Dec 2022 19:08:13 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NQT580lyRz4y0vD;
        Mon,  5 Dec 2022 11:08:12 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B537vaY062780;
        Mon, 5 Dec 2022 11:07:57 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Mon, 5 Dec 2022 11:07:58 +0800 (CST)
Date:   Mon, 5 Dec 2022 11:07:58 +0800 (CST)
X-Zmail-TransId: 2af9638d608e4207d100
X-Mailer: Zmail v1.0
Message-ID: <202212051107581630594@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <sre@kernel.org>
Cc:     <linus.walleij@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHBvd2VyOiBzdXBwbHk6IHVzZSBzeXNmc19lbWl0KCkgdG8gaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B537vaY062780
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638D609C.000 by FangMail milter!
X-FangMail-Envelope: 1670209692/4NQT580lyRz4y0vD/638D609C.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638D609C.000/4NQT580lyRz4y0vD
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/power/supply/ab8500_fg.c        | 18 +++++++++---------
 drivers/power/supply/bq24190_charger.c  |  2 +-
 drivers/power/supply/bq24257_charger.c  |  8 +++-----
 drivers/power/supply/lp8788-charger.c   |  7 +++----
 drivers/power/supply/max14577_charger.c |  2 +-
 drivers/power/supply/max77693_charger.c |  6 +++---
 6 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c6c9804280db..d989eadaa933 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2594,7 +2594,7 @@ static ssize_t ab8505_powercut_flagtime_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
+	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));

 fail:
 	return ret;
@@ -2644,7 +2644,7 @@ static ssize_t ab8505_powercut_maxtime_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
+	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));

 fail:
 	return ret;
@@ -2695,7 +2695,7 @@ static ssize_t ab8505_powercut_restart_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0xF));
+	return sysfs_emit(buf, "%d\n", (reg_value & 0xF));

 fail:
 	return ret;
@@ -2746,7 +2746,7 @@ static ssize_t ab8505_powercut_timer_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
+	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));

 fail:
 	return ret;
@@ -2769,7 +2769,7 @@ static ssize_t ab8505_powercut_restart_counter_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0xF0) >> 4);
+	return sysfs_emit(buf, "%d\n", (reg_value & 0xF0) >> 4);

 fail:
 	return ret;
@@ -2790,7 +2790,7 @@ static ssize_t ab8505_powercut_read(struct device *dev,
 	if (ret < 0)
 		goto fail;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x1));
+	return sysfs_emit(buf, "%d\n", (reg_value & 0x1));

 fail:
 	return ret;
@@ -2841,7 +2841,7 @@ static ssize_t ab8505_powercut_flag_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", ((reg_value & 0x10) >> 4));
+	return sysfs_emit(buf, "%d\n", ((reg_value & 0x10) >> 4));

 fail:
 	return ret;
@@ -2864,7 +2864,7 @@ static ssize_t ab8505_powercut_debounce_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7));
+	return sysfs_emit(buf, "%d\n", (reg_value & 0x7));

 fail:
 	return ret;
@@ -2914,7 +2914,7 @@ static ssize_t ab8505_powercut_enable_status_read(struct device *dev,
 		goto fail;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%d\n", ((reg_value & 0x20) >> 5));
+	return sysfs_emit(buf, "%d\n", ((reg_value & 0x20) >> 5));

 fail:
 	return ret;
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 2b2c3a4391c1..be34b9848450 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -463,7 +463,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
 	if (ret)
 		count = ret;
 	else
-		count = scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
+		count = sysfs_emit(buf, "%hhx\n", v);

 	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index ab4c49788c58..103ddc2b3def 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -767,8 +767,7 @@ static ssize_t bq24257_show_ovp_voltage(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct bq24257_device *bq = power_supply_get_drvdata(psy);

-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 bq24257_vovp_map[bq->init_data.vovp]);
+	return sysfs_emit(buf, "%u\n", bq24257_vovp_map[bq->init_data.vovp]);
 }

 static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
@@ -778,8 +777,7 @@ static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct bq24257_device *bq = power_supply_get_drvdata(psy);

-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 bq24257_vindpm_map[bq->init_data.vindpm]);
+	return sysfs_emit(buf, "%u\n", bq24257_vindpm_map[bq->init_data.vindpm]);
 }

 static ssize_t bq24257_sysfs_show_enable(struct device *dev,
@@ -800,7 +798,7 @@ static ssize_t bq24257_sysfs_show_enable(struct device *dev,
 	if (ret < 0)
 		return ret;

-	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }

 static ssize_t bq24257_sysfs_set_enable(struct device *dev,
diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply/lp8788-charger.c
index f5f47a0aa1e3..755b6a4379b8 100644
--- a/drivers/power/supply/lp8788-charger.c
+++ b/drivers/power/supply/lp8788-charger.c
@@ -602,7 +602,7 @@ static ssize_t lp8788_show_charger_status(struct device *dev,
 	lp8788_read_byte(pchg->lp, LP8788_CHG_STATUS, &data);
 	state = (data & LP8788_CHG_STATE_M) >> LP8788_CHG_STATE_S;

-	return scnprintf(buf, PAGE_SIZE, "%s\n", desc[state]);
+	return sysfs_emit(buf, "%s\n", desc[state]);
 }

 static ssize_t lp8788_show_eoc_time(struct device *dev,
@@ -618,8 +618,7 @@ static ssize_t lp8788_show_eoc_time(struct device *dev,
 	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
 	val = (val & LP8788_CHG_EOC_TIME_M) >> LP8788_CHG_EOC_TIME_S;

-	return scnprintf(buf, PAGE_SIZE, "End Of Charge Time: %s\n",
-			stime[val]);
+	return sysfs_emit(buf, "End Of Charge Time: %s\n", stime[val]);
 }

 static ssize_t lp8788_show_eoc_level(struct device *dev,
@@ -642,7 +641,7 @@ static ssize_t lp8788_show_eoc_level(struct device *dev,
 	val = (val & LP8788_CHG_EOC_LEVEL_M) >> LP8788_CHG_EOC_LEVEL_S;
 	level = mode ? abs_level[val] : relative_level[val];

-	return scnprintf(buf, PAGE_SIZE, "End Of Charge Level: %s\n", level);
+	return sysfs_emit(buf, "End Of Charge Level: %s\n", level);
 }

 static DEVICE_ATTR(charger_status, S_IRUSR, lp8788_show_charger_status, NULL);
diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index f244cd902eb9..96f9de775043 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -532,7 +532,7 @@ static ssize_t show_fast_charge_timer(struct device *dev,
 		break;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static ssize_t store_fast_charge_timer(struct device *dev,
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index a2c5c9858639..794c8c054450 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -296,7 +296,7 @@ static ssize_t fast_charge_timer_show(struct device *dev,
 		break;
 	}

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static int max77693_set_fast_charge_timer(struct max77693_charger *chg,
@@ -357,7 +357,7 @@ static ssize_t top_off_threshold_current_show(struct device *dev,
 	else
 		val = data * 50000;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static int max77693_set_top_off_threshold_current(struct max77693_charger *chg,
@@ -405,7 +405,7 @@ static ssize_t top_off_timer_show(struct device *dev,

 	val = data * 10;

-	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
+	return sysfs_emit(buf, "%u\n", val);
 }

 static int max77693_set_top_off_timer(struct max77693_charger *chg,
-- 
2.25.1
