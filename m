Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192456FFB68
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239330AbjEKUlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjEKUk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:40:59 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C964128
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:40:57 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-546ee6030e5so4402006eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 13:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1683837657; x=1686429657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HF4n4y/GeCCM6obESYiThOANt4aesbUOtUb4gH3800w=;
        b=hI0rhREHz7mQ0acrixIxJoOcmRpYu/9CgsJ3Qb4xo3NgbEi9So7RMGD6T9eJfTiMBT
         IzbjlEup87w8QCsQPhg/CfXpQWvPuhfWn+tO6qjDh5YejWLKjWnWb3ez3tZ5GVXs5VnL
         kgIwNR1ozUJwPUG2kulmN5CEuXhgDF94WjFhfd/HqvS8K6mIBBstZZ8svcVs/5aUL+FI
         5aZa2ffTOgdRR4q5r0qOUO56KwoYJw77B2e+vrf8II7tC5NltH6lB8S8Hp4cLiKIMS8V
         8WFkD3oIQzkkv4GgLHPwVTIATQnEnKHBHcLq3U9MgLCmT3PWuafmKzv9uDcPrdJteWPP
         YP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683837657; x=1686429657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HF4n4y/GeCCM6obESYiThOANt4aesbUOtUb4gH3800w=;
        b=GHpFOygPWF+GaIR39y3fwUlhj8Nmu7k2tLZSr804KT27bz/8MCQIOz8XBWgr6pKbVZ
         sy5bvhB6Hnv62Dqm2fy+CZFj3GDgwRjH476PoqnYeRcx5BwVeMUBnJG1vgigCywd/3Xe
         dSwR/DQa0wkTDzt9/3B37OzTvUS0sVF976u+n6LF7JLgeNGCgSM4SRJzb1dVKHyhSUlO
         YEY1O6SBVEytlm4vgr9wlWEpG+Qka0zFPAoUdkYRh9UsZ+NXS5kHgANDALL4Qdv44HEe
         DyBwRiNGjCwJXSTAAiB/FOdcNp3JrrCimUo8CQgbUt2ptevz99qcYtLcbIVePTQjPvzZ
         lb+w==
X-Gm-Message-State: AC+VfDy4lgHH66rlPvOWiZAVgCEVIhJQWrIzNqTwKleBpj6eGt1aEmu4
        levuOuItp2j3onGYgdf45SzaK7zkBwwPmTXGNJJmZw==
X-Google-Smtp-Source: ACHHUZ5Szow/NJ7Cu3BIYjly279f1dMTGKvorFrSpX63B2R+I+6xnjEAWsSFp9WFhylPlNalzeGE0loBWPzSwNY+MpM=
X-Received: by 2002:a4a:ea06:0:b0:54a:65e7:9b51 with SMTP id
 x6-20020a4aea06000000b0054a65e79b51mr5995029ood.8.1683837656891; Thu, 11 May
 2023 13:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230508160829.2756405-1-vineeth@bitbyteword.org>
 <20230509132534.09098acc@luca64> <CAO7JXPhrqKWfsp860rRmEenxARi8U2gNMGsOn4m+aKporWwBcg@mail.gmail.com>
 <20230509224829.2fb547fd@nowhere> <20230509225417.61d36733@nowhere>
 <CAO7JXPhk5qbz9kmiu9WuXS+gXCt9+X8pP2c37hd9ChByLmXYjA@mail.gmail.com>
 <20230510090735.68f62cd4@nowhere> <CAO7JXPg03f2YnrmzoGjfHEZZcoN55cU7uVukMw31Bw3x6nnaMw@mail.gmail.com>
 <20230511093711.2be82409@nowhere> <CAO7JXPiKLFLVpqDKoRdu8c2Yd4AJ_2B2UyXJxD3kJAyiJ=n0_Q@mail.gmail.com>
 <20230511220336.05866e80@nowhere>
In-Reply-To: <20230511220336.05866e80@nowhere>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Thu, 11 May 2023 16:40:46 -0400
Message-ID: <CAO7JXPg9K4MA7H63Num8-BHBT-Y=GQ3BnEEvaEMVKmYsXCY7Sg@mail.gmail.com>
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

> >
> > I felt that, since we are using sequential reclaim mentioned in the
> > paper and we isolate all parameters per-cpu(except for extra_bw) we
> > could use the "-dq = -(U/Umax) dt" equation as it was simpler than
> > equation (3).
>
> This is the part I am not sure about...
>
> Maybe the best way to go is to split the patch: first you implement (1)
> (and use div64 to remove the approximation I used), then you implement
> (3) in a second patch.
>
> Finally, if removing the max{} is really needed you can do it in a
> third patch (but I would try to go with Equation 3 before removing the
> max{})
>
Sure, I shall split the patch. Joel also suggested splitting the patch
and I was probably wrong to think that the patch was simple to be a
single patch :-).

Since equation (3) has theoretical backing, I am perfectly fine with
using it for our fix. Will have 2 patches as you suggested.

Will get the v3 out soon..

Thanks,
Vineeth
