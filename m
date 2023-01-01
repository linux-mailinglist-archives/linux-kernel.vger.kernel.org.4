Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B5165A91F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 07:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjAAGQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 01:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAAGQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 01:16:13 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F06F66
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 22:16:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z12so20253367qtv.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 22:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+W8S4Gw96ZyMz/iU7xZEIkDgZoTIpygT5AgywG1R4c=;
        b=a6T7HkbRuT762R6I6HWxKnaLfnx0/4vDgmHoId90Mn7bOd33CT6EN+PkQXW/TYNBIv
         y4URlU0QGxe1NWqOV4k6tCWrPz6D64eB8134YQh71ZD44IG8w8dprOYEY+2tVjyWvZFi
         7YtcF6vWzY8m8ZZ9bdQn74IAsn2EcurHYMOmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+W8S4Gw96ZyMz/iU7xZEIkDgZoTIpygT5AgywG1R4c=;
        b=YfkpC/XpzPe91q4OQRHzAoe1VtRLY2wwMhpoHm57cmvdZlaUH6cSWrtAK16N8syXEH
         YN8hLvISAgb/15/eP/sleYzYE210g4inYa+Nw7YNJJ+tpMJi7PcUigDzkGdkfVDXJ8If
         sq9UsXOhNDMh0dDq3pQCO38jOM8plhy/YXtt3Oi9cZY1un/K+04sYobWOVu9vpAzmvkT
         /ohA5I0yosjRlUYJJq0w0xKBj7cQ+dOvk7xpehCccNOCU9896fpAddDWTb1zBb5uAxRa
         oBAwKb1dDkiWgfiMAVPjJkmu5VrFHLr60ou4MvKyUYzlybkxfpWd1UjgMXaPkKr4hSEp
         YWyw==
X-Gm-Message-State: AFqh2kq8KSoesB6eMOEUqhgqD7cE//JFBN8GFGaQiCLCgQQL0xb9El20
        fAzv8CZBo63M8J2+ROT7EVLEZNgWEegHsHsJ
X-Google-Smtp-Source: AMrXdXvfxB//pMaDXVtus//c+ZUXIlTibmqbLWJ5pmUZaZpVHulk9jNvtJWvvob7Oqn/Phgm6smPvw==
X-Received: by 2002:a05:622a:1f14:b0:3a5:43af:d7ac with SMTP id ca20-20020a05622a1f1400b003a543afd7acmr54924433qtb.67.1672553768453;
        Sat, 31 Dec 2022 22:16:08 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b006fcb77f3bd6sm18761282qko.98.2022.12.31.22.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 22:16:07 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, stable@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] torture: Fix hang during kthread shutdown phase
Date:   Sun,  1 Jan 2023 06:15:55 +0000
Message-Id: <20230101061555.278129-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During shutdown of rcutorture, the shutdown thread in
rcu_torture_cleanup() calls torture_cleanup_begin() which sets fullstop
to FULLSTOP_RMMOD. This is enough to cause the rcutorture threads for
readers and fakewriters to breakout of their main while loop and start
shutting down.

Once out of their main loop, they then call torture_kthread_stopping()
which in turn waits for kthread_stop() to be called, however
rcu_torture_cleanup() has not even called kthread_stop() on those
threads yet, it does that a bit later.  However, before it gets a chance
to do so, torture_kthread_stopping() calls
schedule_timeout_interruptible(1) in a tight loop. Tracing confirmed
this makes the timer softirq constantly execute timer callbacks, while
never returning back to the softirq exit path and is essentially "locked
up" because of that. If the softirq preempts the shutdown thread,
kthread_stop() may never be called.

This commit improves the situation dramatically, by increasing timeout
passed to schedule_timeout_interruptible() 1/20th of a second. This
causes the timer softirq to not lock up a CPU and everything works fine.
Testing has shown 100 runs of TREE07 passing reliably, which was not the
case before because of RCU stalls.

Cc: Paul McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: <stable@vger.kernel.org> # 6.0.x
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/torture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 29afc62f2bfe..d024f3b7181f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -915,7 +915,7 @@ void torture_kthread_stopping(char *title)
 	VERBOSE_TOROUT_STRING(buf);
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb(title);
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ/20);
 	}
 }
 EXPORT_SYMBOL_GPL(torture_kthread_stopping);
-- 
2.39.0.314.g84b9a713c41-goog

