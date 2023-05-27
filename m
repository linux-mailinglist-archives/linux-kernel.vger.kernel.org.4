Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528E47131C0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjE0Bra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjE0Br2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CFDF7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 18:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0E77617C3
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24ABC433D2;
        Sat, 27 May 2023 01:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685152013;
        bh=W83RVanuHQE7ZbTs/GmwjsxwIO+ZLerImcVp8bovX8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=td9OaHbgDQ5nnasGQrsSvKwMyKx6sEmAxp+plDOsq7zQZzBbreQOUMMzXv5XVfXwc
         e/PIzGGrITwnHs89p1w2t6rispHCcB/FH/NfF8MowZmFtOdNPQTRnYsQMQhaAIkIdH
         JceIpOQKsq2mdOH1nI5l9J+owRO9RR6hbsaD6EJHqqsZhwGKjBTrSA8jMA7DiYX/OF
         hc8aPHvZgef2WGPRoXpxcy56Sa+J2o7A6vToj/W658E7dlSlG67nMwSiKx44TdO2t4
         KG5JGXG0psbKb7I9wrCuDtIwcKEBxb15b6Z5SZKhHFgDsnAb7WRdiMc7Sr587B8ReC
         /jo/9C7zEf3OA==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        syzbot <syzbot+841a46899768ec7bec67@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [damon?] divide error in damon_set_attrs
Date:   Fri, 26 May 2023 18:46:35 -0700
Message-Id: <20230527014635.7380-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c18dc1e9-1805-f366-9d16-30e9628ac14e@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Sat, 27 May 2023 09:15:01 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

[...]
> > 
> > Nice and effective fix!  Nevertheless, I think aggregation interval smaller
> > than sample interval is just a wrong input.  How about adding the check in
> > damon_set_attrs()'s already existing attributes validation, like below?
> 
> Yes, move the check into damon_set_attrs() is better

Thank you for this kind comment!

> , and it seems that
> we could move all the check into it, and drop the old_attrs check in
> damon_update_monitoring_results(), what's you option?
> 
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index d9ef62047bf5..1647f7f1f708 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -523,12 +523,6 @@ static void damon_update_monitoring_results(struct 
> damon_ctx *ctx,
>          struct damon_target *t;
>          struct damon_region *r;
> 
> -       /* if any interval is zero, simply forgive conversion */
> -       if (!old_attrs->sample_interval || !old_attrs->aggr_interval ||
> -                       !new_attrs->sample_interval ||
> -                       !new_attrs->aggr_interval)
> -               return;
> -
>          damon_for_each_target(t, ctx)
>                  damon_for_each_region(r, t)
>                          damon_update_monitoring_result(
> @@ -551,6 +545,10 @@ int damon_set_attrs(struct damon_ctx *ctx, struct 
> damon_attrs *attrs)
>                  return -EINVAL;
>          if (attrs->min_nr_regions > attrs->max_nr_regions)
>                  return -EINVAL;
> +       if (attrs->sample_interval > attrs->aggr_interval)
> +               return -EINVAL;
> +       if (!attrs->sample_interval || !attrs->aggr_interval)
> +               return -EINVAL;

In my humble opinion, the validation for monitoring results and for general
monitoring could be different.  For example, zero aggreation/sampling intervals
might make sense for fixed granularity working set size monitoring.  Hence, I'd
prefer keeping those checks in the damon_update_monitoring_results().


Thanks,
SJ

[...]
