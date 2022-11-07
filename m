Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79B861F235
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiKGLur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiKGLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:50:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00941A38E;
        Mon,  7 Nov 2022 03:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667821844; x=1699357844;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XpXWt8wuTNay08we0kpVyVUQSkZOZQKYsYrZtuRP7q8=;
  b=I9mZzES2MP2IwtQGlczr15X9hIlrpg9wCuvekHNRmup1SvQakH2Uar2t
   mk7j0BFpw0B158p+EGBvkhfnVnbpepDCVdEaK8iynOiQrMdtLsFTwUsJ5
   +jRoLQ2BKfSvv5S4DWt3bkI81vS0JzvARw+D5m8AaaB+d62k6fIY4TeZ+
   1czgsYLZvuKl3NoC9BuUW5/xzZajOJiuVqLHC7hZ9/F6RxC96j6HBOZ7l
   7iKQfh8vnyt8Wz7Fcj6BZY8crM7+E9PYXD3IQ+6/HC+orkqKfgGpmvJBo
   FfdQVHoJ+WZuDKycHP8zLPMAJNq8hiCqRGjLhIrCXza6HzhNsinBu0vtI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="311525697"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="311525697"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:50:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="635880143"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; 
   d="scan'208";a="635880143"
Received: from gschoede-mobl1.ger.corp.intel.com ([10.252.46.211])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 03:50:41 -0800
Date:   Mon, 7 Nov 2022 13:50:38 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] 8250: DMA Fixes
In-Reply-To: <Y2js3Xsq1Fmz1mTq@smile.fi.intel.com>
Message-ID: <b66aa1-50ab-ecc-1633-d6e83f5cd925@linux.intel.com>
References: <20221107110708.58223-1-ilpo.jarvinen@linux.intel.com> <Y2js3Xsq1Fmz1mTq@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-958723828-1667820915=:56477"
Content-ID: <f6d7d065-7c86-6b86-28bc-3114c847489f@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-958723828-1667820915=:56477
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <3087fb9-ada7-8275-9bc3-a0b62ca08322@linux.intel.com>

On Mon, 7 Nov 2022, Andy Shevchenko wrote:

> On Mon, Nov 07, 2022 at 01:07:04PM +0200, Ilpo Järvinen wrote:
> > Here are a number of 8250 DMA related fixes. The last one seems the
> > most serious problem able to corrupt the payload ordering.
> > 
> > Ilpo Järvinen (4):
> >   serial: 8250: Fall back to non-DMA Rx if IIR_RDI occurs
> 
> 8250_port?
> 
> >   serial: 8250_lpss: Configure DMA also w/o DMA filter
> >   serial: 8250_lpss: Use 16B DMA burst with Elkhart Lake
> >   serial: 8250: Flush DMA Rx on RLSI
> 
> 8250_port?

Why?

To me this 8250_core/port split is still integral part of the same 
8250 even if they're in the end technically loaded into different modules
or the code is in a different file. There's even some trickery to access 
internals of the other part to workaround the circular module dependency 
logic that would otherwise prevent the split (like we learned not so long 
time ago with that setup_irq change).

I can start to use 8250_port if you insist but it seems pointless 5 extra 
characters out from a resource that is scarse to begin with, IMHO (the 
summary line is not that long).


-- 
 i.
--8323329-958723828-1667820915=:56477--
