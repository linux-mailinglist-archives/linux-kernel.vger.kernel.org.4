Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA1708CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjESAIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjESAIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:08:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459410C3;
        Thu, 18 May 2023 17:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684454898; x=1715990898;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mV/lqMYc8phJKknd1RZjyJiN6gwG6n5o6thTo+1S4vI=;
  b=YupcAuqexmVvQJTGctJjeOf8MLv4KkHIdfpHubVus39GRl7p4CppLMye
   CtvMrUO1qOUoT4dRpoU1v0YWMaTM0F5tjOkHDjPGbr3fCOBMr+JyGa38W
   TjiSRwuVIKWAb0+8/IJXMeQ3rzhm0FBdoU/c7Eh/pb9Pb75+ivVCFosBJ
   V8LzymGj0+ALyB36EQ4+o/q4Kf1+b+j5IgLgN96T6x22IW96SXWAxPa11
   vzNaBlx8+jM3nRvGB9zjQvwBDpH60xoJTeS84h72MJZeBIDq82pyzaott
   nxQl0BYvT3vCK7IJ1LMACjOOpWhqAqXxg7W8E/l6iWqKktS6FmbGEYDZD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="415686638"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="415686638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:08:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="702319747"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="702319747"
Received: from mkim1-mobl.amr.corp.intel.com (HELO [10.209.118.171]) ([10.209.118.171])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 17:08:16 -0700
Message-ID: <8dc725c8-613a-b51b-6cc1-80d2275ca130@intel.com>
Date:   Thu, 18 May 2023 17:08:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] x86/numa: Introduce numa_fill_memblks()
Content-Language: en-US
To:     alison.schofield@intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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
        Dave Jiang <dave.jiang@intel.com>
Cc:     x86@kernel.org, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1684448934.git.alison.schofield@intel.com>
 <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e365f4dfa7fa974118eb4e59aebc7cc423cf19a1.1684448934.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 17:04, alison.schofield@intel.com wrote:
> The initial use case is the ACPI driver that needs to extend
> SRAT defined proximity domains to an entire CXL CFMWS Window[1].

Dumb question time: Why didn't the SRAT just cover this sucker in the
first place?  Are we fixing up a BIOS bug or is there a legitimate
reason that the SRAT didn't cover it up front?


