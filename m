Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA926F6735
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjEDIYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjEDIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B07DA4
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683188221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StIZClLvWq1Og9t6DHx1Hzd3Kvv2y6bvz7gxny+91MY=;
        b=II0Ibw0PPn0yVI7pXaXFElYZ/+ynqDmX3efa6Aly98Z4IvSwzsKH11mMsCrPOI5ptiWd9P
        bN8soeX/uxz0OUeL1oWoQzA2EIQQiXcorOjvpAU8BBFXlU+5XRLEqj6g3NSzZL5hAXlPaW
        3Jz6ZO1NyY4/179MgcYZFOSTsjEif1c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-dLr9fYovPZG70OpQF6nMAg-1; Thu, 04 May 2023 04:13:43 -0400
X-MC-Unique: dLr9fYovPZG70OpQF6nMAg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3062e5d0cd3so31374f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188022; x=1685780022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StIZClLvWq1Og9t6DHx1Hzd3Kvv2y6bvz7gxny+91MY=;
        b=A7eLS3+jkK3T+IPU6Y96WD2Zc8jPqG+05qmxF3riYZkrn6zWgNDDC5fg6MQGjZ13js
         PW/y93cQRfbv48L7UZpzknipcIJRcJjbfyaWt/fQ30gb/MAmiOsVvyRU5nnqu70s/oz7
         6MphJ/qnupfpjh+ZKmCvthdqPfZrcvUjWQZP4hGR4aqJ5ZM/0SnebdZ2aj4Cf7QwBaBp
         Yhinic+gfAUhed2CWuL5JA+oOxoANe0RTBIsmFgmTD2xtGr4Wqsch2bwpZsIn2rfTazM
         ms66ccGnAZ+wv5fAkUIkiLjd6x3h1BKsnoeFABlswlUZ7Vtm1QmWxXIJK4g10RKnHwCT
         d2cA==
X-Gm-Message-State: AC+VfDws5KaG0+Mc8mUFvxT8XDWZ6AVZ2Wbhrk9YUyc2c0I766oAyJsF
        Ak7k6XRktb57Ln4K34oXQyfUlzyh1fzRaKwBKN+pvAjpdobPN6YkA7yVdvaC65hDCpTfPZUb4Om
        JUJwGn2fJpfqKKEsYGRNzDUXN
X-Received: by 2002:a5d:420a:0:b0:306:b48:3fc4 with SMTP id n10-20020a5d420a000000b003060b483fc4mr1824562wrq.31.1683188022266;
        Thu, 04 May 2023 01:13:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6knmugZZ6j26dT1v2A0BMTbke1qENWBnpQ3CFgVVDPYEx3RlyJjucKmZv0kjkFf+iXpUNLBQ==
X-Received: by 2002:a5d:420a:0:b0:306:b48:3fc4 with SMTP id n10-20020a5d420a000000b003060b483fc4mr1824547wrq.31.1683188021948;
        Thu, 04 May 2023 01:13:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:b121:8011:79a:2d6b:5410:3927:2f38])
        by smtp.gmail.com with ESMTPSA id y11-20020adfe6cb000000b002f81b4227cesm36203234wrm.19.2023.05.04.01.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:13:41 -0700 (PDT)
Date:   Thu, 4 May 2023 10:13:37 +0200
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
Subject: Re: [PATCH v2 2/6] sched/cpuset: Bring back cpuset_mutex
Message-ID: <ZFNpMT+gLbETz8Mp@localhost.localdomain>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
 <20230503072228.115707-3-juri.lelli@redhat.com>
 <20230504061842.GC1734100@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504061842.GC1734100@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/23 08:18, Peter Zijlstra wrote:
> On Wed, May 03, 2023 at 09:22:24AM +0200, Juri Lelli wrote:
> 
> >  /*
> > - * There are two global locks guarding cpuset structures - cpuset_rwsem and
> > + * There are two global locks guarding cpuset structures - cpuset_mutex and
> >   * callback_lock. We also require taking task_lock() when dereferencing a
> >   * task's cpuset pointer. See "The task_lock() exception", at the end of this
> > - * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
> > - * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
> > - * prevent change to cpuset structures.
> > + * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
> > + * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
> > + * structures.
> >   *
> >   * A task must hold both locks to modify cpusets.  If a task holds
> > - * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
> > - * is the only task able to also acquire callback_lock and be able to
> > - * modify cpusets.  It can perform various checks on the cpuset structure
> > - * first, knowing nothing will change.  It can also allocate memory while
> > - * just holding cpuset_rwsem.  While it is performing these checks, various
> > - * callback routines can briefly acquire callback_lock to query cpusets.
> > - * Once it is ready to make the changes, it takes callback_lock, blocking
> > - * everyone else.
> > + * cpuset_mutex, it blocks others, ensuring that it is the only task able to
> > + * also acquire callback_lock and be able to modify cpusets.  It can perform
> > + * various checks on the cpuset structure first, knowing nothing will change.
> > + * It can also allocate memory while just holding cpuset_mutex.  While it is
> > + * performing these checks, various callback routines can briefly acquire
> > + * callback_lock to query cpusets.  Once it is ready to make the changes, it
> > + * takes callback_lock, blocking everyone else.
> >   *
> >   * Calls to the kernel memory allocator can not be made while holding
> >   * callback_lock, as that would risk double tripping on callback_lock
> > @@ -403,16 +402,16 @@ static struct cpuset top_cpuset = {
> >   * guidelines for accessing subsystem state in kernel/cgroup.c
> >   */
> >  
> > -DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
> > +static DEFINE_MUTEX(cpuset_mutex);
> 
> Perhaps extend the comment to state you explicitly want a mutex for PI
> etc.. ?
> 

Sure, can do that.

Thanks!

