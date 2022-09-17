Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826B35BB97C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIQQmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIQQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:42:35 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0FB2CDF7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v15so18920935qvi.11
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=djHngNemHi3eZpfRKmBBroxPgd9zL0hx+UyXGlRbBPY=;
        b=tM/vT2smjuv+K6a7RszMHlsIt2sTsMv+X6bVV7YqUcB2ch34LJ/F8YtsOIgNwSJ67b
         oWffBHlgLLaDv/5aI5RXzSHFvqt4ndmNVUJTHMPL8hE6i+b4l0nsMUERHUdVatzJSu9c
         2zHPllDXV63MTFTHvPdresmc/xZe3jODMx25U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=djHngNemHi3eZpfRKmBBroxPgd9zL0hx+UyXGlRbBPY=;
        b=LUr3yO0kupL1YoEL8ZuEjt15S79WPrJAu3Qml2XCPpMSyZhHTocWS+xvbWIrpCjetA
         tlL5rX1oYyq3kAnDotUJrn1G3iVCBzVwKCjd6kY5qJ4DvFKyB/T2r2E5XR2saMRqhDEH
         UcItopfaJ8liiPkFVnbu5PMXvDhu2IRgtmiQIpTeXsmP7/P2GthKMoqNaIUXw/HieOyn
         as2iwMZaibVOvFr1sislzJK5jek1XEFR+uGeRcKib4JrVVypbo7+kidTehXoEYIu6BpD
         jR5wwKNddob7/4w3rrR1ThbftJ+S9sdQEAbLO6Jv59tC6xuJFPGa6xiSUlBJ1+BNR0v9
         gx8w==
X-Gm-Message-State: ACrzQf0dHXe8ohw0WDCEUFuX1nzEmAPJp/AjgaLQGrA3jvN8SvbVfVX5
        dE0Q9IekIBnhSjHMgiUFZHeWaQ==
X-Google-Smtp-Source: AMsMyM48LNU+nDO9OS2sTlYYOlcMNBhQLnc/NBRvCQ2zYhK6WU9+dsqh1fAuPk5Y8f32doofRZY2XQ==
X-Received: by 2002:a05:6214:27ca:b0:4a9:d3f8:9cfb with SMTP id ge10-20020a05621427ca00b004a9d3f89cfbmr8316860qvb.56.1663432951722;
        Sat, 17 Sep 2022 09:42:31 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm9479239qkp.85.2022.09.17.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:42:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH rcu/next 0/3] Preparatory patches borrowed from lazy rcu v5
Date:   Sat, 17 Sep 2022 16:41:57 +0000
Message-Id: <20220917164200.511783-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just sending a few patches before lazy rcu v6 can come out. That can come out
after more testing to check feasibility of ideas discussed at LPC. I will try
to get rcutop pushed as well before that, but in the meanwhile I don't see much
reason to block these few patches for 6.1. These apply to Paul's rcu/next
branch. What do you think?

For Resend:
- Added Reviewed-by tags from Frederic on 1/3 and 3/3. For 2/3, I implemented
changes after last discussion.
- Better commit messages.

Joel Fernandes (Google) (3):
rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
rcu: Fix late wakeup when flush of bypass cblist happens (v6)
rcu: Call trace_rcu_callback() also for bypass queuing (v2)

kernel/rcu/tree.c      | 32 +++++++++++++++++++++++---------
kernel/rcu/tree_nocb.h | 10 ++++++++--
2 files changed, 31 insertions(+), 11 deletions(-)

--
2.37.3.968.ga6b4b080e4-goog

