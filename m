Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019466FA1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjEHIAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjEHIAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128101FAB6
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0yjjpMvZRxZ04Sc5RGeV40FbrumDYGW5whlq7sLnsds=;
        b=RXRh5E/Qxb3g8UVNwqyIJBuywIcoBQVaL+Ov4FddxxezAYvMUpBpEJNF/gQZsd8Xbg/uOM
        qW3c2qZVPeBRCEF4SDBZsg1Jz/RygsFhFqAb+JFhRXOHO/5DpejUxD/3YO7Nnmf5JtrCBE
        Juq6U4ii+zJE1bojxXSnx+Apc7mFCqw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-3AKCxenXPG-JbqzO1BV_qg-1; Mon, 08 May 2023 03:59:09 -0400
X-MC-Unique: 3AKCxenXPG-JbqzO1BV_qg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f41efd04dfso8449755e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532748; x=1686124748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yjjpMvZRxZ04Sc5RGeV40FbrumDYGW5whlq7sLnsds=;
        b=iS2Rjw9MaBFLONr6Qaw8y94eBtzmLDxpX4XgmwY/m1NhlkBozW/n6F/DWauUbIW/QE
         4sX0d35TRd++ColNgbxhg9Vt8PVcXiP5l6oIFlDD0ez07ljpd1NRgbFgvNjtPJWhq/on
         /XJ7g82urBvXibQElgGH4ZzUdT2pN7A9u5WCNqxgA2LUOD02Zc4wKU9+8vgJpryKKKIL
         k1KoCMXcobx35Ms8Hamfz6lf4DEMpwFwV7VVrsZL4fqsu4tapZTQkh1SF0uTJo3qq+da
         0NwNdIPWfsEO8tgr2W7lqMCLUNOA+/egC8pG0Hdxt0aXWMWAKLj/nUX11AYdvEAngLcD
         8r4Q==
X-Gm-Message-State: AC+VfDz8H+WBL5B3oWY63qYg0hmJLJNjlPtOnw9pRNv61b8Ucm68E6Ku
        CNvMyejH+8xTRi5ZipHidkS6j7h8I/DkCaE0LBRYmEu51QwRBvy8qtk7upSka+kHV3Jbaj1vzZI
        riF+emkioadAj9LqWb623BQEn
X-Received: by 2002:a7b:c5c3:0:b0:3f3:2ba9:94e1 with SMTP id n3-20020a7bc5c3000000b003f32ba994e1mr6171413wmk.25.1683532747870;
        Mon, 08 May 2023 00:59:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DSFBAUNLjj3rTwoASsPZbj9hYXrXBFrluMZpr49toKIIVxr6ZbwXHQTd+xcH5FBfSweYTPA==
X-Received: by 2002:a7b:c5c3:0:b0:3f3:2ba9:94e1 with SMTP id n3-20020a7bc5c3000000b003f32ba994e1mr6171393wmk.25.1683532747506;
        Mon, 08 May 2023 00:59:07 -0700 (PDT)
Received: from localhost.localdomain.com ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm250423wmj.23.2023.05.08.00.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:59:06 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v3 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth restoration
Date:   Mon,  8 May 2023 09:58:48 +0200
Message-Id: <20230508075854.17215-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qais reported [1] that iterating over all tasks when rebuilding root
domains for finding out which ones are DEADLINE and need their bandwidth
correctly restored on such root domains can be a costly operation (10+
ms delays on suspend-resume). He proposed we skip rebuilding root
domains for certain operations, but that approach seemed arch specific
and possibly prone to errors, as paths that ultimately trigger a rebuild
might be quite convoluted (thanks Qais for spending time on this!).

This is v3 of an alternative approach (v2 at [4]) to fix the problem.

 01/06 - Rename functions deadline with DEADLINE accounting (cleanup
         suggested by Qais) - no functional change
 02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
         from scheduler operations - and we also fix some problems
         associated to percpu_cpuset_rwsem)
 03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
 04/06 - Use this information to only perform the costly iteration if
         DEADLINE tasks are actually present in the cpuset for which a
         corresponding root domain is being rebuilt
 05/06 - Create DL BW alloc, free & check overflow interface for bulk
         bandwidth allocation/removal - no functional change 
 06/06 - Fix bandwidth allocation handling for cgroup operation
         involving multiple tasks

With respect to the v2 posting [4]

 1 - rebase on top of Linus' tree as of today (ac9a78681b92)
 2 - add the 'why' to 5/6 changelog - Peter
 3 - explicitly say that we need to keep cpuset_mutex a mutex for PI on
     2/6 - Peter

This set is also available from

https://github.com/jlelli/linux.git deadline/rework-cpusets

Best,
Juri

1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
2 - RFC https://lore.kernel.org/lkml/20230315121812.206079-1-juri.lelli@redhat.com/
3 - v1  https://lore.kernel.org/lkml/20230329125558.255239-1-juri.lelli@redhat.com/
4 - v2  https://lore.kernel.org/lkml/20230503072228.115707-1-juri.lelli@redhat.com/

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

Juri Lelli (4):
  cgroup/cpuset: Rename functions dealing with DEADLINE accounting
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h  |  12 +-
 include/linux/sched.h   |   4 +-
 kernel/cgroup/cgroup.c  |   4 +
 kernel/cgroup/cpuset.c  | 244 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 +++----
 kernel/sched/deadline.c |  67 ++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 246 insertions(+), 128 deletions(-)

-- 
2.40.1

