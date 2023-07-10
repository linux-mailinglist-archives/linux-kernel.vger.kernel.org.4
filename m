Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4697F74CB70
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 06:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGJEzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 00:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGJEzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 00:55:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1CBC;
        Sun,  9 Jul 2023 21:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29E2360B90;
        Mon, 10 Jul 2023 04:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00A6C433C8;
        Mon, 10 Jul 2023 04:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688964900;
        bh=g12fHdC5Z9NetJn1/SOSlODorI2eeR3rvQfBoTMmrK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVObVL8em8J88QSGktQFdd0270c+Rhm2DmB5YmkAvhY+D14mH0DRAsMRIO7EjrOgp
         uUCoOyhTaSh5f4b9ESZ7AAuXahTKXko4Qn9AdhFqjSl0uuKKuA/wCYMCyYdRnrKnIS
         kjKEY5YHjyw88MQV1WBZ8jhKCAwSf4GewVJpYE87ukV4aWfsitLO0lY/v0zhrfS7JT
         2YnQTBHZf6cFWkALjIJdWG/+J6BYrS2laRo3pGLEPek9u5snkEQKxyyFg1NeorCYjj
         LYkeOPrAueAZYxjCyvkS9KjgFCyHCHXm3ropd8qVz1bQs4RjC95YyqGvlyjtV80V5p
         UtxtyJSR5Xmow==
Date:   Sun, 9 Jul 2023 21:58:35 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: altmodes/displayport: add support for
 embedded DP cases
Message-ID: <4uvqvjzd53mpgkyysu5c7lmil44i5s5imgung4pbmgay27a2rq@gaec42ewhqu2>
References: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
 <20230709201309.274306-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709201309.274306-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 11:13:08PM +0300, Dmitry Baryshkov wrote:
> In the embedded cases, the DisplayPort connector is handled by the TCPM
> itself. Fallback to the controller fwnode for HPD notifications to
> support such usecases without requiring additional DT properties.
> 

More specific, the proposal of adding the "displayport" reference to the
DeviceTree binding was rejected, in favour of properly describing the
electrical signal path using of_graph.

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/usb/typec/altmodes/displayport.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
> index 4e5aa17ce4c8..699438c7755e 100644
> --- a/drivers/usb/typec/altmodes/displayport.c
> +++ b/drivers/usb/typec/altmodes/displayport.c
> @@ -578,7 +578,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
>  	alt->ops = &dp_altmode_ops;
>  
>  	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
> -	dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
> +	if (fwnode_property_present(fwnode, "displayport"))
> +		dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
> +	else
> +		dp->connector_fwnode = fwnode_handle_get(fwnode); /* embedded DP */
>  	if (IS_ERR(dp->connector_fwnode))
>  		dp->connector_fwnode = NULL;
>  
> -- 
> 2.39.2
> 
