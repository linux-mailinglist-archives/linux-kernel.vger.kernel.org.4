Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1455BCA08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiISKyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiISKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:53:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07D2A251
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UCSeoFTRn0rDIVGvHckFfpCejRDODjD/mepPzagQ650=; b=WQ8VV5a15E753SKXoSSrvaOmTK
        +5eJBoPoWcXZaoeD78zrwhcNU1n9tiKi9Jt5DpggN6dKzKv0lvCw+NECtgRz09zIpEQLR2SJIuMex
        UuK2cb4oWajOckfEXfLBvmAOkxK+9ve4UrQ6DJV31mxUHXJjmEkcSHU89YENfT3mvbvTAc3OJyjiX
        pXzqy4P2lmTtgFiSAZPWQg5G54RyCt8+w4pGrQGRF2SIbgu4DnC2YwrpQ7IzrQnd/kxHdwJygWsdc
        EekkL4xchOery8DGMR0V8cf5/VGVlHvgJ0gjpzfZGm+sVKWts1FzeAsAg34Gzl/auPR3R4oBkdt0v
        NsiNmL0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaEKA-004dUO-JC; Mon, 19 Sep 2022 10:48:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70027300202;
        Mon, 19 Sep 2022 12:48:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4ED0B20188683; Mon, 19 Sep 2022 12:48:23 +0200 (CEST)
Date:   Mon, 19 Sep 2022 12:48:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] lockdep: report name and key when
 look_up_lock_class() got confused
Message-ID: <YyhI93taOenZMHrY@hirez.programming.kicks-ass.net>
References: <55111c45-0f8f-c6f9-640c-6919939b77dd@I-love.SAKURA.ne.jp>
 <YydkEtcVc0GtCizz@boqun-archlinux>
 <bd99391e-f787-efe9-5ec6-3c6dc4c587b0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd99391e-f787-efe9-5ec6-3c6dc4c587b0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 09:52:13AM +0900, Tetsuo Handa wrote:
> Printing this information will be helpful.
> 
>   ------------[ cut here ]------------
>   Looking for class "l2tp_sock" with key l2tp_socket_class, but found a different class "slock-AF_INET6" with the same key
>   WARNING: CPU: 1 PID: 14195 at kernel/locking/lockdep.c:940 look_up_lock_class+0xcc/0x140
>   Modules linked in:
>   CPU: 1 PID: 14195 Comm: a.out Not tainted 6.0.0-rc6-dirty #863
>   Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
>   RIP: 0010:look_up_lock_class+0xcc/0x140
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Urgh, you hitting that WARN enough times to want to improve it seems to
suggest your machine is quite sick.

Anyway, patch is ok I suppose.
