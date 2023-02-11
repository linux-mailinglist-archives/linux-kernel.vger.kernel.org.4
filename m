Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81CE692F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 09:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBKIyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 03:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 03:54:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2BF17156
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:54:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id sa10so21178416ejc.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 00:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kSW042nuuhVIYOcJ+JM+r/3KmzLEvzvNeRdEP8Qp3Hc=;
        b=HteGXqVwWSAnxqXg19ooR++7+/FlFZB30Ws36WsCp0pxluvnDn9bTe/6EbqxIkP/m1
         LVfe9LLeD/vUF86uZ39kOtldmbadmaVpQpfbiGZyYaLIWlKmPDFa2uGOp5k8a787mo0P
         wzF4BR4CNX23IF4onD+k0COcbUHQnCyGypaOJFjV1qYwA6Zd0/l0AokRt/clFbm6n0ID
         HjPnXsqgioZd9KhijdUkpxe4Mv4h7pcuT1ITE3AUczhvtk1oCuYIDMF7Ouq+DXELgVCu
         ZJPbjX1Xda42+hchpxcI3wWkP8pEnecKkKake68UjO1ojPPPaYEcu8uBTRf1zW3zqTpm
         O7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSW042nuuhVIYOcJ+JM+r/3KmzLEvzvNeRdEP8Qp3Hc=;
        b=ayFgJ6zSzc3z04Bgd8QG6Sv6pjLWsd7c4XaLuw2OAj9xdkwoYfym4I3ktPyvEa1FcY
         IimhhdrAM1SvW7wrvmQ0x6RF4Nx46RNH5Ng9cNj3TLb8kxE+r/7XxJzliA7ptVzJON2J
         zR+vOpElCJ/1h4b8gQ1Ak6lDGUxoA9iWbpxKGsCRhXiQyFRv/ZftaUfGhAIZHQOMtPY0
         sHsavNGVhpX7pbJdefkQBYM7Hys97t4fmpTX4pHWB5ub+ghZTaw8zo5Ti3rduuPNii3U
         TKDFLRHDkpMb0eiKnnncv1u4tkvnOLkOewGpRjSrvUBT8JseybQ8ZQjWZM1OzLtiN89J
         SPmA==
X-Gm-Message-State: AO0yUKXu+Swtd9qBiN4TtQPCKs9WLVU/CQaaKdwJ0XyZjvz/pZQA2FGE
        EDH//WHZ3QMPJcSqYAbDNHI=
X-Google-Smtp-Source: AK7set9h/yoELgVTBXSHfaCntokO3pbhH5mhhVJeNRf0FrHU7ppxnwinO8vw8d171AZkrUYEGKTFpQ==
X-Received: by 2002:a17:907:8e8b:b0:8aa:1f89:122e with SMTP id tx11-20020a1709078e8b00b008aa1f89122emr18730068ejc.39.1676105671189;
        Sat, 11 Feb 2023 00:54:31 -0800 (PST)
Received: from gmail.com (1F2EF6B7.nat.pool.telekom.hu. [31.46.246.183])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906b00100b0087862f45a29sm3584457ejy.174.2023.02.11.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 00:54:30 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 11 Feb 2023 09:54:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] locking fix
Message-ID: <Y+dXxGNISTLdmh/U@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2023-02-11

   # HEAD: db370a8b9f67ae5f17e3d5482493294467784504 rtmutex: Ensure that the top waiter is always woken up

Fix an rtmutex missed-wakeup bug.

 Thanks,

	Ingo

------------------>
Wander Lairson Costa (1):
      rtmutex: Ensure that the top waiter is always woken up


 kernel/locking/rtmutex.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 010cf4e6d0b8..728f434de2bb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -901,8 +901,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * then we need to wake the new top waiter up to try
 		 * to get the lock.
 		 */
-		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
-			wake_up_state(waiter->task, waiter->wake_state);
+		top_waiter = rt_mutex_top_waiter(lock);
+		if (prerequeue_top_waiter != top_waiter)
+			wake_up_state(top_waiter->task, top_waiter->wake_state);
 		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
