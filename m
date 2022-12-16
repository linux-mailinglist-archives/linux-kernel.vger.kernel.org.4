Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E964E9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiLPKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiLPKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:46:35 -0500
Received: from outbound-smtp19.blacknight.com (outbound-smtp19.blacknight.com [46.22.139.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC1D2CC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:46:34 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 317D31C3BB8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 10:46:33 +0000 (GMT)
Received: (qmail 26693 invoked from network); 16 Dec 2022 10:46:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Dec 2022 10:46:32 -0000
Date:   Fri, 16 Dec 2022 10:46:28 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tzm <tcm1030@163.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: failed to disable numa balancing
Message-ID: <20221216104628.bbeoilx3r64k3tlv@techsingularity.net>
References: <20221202141630.41220-1-tcm1030@163.com>
 <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221202115954.a226f8ef3051266d04caff54@linux-foundation.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 11:59:54AM -0800, Andrew Morton wrote:
> On Fri,  2 Dec 2022 22:16:30 +0800 tzm <tcm1030@163.com> wrote:
> 
> > It will be failed to  disable numa balancing policy permanently by passing
> > <numa_balancing=disable> to boot cmdline parameters.
> > The numabalancing_override variable is int and 1 for enable -1 for disable.
> > So, !enumabalancing_override will always be true, which cause this bug.
> 
> That's really old code!
> 
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2865,7 +2865,7 @@ static void __init check_numabalancing_enable(void)
> >  	if (numabalancing_override)
> >  		set_numabalancing_state(numabalancing_override == 1);
> >  
> > -	if (num_online_nodes() > 1 && !numabalancing_override) {
> > +	if (num_online_nodes() > 1 && (numabalancing_override == 1)) {
> >  		pr_info("%s automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl\n",
> >  			numabalancing_default ? "Enabling" : "Disabling");
> >  		set_numabalancing_state(numabalancing_default);
> 
> Looks right to me.  Mel?
> 
> After eight years, I wonder if we actually need this.

I don't think the patch is right aside from coding style issues such as
real names used in signed-off-by's.

The !numabalancing_override is checking "should the default be changed?",
itt's not checking if it should be enabled specifically. A better potential
fix would be something like this? (not actually tested)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..fc649f8509f7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2862,10 +2862,12 @@ static void __init check_numabalancing_enable(void)
 		numabalancing_default = true;
 
 	/* Parsed by setup_numabalancing. override == 1 enables, -1 disables */
-	if (numabalancing_override)
+	if (numabalancing_override) {
 		set_numabalancing_state(numabalancing_override == 1);
+		return;
+	}
 
-	if (num_online_nodes() > 1 && !numabalancing_override) {
+	if (num_online_nodes() > 1) {
 		pr_info("%s automatic NUMA balancing. Configure with numa_balancing= or the kernel.numa_balancing sysctl\n",
 			numabalancing_default ? "Enabling" : "Disabling");
 		set_numabalancing_state(numabalancing_default);
