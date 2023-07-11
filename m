Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EAB74F9B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 23:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGKVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjGKVXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 17:23:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339111B;
        Tue, 11 Jul 2023 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689110595; x=1720646595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E8txDx+ewvXOdcJsIlylcjGRaNR3TVVS13z+5E2/IfM=;
  b=HBiQSY0QpX1Zhukj6/Bv6GXoJ1ajhmqF02cY8BoYi8O0Ywt2PNDBEHC2
   DdM3yQlRwjL+KwKRYvdnOexaujJWum9a6jRKKTo1pRMxG2kEH+i3uRonQ
   Yu+B4TQcczt9HDkmPJT3Qwq1avaBC7L5dtX3MHM1OxnU6+VbaADoUaYDr
   hvDBpxTSoeJB0obr66hDGBsdRkRETeHRA/IfiMGQx1OvsYxEyiU/wa6tN
   KCZ1IUddmVE7rKEsuZiTwNKbdnd+aM2JHWi6y7leLAGTFGEztHjjor+67
   ZxDBB020hZG3JHO7bDt5LpM/gj30j0+VCoK9lYl15krDaXEDzbgwVbWId
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344339360"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="344339360"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="791358549"
X-IronPort-AV: E=Sophos;i="6.01,197,1684825200"; 
   d="scan'208";a="791358549"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 14:23:15 -0700
Date:   Tue, 11 Jul 2023 14:23:14 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster
 (SNC) systems
Message-ID: <ZK3IQj6+eVAeaNY1@agluck-desk3>
References: <20230621174006.42533-1-tony.luck@intel.com>
 <TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB608331B7F85320DD4CD93448FC25A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <30b63f35-1839-6870-d81b-1e8bff88dc70@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b63f35-1839-6870-d81b-1e8bff88dc70@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 01:50:02PM -0700, Reinette Chatre wrote:
> Hi Tony,
> > This is expected. When SNC is enabled, CAT still supports the same number of
> > bits in the allocation cache mask. But each bit represents half as much cache.
> > 
> > Think of the cache as a 2-D matrix with the cache-ways (bits in the CAT mask)
> > as the columns, and the rows are the hashed index of the physical address.
> > When SNC is turned on the hash function for physical addresses from one
> > of the SNC number nodes will only pick half of those rows (and the other
> > SNC node gets the other half of the rows).
> 
> If a test is expected to fail in a particular scenario then I think
> the test failure should be communicated as a "pass". If not this will 
> reduce confidence in accuracy of tests. Even so, from the description
> it sounds as though this test can be made more accurate to indeed pass
> in the scenario when SNC is enabled?

Hi Reinette,

Yes. This could be done. The resctrl tests would need to determine
if SNC mode is enabled. But I think that is possible by comparing
output of sysfs files. E.g. with SNC disabled the lists of cpus for a node
and a CPU on that node will match like this:

$ cat /sys/devices/system/node/node0/cpulist
0-35,72-107
$ cat /sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_list
0-35,72-107

but with SNC enabled, the CPUs sharing a cache will be divided across
two or four nodes.

It looks like the existing tests may print a warning. I see
this code in:

tools/testing/selftests/resctrl/resctrl_tests.c

123         res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
124         ksft_test_result(!res, "CMT: test\n");
125         if ((get_vendor() == ARCH_INTEL) && res)
126                 ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");

but at first glance that warning doesn't appear to try and
check if SNC was the actual problem.

-Tony
