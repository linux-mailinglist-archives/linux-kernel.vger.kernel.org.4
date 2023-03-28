Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD606CCE23
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjC1Xim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjC1Xik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:38:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4531FE2;
        Tue, 28 Mar 2023 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680046719; x=1711582719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IwnIbBzD5xf4CwbHYRJBexCA339KKhJzpvWJydOcd9Q=;
  b=JMc1Mvog/mhq8jW6gy6Bt5LodXWKLx5BPBAS2Ao54au9wkYTpRnMlq/h
   13iFAU8bsH2qy2a/AcI8n8FI9Wy+iHCycwWIak6jCWuZjK7XcXjor64JU
   R0xYROYELYz7d4b8RHS7/yApwsaLL1GiT54y2FDR6FQxfPVx9TJ1jX5dp
   cB287TJP/0rONQr1OimG+HuAohpoPR/9J+49yLRjHzmOXq+17YFwQlg4E
   V7FAnbQDIrlZZ0wt9yVrJqcGVPC03aNziIUzbkwUt7HPWjxigTJxKpngR
   n9RnQBF90RmHGjjUtolae5MDu9ZWg0bJ8MLY39jsDnHHA4cx5muJrzxRx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405666856"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="405666856"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 16:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="827669088"
X-IronPort-AV: E=Sophos;i="5.98,299,1673942400"; 
   d="scan'208";a="827669088"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2023 16:38:38 -0700
Date:   Tue, 28 Mar 2023 16:49:20 -0700
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
Subject: Re: [PATCH v3 16/24] thermal: intel: hfi: Define a default class for
 unclassified tasks
Message-ID: <20230328234920.GE8958@ranerica-svr.sc.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
 <20230207051105.11575-17-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0iMkADWu2P_cn9+8FV4HR+0eDF2uAwEMAZwTAMuE3kBkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iMkADWu2P_cn9+8FV4HR+0eDF2uAwEMAZwTAMuE3kBkA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:51:33PM +0200, Rafael J. Wysocki wrote:
> On Tue, Feb 7, 2023 at 6:02 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > A task may be unclassified if it has been recently created, spend most of
> > its lifetime sleeping, or hardware has not provided a classification.
> >
> > Most tasks will be eventually classified as scheduler's IPC class 1
> > (HFI class 0). This class corresponds to the capabilities in the legacy,
> > classless, HFI table.
> >
> > IPC class 1 is a reasonable choice until hardware provides an actual
> > classification. Meanwhile, the scheduler will place classes of tasks with
> > higher IPC scores on higher-performance CPUs.
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
> Fine with me, so
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you Rafael!
