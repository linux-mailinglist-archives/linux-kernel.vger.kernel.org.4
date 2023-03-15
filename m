Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46E66BBA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjCORLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjCORLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:11:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729139BBB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678900260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shMiUju0CLJ7Dpi4MvVas/gIt/IesSMILI0VOCkmlZA=;
        b=dDQ7u9b7gdCU13FJnFPiVpb5t4aA/6VnC8hi7UZSqmA3JerqqVGJaDAk1Lyvq/jyu+h2Tt
        Tnv6Q/TUSxh3MxZ5nx0fAruGWhLkSGb7OAL4qgWL7Toq/WwLDqJrJvJN8OHWcjYiQbRwuc
        LbqBigDdvkFtI2kOLIzj4wxnvVTk4Fs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-ZBT5Nf-5NEq6kZ_oWndp_Q-1; Wed, 15 Mar 2023 13:10:59 -0400
X-MC-Unique: ZBT5Nf-5NEq6kZ_oWndp_Q-1
Received: by mail-wr1-f71.google.com with SMTP id o15-20020a05600002cf00b002c54a27803cso3456206wry.22
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shMiUju0CLJ7Dpi4MvVas/gIt/IesSMILI0VOCkmlZA=;
        b=pjNuLoXQMWFv0bIeX4BcRgc4n8etH4LycSZ0H1YnGk8sMo9ax72jcECjlWtBVe5/kl
         iCQPqd2z2tZHR9dBqXVsDfMFoFqqCwTAGtw6gBjjUM8w0MmGXUeSUMy6B3dT1/gZXCuL
         W0hoxi8M3B1YF5icVxv/cW/dU1PgXW7UZJ45MNpKdTCVUOBeNGn8bWO6Gunv+MZ/RpCE
         6hi/bygqIfL7lxW0USvW/V7TcY1/GAH5gurxBNF5YXIOEH2bXqXTXSGsTBeYdtHAAedI
         wqcB4Q8B7sKR3bXz8gw5aZxVa/mtRzmN4L7C8YZPNDk3GTC9Nkxsm+xdDjVVCWdxErx9
         iaNQ==
X-Gm-Message-State: AO0yUKXc6CIULZh+4UCrNHgYYEhZjmNtJT/k4UGPyPWG//bplIUMcpfx
        j44bCTlgS0xnsIHhHGWaVbSVNHHljaeYgX8W7tj4lWZl7169Q4TpqtgyH0EGlWf11cpN8cKbroV
        2gOzrMh7+Yo2xTB3Ygtugnb5v2NhXEvvsChc=
X-Received: by 2002:adf:ea87:0:b0:2c7:ce2:6479 with SMTP id s7-20020adfea87000000b002c70ce26479mr2370384wrm.40.1678900257801;
        Wed, 15 Mar 2023 10:10:57 -0700 (PDT)
X-Google-Smtp-Source: AK7set8SE+RCVomXOSJQTIXC1N4nwLboauC8hgQoizKqO3m87jIOgxi0/pgrflWXydDBwNRaSCAbMw==
X-Received: by 2002:adf:ea87:0:b0:2c7:ce2:6479 with SMTP id s7-20020adfea87000000b002c70ce26479mr2370365wrm.40.1678900257433;
        Wed, 15 Mar 2023 10:10:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b002ceaeb24c0asm5149126wrt.58.2023.03.15.10.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:10:56 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:10:54 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
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
Subject: Re: [RFC PATCH 0/3] sched/deadline: cpuset: Rework DEADLINE
 bandwidth restoration
Message-ID: <ZBH8HqFoO8j44SVx@localhost.localdomain>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315145514.vjoypwadprvpgwam@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315145514.vjoypwadprvpgwam@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/23 14:55, Qais Yousef wrote:
> On 03/15/23 12:18, Juri Lelli wrote:
> > Qais reported [1] that iterating over all tasks when rebuilding root
> > domains for finding out which ones are DEADLINE and need their bandwidth
> > correctly restored on such root domains can be a costly operation (10+
> > ms delays on suspend-resume). He proposed we skip rebuilding root
> > domains for certain operations, but that approach seemed arch specific
> > and possibly prone to errors, as paths that ultimately trigger a rebuild
> > might be quite convoluted (thanks Qais for spending time on this!).
> 
> Thanks a lot for this! And sorry I couldn't provide something better.

Ah, no worries. Actually still have to convice myself what I have it's
actually better. :)

> > 
> > To fix the problem I instead would propose we
> > 
> >  1 - Bring back cpuset_mutex (so that we have write access to cpusets
> >      from scheduler operations - and we also fix some problems
> >      associated to percpu_cpuset_rwsem)
> >  2 - Keep track of the number of DEADLINE tasks belonging to each cpuset
> >  3 - Use this information to only perform the costly iteration if
> >      DEADLINE tasks are actually present in the cpuset for which a
> >      corresponding root domain is being rebuilt
> 
> nit:
> 
> Would you consider adding another patch to rename the functions?
> rebuild_root_domains() and update_tasks_root_domain() are deadline accounting
> specific functions and don't actually rebuild root domains.

Yep, can do.

Thanks,
Juri

