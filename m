Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76918641039
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiLBVxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiLBVxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:53:09 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9B1B7DF1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:53:07 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id v81so2898033vkv.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct0cPrSi092x9+JQYVwzrM1Jm4HkMAgjSbtFI3tq/NY=;
        b=Ydy+x0SUjPBd8rlBTfLQvfQhclcGeQye4ZJmZb6dCvZmpCoe1U4EPuT6V4IWgDo77G
         N69hl/0x/n+puIAwK3nUedXq/dZflpq6qY0nHg45KIFbrO74J91Csdi2EiO7QkOi4gO4
         Y9zAZMNEcOL5DXQw+DycdP2OtblBh/zNMx8RFiA9MAFSl2Xopv5koYj2nlbU5p/jKQTc
         wYV/PAhb8PEIqGl32evepYaBJayxX/B6Zsd8supMTxEIfzswC++WMSjXttHkVv/PBReS
         XwJEoU6Mgl+nWIRqszyVLX3tBpYnhjyfJV6zvgMGPTVfvbDzAjarPL31HOxD1u7j1vE5
         SWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ct0cPrSi092x9+JQYVwzrM1Jm4HkMAgjSbtFI3tq/NY=;
        b=IceuZkxVOaH5SQTmPL5f3SHWKazQ2pCzJdMwK808/7w0TrFSshpqvmPEeN803U3crC
         YUwfTNxkkhI7zXNwArX5Kk8G/5/ZnDnYkeh6ztfL+w2U48pffXTdh/MqPoPVGL051hxq
         8y/QNpZfmNbPT1HgLK4LcGZOzzIso65rwYY8Ew/ouaukzQKnivvMF1Hieypiy/y/Z2Pn
         KSd6ApLNTMaTyScsPzn+FgByMdW4C/E3qtGg68d7ijM7R7xzwqal1RZnoF0u919WbVcK
         gAM8VR975BZJqEjIzvqdg0kegfe/Purx2Ka4FR/yjzp+Ya4A0XJyTweD4Zyc/JW5Nt8r
         TL8g==
X-Gm-Message-State: ANoB5pls/fCIan5JUZPyBtZBpb4gI05hSrgvriokk31NdLNGl9LeE/R6
        4+hEeF3NLgJHlEakDY22G4pry8Vqyi47e6hH2aTXYeLK7Pn1bT4b
X-Google-Smtp-Source: AA0mqf4Zn/JmvGfUC7Y8Dukg3p9YPL5jtHAQXNAsLflE5CoMvabxjvRudsoThZhBWzF1392f10iPs0qJZGYVrFCli1Q=
X-Received: by 2002:a05:6122:482:b0:3bc:d827:7113 with SMTP id
 o2-20020a056122048200b003bcd8277113mr16603367vkn.0.1670017986741; Fri, 02 Dec
 2022 13:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20221201233317.1394958-1-almasrymina@google.com> <20221202133840.5cdd4270cf73eaaa1d9d0345@linux-foundation.org>
In-Reply-To: <20221202133840.5cdd4270cf73eaaa1d9d0345@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 2 Dec 2022 13:52:55 -0800
Message-ID: <CAHS8izMPbP1XAKCMKJ6UF39uGNv6k_fkMDgS6DR+MF9OucLhEg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: disable top-tier fallback to reclaim on proactive reclaim
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 2, 2022 at 1:38 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu,  1 Dec 2022 15:33:17 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > Reclaiming directly from top tier nodes breaks the aging pipeline of
> > memory tiers.  If we have a RAM -> CXL -> storage hierarchy, we
> > should demote from RAM to CXL and from CXL to storage. If we reclaim
> > a page from RAM, it means we 'demote' it directly from RAM to storage,
> > bypassing potentially a huge amount of pages colder than it in CXL.
> >
> > However disabling reclaim from top tier nodes entirely would cause ooms
> > in edge scenarios where lower tier memory is unreclaimable for whatever
> > reason, e.g. memory being mlocked() or too hot to reclaim.  In these
> > cases we would rather the job run with a performance regression rather
> > than it oom altogether.
> >
> > However, we can disable reclaim from top tier nodes for proactive reclaim.
> > That reclaim is not real memory pressure, and we don't have any cause to
> > be breaking the aging pipeline.
> >
>
> Is this purely from code inspection, or are there quantitative
> observations to be shared?
>

This is from code inspection, but also it is by definition. Proactive
reclaim is when the userspace does:

    echo "1m" > /path/to/cgroup/memory.reclaim

At that point the kernel tries to proactively reclaim 1 MB from that
cgroup at the userspace's behest, regardless of the actual memory
pressure in the cgroup, so proactive reclaim is not real memory
pressure as I state in the commit message.

Proactive reclaim is triggered in the code by memory_reclaim():
https://elixir.bootlin.com/linux/v6.1-rc7/source/mm/memcontrol.c#L6572

Which sets MEMCG_RECLAIM_PROACTIVE:
https://elixir.bootlin.com/linux/v6.1-rc7/source/mm/memcontrol.c#L6586

Which in turn sets sc->proactive:
https://elixir.bootlin.com/linux/v6.1-rc7/source/mm/vmscan.c#L6743

In my patch I only allow falling back to reclaim from top tier nodes
if !sc->proactive.

I was in the process of sending a v2 with the comment fix btw, but
I'll hold back on that since it seems you already merged the patch to
unstable. Thanks! If I end up sending another version of the patch it
should come with the comment fix.
