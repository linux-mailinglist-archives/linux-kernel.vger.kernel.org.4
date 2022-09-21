Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFC5BF89F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIUIJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIUII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:08:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1B80EA3;
        Wed, 21 Sep 2022 01:08:58 -0700 (PDT)
Date:   Wed, 21 Sep 2022 08:08:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663747737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zPza9GfvfCzuDa1HTfIXTm9tWsA3CcYZ82dbV7tKWcg=;
        b=1NJ1AVQcZNVQd2+Kk+92P/AiFXqq+LfXiCbDgRU6xRDygNhy0Tvl4l54e++P6Glg+ba6W1
        FMb8qklPaWXLtTm1+GXbpqJlwok3/mpuAKjcgw+Z/JmqtJniVwLF2l7G+cHNNptoqgboiR
        ghpRcpDJjPAV51ILeQbaS3onVtTSVvyAt5Yd9FTXEHa+SU5IeouP00e7cNoeLfQWIcJ+Ma
        fUDpa7DoSMLkl/tOaYuebywuU3Z6xfqIBc7Tu1kQiTSh9fkTsjrEdH0gYNbnrahtQbaTa+
        TMCnTbOY+jl71AiYmnlWOiAtMI0opGtG7A7ss85mDd04nndqyrI+AcMNGgi8dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663747737;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zPza9GfvfCzuDa1HTfIXTm9tWsA3CcYZ82dbV7tKWcg=;
        b=2whLIOsFLsxkUsWwJIR6CzYh1mid1NLsDhBofl1QBizqs/+tH5/L8z/DZyGsH9ZQC46Qi6
        zYfLoUSyMHDhkLDw==
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Convert snprintf() to scnprintf()
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166374773592.401.16831946846027095231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     678739d622ae7b75b62d550858b6bf104c43e2df
Gitweb:        https://git.kernel.org/tip/678739d622ae7b75b62d550858b6bf104c43e2df
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Sun, 18 Sep 2022 00:41:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 21 Sep 2022 10:01:20 +02:00

perf/core: Convert snprintf() to scnprintf()

Coccinelle reports a warning:

    WARNING: use scnprintf or sprintf

Adding to that, there has also been some slow migration from snprintf to scnprintf.

This LWN article explains the rationale for this change:

    https: //lwn.net/Articles/69419/

No change in behavior.

[ mingo: Improved the changelog. ]

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7da5515..c07e9a3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10952,7 +10952,7 @@ static ssize_t nr_addr_filters_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->nr_addr_filters);
 }
 DEVICE_ATTR_RO(nr_addr_filters);
 
@@ -10963,7 +10963,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *page)
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->type);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->type);
 }
 static DEVICE_ATTR_RO(type);
 
@@ -10974,7 +10974,7 @@ perf_event_mux_interval_ms_show(struct device *dev,
 {
 	struct pmu *pmu = dev_get_drvdata(dev);
 
-	return snprintf(page, PAGE_SIZE-1, "%d\n", pmu->hrtimer_interval_ms);
+	return scnprintf(page, PAGE_SIZE - 1, "%d\n", pmu->hrtimer_interval_ms);
 }
 
 static DEFINE_MUTEX(mux_interval_mutex);
