Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E792B6A71C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 18:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCAREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 12:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjCAREB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:04:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C593C0E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 09:03:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so12351621wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qUHKTRcQh3URDtHGlGaA089RX+46wq6JZY7f9xT1DBI=;
        b=2O6UAvj6zfjZ/qTx+DC1jnzc4oofYRirSDiuT9o8rhJ/6BEiPA4+rcBx4atFEYGEIo
         QVdj2yopC3IIfoL06yzTsC3ziAmJYMHVp28B/iZfCAryxbSMgsa3kgv/phahYvjdTBzb
         Z/2osNzuFnLNlGTIvz/JMmEPzwLmZAOY13uQsvapEDGujowt6lWX6AE8hfelFeGUxisa
         CJNyd0S6acdvftMLIIDqsimJ3mYWYm9fdb/HVEiQhLot1fGCgY3NO75b80K0cta4Mx61
         J5BxMt3zLEk/F+OPrB+G6242679o0jxvLR4EnQao/I7ez0xvSyFY5dK4MelBSfYqGIyZ
         x/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUHKTRcQh3URDtHGlGaA089RX+46wq6JZY7f9xT1DBI=;
        b=sTGH3yPZ5bqw/Ix3gUk3UNxa0c3XuMYKgQBRN5BaK7/p65oWDR3oHXXEyCwgQDvLQ2
         qoUjLgC4kEhNP9nPnlcoG1edE+qIQttbCS6UTthMa5wy1/QjwL0MCcCEwbxoaXxUgAEy
         C9xInhvmFmPcaIeJbmkK92A+w2h82FA+hdlzLW+adEc/zW3UIWaQYIlXc5u/5LZzXBE6
         LuZB55xVTTsORgu0ljau/yby6srPd+m+hCG1NJNQwA9AmMorznfJuuGDe3Rozmrsmi9i
         Jzqspw3/yewFw1/6kJhMSzaBr4HW3ap4QAwX2U+icuXRUc4gyaSL/qUhrIAfX4aFACaB
         5GbA==
X-Gm-Message-State: AO0yUKWqBopPTe4+9fjeG2d9ye2xK3tN4vTOeo3VzsvxRzBDLRY8feu9
        BzjRRv7G1U/hrPV4n1Zlp0yEvg==
X-Google-Smtp-Source: AK7set8vQqf910uXvU8gXb+dtW0FrWBh+y0eZXgna9uwh5OHAKzuXs0cw2hHMMTvzp4hl3cfxLpuSQ==
X-Received: by 2002:a05:600c:3093:b0:3eb:3104:efef with SMTP id g19-20020a05600c309300b003eb3104efefmr5425757wmn.31.1677690204651;
        Wed, 01 Mar 2023 09:03:24 -0800 (PST)
Received: from airbuntu (host86-168-251-3.range86-168.btcentralplus.com. [86.168.251.3])
        by smtp.gmail.com with ESMTPSA id z26-20020a1c4c1a000000b003eb395a8280sm107158wmf.37.2023.03.01.09.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:03:24 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:03:22 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
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
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on
 suspend-resume
Message-ID: <20230301170322.xthlso7jfkixlyex@airbuntu>
References: <20230206221428.2125324-1-qyousef@layalina.io>
 <20230223153859.37tqoqk33oc6tv7o@airbuntu>
 <5f087dd8-3e39-ce83-fe24-afa5179c05d9@arm.com>
 <20230227205725.dipvh3i7dvyrv4tv@airbuntu>
 <5a1e58bf-7eb2-bd7a-7e19-7864428a2b83@arm.com>
 <20230228174627.vja5aejq27dsta2u@airbuntu>
 <Y/7/SLzvK8LfB29z@localhost.localdomain>
 <20230301122852.zgzreby42lh2zf6w@airbuntu>
 <Y/9gmDRlGOChIwpf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/9gmDRlGOChIwpf@localhost.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/23 15:26, Juri Lelli wrote:
> On 01/03/23 12:28, Qais Yousef wrote:
> > On 03/01/23 08:31, Juri Lelli wrote:
> 
> ...
> 
> > > Not ignoring you guys here, but it turns out I'm quite bogged down with
> > > other stuff at the moment. :/ So, apologies and I'll try to get to this
> > > asap. Thanks a lot for all your efforts and time reviewing so far!
> > 
> > Np, I can feel you :-)
> 
> Eh. :/

I hope I did not offend. That was meant as no pressure, I understand.

> 
> BTW, do you have a repro script of some sort handy I might play with?

Sorry no. You'll just need to suspend to ram. I had a simple patch to measure
the time around the call and trace_printk'ed the result.

I was working on a android phone which just suspends to ram if you turn the
screen off and disconnect the usb.

I think you can use rtcwake in normal desktop environment. Something like

	sudo rtcwake -u -s 5 -m mem


Thanks!

--
Qais Yousef
