Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA66BA0A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCNUXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCNUXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:23:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D483CC14B;
        Tue, 14 Mar 2023 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678825425; x=1710361425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EZgemfODZdzJL//ckW8Ahf4paB+FAWm34Ie+LQVzxoU=;
  b=Dkk/k3G8o+coc4cRQcctGLM71c3eGtUNpzFVVF1eYIqNnVc6qvpBwPTZ
   KRDOfGpnl0OY6D8TCd2l7+OV1kYDgjiACFLfcC3Gf8i/OzUzUXjU7mGb/
   SDPFVjfQ3UGIAEo5JZMrYA5XicAbUVuXVnXK/yIsTC/GuLZos3v4MNAKs
   IqNY1TZmdzdo/RIemXginBz7Y1OUBbBYaoqLB9xnsapKX3KJk0q1b8VGc
   PRT41uqlYqjEtv9HZP3d3h9mbuYkZser3WJBkFeoG3rWp+AjI9gczkp/1
   NK4uBECZ5rEcyFqcrOOsCViMNRCaA92eabaM2TjWvcjDpOF4c2bYjT1yB
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317931144"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317931144"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 13:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="748143935"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="748143935"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 13:23:44 -0700
Date:   Tue, 14 Mar 2023 13:23:43 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Moger, Babu" <babu.moger@amd.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Message-ID: <ZBDXzz+f1nSP1Ml0@agluck-desk3.sc.intel.com>
References: <20230126184157.27626-1-tony.luck@intel.com>
 <20230126184157.27626-8-tony.luck@intel.com>
 <38ce210b-50f7-188b-63a9-c7b3870fa99c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38ce210b-50f7-188b-63a9-c7b3870fa99c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:51:32PM -0600, Moger, Babu wrote:
> I am thinking loud here.
> When a new monitor group is created, new RMID is assigned. This is done by
> alloc_rmid. It does not know about the rmid_offset details. This will
> allocate the one of the free RMIDs.
> 
> When CPUs are assigned to the group, then per cpu  pqr_state is updated.
> At that point, this RMID becomes default_rmid for that cpu.
> 
> But CPUs can be assigned from two different Sub-NUMA nodes.
> 
> Considering same example you mentioned.
> 
> E.g. in 2-way Sub-NUMA cluster with 200 RMID counters there are only
> 100 available counters to the resctrl code. When running on the first
> SNC node RMID values 0..99 are used as before. But when running on the
> second node, a task that is assigned resctrl rmid=10 must load 10+100
> into IA32_PQR_ASSOC to use RMID counter 110.
> 
> #mount -t resctrl resctrl /sys/fs/resctrl/
> #cd /sys/fs/resctrl/
> #mkdir test  (Lets say RMID 1 is allocated)
> #cd test
> #echo 1 > cpus_list
> #echo 101 > cpus_list
> 
> In this case, the following code may run on two different RMIDs even
> though it was intended to run on same RMID.
> 
> wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + this_cpu_read(rmid_offset));
> 
> Have you thought of this problem?

Now I've thought about this. I don't think it is a problem.

With SNC enabled for two nodes per socket the available RMIDs
are divided between the SNC nodes, but are for some purposes
numbered [0 .. N/2) but in some cases must be viewed as two
separate sets [0 .. N/2) on the first node and [N/2 .. N) on
the second.

In your example RMID 1 is assigned to the group and you have
one CPU from each node in the group. Processes on CPU1 will
load IA32_PQR_ASSOC.RMID = 1, while processes on CPU101 will
set IA32_PQR_ASSOC.RMID = 101. So counts of memory bandwidth
and cache occupancy will be in two different physical RMID
counters.

To read these back the user needs to lookup which $node each CPU
belongs to and then read from the appropriate
mon_data/mon_L3_$node/{llc_occupancy,mbm_local_bytes,mbm_total_bytes}
file.

$ cat mon_data/mon_L3_00/llc_occupancy # reads RMID=1
$ cat mon_data/mon_L3_01/llc_occupancy # reads RMID=101

-Tony
 
