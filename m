Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4DB63F9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiLAVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiLAVcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:32:07 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A141C3584
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:32:06 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id bq9-20020a056a000e0900b00571802a2eaaso3040060pfb.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 13:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfDx/vZZhAqgLTBVAtZpOgxT3AMIFtwt/yJ9iwINIG4=;
        b=sbHSU0xyULWPTLXrm4btl81eBH5mc9EKqlCz8FBmg/OKAGvwye48d3zFEn0riuTVz+
         WI135Ntn79yhQRfKeyZF9J31eWKZKbKfBPuZ6/IMFzXeE7bgaaa2yAN6MEz3rn9BS3KN
         pNq4oLUFZmBCza5DExDhCrhY1gEBUmnnwuPGqI06j6cwAnmA9q0TDNzZ1mv8sSTIT1dN
         i7JlGJQmI3F0FeNp58IYU82p1+DN2kCgMsZWLPZ80EgvnJx/a3yI/cpU52DcBwD9efhB
         EZCOpNyNvSM5cmzqGWy8U39bvl1fJXnh98h4aU96DBsH01M0Va7s9KdyfDWD8Tiyn9Ie
         bEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfDx/vZZhAqgLTBVAtZpOgxT3AMIFtwt/yJ9iwINIG4=;
        b=aZ+yqJawmEJuLAChiTC783Itps5qfRlx2gfeFgVCwADnpuPitM1TNYMsrzuYnq/7CE
         Z2xVz3EkZW17rrs7GVWF1E09sHG7btcSdTYhEQpmbOXVhiZ/ocl0Y2+ZIaQWzmTUySYI
         9F41qxExn2WrooHC3jzOJl9uCv7hxT3SMgj+hbJcWOiL64l4EFfo3wHCvsi8q2mdAkyi
         hqgtwzBsWh1Rli4uXghgt4sUKP6dkppSmzM0kjjUR57eS2e4fVyySi/HeUgCW5+i9Ak4
         YzNL9xJuqxD8zMUxth2YyjcSbh08ffKgTLTUR2HYgAWyAMK5+npnyjI79PwTBpgKc+TO
         eiMA==
X-Gm-Message-State: ANoB5pkrnJFFWzAA2fStfUN7vsX497o41wZ3yh4ov2hZUZeQvURwNlt4
        hhD7GgQshtnRS79VFYSl9jak4BsjaziSIw==
X-Google-Smtp-Source: AA0mqf6pgLZ9Fc+K/9bMs2AxM/jvaK3js6zpoUDFS4IqiABOk/6WhwnwrmgPz87CaWY8z9dGCinxzJhJXRwT3w==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:902:efd6:b0:189:94e6:6a8e with SMTP
 id ja22-20020a170902efd600b0018994e66a8emr18501696plb.72.1669930325681; Thu,
 01 Dec 2022 13:32:05 -0800 (PST)
Date:   Thu, 1 Dec 2022 21:32:02 +0000
In-Reply-To: <20221130020328.1009347-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20221130020328.1009347-1-almasrymina@google.com>
Message-ID: <20221201213202.ycdaymwojd5plyrk@google.com>
Subject: Re: [RFC PATCH v2] mm: Add nodes= arg to memory.reclaim
From:   Shakeel Butt <shakeelb@google.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        gthelen@google.com, fvdl@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:03:27PM -0800, Mina Almasry wrote:
[...]
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7b8e8e43806b..23fc5b523764 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6735,7 +6735,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   unsigned long nr_pages,
>  					   gfp_t gfp_mask,
> -					   unsigned int reclaim_options)
> +					   unsigned int reclaim_options,
> +					   nodemask_t nodemask)

Can you please make this parameter a nodemask_t* and pass NULL instead
of NODE_MASK_ALL?
