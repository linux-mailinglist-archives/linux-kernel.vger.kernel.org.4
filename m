Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4183736F08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjFTOrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjFTOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:47:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8CF95
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687272462; x=1718808462;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=LG0edqrvyHsDW/l6sS9e6UCd7Let6v/Fg5o7MAHvm2I=;
  b=RzS3sbE9m/1kV185sTjYGauGTk+/OtLeHBSGs5cDUMi4ZEA4EwIwCk5T
   RNSlZSqAIo6fpbOhR2xOqijlexa8CmkA+1dNN8hBHIkXDcCY2S8Y48lBv
   WvOAVd3JIC2pBKHgv/xrdKjI3CXLd4P3FrwvLXxCAOISEjGY/mkicctoj
   s9hzC/stu2bDbVPzpzb9kcFzC3t/PvMjCMWSQ9KyEng42XzH2hGHkh2oX
   emyAXGY4FNPYqAZzW3VubcOq2E8cmvgCC+E/DQ/Vx4IRC/I9LHE513Ydi
   nwAmet43s3+sThrwWJ7uZWeDeXwwuvufyb8AJuTeG3i67ATY+JaQ/NzDY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446251940"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="446251940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 07:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827023019"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="827023019"
Received: from dshvarts-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.62.204])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 07:47:37 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/3] linux/bits.h: Add fixed-width GENMASK and BIT macros
In-Reply-To: <ZIs0CC2J7nu0LHEK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com> <87pm75kd0h.fsf@intel.com>
 <ZF4j0NPoBGMBT8CO@smile.fi.intel.com> <87mt29kc34.fsf@intel.com>
 <ZIs0CC2J7nu0LHEK@smile.fi.intel.com>
Date:   Tue, 20 Jun 2023 17:47:34 +0300
Message-ID: <875y7igph5.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, May 12, 2023 at 02:45:19PM +0300, Jani Nikula wrote:
>> On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Fri, May 12, 2023 at 02:25:18PM +0300, Jani Nikula wrote:
>> >> On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> >> > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
>> >> >> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
>> >> >> masks for fixed-width types and also the corresponding BIT_U32(),
>> >> >> BIT_U16() and BIT_U8().
>> >> >
>> >> > Why?
>> >> 
>> >> The main reason is that GENMASK() and BIT() size varies for 32/64 bit
>> >> builds.
>> >
>> > When needed GENMASK_ULL() can be used (with respective castings perhaps)
>> > and BIT_ULL(), no?
>> 
>> How does that help with making them the same 32-bit size on both 32 and
>> 64 bit builds?
>
> 	u32 x = GENMASK();
> 	u64 y = GENMASK_ULL();
>
> No? Then use in your code either x or y. Note that I assume that the parameters
> to GENMASK*() are built-time constants. Is it the case for you?

What's wrong with wanting to define macros with specific size, depending
on e.g. hardware registers instead of build size?

What would you use for printk format if you wanted to to print
GENMASK()?


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
