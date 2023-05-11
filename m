Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B126FFCCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbjEKWrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbjEKWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:47:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DCD4496
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:47:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643a6f993a7so5603590b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683845253; x=1686437253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wy2Rq22NlbGnvYnGved+BU6C8dl1IP570WbA/WCe8jA=;
        b=XRsC1FYauRUJ53RtzQHwstFdsn9SY4IjWjt3taS+ix/YISr1w33BiKBcTmOn+TnuLP
         Q69qwb9/tsNOXvpCWRDZiWMMOghzkutOqH0ccjOuC7uHqFe04afkR3nKeJukon8gOVJX
         SkAQWticulayUpWyvVqCpnOuBc1fZmpuAN8aj4nmlXKQbNWKT25h96KJm47pUszgLAYX
         X5h9E1imI4AxvsyYh9Of5M3/A0Wz/8XWLdThK2tW589KnLAruuq7X2OYI3mjaeqShbSH
         GkRSl8n+URKbkvVPmynSdrkPHMDmilrJmW3JFX2urKXTOj32+3dnRjLCT8zEuyYXRIjk
         2kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683845253; x=1686437253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy2Rq22NlbGnvYnGved+BU6C8dl1IP570WbA/WCe8jA=;
        b=NccwGxLc66cnSewRBanRRPK3ziQ5OR/z4q52PHoeZM/oUEJC5Q6sKE6I9Tj/9jgh7y
         Q18y8tgcMqU7l5QGBtgptOF1fr6vzmIH6NjqnObAkA2TZ8df/Bf5do60FQbg11tJEpiF
         wv2OgswBYXmwETqwR7xAEijBq7mgGV4xhRkbJhtXvEkCJzw1t4kHR1wisTVjNCuT58+5
         JX2B34CqVVCWIc9vBtnyK27jKgpbY1PrBf6ZzYS0V2F+m6NLJn6Q8JbBDVzbArIhwZBj
         C68OfgeHvgf7/8haPt0jFFKxic/GSyOhPSQzeVYCBiVLm7v9UnFXNf1xkH+unwTyBNFF
         aD9A==
X-Gm-Message-State: AC+VfDyWQ8lcpVSp8DsAwhDVpFgZj6GvSJ65PBjZE1l8nYQqApmtF8tP
        ueLW6gcTFDCDTB5ogiqexkbgWiyuu5A=
X-Google-Smtp-Source: ACHHUZ6/vuc2Dig1PimSwEU4Vt8/F/jqY/9seXIhvnHBL2kizI5JTi9TjTlRBYG2ch1OniCDiJJ93A==
X-Received: by 2002:a05:6a00:1312:b0:648:774d:3cd0 with SMTP id j18-20020a056a00131200b00648774d3cd0mr8362053pfu.14.1683845252680;
        Thu, 11 May 2023 15:47:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u18-20020aa78492000000b006470a6ef529sm5373319pfn.88.2023.05.11.15.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:47:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 11 May 2023 12:47:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 5/7] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <ZF1wg7-Lczi0APsP@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-6-tj@kernel.org>
 <20230511212358.GH2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511212358.GH2296992@hirez.programming.kicks-ass.net>
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

On Thu, May 11, 2023 at 11:23:58PM +0200, Peter Zijlstra wrote:
> > * Even when detection is working, the 10ms detection delays can add up if
> >   many CPU-hogging work items are queued at the same time.
> 
> HZ=100 assumption there :-) My HZs are bigger 'n yours etc.

Oh, I was referring to the default threshold, but yeah, lower HZ can
definitely be a factor.

> > However, in vast majority of cases, this should be able to detect violations
> > reliably and provide reasonable protection with a small increase in code
> > complexity.
> > 
> > If some work items trigger this condition repeatedly, the bigger problem
> > likely is the CPU being saturated with such per-cpu work items and the
> > solution would be making them UNBOUND. The next patch will add a debug
> > mechanism to help spot such cases.
> > 
> > v3: Switch to use wq_worker_tick() instead of hooking into preemptions as
> >     suggested by Peter.
> > 
> > v2: Lai pointed out that wq_worker_stopping() also needs to be called from
> >     preemption and rtlock paths and an earlier patch was updated
> >     accordingly. This patch adds a comment describing the risk of infinte
> >     recursions and how they're avoided.
> 
> I tend to prefer these changelog-changelogs to go below the --- so that
> they go away on applying, they're not really relevant when reading the
> patch in a year's time when trying to figure out wtf this patch did.

I tried that and promptly lost the version logs while iterating / posting
cuz that involved going through git commits. But yeah, the above version
logs aren't useful. I'll drop them when applying.

> Anyway, this seems entirely reasonable.
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks.

-- 
tejun
