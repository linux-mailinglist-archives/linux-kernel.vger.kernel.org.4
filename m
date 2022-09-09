Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6651D5B3500
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIIKRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIIKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:17:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF3129C6C;
        Fri,  9 Sep 2022 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662718666; x=1694254666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=twmve2pp6FrQGPPjMyndpXyUbQtJvOD5cguRNbI4b8k=;
  b=LNomahuwvi9Ima+PTJbdzu13/NoqIfSY+viDyk/pqJBLgBx79r1tzYSL
   dNoApEmfTG1kXPexjt5yrVSLkOnzgJSVr74dgajVbkCQroE1DD3+TgInx
   J1Z9d7/kEEmk+6RDwZegYRqg7UCmN/cNPMoF4gyjJAfwJeNYUJ6e+YmuL
   AxtryTlJqF1dhFEQ5n/+rHl9+vi8LzjChrxmhxJm6CtIJRvLhC7ZZ1bM8
   qrx/X5LSkcPjR9zWWolCv8ztbsyLSZRcJLUzn/aCZ+0kyCr+LA82LfYdn
   gMWGxIjVDSQvpWL1Gbs9lPoNAG+6/EN6iiIjouvKPq/0ooZcE6tQhWfrt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323652426"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="323652426"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:17:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="592559923"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 03:17:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWb4v-00AW30-1f;
        Fri, 09 Sep 2022 13:17:41 +0300
Date:   Fri, 9 Sep 2022 13:17:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
Message-ID: <YxsSxbB47TNm2p0B@smile.fi.intel.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
 <81acf91-ba43-f276-fca7-ac9c9e721a88@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81acf91-ba43-f276-fca7-ac9c9e721a88@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 12:16:58PM +0300, Ilpo Järvinen wrote:
> On Fri, 9 Sep 2022, Andy Shevchenko wrote:
> 
> > uart_xmit_advance() provides a common way on how to advance
> > the Tx queue. Use it for the sake of unification and robustness.

...

> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks!

> Please note though that I already have patches for almost all these but
> I've not just submitted the remaining ones yet.

My interest only for a limited scope of 8250 compatible UARTs, I have sent
just a couple of patches and I don't think I will send more.


-- 
With Best Regards,
Andy Shevchenko


