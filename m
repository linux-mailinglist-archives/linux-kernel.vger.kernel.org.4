Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4057E6BBD3A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 20:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjCOT0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 15:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjCOTZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 15:25:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A19029424
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:25:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q16so18304547wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 12:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1678908347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zDY1niEs3y45VnBldMysocOzffvLzvPaTI8pzH+DNnY=;
        b=oTI0TkVK0nNqU/zoKTrAJNGzJsgn3Ec3xL6T/YTI/OGOYUwiXI+Zea7W9JQ37PN9mK
         Fri6RhTmi800wCaByug5NppNgFk3745pN3yCoAJbr9MVc5doFqgVAye9nBAB8Tjq2yFT
         ikfxJfmqWJyBZtZjurB6GVbT4S50M7mLzR6f/IVy6nuQHLL+EkYjtwjPRLF7LIy7EU6b
         ehnzJCmvkIv4w1SifZk28nmcRa/qfYHSJl8bRG7IzM2S9Qxx0PCN5ipkC2vY4TUHWRlm
         1S/NnH0cBrf95jL1XpbM+hJ+t9gnX1p8zdtqBbmsos9x+wXJxB7ajX2m7v6y7CWhXGl3
         aBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678908347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDY1niEs3y45VnBldMysocOzffvLzvPaTI8pzH+DNnY=;
        b=7FYG6Umy/sH7pO1Lbuz52pMz9Gttd0AwUZvO3JR61OY2PP+u1sMDd017z74tQChOKz
         KBOvcKYi3GDxBbQcGYe9CG+NPXV3GYt0Rzhao6JsIIeO1/XooQH46kVxYLUrKo1B5l/C
         XvRov01MizMlu+k7QJ0XxcgLo29yNflutATknYb+7bZw51nBbpHQFTp+oJmkS318fnXl
         0osgNLERDBehq+qGKGDOjITQYQOw1rEErUBdPiioF1BkNHeJtF5mF6vqCjPCsFOMEE13
         o0vRTIDhRED8K/aUjgBEeQseW+rdFzg1D92c6vMDHwDXzJyqr3VHO4VzkidFpI1mx5DL
         5Bog==
X-Gm-Message-State: AO0yUKWPmnOCaFsuqE61n4XhYj45ipYvUDa/8wc4qFA6AssjWnwg5amY
        nxskfGKWDk7iReySeTDZskrPEw==
X-Google-Smtp-Source: AK7set/KaTIW+foFs+KH/RgvtwrBd+LkAfDADlz+KDrIV4s7o1Y69ktq9GFXEGM+tXyOBFlNdysWWA==
X-Received: by 2002:adf:dfd0:0:b0:2ce:a703:1937 with SMTP id q16-20020adfdfd0000000b002cea7031937mr2774138wrn.50.1678908347081;
        Wed, 15 Mar 2023 12:25:47 -0700 (PDT)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id m1-20020adffa01000000b002c5526234d2sm5557773wrr.8.2023.03.15.12.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:25:46 -0700 (PDT)
Date:   Wed, 15 Mar 2023 19:25:44 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Message-ID: <20230315192544.44ufekpbebs2ysub@airbuntu>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315121812.206079-3-juri.lelli@redhat.com>
 <20230315144927.624cbwc3yep3fwor@airbuntu>
 <ZBH+AaJV36y/HNXk@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBH+AaJV36y/HNXk@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/23 17:18, Juri Lelli wrote:
> On 15/03/23 14:49, Qais Yousef wrote:
> > On 03/15/23 12:18, Juri Lelli wrote:
> 
> ...
> 
> > > +void inc_dl_tasks_cs(struct task_struct *p)
> > > +{
> > > +	struct cpuset *cs = task_cs(p);
> > 
> > nit:
> > 
> > I *think* task_cs() assumes rcu_read_lock() is held, right?
> > 
> > Would it make sense to WARN_ON(!rcu_read_lock_held()) to at least
> > annotate the deps?
> 
> Think we have that check in task_css_set_check()?

Yes you're right, I didn't go forward enough in the call stack.

It seems to depend on PROVE_RCU, which sounds irrelevant, but I see PROVE_RCU
is actually an alias for PROVE_LOCKING.


Cheers

--
Qais Yousef
