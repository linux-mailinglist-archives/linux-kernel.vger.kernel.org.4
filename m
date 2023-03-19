Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9B6C0298
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCSPHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCSPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 11:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE91B567;
        Sun, 19 Mar 2023 08:07:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DFAF61024;
        Sun, 19 Mar 2023 15:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F5DC433EF;
        Sun, 19 Mar 2023 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679238450;
        bh=+Ua4oAyAvYWiCkH03swFQ8O+jZwZiF2kyOP2DApe9A8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GRuksVUP1IqIB4Y/zWADLhGPxeC/5k6MRyK8viYfGbIg/8JquilsSuIFf68V0qRkU
         8RRPDv70iZ+iINM6Rad2EwIg4Hg8LBCmKFQt56kA5Rus0UBBtOih76xcPIpw52CVSX
         dQCY4ifKMUReWYlFICtDxSXh01AItW9HGFPGPKJMAdiRZ94xgrgv/qLFKNOUT7SsaS
         HsPmsrI9L6f0pUgYNVvN4t5Q+MX1vATBG+1Zu2LO1XqHmFWweQp0j2oehB2YVnpFos
         0JQs4a7l2vvHGZI9B/HSCWendDx4oCUQU+zldym6L+BrJ2npTwf4UEIIjYBn3+M/4V
         l29g+cOmCIH9g==
Date:   Sun, 19 Mar 2023 15:22:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Zheng Wang <zyytlz.wz@163.com>, eugen.hristev@collabora.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
Message-ID: <20230319152222.0b02fb51@jic23-huawei>
In-Reply-To: <d62ece80-4d88-36a6-9561-fa0f5afc40c1@metafoo.de>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
        <20230318173913.19e8a1b1@jic23-huawei>
        <d62ece80-4d88-36a6-9561-fa0f5afc40c1@metafoo.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2023 10:36:04 -0700
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 3/18/23 10:39, Jonathan Cameron wrote:
> > On Fri, 10 Mar 2023 17:12:39 +0800
> > Zheng Wang <zyytlz.wz@163.com> wrote:
> >  
> >> In at91_adc_probe, &st->touch_st.workq is bound with
> >> at91_adc_workq_handler. Then it will be started by irq
> >> handler at91_adc_touch_data_handler
> >>
> >> If we remove the driver which will call at91_adc_remove
> >>    to make cleanup, there may be a unfinished work.
> >>
> >> The possible sequence is as follows:
> >>
> >> Fix it by finishing the work before cleanup in the at91_adc_remove
> >>
> >> CPU0                  CPU1
> >>
> >>                      |at91_adc_workq_handler
> >> at91_adc_remove     |
> >> iio_device_unregister|
> >> iio_dev_release     |
> >> kfree(iio_dev_opaque);|
> >>                      |
> >>                      |iio_push_to_buffers
> >>                      |&iio_dev_opaque->buffer_list
> >>                      |//use
> >> Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> >> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >> ---
> >>   drivers/iio/adc/at91-sama5d2_adc.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> >> index 50d02e5fc6fc..1b95d18d9e0b 100644
> >> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> >> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> >> @@ -2495,6 +2495,8 @@ static int at91_adc_remove(struct platform_device *pdev)
> >>   	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >>   	struct at91_adc_state *st = iio_priv(indio_dev);
> >>   
> >> +	disable_irq_nosync(st->irq);
> >> +	cancel_work_sync(&st->touch_st.workq);  
> > I'd like some input form someone more familiar with this driver than I am.
> >
> > In particular, whilst it fixes the bug seen I'm not sure what the most
> > logical ordering for the disable is or the best way to do it.
> >
> > I'd prefer to see the irq cut off at source by disabling it at the device
> > feature that is generating the irq followed by cancelling or waiting for
> > completion of any in flight work.  
> The usually way you'd do this by calling free_irq() before the 
> cancel_work_sync().

I'd go a little further than that and disable the interrupt source at the
device (if possible) then call free_irq() then cancel_work_sync()

Otherwise the device is merrily monitoring something and generating interrupts
that we don't care about.  Might well be wasting power doing that, though I haven't
checked the flow in this particular case.

Jonathan

