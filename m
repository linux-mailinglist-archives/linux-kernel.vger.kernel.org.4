Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57BB62AF60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKOXXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiKOXXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:23:40 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146D9FC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:23:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 136so15022783pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeFCzvbHxCMk5+FnFozTy4bW8T8EDfkdgl/UWLzqnP0=;
        b=E7upmvckNneLUJ5t5ce/SSEpXNc6jC5Q/95UYsU5By7kT1h6pCfMkpfC8PMv1R+qHM
         itjzlwuAa4YLgGwb6BTLgTFRA3d0lEsvTzlQt3ZhAVHHpkMb9G6aN4o571289K/Hpm7K
         5oknw92j5qvRDQrFMOiJBw7XmIdpE26u5YTMkXgXRCG0riKZwBXFsGlTzcKezrnPGKH9
         nTfaXKNERLS6WbjJvkcy9ToP3qW7YvwLl/L0IT+s6M+l79gq7dN/Q6kigtLB3u3PivVf
         lyR/zjvK/YIl7Ac4vGLtKANJL8DNhPYqLaJwwYP9/A37evqMyhbrX1WqPpfShgN6sha7
         0EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeFCzvbHxCMk5+FnFozTy4bW8T8EDfkdgl/UWLzqnP0=;
        b=g8CK5QKfD4faxNy+zoUicuZsYlgUUEgX4Rrs3cLzgYYW6zUNnNU1w7XrSx4EyO6iDc
         S9IIbaL4CrZIjPlJrtss46jLxXSscaKuM9Uj3NSa/sEOVL2mzVVFq/ATlCskf/XigL6p
         DArt/JJTwUoRL2KOJLwAnn/VOw32o+t6ea4kUqB8XZV3TNZq9FrqNMgZVFfPQrgrmWtn
         e7N6PEsr7QQqJqfxPzYch5hwIRca7Po2H3wedFS2GaH5UpmVzLuRbOlhAiJB6q+5Tvpr
         aWtYopwyBIYjOdY4o0cBMObSu9uOxQx6mo02BrmRB+AxpSYARNLji7PoJAArL9+zzLNG
         yNFw==
X-Gm-Message-State: ANoB5pm80sjw4vxkWwQ/iI4HJ0Kcic1JNAdHUK0Ega7G5TYS86EK4LM7
        IXCdGbO9kXUS8d7X37pEv4RVJZodNeI=
X-Google-Smtp-Source: AA0mqf4rU0AfEIfJ+7/6nukd+YOE7yNVYuMIpXlKPRu0R12NQwcNfs1g00Jh6i0yd04CxC6k8MEVXg==
X-Received: by 2002:aa7:91cf:0:b0:56e:64c8:f222 with SMTP id z15-20020aa791cf000000b0056e64c8f222mr20619863pfa.71.1668554618505;
        Tue, 15 Nov 2022 15:23:38 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6ff2:4caf:5d97:1932])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a66c900b0021358bd24b9sm110266pjl.21.2022.11.15.15.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:23:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 15 Nov 2022 15:23:35 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zsmalloc/zram: configurable zspage size
Message-ID: <Y3QfdyKNrZjx5FR8@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <Y21+xp52OQYi/qjQ@google.com>
 <Y22dxEcs2g5mjuQ7@google.com>
 <Y26AbHxhPBJdWZQE@google.com>
 <Y3MrHsaLc8wth00E@google.com>
 <Y3NG4fsjxHGrnbDp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NG4fsjxHGrnbDp@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:59:29PM +0900, Sergey Senozhatsky wrote:
> On (22/11/15 15:01), Sergey Senozhatsky wrote:
> > On (22/11/11 09:03), Minchan Kim wrote:
> > [..]
> > > for class in classes:
> > >     wasted_bytes += class->pages_per_zspage * PAGE_SIZE - an object size
> > > 
> > > with *aggressive zpage compaction*. Now, we are relying on shrinker
> > > (it might be already enough) to trigger but we could change the policy 
> > > wasted memory in the class size crossed a threshold
> > 
> > Compaction does something good only when we can release zspage in the
> > end. Otherwise we just hold the global pool->lock (assuming that we
> > land zsmalloc writeback series) and simply move objects around zspages.
> > So ability to limit zspage chain size still can be valuable, on another
> > level, as a measure to reduce dependency on compaction success.
> > 
> > We may be can make compaction slightly more successful. For instance,
> > if we would start move objects not only within zspages of the same size
> > class, but, for example, move objects to class size + X (upper size
> > classes). As an example, when all zspages in class are almost full,
> > but class size + 1 has almost empty pages. In other words sort of as
> > is those classes had been merged. (virtual merge). Single pool->look
> > would be handy for it.
> 
> What I'm trying to say here is that "aggressiveness of compaction"
> probably should be measured not by compaction frequency, but by overall
> cost of compaction operations.
> 
> Aggressive frequency of compaction doesn't help us much if the state of
> the pool doesn't change significantly between compactions. E.g. if we do
> 10 compaction calls, then only the first one potentially compacts some
> zspages, the remaining ones don't do anything.
> 
> Cost of compaction operations is a measure of how hard compaction tries.
> Does it move object to neighbouring classes and so on? May be we can do
> something here.
> 
> But then the question is - how do we control that we don't drain battery
> too fast? And perhaps some other questions too.
> 

Sure, if we start talking about battery, that would have a lot of things
we need to consider not only from zram-direct but also other indirect-stuffs
caused caused by memory pressure and workload patterns. That's not what we
can control and would consume much more battery. I understand your concern
but also think sysfs per-konb can solve the issue since workload is too
dynamic even in the same swap file/fs, too. I'd like to try finding a
sweet spot in general. If it's too hard to have, then, we need to introduce
the knob with reasonable guideline how we could find it.

Let me try to see the data under Android workload how much just increase
the ZS_MAX_PAGES_PER_ZSPAGE blindly will change the data.
