Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997766E8CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbjDTIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjDTIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:39:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C140C7;
        Thu, 20 Apr 2023 01:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681979948; x=1713515948;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4VPKHoRggY1IUF6tvOUimijOTqeaqrgEirRfDRYdkX4=;
  b=ENpSpNiiaKrxZ8/CL53kH9kQd7/4n2qJ7P6GDinCF0T2XhGoM4tnwjV+
   V0SjEnb7gIue16PUwKCLc8d/svXr0DQ5XAor0D0gIDck8BzZ73Zwat38y
   JPCGEKQoAbUNr8TvxsiQyg6pcBhETuKDwN19CEwvo8MciUCqSGYakNw2U
   wupdVZcWGdjb8t1PooOcJs5UqkC2C6Hp1ZNwuDEegnQsiyAAN/pVsBedF
   EPt99PWEIRmyyK97eiB0zU5QWMfZNfGVf75X1hMqubmb64Mz6KrFL7kxx
   zGkBGRbsrjQrr37DcEW1TtdN9mCNuvw/NDhXYR8dd2x96OFjAYSxVJULv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="410912719"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="410912719"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:39:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="835635411"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="835635411"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 20 Apr 2023 01:39:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 20 Apr 2023 11:39:04 +0300
Date:   Thu, 20 Apr 2023 11:39:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] usb: typec: fix potential NULL dereference
Message-ID: <ZED6KBl6HNT8D0ae@kuha.fi.intel.com>
References: <20230417195003.19504-1-korotkov.maxim.s@gmail.com>
 <ZD41tLi3sMB71Xf2@kroah.com>
 <22a5bd86-8d41-14e2-bb5a-968d15618adf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a5bd86-8d41-14e2-bb5a-968d15618adf@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 09:56:51AM +0300, Maxim Korotkov wrote:
> On 18.04.2023 09:16, Greg Kroah-Hartman wrote:
> > On Mon, Apr 17, 2023 at 10:50:03PM +0300, Maxim Korotkov wrote:
> > > The pointer 'adev' was being dereferenced before being checked for NULL
> > > in the 'type_alt mode_enter()' and 'type_alt mode_exit()' functions.
> > > Although this is a hypothetical issue, it's better to move the pointer
> > > assignment after the NULL check to avoid any potential problems.
> > > 
> > > Found by Linux Verification Center with Svace static analyzer.
> > > 
> > > Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> > > Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> > > ---
> > >   drivers/usb/typec/bus.c | 13 +++++++++----
> > >   1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
> > > index 098f0efaa58d..ae0aca8f33db 100644
> > > --- a/drivers/usb/typec/bus.c
> > > +++ b/drivers/usb/typec/bus.c
> > > @@ -125,13 +125,16 @@ EXPORT_SYMBOL_GPL(typec_altmode_notify);
> > >    */
> > >   int typec_altmode_enter(struct typec_altmode *adev, u32 *vdo)
> > >   {
> > > -	struct altmode *partner = to_altmode(adev)->partner;
> > > -	struct typec_altmode *pdev = &partner->adev;
> > > +	struct altmode *partner;
> > > +	struct typec_altmode *pdev;
> > >   	int ret;
> > >   	if (!adev || adev->active)
> > >   		return 0;
> > > +	partner = to_altmode(adev)->partner;
> > > +	pdev = &partner->adev;
> > 
> > As you point out, the original code is still fine here, we check before
> > we actually use these values.
> > 
> > Also, can adev every actually be NULL?  In looking at the code paths, I
> > can't see how that could happen.
> > 
> > thanks,
> > 
> > greg k-h
> 
> I agree that the adev will most likely never be NULL, but usually this
> pointer is checked before usage (for example in typec_altmode_notify() or
> typec_altmode_vdm()). It is a little odd that in these functions it utilized
> before check. Is it just extra check that can be removed?

Please go ahead and remove it.

thanks,

-- 
heikki
