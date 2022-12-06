Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B56643E39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbiLFIPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiLFIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:15:40 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448D8DF08;
        Tue,  6 Dec 2022 00:15:38 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NRCsM5PYCz8RV7D;
        Tue,  6 Dec 2022 16:15:35 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2B68FKto091781;
        Tue, 6 Dec 2022 16:15:20 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 6 Dec 2022 16:15:22 +0800 (CST)
Date:   Tue, 6 Dec 2022 16:15:22 +0800 (CST)
X-Zmail-TransId: 2af9638efa1affffffffe3a57249
X-Mailer: Zmail v1.0
Message-ID: <202212061615227896127@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <rafael@kernel.org>
Cc:     <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBjcHVmcmVxOiBzdGF0czogQ29udmVydCB0byB1c2Ugc3lzZnNfZW1pdF9hdCgpIEFQSQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B68FKto091781
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638EFA27.001 by FangMail milter!
X-FangMail-Envelope: 1670314535/4NRCsM5PYCz8RV7D/638EFA27.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638EFA27.001/4NRCsM5PYCz8RV7D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/cpufreq/cpufreq_stats.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1570d6f3e75d..55c7ffd37d1c 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -128,25 +128,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j, count;

-	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
+	len += sysfs_emit_at(buf, len, "   From  :    To\n");
+	len += sysfs_emit_at(buf, len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
 		if (len >= PAGE_SIZE)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
-				stats->freq_table[i]);
+		len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
 	}
 	if (len >= PAGE_SIZE)
 		return PAGE_SIZE;

-	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");

 	for (i = 0; i < stats->state_num; i++) {
 		if (len >= PAGE_SIZE)
 			break;

-		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
-				stats->freq_table[i]);
+		len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);

 		for (j = 0; j < stats->state_num; j++) {
 			if (len >= PAGE_SIZE)
@@ -157,11 +155,11 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 			else
 				count = stats->trans_table[i * stats->max_state + j];

-			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
+			len += sysfs_emit_at(buf, len, "%9u ", count);
 		}
 		if (len >= PAGE_SIZE)
 			break;
-		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+		len += sysfs_emit_at(buf, len, "\n");
 	}

 	if (len >= PAGE_SIZE) {
-- 
2.25.1
