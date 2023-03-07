Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DAB6AE1F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjCGOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCGONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:13:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD435BCA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e34Iqvr6gyZS37VW/1C63Y8nOm9Y+LfjVrnWyuPPiMA=; b=T01P46nwK9y3LCBuhX2NKziVrc
        vRqmiNsB6LWTHXfJtbPd9GT3aeBY/DVIUVvdcKBLREsvqYnjcQ829l3rUlGWyyU7tQBoA4DHiunYw
        igtZh5F68oEKy7q2N3WUs2NDeNWXaXVuGDip9bDCV1TST9tY7zO241ab1WcLtryDvSutFLq8oLxPc
        FabwXv2FAo5NTA/1mN7tyH3gWuJEQ5lEtAp/cmoM9eS3X0krEb1F+rA9L45LSOTGxVyjbO0bNPTAS
        POkWClpnHB/63vyt1PsqVNaMw0R0q1uwGXJTeZn4i8EuUAr1hEUr4H0iOwzu0ocz8vk6vrpt49zuB
        D5qV1g3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pZXzx-00H3qu-1A;
        Tue, 07 Mar 2023 14:09:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F7C5300642;
        Tue,  7 Mar 2023 15:08:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DC02423A1D2EA; Tue,  7 Mar 2023 15:08:58 +0100 (CET)
Date:   Tue, 7 Mar 2023 15:08:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230307140858.GE2017917@hirez.programming.kicks-ass.net>
References: <20230302062741.483079-1-jstultz@google.com>
 <20230302082414.77613351@gandalf.local.home>
 <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
 <20230302152103.2618f1b7@gandalf.local.home>
 <20230302163253.541ac3a8@gandalf.local.home>
 <20230302163603.223313ba@gandalf.local.home>
 <20230302165613.2dcc18ca@gandalf.local.home>
 <20230302200136.381468f0@gandalf.local.home>
 <20230303181134.GA1837196@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303181134.GA1837196@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 06:11:34PM +0000, Joel Fernandes wrote:
> What  makes the rtmutex spin logic different from normal mutex in this
> scenario, so that rtmutex wants to do that but normal ones dont?

Regular mutex uses osq 'lock' to serialize waiters and only the top
spinner gets to spin on the mutex itself, this greatly reduces the
contention on the mutex.

OSQ is FIFO, which is not what RT-mutex needs.
