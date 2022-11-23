Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6855635333
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbiKWItQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiKWItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:49:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FBC14D0A;
        Wed, 23 Nov 2022 00:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669193344; x=1700729344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fgOfapqW2CoqDrEhOH22xK8eCPNP5ZTokn6bHwFpdvA=;
  b=S3r8gikPQDS8eFUkQGjaFLARx/6k7GtXdIMscakbylHxaAv/R0ZXdOM/
   2M7gXKfH9fUAUiW06DU00YTO8sRQy11gmMGWXwLwnYoxzTcJ0YfzB4pJa
   TzkOwLiK6wSz5Zs5prT/Lu0UQrf+YbqPkwo8gSPcw69hzUPf4kzStDOdH
   j3jtxUAT4ZqY6C2V56t5ff1jsEs8zw9QD8CCdHfem4SBxlDifMacwWMmp
   CdBzAaJtSAxYHMsvL2Xu6irCwoTtH1eDDn58M+0kXUUp2Nru8CCvad4Qx
   12Wx0hKap1tlA9F/J9yHf6kjyuXUPpNsgtkXTWjERApWrt1SnA9KlSyiT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="340894622"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="340894622"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:49:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="784160188"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="784160188"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Nov 2022 00:49:01 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Nov 2022 10:49:01 +0200
Date:   Wed, 23 Nov 2022 10:49:01 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 1/2] usb: typec: Add helper to get partner device struct
Message-ID: <Y33efUCVpkgpQz0O@kuha.fi.intel.com>
References: <20221121201337.2772216-1-pmalani@chromium.org>
 <20221121201337.2772216-2-pmalani@chromium.org>
 <Y3ydPqkxxQCSGGp7@kuha.fi.intel.com>
 <CACeCKaeCA3+0BVyUO72HvUbV7mcjEcGT4uXnA2X8=CUdjdtOuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaeCA3+0BVyUO72HvUbV7mcjEcGT4uXnA2X8=CUdjdtOuQ@mail.gmail.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:05:04AM -0800, Prashant Malani wrote:
> Hi Heikki,
> 
> Thanks for reviewing the patch.
> 
> On Tue, Nov 22, 2022 at 1:58 AM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Let's not loose the protection around these devices unless there is no
> > other way, and in this case there is.
> >
> > Please just create a wrapper for usb_power_delivery_register() instead:
> >
> > struct usb_power_delivery *
> > typec_partner_usb_power_delivery_register(struct typec_partner *partner,
> >                                           struct usb_power_delivery_desc *desc)
> > {
> >         return usb_power_delivery_register(&partner->dev, desc);
> > }
> > EXPORT_SYMBOL_GPL(typec_partner_usb_power_delivery_register);
> 
> Sounds good. I'll send a v2 with the above change as patch 1 (instead
> of the current patch 1).
> 
> I will list you as the "Suggested-by" tag (but please let me know if
> you'd like attribution stated differently).

Thanks. Suggested-by is the correct tag IMO.

cheers,

-- 
heikki
