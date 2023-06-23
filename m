Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CE73BF63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjFWUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFWUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:20:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F85319F;
        Fri, 23 Jun 2023 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687551641; x=1719087641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lAryfG9qk31DDSMUJF1vjuoirKqKEz/0CPZgNOgSylg=;
  b=ATpaf8aOVUYp1nJ5VtfPQdixod2z9ujbxNB4yV1HY2WGTlAc1USkjsZg
   XNWrwejPdVYKBh3QPmgKmqTwVdeWCVs++fAjeaTaLmMBK60DDRBgnb67H
   gA4hkDM7io+eOc9tVWfQ8mkz7tI/E0yyCf0sGYUljhCj2CDjlkzqD4r3t
   Ruva75dE6A5MfwDCnNGLTfUUP89GDc274BT1NElxBL7m/gUAlNzaN3oDQ
   CX97vldPRqkk+42o+Tfn2KtoowP7KrMai3wJ8cDS99VouynrFx0kMcktH
   tHJsWpi2fg2vYYBVArot5x9/mjuPNgEJHry6I/93weC0O4IdgnU44ne2d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="363404549"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="363404549"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 13:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="709565377"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="709565377"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 13:20:39 -0700
Date:   Fri, 23 Jun 2023 13:20:38 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Peter Newman <peternewman@google.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v2 7/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Message-ID: <ZJX+lmQTUEujF88U@agluck-desk3>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <20230621174006.42533-8-tony.luck@intel.com>
 <CALPaoCgF04M0Jc-c4VmbKkRSFo677SBGoPHzNCSeQ4S6Bqb60w@mail.gmail.com>
 <SJ1PR11MB60836CD7493B0EAF0F687051FC22A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CALPaoCiaknUMSU4CunSQrRP=WS8DAbToVo5jibh8TaWNZXGMbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCiaknUMSU4CunSQrRP=WS8DAbToVo5jibh8TaWNZXGMbQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:19:37PM +0200, Peter Newman wrote:
> Hi Tony,
> 
> On Thu, Jun 22, 2023 at 6:02 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > Unfortunately I'm not getting as good of results with the new series.
> > > The main difference seems to be updating the 0xca0 MSR instead of
> > > applying the offset to PQR_ASSOC.
> >
> > I think I may have reversed the actions to update the MSR in one of
> > my refactor/rebase. The comment here is correct, but that's not
> > what the code is doing :-(
> >
> > Can you swap the bodies of these two functions and retest?
> 
> It's a small improvement, but still not great. Still only node 0
> giving believable results, but at least no more empty results from the
> second package.
> 
> I poked around in /proc/kcore and noticed that my snc_ways is still 1, though.

Below is the patch I applied to reverse the add/remove package actions
together with some debug to make double sure SNC is being detected as
I expect and the right actions taken.

When booting the debug messages say:

[    9.458624] resctrl: SNC_ways = 2
[    9.458801] resctrl: CPU0: set MSR_RMID_SNC_CONFIG to 0x0
[    9.461986] resctrl: CPU56: set MSR_RMID_SNC_CONFIG to 0x0

which is all good and correct.

For my tests I have a memory hog process that loops on a memcpy()
of 100 MBytes to generate enough traffic to be totally obvious when
looking at the mbm counters.

Test 1: I used taskset(1) to start a copy on the first CPU of node0
and checked the MBM counters. Both local and remote showed around
25 GB/s on node 0. Killed this process.

Tests 2, 3, 4: Same as 1, but started the process on first CPU of node
1, 2, 3.  Same result. Around 25 GB/s appeared in the MBM counts for
the right node in each cycle.

Test 5: Started on node0, then periodically used taskset to bind the
running process onto a CPU on another node.  It looks like Linux
migrates the memory for the job shortly after the affinity of the
process is changed. A few seconds after each process migration, the
MBM counters reflect traffic on the node that is the new home of the
process.

-Tony

From 414341db02cd51daaf4a9ea8bd68b22a23cf4b59 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Fri, 23 Jun 2023 08:57:57 -0700
Subject: [PATCH] Fix inverted SNC enable/disable MSR writes. Add some debug
 too.

---
 arch/x86/kernel/cpu/resctrl/core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 869cfb46e8e4..e66b2b84fe6f 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -546,18 +546,20 @@ static void snc_add_pkg(void)
 {
 	u64	msrval;
 
-	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
-	msrval |= BIT_ULL(0);
-	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
-}
-
-static void snc_remove_pkg(void)
-{
-	u64	msrval;
-
 	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
 	msrval &= ~BIT_ULL(0);
 	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
+pr_info("CPU%d: set MSR_RMID_SNC_CONFIG to 0x%llx\n", raw_smp_processor_id(), msrval);
+}
+
+static void snc_remove_pkg(void)
+{
+	u64	msrval;
+
+	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
+	msrval |= BIT_ULL(0);
+	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
+pr_info("CPU%d: set MSR_RMID_SNC_CONFIG to 0x%llx\n", raw_smp_processor_id(), msrval);
 }
 
 /*
@@ -987,6 +989,7 @@ static __init int find_snc_ways(void)
 	if (ret > 1)
 		rdt_resources_all[RDT_RESOURCE_PKG].r_resctrl.pkg_actions = true;
 
+pr_info("SNC_ways = %d\n", ret);
 	return ret;
 }
 
-- 
2.40.1

