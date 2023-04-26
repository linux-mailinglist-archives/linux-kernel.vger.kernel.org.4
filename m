Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F2C6EF674
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbjDZOcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjDZOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7051772A1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682519474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x0YRJ7TlPoY9IYDWRjmvki/mO0TL+b3mD3tzGtLzoUc=;
        b=FGGwXsJdjZL6AC3t2yAOiFXB86dk4ifPNSwMF4LokYKW35ZK7v3jIX5crX5IwVpWhr/Agv
        CA1u0RV50rXUT4aarKAAtc7zkLVuBGlNVNoBD1msuXWfax6aMq6vkTZ8ZPWPBt8gTvd07p
        cQUbj62HcUYiy/ixIhUWGwfY2Kl4kIs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-D9ROo2oCPAGkjVbd9jNdNQ-1; Wed, 26 Apr 2023 10:31:13 -0400
X-MC-Unique: D9ROo2oCPAGkjVbd9jNdNQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a341ee4fcso836938866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519472; x=1685111472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0YRJ7TlPoY9IYDWRjmvki/mO0TL+b3mD3tzGtLzoUc=;
        b=QCF9Zp5bZeRRxD60foBXFA/yJ8Cky/YqVuAy48sy89fZ3UK/8JbFAXd/+tpKss2Agx
         N5njroF80WilWrBc8OxWiDLL7amKgqXUdy02J5j4sNn49wP/0DY4UNt3YsMlRPUzC0sT
         l4VS6FKfRaJ33y4RQRePtIXpJWNwtldNtXYHGz1LwqKp/Cn0SlQAhFPBg+R1GbpBu+zc
         fC1pmF/vLpByaxmcYPckcRpT9QaCVFGj6t88sG98DvED96eCOQcsXn5TaOpa+O1urSOi
         JoKP7EWPggpWDj3FFw8VDDIskj4xtRLYYcgef2uGxMrM3NRtpn46GnTc0es79BBorOA+
         Bj2w==
X-Gm-Message-State: AAQBX9e8P5yYTbmcoCDeecmYyiyU0857aoohIa3apRvm9am+IFAyzvAS
        cIExPOaxVGozDr8vVLa4nQhrhWrfQlZ2UsVO2BNWpWxw7sGMXrhaIM81t+qF1d/w+Som5530dgg
        jLehzQdu935ncMJstTDz0utd/
X-Received: by 2002:a17:906:5904:b0:94f:928a:af0f with SMTP id h4-20020a170906590400b0094f928aaf0fmr16872069ejq.47.1682519471929;
        Wed, 26 Apr 2023 07:31:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350a2Qx33w3mXxDNQvaU4xmScsVwPkVRXikQ4mXYM/czaQyeimOaj9xmuUVq8rnQ075JBB24M3A==
X-Received: by 2002:a17:906:5904:b0:94f:928a:af0f with SMTP id h4-20020a170906590400b0094f928aaf0fmr16872030ejq.47.1682519471458;
        Wed, 26 Apr 2023 07:31:11 -0700 (PDT)
Received: from [192.168.0.198] (host-82-53-138-176.retail.telecomitalia.it. [82.53.138.176])
        by smtp.gmail.com with ESMTPSA id gj19-20020a170906e11300b0095ec8dfc439sm1548225ejb.166.2023.04.26.07.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:31:10 -0700 (PDT)
Message-ID: <10fdfdd8-06bc-0f35-0fea-e604aa5c103a@redhat.com>
Date:   Wed, 26 Apr 2023 16:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
To:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>
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
        mathieu.poirier@linaro.org, cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-3-juri.lelli@redhat.com>
 <fa585497-5c6d-f0ed-bdda-c71a81d315ad@redhat.com>
 <ZEkRq9iGkYP/8T5w@localhost.localdomain>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <ZEkRq9iGkYP/8T5w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 13:57, Juri Lelli wrote:
> On 04/04/23 13:31, Waiman Long wrote:
>> On 3/29/23 08:55, Juri Lelli wrote:
>>> Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
>>> Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
>>> as it has been reported to cause slowdowns in workloads that need to
>>> change cpuset configuration frequently and it is also not implementing
>>> priority inheritance (which causes troubles with realtime workloads).
>>>
>>> Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
>>> only for SCHED_DEADLINE tasks (other policies don't care about stable
>>> cpusets anyway).
>>>
>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> I am thinking that maybe we should switch the percpu rwsem to a regular
>> rwsem as there are cases where a read lock is sufficient. This will also
>> avoid the potential PREEMPT_RT problem with PI and reduce the time it needs
>> to take a write lock.
> I'm not a big fan of rwsems for reasons like
> https://lore.kernel.org/lkml/20230321161140.HMcQEhHb@linutronix.de/, so
> I'd vote for a standard mutex unless we have a strong argument and/or
> numbers.

+1

-- Daniel

