Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C55E6F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiIVWBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIVWB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:01:28 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD83F1624
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w2so7311321qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eySuugiAbw8rDbqyosau5S1qc5DsO8UPUSTZ8DZ24fc=;
        b=a9qoD9wUuyLv45FLdm4rewR00tvRAXnEJDPVxgUNestW4N4ZrgjgGBNFYnrgWd2SBp
         vhVLgu3JlNc2MsINcevBcJSnvGDRkmTuzpTf0FMburFikrNzwf5dOH0sAAJW+hMw3ZpF
         px8UdgmdXJKjF4zRrGS0AIC4oz9ij/aKpaLVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eySuugiAbw8rDbqyosau5S1qc5DsO8UPUSTZ8DZ24fc=;
        b=HgbcyHDWdSXSsaMUeApMbQpVbHuyFaFKtAllVFphBPEYUt/SETBIUk/BNmoXilcHmr
         iNYWgONGj9j3s4Ma69qHB4Weia5KDbLzr5GOJqycVt7PIhXfWJDhqSLcJ5/g+9WSlqyq
         OxypxMvNDlqGLudNMqlCXWwZ0Ah8A/tPYdqGRjS1Jsy1L+TgPrj6WX2qiWUneh67IbhA
         +NUp2Qm4bcRTyi82D4ViHzHll00iW3Dx6km++Cp48lNIhonDwCkjq6dkAy0AeMLPN4GF
         cZ0mbsImCyPcNmJ9+pK4wjD13sWcBFF6LOYN3FCAXpFUf60q6NeQRmv51LI7JQ2YjtjD
         6hMA==
X-Gm-Message-State: ACrzQf2+7sYKoOXCjKgGlAUjUfGfo7Y10ZQqBykg2IO5qearcS8m0evw
        pMrqO8j8D/7eblAO2LxY4xsbEw==
X-Google-Smtp-Source: AMsMyM7Fee6VM8U8YV9/jN5K8T8ZKcR1kVi79TKvoRXKcRqn7+KS/FeAFWHz8A7b8FHOlQk+fDv+uw==
X-Received: by 2002:ac8:5c8c:0:b0:35d:4c5:7e2a with SMTP id r12-20020ac85c8c000000b0035d04c57e2amr4776446qta.293.1663884086307;
        Thu, 22 Sep 2022 15:01:26 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87f8c000000b0035ba7012724sm4465833qtj.70.2022.09.22.15.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:01:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v6 0/4] rcu: call_rcu() power improvements
Date:   Thu, 22 Sep 2022 22:01:00 +0000
Message-Id: <20220922220104.2446868-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
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

v6 version of RCU lazy patches based on rcu/next branch.

To facilitate easier merge, I dropped tracing and other patches and just
implemented the new changes. I will post the tracing patches later along with
rcutop as I need to add new tracepoints that Frederic suggested.

Main changes:
1. rcu_barrier() wake up only for lazy bypass list.
2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
3. Take care of some callers using call_rcu_flush() API.

I am seeing good performance and power with these patches on real ChromeOS x86
asymmetric hardware.

v5 cover letter is here:
https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/

Joel Fernandes (Google) (3):
rcu: Make call_rcu() lazy to save power
rcuscale: Add laziness and kfree tests
percpu-refcount: Use call_rcu_flush() for atomic switch

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

include/linux/rcupdate.h |   7 ++
kernel/rcu/Kconfig       |   8 ++
kernel/rcu/rcu.h         |   8 ++
kernel/rcu/rcuscale.c    |  65 ++++++++++-
kernel/rcu/tiny.c        |   2 +-
kernel/rcu/tree.c        | 133 ++++++++++++++--------
kernel/rcu/tree.h        |  17 ++-
kernel/rcu/tree_exp.h    |   2 +-
kernel/rcu/tree_nocb.h   | 236 +++++++++++++++++++++++++++++++++------
lib/percpu-refcount.c    |   3 +-
10 files changed, 395 insertions(+), 86 deletions(-)

--
2.37.3.998.g577e59143f-goog

