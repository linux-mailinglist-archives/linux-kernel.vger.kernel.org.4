Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31DE728FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjFIG2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFIG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:28:34 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B211FE9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:28:33 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1a28817f70bso418513fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686292111; x=1688884111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs7JyXplXGj0HwZiC3f6ccM5H1CZpgXKFr/b8EsNDVo=;
        b=Po8O2o2wawo1Ot0f4749T8c6N9iX4fBtBg8WV0ga/zLL6Cx7rOxI7DdgeOpLjskm3y
         kXNCikt+27mfLyoys0n5AAibNQ19ksmfUevDgs1sxLdK3IeXak3xYpzHVsz/SBWQT/Qi
         AJ3xi3V99D6JZGdPYgwVTNzfAvLW9vjPjKb4QOry/6nE5nYhUSqG1TLxosAb/LdcXzi+
         yhZ0kxDUwy/BvirR20HC2Ut6BqdJzHXkR5vuFstkK3QcB80nn8oE60J3R7QzEWeIQjwG
         fqwCWbSnD/En+7aVt+VIVFyfsSSilM+b5hDE9Wtw9MPQ/DvKekDY3CfdZGZ1SGv+6j4E
         eyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686292111; x=1688884111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs7JyXplXGj0HwZiC3f6ccM5H1CZpgXKFr/b8EsNDVo=;
        b=bFOsmMbxd59woGWmu+AMbaLpB1xEPcXHcHc41FBJeMzyE9SFwrWh+VBh0rho+CwiaE
         BHB9xcpjnurKYJQrI+sDLgU6NVPfVhRKrpQhP80sog56e4oucHlpCPyxlzC0+Z7FOaMR
         3h9+8+PGFP55WR5z/xWOZA3KWSt6H7twV7lU0LYCVBuQ/0DPhaebi3QwmHmZc1EOClei
         x3rBLnkK23GyeKGrxQmTlhgh+S6lPhK8DMam5DMgEQu3u9Ar1ZXGYRtdNZFaBpRpJIpB
         T0iRPu/9V1vesMFtt6AGZBZCnsCk+hTnjT967wGU2EZoJ2A75jUpYoqE7LZ3FJ/iEmoP
         IW4g==
X-Gm-Message-State: AC+VfDypstsOb4a33dmFO51lYl7oOmP8MM6uoxwyw2rb4KyBvu1m4gLE
        FAzPpGsFExmECMUsplA9VWCOvV3+D7RlVEWPODE=
X-Google-Smtp-Source: ACHHUZ50HLQYZxbG4EbIqzuXDvhmfkaLYcDlCiWbCyVpaje+FEI8XReFsWQ4mLCa5PEaH4MmFGT7XONhqq50+D7gctM=
X-Received: by 2002:a05:6870:8c2f:b0:19f:5d99:fc75 with SMTP id
 ec47-20020a0568708c2f00b0019f5d99fc75mr625834oab.2.1686292111072; Thu, 08 Jun
 2023 23:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000> <ZIJbvCcaqjzNteWs@slm.duckdns.org>
In-Reply-To: <ZIJbvCcaqjzNteWs@slm.duckdns.org>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Fri, 9 Jun 2023 14:28:19 +0800
Message-ID: <CAEQmJ=gYe=d53HHC1xW_epmPmmddA4J28SHybwGmQzUZgxZovg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        tiozhang@didiglobal.com, fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

// I resend this to put it into the same thread, sorry for the confusion.

> Can you elaborate the intended use cases?

Hi Tejun,

Thanks for your reply! Please let me use myself as an example to explain th=
is.

In my scenario, I have 7 cpus on my machine (actually it is uma, so
queue_work_node
or using UNBOUND do not works for me), and for some unlucky reasons
there are always some irqs running on cpu 0 and cpu 6, since I'm using arm6=
4
with irqs tuning into FIFO threads, those threaded irqs are always running =
on
cpu 0 and 6 too (for affinity). And this would not be fixed easily in
short terms :(

So in order to help async init for better boot times for my devices,
I'd like to prevent
works from running on cpu 0 and 6. With queue_work_cpumask(), it would be s=
imply
done by:

...
cpumask_clear_cpu(0, cpumask);  // actually I use sysfs to parse my cpumask
cpumask_clear_cpu(6, cpumask);
queue_work_cpumask(cpumask, my_wq, &my_work->work);
...


> The code seems duplicated too. Could you do a little refactoring and make
> they (queue_work_cpumask() & queue_work_node()) share some code?

Hi Lai,

Thanks for your advice!

I do the refactoring in PATCH v2, there are some changes:
1. removed WARN_ONCE in previous code
  1). queue_work_node works well in UNBOUND since we have unbound_pwq_by_no=
de()
       in __queue_work() to choose the right node.
  2). queue_work_cpumask does not work in UNBOUND since list
numa_pwq_tbl is designed
       to be per numa node. I comment on this in this patch.
2. remove the previous workqueue_select_cpu_near and let queue_work_node() =
use
    queue_work_on() and queue_work_cpumask().

I test this patch with 100,000 queue_work_cpumask() &
queue_work_node() with randomly
inputs cpumask & node, it works as expected on my machines (80 cores
x86_64 & 7 cores ARM64
& 16 cores ARM64).

Please help review, thanks a lot!

Thanks,
Tio Zhang

Tejun Heo <tj@kernel.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=889=E6=97=A5=E5=91=
=A8=E4=BA=94 06:52=E5=86=99=E9=81=93=EF=BC=9A
>


Tejun Heo <tj@kernel.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=889=E6=97=A5=E5=91=
=A8=E4=BA=94 06:52=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 06, 2023 at 05:31:35PM +0800, Tio Zhang wrote:
> > Introduce queue_work_cpumask to queue work on a "random" CPU onto a giv=
en
> > cpumask. It would be helpful when devices/modules want to assign works =
on
> > different cpusets but do not want to maintain extra workqueues, since t=
hey
> > have to alloc different workqueues and set different
> > workqueue_attrs->cpumask in the past times.
> >
> > For now only available for unbound workqueues, We will try to further
> > patch it.
> > And default to the first CPU that is in the intersection of the cpumask
> > given and the online cpumask.
> > The only exception is if the CPU is local in the cpuset we will just us=
e
> > the current CPU.
> >
> > The implementation and comments are referenced from
> > 'commit 8204e0c1113d ("workqueue: Provide queue_work_node to queue work
> > near a given NUMA node")'
>
> Can you elaborate the intended use cases?
>
> Thanks.
>
> --
> tejun
