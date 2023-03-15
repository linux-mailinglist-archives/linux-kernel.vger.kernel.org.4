Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11DB6BB0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjCOMUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjCOMUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFD9008B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678882745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fXppUTug8j7tzXh0MhllF73tJwxX1FkvEF1tk4ChKu4=;
        b=c9xF3/KHUaNc0z4boUNzGG2DBl2zP+JkhafBX++qhFPpcj94zF9AIjUY7Q1rtv+HutwVV3
        BGwykW7J1sbNK5tez6H6hbHBIV55ZE2GocX0MbxfiUDhCE0MN+NMdYj/WR1JQAg/OiHMQ/
        FkrZW0bYfLqp+h9bsU1G/+wr5YVwul0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-xckNC8nIM12_kSY763p-zQ-1; Wed, 15 Mar 2023 08:19:04 -0400
X-MC-Unique: xckNC8nIM12_kSY763p-zQ-1
Received: by mail-qk1-f199.google.com with SMTP id o9-20020a05620a228900b0074585d47b77so5889421qkh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678882743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXppUTug8j7tzXh0MhllF73tJwxX1FkvEF1tk4ChKu4=;
        b=UFCV7FLfbInwTeok+3nJ74KPxMHR92bYb0CLuLdyb4dRZMqCY9J9p9Qvjk2kis0L7u
         SCY7ZilHXkm02CpUWZox7qIIcQdolu6qxn/jwTGFRD1nIf6s+Lt8k6lvtKnDwQzZoviX
         I8JWWtPhTqj+ysX1lT8GQ3vvtlK5ThCzjvx2u40xst/lmc0z76n5PGgaoXZ5BojWlBf3
         8MzVwqKuvAdE/ox9PTQUmIdqZpa8zkzy0FjYvGzstfNBcekTwa7WqajTKwONGGWzuQJD
         ZUVdYaEZIO2KTur1C6uQd3q2XSZJhik9bkvCCaec8PeE+D7pBseR05k/phg7HPzSUEEB
         j90A==
X-Gm-Message-State: AO0yUKUSbm3kJZBIR7iEwuV+y7fuGnbprEOhAiCI4L7hEHd47fD2Uih4
        km+3ksCc7nczvYcsdiV+s0JuE8ZbgB85by88Nr9WKuyMu1fR5jUTP3ynMd0DSRjmc18qtWaVwRU
        nefOwi0C/YKIVjjKWnxsFCgeQukniulHWi0A=
X-Received: by 2002:ac8:5f88:0:b0:3bf:daae:7f24 with SMTP id j8-20020ac85f88000000b003bfdaae7f24mr38976743qta.34.1678882743710;
        Wed, 15 Mar 2023 05:19:03 -0700 (PDT)
X-Google-Smtp-Source: AK7set8DFaytqfR4AZ7VOdiVhG3zgN+t7wiROv/kG8aBsJKjlwT4z/JzawdGYnSKspEcO/qLUe8EQg==
X-Received: by 2002:ac8:5f88:0:b0:3bf:daae:7f24 with SMTP id j8-20020ac85f88000000b003bfdaae7f24mr38976708qta.34.1678882743405;
        Wed, 15 Mar 2023 05:19:03 -0700 (PDT)
Received: from localhost.localdomain.com ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8014b000000b003bd21323c80sm3672595qtg.11.2023.03.15.05.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 05:19:03 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] sched/deadline: cpuset: Rework DEADLINE bandwidth restoration
Date:   Wed, 15 Mar 2023 12:18:09 +0000
Message-Id: <20230315121812.206079-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

To fix the problem I instead would propose we

 1 - Bring back cpuset_mutex (so that we have write access to cpusets
     from scheduler operations - and we also fix some problems
     associated to percpu_cpuset_rwsem)
 2 - Keep track of the number of DEADLINE tasks belonging to each cpuset
 3 - Use this information to only perform the costly iteration if
     DEADLINE tasks are actually present in the cpuset for which a
     corresponding root domain is being rebuilt

This set is also available from

https://github.com/jlelli/linux.git deadline/rework-cpusets

Feedback is more than welcome.

Best,
Juri

1 - https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/

Juri Lelli (3):
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h |  12 ++-
 kernel/cgroup/cgroup.c |   4 +
 kernel/cgroup/cpuset.c | 175 +++++++++++++++++++++++------------------
 kernel/sched/core.c    |  32 ++++++--
 4 files changed, 137 insertions(+), 86 deletions(-)

-- 
2.39.2

