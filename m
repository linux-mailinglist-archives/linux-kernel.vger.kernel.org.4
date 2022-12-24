Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CE7655873
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiLXFUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiLXFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:20:25 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116E018688
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 21:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671859225; x=1703395225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=voB+nAyHNEktsQe6rbbt2Lz35Dw3Tx7cQbow3+txWcE=;
  b=Y3wtqrMyQEHG7+sQ/yg6IUIZd8sAmku10+zO0deLNJYihLWW317jTabW
   YLn88IkHsDSlscdl097T/l5OV6rR8u50l7wAkh3S8I036Zu8bJLY8Xi5J
   n3mNbWyldSraGNdBG2UZnDpnT2IHPlVHTqRwbb8nBWnajUkV13TWgIpfU
   3e4P7RPg2VjRQiIClUvKQCUmvE9Z3767oIdMiUTQf97AbKFyz74CXowT4
   q6Xsp6k1LmvduI/XpP+15r3f9QGVBPsofvSTscmwqssgOuaW6yLmOTBqa
   R6Ds1jxCo/n0WuYnoFbaKfsTnnII4SXIJY6Np2R8eI9LgF1uTBbct6Y2d
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="318050896"
X-IronPort-AV: E=Sophos;i="5.96,270,1665471600"; 
   d="scan'208";a="318050896"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 21:20:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="645730540"
X-IronPort-AV: E=Sophos;i="5.96,270,1665471600"; 
   d="scan'208";a="645730540"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 23 Dec 2022 21:20:24 -0800
Date:   Fri, 23 Dec 2022 21:28:50 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Valentin Schneider <vschneid@redhat.com>
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
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 4/7] sched/fair: Introduce sched_smt_siblings_idle()
Message-ID: <20221224052850.GA8245@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-5-ricardo.neri-calderon@linux.intel.com>
 <xhsmhsfh7e5s9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhsfh7e5s9.mognet@vschneid.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:56:22PM +0000, Valentin Schneider wrote:
> On 22/11/22 12:35, Ricardo Neri wrote:
> > Architectures that implement arch_asym_cpu_priority() may need to know the
> > idle state of the SMT siblings of a CPU. The scheduler has this information
> > and functionality. Expose it.
> >
> > Move the existing functionality outside of the NUMA code.
> >
> 
> test_idle_cores() does something similar without an iteration, did you
> consider using that instead?

IIUC, test_idle_cores() returns true if there is at least one idle core in
the package. In my case, I need to know the idle state of only the SMT
siblings of a specific CPU. Am I missing something?

Thanks and BR,
Ricardo
