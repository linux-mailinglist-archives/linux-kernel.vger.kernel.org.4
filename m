Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F086F5132
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjECHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3992D6B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 00:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683098576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IIZ/GCCJmx19uZ3mIOzJAELhL8g2Ju+C9RZzvBPp+14=;
        b=UlD8BqzR8DFk0puuZ5Ptlirl9D9/L/DVHBLKqcTnNFKDtMFfm0OEWH4T5GtMUCkvRBzQHh
        /S6TYuDVcPFEeU8nVxq5NL5ndbqUaZLq1x17aP/CyoAxuBgc6BGT0/wxl/pyPwTIxs/BK0
        TZ5JqXCGle5be3/PRNlx5cJe0CQXp9Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-kBKUc3_rMOO_0ymzOPYMOw-1; Wed, 03 May 2023 03:22:55 -0400
X-MC-Unique: kBKUc3_rMOO_0ymzOPYMOw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3062e5d0cd3so1102380f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 00:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098574; x=1685690574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IIZ/GCCJmx19uZ3mIOzJAELhL8g2Ju+C9RZzvBPp+14=;
        b=KWCXdMgs4eCO6i72oclIYNLkavRJTjFb1RrnFhMSAIzhO/UBdgg/xc2ZgdXRdnFW+y
         VFuWdlY8YxTyzguGo60SiP5cFA1qn+zxx2zHiM3XYet15mmGhQ0ksbXqf344O7cFyyVz
         g68KX2MTPJAxYPi+a9Y7/ZsZpYfsglwviKLoIsBd2yx8XDgWXlkRJQZMJBJzRNFzRpZx
         pDHAh9nDVYnDt2w79BYg2EmTXF9/tnqzHxiNyOaotQ2cJVf5XIlVhX31viEcsgfmJXEU
         QYSYYlb1iLeT87t4JjV3FjBhfQ9YGigx1mWVmYf7w8YQEnuwJNchdhGiyM47XOOlY2yW
         jFeA==
X-Gm-Message-State: AC+VfDw5UUZ7Ad9poU9fUAnF4OFZ9JMyby3QpkNt78qfI+H9Wi5m99iy
        51YpM+xmIxHixy8tqftVpiCppkZDW77auWxPATuCc/lcW3Qa3Pko8FPcOe8uKrh0/ZWeVEmVXMa
        hqJu2MRrtWsVHvMhGRqlceReK
X-Received: by 2002:a05:6000:1191:b0:306:34f6:de8a with SMTP id g17-20020a056000119100b0030634f6de8amr3740011wrx.71.1683098573814;
        Wed, 03 May 2023 00:22:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54zy8/SIcgpOp/BoRmdQDJsXfaF76CBFfxdPQZTW8HUw1yUuPWnpw6k9sR/S7c2WjN63x9jQ==
X-Received: by 2002:a05:6000:1191:b0:306:34f6:de8a with SMTP id g17-20020a056000119100b0030634f6de8amr3739998wrx.71.1683098573403;
        Wed, 03 May 2023 00:22:53 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:b127:8011:7489:32ac:78e2:be8c:a5fb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm947259wmj.39.2023.05.03.00.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:22:52 -0700 (PDT)
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
Subject: [PATCH v2 0/6] sched/deadline: cpuset: Rework DEADLINE bandwidth restoration
Date:   Wed,  3 May 2023 09:22:22 +0200
Message-Id: <20230503072228.115707-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This is v2 of an alternative approach (v1 at [3]) to fix the problem.

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

With respect to the v1 posting [3]

 1 - rebase on top of Linus' tree as of today (865fdb08197e)
 2 - move patch 6 to position 4 - Qais

As the rebase needed some work, I decided to remove the tested and
reviewed bys. Please take another look, just in case I messed something
up.

This set is also available from

https://github.com/jlelli/linux.git deadline/rework-cpusets

Best,
Juri

1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
2 - RFC https://lore.kernel.org/lkml/20230315121812.206079-1-juri.lelli@redhat.com/
3 - v1  https://lore.kernel.org/lkml/20230329125558.255239-1-juri.lelli@redhat.com/

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
 kernel/cgroup/cpuset.c  | 242 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 +++----
 kernel/sched/deadline.c |  67 ++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 244 insertions(+), 128 deletions(-)

-- 
2.40.1

