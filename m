Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACE65597A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 09:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiLXIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 03:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXIyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 03:54:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A462D126;
        Sat, 24 Dec 2022 00:54:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 405C1B8219B;
        Sat, 24 Dec 2022 08:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79562C433D2;
        Sat, 24 Dec 2022 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671872088;
        bh=m3Ir70l8g/TXMb/IV1C5kk10eAYAEp+V9k7xKdezeGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQWqu7Gb6mhU/wDiU4LytDOURNWAMqtwN8md9fTezBNZ8s3NJfpnVvzG25oC2AQBa
         mUTLJMUQpHRZFrjrutDBg+lmU8PcRq1jqM639Tb1fxPUlr19o73tkMM1VNMjNs8tqA
         MpK8Xi23gbyhrOPX9UHjLfZeZj7KKVFgD3E6cjYg=
Date:   Sat, 24 Dec 2022 09:54:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [RFC PATCH 06/14] usb: core: hcd: Introduce USB HCD APIs for
 interrupter management
Message-ID: <Y6a+VJ75lRIUE9yD@kroah.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-7-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223233200.26089-7-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:31:52PM -0800, Wesley Cheng wrote:
> For USB HCDs that can support multiple USB interrupters, expose functions
> that class drivers can utilize for setting up secondary interrupters.
> Class drivers can pass this information to its respective clients, i.e.
> a dedicated DSP.

Where is the locking here that seems to be required when a hcd is
removed from the system and you have data in flight?  What am I missing
here in the design of this?

And yes, HCDs get removed all the time, and will happen more and more in
the future with the design of more systems moving to Thunderbolt/PCIe
designs due to the simplicity of it.

> +/**
> + * usb_set_interruper - Reserve an interrupter

Where is an "interrupter" defined?  I don't know what this term means
sorry, is this in the USB specification somewhere?


> + * @udev: usb device which requested the interrupter
> + * @intr_num: interrupter number to reserve
> + * @dma: iova address to event ring
> + *
> + * Request for a specific interrupter to be reserved for a USB class driver.
> + * This will return the base address to the event ring that was allocated to
> + * the specific interrupter.
> + **/
> +phys_addr_t usb_set_interruper(struct usb_device *udev, int intr_num,
> +							dma_addr_t *dma)
> +{
> +	struct usb_hcd *hcd;
> +	phys_addr_t pa = 0;
> +
> +	hcd = bus_to_hcd(udev->bus);
> +	if (hcd->driver->update_interrupter)
> +		pa = hcd->driver->update_interrupter(hcd, intr_num, dma);
> +
> +	return pa;

Wait, you return a physical address?  What are you going to do with
that?  And what guarantees that the address is valid after you return it
(again, remember memory and devices can be removed at any point in time.

thanks,

greg k-h
