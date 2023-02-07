Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0CC68DE4B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjBGQzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjBGQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:54:58 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2746B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:54:56 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c2so17426116qtw.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzBHkLfEnVFDEK+KjgVtsPAXlm9EVCQtMhAcZQTuuh0=;
        b=3R5dDZ6GGGovkkLkQKUaYxu0foL+1lSJ8IYIIwmffq4aZeogM3A10O2HibgSIDGKm6
         P7pHWBdcrdY/tHJxBL8olfaSswF+l0AOUBQwRFILopVOkqOWeq+fkuGRn/KV2miGfB3R
         u2vfrnTiS6VZZdXL1OihlaQjXHY5+EQIfDuv8ApYEIwNiQ+tgj6bt1TEcvup3q5bEnCV
         6X8WgXeM41DC7cVzX/pLIbQCt5v/NoP7/Xe8rOEgPF+0w6pktkLf4mXIh6XVxykeW53+
         OoHO/9ALa/Yjs0ssGNlGiW1Gqwin4AsAZ9YzG1koYj2hrBCPfTY81/kOEme7WiTmWusk
         n0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzBHkLfEnVFDEK+KjgVtsPAXlm9EVCQtMhAcZQTuuh0=;
        b=tk6geCzoKp3F4yR2mtIa/QTPNDT5reGnreANtQzEc7DGvXNBncCgHRpyYOwEl7bgdn
         iS/G/D2vxcAQRHhIruliPo4YmPVizzZS2I92LspRWn3paDZ/NyLLMd1jvcZZB6z8k4b5
         v116+sgsr2d0ylpB3T29woUAHp0bh1GmLL+u8Qp06DlbjXSOO9rhubr9QhyFmxT3B8+p
         mdgi8wnf2fj6WH8C7NjdyaLR/iTj7tFkJlbFI9fp8CHZ5kgZaBX0iG+5CO6OPPJQLUgl
         rWwO1OtIoC/okFkqhTjtXb8+onOOBHWlYTRmJPx8uVqeDl4k3OsgbxngaWxHEbpvxl6J
         otLg==
X-Gm-Message-State: AO0yUKXNa4iDJ77BGj8kDpRterXK2Pdz5P5cBmaxcFlSeyZ1AC//NNPD
        3mgMBN0ET3gJmUpcAPpp37mIbg==
X-Google-Smtp-Source: AK7set+qMzUiEaYmqgBIuMjwJYZXmESXV2XKb3as1asM/N2cPgZ2RgC9pfsk9faWyzv7DV7GhtKZIA==
X-Received: by 2002:a05:622a:196:b0:3b9:b422:4d5b with SMTP id s22-20020a05622a019600b003b9b4224d5bmr6436646qtw.26.1675788896058;
        Tue, 07 Feb 2023 08:54:56 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id j6-20020ac84c86000000b003b642c7c772sm9611834qtv.71.2023.02.07.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:54:55 -0800 (PST)
Date:   Tue, 7 Feb 2023 11:54:55 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <Y+KCX6XHj/lv9ul3@cmpxchg.org>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
 <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
 <20230206161843.GD21332@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230206161843.GD21332@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 05:18:43PM +0100, Michal Koutný wrote:
> On Thu, Feb 02, 2023 at 10:30:40AM -0800, Yosry Ahmed <yosryahmed@google.com> wrote:
> > > b) Only count cgroup swap events when they are actually due to a
> > >    cgroup's own limit. Exclude failures that are due to physical swap
> > >    shortage or other system-level conditions (like !THP_SWAP). Also
> > >    count them at the level where the limit is configured, which may be
> > >    above the local cgroup that holds the page-to-be-swapped.
> > >
> > >    This is in line with how memory.swap.high, memory.high and
> > >    memory.max events are counted.
> > >
> > >    However, it's a change in documented behavior.
> > 
> > This option makes sense to me, but I can't speak to the change of
> > documented behavior. However, looking at the code, it seems like if we do this
> > the "max" & "fail" counters become effectively the same. "fail" would
> > not provide much value then.
> > 
> > I wonder if it makes sense to have both, and clarify that "fail" -
> > "max" would be non-limit based failures (e.g. ran out of swap space),
> > or would this cause confusion as to whether those non-limit failures
> > were transient (THP fallback) or eventual?
> 
> I somewhat second this.
> 
> Perhaps, could the patch (and arguments) be split in two:
> 1) count .max events on respective limit's level (other limits consistency),

Okay, I'll split this one out. It's good to have regardless of what we
do with the fail counter.

Thanks
