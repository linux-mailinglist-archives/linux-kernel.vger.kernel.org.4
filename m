Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B364EFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLPQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiLPQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:58:58 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F38F50D71;
        Fri, 16 Dec 2022 08:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671209936; x=1702745936;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X2mDf4J1WrwbdWmHR5CTw1rV/tL2BDpIGIomR+yeuAY=;
  b=ZND9L71Q0vqMQgp7RGwQmf8dUmuaBw6A17ffETgK3KnpnT1bdWP1qrBA
   StQ/cbiRzAaKuQnpCESu2dEN+V0xigAy3+2aYC9zcXSPB2gzwr8a/zhVB
   mNwdQX2z543jKTrM9RquEeld5wA+bJA/VqHqJicQLJF0rU6Waor3kwQgC
   Syc1+XqcDWnx5dajaAJNob2YZsHX9dspha0HB3DjsgIH9szWVaj4jfgja
   7INYn9+GUhvXOHYuXM4PDiVBEmwPTuuvOPebmf4oiQ1EST85VHihn9UY5
   UjWmPAPgux7V5wraRaSTL/Wk/4aDOMMrY1eT2jviqvGLZooywmER/NScF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="381227653"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="381227653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:58:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="824166028"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="824166028"
Received: from wchakrab-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.231.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 08:58:55 -0800
Message-ID: <21925b706eb55d78afe40ae3e8d5778875821009.camel@linux.intel.com>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rafael@kernel.org, frederic@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com
Date:   Fri, 16 Dec 2022 08:58:55 -0800
In-Reply-To: <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
         <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
         <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-16 at 12:19 +0100, Peter Zijlstra wrote:
> On Thu, Dec 15, 2022 at 10:42:59AM -0800, Srinivas Pandruvada wrote:
> > +               /* Give ksoftirqd 1 jiffy to get a chance to start
> > its job */
> > +               if (!READ_ONCE(it.done) &&
> > task_is_running(__this_cpu_read(ksoftirqd))) {
> > +                       __set_current_state(TASK_UNINTERRUPTIBLE);
> > +                       schedule_timeout(1);
> > +               }
> 
> That's absolutely disgusting :-/
What is the alternative? Process softirq in this task context for one
time?

Thanks,
Srinivas
