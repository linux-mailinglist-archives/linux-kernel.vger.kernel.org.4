Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A18F6F3201
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjEAOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAOeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A23134;
        Mon,  1 May 2023 07:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 727EC60DF8;
        Mon,  1 May 2023 14:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EB4C433EF;
        Mon,  1 May 2023 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682951674;
        bh=xUGCecrX3Z5CPY2qKnp0m27endo6ZPDmDr7ybUXGBQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NAGYdWxw4LIhOTGOA62hRR4aRcvWfwBFKad072qWnoBraTZ4uqdmhIL4/01/3IsaU
         WAjgNgXLsJQVwZlg5o+A53T1x0EHXgzecivTW38B5r+byMbXmIeXGXXRpyIWnO/pPe
         meGFW2j/+wqRdyXi8e7lWpIx4eSr+Y4yxmAwdBhfcrTVLFyMve5o9LRXSTkbzNe7Vp
         KJZz3tdwhrOLFSxc7Z7gdagEUWeybTDz1aNIpLxRGA4VJATSgAbalheMxF4emcoUNd
         niNIj3nIwPqEtLGiPYL06nDUXPU1x6OXWAHH/wrpiVq2+sEcryWDh3Hj4jPpQRUXhp
         cJlHPEn5lzIpA==
Date:   Mon, 1 May 2023 15:50:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iio: accel: kionix-kx022a: Refactor driver and
 add chip_info structure
Message-ID: <20230501155019.031ff86e@jic23-huawei>
In-Reply-To: <64728e90-48a7-43d0-b3d3-bfceb94884d7@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <bf0269aff66483f2323914170707203749b33f0f.1682373451.git.mehdi.djait.k@gmail.com>
        <867ac7b4-b666-854f-69f7-2d7d7d92c94e@gmail.com>
        <ZEeAGN3TBcao3CNA@carbian>
        <c0958e31-b477-34e0-d824-b017efadd0df@gmail.com>
        <ZE0Unz0lxMWY4pRf@carbian>
        <64728e90-48a7-43d0-b3d3-bfceb94884d7@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Apr 2023 16:56:38 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 4/29/23 15:59, Mehdi Djait wrote:
> > Hi Matti,
> > 
> > On Tue, Apr 25, 2023 at 11:12:11AM +0300, Matti Vaittinen wrote:  
> >> On 4/25/23 10:24, Mehdi Djait wrote:  
> >>> Hi Matti,
> >>>
> >>> On Tue, Apr 25, 2023 at 09:50:11AM +0300, Matti Vaittinen wrote:  
> >>>> On 4/25/23 01:22, Mehdi Djait wrote:  
> >>>>> Add the chip_info structure to the driver's private data to hold all
> >>>>> the device specific infos.
> >>>>> Refactor the kx022a driver implementation to make it more generic and
> >>>>> extensible.
> >>>>>
> >>>>> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
> >>>>> ---
> >>>>> v3:
> >>>>> - added the change of the buffer's allocation in the __kx022a_fifo_flush
> >>>>>      to this patch
> >>>>> - added the chip_info to the struct kx022a_data
> >>>>>
> >>>>> v2:
> >>>>> - mentioned the introduction of the i2c_device_id table in the commit
> >>>>> - get i2c_/spi_get_device_id only when device get match fails
> >>>>> - removed the generic KX_define
> >>>>> - removed the kx022a_device_type enum
> >>>>> - added comments for the chip_info struct elements
> >>>>> - fixed errors pointed out by the kernel test robot
> >>>>>
> >>>>>     drivers/iio/accel/kionix-kx022a-i2c.c |  15 +++-
> >>>>>     drivers/iio/accel/kionix-kx022a-spi.c |  15 +++-
> >>>>>     drivers/iio/accel/kionix-kx022a.c     | 114 +++++++++++++++++---------
> >>>>>     drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++-
> >>>>>     4 files changed, 147 insertions(+), 51 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
> >>>>> index 8f23631a1fd3..ce299d0446f7 100644
> >>>>> --- a/drivers/iio/accel/kionix-kx022a-i2c.c
> >>>>> +++ b/drivers/iio/accel/kionix-kx022a-i2c.c
> >>>>> @@ -15,6 +15,7 @@  
> >>>>
> >>>> ...
> >>>>
> >>>>  
> >>>>>     static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >>>>> @@ -600,13 +600,17 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
> >>>>>     {
> >>>>>     	struct kx022a_data *data = iio_priv(idev);
> >>>>>     	struct device *dev = regmap_get_device(data->regmap);
> >>>>> -	__le16 buffer[KX022A_FIFO_LENGTH * 3];
> >>>>> +	__le16 *buffer;
> >>>>>     	uint64_t sample_period;
> >>>>>     	int count, fifo_bytes;
> >>>>>     	bool renable = false;
> >>>>>     	int64_t tstamp;
> >>>>>     	int ret, i;
> >>>>> +	buffer = kmalloc(data->chip_info->fifo_length * KX022A_FIFO_SAMPLES_SIZE_BYTES, GFP_KERNEL);
> >>>>> +	if (!buffer)
> >>>>> +		return -ENOMEM;  
> >>>>
> >>>> Do you think we could get rid of allocating and freeing the buffer for each
> >>>> flush? I feel it is a bit wasteful, and with high sampling frequencies this
> >>>> function can be called quite often. Do you think there would be a way to
> >>>> either use stack (always reserve big enough buffer no matter which chip we
> >>>> have - or is the buffer too big to be safely taken from the stack?), or a
> >>>> buffer stored in private data and allocated at probe or buffer enable?  
> >>>
> >>> I tried using the same allocation as before but a device like the KX127
> >>> has a fifo_length of 342 (compared to 86 for kx132, and 43 for kx022a).
> >>> Allocating this much using the stack will result in a Warning.
> >>>  
> >>
> >> Right. Maybe you could then have the buffer in private-data and allocate it
> >> in buffer pre-enable? Do you think that would work?  
> > 
> > Do you mean add a new function kx022a_buffer_preenable to iio_buffer_setup_ops ?  
> 
> Sorry. I thought the kx022a already implemented the pre-enable callback 
> but it was the postenable. I was mistaken.

Separation between what should be done in preenable and postenable has been
vague for a long time. These days only really matters if you need to
order them wrt updating the scan mode I think.

> 
> > Would adding the allocation to kx022a_fifo_enable and the free to
> > kx022a_fifo_disable be a good option also ?  
> Yes. I think that should work!

Agreed that these allocations should be taken out of this hot path.
Either of these options should work so up to you.

> 
> Yours,
> 	-- Matti
> 
> 

