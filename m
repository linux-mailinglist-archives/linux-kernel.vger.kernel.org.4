Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE763E55D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiK3XVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3XVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:21:01 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192F1A13E7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1669850022; x=1701386022;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bZPmwaW8zkxnyfuYSWuvlfr7TyglUbkuH8MZ7VOi87o=;
  b=lTWm7oBvCD5aWXgUflr99cEBh9aIU2wsWLX3pG6P9wqTqvHcbPNbl63R
   Z3jgWqxQRYvoyFaWN/iGSn/ucDCwFZcebHWgjrbmFyERIdmRbkkup1vL3
   Xn0/oi6+XsNbSHJYZJwCQ8Q1WK6wgR1YwCsv89+niJhQ9Ei4hD4JHwIFs
   g=;
X-IronPort-AV: E=Sophos;i="5.96,207,1665446400"; 
   d="scan'208";a="285771492"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 23:13:33 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id 419D6825BE;
        Wed, 30 Nov 2022 23:13:32 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Wed, 30 Nov 2022 23:13:31 +0000
Received: from [192.168.3.46] (10.43.162.134) by EX19D003UWC001.ant.amazon.com
 (10.13.138.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.20; Wed, 30 Nov 2022
 23:13:30 +0000
Date:   Wed, 30 Nov 2022 17:13:27 -0600
From:   Geoff Blake <blakgeof@amazon.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] perf/arm-cmn: Cope with spurious IRQs better
In-Reply-To: <c34db006-4d5b-fb71-f998-63fcdcde6c0b@arm.com>
Message-ID: <99fd664c-bf59-b8c0-29d0-6eccfc1c8e80@amazon.com>
References: <bc8183fcd7f6ca07b0d56aa8061d816485b84341.1669822447.git.robin.murphy@arm.com> <f41af5cb-7fc7-4bd3-ec9e-53071b9a41f9@amazon.com> <c34db006-4d5b-fb71-f998-63fcdcde6c0b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D49UWC001.ant.amazon.com (10.43.162.217) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-14.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >  From my perspective, this is a worse solution as now we're sweeping an
> > issue under the rug and consuming CPU cycles handling IRQs we should not
> > be getting in the first place.  While an overflow IRQ from the cmn should
> > not be high frequency, there is a non-zero chance in the future it could
> > be and this could lead to a very hard to debug performance issue instead
> > of the current problem, which is discovering we need to clean up better
> > from a noisy kernel message.
> 
> Kexec is not the only possible source of spurious IRQs. If they cause a
> problem for this driver, that cannot be robustly addressed by trying to
> rely on whatever software might happen to run before this driver.

Sure, I can agree with the assertion a spurious IRQ could come from 
anywhere, in that case though, shouldn't the behavior still be to log 
spurious IRQs as a warning instead of silently sinking them?  

> > The driver as best I can grok currently is optimized to limit the amount
> > of register writes for the common use-case, which is setting and unsetting
> > events, so all the wiring for the PMU to feed events to the DTC is done up
> > front on load: DTC_CTL's DT_EN bit is set immediately during probe, as is
> > OVFL_INTR_EN. All the DN states and DTM PMU_CONFIG_PMU_EN is deferred
> > for when an event is actually set, and here we go through all of them
> > anyways for each event unless its bynodeid, so the expense of setting
> > events grows linearly with the mesh size anyways.
> 
> If arm_cmn_init_dtc() writing 0 to PMCR didn't stop the PMU then we've
> got bigger problems, because that's how we expect to start and stop it
> in normal operation. I'm not ruling out that some subtle bug in that
> regard might exist, since I've still not yet had a chance to reproduce
> and observe this behaviour on my board, but I've also not seen
> sufficient evidence to suggest that that is the case either. (Now that
> I'm looking closely, I think there *is* actually a small oversight for
> the DTMs, but that would lead to different symptoms than you reported)

> At least the writes to PMOVSR_CLR *did* clearly work, because you're
> seeing the "nobody cared" message from the IRQ core rather than the
> WARN_ON(!dtc->counters[i]) which would happen if a fresh overflow was
> actually asserted. Currently I would expect to see up to 4 of those
> messages since there can be up to 4 IRQs, but once those are all
> requested, enabled, and "handled", all the spurious initially-latched
> state should be cleared and any *new* overflows will be indicated in
> PMOVSR. I don't see how a single IRQ could ever be unhandled more than
> once anyway, if the first time disables it.

I do see 4 of these "nobody cared" messages in all the times I've 
reproduced it, but saw no need to copy paste all of them in with the 
original post.  Looking back over the code I see why more clearly your 
assertion we only need to clear the DT_EN bit as the PMU is off at 
the DTC with the PMCR set to 0 on init, but it is really hard to 
see why that is with all the various places bits of configuration is done, 
but it is still not easy to verify if unsetting that bit is sufficient to 
not get into some odd corner cases.

Is there any argument against me taking another pass and try separating 
out discovery, from a shared reset/initialization code path?  

-Geoff 
