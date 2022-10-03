Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD9E5F368A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJCTnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJCTnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:43:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8861711800
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664826191; x=1696362191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Grb/QYisV63rNYcv9Sr3eRU62PmVrW9BGs7p9XSJRQg=;
  b=K8UvF8soay2kgbaxHExhtlRpfabpL9XkJOXpzm81vb/41bThMjH+WdWC
   kdmqi5LdnhjlSdmskA9HtVDUdUPdgH4y6UUWEKUKnoHil7S+8f7I8tUOJ
   TPp+uaBMSbzdAJ49al15X4g7hBUmD1jrR6ItEpnG1L7JKXkwAFoFSV6bx
   XqCpuHcp0Qzn3bMJa5vM8P6HNYydBPjZhsbtjActl3mexPWjiTyw5HA7/
   PCTnzw+YccvhmxhNud3dKudSa4OjC7NBPB4klfi9yWeqkLEP0TuuYKta8
   A9pJ+xIgYC1uplOEhhfszfZDwzsTw/suhd7QtxlxInihOLW9drRZC7x7d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="366841585"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="366841585"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 12:43:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="654501962"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="654501962"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 03 Oct 2022 12:43:10 -0700
Date:   Mon, 3 Oct 2022 12:49:35 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 23/23] x86/process: Reset hardware history in context
 switch
Message-ID: <20221003194935.GA20128@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
 <YzL3g9MM3QwyfRer@zn.tnic>
 <20221002221238.GB17545@ranerica-svr.sc.intel.com>
 <YzoNhJ2ldgak1WuY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzoNhJ2ldgak1WuY@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:15:32AM +0200, Borislav Petkov wrote:
> On Sun, Oct 02, 2022 at 03:12:38PM -0700, Ricardo Neri wrote:
> > Sure I can do this, Boris. I guess this implies that I also need to
> > add the DISABLE_MASK bits.
> 
> Are you adding a CONFIG_ item which can control the DISABLE_MASK bit
> too?

I am not. I could use CONFIG_INTEL_HFI_THERMAL, as using HRESET only makes
sense when Intel Thread Director (Peter argued in separate email against
having a config option specific for Intel Thread Director).

> 
> > Othewise, IIUC, cpu_feature_enabled() falls back to static_cpu_has().
> 
> And?

Since I did not implement a DISABLE_MASK bit nor a CONFIG_ option for
HRESET, I thought that static_cpu_has() was sufficient.

I am not against using cpu_feature_enabled(), I just want to confirm that
I also need to implement the DISABLE_MASK bit and the CONFIG_ option.

Thanks and BR,
Ricardo
