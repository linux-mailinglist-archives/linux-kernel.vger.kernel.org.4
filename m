Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEFE5F7639
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiJGJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJGJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:26:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F9120BE8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:26:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so4061957plo.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKFjny/9mWuO/iG0Kxc5VvaxquxrAamtdUptPDp0d74=;
        b=AngNmDbhqF7oOIzvRt23cm/VbXB5qly7NvGLYKWLcaYacG7ceVkIDVFCaTy+5Hw4N6
         pkEKIsR+JnE7FQ2tKD6aIHN/lA3nSFzPpAfNkCXQpm3OV+MyvvfndWtGOSa6a1am65fY
         KAiPUjqJaqGmEM/cSmeU9guNI+hJxrxZ2hxb2Yoa9ZQTagAmfBHMVyjej00P9Sw1IRZ5
         eH6/tgp28QATHvBUZ3ot8D5Auh1SR72Nw+rvbSuJMu9JUocNqeT75M4qsCBV7xsHLQ0B
         fHRwWAxh/9XMG9rKEwHTMsVvnMRa7uzIyzjaeQVGtjUlrMgntL3F+ORSdR/RQVIM1uGf
         4+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKFjny/9mWuO/iG0Kxc5VvaxquxrAamtdUptPDp0d74=;
        b=rSu9QnZHrmFY9DvUB/B5e1VjMXA40VjhZstE3xbPwrwhQNCYIE9c+A7PLNXiHuFWMn
         el+1mXrbsRKpOK/J/GdOGsyqP7b1bxoZZEGS4pmjWUbtFxAdVylkRxhBQnF/o6Y0i7ID
         Wv+1oroWJ+yrBDxrticCdAiahLScR/yHJyPNYP9Zf5AQCqZrhSmA5tr3bpcbvgtAU38n
         TLk5UkcdlVKwjSnpXo+ER7oC4DphV5beO82PQQ8dhXgq5zZFos6V3Qed1BulwGiMiBYy
         fbXBgmeMhvAETm8A/zSCn7ULqNc63ykGiQYsXQI/fY+rzQV9HhIaeuy+QUFaz7RY+hBB
         OC9w==
X-Gm-Message-State: ACrzQf3mpk88Ety6z5eAwIONnLstNMhL4/rCkPTr7hMqy4JJC33exbU+
        +NeOzjKsZOBmcawUHsgiGUmicg==
X-Google-Smtp-Source: AMsMyM4c5tdR5HoZonQcRDYA/eocBG1QDHyMCRm/da7cesjqViV750YP7uXXDUViKsc3DUfX8XnGhg==
X-Received: by 2002:a17:90a:6503:b0:207:cd0e:bf1f with SMTP id i3-20020a17090a650300b00207cd0ebf1fmr4438832pjj.25.1665134793930;
        Fri, 07 Oct 2022 02:26:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902e74700b0016ef87334aesm1069394plf.162.2022.10.07.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 02:26:33 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH 2/3] ipmi: fix long wait in unload when IPMI disconnect
Date:   Fri,  7 Oct 2022 17:26:16 +0800
Message-Id: <20221007092617.87597-3-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
References: <20221007092617.87597-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fixing the problem mentioned in PATCH1, we also found
the following problem:

If the IPMI is disconnected and in the sending process, the
uninstallation driver will be stuck for a long time.

The main problem is that uninstalling the driver waits for curr_msg to
be sent or HOSED. After stopping tasklet, the only place to trigger the
timeout mechanism is the circular poll in shutdown_smi.

The poll function delays 10us and calls smi_event_handler(smi_info,10).
Smi_event_handler deducts 10us from kcs->ibf_timeout.

But the poll func is followed by schedule_timeout_uninterruptible(1).
The time consumed here is not counted in kcs->ibf_timeout.

So when 10us is deducted from kcs->ibf_timeout, at least 1 jiffies has
actually passed. The waiting time has increased by more than a
hundredfold.

Now instead of calling poll(). call smi_event_handler() directly and
calculate the elapsed time.

For verification, you can directly use ebpf to check the kcs->
ibf_timeout for each call to kcs_event() when IPMI is disconnected.
Decrement at normal rate before unloading. The decrement rate becomes
very slow after unloading.

  $ bpftrace -e 'kprobe:kcs_event {printf("kcs->ibftimeout : %d\n",
      *(arg0+584));}'

Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
---
 drivers/char/ipmi/ipmi_si_intf.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 6e357ad76f2e..abddd7e43a9a 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2153,6 +2153,20 @@ static int __init init_ipmi_si(void)
 }
 module_init(init_ipmi_si);
 
+static void wait_msg_processed(struct smi_info *smi_info)
+{
+	unsigned long jiffies_now;
+	long time_diff;
+
+	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
+		jiffies_now = jiffies;
+		time_diff = (((long)jiffies_now - (long)smi_info->last_timeout_jiffies)
+		     * SI_USEC_PER_JIFFY);
+		smi_event_handler(smi_info, time_diff);
+		schedule_timeout_uninterruptible(1);
+	}
+}
+
 static void shutdown_smi(void *send_info)
 {
 	struct smi_info *smi_info = send_info;
@@ -2187,16 +2201,13 @@ static void shutdown_smi(void *send_info)
 	 * in the BMC.  Note that timers and CPU interrupts are off,
 	 * so no need for locks.
 	 */
-	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
-		poll(smi_info);
-		schedule_timeout_uninterruptible(1);
-	}
+	wait_msg_processed(smi_info);
+
 	if (smi_info->handlers)
 		disable_si_irq(smi_info);
-	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
-		poll(smi_info);
-		schedule_timeout_uninterruptible(1);
-	}
+
+	wait_msg_processed(smi_info);
+
 	if (smi_info->handlers)
 		smi_info->handlers->cleanup(smi_info->si_sm);
 
-- 
2.30.2

