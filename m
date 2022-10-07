Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE385F7EBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJGU15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJGU1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:27:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9246139560
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665174474; x=1696710474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RMsUerXHhE7TEWBzGIbOLMO3N8QNtWmQRZsTfVgpCMc=;
  b=eWnmWHE3LSO6bMhT5w1KE/fgfLJPl8vHxam+M2AnPAGF2ZQx3co0w7bd
   z38h8rvfHYNBn6scbl8n8K0uejKpAtKDy1Yk5BUOM/errh4y2wkd6jGRj
   GjuVQrho1vtJuMd4vq2C1/uWX/9DEnijdVrPC2B5bzap431kn18XmW5Lr
   rc67wwUa49dnM5+kTEn/hjFUx0DrzODrfJCq1+T1JnK2zsHMBSZ8fT0vh
   lcl4obh3fi2kXSymA0EljjC8yZ+lVqP2qZhcicA25xJ9LK4d4oAbzQBLF
   tfnI1o9gcVRIzRykONYPP8bgVn78EeOyMjXoLiGusvuOV3LoFpp9AWkT+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="284201831"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="284201831"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2022 13:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10493"; a="714395973"
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="714395973"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2022 13:27:54 -0700
Date:   Fri, 7 Oct 2022 13:34:25 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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
Subject: Re: [RFC PATCH 14/23] thermal: intel: hfi: Update the class of the
 current task
Message-ID: <20221007203425.GA5647@ranerica-svr.sc.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-15-ricardo.neri-calderon@linux.intel.com>
 <YzLis/a3aIJnJ2ZE@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzLis/a3aIJnJ2ZE@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 01:46:59PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 04:11:56PM -0700, Ricardo Neri wrote:
> > +union hfi_thread_feedback_char_msr {
> > +	struct {
> > +		u8	classid;
> > +		u64	__reserved:55;
> > +		u8	valid:1;
> > +	} split;
> > +	u64 full;
> > +};
> 
> Urgh, did you perhaps mean:
> 
> 	struct {
> 		u64	classid    :8;
> 		u64	__reserved :55;
> 		u64	valid      :1
> 	};
> 
> ?
> 
> Because yes, GCC does fold that into a single u64, but that's
> implementation defined behaviour; the C spec doesn't require one to pack
> adjacent bitfields of different types together.
> 
> I layout of:
> 
> 	u8	class;			// offset 0
> 	u64	__reserver : 55;	// offset 8
> 	u8	valid : 1;		// offset 16
> 
> with a total size of 24 bytes is, AFAIU, a valid result of what you
> wrote.

I checked the C99 and C11 specs and, IIUC, it does prescribe how to handle
adjacent bit-fields:

	"An implementation may allocate any addressable storage unit large
	 enough to hold a bitfield. If enough space remains, a bit-field
	 that immediately follows another bit-field in a structure shall be
	 packed into adjacent bits of the same unit."

Hence, __reserved and valid should be packed. classid, however, it is not
guaranteed to be adjacent to __reserved.

I will implement the struct are you have described.

Thanks and BR,
Ricardo
