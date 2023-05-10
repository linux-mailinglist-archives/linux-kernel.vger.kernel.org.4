Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063CE6FE225
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjEJQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEJQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:08:24 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D41BCA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:08:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aafa41116fso51612305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683734903; x=1686326903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1DDjUTMc5wS8zkB22a4mtsmjrzzirzUBabaUUpQOZw=;
        b=nYauP0do2c3U3efM8Z+jF7KLSgqicBpbneDcE7nUeJQeksc19mfFqbmqGMv63gAzQN
         WrUS1ij5gSaeZ6d/fkF5e0pIiY6lmMlGXtH0eyW1IJ83B30jEsLk3qbWe+jKXxdA12o+
         bBHG9sdMtxiIwCMAybVr7YS2/FnbOZ29yuCm/erq/HGtt+sciXmOltwYMwJubBhcas8y
         tq41nu9XIJ9ysSPGD/kQCqhofujyiq/e0Pf+VoKlyOmouQ6x405XQEeI9JQvy9B2HcL5
         5Lv3tbuks5JXMJeeBaOKlK4onvT/atrI9r0sdNwH8VcK8VgGlxR57ma1wYDrNRqoq06v
         Gmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683734903; x=1686326903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1DDjUTMc5wS8zkB22a4mtsmjrzzirzUBabaUUpQOZw=;
        b=FDCaLDe/GYwBfI6HyLobPyYSNvdVoroLNzjhpeSpQAdWZSV1wSAhPjy/W8KTXweDge
         RJrODxIrlrNEPGx0OQL/EDMdFGK0jjIsfioOEQfzgNUyGBqX+trIfo/EBQysOl9V6yNB
         HVVlmA6nREveMwfy2yYp0FHQ2wO85p361pAozzVwlfCAPZ29Oey2T+wtFrnmuOPh0WLo
         MsdIrCpbebR2DWNJqkLXt3OhUBUj99R6Vk25LyWo5fPvYbDxPqj1Zv2VBHf3SpcWyZos
         jrXYSnxXDdxN/dyQ6yaLdBDsZ62WUjmbAf77cuLVrAi55Cu7hxs7I/LKQTAHCbD0cf+u
         tNUw==
X-Gm-Message-State: AC+VfDwY09oxC+Eh6yxTjH1ySFiuOlqsqatSsb8aFFZOqeyFmxV6XC29
        mwbx9qLOl6JDXj/hXNKLlN4=
X-Google-Smtp-Source: ACHHUZ5X8rLbDNfZjiCF0KDlcGkYsGg9Fyr1Cu7KYTpdSsN9CPCh08N5Kr13v+c4heNBtEFBMCTjbw==
X-Received: by 2002:a17:902:ea0b:b0:1ac:7d8a:365 with SMTP id s11-20020a170902ea0b00b001ac7d8a0365mr12716189plg.26.1683734902834;
        Wed, 10 May 2023 09:08:22 -0700 (PDT)
Received: from localhost ([2600:380:7622:feaa:72b1:faa6:bc19:3bc2])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b00186a2274382sm3994313plx.76.2023.05.10.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:08:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 06:08:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH 4/6] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <ZFvBdB9C7t8ao1PU@slm.duckdns.org>
References: <20230510030752.542340-1-tj@kernel.org>
 <20230510030752.542340-5-tj@kernel.org>
 <20230510150946.GO4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510150946.GO4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter.

On Wed, May 10, 2023 at 05:09:46PM +0200, Peter Zijlstra wrote:
> > @@ -2348,6 +2382,7 @@ __acquires(&pool->lock)
> >  	worker->current_work = work;
> >  	worker->current_func = work->func;
> >  	worker->current_pwq = pwq;
> > +	worker->current_at = worker->task->se.sum_exec_runtime;
> 
> That only gets updated at scheduling events, it's not a 'running' clock.

I think it gets updated on each tick and preemption checks, right? That
should be more than enough here. Just using jiffies should be fine on higher
HZ machines; however, when the threshold is not significantly longer than
HZ, it becomes a bit problematic. Reading highres clock separately is an
option but is a little bit more expensive. So, sum_exec_runtime seems to fit
pretty well. FWIW, it's already used outside scheduler proper too.

> >  	work_data = *work_data_bits(work);
> >  	worker->current_color = get_work_color(work_data);
> >  
> 
> Anyway, it occurs to me that if all you want is to measure long running
> works, then would it not be much easier to simply forward the tick?

Ah, that reminds me that I forgot to update the origin timestamp on
sleeping. It should be tracking the continuous CPU consumption between
sleeps.

> Something like the below.. Then this tick handler (which will have just
> updated ->sum_exec_runtime BTW) can do that above 'work-be-long-running'
> check.
> 
> Or am I missing something? Seems simpler than hijacking preempt-out.

One advantage of doing it from preempt-out is that workqueue can immediately
release other per-cpu work items without any delay as when the violating
work item leaves CPU is the exact point for both detection and action.

That said, this mechanism doesn't have to super accurate, so simpler code
has its benefits. I'll take a stab at it.

Thanks.

-- 
tejun
