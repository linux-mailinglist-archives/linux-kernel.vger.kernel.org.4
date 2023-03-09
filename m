Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE73F6B1BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCIG4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCIG4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:56:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D4A85353
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678344916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIczmgYoQYTCvZV52CjGLXblPTYkMmmzjpWwwvoi3OY=;
        b=i2I1J69pdj3A+SaMK5ArXool6bBnYg5jPvrcS6bMUsa6aTESpA1Bunccmkdq+hJFgrN0cP
        i4R0vXTRVXzxVi3juJLjr2l6FAMzQM14o4sWNCyo24cQp0d21g6c9IO8+OQtDaupSkYtKZ
        uBsKgrBM7cplb+BJhtSi711Phs7/EgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-tdVLZduwP-KLrmBE_dzcOg-1; Thu, 09 Mar 2023 01:55:13 -0500
X-MC-Unique: tdVLZduwP-KLrmBE_dzcOg-1
Received: by mail-wm1-f70.google.com with SMTP id p22-20020a7bcc96000000b003e2036a1516so1973544wma.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678344912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIczmgYoQYTCvZV52CjGLXblPTYkMmmzjpWwwvoi3OY=;
        b=xdFcVTBdW/ZfnSO2jL0DWptQU/N4lvmyzkWDirhJafcY1Yt161ZEDBLk9lpEd3nGPi
         VfhP8aiUCBTJ2Y9SA2S+7k82HHCOQCPfXEDAoIw5n1vC1KoxnlnxrB2rQqFVtmBjTDg/
         QrketO6v5yc0buAJaCADZPuINiVdRr/Qd7gjFagBal832Az0h6ZDPkfySdL6WQOUw45B
         aDzyUs0csV2W4XqNyuguYS03cuEdqWNyy7gU8/hhZviCAtEb4BA9/tA/gqh25YwVmUgK
         mm+HBZ9cfqWuOifNOlrEtBDP0DPLm35iSPADIXUymgfxeDTSZkBe+pj4CSBlAUeX5JeC
         Fq1g==
X-Gm-Message-State: AO0yUKXoOxZVVcxkPiK3t+uAGIbd0Z0ydIg3V2/h0c3bcYv32LQUGpfl
        FJ4Oxtmd9TEVkONxL8JlYhZWNVgCDpy+mBFJjHILUBdfkGodWmIqo1lJrgmpzWZS2j4AnUCvXZf
        l4u7wAnuSHSp1ZeAMhqVC5uXc
X-Received: by 2002:a7b:c84a:0:b0:3df:eda1:439c with SMTP id c10-20020a7bc84a000000b003dfeda1439cmr17144594wml.11.1678344912389;
        Wed, 08 Mar 2023 22:55:12 -0800 (PST)
X-Google-Smtp-Source: AK7set/bfjO/UHYawWvMvflT2aQSWT9oFIwQPchCZihniaflaPBGX8+DCtD/jgOt+kBt3ywllO487g==
X-Received: by 2002:a7b:c84a:0:b0:3df:eda1:439c with SMTP id c10-20020a7bc84a000000b003dfeda1439cmr17144563wml.11.1678344912018;
        Wed, 08 Mar 2023 22:55:12 -0800 (PST)
Received: from localhost.localdomain ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003e21f01c426sm1714588wms.9.2023.03.08.22.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 22:55:11 -0800 (PST)
Date:   Thu, 9 Mar 2023 07:55:08 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
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
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <ZAmCzJQZl7j/m2oN@localhost.localdomain>
References: <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
 <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
 <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

On 08/03/23 10:01, Hao Luo wrote:
> On Wed, Mar 8, 2023 at 2:20 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> >
> > On 01/03/23 17:03, Qais Yousef wrote:
> > > On 03/01/23 15:26, Juri Lelli wrote:
> <...>
> > > > BTW, do you have a repro script of some sort handy I might play with?
> > >
> > > Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
> > > the time around the call and trace_printk'ed the result.
> > >
> > > I was working on a android phone which just suspends to ram if you turn the
> > > screen off and disconnect the usb.
> >
> > Looks like I could come up with the following
> >
> > https://github.com/jlelli/linux.git deadline/rework-cpusets
> > https://github.com/jlelli/linux/tree/deadline/rework-cpusets
> >
> > which I don't think it's at a point that I feel comfortable to propose
> > as an RFC (not even sure if it actually makes sense), but it survived my
> > very light testing.
> >
> > Could you please take a look and, if it makes some sense in theory, give
> > it a try on your end?
> >
> 
> Hi Juri,
> 
> Thanks for coming up with the RFC. I can test your changes in the
> server environment. I observed the same issue on my side and I can
> reproduce.
> 
> I sync'ed up with Qais offline earlier yesterday, and was preparing a
> couple of patches that optimize the cpuset.cpus writes. Tracking dl
> tasks in cpusets is one of them. But I am happy to take your patches
> and do the testing. Note that I won't be able to test the dl part of
> the patch, only the latency impact on rebuild_root_domains(), as we
> don't have dl tasks in our system.
> 
> The other patch is fixing cpuset_rwsem. I see you switched it back to
> mutex. I did observe performance issues with cpuset_rwsem. Basically,
> using percpu_rwsem generates very very long latency tails for writers,
> but mutex doesn't. After some debugging, I found it was because
> percpu_rwsem requires every writer to call a synchronize_rcu() for
> acquiring the lock. So in my patches, I disabled the fastpath of
> readers for cpuset_rwsem. This has been done before[1]. But mutex also
> worked.
> 
> Anyway, I'm happy to test your patches and ack once they are sent out.

Do you strictly need a proper RFC or could you please test the above for
now? If you could please do the latter, and if tests look ok, I could
then put together proper changelogs etc. and propose an RFC (it would
save me some time not to do that if the above doesn't work, apologies
for not going the proper route from the start). Guess this question
applies to Qais as well. Hummm, or maybe you are actually saying that
you are indeed going to test them already, just wanted to make sure
then. :)

Thanks!
Juri

