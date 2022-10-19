Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0D3603C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiJSIp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiJSIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:44:22 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165D89967;
        Wed, 19 Oct 2022 01:43:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSZvGwx_1666168846;
Received: from localhost(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VSZvGwx_1666168846)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 16:40:47 +0800
From:   'Guanjun' <guanjun@linux.alibaba.com>
To:     schspa@gmail.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        guanjun@linux.alibaba.com, zelin.deng@linux.alibaba.com
Subject: [PATCH 1/1] cpufreq: Fix show()/store() issue for hotplugging offline CPU
Date:   Wed, 19 Oct 2022 16:40:45 +0800
Message-Id: <1666168845-67690-2-git-send-email-guanjun@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1666168845-67690-1-git-send-email-guanjun@linux.alibaba.com>
References: <1666168845-67690-1-git-send-email-guanjun@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zelin Deng <zelin.deng@linux.alibaba.com>

After brought one CPU offline, lscpu returned failure:

lscpu: cannot read /sys/devices/system/cpu/cpu64/cpufreq/cpuinfo_max_freq: Device or resource busy

which had blocked all outputs of lscpu.

This is not the case mentioned in commit d4627a287e251, as the policy
had been created successfully but is inactive due to CPU gets offline.
To fix this issue, just add an addtional check whether CPU is online or
not.

Fixes: d4627a287e251 ("cpufreq: Abort show()/store() for half-initialized policies")
Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
---
 drivers/cpufreq/cpufreq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 69b3d61852ac..aa238ba7d2fe 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -956,8 +956,12 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 		return -EIO;
 
 	down_read(&policy->rwsem);
-	if (likely(!policy_is_inactive(policy)))
-		ret = fattr->show(policy, buf);
+	if (unlikely(policy_is_inactive(policy) && cpu_online(policy->cpu)))
+		goto err;
+
+	ret = fattr->show(policy, buf);
+
+err:
 	up_read(&policy->rwsem);
 
 	return ret;
@@ -974,8 +978,12 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 		return -EIO;
 
 	down_write(&policy->rwsem);
-	if (likely(!policy_is_inactive(policy)))
-		ret = fattr->store(policy, buf, count);
+	if (unlikely(policy_is_inactive(policy) && cpu_online(policy->cpu)))
+		goto err;
+
+	ret = fattr->store(policy, buf, count);
+
+err:
 	up_write(&policy->rwsem);
 
 	return ret;
-- 
2.32.0.GIT

