Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4907708CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjESA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjESA0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:26:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C2E0;
        Thu, 18 May 2023 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684455966; x=1715991966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vmNO3nCpeED9i66p4eJ06n2xbLKfA9JoMG33j6lzFIg=;
  b=ELtDRQUHOdwmsyI4NPGmLdOtkzoN9/DMcbhqhWSb2T2JxlT9ab3OdghU
   spKQgbgrhtMkAxmrPPwV5xw7jGylHq5U5XoZ99ltpauEQANeXxCld8rHF
   t/dVgzG0UFUF4a8aNqKnmsLKXymjOhmzVtHtem4fANXu1eSnCDmN9Jios
   zprSy6cdA3NLpasiaEVea0VpFBuX91r7iHOsTA/Ar2x5Ux7+fVnW15Jhn
   +nobccGqaEpSPUPA4x9pCPWwmSq1IEpZirVPVcPdzn89QEZlnI2xe2MbK
   wEyBpXjIt324TxEwu/0xJJNJuzHeADetSFtLRQO+dCpKwbKlJUsBpt9LH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355451069"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="355451069"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="705376838"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="705376838"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.20.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:26:04 -0700
Date:   Thu, 18 May 2023 17:26:03 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, x86@kernel.org,
        linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Message-ID: <ZGbCG4gRGow0VCmQ@aschofie-mobl2>
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
 <8dc725c8-613a-b51b-6cc1-80d2275ca130@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dc725c8-613a-b51b-6cc1-80d2275ca130@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 05:08:16PM -0700, Dave Hansen wrote:
> On 5/18/23 17:04, alison.schofield@intel.com wrote:
> > The initial use case is the ACPI driver that needs to extend
> > SRAT defined proximity domains to an entire CXL CFMWS Window[1].
> 
> Dumb question time: Why didn't the SRAT just cover this sucker in the
> first place?  Are we fixing up a BIOS bug or is there a legitimate
> reason that the SRAT didn't cover it up front?
> 
>

There is no requirement that the BIOS describe (in the SRAT) all the
HPA assigned to a CFMWS Window. The HPA range may not actually map to
any memory at boot time. It can be persistent capacity or may be there
to enable hot-plug. IIUC BIOS can pick and choose and define volatile
regions wherever it pleases.

So, no we're not fixing up a BIOS bug, nor doing a BIOS sanity check.

