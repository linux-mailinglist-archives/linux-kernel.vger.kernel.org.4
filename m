Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A27738A77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjFUQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjFUQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5818419B;
        Wed, 21 Jun 2023 09:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E15FA615D8;
        Wed, 21 Jun 2023 16:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B970CC433C8;
        Wed, 21 Jun 2023 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687363661;
        bh=kHkwj8+VKWeZek1KqV5byWtG03YfCvl+MT6bpPneKUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z/FRk07HtpZIEXt8FOhzXDe3nRItPMQhFw9qo9ausXJJSDFyQo3J0sRFgNhop0hj6
         /8gMKeUnz3VtiBYM3dpLeSuiFg3Z4Ya1/ukjfOzqSpRhbiNyUm1LDkCfvyEHZaUBNd
         1j3HFDw8S8hw3kjtC/474Zqu4lFWQL7BYUw1ST4U=
Date:   Wed, 21 Jun 2023 18:06:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: misc: onboard-hub: support multiple power
 supplies
Message-ID: <2023062102-booth-glorify-2b09@gregkh>
References: <20230620-hx3-v3-0-2acbc03ca949@skidata.com>
 <20230620-hx3-v3-1-2acbc03ca949@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620-hx3-v3-1-2acbc03ca949@skidata.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 05:58:30PM +0200, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> As some of the onboard hubs require multiple power supplies, provide the
> environment to support them.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> v3:
> - fix nits mentioned in v2
> 
> v2:
> - replace (err != 0) with (err)
> ---
>  drivers/usb/misc/onboard_usb_hub.c | 39 ++++++++++++++++++++++++++++++--------
>  drivers/usb/misc/onboard_usb_hub.h |  1 +
>  2 files changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> index 12fc6eb67c3b..a56e712d3a45 100644
> --- a/drivers/usb/misc/onboard_usb_hub.c
> +++ b/drivers/usb/misc/onboard_usb_hub.c
> @@ -27,6 +27,13 @@
>  
>  #include "onboard_usb_hub.h"
>  
> +#define MAX_SUPPLIES 2

Why 2?

> +
> +static const char * const supply_names[] = {
> +	"vdd",
> +	"vdd2",
> +};

Do those names have anything to do with the number above?  If so, please
document it!

>  struct onboard_hub_pdata {
>  	unsigned long reset_us;		/* reset pulse width in us */
> +	unsigned int num_supplies;	/* number of supplies: 0 considered as 1 */

I can not understand that comment at all :(

