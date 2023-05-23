Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2326070E79E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjEWVpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjEWVpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:45:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B599E64
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:44:56 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1afa6afcf4fso1907045ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684878296; x=1687470296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVkVzRy2R861oYLkXc/9sZeWaxITTwj/riElsfeea7o=;
        b=V5MxZuqSgvz2elLCr1QksgqUqrMcfmOJI9p+sKAGOWfK/be0Y0ZZeCbBU8La62IhRz
         sjAlK/VK5H07s332q/PK+u87XXZ7W37ipT0UZU14CybS8vHBL3G6EsEbwuCCHmHryHAC
         9Cf/f9LL1YowDu8/BrPfzocZRduDyOyFvEcDjDoVorgQUGJI445mbNzwx42weVA1iKI3
         jlnq3/lL9fz6U8NrAnvHiU5eqq1VQsrYIjMO43m2YhK4MIkRjTf+zrExqTB6tcfRRgXL
         wPUI3PFmtxnTZr0ttF2YQZpbJix84WutbspR+92Ppcxax2iMAZDk0fGWv8selUOnHPzY
         5fug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878296; x=1687470296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVkVzRy2R861oYLkXc/9sZeWaxITTwj/riElsfeea7o=;
        b=Mov/Sll6D9YwvXa3nOlCV2UFXDQZ4/ByhGiQX96MC3GBgHKtL28TEhgCie1fB0RWW7
         6WPQO2co9ozczseFQUCRH9empuN8eOwhaVRt+rQs1WnbL7+V6ZyVXESyc/QgBQ04WjRX
         8bodRjyM8cLYh9qaEXzG5mu35j8LCfTMBsv+W+GqWF855tbdIqfT6b+ah3gtQ8XO3fhG
         w39TRiYP8PPlXxchglQZDP1pyIrC0Qnt58sLI7EBo0w4d0ozQwje0dVvYhIfDuLWVqb/
         9+QE0ZqEw341Lr5gfwgU+Au0jFzAmZp9fgooiwUNOfqJ+aYP0EyW0n6Zfj5TfYwU/Iep
         x+AA==
X-Gm-Message-State: AC+VfDyX5EcJyGRCCYu9RIZrBmRD9rEUBIv0W0aPYE00UGpd0EuPbjT5
        pVIVNRgktUzAKNhXzVhsLNY=
X-Google-Smtp-Source: ACHHUZ53mvf2bAuDym1gKE98aROen7CF4/0WaUOLQhSY31NLTm9TIvoIjgQ3BjbgzP4Kbvllp40z/g==
X-Received: by 2002:a17:902:db03:b0:1ae:6135:a050 with SMTP id m3-20020a170902db0300b001ae6135a050mr19559179plx.19.1684878295547;
        Tue, 23 May 2023 14:44:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7a1e])
        by smtp.gmail.com with ESMTPSA id d12-20020a170903230c00b001ac7c6fd12asm7257510plh.104.2023.05.23.14.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 14:44:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 May 2023 11:44:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/2] sched: add throttled time stat for throttled children
Message-ID: <ZG0z1enh3TNbsxQh@slm.duckdns.org>
References: <20230518013414.3053254-1-joshdon@google.com>
 <20230518013414.3053254-2-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518013414.3053254-2-joshdon@google.com>
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

(cc'ing Johannes)

On Wed, May 17, 2023 at 06:34:14PM -0700, Josh Don wrote:
> We currently export the total throttled time for cgroups that are given
> a bandwidth limit. This patch extends this accounting to also account
> the total time that each children cgroup has been throttled.
> 
> This is useful to understand the degree to which children have been
> affected by the throttling control. Children which are not runnable
> during the entire throttled period, for example, will not show any
> self-throttling time during this period.
...
> @@ -11204,20 +11217,24 @@ static int cpu_extra_stat_show(struct seq_file *sf,
>  	{
>  		struct task_group *tg = css_tg(css);
>  		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
> -		u64 throttled_usec, burst_usec;
> +		u64 throttled_usec, burst_usec, throttled_self_usec;
>  
>  		throttled_usec = cfs_b->throttled_time;
>  		do_div(throttled_usec, NSEC_PER_USEC);
> +		throttled_self_usec = throttled_time_self(tg);
> +		do_div(throttled_self_usec, NSEC_PER_USEC);
>  		burst_usec = cfs_b->burst_time;
>  		do_div(burst_usec, NSEC_PER_USEC);
>  
>  		seq_printf(sf, "nr_periods %d\n"
>  			   "nr_throttled %d\n"
>  			   "throttled_usec %llu\n"
> +			   "throttled_self_usec %llu\n"

This is fine in principle but I think it'd be better to keep it consistent
with how non-hierarchical events are in memory.events.local. ie. Can we
please add cpu.stat.local instead of adding the _self key to cpu.stat?

Thanks.

-- 
tejun
