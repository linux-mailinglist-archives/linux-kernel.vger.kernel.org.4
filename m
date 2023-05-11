Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257796FF983
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbjEKSex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKSev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:34:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29115584
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:34:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ab611e57c2so1028897a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683830089; x=1686422089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eqk34LLf7CtwfQbk/8o6b4YNIAWEXLYt4n8dWqcS5ck=;
        b=LBdVZAm7fx0OMMTmY4JLYUPEsaUsWQlkXbKIK11lGvRxosG8NIsr+iX8dOLHMpD3Vl
         ROCCtj5nN2m2NhyWoLeor+MCXIvxIsRddFPHAInwtIhkJuWpH0S2W6zNB6z+XyddwLUt
         XwrahT14wszgczKY8a4AnBZq32h321FIGDRQdVFIMO+hMQFuhpDhAW63O987g6tp+m9f
         8Dz83dFyCvoQbcEBcz79UFZApDbYpApHKnLZKZ9tQrgyKpzxKXdrf9nRozIrG/lzqPoB
         dMOEAWlfR6TJYbVapjWFYP7uFB4WZ2reB3ls7CCvxlr+Io29Df4Udy9fGmAbxSdaOazZ
         c7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830089; x=1686422089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqk34LLf7CtwfQbk/8o6b4YNIAWEXLYt4n8dWqcS5ck=;
        b=bZ1yVHjv2FMZLdrzF3KEBBXVa9DQ/u2YV0ngBXpWgDKf37jEO49ksFPhuRz/7ycg03
         RHKhhcZvA4boT3vDORtHgcejLiifXiV1ZDVSlTDL7ZQZzIJB5QEgmjH6lOk4Sqy5YmCJ
         wg+Lku+smSpvbgfCtIplaLk5MIikbEwu7Ig+UPz2HqQ5rFrhUxQBJB61m8QLqNP2Y0vw
         4En8tIyldBlZgcEyshjXas5UChLArVvLCxOCH+ALGCwotCLSNETbquSfGsghRSLnrySv
         DXj3IGppIZCr/E2iI/OLVNIM0OzZEatfsPSRqq3zEdW4LnzVBudRZiDg3nsBxMhl+T4Q
         ALNw==
X-Gm-Message-State: AC+VfDz46NxRlTMED1IIUwPdk4bfLTLjFEYrFHT2PRXG3O8CioKESHjT
        VjIkjXn9AE8SsWiMsvo6qhobXkEldGmgdtKWD9lgpqbPLmIPFxwoSVdp3g==
X-Google-Smtp-Source: ACHHUZ5uA60qYdAeSKObEwcECuose51HMLpDsQyqtfXHDIWS+t2Q6r7nIDwJ6HyPNekR99P7VfeBMaHjdmdwu4VnkBo=
X-Received: by 2002:a9d:7d07:0:b0:6ab:82ac:fad8 with SMTP id
 v7-20020a9d7d07000000b006ab82acfad8mr2203405otn.15.1683830089017; Thu, 11 May
 2023 11:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
 <20230509132534.09098acc@luca64> <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
 <20230509224829.2fb547fd@nowhere> <20230509225417.61d36733@nowhere>
 <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
 <20230510090735.68f62cd4@nowhere> <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
 <20230511093711.2be82409@nowhere>
In-Reply-To: <20230511093711.2be82409@nowhere>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Thu, 11 May 2023 14:34:38 -0400
Message-ID: <CAO7JXPiKLFLVpqDKoRdu8c2Yd4AJ_2B2UyXJxD3kJAyiJ=n0_Q@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Thu, May 11, 2023 at 3:37=E2=80=AFAM luca abeni <luca.abeni@santannapisa=
.it> wrote:
>
> I've just seen v2, and (unless I misunderstand something) I see you
> removed the max{u_i/u_max, 1 - (u_inact + u_extra}} thing?
>
> I fear this might break the real-time guarantees provided by the
> algorithm...
>
I am sorry I missed sending more details before sending out v2. So, I
think there is another bug in the existing implementation. Let me try
to explain the details.

SMP GRUB paper has the equation for depreciating runtime as:
  dq_i =3D -max{u_i, 1 - (extra_bw + Uinact)} dt

Since we are caping at Umax, the equation would be
  dq_i =3D -(max{u_i, Umax - (extra_bw + Uinact)} / Umax) dt (1)

But existing implementation is:
  dq_i =3D -max{u_i/Umax, 1 - (extra_bw + Uinact)} dt (2)

Here in (2), we factored Umax only to the first term "u_i" and the
second term in max{} was as left as it is. What do you think?

Now with normal DL and SCHED_FLAG_RECLAIM tasks, equation (1) can be
re-written as:
  dq_i =3D
   -(max{u_i, Ureclaim_max - (extra_bw + Uinact)}/Ureclaim_max)dt (3)

I tested this equation (3) and it works as expected. What do you think
about the correctness of equation (3)?

I felt that, since we are using sequential reclaim mentioned in the
paper and we isolate all parameters per-cpu(except for extra_bw) we
could use the "-dq =3D -(U/Umax) dt" equation as it was simpler than
equation (3). Sorry that I missed discussing this. I shall send out
v3 with equation (3), if you think it's the right way to go to enforce
deadline guarantees.

Thanks,
Vineeth
