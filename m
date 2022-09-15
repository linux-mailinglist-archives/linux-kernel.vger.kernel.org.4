Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA45D5B9185
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiIOAOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIOAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:14:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2C92718
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:14:33 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id d17so11372190qko.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=n75DckJoTNxwHGQy+cAzlCqQ+/GK+bz2i3ZQXyrbV3o=;
        b=qApXbnIKeQh3JuT+G6S4AN/JA7pDhe1ZN1/ProWVTLC/Rij/S4yNyrTcBcqxb15gT8
         8YiocZCvL+QltvhXJ9euL+HrQz+fpU5dQxPkkl7hRmteqRE6fzC5vAYZumEiU0vwZIq2
         Cld5jckzCNCBc3dfflc8oaJA2UN3rZ8wDZXDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=n75DckJoTNxwHGQy+cAzlCqQ+/GK+bz2i3ZQXyrbV3o=;
        b=LqLpdVLowAA1adfPR5ZbwZTYgPYtobTc0LBpbRFztwReU9da4Gn38ORrltohyTpsjK
         IoDdAYFSUoHkMuC3DyZV7z38wKP0+x9k0DcPWMjyShcdQAhSaAUUVWgnLRL3C5ZDjoIb
         /EaevkbQHtkGHw5fN8KlEBQmw2Q3PzUlBkLtJAOAPlF3SwYf3Rin8FxmyYTeWlQXDWNc
         HEC4vxTfbfkp7W9gqL60kyaeV6FeIHr+Y4+Ptz02YMETn7QT2pPSoVvgqgrbIXMX4iYN
         REtOhYgrnCMImho62gi0kn7huULcpCKQERBcV5t6xRYLwwagee9jUsj6PEJnDRojeqsc
         D8Dg==
X-Gm-Message-State: ACgBeo3fqaOOoCt2eguZETZII/S+k1lo1byaI3i2niGvGTHb4IQy0N2C
        5EaCmI4GZsLRRVWqBdvWVyL0xG3zDanazSOA
X-Google-Smtp-Source: AA6agR5EImjOMvPGoTYlDOogzQ3RZqT0E/3ynshzHY9J48USbOtAX8h2DmPD3ZjuAlj49Xt+xtD6eg==
X-Received: by 2002:a05:620a:2887:b0:6b6:52a5:d287 with SMTP id j7-20020a05620a288700b006b652a5d287mr28551826qkp.442.1663200872662;
        Wed, 14 Sep 2022 17:14:32 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm2872422qkb.108.2022.09.14.17.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:14:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu/next 0/3] Preparatory patches borrowed from lazy rcu v5
Date:   Thu, 15 Sep 2022 00:14:16 +0000
Message-Id: <20220915001419.55617-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just sending a few patches before lazy rcu v6 can come out. That can come out
after more testing to check feasibility of ideas discussed at LPC. I will try
to get rcutop pushed as well before v6, but in the meanwhile I don't see much
reason to block these few patches for 6.1. These apply to Paul's rcu/next
branch. What do you think?

Joel Fernandes (Google) (3):
rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
rcu: Move trace_rcu_callback() before bypassing
rcu: Fix late wakeup when flush of bypass cblist happens

kernel/rcu/tree.c      | 12 +++++++-----
kernel/rcu/tree_nocb.h | 10 ++++++++--
2 files changed, 15 insertions(+), 7 deletions(-)

--
2.37.2.789.g6183377224-goog

