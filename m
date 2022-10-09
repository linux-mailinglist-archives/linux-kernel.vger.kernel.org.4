Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FEE5F8A56
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiJIJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJIJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:18:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF272B1AA
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:18:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id p14so4122006pfq.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKFjny/9mWuO/iG0Kxc5VvaxquxrAamtdUptPDp0d74=;
        b=ojQqKCdE1xWnmbi41ppc32d+eOC7AWp0Z8fAmyiBCoOubBhyz21Z9rC7wh21wSzkWr
         Blh98iWF76sGUhTbkD20/++kK597nR3eZKk9Q8+XUaTP7xZWD+znQoJva6NviowPO09E
         rEpoKXUyqJ3MHO0Zmx9VAIwUuW0LiY/5kEQeOzzmcCSEUys8Csa4jrUuW+b0vbCDKoTd
         B7A6LKNJo6lZbsYaWcq92O+uPUk7yXDvOYXzCeNlYNSkM0ozVwAc+oBtCrGpyQcsKa3S
         yIIVa5FTtlLaIPL6tZhecGJu8mYNLn+v+46/m1iBsAely7nOeCqkxF6hZPFePoY1G1wm
         bw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKFjny/9mWuO/iG0Kxc5VvaxquxrAamtdUptPDp0d74=;
        b=vz8MWcb5W1CpWDFkXXWyPP4vLAE22bFb/OkP3KJf7JRJT3dsHINcNywOrZ9Z+OEUvK
         ShaG2sr3dp/q2Etbf/9gLXlQxB71QL7ZrFX7onqdU4gdEWD+B3bcehUMBFzzRNb1ou0y
         3m7f7GtOxQKnvdmHUhWmhTTDoAN4ILUzTbSoJUKizEzNxge7ZRxKbSfeJkIRN4CTZmYw
         gc+/pxwUhfD5KlhOF2xw1oHbyCux3Th4EBLczRxbi106V29wPCa+kmCfknEq7z+YWKD2
         Ij8xZz42I1SBbmvbQBAF7/0s1lWR/Aq2OrPyxaVVTy5W0qe8YtzcJkJqtxlPp0Yc5jZ8
         iptw==
X-Gm-Message-State: ACrzQf1pXmU5gW9jOLnDPRny9w45cMudGd8Lc2VshCOZl6CuQknoD5DJ
        WLOOyjW4vLtRuXpAdQKZqb+QFw==
X-Google-Smtp-Source: AMsMyM4tSxYbXYtzOq11CTZtT49IL2PjNyOj9GZtNR3Z8wRpNJP4JMMrmFnExO9hOFCydmTujtOhIA==
X-Received: by 2002:a63:ff1b:0:b0:43c:e4ee:e5e0 with SMTP id k27-20020a63ff1b000000b0043ce4eee5e0mr11382651pgi.540.1665307107095;
        Sun, 09 Oct 2022 02:18:27 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id f38-20020a635566000000b004405c6eb962sm4328711pgm.4.2022.10.09.02.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:18:26 -0700 (PDT)
From:   Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, qi.zheng@linux.dev,
        Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Subject: [PATCH v2 2/3] ipmi: fix long wait in unload when IPMI disconnect
Date:   Sun,  9 Oct 2022 17:18:10 +0800
Message-Id: <20221009091811.40240-3-zhangyuchen.lcr@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20221009091811.40240-1-zhangyuchen.lcr@bytedance.com>
References: <20221009091811.40240-1-zhangyuchen.lcr@bytedance.com>
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

