Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E8642BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiLEPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiLEPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:38:32 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9298255
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 07:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1670254693; x=1701790693;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p5Y08WCauCkKV8rGN0y/sAMyI/lEE0FyECSha1h2tSI=;
  b=ctJ9TovAwOIFj1nAj6Y7SywP6uPHrM7HKBFwt/FraLrfSD0oyAnyxH67
   RJ8LvuqFzeq0W5Zb7n5nqFmVPRlgQvuEyH5aPEmH17nq1vVP5QV9tOFaY
   p6Pmk4P8ljkP+u4nz5cyS6clqnCg7S6iqV+04X4uRRME66sypy8AUf+1Y
   Y=;
X-IronPort-AV: E=Sophos;i="5.96,219,1665446400"; 
   d="scan'208";a="158006298"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 15:38:09 +0000
Received: from EX13MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-m6i4x-245b69b1.us-east-1.amazon.com (Postfix) with ESMTPS id 6B29E341E4A;
        Mon,  5 Dec 2022 15:38:06 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 5 Dec 2022 15:38:05 +0000
Received: from [192.168.4.128] (10.43.162.134) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20;
 Mon, 5 Dec 2022 15:38:04 +0000
Date:   Mon, 5 Dec 2022 09:38:02 -0600
From:   Geoff Blake <blakgeof@amazon.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] perf/arm-cmn: Cope with spurious IRQs better
In-Reply-To: <83d16969-9d23-1dc5-c9dd-03542b43a52e@arm.com>
Message-ID: <2bb86e97-6cef-700e-70ed-4f303da10fd9@amazon.com>
References: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com> <f41af5cb-7fc7-4bd3-ec9e-53071b9a41f9@amazon.com> <c34db006-4d5b-fb71-f998-63fcdcde6c0b@arm.com> <99fd664c-bf59-b8c0-29d0-6eccfc1c8e80@amazon.com>
 <83d16969-9d23-1dc5-c9dd-03542b43a52e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D42UWA004.ant.amazon.com (10.43.160.18) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >   From my perspective, this is a worse solution as now we're sweeping an
> > > > issue under the rug and consuming CPU cycles handling IRQs we should not
> > > > be getting in the first place.  While an overflow IRQ from the cmn
> > > > should
> > > > not be high frequency, there is a non-zero chance in the future it could
> > > > be and this could lead to a very hard to debug performance issue instead
> > > > of the current problem, which is discovering we need to clean up better
> > > > from a noisy kernel message.
> > > 
> > > Kexec is not the only possible source of spurious IRQs. If they cause a
> > > problem for this driver, that cannot be robustly addressed by trying to
> > > rely on whatever software might happen to run before this driver.
> > 
> > Sure, I can agree with the assertion a spurious IRQ could come from
> > anywhere, in that case though, shouldn't the behavior still be to log
> > spurious IRQs as a warning instead of silently sinking them?
> 
> We still have to handle the interrupt anyway to avoid it getting
> disabled behind our back, and beyond that it's not really something
> that's actionable by the user. What would we say?
> 
>        dev_warn(dev, "Something harmless, and in some cases expected,
> happened! If you've just rebooted after a kernel panic, maybe try having
> the kernel not panic?");
> 
> Perhaps that should be a core IRQ helper so that many other drivers can
> also call it too?
> 
> Furthermore if you're worried about performance implications from a
> theoretical interrupt storm, I can tell you from experience that logging
> to a serial console from a high-frequency interrupt handler is one of
> the best ways to cripple a system to the point where reaching for the
> power switch is the only option.

Logging unexpected events is necessary to give clues of what is going 
wrong before they implode on fully remote machines.  If you prefer to 
handle the IRQ here rather than in the bad_irq section, then can we at 
least have a WARN_ON() in the case where a spurious IRQ happens but no 
overflow bit is set.  

> The DTC_CTL documentation seems fairly unambiguous:
> 
> [0]     dt_en   Enables debug, trace, and PMU features
> 
> The design intent is that the PMU counters do not count when the entire
> PMU feature is disabled. I'm pretty sure I did confirm that empirically
> during development too (I recall the sheer number of different "enable"
> bits baffled me at the beginning, and there was actually one that did
> nothing, which I think did eventually get removed from the documentation).
> 
> Of course clearing PMCR_PMU_EN is sufficient to simply stop counting,
> which we also depend on for correct operation, but I believe clearing
> DT_EN allows it to put all of the DT logic into a quiescent state.

I took the other patch that writes 0 to DTC_CTL.dt_en only and put it in a 
loop of kexec'ing when the PMU is active for a few hours, I did not see 
anymore spurious IRQs (whereas with the stock driver I could reproduce in under 10 tries). 
You are correct Robin, that is all that is needed, and my code was overly 
cautious.

- Geoff
