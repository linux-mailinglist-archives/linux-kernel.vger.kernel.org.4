Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DE6CCE0B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjC1Xbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC1Xbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:31:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4B30EB;
        Tue, 28 Mar 2023 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680046289; x=1711582289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F+CoBdGg9IzfamG5sBNTunYtWHdruC9puKSx6k5i0WM=;
  b=eOB9QMi3R0wFvMDS5i7Z7vc5LVe3okpfH5jlxShVdXKXHN/jVB+GRXof
   jQR5MhtEMqReIojCZV8gj7v6mrDMKX2bWHmTSkypmBx2990M6iiXrMxcu
   Dz4mZ4m9JRxdE2dwlr0boLOF9ifhGotxuqiqnSprvpkrqkD/E3otdAxEe
   Y2ZLEGlnbJnW3Mr6RKrCuiDQg8DjERVCoz0mKjOBqcMHeRy7Sk4cK0kLO
   Ta6hAFZb4Wu3B1M+ODfNyam1VBq9q5tdQ8C92uB1sRR8ewPcQftp6jdkv
   9VWuvkmEURiHfWHGd2aeLpzBI25isZ280H4flFDUrFE3Ar/OpDajNZ7lH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="329185591"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="329185591"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 16:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="661375659"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="661375659"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga006.jf.intel.com with ESMTP; 28 Mar 2023 16:31:25 -0700
Date:   Tue, 28 Mar 2023 16:42:06 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v3 11/24] thermal: intel: hfi: Introduce Intel Thread
 Director classes
Message-ID: <20230328234206.GC8958@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-12-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0hOdubRdhDpHyU474Px5mSo7hcYGS+oXLYLf38_y+V-Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hOdubRdhDpHyU474Px5mSo7hcYGS+oXLYLf38_y+V-Gg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:31:03PM +0200, Rafael J. Wysocki wrote:
> On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > On Intel hybrid parts, each type of CPU has specific performance and
> > energy efficiency capabilities. The Intel Thread Director technology
> > extends the Hardware Feedback Interface (HFI) to provide performance and
> > energy efficiency data for advanced classes of instructions.
> >
> > Add support to parse per-class capabilities.
> >
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Ionela Voinescu <ionela.voinescu@arm.com>
> > Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Tim C. Chen <tim.c.chen@intel.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> No objections to this patch, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you Rafael!
