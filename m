Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467F561FE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiKGS7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiKGS7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:59:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA424953
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667847497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lm/gLWjRRDByRItdq2DWUDLAYXSuDRiPzJ+nYmQMRws=;
        b=TqJPn4ZndOWNh0XrQrqMH1MhDXIESbznYZLUPwLyegABKYZtnE3RlMCBIHu8dnM2+I37ti
        hdtIHdC9oCR6FgVYqlilB5XG/l98MMjl5BaXamANjwyrhAdMMA6kvkHrkrXsqyi+RdPsV5
        p+fxzPS7ZWHnG52TbgOXueDUo16c+IU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-205-1eVoQbZ8M_-T68ImQ5k3ug-1; Mon, 07 Nov 2022 13:58:15 -0500
X-MC-Unique: 1eVoQbZ8M_-T68ImQ5k3ug-1
Received: by mail-wr1-f69.google.com with SMTP id d10-20020adfa34a000000b00236616a168bso3136031wrb.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm/gLWjRRDByRItdq2DWUDLAYXSuDRiPzJ+nYmQMRws=;
        b=izSaNO7UowQZxPF+d821sl/Vgu+2QLWTrfQZbaTxZkOi6Ioba/ZpqXSHMwef2F2sO9
         z0At5oYYs9yI13uZrwE8sbOv+3FUXsoccKHRN6goVov/dT/pAz/gZ7XlsTFPVFVv1xTP
         KHqSGoxue07AhK7egtMhV5YyjOfq+unhrRkLv7OPHvXSHgMN5qaxZ+eWAIjGRJPj2aCE
         K4oq9ucic91mGs9hqIaRDxPbaoHWTqMvGSie7oZei+kFHAAQA3/MG4TXmQVutQsdXeK6
         ZPw3nLpxr7UvPRPMeA9znYeCZ9lcI7h2sRrrMz6KQvW/Y78AHTyUqIod3uKSrEi6SjPM
         OCew==
X-Gm-Message-State: ACrzQf1bQ+H+nW9LVEyfC2o9S3A7o5ocjcr32awhfUo17XYJlDyRw3mc
        0AI+Hw7DSG85RscGj8vgZ2pGYydZJSfhUOAzkVCrzHUCBMv1jhzJLs5dbTlDyU/4yyDW4Y0LYEJ
        3LUONILRLP96g9EPRSFpHHYVu
X-Received: by 2002:a05:6000:11cb:b0:236:b1ad:7ae7 with SMTP id i11-20020a05600011cb00b00236b1ad7ae7mr31039386wrx.608.1667847494414;
        Mon, 07 Nov 2022 10:58:14 -0800 (PST)
X-Google-Smtp-Source: AMsMyM52tMSdlLMkbGZTC6SNQoV21JG9oWNiepfxffbsAE5SuSpyGnHoJncZUvJ15OtrhWx/KZBNXQ==
X-Received: by 2002:a05:6000:11cb:b0:236:b1ad:7ae7 with SMTP id i11-20020a05600011cb00b00236b1ad7ae7mr31039372wrx.608.1667847494180;
        Mon, 07 Nov 2022 10:58:14 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id v2-20020a7bcb42000000b003cf4ec90938sm8931819wmj.21.2022.11.07.10.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:58:13 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH v2 1/9] sched/uclamp: Fix relationship between uclamp
 and migration margin
In-Reply-To: <20221105192452.e6lgq55uyiij7ecf@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-2-qais.yousef@arm.com>
 <xhsmhy1sqvd0a.mognet@vschneid.remote.csb>
 <20221105192452.e6lgq55uyiij7ecf@airbuntu>
Date:   Mon, 07 Nov 2022 18:58:12 +0000
Message-ID: <xhsmhpmdymw1n.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/22 19:24, Qais Yousef wrote:
> On 11/04/22 17:35, Valentin Schneider wrote:
>
>> > +	/*
>> > +	 * We must use capacity_orig_of() for comparing against uclamp_min and
>> > +	 * uclamp_max. We only care about capacity pressure (by using
>> > +	 * capacity_of()) for comparing against the real util.
>> > +	 *
>> > +	 * If a task is boosted to 1024 for example, we don't want a tiny
>> > +	 * pressure to skew the check whether it fits a CPU or not.
>> > +	 *
>> > +	 * Similarly if a task is capped to capacity_orig_of(little_cpu), it
>> > +	 * should fit a little cpu even if there's some pressure.
>> > +	 *
>> > +	 * Only exception is for thermal pressure since it has a direct impact
>> > +	 * on available OPP of the system.
>> > +	 *
>> > +	 * We honour it for uclamp_min only as a drop in performance level
>> > +	 * could result in not getting the requested minimum performance level.
>> > +	 *
>>
>> Why specifically care about OPPs here? Per our CPU capacity model, a task
>> alone on a CPUx throttled to f=fmax/2 and a task coscheduled on a CPUy with
>> RT/DL tasks and/or IRQs such that cpu_capacity(CPUy) = 50% are both getting
>> (roughly) the same performance level.
>
> Depends how you define performance level. What you call performance level,
> I think is better called bandwidth. Uclamp is a performance and not a bandwidth
> hint.
>
> If a 10% task:
>
>       p->util_avg = 10% * 1024
>
> is requesting max performance level
>
>       p->uclamp_min = 1024
>
> This will translate to running at highest frequency and in case of big.LITTLE
> system, the biggest CPU too.
>
> RT/DL pressure has no impact in the task being able to achieve this; that is
> running at max frequency and biggest cpu.
>
> If the cpu has no bandwidth to fit this task, then our usual comparison of
> util_avg with capacity_of() should fail as usual.
>

Ok so we *do* have this with how the fitting criteria are combined (I
didn't get that when I first scanned through the code); thanks for
elaborating on that.

> In the example above, the RT/DL pressure has to be pretty high for the 10% task
> not to fit from bandwidth point of view. Which has nothing to do with
> uclamp_min.  Only thermal pressure which drops OPPs can actually affect the
> uclamp_min hint/request.
>
> That is, when the task runs it will run at maximum frequency regardless of the
> RT/DL pressure. The fact that the bandwidth of the CPU can be stolen has
> nothing to do with uclamp_min hint.
>
>
> Thanks!
>
> --
> Qais Yousef

