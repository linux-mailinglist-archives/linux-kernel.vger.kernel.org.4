Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6EE6BE7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCQLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:13:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADFF4C6E4;
        Fri, 17 Mar 2023 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679051635; x=1710587635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bCdtaLDeSSqAH0BuW0GZz8uVHOYgQbEAfJfRQ/dNRe0=;
  b=fZOZMjVmS9B/yG5iFEwV7efxQSg7XPwF6BD24EjtCQyMQpwEuqBSx/C6
   wIDSP6xWU+5l8amJqUxwCcJHPCEA4BeIcZNhUHkwq1YEvktfjFGaPHBks
   5PbvuKin+ITvvWafQWX1VJvBMIAStvl0ur2v14rNpLvDHRRib9M0H90rT
   hCXqXrgJewuobyxY/6XnzwmGuW4+NQJO2ylCNSRy6opD02xUwwyPSYv5V
   UN2edih57k0xDrXiGFZ9yF/ZKYtXMwmT1w5ga+fzZ2vhD0E3KuubXgFOb
   3iPyS09/gzXbQVkTQ/UYjB9Nch4XHiqIcd+JbkgbLjroTH9xFnzho1Ah5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424509520"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424509520"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 04:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823637159"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823637159"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2023 04:13:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 Mar 2023 13:13:51 +0200
Date:   Fri, 17 Mar 2023 13:13:51 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] extcon: usbc-tusb320: add usb_role_switch support
Message-ID: <ZBRLb4MCJI47moId@kuha.fi.intel.com>
References: <20230317104229.1392742-1-alvin@pqrs.dk>
 <20230317104229.1392742-2-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317104229.1392742-2-alvin@pqrs.dk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:42:28AM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The connector child node of the TUSB320 device might be linked with a
> USB OTG controller with USB role switch capability. Add driver support
> for detecting a usb_role_switch and setting its state in the typec
> interrupt handler. This follows similar practice in other drivers in the
> typec subsystem, which this extcon driver can opt-in to.

I'm sorry to be a bit picky here, but I must ask that you don't use
the term USB OTG. It is too confusing - OTG may refer to USB device
controller, USB host controller, or dual-role capable USB controller,
depending on the case, so we need to be specific.

The OTG spec itself is in any case obsolete - USB Type-C and USB PD
specs define their own way of handling the roles, and they are not
compatible with the USB OTG specification(s).

thanks,

> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
> v2: remove unused variable as reported by kernel test robot
> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 882d1f48495e..cc2d0ac7c5f6 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -16,6 +16,7 @@
>  #include <linux/regmap.h>
>  #include <linux/usb/typec.h>
>  #include <linux/usb/typec_altmode.h>
> +#include <linux/usb/role.h>
>  
>  #define TUSB320_REG8				0x8
>  #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
> @@ -80,6 +81,7 @@ struct tusb320_priv {
>  	enum typec_port_type port_type;
>  	enum typec_pwr_opmode pwr_opmode;
>  	struct fwnode_handle *connector_fwnode;
> +	struct usb_role_switch *role_sw;
>  };
>  
>  static const char * const tusb_attached_states[] = {
> @@ -278,6 +280,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  	struct typec_port *port = priv->port;
>  	struct device *dev = priv->dev;
>  	int typec_mode;
> +	enum usb_role usb_role;
>  	enum typec_role pwr_role;
>  	enum typec_data_role data_role;
>  	u8 state, mode, accessory;
> @@ -300,11 +303,13 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  	switch (state) {
>  	case TUSB320_ATTACHED_STATE_DFP:
>  		typec_mode = TYPEC_MODE_USB2;
> +		usb_role = USB_ROLE_HOST;
>  		pwr_role = TYPEC_SOURCE;
>  		data_role = TYPEC_HOST;
>  		break;
>  	case TUSB320_ATTACHED_STATE_UFP:
>  		typec_mode = TYPEC_MODE_USB2;
> +		usb_role = USB_ROLE_DEVICE;
>  		pwr_role = TYPEC_SINK;
>  		data_role = TYPEC_DEVICE;
>  		break;
> @@ -316,6 +321,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  		if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
>  		    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
>  			typec_mode = TYPEC_MODE_AUDIO;
> +			usb_role = USB_ROLE_NONE;
>  			pwr_role = TYPEC_SINK;
>  			data_role = TYPEC_DEVICE;
>  			break;
> @@ -323,12 +329,14 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP) {
>  			typec_mode = TYPEC_MODE_DEBUG;
>  			pwr_role = TYPEC_SOURCE;
> +			usb_role = USB_ROLE_HOST;
>  			data_role = TYPEC_HOST;
>  			break;
>  		} else if (accessory ==
>  			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP) {
>  			typec_mode = TYPEC_MODE_DEBUG;
>  			pwr_role = TYPEC_SINK;
> +			usb_role = USB_ROLE_DEVICE;
>  			data_role = TYPEC_DEVICE;
>  			break;
>  		}
> @@ -339,6 +347,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  		fallthrough;
>  	default:
>  		typec_mode = TYPEC_MODE_USB2;
> +		usb_role = USB_ROLE_NONE;
>  		pwr_role = TYPEC_SINK;
>  		data_role = TYPEC_DEVICE;
>  		break;
> @@ -348,6 +357,7 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  	typec_set_pwr_role(port, pwr_role);
>  	typec_set_data_role(port, data_role);
>  	typec_set_mode(port, typec_mode);
> +	usb_role_switch_set_role(priv->role_sw, usb_role);
>  
>  	mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
>  	if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
> @@ -472,10 +482,20 @@ static int tusb320_typec_probe(struct i2c_client *client,
>  		goto err_put;
>  	}
>  
> +	/* Find any optional USB role switch that needs reporting to */
> +	priv->role_sw = fwnode_usb_role_switch_get(connector);
> +	if (IS_ERR(priv->role_sw)) {
> +		ret = PTR_ERR(priv->role_sw);
> +		goto err_unreg;
> +	}
> +
>  	priv->connector_fwnode = connector;
>  
>  	return 0;
>  
> +err_unreg:
> +	typec_unregister_port(priv->port);
> +
>  err_put:
>  	fwnode_handle_put(connector);
>  
> @@ -484,6 +504,7 @@ static int tusb320_typec_probe(struct i2c_client *client,
>  
>  static void tusb320_typec_remove(struct tusb320_priv *priv)
>  {
> +	usb_role_switch_put(priv->role_sw);
>  	typec_unregister_port(priv->port);
>  	fwnode_handle_put(priv->connector_fwnode);
>  }
> -- 
> 2.39.2

-- 
heikki
