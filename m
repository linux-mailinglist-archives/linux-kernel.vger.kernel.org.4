Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F956E9256
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjDTLV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjDTLVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:21:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68407A243;
        Thu, 20 Apr 2023 04:19:16 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u3so5391192ejj.12;
        Thu, 20 Apr 2023 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681989479; x=1684581479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CPEgy8x9A+irZgd8pLdz+IKCAJoepVV09T/iGyXx1s=;
        b=iLfkeyXsuwn7KZOZtB5Fyxj+ZwrK/o96mpGib+1Ymb/4ss/rSnsYwcXf06UEjTJnc4
         XxV6wTLI3sGwnfuWwaq+LaghHuAq8Dok7BalHP7UCEsEP6POIQH3zYSgiVtyHcHXk4Tm
         ayDK/PelXCHslM2HqNnpY9BZ6xEIQJo9Lv7GZPwxKavgvYYjX92TC22FQACnTEedI71m
         rCfxcD4EGT0TZrweeM7RRh2cHs00uwnkRv9FTYXbfm54lRB7J5mT3l2IJya0yWo/TW5G
         j9kGZBkwUg0l02JOo4I0ijhuAZy3e/0SaaQ5rNPytDEoiTLFT3ud0KpmalH6AxspWtmw
         9HGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681989479; x=1684581479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CPEgy8x9A+irZgd8pLdz+IKCAJoepVV09T/iGyXx1s=;
        b=hgbHY+9Pg/Pb/IZbtrFj9MkK4BmrGagY2zjRr5cGCYw5Zn1TMCthxiSTQfMIhl9v6h
         UDjHAdbPzjkB3MqHos9iHs6l7qfwbetOvIXb5ZKqSNIebigy6u3nvmZOtJ7KPrF5sIDZ
         ozHGx2Ejpa7st0r8gXSjfKdpi3V2PCH9i6NuTOqe/vJEySeQ9DjjWtO8abgZ6ZLSvU91
         epFRJEkMxzPyE3Hg7T9ObaY3a/ReGH7JEmMVjeBfK6ONmyx4N/h6ITkdm77hFlZCzhxx
         jjkKG2WYhGfgy+1DatgedHHBzMyp9zfwdtP7jt6WgQK7l0K6Ftt2lrOfGKlgpT7rbeBo
         svfA==
X-Gm-Message-State: AAQBX9eh5fUKl4BymC6PIYs4lRaMzVb73Yq+pv+/5VJOVh0oEGkImiTd
        yQaC00ZAB/ABDJtF3jg+ftUCu2VMTUc=
X-Google-Smtp-Source: AKy350Yd/dVYSlk0nlDW/oE1kE5XYF6RMEM8XBQDPxa6Q5epikx8HVSR8VEFvczr+pyrYegGtGjJ7g==
X-Received: by 2002:ac2:430e:0:b0:4dd:af71:a5c3 with SMTP id l14-20020ac2430e000000b004ddaf71a5c3mr319790lfh.58.1681988790510;
        Thu, 20 Apr 2023 04:06:30 -0700 (PDT)
Received: from pc636 (host-90-233-216-43.mobileonline.telia.com. [90.233.216.43])
        by smtp.gmail.com with ESMTPSA id u17-20020ac248b1000000b004eafa060a6fsm179906lfg.145.2023.04.20.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 04:06:30 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 20 Apr 2023 13:06:27 +0200
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kvfree: Make drain_page_cache() call return
 directly if cache is disabled
Message-ID: <ZEEcsyn27ssrdfh6@pc636>
References: <20230418122702.1378299-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418122702.1378299-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 08:27:02PM +0800, Zqiang wrote:
> If the rcu_min_cached_objs is set to zero at boot params, the
> krcp->page_cache_work will not be triggered to fill page cache,
> and the put_cached_bnode() also does not fill page cache, this
> also means the krcp->bkvcache is always empty, so not need to
> acquire unnecessary krcp->lock to get page from krcp->bkvcache,
> this commit therefore make drain_page_cache() return directly if
> the rcu_min_cached_objs is zero.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93faf9f5c58f..00620a2117de 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2924,6 +2924,9 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
>  	struct llist_node *page_list, *pos, *n;
>  	int freed = 0;
>  
> +	if (!rcu_min_cached_objs)
> +		return 0;
> +
>  	raw_spin_lock_irqsave(&krcp->lock, flags);
>  	page_list = llist_del_all(&krcp->bkvcache);
>  	WRITE_ONCE(krcp->nr_bkv_objs, 0);
> -- 
> 2.32.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
