Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC58D72BBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjFLJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjFLJRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:17:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDADE41
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:09:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6563ccf5151so4492027b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686560984; x=1689152984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjqIWMhnCM3c0UyuNcTdFYBODL+SoHqU5xJE8dit+pY=;
        b=bFVjPv9Lkj282qORYOGzfQZbnNNLwfFdEqpe4QoputK+XT8zfDEv6W+usaF8I/2V81
         ADri1mdY+Pg/cjn6K3g+Nrg/cOv1lH00gjP6UCOsA9Ht42aM2vGCfw3LM0hBB5uQF4n6
         Gt53m6jL5Vwx20KlTke0XCZWCPyiAZRfEUA43IfwgvsaMj9sijg/uL1aKGRGAgrp9uOJ
         nhnUxKDljdxdp36OEiy77IbFTtJZ5UGfvv3Jru55w+nexwORIGw2Rlvy/ysdTqA5cKUA
         MeBezwRj7dK0Aap1iy6g1KfndD/wVQuRoZSBJBnC5M3tqdePo/jntLt3WOxsVLu9QiyZ
         QCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560984; x=1689152984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjqIWMhnCM3c0UyuNcTdFYBODL+SoHqU5xJE8dit+pY=;
        b=jrNbWJwdhTXH65bZVDIeY8gI5LHsj7F1wjf2QF7pcTTm3EAX6PjyJfLc+Ml51ePRBt
         dwD/+KKNTvQWyx8CTxyDsp9HSbHxlPTpIYpcepvk7jiTihKZMo6A71LyFAx/f9oKzZnK
         abl2tJsh7ufnmAZ+a/nzjECiD39khIw/kVkKt+BCM8tbem8yLx7ZiBeyprmQQStUR3XU
         LiAPXqrB9DQRQQTkIBMYXrdSKAXd8JxNhSLgutQgMOZtqS9ewK4hcgp9mk0/PbClLy5t
         c49FcfsKN8v24L0CY5EqAi9uotSZbrmzEI+NKNCBjOM0haoyYTknfunVikWGdrHcKeRD
         cRig==
X-Gm-Message-State: AC+VfDyHBfIN6Ccovl2YsWDJbO6OErRlY6z5W0u3i2S928/7OFeMNDiG
        BfPE2mpJvSLUwFOgIcN8JeSNCA==
X-Google-Smtp-Source: ACHHUZ7cYtPQh6sqro9YUMknnTBHC/C13NKV9pumrUpp099tZsLKZgHVq5VRS3cCi7yNgDVvDFYJfw==
X-Received: by 2002:a05:6a00:1804:b0:662:5146:c761 with SMTP id y4-20020a056a00180400b006625146c761mr13170762pfa.17.1686560983831;
        Mon, 12 Jun 2023 02:09:43 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-201.hinet-ip.hinet.net. [211.75.219.201])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b00643889e30c2sm6480550pff.180.2023.06.12.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:09:43 -0700 (PDT)
Date:   Mon, 12 Jun 2023 17:09:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        kirill@shutemov.name, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] perf/ring_buffer: Fix high-order allocations for AUX
 space with correct MAX_ORDER limit
Message-ID: <20230612090937.GD217089@leoy-huanghe.lan>
References: <20230612052452.53425-1-xueshuai@linux.alibaba.com>
 <20230612052452.53425-3-xueshuai@linux.alibaba.com>
 <751cb217-4be0-ddfc-780b-87517a8e337a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <751cb217-4be0-ddfc-780b-87517a8e337a@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:45:38AM +0100, James Clark wrote:

[...]

> > @@ -609,8 +609,8 @@ static struct page *rb_alloc_aux_page(int node, int order)
> >  {
> >  	struct page *page;
> >  
> > -	if (order > MAX_ORDER)
> > -		order = MAX_ORDER;
> > +	if (order >= MAX_ORDER)
> > +		order = MAX_ORDER - 1;
> >  
> >  	do {
> >  		page = alloc_pages_node(node, PERF_AUX_GFP, order);
> 
> 
> It seems like this was only just recently changed with this as the
> commit message (23baf83):
> 
>    mm, treewide: redefine MAX_ORDER sanely
> 
>   MAX_ORDER currently defined as number of orders page allocator
>   supports: user can ask buddy allocator for page order between 0 and
>   MAX_ORDER-1.
> 
>   This definition is counter-intuitive and lead to number of bugs all
>   over the kernel.
> 
>   Change the definition of MAX_ORDER to be inclusive: the range of
>   orders user can ask from buddy allocator is 0..MAX_ORDER now.
> 
> It might be worth referring to this in the commit message or adding a
> fixes: reference. Or maybe this new change isn't quite right?

Good point.  If so, we don't need this patch anymore.

Thanks for reminding, James.

Leo
