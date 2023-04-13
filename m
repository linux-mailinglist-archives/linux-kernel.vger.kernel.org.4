Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF26E09B0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDMJH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjDMJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:07:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F783F8;
        Thu, 13 Apr 2023 02:07:14 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b33so10352202ljf.2;
        Thu, 13 Apr 2023 02:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681376833; x=1683968833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2nwth3f3dlESn+xcWsI3GV0ApYXXBMlu6d6OTG1ZvlY=;
        b=KmPbLiqsmMc4cNxb7TG0JMYJLr3RywbCDFSS8PotigkKMUdFMykxLdwdKlh74yvAWY
         /KYxKqLYp6WujQ15SPk0h5gXaVNCDKf/8kgjas+MxnK4Il6Q5dTN+yQh2YL7VpbQJmhN
         7cF+BEZKXbINt7wGyjxEyQL5lBWDqWxLyCd70MBtgWkY3MGxIUXTlmqBtuIjPW72E8Td
         QZwls6tlVWymzbnRsHHX7SL8c72SFMesKa3tlvtd5QJGz27UDq5ZtI0IjYsIWLOvn9Oj
         wF9IgvURsb5eSGU8ktr079UdkULuGxk+hBcNZ1fZM0F9yHRoIfBF02np47+kmKeR8kAv
         zFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376833; x=1683968833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwth3f3dlESn+xcWsI3GV0ApYXXBMlu6d6OTG1ZvlY=;
        b=GXkMi5Wrevf2spOMOqQheYBs+Vun2EqfZ56aJa9q3eUyHI7hMh/ci+JQA2PY5oimRX
         DaYNuUY7mrKxmOL5QWjHTmBl7PYiwIdjSc9L9/h+vSfWRBNYnZ0u0mE0rh7Ihwe2MlPH
         LiqRGK31b7KoZuZIP79k7W0dtxeID2XwZKuEQxCeXqBwFBZIAajrKikUs6YrD1aaQT92
         h4O0aFC7bNq9kDRDM7Us6GIwyPDJMjagy/2P8M1fnbA6PJPhdujX5zNDi5dDx6VG8DsH
         MQ2migEDFN1tsNixJ2wFPud1+00bNWoWfF8BtPhEUcVmh/lwyZG45tnKLY8K1/VLySM6
         XYgg==
X-Gm-Message-State: AAQBX9cW9STWuSFVqeCVhxWx2uMSrFRG5sqPd0t9FZm/OpGUszU1CxNN
        GJb3TKMv2SELUYozo7rKY+s=
X-Google-Smtp-Source: AKy350a+d3J2QqMnTyLB5QUmgSNUAYdPm2HwqBrHn2ztoXz2D4gOu7o7YUt8j3COeTRXdLl1WM/PbA==
X-Received: by 2002:a2e:301a:0:b0:29b:80b4:7bf7 with SMTP id w26-20020a2e301a000000b0029b80b47bf7mr598325ljw.41.1681376832750;
        Thu, 13 Apr 2023 02:07:12 -0700 (PDT)
Received: from pc636 (host-90-235-5-238.mobileonline.telia.com. [90.235.5.238])
        by smtp.gmail.com with ESMTPSA id h13-20020a2e900d000000b002987088bda4sm177565ljg.69.2023.04.13.02.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:07:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 13 Apr 2023 11:07:09 +0200
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Make fill page cache start from
 krcp->nr_bkv_objs
Message-ID: <ZDfGPQfFhMdajJRC@pc636>
References: <20230412143127.1062367-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412143127.1062367-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 10:31:27PM +0800, Zqiang wrote:
> The fill_page_cache_func() is invoked and start from zero to
> allocate nr_pages of page, if the kfree_rcu_work() executes before
> the fill_page_cache_func(), the krcp->nr_bkv_objs is updated before
> enter for-loop and equal to nr_pages, since the page is allocated
> first, and then check the krcp->nr_bkv_objs in put_cached_bnode(),
> this produces a meaningless __get_free_page() call, this commit
> therefore make allocate page start from krcp->nr_bkv_objs and
> check krcp->nr_bkv_objs before allocate page.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 41daae3239b5..dcb86f9f2dd6 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3223,7 +3223,7 @@ static void fill_page_cache_func(struct work_struct *work)
>  	nr_pages = atomic_read(&krcp->backoff_page_cache_fill) ?
>  		1 : rcu_min_cached_objs;
>  
> -	for (i = 0; i < nr_pages; i++) {
> +	for (i = READ_ONCE(krcp->nr_bkv_objs); i < nr_pages; i++) {
>  		bnode = (struct kvfree_rcu_bulk_data *)
>  			__get_free_page(GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
>  
> -- 
> 2.32.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
