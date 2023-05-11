Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E046FED3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbjEKH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjEKH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:56:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB6269E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 00:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+CGH7YHU79D1x2zo+JX/L+1Yeo4Kpnw8RAg9mt4T5fI=; b=JaYNfxN6UpDjkg5TCFsg9BwlN+
        c3txs50rIc3hX+JmCPER1Hf2OJ0PvJ42OxnSzvJ0Vbi2Mta7+67wKYBtcaDiQmphbwPBIJ3GZEr5m
        zZlA0Sy/tUFu4dFj327ul1jgXZhqfOJ2HcaSXe2NzKlloGT5etzz4BaWeV4u7zZHeFe+BOhyCIZZV
        DBHeUz2iirtSu7ToxV5lgyWz+5QtGJJ7fd7I9qmEtdvZWpKosNwMZQ/VuhYRBPBfji7KY+5vSBLs3
        TpPTaXhpTweZBq8I+hJKrv3Yh/wC7S5t59n+xdZScabJ9jlSJ0DBAjL0YpZJp9FuQKLJswTHJ+uzG
        AXpqQ42A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1px1AA-008AyE-2u;
        Thu, 11 May 2023 07:56:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7948300023;
        Thu, 11 May 2023 09:56:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D70C235CC442; Thu, 11 May 2023 09:56:32 +0200 (CEST)
Date:   Thu, 11 May 2023 09:56:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [RFD] posix-timers: CRIU woes
Message-ID: <20230511075632.GR4253@hirez.programming.kicks-ass.net>
References: <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx>
 <87v8h62vwp.ffs@tglx>
 <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx>
 <875y911xeg.ffs@tglx>
 <87ednpyyeo.ffs@tglx>
 <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com>
 <87wn1gy4e6.ffs@tglx>
 <005a944c-ed2e-6010-a534-26d5947402da@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005a944c-ed2e-6010-a534-26d5947402da@virtuozzo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 12:12:32PM +0800, Pavel Tikhomirov wrote:
> Not sure how kernel memory consumption increases with sparse timer IDs,
> global hashtable (posix_timers_hashtable) is the same size anyway, entries
> in hlists can be distributed differently as hash depends on id directly but
> we have same number of entries. Probably I miss something, why do we need
> dense IDs?

The proposal was to remove the global hash and use a signal_struct based
xarray instead.
