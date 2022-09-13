Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4A5B6DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiIMMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiIMMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:54:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692F1013;
        Tue, 13 Sep 2022 05:54:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E71A3B80E5F;
        Tue, 13 Sep 2022 12:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BCBC433D7;
        Tue, 13 Sep 2022 12:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663073668;
        bh=yQ+lxkhWQ3O13lv29imS0rBCv/cWaWpZtYwrmgREPik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CI6xcvd2RYz1KrSO5Z0cJX0HeUtZaeZL16Ro0aZCTsJh1oJHzeLdpZkD6xWdgvxzS
         2mdDhaIvTPGU/aGUQ3kEfZEd1N4CRXzHUrk9vSjbCNfgiFzQ4WJvT+cTUWGuzYtWpY
         Rffe1VDYTO0rS6IgI4S1iW3sSeDaDA9OzupZGJq2oUZHT0DYOT3O0StfKq3kxeNO5G
         zDXzRrlagLb/y+IVpTc2lFxMVJZp9AtmmjiFeMXcWj7x3xZywN0sFAwUyS4act9I/u
         lV882oI0rtpPShJ/EPn19qGFt8lyKBlhuzIVjTuAQ59z3msFPjyWRFjFrrFjC/OqkE
         Hdvhrp1rV17Xw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY5Qp-0003cd-DW; Tue, 13 Sep 2022 14:54:28 +0200
Date:   Tue, 13 Sep 2022 14:54:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: ftdi_sio: Convert to use dev_groups
Message-ID: <YyB9g2xKIvUsv+vL@hovoldconsulting.com>
References: <20220905095120.343807-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905095120.343807-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 05:51:20PM +0800, Jiasheng Jiang wrote:
> The driver core supports the ability to handle the creation and removal
> of device-specific sysfs files in a race-free manner. Moreover, it can
> guarantee the success of creation. Therefore, it should be better to
> move the code and convert to use dev_groups.
> 
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v3 -> v4:
> 
> 1. Move the code and remove the pre-definitions.

I don't know exactly you were told to do here, but do not reorganise the
entire driver just to add an attribute group. It not only makes the
patch harder to review but also messes up the git history (e.g.
git-blame) for no good reason.

> +static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
> +					 struct attribute *attr, int idx)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct usb_serial_port *port = container_of(dev, struct usb_serial_port, dev);
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	umode_t mode = attr->mode;
> +
> +	if (attr == &dev_attr_latency_timer.attr) {
> +		if (priv->chip_type == FT232BM ||
> +		    priv->chip_type == FT2232C ||
> +		    priv->chip_type == FT232RL ||
> +		    priv->chip_type == FT2232H ||
> +		    priv->chip_type == FT4232H ||
> +		    priv->chip_type == FT232H ||
> +		    priv->chip_type == FTX) {
> +			return mode;
> +		}
> +	}
> +	return 0;
> +}

This isn't equivalent with the current implementation, which used
different visibility per attribute.

> +static struct attribute *ftdi_sio_attrs[] = {
> +	&dev_attr_event_char.attr,
> +	&dev_attr_latency_timer.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ftdi_sio_group = {
> +	.attrs = ftdi_sio_attrs,
> +	.is_visible = ftdi_sio_attr_is_visible,
> +};
> +
> +static const struct attribute_group *ftdi_sio_groups[] = {
> +	&ftdi_sio_group,
> +	NULL
> +};
> +
>  static struct usb_serial_driver ftdi_sio_device = {
>  	.driver = {
>  		.owner =	THIS_MODULE,
>  		.name =		"ftdi_sio",
> +		.dev_groups =	ftdi_sio_groups,

And you should only need a forward declaration for ftdi_sio_groups for
this.

>  	},
>  	.description =		"FTDI USB Serial Device",
>  	.id_table =		id_table_combined,
> @@ -1144,9 +1279,6 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  };

Johan
