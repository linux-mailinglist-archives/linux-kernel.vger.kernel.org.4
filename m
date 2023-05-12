Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB91970071F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbjELLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjELLp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:45:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5B40F8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683891927; x=1715427927;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dYYNFnS0C9MVpLeh+UPAsMuKqp0z8z6OdbK4OMSu5kk=;
  b=EdnND/N7ijpTnS7wcQOrO3Hopzc9DnT6qWemtdexKOdOhLenLH51kFZY
   6UFV42DkL9ajafo8M+p5F07mgO0243cv9J6BlE76Hw/+fcHfa+eG5x+Er
   bkctydcfRbRo8/qhJOGczIBpJ2uSj0/H1xxu4y8jVVHvncrYCwh6/qFhO
   v2KdtpAFlQOTSq1BkNJjO5lib30Y7hxZRGs3ZDrE99ZOwymvnEHy2FSWA
   Spsd++dGNfMP87nPSOVO0X24IRiNuVorswczfHlYMizwoIb3+nhY1zSJr
   I1+jgUoHrt3hQM6DVtgpivHKYQ1ogEqR0JZw7F4zQthXT+UoKkQzBVXMj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="340084833"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="340084833"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="733017118"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="733017118"
Received: from tsavina-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.63.51])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 04:45:22 -0700
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
In-Reply-To: <ZF4j0NPoBGMBT8CO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230509051403.2748545-1-lucas.demarchi@intel.com>
 <20230509051403.2748545-3-lucas.demarchi@intel.com>
 <ZF4fi5B7PPlgZBOI@smile.fi.intel.com> <87pm75kd0h.fsf@intel.com>
 <ZF4j0NPoBGMBT8CO@smile.fi.intel.com>
Date:   Fri, 12 May 2023 14:45:19 +0300
Message-ID: <87mt29kc34.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, May 12, 2023 at 02:25:18PM +0300, Jani Nikula wrote:
>> On Fri, 12 May 2023, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>> > On Mon, May 08, 2023 at 10:14:02PM -0700, Lucas De Marchi wrote:
>> >> Add GENMASK_U32(), GENMASK_U16() and GENMASK_U8()  macros to create
>> >> masks for fixed-width types and also the corresponding BIT_U32(),
>> >> BIT_U16() and BIT_U8().
>> >
>> > Why?
>> 
>> The main reason is that GENMASK() and BIT() size varies for 32/64 bit
>> builds.
>
> When needed GENMASK_ULL() can be used (with respective castings perhaps)
> and BIT_ULL(), no?

How does that help with making them the same 32-bit size on both 32 and
64 bit builds?

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
