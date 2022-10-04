Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773795F3B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJDCmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJDCmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72311220F0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 19:42:20 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so8064515qvs.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 19:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1Ydh1sTYTB+G4p1TUCm5A0LuEGnTBDPLiVoWccVO8tQ=;
        b=O6tSjWAnQfyu9jCSUUxAPTRTMJsmk8N8kkQ5yOa4FxOw+7r7YAtQdpfc/cGcrH6Usm
         JgCK86czKV1GYO0U2GKkgDQxODv4SeGqMMEas5HkH4570qKkMNmAbAQsKMUwhx6ZzDJ7
         M2/ecRDGMhmCghmjn/sjiWfQBtb1KacRAW4w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1Ydh1sTYTB+G4p1TUCm5A0LuEGnTBDPLiVoWccVO8tQ=;
        b=MXEok/yfsTOtSVTz/mICAxeDTFjUkCMaXddiKMwLzwOwnzhLKGC5TWmKjA88Zqpneh
         iwBpRaDrqJ5p+9LE2sg4i8zJJUtt/QciHiWiey61rx+hjRjdAhcMyNkyZ4ER3IfcA4+z
         afZkbN4kjDkkAzTnY+Me1PMmacrxStq4X8h8lfgDdUM3lJ/biHDXkCkhx8Nn+2suqZQi
         8x/eYjLqMJzhx2EeZFCv/4wFQRS2ldjsOAgJYqC5NhfkaFkViKzcR5l02+HUopMoCnYv
         DDBT05SgRI7GJtnvaAyzCsYjxMmAcBYkpSA/M/elxO5JGEHcxTYgNl81y+Gw6S3D/Tm+
         iRAQ==
X-Gm-Message-State: ACrzQf0YJ7cJ917/Y7Cy+OCaNp48Iu5rapL/Bhf928ujH6qqYYAJ+A09
        3LeBSV1Ha/BWPCWhmzSGPQVsbg==
X-Google-Smtp-Source: AMsMyM46KgEOkbrj/gRFJr3t+N8w+Q5zHpPQJ384OMIMzINV/29fKgbdy6CP5WNhoCykiS8ms651JQ==
X-Received: by 2002:a05:6214:21ab:b0:4ad:6fe6:be7b with SMTP id t11-20020a05621421ab00b004ad6fe6be7bmr18343392qvc.5.1664851339614;
        Mon, 03 Oct 2022 19:42:19 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 00/11] rcu: call_rcu() power improvements
Date:   Tue,  4 Oct 2022 02:41:46 +0000
Message-Id: <20221004024157.2470238-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

v7 version of RCU lazy patches based on rcu/next branch.

To facilitate easier merge, I dropped tracing and other patches and just
implemented the new changes. I will post the tracing patches later along with
rcutop as I need to add new tracepoints that Frederic suggested.

Main recent changes:
1. rcu_barrier() wake up only for lazy bypass list.
2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
3. Take care of some callers using call_rcu_flush() API.
4. Several refactorings suggested by Paul/Frederic.
5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.

I am seeing good performance and power with these patches on real ChromeOS x86
asymmetric hardware.

Earlier cover letter with lots of details is here:
https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/

List of recent changes:
    
    [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
      deferral levels wake much earlier so for those it is not needed. ]
    
    [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
    
    [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
    
    [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
    
    [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
    
    [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
    
    [ Paul/Frederic : Cosmetic changes, split out wakeup of nocb thread. ]
    
    [ Vlad/Joel : More call_rcu -> flush conversions ]

Frederic Weisbecker (1):
rcu: Wake up nocb gp thread on rcu_barrier_entrain()

Joel Fernandes (Google) (7):
rcu: Make call_rcu() lazy to save power
rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
rcuscale: Add laziness and kfree tests
percpu-refcount: Use call_rcu_flush() for atomic switch
rcu/sync: Use call_rcu_flush() instead of call_rcu
rcu/rcuscale: Use call_rcu_flush() for async reader test
rcu/rcutorture: Use call_rcu_flush() where needed

Uladzislau Rezki (2):
scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
workqueue: Make queue_rcu_work() use call_rcu_flush()

Vineeth Pillai (1):
rcu: shrinker for lazy rcu

drivers/scsi/scsi_error.c |   2 +-
include/linux/rcupdate.h  |   7 ++
kernel/rcu/Kconfig        |   8 ++
kernel/rcu/rcu.h          |   8 ++
kernel/rcu/rcuscale.c     |  67 +++++++++++-
kernel/rcu/rcutorture.c   |  16 +--
kernel/rcu/sync.c         |   2 +-
kernel/rcu/tiny.c         |   2 +-
kernel/rcu/tree.c         | 140 +++++++++++++++++--------
kernel/rcu/tree.h         |  12 ++-
kernel/rcu/tree_exp.h     |   2 +-
kernel/rcu/tree_nocb.h    | 213 ++++++++++++++++++++++++++++++++------
kernel/workqueue.c        |   2 +-
lib/percpu-refcount.c     |   3 +-
14 files changed, 388 insertions(+), 96 deletions(-)

--
2.38.0.rc1.362.ged0d419d3c-goog

