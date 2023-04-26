Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0086EF3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 13:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbjDZL61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjDZL6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 07:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162A49E1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682510257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S6kenneY8yYtvlvRJgCvchvwHXpRVf9tllRS7ez23UU=;
        b=Y/gms4UmJLai4pwPTAIDfwhzwrC1YnRaa70pMrIDthQMJTtIAIlvBLIsLcixb4TNTNNubK
        7FLSzebblPBzjjASQ/LTU7qLyIu075ZyKbC779KF8JJg7VLOYXzJYxCJCnB5oYpL0DHnTr
        5f9St1J/ldW8APCHQZMtJkqEscEolNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-HwsPzAuEMMCMLXVxy_a1NA-1; Wed, 26 Apr 2023 07:57:35 -0400
X-MC-Unique: HwsPzAuEMMCMLXVxy_a1NA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f080f9ea3eso26713585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 04:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682510255; x=1685102255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6kenneY8yYtvlvRJgCvchvwHXpRVf9tllRS7ez23UU=;
        b=I8TcMtnMtZSVXRHKU1xosji0ePM2jHJZGjz2XIFL53yDhLIPuiTZXxqRJvi87qunrN
         6iX4q1XzYq9YNFmKb0e+CNwwTZf+xvdAqQt7BiVmDn2p37B17gNE4R/37kIvOMv/bYVL
         SOMs3vVOCR+emCc/HQ+rRmMef6c9Ee5/dnWAOYj5P32StpjmY16PcdfyBO2lSFGI1l74
         kmSYrboHPAfGVlQ1YvqJdZ9mO87WDu4H+39qfQHIN/0m/NMg8KxQ7EC34m26f+dgAd0e
         17y2Va4bTq1+wGau4NKG7sLXpsmmOLxNqpqCRWK4nE8kWqNFXdJRBMdOuNeyu2rS+opy
         Uzzw==
X-Gm-Message-State: AAQBX9cJhf6fCD44dq7ELOf9Va2Q+KKjSdCSL6iWt3j+XIyLfz3bN3vG
        juugUV2//abKsDXy8tPQLWEheeJ39A6vIHRv6rWcc17zoF0JSRvT18tr0jgHFy93yAZlB7Iiw6w
        1zhHWrjXjwEUJqP2Y1orusMei
X-Received: by 2002:a1c:7211:0:b0:3f1:82d8:8fde with SMTP id n17-20020a1c7211000000b003f182d88fdemr12252876wmc.24.1682510254788;
        Wed, 26 Apr 2023 04:57:34 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZOmeLFYcmstNxqt1xjWV1KznYWVrdJf5TPMIQkF5eKtyG7qBxSJhOp6nb0xf7u++jM0zEkCw==
X-Received: by 2002:a1c:7211:0:b0:3f1:82d8:8fde with SMTP id n17-20020a1c7211000000b003f182d88fdemr12252841wmc.24.1682510254457;
        Wed, 26 Apr 2023 04:57:34 -0700 (PDT)
Received: from localhost.localdomain ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id q17-20020a1cf311000000b003eeb1d6a470sm17806976wmq.13.2023.04.26.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 04:57:33 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:57:31 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <ZEkRq9iGkYP/8T5w@localhost.localdomain>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/23 13:31, Waiman Long wrote:
> On 3/29/23 08:55, Juri Lelli wrote:
> > Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
> > Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
> > as it has been reported to cause slowdowns in workloads that need to
> > change cpuset configuration frequently and it is also not implementing
> > priority inheritance (which causes troubles with realtime workloads).
> > 
> > Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
> > only for SCHED_DEADLINE tasks (other policies don't care about stable
> > cpusets anyway).
> > 
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> I am thinking that maybe we should switch the percpu rwsem to a regular
> rwsem as there are cases where a read lock is sufficient. This will also
> avoid the potential PREEMPT_RT problem with PI and reduce the time it needs
> to take a write lock.

I'm not a big fan of rwsems for reasons like
https://lore.kernel.org/lkml/20230321161140.HMcQEhHb@linutronix.de/, so
I'd vote for a standard mutex unless we have a strong argument and/or
numbers.

Thanks!
Juri

