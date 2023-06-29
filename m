Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A033D741EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjF2DXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF2DXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:23:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E062713;
        Wed, 28 Jun 2023 20:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C34E61469;
        Thu, 29 Jun 2023 03:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51F4C433C0;
        Thu, 29 Jun 2023 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688009001;
        bh=jPUDoa5cZUOVLW9fXcJjrHQ4e1B4ZzR+5PdHRs1Dzio=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=VfRidV3ovcBlqprFPTQzhiyN6hq8PWpDbgXhFNU58toQVUOLqNeKHB40Vv+xw58Fd
         a+J2LRnQRj/3ES1P0xPw7VpB810jbOXajlgRxlDRw5Gy+QoO6dZi+spC7fBWJgliXM
         dW1YYR86KQgOPooV+VSkUU6NjdQJlDatxPYotyFrBZUrI6Em++lU9T8PjSL4QmKGk7
         WuuUWm5yq8+Zdtt8N/SqpChNEc1aZ47Q0IRpFnp751NmE0/hNxHv8QGk5lm3xuNWCK
         o+H10V2l51UJjUtHiL2Xwd/HcQX7IBEkoEn8MG3ARygL/kC14ketAVNxfTOo5kY1qv
         9FrtNRY1nUpQg==
Message-ID: <42940cae-ce4f-577a-474b-f06b3b481e4e@kernel.org>
Date:   Thu, 29 Jun 2023 08:53:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] usb: gadget: call usb_gadget_check_config() to verify
 UDC capability
To:     Frank Li <Frank.Li@nxp.com>, r-gunasekaran@ti.com,
        imx@lists.linux.dev, jun.li@nxp.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230628222437.3188441-1-Frank.Li@nxp.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230628222437.3188441-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/2023 03:54, Frank Li wrote:
> The legacy gadget driver omitted calling usb_gadget_check_config()
> to ensure that the USB device controller (UDC) has adequate resources,
> including sufficient endpoint numbers and types, to support the given
> configuration.
> 
> Previously, usb_add_config() was solely invoked by the legacy gadget
> driver. Adds the necessary usb_gadget_check_config() after the bind()
> operation to fix the issue.

You have only fixed composite.c. Not all gadget drivers use composite.c
so it will be still broken for them.

Please also add default sane configuration in CDNS3 so it works even
if usb_gadget_check_config() is not invoked.

> 
> Fixes: dce49449e04f ("usb: cdns3: allocate TX FIFO size according to composite EP number")
> Reported-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/gadget/composite.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 1b3489149e5e..dd9b90481b4c 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1125,6 +1125,10 @@ int usb_add_config(struct usb_composite_dev *cdev,
>  		goto done;
>  
>  	status = bind(config);
> +
> +	if (status == 0)
> +		status = usb_gadget_check_config(cdev->gadget);
> +
>  	if (status < 0) {
>  		while (!list_empty(&config->functions)) {
>  			struct usb_function		*f;

-- 
cheers,
-roger
