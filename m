Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE94700674
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbjELLO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241028AbjELLO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:14:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237D2120B5
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683890066; x=1715426066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b2bSeUNs7PpWjC5QOLRCXQ3B+M8q/ixInf2CByxcbkc=;
  b=U91Ynp/5Lb0nHj2X1c/O6nvQx/KaIdRh8xkMxAaG52WLt1c8h/WwjzMy
   SxzpXki5m1ZUljcr82cLlZ6st3ITrBkyLBnL6foOesaEzbJBrflpR1b08
   myficAyS8BqOpcChnz5ySNCRifgtGP2G3FGxOn7+uQUXrYd9izg3QUk37
   yXm4d4GNgL09l5GYmuvREHtygs5j6hxUY+L0tGhmzzPcL10B4mZhcHhup
   L9PFfF6qsagPUITGsUG08nEVUmTUj+4/YXuqf3V7dMoIh9440ehMYE1Tw
   b669dTnyHw6T8PWh/IqRXFrf9G3++uVd5ygJg5GbqwbOI4eBnUFe/MJv6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="378900272"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378900272"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730785709"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="730785709"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2023 04:14:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pxQj5-0004b6-3D;
        Fri, 12 May 2023 14:14:19 +0300
Date:   Fri, 12 May 2023 14:14:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
Message-ID: <ZF4fi5B7PPlgZBOI@smile.fi.intel.com>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509051403.2748545-3-lucas.demarchi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> masks for fixed-width types and also the corresponding BIT_U32(),
> BIT_U16() and BIT_U8().

Why?

> All of those depend on a new "U" suffix added to the integer constant.
> Due to naming clashes it's better to call the macro U32. Since C doesn't
> have a proper suffix for short and char types, the U16 and U18 variants
> just use U32 with one additional check in the BIT_* macros to make
> sure the compiler gives an error when the those types overflow.
> The BIT_U16() and BIT_U8() need the help of GENMASK_INPUT_CHECK(),
> as otherwise they would allow an invalid bit to be passed. Hence
> implement them in include/linux/bits.h rather than together with
> the other BIT* variants.

So, we have _Generic() in case you still wish to implement this.

-- 
With Best Regards,
Andy Shevchenko


