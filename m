Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23300732912
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245295AbjFPHjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjFPHjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:39:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CAF1FE2;
        Fri, 16 Jun 2023 00:39:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-66643830ab3so541512b3a.0;
        Fri, 16 Jun 2023 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686901175; x=1689493175;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7akhRlrAotjAIYUI4yTq+8R48vhHEwOUnsry9EsS18=;
        b=coR3DHhVCV63O2jHgnP8FOfFjrEI7Vn3UwLEdsaTlC4zdYT2te1IF+EhrIMzG/XPCJ
         dSy6+zDZeAEq0/yZSGxol9NjgcXAXHR+0RYzSmjIVJyWcEplG9+jLszotI+CY60UrruN
         4NGBQaHHVW1xet1QyqVc7Ed2mDmok0eUgHs6UvZNvqfWOJrN9mb0ByF8ar0cUbINNKGZ
         2WOalAO7282mD+Z0TfIaIN0lnm1+m696pAsSe7/enO/O3RWHx7peWazLs1PBM5Q5RVEO
         8d6z94qr7lW6aNZVhf0yV9PHfcW0Sv7kqBDzeZXxZ4bhUs0JS2kSNVbQDTBOLxrE2fmu
         us3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686901175; x=1689493175;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7akhRlrAotjAIYUI4yTq+8R48vhHEwOUnsry9EsS18=;
        b=faQWZXlMGBXLTVcQw5xsEVuoVm4tRTiWekE7Vy+uVsiGTblGBua6gw/d08iPgb4q3D
         EGL2TtBzxPW4iwAn3B2ISxKgcfEEz2rWf/TDwlBXS6aRIpQhTknhRrRti3cU8XmY9aJ4
         dWHut4VeKKDzkiPKIexIR556mpaZpIn+MWVYehP5e0zmG7DlKZ2EIEfHMW2c2Opkz9Ei
         9JyVv2wLg01i1htafA1li8fUzi0sGp5SZkuHQdGyYfSwbI8t9TnN9Jh4yW8yqwx/UGkT
         BysFtdo36/xZud4JHZnM84IUB7N4i5G2wyYmK3ziWVl6X6sBOgd1vUamVg0EklImfQ9O
         CyPw==
X-Gm-Message-State: AC+VfDyqHd6yF6mCqM9GTl/tWK6J2xOUMzc+HnhfOi6nDigT1x5Ag+gF
        14VJUt4fyNXpXrA394LR9D0=
X-Google-Smtp-Source: ACHHUZ6eOEbtBw8SsrurV+CCezsk2e6rlw4DzO7g8MY7I6b91aDLku50jfVWhDrIG1M1+TbNjMN8wQ==
X-Received: by 2002:a05:6a00:1a56:b0:65b:38b2:8d4b with SMTP id h22-20020a056a001a5600b0065b38b28d4bmr1509585pfv.29.1686901174778;
        Fri, 16 Jun 2023 00:39:34 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id i21-20020aa78d95000000b0064d34ace753sm13134736pfr.114.2023.06.16.00.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 00:39:34 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org,
        quic_neeraju@quicinc.com, qiang.zhang1211@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcuscale: Move schedule_timeout _uninterruptible to _idle in rcu_scale_writer()
Date:   Fri, 16 Jun 2023 15:39:26 +0800
Message-Id: <20230616073926.24462-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcuscale.holdoff can be used to delay the start of rcu_scale_writer
kthread, however, if the rcuscale.holdoff is set and the timeout is greater
than the hung_task_timeout_secs, can trigger the hung-task timeout:

runqemu kvm nographic slirp qemuparams="-smp 4 -m 2048M"
bootparams="rcuscale.shutdown=0 rcuscale.holdoff=300"

[  247.071753] INFO: task rcu_scale_write:59 blocked for more than 122 seconds.
[  247.072529]       Not tainted 6.4.0-rc1-00134-gb9ed6de8d4ff #7
[  247.073400] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  247.074331] task:rcu_scale_write state:D stack:30144 pid:59    ppid:2      flags:0x00004000
[  247.075346] Call Trace:
[  247.075660]  <TASK>
[  247.075965]  __schedule+0x635/0x1280
[  247.076448]  ? __pfx___schedule+0x10/0x10
[  247.076967]  ? schedule_timeout+0x2dc/0x4d0
[  247.077471]  ? __pfx_lock_release+0x10/0x10
[  247.078018]  ? enqueue_timer+0xe2/0x220
[  247.078522]  schedule+0x84/0x120
[  247.078957]  schedule_timeout+0x2e1/0x4d0
[  247.079447]  ? __pfx_schedule_timeout+0x10/0x10
[  247.080032]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.080591]  ? __pfx_process_timeout+0x10/0x10
[  247.081163]  ? __pfx_sched_set_fifo_low+0x10/0x10
[  247.081760]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.082287]  rcu_scale_writer+0x6b1/0x7f0
[  247.082773]  ? mark_held_locks+0x29/0xa0
[  247.083252]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.083865]  ? __pfx_rcu_scale_writer+0x10/0x10
[  247.084412]  kthread+0x179/0x1c0
[  247.084759]  ? __pfx_kthread+0x10/0x10
[  247.085098]  ret_from_fork+0x2c/0x50
[  247.085433]  </TASK>

This commit therefore replaces schedule_timeout_uninterruptible() with
schedule_timeout_idle().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index a0eae1900708..ffdb30495e3c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -469,7 +469,7 @@ rcu_scale_writer(void *arg)
 	sched_set_fifo_low(current);
 
 	if (holdoff)
-		schedule_timeout_uninterruptible(holdoff * HZ);
+		schedule_timeout_idle(holdoff * HZ);
 
 	/*
 	 * Wait until rcu_end_inkernel_boot() is called for normal GP tests
-- 
2.17.1

