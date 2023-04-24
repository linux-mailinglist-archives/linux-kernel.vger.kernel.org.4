Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B716ECD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjDXNUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjDXNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:20:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECEF4C17;
        Mon, 24 Apr 2023 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682342407; x=1713878407;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=07zWWxHob+csZ4llanNrZm26lx7Ujo9dMi7dGSKoJlI=;
  b=boz8bSmjawVci97IRC+kE4ssiGgw4y54MZnBIjaRqX/tO088/ZfZZzSX
   7xYOOJr7xjgeVkkPoAgza13RGdnVXB069diatepe7Ey27knt3ok+X09QG
   A0Fr/gqUB3ZFHUe9EsYvM5ZsK2ydhJBIhXDNLNTkKIaN8qbMmvAe+G6QE
   l/jsuzKCSuqUnEIUl3dY1/RZi78abEHeiG6yWdq4wQNtadSKxrrp9KSc5
   b0Oq9fENc7I32LwhmBVajly6H36+VlMP5CnaUSVzXrbyFJMuK1PZop9SW
   P39B/u/V6KmEg6GBV79/uVka/kf+oQJ/ruyoicrrlS9Jf7bXDDjiy7YSj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="374394885"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="374394885"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 06:20:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="939324604"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="939324604"
Received: from wlwpo-8.amr.corp.intel.com ([10.251.215.143])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 06:20:03 -0700
Date:   Mon, 24 Apr 2023 16:20:00 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/8] tty: n_gsm: add restart parameter to DLC specific
 ioctl config
In-Reply-To: <2023042459-humbly-confusing-9721@gregkh>
Message-ID: <bdb4347-d0e9-96c5-031-ecc549a7d1cd@linux.intel.com>
References: <20230424075251.5216-1-daniel.starke@siemens.com> <2023042438-whole-cannot-1945@gregkh> <DB9PR10MB588138A96EE5E7CE96E28221E0679@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM> <2023042459-humbly-confusing-9721@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Greg KH wrote:

> On Mon, Apr 24, 2023 at 11:03:26AM +0000, Starke, Daniel wrote:
> > > > --- a/include/uapi/linux/gsmmux.h
> > > > +++ b/include/uapi/linux/gsmmux.h
> > > > @@ -58,7 +58,8 @@ struct gsm_dlci_config {
> > > >  	__u32 priority;		/* Priority (0 for default value) */
> > > >  	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
> > > >  	__u32 k;		/* Window size (0 for default value) */
> > > > -	__u32 reserved[8];	/* For future use, must be initialized to zero */
> > > > +	__u32 restart;		/* Force DLCI channel reset? */
> > > 
> > > Why are you using a full 32 bits for just 1 bit of data here?  Why not
> > > use a bitfield?
> > 
> > The ioctrl guide states:
> >   Bitfields and enums generally work as one would expect them to,
> >   but some properties of them are implementation-defined, so it is better
> >   to avoid them completely in ioctl interfaces.
> > 
> > Therefore, I tried to avoid them here.
> 
> Then use a u8?

To add further, I think that the ioctl guidance tries to say that C 
bitfields using :number postfix are not a good idea, not that much to 
disallow flag like content within an integer type.

-- 
 i.

> > > And what happened to the request to turn the documentation for this
> > > structure into proper kerneldoc format?
> > 
> > That applied to patch 2/8 and is unrelated to this patch. Another patch
> > will need to fix this.
> > 
> > Link: https://lore.kernel.org/all/20230424075251.5216-2-daniel.starke@siemens.com/
> 
> It's kind of related in that the format is not right :)
> 
> As it's a few weeks before I am allowed to even apply this, please
> rework the series a bit.
> 
> thanks,
> 
> greg k-h
> 

