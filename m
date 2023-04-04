Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B16D6ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbjDDRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjDDRjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:39:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5D1992
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680629886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V+vrMacm8K2usa1pALZTH2tABjT2c2JpiiWSHS5nyhs=;
        b=Yjc7Byg1Qq+BHDJTd9b9h+cjdMYUcs0EUzdVE+XYsOBdzixhd0VsCp7mskCcBLmW6E0Gz8
        nuyeLXtJPWMSBkEBjThw9aUbiA1SvyCBvrK0AcT84H/IvFO9B7vMtrxT/JYK8UWvrQVKw5
        7C+jNto96Yxk+2nDYy1g3RpnjMeasX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-fj2Sq0dyP_q-27E4nNvvWQ-1; Tue, 04 Apr 2023 13:31:56 -0400
X-MC-Unique: fj2Sq0dyP_q-27E4nNvvWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5794100DEB2;
        Tue,  4 Apr 2023 17:31:53 +0000 (UTC)
Received: from [10.22.32.153] (unknown [10.22.32.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 113912027061;
        Tue,  4 Apr 2023 17:31:51 +0000 (UTC)
Message-ID: <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
Date:   Tue, 4 Apr 2023 13:31:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
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
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230329125558.255239-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 08:55, Juri Lelli wrote:
> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
> as it has been reported to cause slowdowns in workloads that need to
> change cpuset configuration frequently and it is also not implementing
> priority inheritance (which causes troubles with realtime workloads).
>
> Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
> only for SCHED_DEADLINE tasks (other policies don't care about stable
> cpusets anyway).
>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

I am thinking that maybe we should switch the percpu rwsem to a regular 
rwsem as there are cases where a read lock is sufficient. This will also 
avoid the potential PREEMPT_RT problem with PI and reduce the time it 
needs to take a write lock.

Cheers,
Longman

