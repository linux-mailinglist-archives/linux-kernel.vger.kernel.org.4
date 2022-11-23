Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26B16367E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiKWSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiKWSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:00:11 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A960F9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:00:10 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h24so11719597qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9A8cQiLxG2eDxIN9LqbxR9kHprQzAjhFPvRfMzy2nbA=;
        b=JThIsrnalYZmSDDhQKwWGGeuUVFsTtfznTSg/LnbVkKWTcX9TtIOv42OyoGs/EtBM8
         5lKGVFslA1HnCNcURKMoM7T/K5hQwmN15JAejQfmZfRaoCm/MMDOmrdCHuzVCDcYlBOm
         3IAENmp+qd/OJOhBTPrmss/VakKTnaf6J5wSznE4djUqzpdYatYSslwQHPZmXSf277kI
         D2w+/RQ5P18zqyLmhAbeXS1zvALCeHv+RG+/JYfuS9W+4DGU4sd57x7C61z2PraoCam2
         GEGp6cj7FfpM9ECL7TpcAPgq0EZ2u8/s5TQ1PwqG5SQpnHDtFREeAmmJ6yvoVy//Qa5W
         SsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A8cQiLxG2eDxIN9LqbxR9kHprQzAjhFPvRfMzy2nbA=;
        b=V58NuEbUghfL1rcM+fD4sa1X06z7yBxwXp6TUcmfTg9ZGhZAHKr62VG7n1auu0wTjN
         2SHXHfEMCb8cYhJI2zFp48LsKNoESyU9VlK0ZPXg1MEYQnQSnIn04caInxjsYUu5ArzX
         nAeDQxfHorBG0rpsRjwq2ZXdNNdNJH7EFzR2Fq8leVc9bpOdC0XEKAIry/03+FkuI6QG
         vUWoNEmHL7loqeYH1XRlexEvaXqD2c+Drrdo3BK8i805AMSu6Yksm18SCH8LKChpWnU+
         BfIenJFh2EWjkFt9CpqPlak0NIR4SWmUFcErXzZoUSCjnPHjIO+Jr/0S+rbdZ4jKOtZ0
         Ew2A==
X-Gm-Message-State: ANoB5pmiRkIq9m3ezEw2gu1o4AVlSyC6EuphzPBE5YO6YDQyFIKsso5p
        Jr4wa4MawqXOfDvY7TTzu0VD/A==
X-Google-Smtp-Source: AA0mqf7yzb7BfNDeGRABLsmwYWSqaGKI2q66TVb/68TnDeMjm5zA8YnyzmhmQSDqNQ1wSvG+wsNWTA==
X-Received: by 2002:a05:622a:4890:b0:3a5:84b9:3292 with SMTP id fc16-20020a05622a489000b003a584b93292mr27137746qtb.119.1669226409525;
        Wed, 23 Nov 2022 10:00:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id i10-20020a05620a404a00b006bb8b5b79efsm12868905qko.129.2022.11.23.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:00:09 -0800 (PST)
Date:   Wed, 23 Nov 2022 13:00:35 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
Message-ID: <Y35fw2JSAeAddONg@cmpxchg.org>
References: <20221122203850.2765015-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122203850.2765015-1-almasrymina@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mina,

On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim""), the proactive reclaim interface memory.reclaim does both
> reclaim and demotion. This is likely fine for us for latency critical
> jobs where we would want to disable proactive reclaim entirely, and is
> also fine for latency tolerant jobs where we would like to both
> proactively reclaim and demote.
> 
> However, for some latency tiers in the middle we would like to demote but
> not reclaim. This is because reclaim and demotion incur different latency
> costs to the jobs in the cgroup. Demoted memory would still be addressable
> by the userspace at a higher latency, but reclaimed memory would need to
> incur a pagefault.
> 
> To address this, I propose having reclaim-only and demotion-only
> mechanisms in the kernel. There are a couple possible
> interfaces to carry this out I considered:
> 
> 1. Disable demotion in the memory.reclaim interface and add a new
>    demotion interface (memory.demote).
> 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
>    behavior in the kernel like so:
>    	- demote=0 would disable demotion from this call.
> 	- demote=1 would allow the kernel to demote if it desires.
> 	- demote=2 would only demote if possible but not attempt any
> 	  other form of reclaim.

Unfortunately, our proactive reclaim stack currently relies on
memory.reclaim doing both. It may not stay like that, but I'm a bit
wary of changing user-visible semantics post-facto.

In patch 2, you're adding a node interface to memory.demote. Can you
add this to memory.reclaim instead? This would allow you to control
demotion and reclaim independently as you please: if you call it on a
node with demotion targets, it will demote; if you call it on a node
without one, it'll reclaim. And current users will remain unaffected.
