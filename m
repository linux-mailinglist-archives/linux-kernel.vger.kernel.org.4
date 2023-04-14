Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1706E2905
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDNRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDNRMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:12:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA412F;
        Fri, 14 Apr 2023 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681492356; x=1713028356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BvUZ/WxkZ91U7aHTLOgkDO1QjRQQwhV++ic08HnfP2U=;
  b=YV2lUzJPWeMtN4AN70nEVaSLBcog3BOgmq2Vs7uovxQNAJaqitvV2Her
   FHp78uNsmKsX9nOMtx06W3tktSyipvkaVH4xvNdUipZh+1XgQ0IEVxnXN
   JinMq3MWrlAKMhj3TKL+s3RnNpJ9o5g8Af42g047nPc96aPSpXB9J0euj
   0tej53wkib//1OadH4TIdLMxliXaAcCUqACQRuSdy66nOTAQBPtqXrKsY
   ugp3GHb9WQPFGmB36y9GVAjs0sxZzRIXg/n5NYwTYsqgYPK6l8Y5nlU9D
   nQIibOADhyR8b4F9qEKw9kffRrD7tSoFWTnyaZPXGpnI48n4tGcv13+/l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="407396285"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="407396285"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 10:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="689878765"
X-IronPort-AV: E=Sophos;i="5.99,197,1677571200"; 
   d="scan'208";a="689878765"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Apr 2023 10:10:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pnMwT-00HDQf-2Z;
        Fri, 14 Apr 2023 20:10:33 +0300
Date:   Fri, 14 Apr 2023 20:10:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: 8250_exar: Add support for USR298x PCI Modems
Message-ID: <ZDmJCa4I5EA9GLMm@smile.fi.intel.com>
References: <20230413214421.6251-1-afd@ti.com>
 <20230413214421.6251-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413214421.6251-2-afd@ti.com>
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

On Thu, Apr 13, 2023 at 04:44:21PM -0500, Andrew Davis wrote:
> Possibly the last PCI controller-based (i.e. not a soft/winmodem)
> dial-up modem one can still buy.
> 
> Looks to have a stock XR17C154 PCI UART chip for communication, but for
> some reason when provisioning the PCI IDs they swapped the vendor and
> subvendor IDs. Otherwise this card would have worked out of the box.
> 
> Searching online, some folks seem to not have this issue and others do,
> so it is possible only some batches of cards have this error.
> 
> Create a new macro to handle the switched IDs and add support here.

Yeah, and here you just going to support the schema before your patch 1.

For this patch
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


