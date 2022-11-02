Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9024B6169DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiKBQ6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKBQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:57:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE47B86A;
        Wed,  2 Nov 2022 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667408278; x=1698944278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HeHwbPhOHs42Kq6mnfMZGexb4iqh1X1MYkH7cuf67cI=;
  b=LY6Llq1U8VPQmxLJFj6VhFAiCqR5+ffqN2YxBorCCsp6NLpp3D4SfLxR
   YBW+GjMiO71XH8WcMPD9Vo376QsopQ/eQF29xoP/al57Nnk6jVmdG5mar
   5Os20LXQ/tfIFM9Xf+39iomXzuLexarWnhNBFv5DUOmgL6o/KF5YXZ7Yo
   e1ArtFnHU9VU3klk9N5kbEU+h3sr1SXCpHZwaiMHePKz2GBiVRhcHxYR8
   qxOP7pMj2kV20iHhX3rjzgIV9rqBM/Jj1yQN78aeulas5bgCtFS5drvzu
   jDLoGDqUFwN9+e6gqrhN7vXzQaGNUfo7eS5LbhroxV8aL4jAkKXxs//12
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="371558549"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="371558549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 09:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="776967155"
X-IronPort-AV: E=Sophos;i="5.95,234,1661842800"; 
   d="scan'208";a="776967155"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by fmsmga001.fm.intel.com with SMTP; 02 Nov 2022 09:57:52 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 02 Nov 2022 18:57:51 +0200
Date:   Wed, 2 Nov 2022 18:57:51 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 6/6] freezer,sched: Rewrite core freezer logic
Message-ID: <Y2Khj7n+tRq3r++O@intel.com>
References: <20220822111816.760285417@infradead.org>
 <20220822114649.055452969@infradead.org>
 <Y1LVYaPCCP3BBS4g@intel.com>
 <Y1drd2gzxUJWdz5F@intel.com>
 <Y1e/Kd+1UQqeSwzY@hirez.programming.kicks-ass.net>
 <Y1kMv1GpKwOSIt8f@intel.com>
 <Y1kdRNNfUeAU+FNl@hirez.programming.kicks-ass.net>
 <Y1qC7d7QVJB8NCHt@intel.com>
 <Y1q3gzbPUCvEMHGD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1q3gzbPUCvEMHGD@hirez.programming.kicks-ass.net>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 06:53:23PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 27, 2022 at 04:09:01PM +0300, Ville Syrjälä wrote:
> > On Wed, Oct 26, 2022 at 01:43:00PM +0200, Peter Zijlstra wrote:
> 
> > > Could you please give the below a spin?
> > 
> > Thanks. I've added this to our CI branch. I'll try to keep and eye
> > on it in the coming days and let you know if anything still trips.
> > And I'll report back maybe ~middle of next week if we haven't caught
> > anything by then.
> 
> Thanks!

Looks like we haven't caught anything since I put the patch in.
So the fix seems good.

-- 
Ville Syrjälä
Intel
