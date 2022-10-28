Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE5611555
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 17:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiJ1PBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJ1PBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:01:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A0A5CE98E;
        Fri, 28 Oct 2022 08:01:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54C691FB;
        Fri, 28 Oct 2022 08:01:27 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.68.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59DA53F534;
        Fri, 28 Oct 2022 08:01:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:00:43 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Message-ID: <Y1vum4BECMf2BXQW@e126311.manchester.arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
 <CAJZ5v0gvAtpzdQo0Tj13ZGFcop8fdNht7e_Nc_UNYCgbU1zZLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gvAtpzdQo0Tj13ZGFcop8fdNht7e_Nc_UNYCgbU1zZLA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 03:12:43PM +0200, Rafael J. Wysocki wrote:

> > The result being that this util-aware TEO variant while using much less
> > C1 and decreasing the percentage of too deep sleeps from ~24% to ~3% in
> > PCMark Web Browsing also uses almost 2% less power. Clearly the power is
> > being wasted on not hitting C1 residency over and over.
> 
> Hmm.  The PCMark Web Browsing table in your cover letter doesn't indicate that.
> 
> The "gmean power usage" there for "teo + util-aware" is 205, whereas
> for "teo" alone it is 187.8.  This is still arguably balanced by the
> latency difference (~100 us vs ~185 us, respectively), but this looks
> like trading energy for performance.

In this case yes, I meant 2% less compared to menu but you're right of
course.

[...]

> Definitely it should not be changed if the previous state is a polling
> one which can be checked right away.  That would take care of the
> "Intel case" automatically.

Makes sense, I already used the polling flag to implement this in this other
governor I mentioned.

> 
> > Should make it much less intense for Intel systems.
> 
> So I think that this adjustment only makes sense if the current
> candidate state is state 1 and state 0 is not polling.  In the other
> cases the cost of missing an opportunity to save energy would be too
> high for the observed performance gain.

Interesting, but only applying it to C1 and only when C0 isn't polling would
make it effectively not do anything on Intel systems, right? From what I've
seen on Doug's plots even C1 is hardly ever used on his platform, most
sleeps end up in the deepest possible state.

Checking for the polling flag is a good idea regardless so I can send a
v3 with that. If you'd like me to also restrict the entire mechanism to
only working on C1 as you suggested then I'm okay with including that in
the v3 as well. What do you think?

Thanks a lot for all your time & input,
Kajetan
