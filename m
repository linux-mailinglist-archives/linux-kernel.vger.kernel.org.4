Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D26B1091
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCHSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:02:13 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B4C6429
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:01:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m6so22425873lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678298518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JW16/7HROPrY7sG+XY15f3ILb1+GdtODQdoPZpSAjd0=;
        b=p8uuCaYyc2Vtp48NB7y2HfkN7dWAnEEpVZGu2O9NKUAvP0AjRLg9zep9eCFVxr6mwa
         2AiwpTpfFp6K5hForLvj493KdKVU/T42/qjl+ljB/33re+vGfElGYognORCyTWPwgzE3
         778ueCAJ/DhJOSOW73K1VzFNQ4ZVpD50CgsUPRYmzKZxsF+ENXu2bHNeapsoJLhk48w5
         46fRZE4S9CVI9Sclz9y/BJlOo7mK0L6/OyPOIQnsV+Ban2T4WeyFKK+jVvvyfZqz66Vd
         yu8KgXGjGB738+nIE8JzPAGKJ4eUmByB47amw4SlflNFGAyhOdBC/bKE+3Zz4NlYB0Nv
         Uqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678298518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JW16/7HROPrY7sG+XY15f3ILb1+GdtODQdoPZpSAjd0=;
        b=0J19j9tYmMsrVWV02hnQmb3v4V3plNaY/nzHD9YwXnQepxUgXMRULYe0v3+GnHnYZ/
         +u2wfWU53eAQrz7UWungUeOQ1VPyylG3sCJcN8tMVKOCMv/dC+DoK8hO/U/RZSYFwzQ3
         ixzaQEiJVHMOUYSk3ckM5oBXcdHgeYKBpOh8ObbH78ALsELDVsEJ3Dx6NwxLfadE2i2n
         8v1F/DaPN+juQ03nKThFKCAU2BVC2UhyJEQMW4CL5i7Pw3VKyPNHB7pGWAz049lvmbqJ
         lRdZnSEQsfQeH+lbPVMJ7UrcHMXABY+MuEeEmeT2NEYQsiemPyQbWudGfjs/VVBWLKTV
         9SKA==
X-Gm-Message-State: AO0yUKXG95/cBVOQfjfMk8BuYv1lLuF6WjVn8J3N1vczzVnZYBMlLvKY
        MQ/79Gh0Q7INMeSdH5TsgWcXMFoA54uk1G69A+417g==
X-Google-Smtp-Source: AK7set8XMk0yMcr3YwfojXi89ZqLCBP6A5pyagZXJf9LUfh7i7FUm5ihqT5OIVu/ahNQLZxSiAbG3BnwlgWx8LjyC+A=
X-Received: by 2002:a19:7506:0:b0:4e0:822f:9500 with SMTP id
 y6-20020a197506000000b004e0822f9500mr6005290lfe.12.1678298517882; Wed, 08 Mar
 2023 10:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20230206221428.2125324-1-qyousef@layalina.io> <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com> <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com> <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain> <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain> <20230301170322.xthlso7jfkixlyex@airbuntu>
 <ZAhhGi55BkYkc3ss@localhost.localdomain>
In-Reply-To: <ZAhhGi55BkYkc3ss@localhost.localdomain>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Mar 2023 10:01:44 -0800
Message-ID: <CA+khW7hmE0tECG2qfKW1HN9yLVOLUn5Zzx4Rz-wHYDtSUPYotw@mail.gmail.com>
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on suspend-resume
To:     Juri Lelli <juri.lelli@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 2:20=E2=80=AFAM Juri Lelli <juri.lelli@redhat.com> w=
rote:
>
> On 01/03/23 17:03, Qais Yousef wrote:
> > On 03/01/23 15:26, Juri Lelli wrote:
<...>
> > > BTW, do you have a repro script of some sort handy I might play with?
> >
> > Sorry no. You'll just need to suspend to ram. I had a simple patch to m=
easure
> > the time around the call and trace_printk'ed the result.
> >
> > I was working on a android phone which just suspends to ram if you turn=
 the
> > screen off and disconnect the usb.
>
> Looks like I could come up with the following
>
> https://github.com/jlelli/linux.git deadline/rework-cpusets
> https://github.com/jlelli/linux/tree/deadline/rework-cpusets
>
> which I don't think it's at a point that I feel comfortable to propose
> as an RFC (not even sure if it actually makes sense), but it survived my
> very light testing.
>
> Could you please take a look and, if it makes some sense in theory, give
> it a try on your end?
>

Hi Juri,

Thanks for coming up with the RFC. I can test your changes in the
server environment. I observed the same issue on my side and I can
reproduce.

I sync'ed up with Qais offline earlier yesterday, and was preparing a
couple of patches that optimize the cpuset.cpus writes. Tracking dl
tasks in cpusets is one of them. But I am happy to take your patches
and do the testing. Note that I won't be able to test the dl part of
the patch, only the latency impact on rebuild_root_domains(), as we
don't have dl tasks in our system.

The other patch is fixing cpuset_rwsem. I see you switched it back to
mutex. I did observe performance issues with cpuset_rwsem. Basically,
using percpu_rwsem generates very very long latency tails for writers,
but mutex doesn't. After some debugging, I found it was because
percpu_rwsem requires every writer to call a synchronize_rcu() for
acquiring the lock. So in my patches, I disabled the fastpath of
readers for cpuset_rwsem. This has been done before[1]. But mutex also
worked.

Anyway, I'm happy to test your patches and ack once they are sent out.

[1] https://lore.kernel.org/all/20160811165413.GA22807@redhat.com/T/#m13ef9=
a728c89cccc9c02af3c96924096c76162a5

Hao
