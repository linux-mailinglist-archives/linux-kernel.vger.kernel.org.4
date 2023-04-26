Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6046EFD00
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjDZWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbjDZWCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:02:22 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE5D132
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682546541; x=1714082541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zKIQW9iwSU4MYlAS62gUCzLwO2UFIxjKIrZL3nh2enE=;
  b=Vtf+k+1wFHjfArwLXCnmOcDAjSiHZGWvMwSIsrgjWOkvmyd7Y1p1qco3
   kxp0gk8XAVZTFW6p6vjRqZ4cZAJSY2kkXhO4NU2gUi3YAP8fEjPGFpcYe
   nDXqGQkgZwLf2t0JVbC3WDkPvvlGQo5DzULXMbDATAGMh8D04Y/Vl384/
   5At05WRlQFeSPv0bAvQoFcuWzG9vmVv7qGYdjUdMUfOtWJl5tQLXNRV1m
   SA0hIuFRP0pmTCVY/4blvXUHeB+Rwolx7lQuAvtQiDPwPhp/XnYDnxekT
   nIoS7zyZ/jHWpO97C5s1ahg47Y2ryL6zD3mhGarJUDUwde1NeuHcgQF2r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="346006753"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="346006753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 15:02:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="868454999"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="868454999"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 15:02:16 -0700
Date:   Wed, 26 Apr 2023 15:02:10 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Message-ID: <ZEmfYpOyyul4BaKP@tassilo>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
 <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com>
 <87y1mey503.ffs@tglx>
 <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
 <01a44722-931a-7aff-4f4b-75e78855beb1@amd.com>
 <25dd25d3-2db1-acf6-0814-9bb5bcd65bb9@intel.com>
 <469754ab-d8ec-168a-15c7-61045a880792@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <469754ab-d8ec-168a-15c7-61045a880792@amd.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This is probably going to pull in a cache line and cause the problem the
> > > native_wbinvd() is trying to avoid.
> > 
> > Is one _more_ cacheline really the problem?
> 
> The answer is it depends. If the cacheline ends up modified/dirty, then it
> can be a problem.

I haven't followed this all in detail, but if any dirty cache line a
problem you probably would need to be sure that any possible NMI user
(like perf or watchdogs) is disabled at this point, otherwise you could
still get NMIs here. 

I don't think perf currently has a mechanism to do that other
than to offline the CPU.

Also there are of course machine checks and SMIs that could still happen, 
but I guess there's nothing you could do about them.

-Andi
