Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC3A6FE1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbjEJPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjEJPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:50:14 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C9040DC
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:50:11 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-18f4a6d2822so45154804fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683733811; x=1686325811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU3otW2nBsPVZDVrYul47MshS8jNhHnlT40CUudsga0=;
        b=nnvKwV0PJ0qt8jo4FYFtGeEo3cYvGbS+5LyAGjOZ6ev7pPjrhSZgC5Fe0eg5nPNpT7
         oa2vcQ21Kpcbmwm7gXIg2lC5cldu5obWDY5ZOtw0Hpvz5WUumQd0BIafvbIjzUDRRPv3
         JDSPlYIadVVwvGt4wC4RMwUThxa6Bv/r82NF5LumgxXX0UgOyAJBR7wW/zCMTB5E5p4U
         v2+nQXlrYolZC/ieOPYoAZN6K9YwKYo4W4zadwrz+4z1VKTQaPVDWyPRumsPgYa9T8t+
         ss7psm/kyavev1Q7TfDBSZ+UjURhvYQACSct0QgprplouBsBNL5/pTWFixY8wUloNbol
         JnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683733811; x=1686325811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU3otW2nBsPVZDVrYul47MshS8jNhHnlT40CUudsga0=;
        b=f6IKs96gXbxwh1fz5ZrRvNwpYtv0dOEz87wjEOqwIyDTdiz+OzufHGfaCw/rrkRMPZ
         Q5Q/JykofiOmVbxcaNC+EZep9DsOjx5GWzqtNlYb0RwRMOe6BxlEcnNTYYNDsvj04MjS
         Ty4Q/qhwBWf8VcDo/fJuy8Yte2AnBxbfOZcD2BZG5t7IlB5ZQJGkKEblCIrp5KkQMky3
         dlVGMLtR12b7g1HlEl7lF0UMId13O01q16abe12M3tk00B0ELPJ/7TkZAuzTJ3obXKTs
         ATwmObZwMMtpr2i8lpg/fbumTGm1Njwpab9+ySBTgiQpEdopB1yZt0pH8gjyJE7TaByr
         IdCQ==
X-Gm-Message-State: AC+VfDx7Jfz2683S6X52YD9meRnmlMDmpkRpD09jm/lQBVacYt5Pwk06
        8mg0VScAbkfcZSHTRE9y98P4tfrQLh1aKH3ALl6D0A==
X-Google-Smtp-Source: ACHHUZ5lT3UppJIuDlKShbqgbtPnge05+c6BxG/OevxBZCHJl3nmekRKwX4qR2nA9ty64aOpRcVMkMnEupFXP5bwhx0=
X-Received: by 2002:a05:6830:6:b0:6a7:bced:411e with SMTP id
 c6-20020a056830000600b006a7bced411emr3308415otp.3.1683733811250; Wed, 10 May
 2023 08:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
 <20230509132534.09098acc@luca64> <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
 <20230509224829.2fb547fd@nowhere> <20230509225417.61d36733@nowhere>
 <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com> <20230510090735.68f62cd4@nowhere>
In-Reply-To: <20230510090735.68f62cd4@nowhere>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Wed, 10 May 2023 11:50:00 -0400
Message-ID: <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/deadline: accurate reclaim bandwidth for GRUB
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Wed, May 10, 2023 at 3:07=E2=80=AFAM luca abeni <luca.abeni@santannapisa=
.it> wrote:
>
> > I was thinking more about this and was doing some more digging into
> > this. I was also wrong about min{}. Giving it some more thought, I
> > think (U/Umax) is indeed the only equation we need and it will take
> > care of caping the reclaiming at Umax.
>
> Uhm... I am not sure about this: for 1 single task on 1 CPU, yes,
> u/Umax does the right thing. But when there are multiple tasks on the
> CPU, I think it can cause issues (because every task ends up trying to
> execute for Umax).
>
Ah ok, I understand now. I was going with the single CPU equation of
U/Umax where this would not have been an issue as U(running_bw) takes
care of the adjustment and does not allow a single task to use whole
of Umax. I read the SMP GRUB paper you shared and see that it uses
u_i/Umax and that might cause issues as you mentioned.

> The "max{}" comes from the original multi-processor GRUB algorithm:
> https://arxiv.org/pdf/1512.01984.pdf (see Equation (13) - in that
> equation, the part we call u_extra is included in Uinact[p])
>
Thanks for sharing. I read the paper and got an overall idea an
background of existing implementation.

> the "1 - u_inact - u_extra" part is needed to make sure that the
> real-time guarantees are not broken by the reclaiming mechanism... But
> it can end up with a task trying to consume too much time on a single
> CPU, hence the "u/Umax" term in the "max{}" is needed to make sure that
> a task will not consume more than Umax of a CPU.
>
> Now, if we have one single task on a CPU u/Umax will always be larger
> than the other term... But when we have multiple tasks the other term
> is needed too.
>
Understood, thanks for explaining.

> (BTW, when considering multiple tasks on multiple CPUs, another
> potential problem is given by u_extra... Now that I remember all the
> details, u_extra is not "Umax - this_bw" - this is true when we consider
> only one CPU, but is is "Umax - sum(u_i)/m" (where "sum(u_i)" is the
> sum of the bandwidths of all the SCHED_DEADLINE tasks in the root
> domain, and "m" is the number of CPUs in the root domain)... So, the
> reclaimable CPU time is distributed uniformly on all the CPUs and this
> could create some issues. But let's see what happens after the div64
> fix and the SCHED_FLAG_RECLAIM fix)
>
This makes sense. This also means that we wouldn't be able to replace
"Uextra + Uinact" with "Umax - running_bw" and I was seeing problems
with SMP testing. So I shall revert to "Uextra + Uinact" in v2. And I
think the potential issue with Uextra would be avoided by the check
for Uextra + Uinact > Umax to make sure that we don't reclaim more
than Umax for a single cpu.

I have tested the patch with SMP using the stressor mentioned in the
commit message and running cyclicdeadline in parallel. The results
are similar to upstream and GRUB able to reclaim upto Umax now.

I shall send the v2 soon after a bit more testing.. Thanks a lot for
all the valuable inputs and detailed explanation :-)

Thanks,
Vineeth
