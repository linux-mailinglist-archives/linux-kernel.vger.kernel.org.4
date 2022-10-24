Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3667D60B563
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJXSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiJXSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:22:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF6E6502C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:03:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3928135pji.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXEhQBaYJcsY09QjqAQ/xiILbCbyndNxr5VQjFtEgKQ=;
        b=IEHv+6EZs++pWLm9yYz0ECtajbE7gAJ95UhsBSQQ+tg4qNvmIIxgLKRoXAAd8iA7dT
         7ioXPXezOFgvHMPz4Iv+GQh3BhCZ60FjczNgGt6m/A6rwMu0wWEeoeT8INCTabElURnZ
         K+PtrME6sG6FAKowJEe2UBBx0NSPR+KxoBaRKNVnQ6CX2CzpUQEAUNl6i1N0Vrm+FQNk
         NDpSLSzWw/zF2yOHnxxCv/4GzBZcSyzZIL/6Ia5DXLJ5fUGxEbK90lmXPAJhZGctD499
         Ph3BfD55zumn4AjxeYhc529HlbzwUbKXNhnJd8dDkWZOfLO0jd60Zc35TkTGACJ0r7eU
         UoVw==
X-Gm-Message-State: ACrzQf3vi0zxQQtzvreeFyoIzuFds5xgVxaOJBghgdK54TmQ3Ew4BjzY
        Yw93ajtkx9Ig+d/SAg2tITfjTItj4F4=
X-Google-Smtp-Source: AMsMyM7A9M3yUshFCPJyOZ62hibLjAF/FHYr9gcDzJC8CXGxdicRR8u2cDReyV6WUYpbsjxjoRtxAA==
X-Received: by 2002:a17:90b:1d0f:b0:20d:1ec3:f732 with SMTP id on15-20020a17090b1d0f00b0020d1ec3f732mr38720175pjb.84.1666630812805;
        Mon, 24 Oct 2022 10:00:12 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186748fe6ccsm6530456plb.214.2022.10.24.10.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:00:12 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:00:09 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH 5/8] mm/percpu: replace the goto with break
Message-ID: <Y1bEmX1JITmafWLM@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
 <20221024081435.204970-6-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-6-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 04:14:32PM +0800, Baoquan He wrote:
> In function pcpu_reclaim_populated(), the line of goto jumping is
> unnecessary since the label 'end_chunk' is near the end of the for
> loop, use break instead.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/percpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 09e407338573..954abf916c7d 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -2167,7 +2167,7 @@ static void pcpu_reclaim_populated(void)
>  			/* reintegrate chunk to prevent atomic alloc failures */
>  			if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_HIGH) {
>  				reintegrate = true;
> -				goto end_chunk;
> +				break;
>  			}
>  
>  			/*
> @@ -2203,7 +2203,6 @@ static void pcpu_reclaim_populated(void)
>  			end = -1;
>  		}
>  
> -end_chunk:
>  		/* batch tlb flush per chunk to amortize cost */
>  		if (freed_page_start < freed_page_end) {
>  			spin_unlock_irq(&pcpu_lock);
> -- 
> 2.34.1
> 
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
