Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C42C634CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiKWBVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiKWBVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:21:18 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF623B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:17 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id k2so11540229qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3JntlUYopy7EhVt3OZGRdZ2NaDDpzA82H1wCFIfskqg=;
        b=g0aoptFvCay221VgNSwPMf5dHuRH4nedQy3tqwkcTZZpKKoX0sZ/jV7OgYnqVdU+Q7
         QEIq9iLjJpL0Eu8aNF3gUac7QXr0VuEKrM0t/FtCZuAJaJPMLq+rIdF01hzuvXlaHZuj
         BLX7KWa6FOtviGjOy0xzEfhCOQeDuELt/8OOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3JntlUYopy7EhVt3OZGRdZ2NaDDpzA82H1wCFIfskqg=;
        b=d1jBxEQOdNHYKFjjBxTUP3x0Mhq84gbMjkkv0szIw0/RT5UBXhZlo8ZL7s1jX3AGLA
         SFtZN22JUMDXX/I9MvojUUbJXSFMMzVWDgbgu6ynguN/HKyNmqyI4FxREQDo6ZFwTN8a
         n2SkaLobJnl6EVQ0xx5MXP1AIivFlrJ8c0a+YpIc6Yg82axb6wdjZrDCdq2Gz6k5BaF4
         bst58KSIF+O6rhUkjCgRF5sWChZBWVpuXrncvgfYGS6idLESoPcdJHSuGAim5PAw/+tg
         ap9tKyfbSXxSlDy6n4p1F5VF3HP+KO8s51J4Z7yl+wlul/IzgTa/7Muv04lV4n1BvjAM
         yx/w==
X-Gm-Message-State: ANoB5pns4BSxj5RAerfcr9KOLIasbu9qDOujBsS60fZ6qward9QL9hlS
        8sSLrlGUBvOgFNJPyi+DCKWPMFxMNsKFdA==
X-Google-Smtp-Source: AA0mqf4uyzg3EdTAF7HDQlcgMtqREFPwx28T0wQA5uF4AaWX+eQ5tYFPP/xkm9IS8dduF/kFWIMdGA==
X-Received: by 2002:a05:620a:370b:b0:6fa:1da0:2e7b with SMTP id de11-20020a05620a370b00b006fa1da02e7bmr7055604qkb.162.1669166475959;
        Tue, 22 Nov 2022 17:21:15 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id gc7-20020a05622a59c700b0035ce8965045sm9096026qtb.42.2022.11.22.17.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:21:15 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Subject: [PATCH RFC 0/3] Patches on top of PE series
Date:   Wed, 23 Nov 2022 01:21:01 +0000
Message-Id: <20221123012104.3317665-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
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

Just some work I did recently on PE for the balancing issue and lock torture.
Could you please consider testing and/or including in next PE series posting?

Last PE series revived by Connor:
https://lore.kernel.org/lkml/20221003214501.2050087-1-connoro@google.com/

Thank you.

Joel Fernandes (Google) (3):
  sched/pe: Exclude balance callback queuing during proxy()'s migrate
  locktorture: Allow non-rtmutex lock types to be boosted
  locktorture: Make the rt_boost factor a tunable

 kernel/locking/locktorture.c | 93 +++++++++++++++++++-----------------
 kernel/sched/core.c          | 72 +++++++++++++++++++++++++++-
 kernel/sched/sched.h         |  7 ++-
 3 files changed, 126 insertions(+), 46 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

