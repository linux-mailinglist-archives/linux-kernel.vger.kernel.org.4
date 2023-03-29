Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16D36CD9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjC2M5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2M5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:57:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB2125
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680094578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bfp+uWRbOwM8a2jDGBZKgrnhrhJwiLY7EtO8YbQJdLo=;
        b=SmrIqzSxRYXn+p3LnuhTdtMpFEpq3odXtWHwTCxMIeM7+72pj5Oq4CuI6c3rT5HUJ3+DSh
        9WLcya6pZjfZx/yj2iia08BzMajcQNxhRp+C25FA4bSlBIDZtoab5YbJviE60OG5F2XIX6
        c86oj7l4I0zUy8t6jTGVIEZnp4iu0Yw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Cv9l92hFM_6nOJfFfE7M6A-1; Wed, 29 Mar 2023 08:56:17 -0400
X-MC-Unique: Cv9l92hFM_6nOJfFfE7M6A-1
Received: by mail-qt1-f197.google.com with SMTP id e4-20020a05622a110400b003e4e915a164so5918477qty.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 05:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bfp+uWRbOwM8a2jDGBZKgrnhrhJwiLY7EtO8YbQJdLo=;
        b=lggYoD8M5xx82RmdxmqzzMe+CcrztsNCdbXez5k2VthFYY2lEIBllio/UwnLp9+gMW
         nDxu+MlARSzKXOxkaYyrvRK+ARngCEWaGlY1FofwnT/4NnasULBJQuemV9tFEBaiwqHG
         EmsNXgRBusW3/x5TDcGClUMbelkaACCcno+0H6HhAeiY8QEvu05Ko5RbdPccr9ZgONbg
         BO6+FBUag74CQUcopwcHP5LWjBlhW5Nj6lM0NcimKu5jHJeje4vL8KweGenPOQGpaGSQ
         S4mG1wBf8OogoI2aOvJ613Ci1kL3BSxxtKhw10hEXEY6O0RSATolLl2iXt7vrZCy+/AV
         1O2w==
X-Gm-Message-State: AAQBX9elbfc4cff0QjYiGLzWccP240TSx69Jdo0vLVtKJUwuglZBvphq
        doZ3mixvPF9BnSO0a7ozlYU5SGpZ4Lmt0HvLrtzazJO7YAGY5EYmHCa/wbY5/jq0jOLA3EMncOI
        6MUfHdIa/uE5fa0z3DvNWaFe4
X-Received: by 2002:ac8:7e96:0:b0:3df:a280:b60f with SMTP id w22-20020ac87e96000000b003dfa280b60fmr3500375qtj.14.1680094576760;
        Wed, 29 Mar 2023 05:56:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZGTLNAqlZFpgluXc9E29WsIGvzo/yoSMfkjUy52AXwYy8t8q4yk5sPGRYXBrERZaZ31OG+dg==
X-Received: by 2002:ac8:7e96:0:b0:3df:a280:b60f with SMTP id w22-20020ac87e96000000b003dfa280b60fmr3500343qtj.14.1680094576443;
        Wed, 29 Mar 2023 05:56:16 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm13527134qke.127.2023.03.29.05.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:56:16 -0700 (PDT)
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
Subject: [PATCH 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth restoration
Date:   Wed, 29 Mar 2023 14:55:52 +0200
Message-Id: <20230329125558.255239-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

To fix the problem

 01/06 - Rename functions deadline with DEADLINE accounting (cleanup
         suggested by Qais) - no functional change
 02/06 - Bring back cpuset_mutex (so that we have write access to cpusets
         from scheduler operations - and we also fix some problems
         associated to percpu_cpuset_rwsem)
 03/06 - Keep track of the number of DEADLINE tasks belonging to each cpuset
 04/06 - Create DL BW alloc, free & check overflow interface for bulk
         bandwidth allocation/removal - no functional change 
 05/06 - Fix bandwidth allocation handling for cgroup operation
         involving multiple tasks
 06/06 - Use this information to only perform the costly iteration if
         DEADLINE tasks are actually present in the cpuset for which a
         corresponding root domain is being rebuilt

With respect to the RFC posting [2]

 1 - rename DEADLINE bandwidth accounting functions - Qais
 2 - call inc/dec_dl_tasks_cs from switched_{to,from}_dl - Qais
 3 - fix DEADLINE bandwidth allocation with multiple tasks - Waiman,
     contributed by Dietmar

This set is also available from

https://github.com/jlelli/linux.git deadline/rework-cpusets

Best,
Juri

1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
2 - https://lore.kernel.org/lkml/20230315121812.206079-1-juri.lelli@redhat.com/

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

Juri Lelli (4):
  cgroup/cpuset: Rename functions dealing with DEADLINE accounting
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h  |  12 ++-
 include/linux/sched.h   |   4 +-
 kernel/cgroup/cgroup.c  |   4 +
 kernel/cgroup/cpuset.c  | 232 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 ++++---
 kernel/sched/deadline.c |  67 +++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 240 insertions(+), 122 deletions(-)

-- 
2.39.2

