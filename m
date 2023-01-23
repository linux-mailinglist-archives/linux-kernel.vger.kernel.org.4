Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC27D678427
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjAWSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjAWSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:07:09 -0500
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F03230E8B;
        Mon, 23 Jan 2023 10:06:52 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1124040F37;
        Mon, 23 Jan 2023 17:58:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8F72F4136A;
        Mon, 23 Jan 2023 17:58:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674496725; a=rsa-sha256;
        cv=none;
        b=Ydk1xQThOhi0rM3HRIH3CfgnoBNFwxmdJ0vqtMHjfhUUpOfX1I34HQfuNvQZtYOPB4qw/q
        gJGuC22y8ZR4hLS+7K7pcwLnaiJ1h/orbNtYcFHMNcDC9G/725vcm5R/F9Pneh/0g9FvIh
        m1AR/yVIb3sEDasmpGVDYD9b96QxqInGKHW+lRz19VACHffxuCFkEodhSwZfrD6gjKoW3s
        JtrnkcQ4lkAeE66fJl0+Zf243f2dOEkbTjzVIcUJJw1TF9e9sumC37Dy3XeSPaB7FCleCH
        Gj29xhK6Fo5HpId63dSgBjJp3BZBw+kVxP4TzZGFHLmtpSanILQiCIdw6w1Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674496725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=HgAdgrmSZwhL1H/zHHkhQTAR0+DUP7uLvndtCVdk2qo=;
        b=hm9TdxvZSgsJ9VcBfQGol9clbea7aLbqFyBch1N1Yak7uSrqFHSN70JagnWkDbhuLXP5aH
        hZVsavS+TFmdblKdUhvOyGpHJdLmhBv+fM5DnTj+HIeyQVGHd5/A0CxZv6Bv0JsPgYFbPK
        idwzAyIu44hyqufJUrgBZbDZgieYfJYxhwziratNKHV+2igQEVsZDxh90d04JprbEtQ/Eb
        uRjWZOhVUAvYYCQh3IRTpkGmCdSDDO1ZHHc5JM1BMC2MVsXb+Bw0rKDlpYCElDUQxCX0K5
        b3d7/K80p6jZ2Pkr3+8LLD/vEYzNmE8ZGSDkJJdjGLhaZdtvb4ey8ZFhix71Rg==
ARC-Authentication-Results: i=1;
        rspamd-6f569fcb69-rsl9k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Harmony: 7ff6a0843d702ea9_1674496725888_2713900432
X-MC-Loop-Signature: 1674496725888:410151927
X-MC-Ingress-Time: 1674496725888
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.6 (trex/6.7.1);
        Mon, 23 Jan 2023 17:58:45 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4P0yX44BZ6zRs;
        Mon, 23 Jan 2023 09:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1674496725;
        bh=HgAdgrmSZwhL1H/zHHkhQTAR0+DUP7uLvndtCVdk2qo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=BvE7YjLYu07x6MeqispuTojP+NhTXef8mnV4Sofnl+MKUwzYVPzX6juCzh0mIZWup
         EbPGAJNtNn+iqAavu5q/sxAu6I0dcf+rxC8ClRYsLgkFJqFTCBYhld2tr4VMKM5vW9
         0ly2O5QefatNHFSlAKwKex1KlLhkC8WYJtuyP/1QhbXxhztn4IcTGT1W7hJXl4UpBB
         I2RxIVpO8cUsE/+4tEGOSsvpFFeND8EtvZUH+/f9jIcDdR+aq48qy0+L34KzM3nP9Q
         fBYR4zEib4hgAw12w2If4DsBzVuOVG3PHCqseIeJnMXZq1USEqnBB6LUUM4ilFJJF5
         JKZLyBamvA1GA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@kernel.org, peterz@infradead.org, bigeasy@linutronix.de,
        dave@stgolabs.net, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kernel/hrtimer: Ignore slack time for RT tasks
Date:   Mon, 23 Jan 2023 09:32:06 -0800
Message-Id: <20230123173206.6764-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123173206.6764-1-dave@stgolabs.net>
References: <20230123173206.6764-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in theory the timer can be triggered before expires+delta,
for the cases of RT tasks they really have no business giving
any lenience for extra slack time, so override any passed value
by the user and always use zero for schedule_hrtimeout_range()
calls. Furthermore, this is similar to what the nanosleep(2)
family already does with current->timer_slack_ns.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/time/hrtimer.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8336c2618ec1..78f2e07d3e7d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2270,7 +2270,7 @@ void __init hrtimers_init(void)
 /**
  * schedule_hrtimeout_range_clock - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  * @clock_id:	timer clock to be used
  */
@@ -2297,6 +2297,13 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 		return -EINTR;
 	}
 
+	/*
+	 * Override any slack passed by the user if under
+	 * rt contraints.
+	 */
+	if (rt_task(current))
+		delta = 0;
+
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
@@ -2316,7 +2323,7 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 /**
  * schedule_hrtimeout_range - sleep until timeout
  * @expires:	timeout value (ktime_t)
- * @delta:	slack in expires timeout (ktime_t)
+ * @delta:	slack in expires timeout (ktime_t) for SCHED_OTHER tasks
  * @mode:	timer mode
  *
  * Make the current task sleep until the given expiry time has
@@ -2324,7 +2331,8 @@ EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
  * the current task state has been set (see set_current_state()).
  *
  * The @delta argument gives the kernel the freedom to schedule the
- * actual wakeup to a time that is both power and performance friendly.
+ * actual wakeup to a time that is both power and performance friendly
+ * for regular (non RT/DL) tasks.
  * The kernel give the normal best effort behavior for "@expires+@delta",
  * but may decide to fire the timer earlier, but no earlier than @expires.
  *
-- 
2.39.0

