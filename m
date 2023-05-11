Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9F6FEEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjEKJcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjEKJcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:32:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C9C72B9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:32:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683797559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1WvvOBcv1MIREGwpXFPvzLdR3fbc4WwQMQtVTZ3Cn0=;
        b=aBDsCS0c2QdGx2obUZCq9kiI1xIjPaOk+MUetd6Y5Hm6h39VvAYPs7vGPmdZqKq46UGq5Y
        /TBzuwpKQashesg0z8mxi8qyEAT4t3ojoYkLteoWLA667eXjTZnoy741wDlx36dz0XB7pv
        BgvfvG7IdHx22mIwnF13Fr/b8OxIchmfnSlzo+fv97VTSvxZhuPWVz2kDLGJ+le4AxysuO
        NQkZCqPunfKKYAIOUM8orwB0ULkfwKRGyhqiJ9Pg8tbkxKwMyKoDWAn/gaJk2iDVYQJUif
        EgVEW5Vd9holcwhtH0tW3V8JdL3KUZ40MTkayk42M5Nj+khmBFdgFJ+cGbS+Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683797559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C1WvvOBcv1MIREGwpXFPvzLdR3fbc4WwQMQtVTZ3Cn0=;
        b=4vrOZ8Xul10X/FUxyVDB++znbE3QjQFAPiLy4sn8fwf837KAGtGnT9lfXhV0mNJgBt1np6
        lryB+wNP7RmSzQCQ==
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Emelyanov <xemul@openvz.org>
Subject: Re: [RFD] posix-timers: CRIU woes
In-Reply-To: <005a944c-ed2e-6010-a534-26d5947402da@virtuozzo.com>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.932345089@linutronix.de> <ZFUXrCZtWyNG3Esi@lothringen>
 <87zg6i2xn3.ffs@tglx> <87v8h62vwp.ffs@tglx> <878rdy32ri.ffs@tglx>
 <87v8h126p2.ffs@tglx> <875y911xeg.ffs@tglx> <87ednpyyeo.ffs@tglx>
 <009e7658-1377-cc79-7a42-4dda8fec5af0@virtuozzo.com> <87wn1gy4e6.ffs@tglx>
 <005a944c-ed2e-6010-a534-26d5947402da@virtuozzo.com>
Date:   Thu, 11 May 2023 11:32:38 +0200
Message-ID: <87ttwjcix5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11 2023 at 12:12, Pavel Tikhomirov wrote:
> On 10.05.2023 16:30, Thomas Gleixner wrote:
>> The downside is that this allows to create stupidly sparse timer IDs
>> even for the non CRIU case, which increases per process kernel memory
>> consumption and creates slightly more overhead in the signal delivery
>> path. The latter is a burden on the process owning the timer and not
>> affecting expiry, which is a context stealing operation. The memory part
>> needs eventually some thoughts vs. accounting.
>> 
>> If the 'explicit at ID' option is not used then the ID mechanism is
>> optimzied for dense IDs by using the first available ID in a bottom up
>> search, which recovers holes created by a timer_delete() operation.
>
> Not sure how kernel memory consumption increases with sparse timer IDs, 
> global hashtable (posix_timers_hashtable) is the same size anyway, 
> entries in hlists can be distributed differently as hash depends on id 
> directly but we have same number of entries. Probably I miss something, 
> why do we need dense IDs?

Because I want to get rid of the global hash table as I explained in my
summary mail.

Thanks,

        tglx
