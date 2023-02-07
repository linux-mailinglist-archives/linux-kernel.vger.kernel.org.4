Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A44D68DE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjBGQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBGQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:52:46 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E946B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:52:44 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w3so17427749qts.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90LXWSidw5JtQbA5QjDdZbPVfE/311Yqzr/kJ+sttOM=;
        b=pYf4Wm2yX5Db/EesL6WWX79wefRSPeDXmP+JdbgruotStM4aTAg2EEmqAmFcafVsOQ
         qVZWuUrBQcBVM89VJJ7Lg4bX/OLfvPC1JnVU38e0oEClpG1YyWHd0+1D5TuFyOmu9tci
         7MwIi4JbzEUI59mW7MaUZ/BNcb7O8lzbaqyOkMte4VWLeUgGN2267ypBgPNhYD5pWixE
         7FMX6ON/ZNDrK1hq08B5q/9FdOFoJ38kat9YP6xjerL7XjmkjB4pkTIVGToAAidXO5G/
         MQeEU/d9tJ/c2Ix5Z2oWzN6/Eq3r3KwCryG0x4+v8QGkNaxF/8oRrWFBcMl3Dd67WCf4
         AwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90LXWSidw5JtQbA5QjDdZbPVfE/311Yqzr/kJ+sttOM=;
        b=YQXJCFHETspekf2i1QFOXOqOAA4xuYIk2Wb3xK6XCLkV3YetFa9ehdjsWxHj8wcai0
         8aeD0WJ11+vKq4EIH35DbqrLHr8+qUnsUSs8pMXC+zyQrhrTcMhp9c0qjnd7eqi/PlOs
         HirUhaEuDiXchYB/WIDrII0oSr7q5YXbkM7mfE7mR6uzVtBKPocAAq9X1D5byjkoR5U/
         tqHv/MP0aHGq1VvTQHXylGLfaURM7KkcA3BV5CRYDROLbWbTZ04pKF+Tg9JMNAQLOZXO
         K1WzKogINc2yzTNJwvrVGI97JFtXrSm+fm5aaiRsns4G8mhHzDxyNGOMwogjjUwJKXWB
         Lt7w==
X-Gm-Message-State: AO0yUKWcO0dJQQuPH2dZ1b4BQUuKW0y5jcPJWxwBJrHGaf1hwvmz6c0m
        yU+8ytnq18rUdbcTCkeQhvBr9w==
X-Google-Smtp-Source: AK7set/uMLJlKX7oaJVhg/E1eUJJiYug4Xd2CDFycpOG8k49bTxnQu/j0dxXX9P9xRATm5qsym0V1A==
X-Received: by 2002:a05:622a:54c:b0:3b8:68fa:afc6 with SMTP id m12-20020a05622a054c00b003b868faafc6mr7290880qtx.29.1675788763797;
        Tue, 07 Feb 2023 08:52:43 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id f10-20020ac840ca000000b003b84b92052asm9621428qtm.57.2023.02.07.08.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:52:43 -0800 (PST)
Date:   Tue, 7 Feb 2023 11:52:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <Y+KB2lcAH3vhw0Xj@cmpxchg.org>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
 <Y91ZsDSIr2oFHu3E@P9FQF9L96D.corp.robot.car>
 <CAHbLzkpk+6+kzsxmJ_MK+708rpCEjB2njnarLkzfzXX-MUyG7g@mail.gmail.com>
 <Y91eRKKutWBZwmSG@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y91eRKKutWBZwmSG@P9FQF9L96D.corp.robot.car>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 11:19:32AM -0800, Roman Gushchin wrote:
> On Fri, Feb 03, 2023 at 11:07:30AM -0800, Yang Shi wrote:
> > On Fri, Feb 3, 2023 at 11:00 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Thu, Feb 02, 2023 at 10:56:26AM -0500, Johannes Weiner wrote:
> > > > Christian reports the following situation in a cgroup that doesn't
> > > > have memory.swap.max configured:
> > > >
> > > >   $ cat memory.swap.events
> > > >   high 0
> > > >   max 0
> > > >   fail 6218
> > > >
> > > > Upon closer examination, this is an ARM64 machine that doesn't support
> > > > swapping out THPs.
> > >
> > > Do we expect it to be added any time soon or it's caused by some system
> > > limitations?
> > 
> > AFAIK, it has been supported since 6.0. See commit d0637c505f8a1
> 
> Great, thank you for the link!
> Then it looks like we have even fewer reasons to change the interface.

Yes, ARM supports it now. But the point wasn't necessarily to fix this
because of ARM. THP swap can fall back due to plenty of other reasons,
for example fragmentation. It always falls back on swapfiles since
they don't have the cluster allocator that bdevs have.

The broader point was that we show failures in the cgroup event
counter that have nothing to do with the cgroup's configuration.
