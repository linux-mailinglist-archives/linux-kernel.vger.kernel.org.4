Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50912600BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbiJQKD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiJQKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:03:17 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68105E662
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:03:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g28so10607017pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UaAzKyNq9nnRse/+cCAjXKMYZQLGLVwCydbfKuvY54=;
        b=VrvnK+3ZAIN1ufgfpHItfJNANC6LgdnWBLQHxtEuLb3d/QY/jQsOlmkAnaHrqZQFdp
         T01CIpbq34QT1DYa9+H26ykD1hvXuToNZiWwhoPn2R6uffGCuCmxeNNQ2NieeJeTgFnG
         W9J6HeuQjI8eLQFBZ5S+JewdaeEBnrIi4Fh7B4G3eOgSVp1bnWq5656oMR6gfXKTJ7+U
         eaBGZMoQbTPvfFTvLQWaP0RxBrfZ5W0Gjv0kdgGa7iC+3Lav++wgaHN0qYbzvrpLz1Os
         3vfvzVbfLwsg5qiZh50Mo3cG9qL6MtaFFTctAoq16PlUNgVnDw2e/QvnTSMnvefhwYsn
         R7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UaAzKyNq9nnRse/+cCAjXKMYZQLGLVwCydbfKuvY54=;
        b=Hr10H+a8Xkl/YuVjioAHfuULnyhj9qnfZDBPV+Ir713fksfokM417tufuyOBriZKu/
         sNr6kPxtfBNnaM0UGL36qAy8gwEyDQaxRl+918dtHgbrDcdHPL6WPn2uMvyW4v2yv8Rx
         8nZXF5GTOsMQvm4xPFahyH9WAFDfLtQrjMJDu6WXeCYm4z7m2eO5TCZIdQXTLRVRjAKX
         5VQGneepFs4CBnLMilTKyKGoYI2SRbxaY+yMQa9MOxXzD669AHoXtwh/4YmGwb9IMol9
         pcqHMBmPjC+mUOqv5yxTRLVohOoWggDdsiJf1QaI/a9pNKLU2zaDxyI0Zv6R/O7fqSjA
         XPHQ==
X-Gm-Message-State: ACrzQf1SUJ5MdZ91GxqggjC4dPOR4G418xYqV7vSU6fsGshlrKcSDxgN
        R5QTI1DkqsH0DuCxo7eiaFXnukspkvunDw==
X-Google-Smtp-Source: AMsMyM6qZa2HnPhyKKOx8pZXzS74QOIoLa7aYXY+beudzq7U2papGMTBBB3rJGRMsd+XaW/aDQBZ/Q==
X-Received: by 2002:a05:6a00:15c2:b0:565:bc96:1c75 with SMTP id o2-20020a056a0015c200b00565bc961c75mr11715950pfu.23.1666000995277;
        Mon, 17 Oct 2022 03:03:15 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id i18-20020a056a00005200b00561b02e3118sm6662744pfk.106.2022.10.17.03.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:03:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: sysfs: Reuse cdev->max_state
Date:   Mon, 17 Oct 2022 15:33:02 +0530
Message-Id: <56d3dcfd92206eea6164ed26e40ae307c5c5219d.1666000867.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1666000867.git.viresh.kumar@linaro.org>
References: <cover.1666000867.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the cooling device structure stores the max_state value, reuse
it and drop max_states from struct cooling_dev_stats.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index bd7596125461..febf9e76c440 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -661,7 +661,6 @@ struct cooling_dev_stats {
 	spinlock_t lock;
 	unsigned int total_trans;
 	unsigned long state;
-	unsigned long max_states;
 	ktime_t last_time;
 	ktime_t *time_in_state;
 	unsigned int *trans_table;
@@ -691,7 +690,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 		goto unlock;
 
 	update_time_in_state(stats);
-	stats->trans_table[stats->state * stats->max_states + new_state]++;
+	stats->trans_table[stats->state * (cdev->max_state + 1) + new_state]++;
 	stats->state = new_state;
 	stats->total_trans++;
 
@@ -725,7 +724,7 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
 	spin_lock(&stats->lock);
 	update_time_in_state(stats);
 
-	for (i = 0; i < stats->max_states; i++) {
+	for (i = 0; i <= cdev->max_state; i++) {
 		len += sprintf(buf + len, "state%u\t%llu\n", i,
 			       ktime_to_ms(stats->time_in_state[i]));
 	}
@@ -740,7 +739,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats = cdev->stats;
-	int i, states = stats->max_states;
+	int i, states = cdev->max_state + 1;
 
 	spin_lock(&stats->lock);
 
@@ -749,7 +748,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	memset(stats->trans_table, 0,
 	       states * states * sizeof(*stats->trans_table));
 
-	for (i = 0; i < stats->max_states; i++)
+	for (i = 0; i < states; i++)
 		stats->time_in_state[i] = ktime_set(0, 0);
 
 	spin_unlock(&stats->lock);
@@ -767,7 +766,7 @@ static ssize_t trans_table_show(struct device *dev,
 
 	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
-	for (i = 0; i < stats->max_states; i++) {
+	for (i = 0; i <= cdev->max_state; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
@@ -777,17 +776,17 @@ static ssize_t trans_table_show(struct device *dev,
 
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
-	for (i = 0; i < stats->max_states; i++) {
+	for (i = 0; i <= cdev->max_state; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 
 		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
 
-		for (j = 0; j < stats->max_states; j++) {
+		for (j = 0; j <= cdev->max_state; j++) {
 			if (len >= PAGE_SIZE)
 				break;
 			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
-				stats->trans_table[i * stats->max_states + j]);
+				stats->trans_table[i * (cdev->max_state + 1) + j]);
 		}
 		if (len >= PAGE_SIZE)
 			break;
@@ -823,14 +822,10 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 {
 	const struct attribute_group *stats_attr_group = NULL;
 	struct cooling_dev_stats *stats;
-	unsigned long states;
+	/* Total number of states is highest state + 1 */
+	unsigned long states = cdev->max_state + 1;
 	int var;
 
-	if (cdev->ops->get_max_state(cdev, &states))
-		goto out;
-
-	states++; /* Total number of states is highest state + 1 */
-
 	var = sizeof(*stats);
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
@@ -843,7 +838,6 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
 	cdev->stats = stats;
 	stats->last_time = ktime_get();
-	stats->max_states = states;
 
 	spin_lock_init(&stats->lock);
 
-- 
2.31.1.272.g89b43f80a514

