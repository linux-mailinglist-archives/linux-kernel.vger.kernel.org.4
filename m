Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651206C202B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjCTSm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCTSmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:42:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A113599;
        Mon, 20 Mar 2023 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679337241; x=1710873241;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=RDWM5GGSfohMNn0saexlnXC0jRr3+/a2Ro1zoyhxTSc=;
  b=UNjglqWUh/VR6yBfG48JW/FF/lFLWd0GjzuoEg42nspO+scoLbHlM7h/
   OxnjRMkR0Giurx2d33qrbtYPST0eP8hknvtKOfKtTqTirrshxOBp2Dr2/
   AIwvCto/qUrFbKzM9C7ZUyYlZzpqXqlXwd3bl1flOhsPniLDMXLKhap4o
   SfRqq7QZLUmPxaXZhdOkPp+pHalZVL2wLZOXtqGhlvuXjxJx2SKSPLWCK
   tniY7PmhKj3kcuGABadzN8Ytko8yH7hDScFMdJJ8D+bZSz4VyEp0+3D3u
   BATHr1sN5eQpeTAHWhtCWiqAzKdgoYNBktixrvkP7nWBZQfr7Uw2210sf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="318396069"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="318396069"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927069744"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="927069744"
Received: from jordanzi-mobl2.amr.corp.intel.com ([10.212.48.149])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 11:33:44 -0700
Message-ID: <cd670ca36053ebf5918a2d1df3255e40edb5f513.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Enable HWP IO boost for all
 servers
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>, rafael@kernel.org,
        lenb@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Mar 2023 11:33:43 -0700
In-Reply-To: <70119ad043502390100e66dbbe658aa069b86e45.camel@suse.cz>
References: <20230303041411.3161780-1-srinivas.pandruvada@linux.intel.com>
         <70119ad043502390100e66dbbe658aa069b86e45.camel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-20 at 18:03 +0100, Giovanni Gherdovich wrote:
> On Thu, 2023-03-02 at 20:14 -0800, Srinivas Pandruvada wrote:
>=20

...

Hi Giovanni,

> Hello Srinivas,
>=20
> Good catch. We've had HWP IO Boost in the kernel for a while now but
> we
> weren't enabling on most of the modern CPUs... This fixes it.
>=20
> One thing though: I've the impression that HWP IO Boost depends on
> having
> per-core p-states -- otherwise you'll be boosting up and down the
> entire machine
> instead of just the one core waking up from IO.
> Enabling the feature on all machines with the ACPI PM server profile
> would
> force it also where per-core p-states aren't available.

This feature only exists on HWP systems. There are no HWP systems
without per core P-states. Here we are enabling for performance and
enterprise servers only.


>=20
> Would you agree with this assessment?
> Do I correctly understand the reason why per-core p-states are needed
> here?
This problem with IO will be more pronounced in per-core P-states
systems as it will not be influenced by other cores. But even if non
per-core systems if other cores are idle or lightly loaded, the same
problem can occur. But I don't have data on such systems.

>=20
> I remember you mentioned the the dependency on per-core p-states in
> the cover
> letter from the HWP IO Boost submission in 2018
> https://lore.kernel.org/lkml/20180605214242.62156-1-srinivas.pandruvada@l=
inux.intel.com/
>=20
> I think there's a tradeoff here. Up until this patch, we forgot to
> enable the
> feature on four generations of Intel CPUs. That's a lot of lost
> performance;
> thanks to this patch it won't happen ever again, because nobody will
> have to
> update the model list at every new CPU release.
>=20
CPU model updates always gets missed and also misses testing
opportunity.

> On the other side, there may be some penalty for machines that:
> - have HWP
> - don't have per-core p-states
> I don't know how large that interesection is, or how big the penalty.
>=20

Thanks,
Srinivas



>=20
> Giovanni
>=20

