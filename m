Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7EF720051
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 13:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235026AbjFBLX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 07:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjFBLX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:23:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E839919B;
        Fri,  2 Jun 2023 04:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CW5FFS/sfC8BHeiLTKhUb9W7eHeglZWQrHMkx8btbA8=; b=OU/j2ooPhXxxOw3rjviWIUTvdj
        8R1/ULne0Ku4w2Wh2VrqMchcHZpojiBD7WG442NEIG8mL4zgsiT9wHAH02BRt2xkCup9btESHDX0N
        rpG+5Tsn5vj/Q0dW2pxNRpA8h0rgUY62GCYoVK9np7sJb1TVoU1/Z44BdWKz6U5b/Pfbazw34m2Sh
        ifZ2pa98+9oF/LFtPv97wEV+nbTYgZfC6oKHCTCBQP2rboTBif8iV2GTIy9++j4fVOGXcACUEOaCx
        3npYpmNO8rrfUdAMeEDdEp4Oj4ms2AJYcZofQTHWjiv285m1dLSpHJddkvCxCbfEQk3lUTqfkADy+
        PEiCPeAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q52sl-001JSl-2G;
        Fri, 02 Jun 2023 11:23:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CC2930031F;
        Fri,  2 Jun 2023 13:23:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 348BB243B0938; Fri,  2 Jun 2023 13:23:47 +0200 (CEST)
Date:   Fri, 2 Jun 2023 13:23:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, x86@kernel.org
Subject: Re: [tip: sched/core] sched/fair: Multi-LLC select_idle_sibling()
Message-ID: <20230602112347.GF620383@hirez.programming.kicks-ass.net>
References: <168553468754.404.2298362895524875073.tip-bot2@tip-bot2>
 <3de5c24f-6437-f21b-ed61-76b86a199e8c@amd.com>
 <20230601111326.GV4253@hirez.programming.kicks-ass.net>
 <20230601115643.GX4253@hirez.programming.kicks-ass.net>
 <20230601120001.GJ38236@hirez.programming.kicks-ass.net>
 <20230601145113.GA559993@hirez.programming.kicks-ass.net>
 <a78b5df0-2374-29bf-f948-3054f1e7e46c@amd.com>
 <ZHmxHWbkQWvcq+bZ@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHmxHWbkQWvcq+bZ@BLR-5CG11610CF.amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 02:36:37PM +0530, Gautham R. Shenoy wrote:

> Yes, this is what the topology looks like
> 
> |---------------------------------------------------------------------------------| 
> |                                                                                 |
> |   ----------- ----------- -----------     ----------- ----------- -----------   |
> |   |(0-7)    | |(8-15)   | |(16-23)  |     |(48-55)  | |(56-63)  | |(64-71)  |   |
> |   | LLC0    | | LLC1    | | LLC2    |     | LLC6    | | LLC7    | | LLC8    |   |
> |   |(96-103) | |(104-111)| |(112-119)|     |(144-151)| |(152-159)| |(160-167)|   |
> |   ----------- ----------- -----------     ----------- ----------- -----------   |
> |                                                                                 |
> |                                                                                 |
> |   ----------- ----------- -----------     ----------- ----------- -----------   |
> |   |(24-31)  | |(32-39)  | |(40-47)  |     |(72-79)  | |(80-87)  | |(88-95)  |   |
> |   | LLC3    | | LLC4    | | LLC5    |     | LLC9    | | LLC10   | | LLC11   |   |
> |   |(120-127)| |(128-135)| |(136-143)|     |(168-175)| |(176-183)| |(184-191)|   |
> |   ----------- ----------- -----------     ----------- ----------- -----------   |
> |                                                                                 |
> |---------------------------------------------------------------------------------|

Yup, that's the pictures I found online.

> > I would think it is the latter since NPS4 does that but let me go verify.
> 
> 2 groups of 6 each is the vertical split which is NPS2.
> 
> 4 groups of 3 each is the vertical and horizontal split, which is
> NPS4.
> 
> In both these cases, currently the domain hierarchy
> 
> SMT --> MC --> NODE --> NUMA
> 
> where the NODE will be the parent of MC and be the 2nd level wakeup domain.
> 
> If we define CLS to be the group with 3 LLCs, which becomes the parent
> of the MC domain, then, the hierarchy would be
> 
> NPS1 : SMT --> MC --> CLS --> DIE
> NPS2 : SMT --> MC --> CLS --> NODE --> NUMA
> NPS4 : SMT --> MC --> CLS --> NUMA
> 
> NPS2 will have 5 domains within a single socket. Oh well!

I think cluster/CLS is taken for L2, we should not re-purpose that for
groups of L3.

Anyway, yes, 5 levels. Shouldn't be a problem though, right?
