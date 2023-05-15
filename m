Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57E7021E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEOC5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 22:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjEOC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 22:57:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC110C2
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ab0c70801dso3192109a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1684119426; x=1686711426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=orD9+oAEHsYM3eHNPXXQ3Z9IvnqViMkDMQitrNknu9k=;
        b=KEOoMxyN2r7qh+SqHJBbCgGFMX1J9rNNC/fls/UUAjXuPD5Qd3aBDFg1vgWVd3xu9w
         biTcYLhFLwk25jhEHZm/aDgyT4kmcaNuykhy4TZZBGlRQHZJ/APbi02ogF3/o7EdyWD+
         Khhy9KWyuKBCqMbCbD9OhC8CePlo8B9bmb7Lz1dr+6ze1Q/6n6FPUyorsQe81nmVt8xc
         2LmDvtp21rDxzpFCMhzQrjE9vg/7ckVoa1QRy79zDTNEKAmSh5VNJzUR8x/SC10hPJex
         15HLKXNMNMIDQacG/rOLyw5sOFJOCmz+Ah/3/dVmXV4iiAohF2v0z+y54spHUL9lDdE5
         0PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684119426; x=1686711426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orD9+oAEHsYM3eHNPXXQ3Z9IvnqViMkDMQitrNknu9k=;
        b=ejYMBncKgpCWR1CAVhHLUiPhHS5v+VF5Vk94FjN/+Xsu6xdzMfQL0cqA0jhybXs+gE
         qM1hY0VuTyJFJ26mGcMpL4zG/gD7TpV5y0Ch8mi2dUb0E9xEXEkC4Xv3AzbVVx/dEad8
         rkx7XyVJ/6g+4opvPHGpl04okrKeLxbZIYUac5fgrduIHXKYpimXcxiCr7XjTEVJqQHH
         zsAhbchDpV+lGuw99TlYsNWGEDfUTAA78IP5YDIK1QYl6HQ5Tu292FpszLVrgXERxOQw
         zHYupzZTfYsB7D26bOaPXmknK1bhrlIBNryVu/7F2qtNMySvz7teYSQwBrXB6eelS0W6
         peWA==
X-Gm-Message-State: AC+VfDzDtqdPf20bkKd0xuZBn8yf7nLN3O0yDIsGqiopQm5AVIebMLRD
        n+IRPc5YZWtxcFtcYrW0w4BExzbhY9UrI+dE6uIa/A==
X-Google-Smtp-Source: ACHHUZ7UR8QzvAdf8bGWfhZR0PDTE58Gd2NNGQFrlqPBckkTMdzBn5HKgBIy0ak7Sy9K9O+x2secKxbxkCA1OnoPayc=
X-Received: by 2002:a9d:6a0d:0:b0:6ab:15c9:b46c with SMTP id
 g13-20020a9d6a0d000000b006ab15c9b46cmr9970194otn.4.1684119426518; Sun, 14 May
 2023 19:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
 <20230509132534.09098acc@luca64> <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
 <20230509224829.2fb547fd@nowhere> <20230509225417.61d36733@nowhere>
 <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
 <20230510090735.68f62cd4@nowhere> <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
 <20230511093711.2be82409@nowhere> <CAO7JXPiKLFLVpqDKoRdu8c2Yd4AJ_2B2UyXJxD3kJAyiJ=n0_Q@mail.gmail.com>
 <20230511220336.05866e80@nowhere> <CAO7JXPg9K4MA7H63Num8-BHBT-Y=GQ3BnEEvaEMVKmYsXCY7Sg@mail.gmail.com>
In-Reply-To: <CAO7JXPg9K4MA7H63Num8-BHBT-Y=GQ3BnEEvaEMVKmYsXCY7Sg@mail.gmail.com>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Sun, 14 May 2023 22:56:55 -0400
Message-ID: <CAO7JXPiYL_1ePxcoH=mvGq05S75jmA3SLjDf=oe0wU4Ozm4hrA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

> Sure, I shall split the patch. Joel also suggested splitting the patch
> and I was probably wrong to think that the patch was simple to be a
> single patch :-).
>
> Since equation (3) has theoretical backing, I am perfectly fine with
> using it for our fix. Will have 2 patches as you suggested.
>
> Will get the v3 out soon..
>
Sorry for the delay. I was testing the fixes and noticed one other
issue and was working on a fix.

This is with the extra_bw for tracking the unused bandwidth in the
system. As you have shown me:
 "extra_bw = Umax - ((Sum of bw of all tasks) / #cpus)"
But I noticed that tracking the extra_bw globally while rest of the
values as per-cpu causes issues with reclaiming especially when we
have tasks with small bandwidth. This is because GRUB tries to
proportionately divide unused bandwidth based on running bw on a cpu.
So even if there is only a single task in a cpu, it reclaims less if
its bandwidth is less.

I think removing the extra_bw and tracking unused bandwidth using
"max_bw - this_bw" should be okay. Since admission control will
guarantee that we don't admit more than the capacity, we should be
good with allowing tasks on a cpu to use max_bw while reclaiming.

With the above theory, the code becomes simpler and is the same as the
v2 patch.
 max{u_i, (max_bw - Uinact - Uextra)}
 = max {u_i, (max_bw - (this_bw - running_bw) - (max_bw - this_bw))}
 = max {u_i, running_bw} = running_bw
So, "dq = -(running_bw / max_bw) dt"

v2 had passed all my tests. But having Uextra broke couple of those
when it came to multiprocessors and after identifying the root cause
and re-writing the equation, everything works now and passes all
my tests. I have more confidence in the above equation as its derived
from the SMP GRUB rule using our max_bw.

Please have a look and let me know what you think about this.

I have the v3 ready with patches split into 5(including doc patch).
I shall post v3 soon after this so that you can see the code changes
as well to have a better look.

Thanks,
Vineeth
