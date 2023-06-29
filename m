Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCF741F91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjF2FME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjF2FLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:11:49 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B626BB;
        Wed, 28 Jun 2023 22:11:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35T5BNYA035959;
        Thu, 29 Jun 2023 00:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688015483;
        bh=0Dc3Q6uzWDWdGY+a/wqboxsnIZAW1oc5tTp4JWmnnIU=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=xyib6HPCgAfk7Ch/fShnT/sU9+unxhiv0DE4YDU6EM670PkyTmOjNOC/nsXZrf3PA
         q0KbqtZAGWuKzikOl/7AJ+kXkCsNqzebyZcv4t0wqonXXKkLPmSI7SQPR1T1/rimTC
         lYG90FH7bdxVMJ/Hxe3aFwq5ohIxeKsY6a95bfTY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35T5BN5q021469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Jun 2023 00:11:23 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Jun 2023 00:11:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Jun 2023 00:11:23 -0500
Received: from [10.24.69.79] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35T5BJHL058488;
        Thu, 29 Jun 2023 00:11:19 -0500
Message-ID: <0da8f837-de99-0673-4af1-06efe4ce0a99@ti.com>
Date:   Thu, 29 Jun 2023 10:41:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] usb: gadget: call usb_gadget_check_config() to verify
 UDC capability
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, <rogerq@kernel.org>,
        <imx@lists.linux.dev>, <jun.li@nxp.com>,
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
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20230628222437.3188441-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 3:54 AM, Frank Li wrote:
> The legacy gadget driver omitted calling usb_gadget_check_config()
> to ensure that the USB device controller (UDC) has adequate resources,
> including sufficient endpoint numbers and types, to support the given
> configuration.
> 
> Previously, usb_add_config() was solely invoked by the legacy gadget
> driver. Adds the necessary usb_gadget_check_config() after the bind()
> operation to fix the issue.
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

This will work for legacy gadgets that support only one configurations.
Take for example g_ether. It has two configurations when RNDIS is enabled.
And usb_add_config() is invoked for each configuration. 

cdns3_gadget_check_config() calculates the total IN end-points based on the
ep->claimed flag. 

        list_for_each_entry(ep, &gadget->ep_list, ep_list) {                
                if (ep->claimed && (ep->address & USB_DIR_IN))              
                        n_in++;                                             
        }  

This ep->claimed flag is later cleared by usb_ep_autoconfig_reset() which is
invoked in usb_add_config(). So for multi-configurations, actual total in end points
is not taken into consideration thus resulting in incorrect fifo size allocation/check.

g_ffs is another gadget which has multiple configurations.


> +
>  	if (status < 0) {
>  		while (!list_empty(&config->functions)) {
>  			struct usb_function		*f;

-- 
Regards,
Ravi
