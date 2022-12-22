Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718326545A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiLVRgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLVRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:36:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6EE13D71;
        Thu, 22 Dec 2022 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671730606; x=1703266606;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8zlTHwNhpDMhAUchHtjK5Guuw+jimmxGdCWGt48Uf0=;
  b=k3NEFvsuivtnSfldNSDIW3Jk1EwLnwAaIa8CNaUEL6tJpkvd67lDZns+
   ZCghkeo6RXWhOH9S+x5zR3CSRFrdwUHMhsCzcePxhvLKZxixaPxYhGute
   /zUQ1iOe+lgKvpM83/ZmRRd7oHcb0Jk6BSdTvjPUH3XgPRlz0Ef7+qQID
   2Rh0YuK7qSrLGEn9pf2RBfKpv7Nd92xwe5f7rrLozzkyKqKwfHcr80Udk
   O04G+Tse9GLsphvEcx/XY7bR++6coDI4zoMYT4ZALQO1UgCEoSYkO846Y
   ZWfl0Lg9ygjPSfsnTe1BxM3zQe3NUThalyxF0DFFsFSUPVE+VQNzNaZIg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="317822534"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="317822534"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:36:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="653956069"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="653956069"
Received: from dkrumwie-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.24.53])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:36:45 -0800
Message-ID: <8d3a9644657c8f0b54dd272fe0a4d640a8a6dfb9.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete
 callbacks
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org
Date:   Thu, 22 Dec 2022 09:36:45 -0800
In-Reply-To: <de6a5000-260e-bb4a-31c4-a0cfe533fad4@linaro.org>
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
         <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
         <e2af7a4b-99f4-f88e-fbe7-5d3595d6211b@linaro.org>
         <3e59c5216fad003f079224cd08a7da9b30f6365d.camel@linux.intel.com>
         <de6a5000-260e-bb4a-31c4-a0cfe533fad4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 2022-12-22 at 10:50 +0100, Daniel Lezcano wrote:
> 
> Hi Srinivas,
> 
> 
> On 21/12/2022 21:58, srinivas pandruvada wrote:
> > Hi Daniel,
> > 
> > On Wed, 2022-12-21 at 15:52 +0100, Daniel Lezcano wrote:
> > > 
> > > Hi Srinivas,
> > > 
> > > On 30/11/2022 00:34, Srinivas Pandruvada wrote:
> > > > The actual idle percentage can be less than the desired because
> > > > of
> > > > interrupts. Since the objective for CPU Idle injection is for
> > > > thermal
> > > > control, there should be some way to compensate for lost idle
> > > > percentage.
> > > > Some architectures provide interface to get actual idle percent
> > > > observed
> > > > by the hardware. So, the idle percent can be adjusted using the
> > > > hardware
> > > > feedback. For example, Intel CPUs provides package idle
> > > > counters,
> > > > which
> > > > is currently used by intel powerclamp driver to adjust idle
> > > > time.
> > > Can you provide an example in terms of timings?
> > > 
> > > I'm not getting how 'prepare' would do by returning a positive
> > > value
> > > to
> > > skip the play_idle_precise() and what will do 'complete' ?
> > > 
> > intel_powerclamp has a logic where if the current idle percentage
> > observed from hardware is more than the desired target inject
> > percent,
> > it skips calling play_idle().
> > 
> > For example if you want to inject 50% idle and system is naturally
> > idle
> > for 60%, there is no use of calling play_idle in the idle injection
> > framework to induce more idle. In this way a workload can run
> > immediately.
> > 
> > So trying to emulate the same logic by using powercap/idle_inject
> > framework. So prepare() callback in the intel_powerclamp driver
> > calls
> > the existing function to check if idle-inject should skip for this
> > time
> > or not.
> 
> The function 'prepare' has the 'cpu' parameter. How can it compare
> with 
> the desired idle duration as this information is not passed to the 
> callback ?
Good question.

Calling driver knows what idle_duration he set.
In my first version, I passed *idle_duration (with current
idle_duration set), so the caller can change this for the current
play_idle call if required for one time.

But in powerclamp case we either skip the whole play_idle or not. It
doesn't change idle duration. So didn't add.

But we can add this back.

Thanks,
Srinivas



> 
> 

