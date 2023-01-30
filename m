Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89B681878
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbjA3SQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbjA3SPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:15:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2392B60E;
        Mon, 30 Jan 2023 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675102549; x=1706638549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QjXjMnu6Y3KsGfyiWp4s/PbltUG+5MX/5jw4lyAX9SI=;
  b=ADRBXuR4/RUxMjE7apGEcC3zByEzkwGtZZXw0+n6W6bc5Kl+bqGAKVOi
   h3xQyBWJjgWwtR7JrsRNiwuqD9LbAKXkIvPVXk4bBGBhPYaqfkHcAet1k
   t8fRoO+ZbD0GRdEr94lxCFrSC99diXMX3yny36DtUhGuvJuRX0+DsSOMM
   azQcjM7racXV7eYCbI23WqCaUSdCtgEFy9JrzQ75Iihl6gP0QVCvuf0jr
   JeY3XTrXbdO1LCFhgsgu/grgFlem5BF4Lj4/n0HdyWDgKSHicTWWX7ssM
   c6+dSq3fHsMc1U95WS+yrnj/HkgDhxbK8wXEB5UWmUGHwK4nr8AbBSFvF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328909709"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="328909709"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:15:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657563974"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="657563974"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:15:34 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 9970A1202B0;
        Mon, 30 Jan 2023 16:39:47 +0200 (EET)
Date:   Mon, 30 Jan 2023 16:39:47 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John Stultz <jstultz@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Maxim Kiselev <bigunclemax@gmail.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Jean-Philippe Brucker <jpb@kernel.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 09/11] of: property: Simplify of_link_to_phandle()
Message-ID: <Y9fWsxYJgNR0z6te@kekkonen.localdomain>
References: <20230127001141.407071-1-saravanak@google.com>
 <20230127001141.407071-10-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127001141.407071-10-saravanak@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Thu, Jan 26, 2023 at 04:11:36PM -0800, Saravana Kannan wrote:
> The driver core now:
> - Has the parent device of a supplier pick up the consumers if the
>   supplier never has a device created for it.
> - Ignores a supplier if the supplier has no parent device and will never
>   be probed by a driver
> 
> And already prevents creating a device link with the consumer as a
> supplier of a parent.
> 
> So, we no longer need to find the "compatible" node of the supplier or
> do any other checks in of_link_to_phandle(). We simply need to make sure
> that the supplier is available in DT.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 84 +++++++------------------------------------
>  1 file changed, 13 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 134cfc980b70..c651aad6f34b 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1062,20 +1062,6 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
>  	return of_device_get_match_data(dev);
>  }
>  
> -static bool of_is_ancestor_of(struct device_node *test_ancestor,
> -			      struct device_node *child)
> -{
> -	of_node_get(child);
> -	while (child) {
> -		if (child == test_ancestor) {
> -			of_node_put(child);
> -			return true;
> -		}
> -		child = of_get_next_parent(child);
> -	}
> -	return false;
> -}
> -
>  static struct device_node *of_get_compat_node(struct device_node *np)
>  {
>  	of_node_get(np);
> @@ -1106,71 +1092,27 @@ static struct device_node *of_get_compat_node_parent(struct device_node *np)
>  	return node;
>  }
>  
> -/**
> - * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> - * @con_np: consumer device tree node
> - * @sup_np: supplier device tree node
> - *
> - * Given a phandle to a supplier device tree node (@sup_np), this function
> - * finds the device that owns the supplier device tree node and creates a
> - * device link from @dev consumer device to the supplier device. This function
> - * doesn't create device links for invalid scenarios such as trying to create a
> - * link with a parent device as the consumer of its child device. In such
> - * cases, it returns an error.
> - *
> - * Returns:
> - * - 0 if fwnode link successfully created to supplier
> - * - -EINVAL if the supplier link is invalid and should not be created
> - * - -ENODEV if struct device will never be create for supplier
> - */
> -static int of_link_to_phandle(struct device_node *con_np,
> +static void of_link_to_phandle(struct device_node *con_np,
>  			      struct device_node *sup_np)
>  {
> -	struct device *sup_dev;
> -	struct device_node *tmp_np = sup_np;
> +	struct device_node *tmp_np = of_node_get(sup_np);
>  
> -	/*
> -	 * Find the device node that contains the supplier phandle.  It may be
> -	 * @sup_np or it may be an ancestor of @sup_np.
> -	 */
> -	sup_np = of_get_compat_node(sup_np);
> -	if (!sup_np) {
> -		pr_debug("Not linking %pOFP to %pOFP - No device\n",
> -			 con_np, tmp_np);
> -		return -ENODEV;
> -	}
> +	/* Check that sup_np and its ancestors are available. */
> +	while (tmp_np) {
> +		if (of_fwnode_handle(tmp_np)->dev) {
> +			of_node_put(tmp_np);
> +			break;
> +		}
>  
> -	/*
> -	 * Don't allow linking a device node as a consumer of one of its
> -	 * descendant nodes. By definition, a child node can't be a functional
> -	 * dependency for the parent node.
> -	 */
> -	if (of_is_ancestor_of(con_np, sup_np)) {
> -		pr_debug("Not linking %pOFP to %pOFP - is descendant\n",
> -			 con_np, sup_np);
> -		of_node_put(sup_np);
> -		return -EINVAL;
> -	}
> +		if (!of_device_is_available(tmp_np)) {
> +			of_node_put(tmp_np);
> +			return;
> +		}
>  
> -	/*
> -	 * Don't create links to "early devices" that won't have struct devices
> -	 * created for them.
> -	 */
> -	sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> -	if (!sup_dev &&
> -	    (of_node_check_flag(sup_np, OF_POPULATED) ||
> -	     sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
> -		pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
> -			 con_np, sup_np);
> -		of_node_put(sup_np);
> -		return -ENODEV;
> +		tmp_np = of_get_next_parent(tmp_np);
>  	}
> -	put_device(sup_dev);
>  
>  	fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));

fwnode_link_add() returns int. Why is the return type of this function
changed to void?

> -	of_node_put(sup_np);
> -
> -	return 0;
>  }
>  
>  /**

-- 
Regards,

Sakari Ailus
