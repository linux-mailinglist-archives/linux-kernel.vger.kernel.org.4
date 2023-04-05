Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15BB6D8059
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbjDEPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbjDEPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:03:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26B5B88
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680707031; x=1712243031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s7rfBjbUMp2WFw8EcYwbRYPBRxvKQ3TJdf9vrLan3wA=;
  b=HIGXiv6HxtmX1vh3mgeWm5H7wup98I2vX5MQhjchI8HXGoO8NWNtSjsN
   PFYjWla8IVN4zV345va9Yyrz2D6zIutVTLMKrFdqNzpLFSB1ulqtleoXP
   5ceM3qCKDe57IWc0TU7S1LkzzIMmOS6NAYK3V12+28JO1ILdUxm82wMys
   eXQeI+Ur65Q2e9OBH6uVC0VSbBFynkMRsefN+xmxHFmUD0Xa+spwueASV
   kop5VU4ffBSNXh9W0RlS/wf/jfSkBRRW47BmdPIl7YCq/U7+o0ezxYLfx
   wW37MM3C4eoHRkpfpvpADy6mq5gQ1lyPb/Mv9FVXnYqTRjSNFRZdNSMmK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="331079251"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="331079251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 08:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="717072126"
X-IronPort-AV: E=Sophos;i="5.98,321,1673942400"; 
   d="scan'208";a="717072126"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 05 Apr 2023 08:03:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pk4f9-00CsaA-03;
        Wed, 05 Apr 2023 18:03:03 +0300
Date:   Wed, 5 Apr 2023 18:03:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Bumwoo Lee <bw365.lee@samsung.com>, linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 07/14] extcon: Use unique number for the extcon device
 ID
Message-ID: <ZC2NpgQ/JktJAzDm@smile.fi.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-8-andriy.shevchenko@linux.intel.com>
 <f0a40f3a-2ff6-5529-ad84-1c66f7e381ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a40f3a-2ff6-5529-ad84-1c66f7e381ea@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:52:46PM +0900, Chanwoo Choi wrote:
> On 23. 3. 22. 23:39, Andy Shevchenko wrote:

...

> > +	ret = ida_simple_get(&extcon_dev_ids, 0, INT_MAX, GFP_KERNEL);
> 
> 
> ida_simple_get and ida_simple_remove are deprecated on 
> commit 3264ceec8f17 ("lib/idr.c: document that ida_simple_{get,remove}()
> are deprecated"). Instead of them, better to use ida_alloc and ida_free 
> according to the comments.

Done for v2.

...

> > +	ida_simple_remove(&extcon_dev_ids, edev->id);
> 
> ditto.

Ditto.

-- 
With Best Regards,
Andy Shevchenko


