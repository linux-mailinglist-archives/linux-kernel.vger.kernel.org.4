Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B6743B10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjF3LoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjF3LoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:44:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFA0EE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:44:06 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc63c307fso6913845e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688125445; x=1690717445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4BaORtXOQANuAHa0XHUrDRcDQ5u87haOCwOJ/QZKJcM=;
        b=OyiXsGuw497EP7V6wUQb+Ab7vryifkkJamfN1rg7130w/NB1qOeMXXKNsf35GJT2o1
         eSMwPREyl3iCrELqahtGfvBpCjWNqfqbGoip1CQby5Uou5lg3k+4yllSeCfe8WfvfOVO
         DoprPQhJ5o8hw3p32RfMlmIjmRU3qAbi7geQXbtNpoMgI1h4hHf79lH9H76g5wWUIMsL
         cabEuQX/52gjjMfrSizrc0zV4thHpLUY79/ANFQlbmp1+pE9iZGor2iao67oBJYIL5yw
         ZoRRbpg3MkEjwUZes4nhc5yFT3arP/vPO9M/PYqZJdmnENp3QD8ygTIRy17WSGNsjmal
         W6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125445; x=1690717445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BaORtXOQANuAHa0XHUrDRcDQ5u87haOCwOJ/QZKJcM=;
        b=Wc8WMUhUFD7mKkMP1fhwEjsc3z+lrq1M7P0veh/RiSw+Yc7pkjPv6vbGvyyL9B8ay3
         hXt48A2VcZICPT7E9mwqFqX9WaP7GgLsl3j62gkfKUSVxA6utU4IxUJOuYVG4/uymeOw
         InLtE1yrbF2b4F3rTd6zZ2RlaK0hcYj4CSGwCLf5Ht0Kcqq+KxrEcQmHuuq4Kn2V0iG/
         31BV2fpQa0Eq/rFsruJS3PQJenzy6X7GP2MVTdFo6wv/lZ/mv47LyUCB9B5bAkuJTE5B
         MtxJtr4Ri+6AHZR/s40Bhk2+gEPFMJs9AT410uEGREHRv8xwWweOg2fXnd8hCxApgnGa
         OL6A==
X-Gm-Message-State: AC+VfDzdwCoJBuwYxU9J7yrkC3PXZbzba9nqPUqvfmd0ybEAqHom6lQK
        SBsH22s7wbkRlABSyCjU7tyYbQ==
X-Google-Smtp-Source: ACHHUZ6nEAk4S0KtQN3X3UjQ5iKhL3AFgYIVUi+TdOD4nZY6kC8rI63sOCF6elXmJnp64y4RZnRRIw==
X-Received: by 2002:a7b:c7d9:0:b0:3fb:c1df:a4fe with SMTP id z25-20020a7bc7d9000000b003fbc1dfa4femr1855253wmk.12.1688125444908;
        Fri, 30 Jun 2023 04:44:04 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c029900b003f42158288dsm21718610wmk.20.2023.06.30.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 04:44:04 -0700 (PDT)
Date:   Fri, 30 Jun 2023 12:44:03 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230630114403.ptbdy63ugmchr4hx@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <20230211172829.f2igueizqpwijjjz@airbuntu>
 <2a9ed73a-256c-4ace-6b26-e30ac69cbdbc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a9ed73a-256c-4ace-6b26-e30ac69cbdbc@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/23 12:50, Hongyan Xia wrote:
> Hi Qais,
> 
> On 2023-02-11 17:28, Qais Yousef wrote:
> > On 02/07/23 10:45, Vincent Guittot wrote:
> > > [...]
> > 
> > Isn't it better to go back to v1 form then? The inconsistent type paired with
> > the cast isn't getting too ugly for me :(
> > 
> > I don't think we can convert cpu_cap to long without having to do more work as
> > it is used with 'util'.
> 
> Sorry if I'm missing something obvious, but why can't we convert util to
> long? The only place I see which mixes with util is
> 
> 	lsub_positive(&cpu_cap, util);
> 
> but at this point both cpu_cap and util should have sane values (top bit not
> set) so doing clamped subtraction should just work fine?

I completely have this series paged out now. I'll consider this comment when
I prepare v3 - which I hope I'll have some down time in few weeks time to send
some fixes I have been sitting on for a bit.


Cheers

--
Qais Yousef
