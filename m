Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4671C6908A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBIM0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjBIM0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:26:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD5274BA;
        Thu,  9 Feb 2023 04:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A31A1B8211B;
        Thu,  9 Feb 2023 12:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93062C433EF;
        Thu,  9 Feb 2023 12:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675945599;
        bh=4PAT5Hx/TWpqFm56WFSX/26ylK2+Mq35WOKpFnjsaok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AiKoea1ccEi66fLguRY4knhkORHjErfw/yOgNcIW5ISYMJCm3QNoMx7TfqiDMbO16
         OaSVYzjvsD4Z6PU/i3ajYxySCJN0zxzvdP3TCtWUNxfWxfEXGyKE+wcfYGDBk4IlJJ
         YM3QvEHNbHDHYxFqnqmY7jEkZCll8EvSNfQjLiqY=
Date:   Thu, 9 Feb 2023 13:26:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] tty: n_gsm: add keep alive support
Message-ID: <Y+Tme2bRXCebRGcS@kroah.com>
References: <20230206114606.2133-1-daniel.starke@siemens.com>
 <20230206114606.2133-2-daniel.starke@siemens.com>
 <Y+OTN4E6W5h4oztW@kroah.com>
 <DB9PR10MB58818B4443F5EA3CB8766DF3E0D99@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58818B4443F5EA3CB8766DF3E0D99@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:09:04PM +0000, Starke, Daniel wrote:
> > > +	if (gsm->ka_num && gsm->ka_retries == 0) {
> > > +		/* Keep-alive expired -> close the link */
> > > +		if (debug & DBG_ERRORS)
> > > +			pr_info("%s keep-alive timed out\n", __func__);
> > 
> > info for a debugging error?  no, please don't do that.  Please fix up
> > the debugging mess in this driver, don't add to it.
> 
> I am aware that the current debugging concept of the driver does not align
> with the kernel philosophy. However, this is the established way it is
> handled in n_gsm right now. Cleaning this up should be done before adding
> new concepts here. But not printing out any information in case of errors
> does not help during use and development of/for this driver. Also note that
> all these outputs are only enabled if explicitly set via kernel module
> parameter. That means syslog does not get polluted if not intentionally
> set so. Unfortunately, I do not have a better proposal for now as neither
> ftrace nor dynamic debug are available to the normal Linux user.

dynamic debug _is_ availble to the normal Linux user, and it's _the_
kernel debug facility and interface.  To not use it is to somehow state
that this one tiny .c file is unique and special over the whole of the
rest of the kernel :)

I recommend just moving to the dynamic debug interface now and then
going forward, it's not going to be an issue at all.

> > > +struct gsm_config_ext {
> > > +	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
> > > +				 * second (0 to disable)
> > > +				 */
> > > +	__u32 reserved[7];	/* For future use */
> > 
> > say "must be set to 0"?
> 
> Right, I will add ", needs to be initialized to zero".

Use "must", that means more.

> > Where are you documenting this ioctl so userspace knows how to use it?
> > Where is the userspace tool that uses it?
> 
> I will extend the description and code example in
> Documentation/driver-api/tty/n_gsm.rst. Should this go CC to
> linux-man@vger.kernel.org?

I don't know, if there is a man page for it, yes, if not, no need.

thanks,

greg k-h
