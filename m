Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AE9731D38
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbjFOP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 11:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjFOP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 11:58:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F8710F6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686844738; x=1718380738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LZa6EpnGegWMGroiF8gOVmJKRW3LU37iwvOPShYDQxM=;
  b=A1/KcBNZUfvmsMbvRT4hkSKgRqCbg9AnuImx73HabZ2Ocv1Qs/aUe4ck
   wW3l59gSwJCfWMjXI7PO9tM4+nsOGTJvIXBK8g5M62BWLRHZQv2ukD4xy
   YNyB8t8dhx1dTHQmDla0ZUYe3VufsX1ixt7XEDwC6gd9kR0BWDF1AqtL3
   4XIdd+p1gWHJp9QDwl3IAV/s6SG+Johsa42T/QugTYYR+LYeENxtzWaCl
   /4j3l31ijnHj94MtJtIPD9CxSGMqOiGgGUitzhb/L63I6febi3CWDcz/I
   U66EylnWIacV/nhNawuzfsi5TKy8iSFxjyfczdQAybfTOxf8fk/hTFcbO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356450348"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="356450348"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715680016"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715680016"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 08:58:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9pMo-003yji-0e;
        Thu, 15 Jun 2023 18:58:34 +0300
Date:   Thu, 15 Jun 2023 18:58:33 +0300
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
Message-ID: <ZIs1KQOeunnBeha2@smile.fi.intel.com>
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com>
 <5wfbihhliddinlvsh23dejbuffiz45ecs3wb37qcwyqd3hjfcm@wyhqnobiiu22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5wfbihhliddinlvsh23dejbuffiz45ecs3wb37qcwyqd3hjfcm@wyhqnobiiu22>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 09:29:23AM -0700, Lucas De Marchi wrote:
> On Fri, May 12, 2023 at 02:14:19PM +0300, Andy Shevchenko wrote:
> > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
> > > Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
> > > masks for fixed-width types and also the corresponding BIT_U32(),
> > > BIT_U16() and BIT_U8().
> > 
> > Why?
> 
> to create the masks/values for device registers that are
> of a certain width, preventing mistakes like:
> 
> 	#define REG1		0x10
> 	#define REG1_ENABLE	BIT(17)
> 	#define REG1_FOO	GENMASK(16, 15);
> 
> 	register_write(REG1_ENABLE, REG1);
> 
> 
> ... if REG1 is a 16bit register for example. There were mistakes in the
> past in the i915 source leading to the creation of the REG_* variants on
> top of normal GENMASK/BIT (see last patch and commit 09b434d4f6d2
> ("drm/i915: introduce REG_BIT() and REG_GENMASK() to define register
> contents")

Doesn't it look like something for bitfield.h candidate?
If your definition doesn't fit the given mask, bail out.

-- 
With Best Regards,
Andy Shevchenko


