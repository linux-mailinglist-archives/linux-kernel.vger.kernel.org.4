Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C606F674F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEDI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEDI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFC783FE
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683188341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZvLxR1Wp5CoC9hbAyjph+R2Ym2/yRjyoOOmO1WU7GE=;
        b=dxuXlt6PKxHn70C+vpgYWzzryuxr+4gsl1120MPxRfbWci+gLVJOUAUnkPr4nNEjfCESuu
        5hrM1ePBROvgzNw5fInzZyixBpx6rkmB4z1uOJxtqDN9jfbYz1k/tuqFFE3++iGbzTWlN7
        YtPTCix8pburytH/tWgVG5c+1KhaAJk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-06aOFlQaNAy8nCiUc-B8Pg-1; Thu, 04 May 2023 04:15:24 -0400
X-MC-Unique: 06aOFlQaNAy8nCiUc-B8Pg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-301110f1756so37895f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188123; x=1685780123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZvLxR1Wp5CoC9hbAyjph+R2Ym2/yRjyoOOmO1WU7GE=;
        b=WD9n4pvoTzFHQb6wwI+MlglrMqIn1pG81AmTfQWBZ5WrUOB5DJ8gtvDTqIB7fadAIU
         mgLsf0Vfg6gJHwk6EVkK164YoElOi8udz/tmvc1qNvmMWE4ZIbLuZ5XdkzjW/57KWp2H
         t9infoJqpE/XEQnQ9psKjUGyVquW28Le45YMXSrsl6JlspQqlWVDWeoPQDxYog7+AVtY
         eL6Jc/VKJMOAfRDbo8MbdWRdhBppRSbm36c+0YATR2mr6+wlVzhhBzdNWRz2Ng0IwP8H
         52gBHV2fgyzmoaDquEgDwMwm6ZQ6PwGtjYOy4MluwEjWFX9mP0S+terG/e8k4Nh1zPnb
         Cd4Q==
X-Gm-Message-State: AC+VfDwbCxwtFxp0OGAkUoR/MBo8+OsvfaK6PRAiKovz8rQhE03toIBO
        By6IZHoqeVMNila68w5EktFTIIXeEWMWShyaQG/4NEgO/UEoAUdyogFuwV0rlxj5+FmI5m8oxqs
        kieME2PskGGmy+Qfr215Hre7c
X-Received: by 2002:a5d:63c6:0:b0:306:3163:b5ca with SMTP id c6-20020a5d63c6000000b003063163b5camr1686178wrw.27.1683188122977;
        Thu, 04 May 2023 01:15:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55tQ1hx68OlyFizj8YXdwZmsiranyIiScgBy8bacvwYnqBXfJccLHLfjezOe46OLRSD618Bg==
X-Received: by 2002:a5d:63c6:0:b0:306:3163:b5ca with SMTP id c6-20020a5d63c6000000b003063163b5camr1686151wrw.27.1683188122575;
        Thu, 04 May 2023 01:15:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:b121:8011:79a:2d6b:5410:3927:2f38])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0030631a599a0sm9008142wrs.24.2023.05.04.01.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:15:22 -0700 (PDT)
Date:   Thu, 4 May 2023 10:15:17 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Qais Yousef <qyousef@layalina.io>,
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
Subject: Re: [PATCH v2 5/6] sched/deadline: Create DL BW alloc, free & check
 overflow interface
Message-ID: <ZFNplb0IYONNPtAU@localhost.localdomain>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-6-juri.lelli@redhat.com>
 <20230504062359.GE1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504062359.GE1734100@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/23 08:23, Peter Zijlstra wrote:
> On Wed, May 03, 2023 at 09:22:27AM +0200, Juri Lelli wrote:
> > From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > 
> > Rework the existing dl_cpu_busy() interface which offers DL BW overflow
> > checking and per-task DL BW allocation.
> > 
> > Add dl_bw_free() as an interface to be able to free DL BW.
> > It will be used to allow freeing of the DL BW request done during
> > cpuset_can_attach() in case multiple controllers are attached to the
> > cgroup next to the cpuset controller and one of the non-cpuset
> > can_attach() fails.
> > 
> > dl_bw_alloc() (and dl_bw_free()) now take a `u64 dl_bw` parameter
> > instead of `struct task_struct *p` used in dl_cpu_busy().  This allows
> > to allocate DL BW for a set of tasks too rater than only for a single
> > task.
> > 
> 
> Changlog fails the 'why' test.
> 

Dietmar, if you could please add (or rework) the 'why' as a reply to
this email, I can fold in v3.

Thanks!

