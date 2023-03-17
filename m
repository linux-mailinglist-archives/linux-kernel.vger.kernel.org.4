Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1863B6BE74D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCQKxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjCQKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:52:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA2FDCF76;
        Fri, 17 Mar 2023 03:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679050377; x=1710586377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iQ1t0ClL1aPi65qRW6K1FWVcELWBdYbryklmXMw4RzU=;
  b=KCxAr4Ls3zXlGQUuI2ehAx5pSO55xJQSXBEwK7FdOcDJzZeR3Z7QWN3n
   ieMvlU4KgUvuLDNOGQXYJr7dJ3A22KESxzFZS7mkTObDWbWLEXDtwpjzr
   IFf+UChT0MNISzTBdQyCnWNnoN9Sj+VfG1HoiCp9kRFj3yJi4VQIG9vLr
   lQxV7PTPDQ0bt2ishF7CgT1nEMukxiNUbwoOQ6FM9DiVIBW0IsJXtdtvT
   hhBaHtwJwNXeRzq25dA9xar901jYSoxIKgroHnDSlpMdXfgbrm3YNn60J
   K7hz4r3hp1yppm4sovG37vffFUBby2J8U4akyGu0KhODPeqGaYNoMv73X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="424506303"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="424506303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 03:52:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="823633759"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="823633759"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Mar 2023 03:52:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 17 Mar 2023 12:52:53 +0200
Date:   Fri, 17 Mar 2023 12:52:53 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-usb@vger.kernel.org,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] extcon: usbc-tusb320: add accessory detection support
Message-ID: <ZBRGhcAeoyxMRMEP@kuha.fi.intel.com>
References: <20230317104229.1392742-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317104229.1392742-1-alvin@pqrs.dk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:42:27AM +0100, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> The TUSB320 can detect the following types of accessory:
> 
>   - Audio Accessory
>   - Audio Accessory with charge-thru
>   - Debug Accessory (DFP)
>   - Debug Accessory (UFP)
> 
> Moreover, the typec subsystem can be informed of this through the
> typec_set_mode() function. The information will be propagated to any
> linked typec muxes. Add the necessary support to the driver.
> 
> Note that for the Debug Accessory modes, an educated guess was made that
> for the USB data role, DFP implies HOST and UFP implies DEVICE. But this
> might want to be made configurable at a later date.
> 
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
> v2: no change

