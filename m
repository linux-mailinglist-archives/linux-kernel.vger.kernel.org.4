Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C835566580E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbjAKJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbjAKJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:48:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A011A29;
        Wed, 11 Jan 2023 01:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A319D61B96;
        Wed, 11 Jan 2023 09:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A035C433A8;
        Wed, 11 Jan 2023 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673430418;
        bh=q0MTQbhS4MjxtbLiLzvG2UgbCXEINak0W4RxzYpWLNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2m3LQPz8klAo5lmv1lQnnS32RnpBjVnoIKlTX3SjDR1cz7SnWI2FoA6TzpQi58zc
         cbIsfcZkcKAjQse33rc5b9J3K44+9PFwfLXbD375VhsfSt9ciFKVqIOtH8i6e4qyTR
         jU1UyZW8M4dMLqbERhxH5Tp0aNoAnIQ48zo2IVaE=
Date:   Wed, 11 Jan 2023 10:46:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Won Chung <wonchung@google.com>, linux-block@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/5] driver core: make struct device_type.devnode() take
 a const *
Message-ID: <Y76FjzouxRSfgiIC@kroah.com>
References: <20221123122523.1332370-1-gregkh@linuxfoundation.org>
 <20221123122523.1332370-4-gregkh@linuxfoundation.org>
 <637e733838b5f_12cdff29466@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637e733838b5f_12cdff29466@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:23:36AM -0800, Dan Williams wrote:
> Greg Kroah-Hartman wrote:
> > The devnode() callback in struct device_type should not be modifying the
> > device that is passed into it, so mark it as a const * and propagate the
> > function signature changes out into all relevant subsystems that use
> > this callback.
> > 
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Alison Schofield <alison.schofield@intel.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Ben Widawsky <bwidawsk@kernel.org>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Jeremy Kerr <jk@ozlabs.org>
> > Cc: Joel Stanley <joel@jms.id.au>
> > Cc: Alistar Popple <alistair@popple.id.au>
> > Cc: Eddie James <eajames@linux.ibm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jilin Yuan <yuanjilin@cdjrlc.com>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Cc: Won Chung <wonchung@google.com>
> > Cc: linux-block@vger.kernel.org
> > Cc: linux-cxl@vger.kernel.org
> > Cc: linux-fsi@lists.ozlabs.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [..]
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 20ce488a7754..6ae8d0bdc61b 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -27,7 +27,7 @@ static void cxl_memdev_release(struct device *dev)
> >  	kfree(cxlmd);
> >  }
> >  
> > -static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
> > +static char *cxl_memdev_devnode(const struct device *dev, umode_t *mode, kuid_t *uid,
> >  				kgid_t *gid)
> >  {
> >  	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
> 
> For the CXL bit:
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>

Thanks for the review!
