Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD5743E28
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjF3PBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjF3PBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:01:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4795171E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:01:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so14146575e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688137268; x=1690729268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahf4iN0qt3X6fXGQpyVE3X/VovChKIPfO2Ax1JckjEQ=;
        b=3yh6L5c0Exj1o0zeTk4a6REXEYKM4fADuVl9BclOQhNxISU2t4fip9AXdWU/TxCkE2
         OqehUtaUgyceR46RN4c8vaFFCD/IVadlqcqp95eocOsazOWkdUAOwn55jgcBDaBUuqe+
         xbv7KeliCoitInjDNB+1JGj+VyukxrmP4K7wIGrgCQYfwGQRpfyqmpvkuWXft6QSVjVA
         +uPIMXW3U1J5hbLSPsGSsifGDMe2tls/RHw+zemHQBbSrRVPl1LI+/DSa3jGqqcrntRz
         SPiHnlysd2rdfqxUHmFa99MK/abqxrQtlvHM29PqtdM/GJp3KdNjSaKPlTy577HyXrXd
         vGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137268; x=1690729268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahf4iN0qt3X6fXGQpyVE3X/VovChKIPfO2Ax1JckjEQ=;
        b=JLS8YTjjRt5XhVE71/nhZyR8hEipmS9viGWx340vk19MYZ2rl+AFljGuYvy5nnTk+G
         4ci/fWRwjvIzEbLjAXPDi6XU0eFSkolKES3P9r/ujHUzR9MDtzoR6XbUCCEiEJBFownc
         f8HuXwxw0Ifm+0bFsH2GL4bM3kDGYZEnwEF2e1hUwdvJOd8D8vYacXrgVH+DAj2ZuHZO
         zn3RX4Ud8OKUptGZydXt5xixKiq5PFY6KLD/Mnzwdr8bXweRsDs9oBn0trc7Fu7vPzXA
         B6LrQJ2x4YoElDwEHRDIkinP8Vv5hY1U/fkV2i2uqWg0JvHxDcjMDwVIGHirJtbn18Ac
         qv9Q==
X-Gm-Message-State: AC+VfDzdrDgo3nkjt5xckMaID1qasEaVbwyczjHN0ixdBC+6Ut14iRJ9
        tfJZ0rlAZinAyvpQ/gU5GOHwJQ==
X-Google-Smtp-Source: ACHHUZ74pk8fAscwl4/V1VyKKVEfajAZpMtTT9HM7NTbJGdATFOVKQDPw1YOnaAs9I7gIMtI+MrUYQ==
X-Received: by 2002:a05:600c:364f:b0:3f9:b1e7:8a4b with SMTP id y15-20020a05600c364f00b003f9b1e78a4bmr2324106wmq.21.1688137268223;
        Fri, 30 Jun 2023 08:01:08 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm19293360wmb.8.2023.06.30.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:01:07 -0700 (PDT)
Date:   Fri, 30 Jun 2023 16:01:03 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/cputime: Make IRQ time accounting configurable at
 boot time
Message-ID: <20230630150103.pp7lhxko7gya65rx@airbuntu>
References: <20230615203745.1259-1-bvanassche@acm.org>
 <20230616074518.GW4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616074518.GW4253@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/23 09:45, Peter Zijlstra wrote:
> On Thu, Jun 15, 2023 at 01:37:26PM -0700, Bart Van Assche wrote:
> > Some producers of Android devices want IRQ time accounting enabled while
> > others want IRQ time accounting disabled. Hence, make IRQ time accounting
> > configurable at boot time.
> 
> Why would they want this disabled? IRQ time accounting avoids a number
> of issues under high irq/softirq pressure.
> 
> Disabling this makes no sense.

I think it is assumed that IRQ time accounting is only used for stat
collection (which is what I thought too), but based on this response I can see
it is used to ensure we account for stolen time in update_rq_clock_task() so it
helps to make it account more accurately for the time a task actually spent
running and doing useful work.

Bart, could you profile the cause of the high overhead? The config message says
a small perf impact, but 40% mentioned in your v2 is high. Could you try to
break down the problem further as we might be overlooking the true source of
overhead or miss an opportunity to improve the accounting logic instead?


Thanks

--
Qais Yousef