Not a big problem, but you forgot to include the version in the
subject. In any case, FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/extcon/extcon-usbc-tusb320.c | 90 +++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> index 10dff1c512c4..882d1f48495e 100644
> --- a/drivers/extcon/extcon-usbc-tusb320.c
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  #include <linux/usb/typec.h>
> +#include <linux/usb/typec_altmode.h>
>  
>  #define TUSB320_REG8				0x8
>  #define TUSB320_REG8_CURRENT_MODE_ADVERTISE	GENMASK(7, 6)
> @@ -26,16 +27,16 @@
>  #define TUSB320_REG8_CURRENT_MODE_DETECT_MED	0x1
>  #define TUSB320_REG8_CURRENT_MODE_DETECT_ACC	0x2
>  #define TUSB320_REG8_CURRENT_MODE_DETECT_HI	0x3
> -#define TUSB320_REG8_ACCESSORY_CONNECTED	GENMASK(3, 2)
> +#define TUSB320_REG8_ACCESSORY_CONNECTED	GENMASK(3, 1)
>  #define TUSB320_REG8_ACCESSORY_CONNECTED_NONE	0x0
>  #define TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO	0x4
> -#define TUSB320_REG8_ACCESSORY_CONNECTED_ACC	0x5
> -#define TUSB320_REG8_ACCESSORY_CONNECTED_DEBUG	0x6
> +#define TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG	0x5
> +#define TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP	0x6
> +#define TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP	0x7
>  #define TUSB320_REG8_ACTIVE_CABLE_DETECTION	BIT(0)
>  
>  #define TUSB320_REG9				0x9
> -#define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
> -#define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
> +#define TUSB320_REG9_ATTACHED_STATE		GENMASK(7, 6)
>  #define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
>  #define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
>  
> @@ -250,8 +251,7 @@ static void tusb320_extcon_irq_handler(struct tusb320_priv *priv, u8 reg)
>  {
>  	int state, polarity;
>  
> -	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> -		TUSB320_REG9_ATTACHED_STATE_MASK;
> +	state = FIELD_GET(TUSB320_REG9_ATTACHED_STATE, reg);
>  	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
>  
>  	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
> @@ -277,32 +277,78 @@ static void tusb320_typec_irq_handler(struct tusb320_priv *priv, u8 reg9)
>  {
>  	struct typec_port *port = priv->port;
>  	struct device *dev = priv->dev;
> -	u8 mode, role, state;
> +	int typec_mode;
> +	enum typec_role pwr_role;
> +	enum typec_data_role data_role;
> +	u8 state, mode, accessory;
>  	int ret, reg8;
>  	bool ori;
>  
> +	ret = regmap_read(priv->regmap, TUSB320_REG8, &reg8);
> +	if (ret) {
> +		dev_err(dev, "error during reg8 i2c read, ret=%d!\n", ret);
> +		return;
> +	}
> +
>  	ori = reg9 & TUSB320_REG9_CABLE_DIRECTION;
>  	typec_set_orientation(port, ori ? TYPEC_ORIENTATION_REVERSE :
>  					  TYPEC_ORIENTATION_NORMAL);
>  
> -	state = (reg9 >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> -		TUSB320_REG9_ATTACHED_STATE_MASK;
> -	if (state == TUSB320_ATTACHED_STATE_DFP)
> -		role = TYPEC_SOURCE;
> -	else
> -		role = TYPEC_SINK;
> +	state = FIELD_GET(TUSB320_REG9_ATTACHED_STATE, reg9);
> +	accessory = FIELD_GET(TUSB320_REG8_ACCESSORY_CONNECTED, reg8);
> +
> +	switch (state) {
> +	case TUSB320_ATTACHED_STATE_DFP:
> +		typec_mode = TYPEC_MODE_USB2;
> +		pwr_role = TYPEC_SOURCE;
> +		data_role = TYPEC_HOST;
> +		break;
> +	case TUSB320_ATTACHED_STATE_UFP:
> +		typec_mode = TYPEC_MODE_USB2;
> +		pwr_role = TYPEC_SINK;
> +		data_role = TYPEC_DEVICE;
> +		break;
> +	case TUSB320_ATTACHED_STATE_ACC:
> +		/*
> +		 * Accessory detected. For debug accessories, just make some
> +		 * qualified guesses as to the role for lack of a better option.
> +		 */
> +		if (accessory == TUSB320_REG8_ACCESSORY_CONNECTED_AUDIO ||
> +		    accessory == TUSB320_REG8_ACCESSORY_CONNECTED_ACHRG) {
> +			typec_mode = TYPEC_MODE_AUDIO;
> +			pwr_role = TYPEC_SINK;
> +			data_role = TYPEC_DEVICE;
> +			break;
> +		} else if (accessory ==
> +			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGDFP) {
> +			typec_mode = TYPEC_MODE_DEBUG;
> +			pwr_role = TYPEC_SOURCE;
> +			data_role = TYPEC_HOST;
> +			break;
> +		} else if (accessory ==
> +			   TUSB320_REG8_ACCESSORY_CONNECTED_DBGUFP) {
> +			typec_mode = TYPEC_MODE_DEBUG;
> +			pwr_role = TYPEC_SINK;
> +			data_role = TYPEC_DEVICE;
> +			break;
> +		}
>  
> -	typec_set_vconn_role(port, role);
> -	typec_set_pwr_role(port, role);
> -	typec_set_data_role(port, role == TYPEC_SOURCE ?
> -				  TYPEC_HOST : TYPEC_DEVICE);
> +		dev_warn(priv->dev, "unexpected ACCESSORY_CONNECTED state %d\n",
> +			 accessory);
>  
> -	ret = regmap_read(priv->regmap, TUSB320_REG8, &reg8);
> -	if (ret) {
> -		dev_err(dev, "error during reg8 i2c read, ret=%d!\n", ret);
> -		return;
> +		fallthrough;
> +	default:
> +		typec_mode = TYPEC_MODE_USB2;
> +		pwr_role = TYPEC_SINK;
> +		data_role = TYPEC_DEVICE;
> +		break;
>  	}
>  
> +	typec_set_vconn_role(port, pwr_role);
> +	typec_set_pwr_role(port, pwr_role);
> +	typec_set_data_role(port, data_role);
> +	typec_set_mode(port, typec_mode);
> +
>  	mode = FIELD_GET(TUSB320_REG8_CURRENT_MODE_DETECT, reg8);
>  	if (mode == TUSB320_REG8_CURRENT_MODE_DETECT_DEF)
>  		typec_set_pwr_opmode(port, TYPEC_PWR_MODE_USB);
> -- 
> 2.39.2

-- 
heikki
