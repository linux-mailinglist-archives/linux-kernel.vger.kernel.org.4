Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6545B5F73DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 07:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJGFRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 01:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJGFRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 01:17:13 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D7C4596;
        Thu,  6 Oct 2022 22:17:12 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-132af5e5543so4507808fac.8;
        Thu, 06 Oct 2022 22:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFb1DikLjUcojh9GhZ3Q9M417hWE4FhLqT1610ZfRQA=;
        b=mg283t+hfae2CjrnVhlFTr6W7VXWoCPnaAu9+vU5rPYCkgGnrmLzkDdvx2uZIHByOO
         6M82sztb4O9bbG5MjW7kcsdPjqfWYAfPRZmlVv33KvYA1IRUJGjwe5VDhV8vXvIOZl4t
         0EtOQ0tC2luQK69rjwZQh4Obuj5w+j60jnNQdm8rZtiZukaDg+WNvOxwFEK79rYHzE2F
         ByyC79dqpf2Ma7icuhpj2dN7E5flxxZaN0teTsiN5EEzMdT679RWe64Fhx9b3gxyrPJh
         vOK3vmxgOI5L2FEa+b4JBE49GRTFTE69BihBlKvmYcyekDiJUrmJbMf75tsZRztNPOmu
         qJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFb1DikLjUcojh9GhZ3Q9M417hWE4FhLqT1610ZfRQA=;
        b=p6Dg44ymQG5YZlqQjhgNdq/z0XwFJifM/DiOj97GaVQld4zWasNaF5J8Z09U9BwybB
         SWJkGcXLY+PwAHNUVBKFj4Ifp059gOPxBymrVI3G03inn0HU2g8dr+Ygax0jUl+MaYxJ
         GCEbTjEfxdJBWS+xHQcKg88GgK9gJd9aHl5PgkLhy4MEVMMRWMyUZbqxclsquVbhAk91
         Ca4qbe0OHSLz7GyB3vHQZI89uKql0Iz8IhdUcLo6ZoDzXbwzYnrzIOo7nEsOjNLeMvbH
         bEpudOD9717bugrwVC20EEJdtxsSESnWh8Np+MrldcthdleMbJKGS7+Q49K8uLnk0gxl
         oQSw==
X-Gm-Message-State: ACrzQf2DCgUlR8/FZ7pM1XHJQbphMuM5+eDwdXMvNz8EHu2y9mpmrCD8
        hWPpNLHY7L3hqMCZxj8ORODMD7PuWVw=
X-Google-Smtp-Source: AMsMyM5aaXxgrR1a+JnrgRe9hLZJLm0xd/dvDgYN0gY6S2iad9uuQWSXaC6smJSlsQ6F4Pju/m8X2w==
X-Received: by 2002:a05:6870:8910:b0:131:2f31:dc1c with SMTP id i16-20020a056870891000b001312f31dc1cmr7400884oao.290.1665119831354;
        Thu, 06 Oct 2022 22:17:11 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id f22-20020a4ad816000000b0044884c40c8asm525673oov.30.2022.10.06.22.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 22:17:11 -0700 (PDT)
Date:   Thu, 6 Oct 2022 22:15:00 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH bitmap-for-next 4/4] blk_mq: Fix cpumask_check()
 warning in blk_mq_hctx_next_cpu()
Message-ID: <Yz+11DZk/pKWDF4c@yury-laptop>
References: <20221006122112.663119-1-vschneid@redhat.com>
 <20221006122112.663119-5-vschneid@redhat.com>
 <Yz7dC4zxby1CZphE@yury-laptop>
 <xhsmhy1ttf0ce.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhy1ttf0ce.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >>  static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
> >>  {
> >> -	bool tried = false;
> >>      int next_cpu = hctx->next_cpu;
> >>
> >>      if (hctx->queue->nr_hw_queues == 1)
> >>              return WORK_CPU_UNBOUND;
> >>
> >> -	if (--hctx->next_cpu_batch <= 0) {
> >> -select_cpu:
> >> -		next_cpu = cpumask_next_and(next_cpu, hctx->cpumask,
> >> -				cpu_online_mask);
> >> -		if (next_cpu >= nr_cpu_ids)
> >> -			next_cpu = blk_mq_first_mapped_cpu(hctx);
> >> +	if (--hctx->next_cpu_batch > 0 && cpu_online(next_cpu))
> >> +		return next_cpu;
> >> +
> >> +	next_cpu = cpumask_next_and_wrap(next_cpu, hctx->cpumask, cpu_online_mask, next_cpu, false);
> >
> > Last two parameters are simply useless. In fact, in many cases they
> > are useless for cpumask_next_wrap(). I'm working on simplifying the
> > cpumask_next_wrap() so that it would take just 2 parameters - pivot
> > point and cpumask.
> >
> > Regarding 'next' version - we already have find_next_and_bit_wrap(),
> > and I think cpumask_next_and_wrap() should use it.
> >
> 
> Oh, I had missed those, that makes more sense indeed.
> 
> > For the context: those last parameters are needed to exclude part of
> > cpumask from traversing, and to implement for-loop. Now that we have
> > for_each_cpu_wrap() based on for_each_set_bit_wrap(), it's possible
> > to remove them. I'm working on it.
> 
> Sounds good.

Hi Valentin, all,

I'd  like to share my work-in-progress for cpumask_next_wrap(). It's 
now in testing (at least, it boots on x86_64 VM).

I'd like to collect early comments on the rework. If you like it, please
align your 'and' version with this.

https://github.com/norov/linux/commits/__bitmap-for-next

Thanks,
Yury
