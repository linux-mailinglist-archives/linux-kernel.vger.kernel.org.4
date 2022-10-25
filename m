Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557CD60C400
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJYGsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiJYGsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:48:46 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E314C51E;
        Mon, 24 Oct 2022 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666680521; x=1698216521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Igm2YXVsITO0q1gnmGrhBBce4AS/xc/BK9V7bbBw9/U=;
  b=Dxezeokg++hf2NGyKDJlkHFjPZ0BVf4spApIXrjMV09mcwAKqwYDGlfc
   Hjo4ElZqNkwy57Oj728X3knBmwsPYXTeAoFgktB1dhRL+IS32a7n7+IzO
   ydkVHGkpLGXMan7PddUsE9+iqoNB9xZNtFYbfh9QEwLEZNKa0YflcepB7
   5lYWpvaZvt+A7EGLW/3C0NVjGEMXI7wyjVOz/tI2BMEZvh/mWqF5KvXTA
   nfiz5JHTDplYOf9/bgr2F3ScGMtE0B9LcV0qkgEWmFnk/rK7c3zkv34vr
   zlb/pCz9ZNRHZqj4cZqre+nm2teZ1GhWyFbwnJp3CGloS0/PRzIczOYkd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="306333490"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="306333490"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:48:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="631529267"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="631529267"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:48:37 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id DE16120144;
        Tue, 25 Oct 2022 09:48:34 +0300 (EEST)
Date:   Tue, 25 Oct 2022 06:48:34 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Akhil R <akhilrajeev@nvidia.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: fwnode: fix fwnode_irq_get_byname() kerneldoc
Message-ID: <Y1eGwtqbOhXCGoaM@paasikivi.fi.intel.com>
References: <Y1dzCCMCDswQFVvO@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1dzCCMCDswQFVvO@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moi,

On Tue, Oct 25, 2022 at 08:24:24AM +0300, Matti Vaittinen wrote:
> The fwnode_irq_get_byname() may return zero on device-tree mapping
> error. Fix documentation to reflect this as current documentation
> suggests check:
> 
> if (ret < 0)
> is enough to detect the errors. This is not the case.
> 
> Add zero as a return value indicating error.
> 
> Fixes: ca0acb511c21 ("device property: Add fwnode_irq_get_byname")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 4d6278a84868..df437d10aa08 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -960,7 +960,7 @@ EXPORT_SYMBOL(fwnode_irq_get);
>   * string.
>   *
>   * Return:
> - * Linux IRQ number on success, or negative errno otherwise.
> + * Linux IRQ number on success, zero or negative errno otherwise.

I wonder if it would be possible instead to always return a negative error
code on error. Returning zero on error is really unconventional and can be
expected to be a source of bugs.

We have code already that takes the error code zero into account in e.g.

static int smbalert_probe(struct i2c_client *ara,
                          const struct i2c_device_id *id)
{
...
                irq = fwnode_irq_get_byname(dev_fwnode(adapter->dev.parent),
                                            "smbus_alert");
                if (irq <= 0)
                        return irq;

And zero turns into successful probe!

>   */
>  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name)
>  {

-- 
Terveisin,

Sakari Ailus
