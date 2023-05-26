Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3A7712190
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbjEZHzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbjEZHyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:54:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF812C;
        Fri, 26 May 2023 00:54:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B3F064DBE;
        Fri, 26 May 2023 07:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51903C433D2;
        Fri, 26 May 2023 07:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685087692;
        bh=r/fk7ywn0jZ7exIpVJ5GqN+idYj8JSycLJBNBKkY+To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSvxXar/RZIH1FoOJc/s0k6Qa+gNIwPaH8Ex5okX01QXiK6uVMuX8Om/62If8fUAE
         ovlZKw6ujgSzuGfOdXj/7WsXOoX9EExtizR1AKOpG6kBpTvsQ+AQm0Z3wxxgwYrFhG
         J0wBcoH9smDqA4hgRo3ygx/Gr5APCGW+Friptd4yEC3ELF3HHeClvYMs4GuUIsq8PR
         9+rnI6UYkYfFviUuHSlezdK+URIy3tkQN3tTkF1d3Fy821oq7EGlmN06NxPajy3/AM
         91riAScRnESGK++T/t9HJRiNIvz5tottLQD0IaFrgSrmchDo4x/VwzJ5XSua4hMkCO
         J8RYE48HQ3a7Q==
Date:   Fri, 26 May 2023 08:54:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Fred Treven <fred.treven@cirrus.com>
Cc:     Ben Bright <ben.bright@cirrus.com>,
        James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] mfd: cs40l26: Add CODEC driver component
Message-ID: <20230526075447.GA449117@google.com>
References: <1685059471-9598-1-git-send-email-fred.treven@cirrus.com>
 <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1685059471-9598-5-git-send-email-fred.treven@cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023, Fred Treven wrote:

> Use MFD interface to load the CODEC driver along
> with the Input FF driver.
> 
> Signed-off-by: Fred Treven <fred.treven@cirrus.com>
> ---
>  drivers/input/misc/cs40l26.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/input/misc/cs40l26.c b/drivers/input/misc/cs40l26.c
> index 12c29cbd4ff0..35d15a6c2230 100644
> --- a/drivers/input/misc/cs40l26.c
> +++ b/drivers/input/misc/cs40l26.c
> @@ -13,6 +13,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/core.h>

NACK.  Please do not use the MFD API outside of drivers/mfd.

>  #include <linux/pm_runtime.h>
>  #include <linux/string.h>
>  #include <linux/firmware/cirrus/wmfw.h>
> @@ -2136,6 +2137,10 @@ static inline int cs40l26_worker_init(struct cs40l26_private *cs40l26)
>  	return 0;
>  }
>  
> +static const struct mfd_cell cs40l26_devs[] = {
> +	{ .name = "cs40l26-codec" },

This is one device.  Thus, not an MFD anyway.

> +};
> +
>  static struct regulator_bulk_data cs40l26_supplies[] = {
>  	{ .supply = "VP" },
>  	{ .supply = "VA" },
> @@ -2275,6 +2280,12 @@ int cs40l26_probe(struct cs40l26_private *cs40l26)
>  	if (error)
>  		goto err;
>  
> +	error = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cs40l26_devs, 1, NULL, 0, NULL);
> +	if (error) {
> +		dev_err(dev, "Failed to MFD add device %s: %d\n", cs40l26_devs[0].name, error);
> +		goto err;
> +	}
> +
>  	return 0;
>  err:
>  	cs40l26_remove(cs40l26);
> -- 
> 2.7.4
> 

-- 
Lee Jones [李琼斯]
