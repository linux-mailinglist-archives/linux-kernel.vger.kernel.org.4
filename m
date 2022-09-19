Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C985BD3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiISReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiISReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:34:06 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9459428E21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:34:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w20so16466884ply.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=QnwrH2dtfvz2iGuxfGiLH6CaV6KM9yIpurelTgaqsnU=;
        b=U9J0yVsKpopz9MNFWbtLDI40e8VlcpnsYS2HdB8krW3BiH3lcS+QLXRe6kJhHSMXLB
         Fx+hXx2C+4rAGFjuojgeYYCXjKtf2HJQjcaTW/KcYy8qqm9D7z/kY03lEu5FW23uH7vE
         D1CLig3e61AGHHxNKoVYaGDjPUQbz22SVmb0M1Ols6yBqvWtVBitsiWsR/mR9yRDoY7e
         O/fnUgaoRw0riMviZHomIoBgGsAAMDCbAIT8jA/LWxvugQkIq/ykbUb//GFOrFtw89cj
         sQJHNaCHZ8lc57PXYhMxBT0Lj2BP8FkWXEHK6vFngxNW6J4IYEy345Ah2OMkCQGzeZhR
         5WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QnwrH2dtfvz2iGuxfGiLH6CaV6KM9yIpurelTgaqsnU=;
        b=XSR6VXTJ7d2bkRIg8yGzD3ad/EiJUVzbLoq3lAMG65U0pjEYmVOSknKzBb0nQOu7Nf
         c5hMv18ju2jUVvpYk0CiNFLLcaZwcG/B3f9FHU9RjuC+UqXOAkih+CCw5VZMJuaC0V3x
         2/XHZi6dDZNQ34DGuYUURO2QJachpc53teI1Z10XAQXDBBTCQO35GXB7IWdrvf2bpcGr
         JSMWemI1cr3tQHdV8ylMf6rdzN6zFI7pDKgzTPc1LO/UBcMTZKQxYo9sUAAilXgLF47p
         xRJ1DW6z8Dh+zkreAvhytIKDmWJkXuSy8hoFS43yDbW0EZD0iLU5D3ulOMREKcr0lTc8
         2YhQ==
X-Gm-Message-State: ACrzQf21IBZZHxpzmIypXzl5918AHU+kXMaoqMesR3n0gAqtXH3w62lh
        mILuUv89CZtbyBeFabpUTwo=
X-Google-Smtp-Source: AMsMyM4YIp5p8gRp5didxm1tnat2f/CfwsUrELpB/hJtjaS/9TWI5+OoN54TSw1txu994bHrLb55yA==
X-Received: by 2002:a17:902:d1d5:b0:178:a537:1645 with SMTP id g21-20020a170902d1d500b00178a5371645mr822873plb.158.1663608844887;
        Mon, 19 Sep 2022 10:34:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y34-20020a631822000000b0041d6d37deb5sm18768752pgl.81.2022.09.19.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:34:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 19 Sep 2022 07:34:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
Message-ID: <YyioChBV2ecBw/vg@slm.duckdns.org>
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org>
 <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Sep 19, 2022 at 01:55:15PM +0200, Dietmar Eggemann wrote:
> s/valentin.schneider@arm.com//
> 
> On 16/09/2022 10:03, Vincent Guittot wrote:
> > Task can set its latency priority, which is then used to decide to preempt
> > the current running entity of the cfs, but sched group entities still have
> > the default latency offset.
> > 
> > Add a latency field in task group to set the latency offset of the
> > sched_eneities of the group, which will be used against other entities in
> 
> s/sched_eneities/sched_entity
> 
> > the parent cfs when deciding which entity to schedule first.
> 
> So latency for cgroups does not follow any (existing) Resource
> Distribution Model/Scheme (Documentation/admin-guide/cgroup-v2.rst)?
> Latency values are only used to compare sched entities at the same level.

I think it'd still result in a hierarchical behavior as scheduling is done
recursively top-down. Right, vincent?

It doesn't fit any of the resource distribution model. But it's rather
difficult to map latencies to existing concepts of resources and we have a
precedence in the cpu controller (.idle) which behaves similarly, so as long
as the behavior is hierarchical, I think it's okay.

Thanks.

-- 
tejun
