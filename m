Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5E670E5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbjEWTsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEWTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:48:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F7119
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:48:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d41d8bc63so170682b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684871291; x=1687463291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gh8j09IDsIastTGK+qUQekVYXvc0e9ghy+aokO8ek64=;
        b=W9xFM/f2wG4wJ1XqimQRGjAZPjNIZDk0zqHNwAfaL2L6+GT/GKtwSsGy4ZbPYkddyI
         a81kW4q1x9unuM8EEvYoYc7sZjn1xl8Hvk55euaZRb42OHIKNrrbAnAkAKcaxYj/+m8F
         yZQAETL4r5IoMBlblG9DCo8hcoIU5wvty+aW3bKZC2Xt6zxNE/VOXoIO+Z1M7BClhsC4
         moh9Kz0jY4Ff2Xn0lZRlxkqh/ygHpbSm+TFT3Vdii1FUjY/q8mYWR1Wyr0cUVAyEvr1J
         vCjbTD0q9Zg9TUNJIWMILwcSLMwaPbVzvsuJXJCe0qn5Xw/0eeVVZtfdCCwTbiaS1dqZ
         aDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684871291; x=1687463291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh8j09IDsIastTGK+qUQekVYXvc0e9ghy+aokO8ek64=;
        b=WdxYAj+1ZDjSX5c0/iAuv1v1qkcvRs27pbqsMgKu7fwS6FnqxhXgoJM8H7GDNCg8xY
         2v+Gp2JzaV7L8X9nY1vO7v/uGg7YEdcEHyL47Iv/xjku9G4/xDhcZo5im52MIcOnsQyl
         nrBM/B7srGcb/NW4rZXw75Pk+EtupNEtLAelEVXtU76ZSDOZNLejURnxOzGX+DAT/VsS
         bwVL51KPzMdrsg6Ku/GwfQ03jHSySWPTFuQ3u3SAyTwuasvHseRtgYIl6s2GinvNj7WG
         3xl7XScH53MAR1uGZW//9qcqMCaNTDk+kfBf+7hbeZ4MhWOb6Qf3HOs2SDwSzpfhdyRx
         75nw==
X-Gm-Message-State: AC+VfDyegbenUZ3C5jXOOTtw7ZQB8Fr6L+tFoSrk8HzMp5sPJKHjP9wo
        gd8j5n8UsIPPYImDaUdUecA=
X-Google-Smtp-Source: ACHHUZ6JDKKFT83gO/cAC16Eg14RrI7fQKz2iGQ8UaXaInuQjbRH1+AxteAJNly09N8IRr9SyjsSNw==
X-Received: by 2002:a05:6a20:3953:b0:10c:2fe0:b3d with SMTP id r19-20020a056a20395300b0010c2fe00b3dmr5608260pzg.33.1684871290987;
        Tue, 23 May 2023 12:48:10 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d22-20020a631d16000000b0050be8e0b94csm6312497pgd.90.2023.05.23.12.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:48:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 09:48:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, naresh.kamboju@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Fix warning triggered when nr_running is
 checked in worker_enter_idle()
Message-ID: <ZG0YeeTZNox8YB25@slm.duckdns.org>
References: <20230523140942.18679-1-qiang.zhang1211@gmail.com>
 <ZG0WoOqfr6R5wK1p@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG0WoOqfr6R5wK1p@slm.duckdns.org>
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

Hello,

On Tue, May 23, 2023 at 09:40:16AM -1000, Tejun Heo wrote:
> On Tue, May 23, 2023 at 10:09:41PM +0800, Zqiang wrote:
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 9c5c1cfa478f..329b84c42062 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1144,13 +1144,12 @@ void wq_worker_tick(struct task_struct *task)
> >  	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
> >  	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
> >  	 */
> > -	if ((worker->flags & WORKER_NOT_RUNNING) ||
> > +	if ((worker->flags & WORKER_NOT_RUNNING) || worker->sleeping ||
> >  	    worker->task->se.sum_exec_runtime - worker->current_at <
> >  	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
> >  		return;
> 
> Ah, right, this isn't just interrupted read-modify-write. It has to consider
> sleeping. This is subtle. We'll definitely need more comments. Will think
> more about it.

So, there already are enough barriers to make this safe but that's kinda
brittle because e.g. it'd depend on the barrier in preempt_disable() which
is there for an unrelated reason. Can you please change ->sleeping accesses
to use WRITE/READ_ONCE() and explain in wq_worker_tick() that the worker
doesn't contribute to ->nr_running while ->sleeping regardless of
NOT_RUNNING and thus the operation shouldn't proceed? We probably need to
make it prettier but I think that should do for now.

Thanks.

-- 
tejun
