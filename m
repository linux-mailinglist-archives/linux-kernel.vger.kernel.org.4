Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2166C6C0CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 10:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCTJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCTJGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 05:06:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188BDEFAC;
        Mon, 20 Mar 2023 02:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fBDCLgDROusp3YVfa1BNKVCbYNk4bPCVRJp8Y+Dd6zc=; b=gby7Pr28whMucYvxRxM4SHS0eO
        2+2vZZCn9wr5Nr+NUf0HJG+p3y0Rc0gQIL6V6PHAe0yE0fvyauZ4XR8Awf34xEPxhBFAb9cxvkjkd
        f+gmd4f+bch/JHYauBVkD6r+P9Q3Kwhns/MP1Fro8TaAbG8j4oXv1MqFxr2KCGb2V6Sdkofl5X+3T
        6rPS9liJSyXmAaf6xJ6x5wcRGkomuIExJbtj73zquzNHeSBA/cHRKrdSQO8h4gbi2mebok5kvT1wB
        3+xWdXxD/Mhke27MpLYh0lx6c+5bM7NTjwW+tCHrqp7AP9TvzCfU5bPZOlE5WYopZPuqjpHVgUtIk
        vPfg6BZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1peBSq-000rfv-Os; Mon, 20 Mar 2023 09:06:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E171A300392;
        Mon, 20 Mar 2023 10:05:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 787CD209F7546; Mon, 20 Mar 2023 10:05:58 +0100 (CET)
Date:   Mon, 20 Mar 2023 10:05:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Klimov <alexey.klimov@linaro.org>
Cc:     draszik@google.com, peter.griffin@linaro.org,
        willmcvicker@google.com, mingo@kernel.org, ulf.hansson@linaro.org,
        tony@atomide.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        alim.akhtar@samsung.com, regressions@lists.linux.dev,
        avri.altman@wdc.com, bvanassche@acm.org, klimova@google.com
Subject: Re: [REGRESSION] CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait()
 and slow-stuck reboots
Message-ID: <20230320090558.GF2194297@hirez.programming.kicks-ass.net>
References: <20230314230004.961993-1-alexey.klimov@linaro.org>
 <20230315111606.GB2006103@hirez.programming.kicks-ass.net>
 <CANgGJDpd4Gm5HhQW__oMAv1yUqSPZ7FSGoQLYTmug=TUk4cn4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgGJDpd4Gm5HhQW__oMAv1yUqSPZ7FSGoQLYTmug=TUk4cn4g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:11:25AM +0000, Alexey Klimov wrote:
> On Wed, 15 Mar 2023 at 11:16, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > (could you wrap your email please)
> 
> Ouch. Sorry.
> 
> > On Tue, Mar 14, 2023 at 11:00:04PM +0000, Alexey Klimov wrote:
> > > #regzbot introduced: 0c5ffc3d7b15 #regzbot title:
> > > CPUIDLE_FLAG_RCU_IDLE, blk_mq_freeze_queue_wait() and slow-stuck
> > > reboots
> > >
> > > The upstream changes are being merged into android-mainline repo and
> > > at some point we started to observe kernel panics on reboot or long
> > > reboot times.
> >
> > On what hardware? I find it somewhat hard to follow this DT code :/
> 
> Pixel 6.

What actual cpuidle driver is that thing using? Is there any out-of-tree
code involved? Mark tells me anything arm64 should be using PSCI, so let
me to stare hard at that again.
