Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C49F64893E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLITxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLITxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:53:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2CB6B9B4;
        Fri,  9 Dec 2022 11:53:31 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670615608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vgxfx/i9kYzvSYspcEHbEEAe0+JN+WukTrnXgbW7wY=;
        b=XKzurZMWPYfNQs5p8r67n9C0fgxSEHaIAiIYu/Pm1lg48sdwqnhkn7Y2m3GuOimHVqKjrT
        ExmvtetajHnYz97oVeQAOvkw3z1eae3xJ8sx9j70aX09BNoxePCV8udcvC7y+vIIUakS36
        OWtUNrj6pdrnhfqkkPTX+snB/fsYiNOIUw5Mmbnk1m46riCRmHpPtHf0xLZTf/3kafxUqf
        YrXJBT47POQZw2h3PdydAVknVXAzL0VBZkyMjrGwJjeVCzaNxHzE7Qr8YQlRCM59LRO5lt
        Lix9aNxms4sEB1lbL3qh5NstHDLK5l0TMpwN3f9bKZKbdfy95YTcsus4A0WW1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670615608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2vgxfx/i9kYzvSYspcEHbEEAe0+JN+WukTrnXgbW7wY=;
        b=LCJeDN4TmIQw3S7soch4Gm6FTqCBtP4eFmM6foQtsFJOjidIKlDvmHtRnJ887106JJAxya
        XIbQS2UyZJnBAuBQ==
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/19] irqdomain: fix mapping race and clean up locking
In-Reply-To: <Y5NfZ3bKTA15MWpu@hovoldconsulting.com>
References: <20221209140150.1453-1-johan+linaro@kernel.org>
 <87o7scd197.ffs@tglx> <Y5NfZ3bKTA15MWpu@hovoldconsulting.com>
Date:   Fri, 09 Dec 2022 20:53:28 +0100
Message-ID: <87lengcq13.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09 2022 at 17:16, Johan Hovold wrote:
> On Fri, Dec 09, 2022 at 04:51:00PM +0100, Thomas Gleixner wrote:
>> On Fri, Dec 09 2022 at 15:01, Johan Hovold wrote:
>> > Parallel probing (e.g. due to asynchronous probing) of devices that
>> > share interrupts can currently result in two mappings for the same
>> > hardware interrupt to be created.
>> >
>> > This series fixes this mapping race and clean up the irqdomain locking
>> > so that in the end the global irq_domain_mutex is only used for managing
>> > the likewise global irq_domain_list, while domain operations (e.g.
>> > IRQ allocations) use per-domain (hierarchy) locking.
>> 
>> Can you please rebase that on top of:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
>
> The series is based on next-20221208 which should contain that branch in
> its current state if I'm not mistaken.
>
> I just tried applying it on top of irq/core and did not notice any
> problems.

Sorry for the noise. Pilot error. -ETOOMANYBRANCHES :)
