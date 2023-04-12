Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51F46DFA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjDLPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjDLPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:37:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A283E3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:37:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681313848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3KOK2E2+YL0UWZuMxIugWW/8u560Xs4Osw19RDEBOc=;
        b=jJKraW6sibyV19gFvOdSg/5yJbD6XCrhTn/9AosBMVHK+hr1IUMi2d56CHi4QGDf5CEaEq
        PzmGZMGZjcdYcDZLQZDltUhPS+yZDUtP0MMT43bzcC5AX9sYO0+G4CeR5ZjxAzrYLEemyu
        F8VZTjrR5VPrqbErETPifdMPyKKNigvES7yMboQ1m501TOX60p7fE2ghdj5MmLDgqhsv9n
        glICORo8KtB71L5THRv+lNrZZPBFCX2ZVuxXfNGKrlXrZWbGK9A/MjHOcos8CIPbPtvaM1
        HkTKlyJZ2h0xLC/lMGiFfG1tXsqaIpOerJYNwiSE0CwO2eXjLtFz8uxCWIijLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681313848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k3KOK2E2+YL0UWZuMxIugWW/8u560Xs4Osw19RDEBOc=;
        b=EY8KgjIqD4lzsVy1JVTclcJnAREGgvIFTNOVYzfEz5HAU8G988gz5Wdo1w7gqZaxENeA63
        darbyuPS1kMwFoBA==
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, johan+linaro@kernel.org, isaku.yamahata@intel.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com
Subject: Re: [PATCH v2] x86/ioapic: Don't return 0 from
 arch_dynirq_lower_bound()
In-Reply-To: <20230328144834.GA17868@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1679988604-20308-1-git-send-email-ssengar@linux.microsoft.com>
 <3D028B51-35D7-435F-B912-DC5C0D6C36C6@zytor.com>
 <20230328144834.GA17868@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date:   Wed, 12 Apr 2023 17:37:27 +0200
Message-ID: <87v8i1yuvc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28 2023 at 07:48, Saurabh Singh Sengar wrote:
> On Tue, Mar 28, 2023 at 06:59:04AM -0700, H. Peter Anvin wrote:
>> 
>> Is there any reason why this variable can't be initialized to a fixed nonzero number, like 16?
>
> Yes, initializing gst_top to any non-zero value should fix this issue.
> At first I thought to intialize gst_top to 1.

That works only in your case. Some boot time registrations of IO_APICs
use gsi_top as the base. So initializing gsi_top to N would move IOAPIC[0]
interrupts out to irq N... and make the legacy interrupts fail.

That whole IOAPIC registration could do with some major cleanup, but
that's a different story.

Thanks,

        tglx
