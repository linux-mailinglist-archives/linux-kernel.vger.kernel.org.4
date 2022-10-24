Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C69760BF21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiJXX6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiJXX6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:58:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF6D347B57;
        Mon, 24 Oct 2022 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666649690; x=1698185690;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IpovU0pr5GqNyG1RQY1BOg6p1QwyjDdZAzVeYeoqpcQ=;
  b=SdBlbZeQKdECKVnMMqoOrJdEMoKXO0cf3IXrb6FZgu/ztduI2hD8kiXD
   p3MCr9gJTe2FsaiKoE+NYpc7b+VK+OdnUVyoHnmEYuJ9yw6h2/U897t1n
   IpnhClCcrf/SHY6/jlnH5MoWJXLdupuZuVKm+ZWz+JX6AUgkMX1ziz8Dr
   8c0l98S0X5jFr8wlFh86v5yVjaiMeG/7t1/dRMGXRVWTrwJMU/q1xe9ag
   deDA6JEA9RFv4gXC70RNwzvob9IUgjQaenB9nJ0oilQqD9KsrwdHsHNQO
   BU/98oveVyMRxpeohG+Miet2hBrGtjC6AOaL1sO18du+JWfAOJiKQFLSj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="308627361"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="308627361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:14:39 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="694715326"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="694715326"
Received: from hossain3-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.39.87])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 15:14:37 -0700
Message-ID: <8bbd9bc65622aafd36433dbf0cf81338fde3007a.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] cpufreq: intel_pstate: Make HWP calibration work on
 all hybrid platforms
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Date:   Mon, 24 Oct 2022 15:14:36 -0700
In-Reply-To: <2258064.ElGaqSPkdT@kreacher>
References: <2258064.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-24 at 21:18 +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> The HWP calibration in intel_pstate is needed to map HWP performance
> levels to
> frequencies, which are used in the cpufreq sysfs interface, in a
> reliable way.
> On all non-hybrid "core" platforms it is sufficient to multiply the
> HWP
> performance levels by 100000 to obtain the corresponding frequencies,
> but on
> hybrid ones there is a difference between P-cores and E-cores.
> 
> Previous attempts to make this work were based on using CPPC (and in
> particular
> the nominal performance values provided by _CPC), but it turns out
> that the
> CPPC information is not sufficiently reliable for this purpose and
> the only
> way to do it is to use a hard-coded scaling factors for P-cores and
> for E-cores
> (which fortunately is the same as in the non-hybrid case). 
> Fortunately, the
> same scaling factor for P-cores works on all of the hybrid platforms
> to date.
> 
> The first patch in the series ensures that all of the CPUs will use
> correct
> information from MSRs by avoiding the situations in which an MSR
> values read
> on one CPU will be used for performance scaling of another CPU.
> 
> The second one implements the approach outlined above.
> 
> Please see the changelogs for details.

Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> 
> Thanks!
> 
> 
> 

