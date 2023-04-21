Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D766EB2E8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjDUU2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDUU2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:28:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C101730
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:28:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682108896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JI7ghwB60oMagdu7Y4eAitqD3tX1oyMmnXoP24a20tM=;
        b=0kLRQ1gf1Sdu2o1z8yEDN0c6EOY8Ae/lP/X2jXYKehyoWBCmWbZXfIgScKNTzJY7i56k2c
        xSEXiIgIGf9o4PhnuxcZObn5v/CbaEnfu/PlUrxhu1rOtf2QaPqvGGJ3PISTLqMzYc74OB
        6T54mn+wgtUbBUywAVteIj6F7wc3Z6E1+EiRjOMEoBr/Ofqwvo8lZ1Hsfzq4JDWhI3B7GA
        oDBeGRpvbhkG0/SQOwszR4h4S6D1kZHdGReRn80HcSSSPiQefrAF/G7nTHISSHwKtVplDe
        zeIGUMjyiJnt3WWgRfJLGbyqzXWW/3arxUEMe1SwA+YJbnIo5MCBqS8OOyOAxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682108896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JI7ghwB60oMagdu7Y4eAitqD3tX1oyMmnXoP24a20tM=;
        b=ZsX6s4nMtJICTg8yewqdPARIQF02Q8zdfT+NRGplgu/YRrHnuWlQJ0BvABK0ULUW4lI6FA
        XgpvRAK884bH4WBg==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
In-Reply-To: <ZELADFhjWR2Swn3l@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen> <87leil2r7v.ffs@tglx>
 <ZELADFhjWR2Swn3l@lothringen>
Date:   Fri, 21 Apr 2023 22:28:15 +0200
Message-ID: <87pm7x0ylc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21 2023 at 18:55, Frederic Weisbecker wrote:
> On Fri, Apr 21, 2023 at 05:24:36PM +0200, Thomas Gleixner wrote:
>> It's far from trivial because you'd need correlation between the
>> interrupt entry and the enter to and return from arch_cpu_idle().
>> 
>> I fear manual inspection is the main tool here :(
>
> I thought so :)
>
> I'm already halfway through the architectures, then will come the cpuidle drivers...

For objtool covered architectures you might come up with some annotation
which allows objtool to yell, when it discovers a local_irq_enable() or
such at the wrong place.

Thanks,

        tglx
