Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70246142DB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 02:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKABqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 21:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiKABqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 21:46:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F019915710
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:46:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 4so12326965pli.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 18:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vc9KCRZ1MfYV4xRJlZtkcs25DBVAEKVH60dw9uAmQw=;
        b=DSKW9GYYxR8AvUg5C4u5zsptQ5utP+ooHd2R3dDcmauWIDWKtH/jRA5u0jr6wfAv3B
         XUTJsgH67wrFjednzkBZK4M5USLVQCYefWZ/x25UCsQd0eHUvlBc9CLyuEw5gm/L1bUW
         35HZ7Iw7dg5wR9JYjeB32RklkPdpiY6nlHDclj9ojl/D85jnbOe63cZfkOJqOblimyYm
         oXdz6CedXgSUv4i0+NJsSqXiOyNGwfPVBvhSmTu+cvNoE7rGxWHzJ2h8lMZbdtvX4P5O
         7YijRcfztz44J8iiH0WOgvQ1amof5L7mgdlrHstpYXanaPi9kevsHLS918U6jgEhVskt
         qhxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vc9KCRZ1MfYV4xRJlZtkcs25DBVAEKVH60dw9uAmQw=;
        b=4OMCsJQh43JLe4UzKRCg+ucA7In2zfEWVOsL/ZOyTxXx01UyLMUsiC58uhTJsnZvxx
         ItMDLKyty7Ugc/vvhRDcAW631htclaNkQY/5PawhvDssWiJBLrD1wLzYEy5DSv8cF4as
         Rg0/ZGrRAsc3Blr+4BGSXfMxDIvXXEcQ+ygCLKB2Bl4LzfAc+EQgAYL/EUfD+L/f88Ku
         jIlmGvg81t9MQlBCG89Yf1ieQJ/S3bi4lLiPU+vsDWN97IpKuhExLmoI3F6Nuc/E7UWK
         4Cgq7uuZKJNi5nrhjYsoiYHZ+vfBNL0I9/K9c/eEZwyzUwlqhNM2M1w1tAPK2+LJT782
         OYNA==
X-Gm-Message-State: ACrzQf1uCxvAY3jmDCZcI4l7pOGJe4k72fn9A7CI9V5FpHwxQ6hFB4e+
        xRENlh7US9+SZkh/RtF7cTs=
X-Google-Smtp-Source: AMsMyM6TCBIzoLTd8itiUeqJtbptMFQ+3VxwxGJxa0pNgTQdC/4ELwpK8DVGHf/JeJPC4jeRrSXfvg==
X-Received: by 2002:a17:902:ec92:b0:186:de89:7f67 with SMTP id x18-20020a170902ec9200b00186de897f67mr17462130plg.166.1667267161268;
        Mon, 31 Oct 2022 18:46:01 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:ba13])
        by smtp.gmail.com with ESMTPSA id o9-20020aa79789000000b0056d98e359a5sm1913974pfp.165.2022.10.31.18.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 18:46:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 31 Oct 2022 15:45:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] sched: async unthrottling for cfs bandwidth
Message-ID: <Y2B6V1PPuCcTXGp6@slm.duckdns.org>
References: <20221026224449.214839-1-joshdon@google.com>
 <Y1/HzzA1FIawYM11@hirez.programming.kicks-ass.net>
 <CABk29Nu=XcjwRxnGBtKHfknxnDPpspghou06+W0fufnkGF6NkA@mail.gmail.com>
 <Y2BDFNpkSawKnE9S@slm.duckdns.org>
 <CABk29Nta-RJpTcybgOk9u4DH=1mwQFZsOxFuQ-UpCcTwzjzAuA@mail.gmail.com>
 <Y2Bf+CeQ8x2jKQ3S@slm.duckdns.org>
 <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nvqv-T1JuAq2cf9=AwRu=y1+YOR4xS2qnVo6+XpWd2UNQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:01:19PM -0700, Josh Don wrote:
> > Yeah, especially with narrow cpuset (or task cpu affinity) configurations,
> > it can get pretty bad. Outside that tho, at least I haven't seen a lot of
> > problematic cases as long as the low priority one isn't tightly entangled
> > with high priority tasks, mostly because 1. if the resource the low pri one
> > is holding affects large part of the system, the problem is self-solving as
> > the system quickly runs out of other things to do 2. if the resource isn't
> > affecting large part of the system, their blast radius is usually reasonably
> > confined to things tightly coupled with it. I'm sure there are exceptions
> > and we definitely wanna improve the situation where it makes sense.
> 
> cgroup_mutex and kernfs rwsem beg to differ :) These are shared with
> control plane threads, so it is pretty easy to starve those out even
> while the system has plenty of work to do.

Hahaha yeah, good point. We definitely wanna improve them. There were some
efforts to improve kernfs locking granularity earlier this year. It was
promising but didn't get to the finish line. cgroup_mutex, w/ cgroup2 and
especially with the optimizations around CLONE_INTO_CGROUP, we avoid that in
most hot paths and hopefully that should help quite a bit. If it continues
to be a problem, we definitely wanna further improve it.

Just to better understand the situation, can you give some more details on
the scenarios where cgroup_mutex was in the middle of a shitshow?

Thanks.

-- 
tejun
