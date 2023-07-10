Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CC574DF02
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGJURN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:17:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752EBBB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-55b1238cab4so2515211a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020231; x=1691612231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVlvV6OUzFpdMtXuozvrxmT75oR8hw0lyEeMlWOoDBE=;
        b=YjKHl2yw/GK0nJVEAE/eMY/hM27z9xu0QlQss3u1pSAoHubsOvJ8LzzCVywm+Q/faZ
         ty3RJjP+/kW6rG818cqw/wfbiHuRE3297aORL5fsTV2fBuY1oRIo+wHAtup5Yxutpkzc
         Yect8Gd9MSyNB2SIOylAO7fqN2vw3zmx9RU4xFWHBsIa0BvS/ZydW/LrgmZ1VuFWIACk
         2hf9G2VuLqHHReCKzd/CgjoqCakKmurU68GOguRJY5BS5Jo7xDiQsMhU3ZEDfG7m0uxF
         ratJ5HQ+VgnKe5uI7vtDLTIUH1Iwp5XdhFFPwIMMRKnkJ/Lm65dQgTupy/pataK1ulgE
         rP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020231; x=1691612231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVlvV6OUzFpdMtXuozvrxmT75oR8hw0lyEeMlWOoDBE=;
        b=GeI6EUTsjU3WgUq3dwQlFutgx7w5VAHRwaGAetN/YL+Oyttvizy+rWQ8J7hYSAw40v
         U0Iq12YgZdOcI57uhtEG7mvb17vlH++9gCZZHy1dxwsI+9YdJ+2DKi53o4OVV+2PMfoF
         cIvTkzLTEaN1wbpcqbjVwZlzCqvmnbFbVyZIidhEdMP0OYZSsHUSnfClyEYyESpzvHYF
         mWeZodAp1UjfizlS/JxYYOATieSLg+TKud/XhGJ5pBEbQNNUHTlAqXURHV92TEAFxORb
         keiIPSQROMjHOBQBTvQq1uzWKkg0Vm+TOqGm1fcia3viF4Muvb474AFZS1Y3pF0A0vpi
         iebw==
X-Gm-Message-State: ABy/qLbF0aiyXj6d9HJVSSZDRsZnyQ2ci/v3E+72rCHurgyi37Zz4NH6
        WQQDpC/NN34gL1dycP0fyqw=
X-Google-Smtp-Source: APBJJlHaMNYOEh2NxYz1HiiDfOdtxRh+bLsh7818E2xlEY6wn0zCoH+H7UZemLZaqlpqmHKaaj65ng==
X-Received: by 2002:a17:902:758b:b0:1b8:1b84:93e5 with SMTP id j11-20020a170902758b00b001b81b8493e5mr11462659pll.1.1689020230717;
        Mon, 10 Jul 2023 13:17:10 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b001b7e63cfa19sm277918pll.234.2023.07.10.13.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:17:08 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v5 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
Message-ID: <ZKxnRIZQzyVDMZGD@slm.duckdns.org>
References: <20230707195748.2918490-1-pauld@redhat.com>
 <20230707195748.2918490-2-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707195748.2918490-2-pauld@redhat.com>
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

On Fri, Jul 07, 2023 at 03:57:47PM -0400, Phil Auld wrote:
> @@ -11038,11 +11038,14 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
>  
>  		/*
>  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> -		 * always take the min.  On cgroup1, only inherit when no
> -		 * limit is set:
> +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> +		 * inherit when no limit is set:
>  		 */
>  		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> -			quota = min(quota, parent_quota);
> +			if (quota == RUNTIME_INF)
> +				quota = parent_quota;
> +			else if (parent_quota != RUNTIME_INF)
> +				quota = min(quota, parent_quota);

Can you please add a comment explaining how hierarchical_quota is used in
cgroup2? It seems like you're using it to detect whether bw limit is
enforced for a given cgroup, which is fine, but the above code in isolation
looks a bit curious because it doesn't serve any purpose by itself.

Thanks.

-- 
tejun
