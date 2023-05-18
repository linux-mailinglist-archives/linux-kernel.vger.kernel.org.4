Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFA5707F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjERLbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjERLag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:30:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5926AE
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:30:06 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3093d10442aso1247207f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1684409404; x=1687001404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1h17sSs+joWo+5DdgNBuj4EX+vCaqVJMhCUM7pb9QI=;
        b=0bOA/Qogy+URrPwpK8Koq0kTlFp3zOxO12nRpF5T5NpS6IJcopa3iFKyJbM7mE45g4
         A5aCLkr4Q4J+Z+V0JcI/V8tmmyw02jMVqAuAycXU3+pRDSz1VQASAtg9E58L9/zyp2zQ
         tuHLcINIxxmby4LFEwVn7fGsEfxhAojablGAjUSx14vH+Zcq8RAEV5dlfvVGVWdwBhIN
         0LGK8a9T3UytvCLadbbDyNAIF/rz0/4FtZjV4O4orqxNe1/m0v/SNbCagBp4oT73s6k8
         0eAXsDupl+pFWfXUsYwL8iLaSG6ZRjNNLLhTWqjfu8hflUl0iyVeH7wwY/9GZzU3KS9R
         Cu6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684409404; x=1687001404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1h17sSs+joWo+5DdgNBuj4EX+vCaqVJMhCUM7pb9QI=;
        b=aSywl3vyiC6AwZknQaZkX4vXJ95OQsTxMp4J410mfsCGoVFLgIQiaHcLliVclI3AIz
         +eW3PzvYfsXItD0ZZGGvHZ1Xnpfvun6Z8CbRPFDn2ExQNE/yCdBjTwBKZqtiugs/vWkH
         ZeYi8czBLrFeVoBdbJkoXAkaNSLPu77YImnJ7FYOq6VJ6luORkyoZYPn0Olj4xuR4ilM
         0+PF+hY2Q9wzk2pogHjAhvmPa5EasI/ZWRpFgtMgqiCzNsXilpWCWTh8LIxota+PVkou
         PNgaGd62BPdnpmBZlAd5uH2NkWN8KFgajh8oD7BoXejnjgGDYe7nCrgbw5LkRd0nVARx
         iTHQ==
X-Gm-Message-State: AC+VfDyo3+vy7ncbT0KKkD3kWqM7gbBoG8/CK/Xau3Pf8iyRAV20r4tt
        GUs11G5J7Z91tQmv9kA7aWm3Dg==
X-Google-Smtp-Source: ACHHUZ538HKpwcCSq6XivDnZaQ8zPkbBrbZoSeiFXg18HnSHTBDxqCfB8eNBq/feEOPaX2xbBSEhVQ==
X-Received: by 2002:a5d:6543:0:b0:307:94b3:47b3 with SMTP id z3-20020a5d6543000000b0030794b347b3mr1071025wrv.38.1684409404216;
        Thu, 18 May 2023 04:30:04 -0700 (PDT)
Received: from airbuntu ([104.132.45.105])
        by smtp.gmail.com with ESMTPSA id c7-20020adfe747000000b002ff2c39d072sm1852346wrn.104.2023.05.18.04.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 04:30:03 -0700 (PDT)
Date:   Thu, 18 May 2023 12:30:00 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/documentation: elaborate on uclamp limitations
Message-ID: <20230518113000.pvboekaba7vspjyn@airbuntu>
References: <20230505152440.142265-1-hongyan.xia2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505152440.142265-1-hongyan.xia2@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC sched maintainers (Ingo + Peter) next time as they should pick this
up ultimately and they won't see it from the list only.

On 05/05/23 16:24, Hongyan Xia wrote:
> The story in 5.2 about util_avg abruptly jumping from 300 when
> Fmax/Fmin == 3 to 1024 when Fmax/Fmin == 4 hides some details about how
> clock_pelt works behind the scenes. Explicitly mention it to make it
> easier for readers to follow.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  Documentation/scheduler/sched-util-clamp.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
> index 74d5b7c6431d..524df07bceba 100644
> --- a/Documentation/scheduler/sched-util-clamp.rst
> +++ b/Documentation/scheduler/sched-util-clamp.rst
> @@ -669,6 +669,19 @@ but not proportional to Fmax/Fmin.
>  
>          p0->util_avg = 300 + small_error
>  
> +The reason why util_avg is around 300 even though it runs for 900 at Fmin is:
> +Although running at Fmin reduces the rate of rq_clock_pelt() to 1/3 thus
> +accumulates util_sum at 1/3 of the rate at Fmax, the clock period
> +(rq_clock_pelt() now minus previous rq_clock_pelt()) in:
> +
> +::
> +
> +        util_sum / clock period = util_avg
> +
> +does not shrink to 1/3, since rq->clock_pelt is periodically synchronized with
> +rq->clock_task as long as there's idle time. As a result, we get util_avg of
> +about 300, not 900.
> +

I feel neutral about these changes. It does answer some questions, but poses
more questions like what is clock_pelt. So we might end up in recursive
regression of explaining the explanation.

I don't think we have a doc about clock_pelt. Worth adding one and just add
a reference to it from here for those interested in understanding more details
on why we need to go to idle to correct util_avg? I think our code has
explanation, a reference to update_rq_clock_pelt() might suffice too.

Vincent, do you have an opinion here?


Thanks!

--
Qais Yousef

>  Now if the ratio of Fmax/Fmin is 4, the maximum value becomes:
>  
>  ::
> @@ -682,6 +695,10 @@ this happens, then the _actual_ util_avg will become:
>  
>          p0->util_avg = 1024
>  
> +This is because rq->clock_pelt is no longer synchronized with the task clock.
> +The clock period therefore is proportionally shrunk by the same ratio of
> +(Fmax/Fmin), giving us a maximal util_avg of 1024.
> +
>  If task p1 wakes up on this CPU, which have:
>  
>  ::
> -- 
> 2.34.1
> 
