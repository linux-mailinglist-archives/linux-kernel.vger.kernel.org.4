Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D9628825
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiKNSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiKNSSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:18:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9A2CE29;
        Mon, 14 Nov 2022 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668449808; x=1699985808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CzoicXuGrMHCvCBrOI2reAemuWJvq/7bOC+oizxyPpQ=;
  b=cl2D44H8ivgAZi2GLVAZTN1nGo+QnvWcdnUgpke4yA4z20ZNR3HnehVR
   jkWdUVBaUBVW2QUc8NJTlrexFvcOoSkGr4MngFnSg2vD5HSlXvCo4RZik
   vqpzWmH57vI1YpOBsCV8yvL5wimtMTiGf+fxCYG54Lnp5XaOwhw54NdZv
   5IieyilS+HrC8QoQ5SG6k2zfMUA3M2pO5xqd5k1s/7Ez6IejxrL+dP+ox
   kWWiws3LLR1PePecA35CQKWQ6AHv0RH9f85gQ+Q7L8I0lCVJw5MNUdfaL
   dcphhNAg89VRT3N0iCeJVwU9PZ5v2eoHToFQWFPh1scqq98ZVvrSlz0o2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310752624"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310752624"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:16:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727628100"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727628100"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.212.119.125]) ([10.212.119.125])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 10:16:47 -0800
Message-ID: <cc5cce78-9fc9-714a-12bc-237b3c4f0ae6@linux.intel.com>
Date:   Mon, 14 Nov 2022 10:16:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/8] Redesign the pmc core driver
To:     hdegoede@redhat.com
Cc:     irenic.rajneesh@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        sukumar.ghorai@intel.com, xi.pardee@intel.com,
        rajvi.jingar@intel.com,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        David E Box <david.e.box@linux.intel.com>
References: <20221114181207.2062901-1-gayatri.kammela@linux.intel.com>
Content-Language: en-US
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <20221114181207.2062901-1-gayatri.kammela@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/2022 10:11 AM, Gayatri Kammela wrote:
> This patch series focuses on redesigning the PMC core driver for
> maintainability and readability. Moving PCH specific structures and
> functions to separate c files, simplifies core.c file and makes it
> easier to add new platforms in future. The series includes two
> preparatory patches that lays the ground work for the redesign. The
> patch series also adds legacy support for Meteor Lake.
>
> This redesign adds following c files to support different PCHs. There
> are no functional changes involved for the already supported platforms.
>
> spt.c: Sunrise Point PCH supports: Sky Lake, Sky Lake L, Kaby Lake,
> Kaby Lake L
> cnp.c: Cannon Lake Point PCH supports: Cannon Lake L, Comet Lake,
> Comet Lake L
> icl.c: Ice Lake PCH supports: Ice Lake L, Ice Lake NNPI, Jasper Lake
> tgl.c: Tiger Lake PCH supports: Tiger Lake, Tiger Lake L, Alder Lake L,
> Alder Lake N, Rocket Lake, Raptor Lake P, Elkhart Lake
> adl.c: Alder Lake PCH supports: Alder Lake, Raptor Lake, Raptor Lake S
> mtl.c: Meteor Lake PCH supports: Meteor Lake
>
> Patch 1: platform/x86: intel/pmc: Replace all the reg_map with init
> functions
> Patch 2: platform/x86: intel/pmc: Move variable declarations and
> definitions to header and core.c
> Patch 3: platform/x86: intel/pmc: Relocate Sunrise Point PCH support
> Patch 4: platform/x86: intel/pmc: Relocate Cannon Lake Point PCH
> support
> Patch 5: platform/x86: intel/pmc: Relocate Ice Lake PCH support
> Patch 6: platform/x86: intel/pmc: Relocate Tiger Lake PCH support
> Patch 7: platform/x86: intel/pmc: Relocate Alder Lake PCH support
> Patch 8: platform/x86: intel/pmc: Add Meteor Lake support to pmc core
> driver
>
> Gayatri Kammela (4):
>    platform/x86: intel/pmc: Replace all the reg_map with init functions
>    platform/x86: intel/pmc: Relocate Tiger Lake PCH support
>    platform/x86: intel/pmc: Relocate Alder Lake PCH support
>    platform/x86: intel/pmc/core: Add Meteor Lake support to pmc core
>      driver
>
> Rajvi Jingar (1):
>    platform/x86: intel/pmc: Relocate Sunrise Point PCH support
>
> Xi Pardee (3):
>    platform/x86: intel/pmc: Move variable declarations and definitions to
>      header and core.c
>    platform/x86: intel/pmc: Relocate Cannon Lake Point PCH support
>    platform/x86: intel/pmc: Relocate Ice Lake PCH support
>
>   drivers/platform/x86/intel/pmc/Makefile |   3 +-
>   drivers/platform/x86/intel/pmc/adl.c    | 325 ++++++++
>   drivers/platform/x86/intel/pmc/cnp.c    | 210 +++++
>   drivers/platform/x86/intel/pmc/core.c   | 994 ++----------------------
>   drivers/platform/x86/intel/pmc/core.h   |  89 ++-
>   drivers/platform/x86/intel/pmc/icl.c    |  56 ++
>   drivers/platform/x86/intel/pmc/mtl.c    |  52 ++
>   drivers/platform/x86/intel/pmc/spt.c    | 140 ++++
>   drivers/platform/x86/intel/pmc/tgl.c    | 269 +++++++
>   9 files changed, 1183 insertions(+), 955 deletions(-)
>   create mode 100644 drivers/platform/x86/intel/pmc/adl.c
>   create mode 100644 drivers/platform/x86/intel/pmc/cnp.c
>   create mode 100644 drivers/platform/x86/intel/pmc/icl.c
>   create mode 100644 drivers/platform/x86/intel/pmc/mtl.c
>   create mode 100644 drivers/platform/x86/intel/pmc/spt.c
>   create mode 100644 drivers/platform/x86/intel/pmc/tgl.c
>
>
> base-commit: 309e0a6ed6e3fdb4febacc3e91aeb268500b90c6
>
> Cc: Xi Pardee <xi.pardee@intel.com>
> Cc: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Cc: David E Box <david.e.box@linux.intel.com>

Hi All,

Sorry, this is v1 and not v3. Please ignore this series. I will resend 
the v1 to avoid confusion.

