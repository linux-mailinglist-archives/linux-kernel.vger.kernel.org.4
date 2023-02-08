Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD468F216
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBHPfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:35:42 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D263644C;
        Wed,  8 Feb 2023 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q9g0YumBHPrmwtZpj+oYc2ptwRNiT+Wulg1WoQ0QQtA=; b=XkY0Z4fGlO+ZrWb1lfh7LV5kap
        rHuzPm+Us75nMR0NYy3zWJikseoNeVZ7ze5iRfXi/+yrRR7aDRBStc2wliaDpHfWw/EQItuf61E0/
        tUXWJgwVCI3niF4K3ycYiQKyl0IGFCYAbUZIJAtB6v2VuL6UO77sPYD2NLyoksMTCsKeJbCw6Evc0
        AUOt468t4hs0jQ0me/mqqJXC3cgXk5yIN1cwYU+s4bRyurvcuLhGIme95akFNLr6N0BipwuMYZ6js
        d3YTihEJhabMUbd1Oqip6/OGlDC7ScEhYZMHUp8YBhg/2H8p/ChE2h9y2M+77WDE868gBRNPglEv0
        WWzCLHqw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1pPmTj-007zoT-Cr; Wed, 08 Feb 2023 17:35:23 +0200
Message-ID: <d6a2a1d5-fc3b-2510-e5e8-e3f36f1652d5@kapsi.fi>
Date:   Wed, 8 Feb 2023 17:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] thermal: tegra-bpmp: Always (re)program trip
 temperatures
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Srikar Srimath Tirumala <srikars@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Timo Alho <talho@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230207135610.3100865-1-cyndis@kapsi.fi>
 <20230207135610.3100865-2-cyndis@kapsi.fi> <Y+N8uMO3V5+YNm2E@orome>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <Y+N8uMO3V5+YNm2E@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 12:43, Thierry Reding wrote:
> On Tue, Feb 07, 2023 at 03:56:09PM +0200, Mikko Perttunen wrote:
>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>
>> In the rare case that calculation of trip temperatures would result
>> in the same trip temperatures that were previously programmed, the
>> thermal core skips calling .set_trips.
> 
> That seems like an appropriate optimization.
> 
>> However, presently, if it is not called, we may end up with no trip
>> temperatures programmed at all.
> 
> I have a hard time understanding when this would happen. prev_low_trip
> and prev_high_trip are -INT_MAX and INT_MAX, respectively, so these are
> unlikely to be the result of anything we compute at runtime, based on
> temperatures specified in DT, for example.

Consider:

Temperature is 45C.
set_trips is called with low=40C high=50C. We program accordingly.
Temperature goes to 55C. Trip point triggers.
Before execution gets to CPU, temperature returns to 45C.
CPU gets the MRQ, calls into thermal core to update.
Thermal core notices that temperature is 45C and sets again the same 
low=40C high=50C trip points, does not call set_trips.
No trip point is programmed to BPMP and we never get trips again.

The above, of course, is rather unlikely to happen, but theoretically 
possible nevertheless.

Alternatively, where I discovered the issue originally, was the issue 
described in the last paragraph of the commit message; see below.

> 
> So I would expect ->set_trips() to get called at least once when the
> thermal zones are first registered. Are you saying there are cases where
> ->set_trips() doesn't get called at all?

No, not saying that. It will get called when registering the zone 
initially, but see below.

> 
>> To avoid this, make set_trips a no-op and in places where it would be
>> called, instead unconditionally program trip temperatures to the last
>> specified temperatures.
> 
> Again, this seems more like a workaround for an issue that exists
> elsewhere. If ->set_trips() doesn't always get called when it should be,
> then that's what we should fix.

I think it depends on what the interpretation is with set_trips. If the 
interpretation is that the the trips configured in the hardware are 
persistent (not disabled when a trip occurs), then the current 
implementation and this patch make sense. Otherwise a change in the 
thermal core would make sense.

> 
>> This also fixes the situation where a trip is triggered between
>> registering a thermal zone and registering the trip MRQ handler, in
>> which case we would also get stuck.
> 
> Could this be fixed by requesting the MRQ prior to registering the
> zones? That seems like the more appropriate fix for this issue. It's
> similar to how we typically register IRQ handlers before enabling a
> device to make sure we don't miss any interrupts.

I considered that -- there are two reasons I didn't go for it:

1. It doesn't solve the race condition described in the first part of 
the message
2. To handle the incoming MRQ, zone->tzd needs to be set. But we only 
get tzd from the zone registration call, and already before that call 
returns, set_trips has been called and we might have received an MRQ. I 
tested using a completion object to block in the MRQ handler until the 
initialization completes, but that's pretty ugly as well.

> 
> Thierry

Thanks,
Mikko
