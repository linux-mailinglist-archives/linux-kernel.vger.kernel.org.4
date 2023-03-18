Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697D96BFBD7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCRRY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCRRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:24:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A64513DD0;
        Sat, 18 Mar 2023 10:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CA6B8094F;
        Sat, 18 Mar 2023 17:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0FC433D2;
        Sat, 18 Mar 2023 17:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679160260;
        bh=km80eU5RmvZRE3qaaPVThX2oqEMEuAb2kMX8o2Jo2zI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iohfQk6S4zqFwANk01KYfDsBtZ1Xg+EoSIuNGoO8bptSs74tcq63nexZk8yBYuLFF
         HL1HTkXUTxJ8fBT/12h58OCJzOl7iD81KrQcIgaBJOw0LXk7Fa8jFKbXIsqpWJQHXA
         cp9ZESyC+8f9CVfCmZgpSiEbwi1PnMCqlGRp3jWcgVusck2z5npVNfeYmOKM4e+5qv
         OIqdkxe6ExoBnjDdbJk4KiCI2HSbzLX052+S8F3urSmxzhRhveMyiEhqyXP+ys1hHp
         2nWO0kws2XIXwhc25nMJmQopPXm8nsA35vGQGCCyPRos9n9BPOceYtz8/KVCdE6kiT
         9iuyedohiwvhg==
Date:   Sat, 18 Mar 2023 17:39:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     eugen.hristev@collabora.com, lars@metafoo.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: at91-sama5d2_adc: Fix use after free bug in
 at91_adc_remove due to race condition
Message-ID: <20230318173913.19e8a1b1@jic23-huawei>
In-Reply-To: <20230310091239.1440279-1-zyytlz.wz@163.com>
References: <20230310091239.1440279-1-zyytlz.wz@163.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023 17:12:39 +0800
Zheng Wang <zyytlz.wz@163.com> wrote:

> In at91_adc_probe, &st->touch_st.workq is bound with
> at91_adc_workq_handler. Then it will be started by irq
> handler at91_adc_touch_data_handler
> 
> If we remove the driver which will call at91_adc_remove
>   to make cleanup, there may be a unfinished work.
> 
> The possible sequence is as follows:
> 
> Fix it by finishing the work before cleanup in the at91_adc_remove
> 
> CPU0                  CPU1
> 
>                     |at91_adc_workq_handler
> at91_adc_remove     |
> iio_device_unregister|
> iio_dev_release     |
> kfree(iio_dev_opaque);|
>                     |
>                     |iio_push_to_buffers
>                     |&iio_dev_opaque->buffer_list
>                     |//use
> Fixes: 23ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 50d02e5fc6fc..1b95d18d9e0b 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -2495,6 +2495,8 @@ static int at91_adc_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct at91_adc_state *st = iio_priv(indio_dev);
>  
> +	disable_irq_nosync(st->irq);
> +	cancel_work_sync(&st->touch_st.workq);

I'd like some input form someone more familiar with this driver than I am.

In particular, whilst it fixes the bug seen I'm not sure what the most
logical ordering for the disable is or the best way to do it.

I'd prefer to see the irq cut off at source by disabling it at the device
feature that is generating the irq followed by cancelling or waiting for
completion of any in flight work.

>  	iio_device_unregister(indio_dev);
>  
>  	at91_adc_dma_disable(st);

