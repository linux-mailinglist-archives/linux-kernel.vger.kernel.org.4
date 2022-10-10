Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F845F9D02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiJJKmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiJJKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:42:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462696B159
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:42:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so12723187pjq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUZiDAkisWsbkBtNg5M6nwdpoi4lUbxssotjHVspO6Y=;
        b=WPdDsg+OiYrMYfJS2MsBXiS34PyQOxdGD5JhLyqQTW18yljSPBC/IEXw1FU4pE3H4o
         dYCn+LCpStFUDRXdA7mR8LC/vgermkI1B0CWRbeK0i9f3unj+3MJ0UZyoFWCRS/h70CA
         p9jw2q1M9357hLm1s6wyM1CKrLZQXWPOnPEaujKyZQCYYNK5FADrjNqErsDSVgxc0wBz
         gEL21kstaJ6YGuMblsozMNVKevRxbrutvLhYwFAAktwuU/EJraET60Wegfdd9+JCDW3a
         zirhi7rEyEqki2kZf3gZa0p6+E7dh4TNd1lEG37dKeTdPBZU0pmaWTv/H+caxNY+d/FP
         xyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUZiDAkisWsbkBtNg5M6nwdpoi4lUbxssotjHVspO6Y=;
        b=y3rS7HQ53bEpqwEkqE6MgPuHnsNAa8zT9x36B4yI0hvqs2iKoBWGyFwC+HLdb4ucwN
         u2LITHQjpvOugWYykEmnwd0MGop4BAs3C3XikVd3gF6JBgIcVIde35xaNZgTbediTNFM
         8EguRItoMRPqfq+f6tpzS9Zc/dHf1qjshqNQaBmXVI8ZoWfI+m95Ot6wjsgjRrE1iFg+
         /0Hz5hV8OLA0V/7ajqiaFoYexcraYN0zAHXCjYWP7tpU0/f5VsLyZRNVO0lnqJZk+4wF
         fXReDB+vyvAZYCfCOxucW8jGX63qpxZu5GdQMpNLtUaUpUIynnxaJoRCvbcd444fRqPR
         zKng==
X-Gm-Message-State: ACrzQf2J5JLDvY2hGTE+lYhTdiwMyl+ifodORzRTwsvq3gyuO3e/zFyy
        47ccDhtYlU8gf9+ADuUVu84+Hw==
X-Google-Smtp-Source: AMsMyM5/LBUFoKoGLQ1r7x9N6IFT07r39az9dgmKHu4b3JcvkGLReVVNstDhqx6bqmNwdpT1gMH9Ag==
X-Received: by 2002:a17:90b:3b47:b0:202:d9d4:23f7 with SMTP id ot7-20020a17090b3b4700b00202d9d423f7mr30792094pjb.56.1665398536696;
        Mon, 10 Oct 2022 03:42:16 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b00176b63535adsm6327874plg.260.2022.10.10.03.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 03:42:16 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, quic_pkondeti@quicinc.com
Cc:     peterz@infradead.org, quic_charante@quicinc.com,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/psi: Fix avgs_work re-arm in psi_avgs_work()
Date:   Mon, 10 Oct 2022 18:42:06 +0800
Message-Id: <20221010104206.12184-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
References: <20220913140817.GA9091@hu-pkondeti-hyd.qualcomm.com>
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

Pavan reported a problem that PSI avgs_work idle shutoff is not
working at all. Because PSI_NONIDLE condition would be observed in
psi_avgs_work()->collect_percpu_times()->get_recent_times() even if
only the kworker running avgs_work on the CPU.

Although commit 1b69ac6b40eb ("psi: fix aggregation idle shut-off")
avoided the ping-pong wake problem when the worker sleep, psi_avgs_work()
still will always re-arm the avgs_work, so shutoff is not working.

This patch changes to consider current CPU groupc as IDLE if the
kworker running avgs_work is the only task running and no IOWAIT
or MEMSTALL sleep tasks, in which case we will shut off the avgs_work
if other CPUs' groupc are also IDLE.

One potential problem is that the brief period of non-idle time
incurred between the aggregation run and the kworker's dequeue will
be stranded in the per-cpu buckets until avgs_work run next time.
The buckets can hold 4s worth of time, and future activity will wake
the avgs_work with a 2s delay, giving us 2s worth of data we can leave
behind when shut off the avgs_work. If the kworker run other works after
avgs_work shut off and doesn't have any scheduler activities for 2s,
this maybe a problem.

Reported-by: Pavan Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ee2ecc081422..f4cdf6f184ba 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -242,6 +242,8 @@ static void get_recent_times(struct psi_group *group, int cpu,
 			     u32 *pchanged_states)
 {
 	struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
+	int current_cpu = raw_smp_processor_id();
+	bool only_avgs_work = false;
 	u64 now, state_start;
 	enum psi_states s;
 	unsigned int seq;
@@ -256,6 +258,15 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		memcpy(times, groupc->times, sizeof(groupc->times));
 		state_mask = groupc->state_mask;
 		state_start = groupc->state_start;
+		/*
+		 * This CPU has only avgs_work kworker running, snapshot the
+		 * newest times then don't need to re-arm for this groupc.
+		 * Normally this kworker will sleep soon and won't wake
+		 * avgs_work back up in psi_group_change().
+		 */
+		if (current_cpu == cpu && groupc->tasks[NR_RUNNING] == 1 &&
+		    !groupc->tasks[NR_IOWAIT] && !groupc->tasks[NR_MEMSTALL])
+			only_avgs_work = true;
 	} while (read_seqcount_retry(&groupc->seq, seq));
 
 	/* Calculate state time deltas against the previous snapshot */
@@ -280,6 +291,10 @@ static void get_recent_times(struct psi_group *group, int cpu,
 		if (delta)
 			*pchanged_states |= (1 << s);
 	}
+
+	/* Clear PSI_NONIDLE so avgs_work won't be re-armed for this groupc */
+	if (only_avgs_work)
+		*pchanged_states &= ~(1 << PSI_NONIDLE);
 }
 
 static void calc_avgs(unsigned long avg[3], int missed_periods,
-- 
2.37.2

