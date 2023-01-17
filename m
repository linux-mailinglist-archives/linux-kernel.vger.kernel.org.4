Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5DE66DFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjAQOHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjAQOHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:07:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83F22DE9;
        Tue, 17 Jan 2023 06:07:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0F9FB8163C;
        Tue, 17 Jan 2023 14:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08E5C433D2;
        Tue, 17 Jan 2023 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673964430;
        bh=EFq8Od2NM75wtjBEcUE7fa3icuvaGh55hFO8nHbgdHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQD7+cWOMoYWQ6+xDnL8JUdVxTFI/skk8sgs2c66neOJBcc/GhgrLdhoW81e81Cuf
         NfqmDJ8Z6WvFSEitxfFuTchBq2eAWUbGmYfcMPrdyA86vzx0vWRhHSXXyXo+0HlIGw
         aLEnHwLjUZp+nHBOxMnspjS/cQeFVk+bQc+3T0bc=
Date:   Tue, 17 Jan 2023 15:07:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, eric.auger@redhat.com,
        alex.williamson@redhat.com, cohuck@redhat.com,
        song.bao.hua@hisilicon.com, mchehab+huawei@kernel.org,
        maz@kernel.org, f.fainelli@gmail.com, jeffrey.l.hugo@gmail.com,
        saravanak@google.com, Michael.Srba@seznam.cz, mani@kernel.org,
        yishaih@nvidia.com, jgg@ziepe.ca, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
        masahiroy@kernel.org, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        okaya@kernel.org, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, git@amd.com
Subject: Re: [PATCH 01/19] bus/cdx: add the cdx bus driver
Message-ID: <Y8arhmVo7LPLuxqr@kroah.com>
References: <20230117134139.1298-1-nipun.gupta@amd.com>
 <20230117134139.1298-2-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117134139.1298-2-nipun.gupta@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 07:11:33PM +0530, Nipun Gupta wrote:
> Introduce AMD CDX bus, which provides a mechanism for scanning
> and probing CDX devices. These devices are memory mapped on
> system bus for Application Processors(APUs).
> 
> CDX devices can be changed dynamically in the Fabric and CDX
> bus interacts with CDX controller to rescan the bus and
> rediscover the devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Signed-off-by: Tarak Reddy <tarak.reddy@amd.com>

First off, very nice job, I didn't find any obvious issues with this
integration into the driver core.

That being said, why do you want this in drivers/bus/?  Why not
drivers/cdx/ ?

One minor comment to make the code smaller:

> +static int get_free_index(void)
> +{
> +	unsigned long id_map;
> +	unsigned long mask;
> +	int index = 0;
> +
> +	mask  = (1UL << MAX_CDX_CONTROLLERS) - 1;
> +retry:
> +	id_map = cdx_controller_id_map[0];
> +	if ((id_map & mask) == mask)
> +		return -ENOSPC;
> +
> +	index = ffz(id_map);
> +	if (index >= MAX_CDX_CONTROLLERS)
> +		return -ENOSPC;
> +
> +	if (test_and_set_bit(index, &cdx_controller_id_map[0]))
> +		goto retry;
> +
> +	return index;
> +}

Why not just use the idr/ida structure instead?  That will handle all of
that logic for you and get rid of your bit twiddling.

> +/**
> + * struct cdx_dev_params - CDX device parameters
> + * @cdx: CDX controller associated with the device
> + * @parent: Associated CDX controller
> + * @vendor: Vendor ID for CDX device
> + * @device: Device ID for CDX device
> + * @bus_num: Bus number for this CDX device
> + * @dev_num: Device number for this device
> + * @res: array of MMIO region entries
> + * @res_count: number of valid MMIO regions
> + * @req_id: Requestor ID associated with CDX device
> + */
> +struct cdx_dev_params {
> +	struct cdx_controller *cdx;
> +	u16 vendor;
> +	u16 device;

Are these in little endian format in memory?  Or native?  Or something
else?

thanks,

greg k-h
