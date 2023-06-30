Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84823743174
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjF3AGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjF3AGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:06:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D067102
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688083607; x=1719619607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v89akaza7HsjyKIZYAwuft+VjZZ85WZYxFaVCTk+znk=;
  b=j4y/UtVO3CvIQfjRa72CXxiV832qiEEv8xL57mq0UA/M8/EbtqDBidTJ
   Y1RkwfHBi0QOSYMC4v3RCcsKadUvCf6WbV5nM695r+S9r8hmDtIa72IGC
   thNnVBtpuf2kMpSzVPuI+L7nqrXGi0igEchrmEY1NOUCpOq/gTPkZ2YY5
   ZDZr8/h1bLdQoLaGM8n1bEpq3mk5VFdb9OV0G0e2cmIkw9XqbuPv8XJQR
   2pprsWHBAfQDj8bzyJojs/cFbLBJnp9m+Yv9uxQnrfbUH8/b1ZcKzpKuG
   K/DfqCSNOmCPoh95drExfN1uwK+QpSWvGALCntRrJdFN2WJkq8pSYscx2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="341850771"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="341850771"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 17:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="1048016939"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="1048016939"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 17:06:46 -0700
Date:   Thu, 29 Jun 2023 17:06:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     James Morse <james.morse@arm.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "xingxin.hx@openanolis.org" <xingxin.hx@openanolis.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "Pitre, Nicolas" <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "aricciardi@baylibre.com" <aricciardi@baylibre.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Message-ID: <ZJ4clUlN2OujgHlC@agluck-desk3>
References: <20230620033702.33344-1-tony.luck@intel.com>
 <ZJqhDYLG+/Kr44sp@x1>
 <SJ1PR11MB60832BA425B43CA19C778100FC27A@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60832BA425B43CA19C778100FC27A@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:33:52PM +0000, Luck, Tony wrote:
> I've made some significant changes since I posted those patches. I pushed
> the latest version to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git    resctrl2_v64

I just pushed one big commit with all the bits I've updated so far
this week. Fixes some serious issues as well as general cleanup.

HEAD is now:

afb7cdd4d640 resctrl2: Many cleanups, fixes, and new functionality

If you've started writing your own architecture specific modules there
are some small interface changes. Most should be found by the compiler
barfing, but the new ".reset()" resource function called during unmount
of /sys/fs/resctrl might be less obvious.

-Tony
