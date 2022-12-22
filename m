Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA965470C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiLVUUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLVUUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:20:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5966120B7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0BYO2kAW7k52H9OS5slY/sSBgV7L3Xl29geQCdlNEks=; b=M2P8NEN072hQHBBVUn3H4XCKIO
        DkIrfyJPf5IeKHaWKBgq+M8hWRm+zVKuJ9ioRzGW2gZOel6C31y07fAYnB3lI7UOHhLQHHJHBC2Ly
        3XF9WaYQT1Q7S1RpneCCImI/NkSmNm88b4CFW3yr6OKnWwGinxIltowgnabDSEcKa35lFtGCadAT6
        mSa3xG8OYNV+piQcR6ToRiDrEtqVs8dVfJHcH5XKaE2xl1YbAi9Mfw7Xg2xvhlTVWUyho7bWvWfCa
        a5n4K9U0VJsA+eX3XzUUPi1xgSXbGQr+ISgJ7dyMj2w7UrftCv76HNhZ9P1eZK1WN5EizM3WfGtUc
        hnuN0V5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p8S2w-003vJh-KK; Thu, 22 Dec 2022 20:20:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 107273003D2;
        Thu, 22 Dec 2022 21:19:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC9272098A270; Thu, 22 Dec 2022 21:19:53 +0100 (CET)
Date:   Thu, 22 Dec 2022 21:19:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        Paul Gazzillo <Paul.Gazzillo@ucf.edu>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Subject: Re: Syzkaller found a bug: KASAN: use-after-free Write in put_pmu_ctx
Message-ID: <Y6S76ZqA/CX8Vx82@hirez.programming.kicks-ass.net>
References: <BN6PR07MB3185E78473482885FE72BCF3ABE89@BN6PR07MB3185.namprd07.prod.outlook.com>
 <CAG_fn=UZcDSqnD6+CezbdaekXqejRKm-W8V6ZHxQ+GGUwb3YdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UZcDSqnD6+CezbdaekXqejRKm-W8V6ZHxQ+GGUwb3YdA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 07:11:38PM +0100, Alexander Potapenko wrote:
> On Thu, Dec 22, 2022 at 6:40 PM Sanan Hasanov
> <sanan.hasanov@knights.ucf.edu> wrote:
> >
> > Good day, dear maintainers,
> 
> Hi Sanan,
> 
> > Config file: https://drive.google.com/file/d/1JutR21cgcf28flJVyLqDniNyrExMsSn_/view?usp=sharing
> >
> > Reproducer file: https://drive.google.com/file/d/1X31x8w4ULrtP_YnkD7_RCyW7FlwGewMR/view?usp=sharing
> 
> Any chance you can build with debug info enabled (CONFIG_DEBUG_INFO=y)?
> Then you'll be able to generate file:line information for the report
> (probably your syzkaller instance will do that for you, otherwise you
> can always use scripts/decode_stacktrace.sh)

Ok use Google before posting....

 https://lkml.kernel.org/r/000000000000a20a2e05f029c577@google.com
