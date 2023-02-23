Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCD6A0D26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjBWPh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjBWPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:37:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF065849D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:37:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bo30so10441075wrb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NnIfJW+ia5tXB47dYoLWfymiihO68C5rjTJ28mL0oQ=;
        b=KzJ9uTVApzsmUOrTpFzuecBFwKzzUeGwtFIfzuwdHyWMQMAzqeFTotz2G1XVp+yCng
         3AAsmvt+Q9MuCkVI9i8Zf677gJU6rQ4tEigjCn85ifQ4SyOI0Zn3y/7DHL54PMaJqtFs
         YUIdyUJ4tZHXKR1W3XmMPzJgGz8NTNZwp5rpc1/k0SxQ14+EXytXLbr1vQ26jZZdRXkL
         pavKEH9pRsXPUW926Kr3BC1Rxp/zR2YW+lcCfiuoGWD5krMSNYCHx2q/asn5dvnwYKP5
         uLj1n42joqY9bxHqaPSqtOsMJmeOynLsL5WgPW3E/UJoPJS8c/sa/zpL4JbuNOE6FjMH
         0+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NnIfJW+ia5tXB47dYoLWfymiihO68C5rjTJ28mL0oQ=;
        b=bg+sWm8Dl8vQP8PZoWYpYwVtp2V0Y/D07B/+acPx+KAeQvz3MQYu6ssDddL33/UoMk
         /+IqoFEUHQz3jwXnX9g4nvpG6aGfH+8pqhoJBQBe0Ybj9+Kpn4jS4j/nAN6DKcdpsKwN
         wLphnuTTIwYfNDd2f7150EOJsl5vCYZtmcdeMYjnw+0XB/gScKKyjxs21PpJkd1envR1
         VIhAXRc0jZwaS5AAX6PW/i36flkhED36AzIRnctS+HJAPiyKzU+tAtr/ZG03t34av0IA
         /6iyvyEwKMLa/hVlyR1rDrfGRk3jBoc9YhLDualDj+DzQREZ498rzezMZxKbB+o4/N4H
         hEbg==
X-Gm-Message-State: AO0yUKXat9IT8J3cziNfKoetSUpdIk42IW/6GQgqXOml5MPz1CIyQ9Zb
        WDXBajhpLCO9UIQ4ZW1XujWRRg==
X-Google-Smtp-Source: AK7set+B2i5qNq2bk5Aj/IBmD/EoAMtjf0Fip+wxkx1zh3fBncLv2IYfgpvWEhDqM/MscL1Qj40NVw==
X-Received: by 2002:a5d:4206:0:b0:2c3:ea8b:2724 with SMTP id n6-20020a5d4206000000b002c3ea8b2724mr12204563wrq.21.1677166623543;
        Thu, 23 Feb 2023 07:37:03 -0800 (PST)
Received: from airbuntu ([104.132.45.105])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c414100b003e200d3b2d1sm12569276wmm.38.2023.02.23.07.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:37:02 -0800 (PST)
Date:   Thu, 23 Feb 2023 15:37:00 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20230223153700.55zydy7jyfwidkis@airbuntu>
References: <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/23 17:16, Vincent Guittot wrote:

> I don't see how util_est_faster can help this 1ms task here ? It's
> most probably never be preempted during this 1ms. For such an Android
> Graphics Pipeline short task, hasn't uclamp_min been designed for and
> a better solution ?

uclamp_min is being used in UI and helping there. But your mileage might vary
with adoption still.

The major motivation behind this is to help things like gaming as the original
thread started. It can help UI and other use cases too. Android framework has
a lot of context on the type of workload that can help it make a decision when
this helps. And OEMs can have the chance to tune and apply based on the
characteristics of their device.

> IIUC how util_est_faster works, it removes the waiting time when
> sharing cpu time with other tasks. So as long as there is no (runnable
> but not running time), the result is the same as current util_est.
> util_est_faster makes a difference only when the task alternates
> between runnable and running slices.
> Have you considered using runnable_avg metrics in the increase of cpu
> freq ? This takes into the runnable slice and not only the running
> time and increase faster than util_avg when tasks compete for the same
> CPU

Just to understand why we're heading into this direction now.

AFAIU the desired outcome to have faster rampup time (and on HMP faster up
migration) which both are tied to utilization signal.

Wouldn't make the util response time faster help not just for rampup, but
rampdown too?

If we improve util response time, couldn't this mean we can remove util_est or
am I missing something?

Currently we have util response which is tweaked by util_est and then that is
tweaked further by schedutil with that 25% margin when maping util to
frequency.

I think if we can allow improving general util response time by tweaking PELT
HALFLIFE we can potentially remove util_est and potentially that magic 25%
margin too.

Why the approach of further tweaking util_est is better?

Recently phoronix reported that schedutil behavior is suboptimal and I wonder
if the response time is contributing to that

	https://www.phoronix.com/review/schedutil-quirky-2023


Cheers

--
Qais Yousef
