Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5536AB303
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 23:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjCEWj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 17:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCEWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 17:39:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6BC7EC2;
        Sun,  5 Mar 2023 14:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678055966; x=1709591966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8aH9LN6EcDisO/WKoB71wVQn6jQCx2m26xFmJ2O3Fn8=;
  b=m4J6seSAjUiLa5MBRfoo8aCm1bauvI4YpNz31JUVNYyWv95rmb6OJGZq
   JFt0ltWTxrk0FSP7KnlJDhx4xoX2YpiCt05J3UA2H57uXeQL6saOjJkDM
   zWu6Qvmak7+BkpZ9Agh+SIZgOwCefJJlgRniQG672SNB1Zp6LEZQ5f3oa
   S2oSx0FAbfW2ueH+J0cNOCmtzhVDwzQl7B7upwIa3F3L7Z0YfYOL497tH
   E4zFMDQm/nbJBHUxRgTrcWY3UmIcHZSVKowrqmWk/ZyrkJQLcmMWQhElp
   uDxkLSqYPgIQ1qJrw/0pdIV6KDdPDnUZiAt1rG1Qy2NDXwS7k7tZSGBxi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337747973"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337747973"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 14:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="740114660"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="740114660"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2023 14:39:24 -0800
Date:   Sun, 5 Mar 2023 14:49:27 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/24] sched: Introduce classes of tasks for load
 balance
Message-ID: <20230305224927.GA10505@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:10:41PM -0800, Ricardo Neri wrote:
> Hi,
> 
> This is third version of this patchset. Previous versions can be found
> here [1] and here [2]. For brevity, I did not include the cover letter
> from the original posting. You can read it here [1].

Hello! Is there any feedback for this patchset?

Thanks and BR,
Ricardo
