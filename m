Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A76E710343
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjEYDVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEYDVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E0C5;
        Wed, 24 May 2023 20:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6359163456;
        Thu, 25 May 2023 03:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40561C433D2;
        Thu, 25 May 2023 03:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684984899;
        bh=lgKBmTvgBzJ+dI7EcVQ1lM0GVoaJUUKSJKoKhDNjIQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPA/nMddJC5SmoPM+NPnp5Yt3qOj7z+dBqtyFuRBAjCH6sw3gl35TPy6n+VhyUhHC
         pJIWQoMYd7+iKrnKZCQ1QIP99z9cozD/Hp/kbNnhmgvk8v4QqOY+id/eErEUOkYUoj
         z7uQjIr+apaoOOfnxLI4QGPEAiys5QziLBPV9INOIB7LqAkWmiP/JZxjA4u0BDi7bz
         tVhm+BGfbvEsrZywbKHdKblrz4vkei7S+BOEbpS1ajZ0ZqTP0YzOPy2qzh3N/zBAvk
         RygP2tnxylrpNRN3Tw5eHRkU6s1aMt3aEAXnJvLoljsq8ES1LWwqVFz7SplHx1ENQF
         gZiFzdZajGdtg==
Date:   Wed, 24 May 2023 20:25:30 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] usb: typec: mux: Clean up mux_fwnode_match()
Message-ID: <20230525032530.u5jecuucmdrsuroo@ripper>
References: <20230524122901.53659-1-heikki.krogerus@linux.intel.com>
 <20230524122901.53659-2-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524122901.53659-2-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:29:00PM +0300, Heikki Krogerus wrote:
> Removing the "svid" and "accessory" device property checks.
> Those properties are not supported on any platform.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Link: https://lore.kernel.org/lkml/20230522215348.uoyboow26n2o3tel@ripper/
> Cc: Bjorn Andersson <andersson@kernel.org>
> ---
>  drivers/usb/typec/mux.c | 55 ++++++-----------------------------------
>  1 file changed, 7 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
> index d9eaf9a0b0bfd..089c2fd478318 100644
> --- a/drivers/usb/typec/mux.c
> +++ b/drivers/usb/typec/mux.c
> @@ -265,60 +265,19 @@ static int mux_fwnode_match(struct device *dev, const void *fwnode)
>  static void *typec_mux_match(const struct fwnode_handle *fwnode,
>  			     const char *id, void *data)
>  {
> -	const struct typec_altmode_desc *desc = data;
>  	struct device *dev;
> -	bool match;
> -	int nval;
> -	u16 *val;
> -	int ret;
> -	int i;
>  
>  	/*
> -	 * Check has the identifier already been "consumed". If it
> -	 * has, no need to do any extra connection identification.
> +	 * Device graph (OF graph) does not give any means to identify the
> +	 * device type or the device class of the remote port parent that @fwnode
> +	 * represents, so in order to identify the type or the class of @fwnode
> +	 * an additional device property is needed. With typec switches the

s/switches/muxes/

> +	 * property is named "orientation-switch" (@id). The value of the device

s/orientation-switch/mode-switch/

With that:

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Tested-by: Bjorn Andersson <andersson@kernel.org>

Thank you,
Bjorn

> +	 * property is ignored.
>  	 */
> -	match = !id;
> -	if (match)
> -		goto find_mux;
> -
> -	if (!desc) {
> -		/*
> -		 * Accessory Mode muxes & muxes which explicitly specify
> -		 * the required identifier can avoid SVID matching.
> -		 */
> -		match = fwnode_property_present(fwnode, "accessory") ||
> -			fwnode_property_present(fwnode, id);
> -		if (match)
> -			goto find_mux;
> -		return NULL;
> -	}
> -
> -	/* Alternate Mode muxes */
> -	nval = fwnode_property_count_u16(fwnode, "svid");
> -	if (nval <= 0)
> +	if (id && !fwnode_property_present(fwnode, id))
>  		return NULL;
>  
> -	val = kcalloc(nval, sizeof(*val), GFP_KERNEL);
> -	if (!val)
> -		return ERR_PTR(-ENOMEM);
> -
> -	ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
> -	if (ret < 0) {
> -		kfree(val);
> -		return ERR_PTR(ret);
> -	}
> -
> -	for (i = 0; i < nval; i++) {
> -		match = val[i] == desc->svid;
> -		if (match) {
> -			kfree(val);
> -			goto find_mux;
> -		}
> -	}
> -	kfree(val);
> -	return NULL;
> -
> -find_mux:
>  	dev = class_find_device(&typec_mux_class, NULL, fwnode,
>  				mux_fwnode_match);
>  
> -- 
> 2.39.2
> 
