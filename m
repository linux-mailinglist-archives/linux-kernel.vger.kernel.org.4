Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61907726326
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbjFGOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjFGOni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:43:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B14B21BD2;
        Wed,  7 Jun 2023 07:43:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC1EE2F4;
        Wed,  7 Jun 2023 07:44:13 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E78683F587;
        Wed,  7 Jun 2023 07:43:26 -0700 (PDT)
Date:   Wed, 7 Jun 2023 15:43:24 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] arm_scmi/opp/dvfs: Add generic performance scaling
 support
Message-ID: <ZICXjExmCRwcQ3BA@e120937-lin>
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607124628.157465-1-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:46:12PM +0200, Ulf Hansson wrote:
> The current SCMI performance scaling support is limited to cpufreq. This series
> extends the support, so it can be used for all kind of devices and not only for
> CPUs.
> 
> The changes are spread over a couple of different subsystems, although the
> changes that affects the other subsystems than the arm_scmi directory are
> mostly smaller. The series is based upon v6.4-rc5. That said, let's figure out
> on how to best move forward with this. I am of course happy to help in any way.
> 
> Note that, so far this is only be tested on the Qemu virt platform with Optee
> running an SCMI server. If you want some more details about my test setup, I am
> certainly open to share that with you!
> 
> Looking forward to get your feedback!
> 

Hi Ulf,

thanks for this first of all.

I'll have a look at this properly in the next weeks, in the meantime
just a small minor remark after having had a quick look.

You expose a few new perf_ops to fit your needs and in fact PERF was
still not exposing those data for (apparent) lack of users needing
those. (and/or historical reason I think)

My concern is that this would lead to a growing number of ops as soon as
more data will be needed by future users; indeed other protocols do
expose more data but use a different approach: instead of custom ops
they let the user access a common static info structure like


+       int (*num_domains_get)(const struct scmi_protocol_handle *ph);
+       const struct scmi_perf_dom_info __must_check *(*info_get)
+               (const struct scmi_protocol_handle *ph, u32 domain);

and expose the related common info struct in scmi_protocol.h too.
Another reason to stick to this aproach would be consistency with other
protos (even though I think PERF is not the only lacking info_get)

Now, since really there was already a hidden user for this perf data
(that would be me :P ... in terms of an unpublished SCMI test-driver),
I happen to have a tested patch that just expose those 2 above ops and
exports scmi_perf_dom_info and related structures to scmi_protocol.h

If you (and Sudeep) agree with this approach of limiting the number of
exposed ops in favour of sharing upfront some static info data, I can
quickly cleanup and post this patch for you to pick it up in your next
iteration.

(really I'd have more conversion of this kind also for other remaining
 protos but these are unrelated to your series and I'd post it later)

Thanks,
Cristian
