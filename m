Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AA0651FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiLTLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiLTLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:43:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9CE10FD1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:43:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ja17so8467914wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Izi5rtgy1gy7iKuRR2cyO+zgmNxqGI8JekC2jp3If4w=;
        b=isuVeixmHfbDsDcKHUdjtJo4925V08Z10w1T9CrZoACnBFjfLsEuLH5+M4VcQSxWRB
         TaTDWZkT/kH+ZCDW6i82k3V81ahhqxjRfXxkOSTxFmdxh2C14WNVYm5nYR8oazqJLPA+
         Tp4nXtHMTmZj7mVCviywGmX5aY6RNehPdHTiNzNb1dfGTUOwWguYSsabN7Iy+R1w0KPr
         BU0HXGwqSJvlffLf5+LDTJTX/pBMluHntTBs6mmmW67uJRK7MZyNdVzd0XRGtMMYD50H
         f1mzcoAErYYMfOOS6E+nKjSlt0bJuW4XQyBoV7IvmVHlw9ZolV4sPqdIJR1iBt70QEPK
         tItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izi5rtgy1gy7iKuRR2cyO+zgmNxqGI8JekC2jp3If4w=;
        b=i3duToIoMFfLRz0SFLM4eGJNrXyoCFWnOFSdA2O5+OI2jJG+dU3dliAtXk/1VwEug4
         4yOrzAOVUrq4OPLX6NEXR3DfcAs/WQv+OiLqzLoTY2/A32lhykEFJzVzh6qARIxsjUHx
         R3PultfhohGH9OoKkdxGOT9/zk3fAY/Dium+KPJJ4JrFogfa4M6B7YXA0hT5+BVRwz1O
         FsQknKB/hG7Lz2bULUvGMfg8Hr9/2KmBaqVqYage/Of5PMycQQUqOMg9s/nCwuA5m/tg
         afhrm4TXtkb9clDqoRQZY5zk0VXLngPxiVlgI9BusJFzzFnG9V9xzU8JDejylhwtj/Bk
         lExA==
X-Gm-Message-State: AFqh2krEXgLZWedZBKx3VhysXYMg51t1I9IUvKqdfHn0UGw1W4T6qKCk
        wQcqEPYYWUM/V5D0CqAHhbydtg==
X-Google-Smtp-Source: AMrXdXsbxjw+D5eWLBCb8CNoSXXL4Xqcy/WesZsTTs+KFRSY8Yc6NQBiZO9T1KIyD5qW8xQ2f3EjPw==
X-Received: by 2002:a05:600c:34cd:b0:3d3:5a42:bd5d with SMTP id d13-20020a05600c34cd00b003d35a42bd5dmr4115697wmq.32.1671536591281;
        Tue, 20 Dec 2022 03:43:11 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b003d1e3b1624dsm25251285wmq.2.2022.12.20.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 03:43:10 -0800 (PST)
Date:   Tue, 20 Dec 2022 11:43:09 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20221220114309.coi2o4ewosgouy6o@airbuntu>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
 <20221216233501.gh6m75e7s66dmjgo@airbuntu>
 <CAKfTPtA0M5XOP4UdkFeSNen98e842OfKTBDOt0r-y_TD4w54jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA0M5XOP4UdkFeSNen98e842OfKTBDOt0r-y_TD4w54jw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/22 09:07, Vincent Guittot wrote:
> On Sat, 17 Dec 2022 at 00:35, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > Hi
> >
> > On 07/19/19 15:59, Juri Lelli wrote:
> > > When the topology of root domains is modified by CPUset or CPUhotplug
> > > operations information about the current deadline bandwidth held in the
> > > root domain is lost.
> > >
> > > This patch addresses the issue by recalculating the lost deadline
> > > bandwidth information by circling through the deadline tasks held in
> > > CPUsets and adding their current load to the root domain they are
> > > associated with.
> > >
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > > ---
> >
> > We see that rebuild_root_domain() can take 10+ ms (I get a max of 20ms quite
> > consistently) on suspend/resume.
> >
> > Do we actually need to rebuild_root_domain() if we're going through
> > a suspend/resume cycle?
> 
> During suspend to ram, there are cpus hotplug operation but If you use
> suspend to idle, you will skip cpus hotplug operation and its
> associated rebuild.

Thanks Vincent. I'll check on that - but if we want to keep suspend to ram?
Do we really to incur this hit?


Thanks

--
Qais Yousef
