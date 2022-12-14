Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073964CEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 18:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbiLNRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 12:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLNRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 12:40:24 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F0019024
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:40:22 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id d20so23664717edn.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 09:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InYm6sLvKrBj85IOoD7cel+odEmWBz2TRkO1Wbhx8jE=;
        b=zLiEPdGWeIplHyN5iSpM7exWPqLSjBujwmhH9CaDqwcZLozyIDL1wj7f/A4x0f7xhw
         lkD8XiLJnLny851wmw6zGpDjB6arYxXyLU41sJvAl3YWqKMcu/bfpzPN2AAEobUO5Qpa
         W+OxWPzArHW5QPgSWm6iu8T9qq/PAFK9GbfHcrpe1gh9ygZhgbyJ1+3/VYviiZ0ZkQix
         c8YTQI07Tib+u3vBjLkP0pGoA5MjveOUWP7Z6mKVzXFz5vyydsDQvlty5Bk07Vobz3xz
         R2/3XxCeEWRcDRVRl7LaIao+kY00sliQuEY1kr8G/Vbrjx/ObRPeswtJpUQOXtGewE6f
         l1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InYm6sLvKrBj85IOoD7cel+odEmWBz2TRkO1Wbhx8jE=;
        b=cWisGhzz490ZrdIZNpnjX+Gkm9aZckvV1rItHT0HjKwNr++P8W2votVAdiU6AiaPef
         XeY8FuzhYXL862oQqVAYQuGDoqN34RzpVkUI3Dmz9FzMq8YuX8a1nNI/BBGCxbHtcj5T
         E62ZxVHvF/TVhCzpQr/VzHl3wukknDRkn9JvMIvenh2Fm92Y7Hy89YMCUs+b21ySIzoZ
         2YHImAKbAmcHmsZd490pf2W/I9gvtazEj1JxDVYgUu9Xklrl5T3zV8K/o8foFRb68tLy
         2ufSRnhYesaaRcK/4qlIwadQZyn7JuO4D9xPBLhmyelsK+3lLKNvktVw5PvhDE+hQ8In
         lC4Q==
X-Gm-Message-State: ANoB5pnv93mVGL8K1s21rG8kS9oR8rCSyT6lGQi2xq7o0FFEgIhewjRN
        1HjujoZWWGxE1qZCEt9R/rIcDQ==
X-Google-Smtp-Source: AA0mqf5eBsgtyrMc/qDoNucSvmTB8WxIbAXdWIFwHNigRd4BitOiOXIkxygy1uff1xLKC+6DbCVocg==
X-Received: by 2002:a05:6402:194a:b0:461:a699:7c5c with SMTP id f10-20020a056402194a00b00461a6997c5cmr19543406edz.22.1671039620871;
        Wed, 14 Dec 2022 09:40:20 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id d10-20020a50f68a000000b0045b3853c4b7sm6696181edn.51.2022.12.14.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 09:40:20 -0800 (PST)
Date:   Wed, 14 Dec 2022 18:40:19 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: memcg reclaim demotion wrt. isolation
Message-ID: <Y5oKg4KFsFIYOYuZ@cmpxchg.org>
References: <Y5idFucjKVbjatqc@dhcp22.suse.cz>
 <Y5ik+CCmvapf87Mb@cmpxchg.org>
 <Y5maoIUuH79KrfJt@dhcp22.suse.cz>
 <Y5nEQeXj6HQBEHEY@cmpxchg.org>
 <Y5nrwrP0twm9IIDl@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5nrwrP0twm9IIDl@dhcp22.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Michal,

On Wed, Dec 14, 2022 at 04:29:06PM +0100, Michal Hocko wrote:
> On Wed 14-12-22 13:40:33, Johannes Weiner wrote:
> > The only way to prevent cgroups from disrupting each other on NUMA
> > nodes is NUMA constraints. Cgroup per-node limits. That shields not
> > only from demotion, but also from DoS-mbinding, or aggressive
> > promotion. All of these can result in some form of premature
> > reclaim/demotion, proactive demotion isn't special in that way.
> 
> Any numa based balancing is a real challenge with memcg semantic. I do
> not see per numa node memcg limits without a major overhaul of how we do
> charging though. I am not sure this is on the table even long term.
> Unless I am really missing something here we have to live with the
> existing semantic for a foreseeable future.

Yes, I think you're quite right.

We've been mostly skirting the NUMA issue in cgroups (and to a degree
in MM code in general) with two possible answers:

a) The NUMA distances are close enough that we ignore it and pretend
   all memory is (mostly) fungible.

b) The NUMA distances are big enough that it matters, in which case
   the best option is to avoid sharing, and use bindings to keep
   workloads/containers isolated to their own CPU+memory domains.

Tiered memory forces the issue by providing memory that must be shared
between workloads/containers, but is not fungible. At least not
without incurring priority inversions between containers, where a
lopri container promotes itself to the top and demotes the hipri
workload, while staying happily within its global memory allowance.

This applies to mbind() cases as much as it does to NUMA balancing.

If these setups proliferate, it seems inevitable to me that sooner or
later the full problem space of memory cgroups - dividing up a shared
resource while allowing overcommit - applies not just to "RAM as a
whole", but to each memory tier individually.

Whether we need the full memcg interface per tier or per node, I'm not
sure. It might be enough to automatically apportion global allowances
to nodes; so if you have 32G toptier and 16G lowtier, and a cgroup has
a 20G allowance, it gets 13G on top and 7G on low.

(That, or we settle on multi-socket systems with private tiers, such
that memory continues to be unshared :-)

Either way, I expect this issue will keep coming up as we try to use
containers on such systems.
