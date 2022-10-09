Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0065F8D23
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiJISZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiJISZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 14:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721331AF04
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D4A760C48
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 18:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F0BC433C1;
        Sun,  9 Oct 2022 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665339922;
        bh=44P2OdzGEAkcFTDiVXHU8vL2N2Ja+R4/GPK9EB4aAZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wmcW+bWGnqPrsuKw6aLReO474F90QEDF96Rmp4RSbqp/p97lXU7mHUSutb+Dpvx9P
         Og1RUPOhIfd8SAty/Xm/rtSGr9w8z4wN7+ZR+0YeOE35azQ4rPxdOT1cLaLK5aIO3Z
         C9geqGi/+qDzruq+okTh2BPfZSzKNsXieHRRHhjc=
Date:   Sun, 9 Oct 2022 20:26:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] device property: add fwnode_is_compatible() for
 compatible match
Message-ID: <Y0MSPaZlhW6iOYEV@kroah.com>
References: <20221009162155.1318-1-soha@lohu.info>
 <20221009162155.1318-4-soha@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009162155.1318-4-soha@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:21:55AM +0800, Soha Jin wrote:
> fwnode_is_compatible is a shortcut to check if a device is compatible with
> a compat string in fwnode property "compatible". This function is similar
> to of_device_is_compatible.
> 
> Signed-off-by: Soha Jin <soha@lohu.info>
> ---
>  include/linux/property.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index dbe747f3e3be..776e4a8bc379 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -252,6 +252,13 @@ fwnode_property_string_array_count(const struct fwnode_handle *fwnode,
>  	return fwnode_property_read_string_array(fwnode, propname, NULL, 0);
>  }
>  
> +static inline bool fwnode_is_compatible(const struct fwnode_handle *fwnode,
> +					const char *compat)
> +{
> +	return fwnode_property_match_string_nocase(fwnode, "compatible",
> +						   compat) >= 0;

Who would mistype "compatible" in a case insensitive way?

Why can't you fix the firmware to be correct instead of forcing the
operating system to fix it for them?

thanks,

greg k-h
