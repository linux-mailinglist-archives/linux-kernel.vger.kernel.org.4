Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108B6E4230
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDQIJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjDQIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:09:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00425585
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:09:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681718951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh7I3HDrPo+//oWDymjnONVtxVeELt5F1rHHaav1vxA=;
        b=KYCGIgs9db3NejMx//bF2IJi/hGwzy1oPLRe7psPVIGjGALewQFoJoDH7kxu/jgcctDb2Z
        CKP8dAlIA+cQ36EUZNB+W4Eb2ebIsxa0Ob32DDR/oZuPE4WDZvBMyl628K26O2ypDRDfT+
        Iqz6MZTUbTgs8r+dWVNIdhXcCm7TcA7YgI/cQxPopQlUHQ8LUPU/zkJOSm4wc+M022gdVH
        X7RAPOdH0NUqzVGY5T+W3mZBP1wh8thAdp53wv71KqmuyuJVCrDGl7I5QSAHUvFO4bnURt
        LN55j1vGNw2bREkikC/HN0Ha214CPSZ6iNlfRPohBp1ak9alGNX0BOnawvGePw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681718951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bh7I3HDrPo+//oWDymjnONVtxVeELt5F1rHHaav1vxA=;
        b=R5NSZu/m7HnuP+k7fvEJ42Et4yeqyZHOtezLCRoH4is1IMcYD2SikkNqcnxp1zO4dUCRVa
        Fu2rwIWfaKkkGnCw==
To:     Dave Chinner <dchinner@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ye Bin <yebin10@huawei.com>, linux-mm@kvack.org
Subject: Re: [patch 1/3] lib/percpu_counter: Fix CPU hotplug handling
In-Reply-To: <ZDyqYYq+HgxCKri4@rh>
References: <20230414162755.281993820@linutronix.de>
 <20230414162841.166896739@linutronix.de> <ZDyqYYq+HgxCKri4@rh>
Date:   Mon, 17 Apr 2023 10:09:09 +0200
Message-ID: <877cub53ru.ffs@tglx>
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

On Mon, Apr 17 2023 at 12:09, Dave Chinner wrote:
> On Fri, Apr 14, 2023 at 06:30:43PM +0200, Thomas Gleixner wrote:
>> -	percpu_counter_batch = max(32, nr*2);
>> +static int percpu_counter_cpu_starting(unsigned int cpu)
>> +{
>> +	/* If invoked during hotplug @cpu is not yet marked online. */
>> +	compute_batch_value(cpu_online(cpu) ? 0 : 1);
>>  	return 0;
>>  }
>
> So this changes the batch size based on whether the CPU is starting
> or dying to try to get _compare() to fall into the slow path
> correctly?

Right. That's not new. The original code did the same.

> How is this supposed to work with counters that have caller supplied
> custom batch sizes? i.e. use percpu_counter_add_batch() and
> __percpu_counter_compare() with their own batch sizes directly?
> Do they now need to add their own cpu hotplug hooks to
> screw around with their batch sizes as well?

Now? Nothing has changed here. Just the point where the batch size
computation is called is different. The original code did it in the
dynamic online callback late on hotplug and in the dead (cleanup)
callback late on unplug.

The external batch sizes always have been independent of this.

Thanks,

        tglx
