Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4C61DB14
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKEOpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiKEOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745CFF02B;
        Sat,  5 Nov 2022 07:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BEAE60B4D;
        Sat,  5 Nov 2022 14:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3EEC433C1;
        Sat,  5 Nov 2022 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667659530;
        bh=zAlUT2GD+IAN3kTMRHI/1fujPF44ZCbrcVuH6AXFD/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dhI3VfiFN/dAdthxO4xV51tqwHD2MsUDxZPxw4p+dSFzYzeHC/6gQwVM4pmgV5td6
         HCUcJ62ucvHaemxmyZ1LaajbPIsRO7YFLngMx/aSRvo+9Otw/uOymssV7VltoHUjvr
         JNIsQlhHAO4D4OHitLhrt7y10PkwR/vdoW35rnBI6hI7fmARngtUQP3BEWXhhqNTbr
         kyob0eauZduHXfAHOf9Us9PcO9nu+WqMoXTYEZqO2lSqrmEnFQzNW2QXZ/jLzyKh9s
         fdqHAEqOT9xZBTyuclM7ZhILD67R2E3VZBc0Aqh0fb1cSVP5aD3RnURHPIU3jJEWfb
         F1u9GPRqUXCyw==
Date:   Sat, 5 Nov 2022 14:45:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Claudiu.Beznea@microchip.com, matti.vaittinen@fi.rohmeurope.com,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        cosmin.tanislav@analog.com, Eugen.Hristev@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        bleung@chromium.org, groeck@chromium.org,
        alexandru.ardelean@analog.com, nathan@kernel.org,
        miquel.raynal@bootlin.com, linmq006@gmail.com,
        u.kleine-koenig@pengutronix.de, paul@crapouillou.net,
        mihail.chindris@analog.com, gwendal@chromium.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Message-ID: <20221105144518.7fa63084@jic23-huawei>
In-Reply-To: <41abe9f6-d633-664a-db93-0580b23e44e1@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
        <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
        <c163203c-d87b-7e71-f582-964a99e37efb@microchip.com>
        <8ef99012-4959-a674-13c1-186b9c1c2cd4@gmail.com>
        <20221009183854.690e2780@jic23-huawei>
        <41abe9f6-d633-664a-db93-0580b23e44e1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 12:36:54 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/9/22 20:38, Jonathan Cameron wrote:
> > On Thu, 6 Oct 2022 15:53:52 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Hi Claudiu,
> >>
> >> On 10/6/22 11:35, Claudiu.Beznea@microchip.com wrote:  
> >>> On 03.10.2022 11:13, Matti Vaittinen wrote:  
> >>>> The iio_triggered_buffer_setup_ext() and the
> >>>> devm_iio_kfifo_buffer_setup_ext() were changed by
> >>>> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> >>>> to silently expect that all attributes given in buffer_attrs array are
> >>>> device-attributes. This expectation was not forced by the API - and some
> >>>> drivers did register attributes created by IIO_CONST_ATTR().
> >>>>
> >>>> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
> >>>> the pointer to stored string constant and when the sysfs file is read the
> >>>> kernel will access to invalid location.
> >>>>
> >>>> Change the function signatures to expect an array of iio_dev_attrs to
> >>>> avoid similar errors in the future.
> >>>>
> >>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> >>>
> >>> Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>>
> >>> on SAMA5D2
> >>>      
> >>
> >> Thanks a ton for the testing! I do _really_ appreciate it :) I am now
> >> slightly more confident regarding the fix here - and a lot more
> >> confident that we do have an actual bug (as you explained in the reply
> >> to the first RFT) :)  
> > 
> > You analysis was sound, so I've long been convinced ;)
> > 
> > Anyhow, one more coming through...
> > AD4130 v9 patch had same issue and so will also need updating with this
> > patch if it lands before yours.
> > 
> > Other than that static macro being ugly (which I can't improve on!)
> > all looks good to me, but I'll let it sit a while longer. If nothing
> > else I want to rebase the fixes-togreg tree on rc1 before putting the first
> > part of this series on top of it then letting them soak in next for
> > a few days,  
> 
> Thanks Jonathan.
> 
> Can you please ping me if you want me to rebase/rework the series? (I 
> may combine this with the kx022a-series then, but naturally not all 
> patches in the series need to be applied at once. Eg, fixes can be taken 
> in faster, kx022a part can be iterated, iterated, iterated... ;] ).

Applied the remainder of this series. As expected need to make the changes
in patch 10 to your kx022a driver and the ad4130 ADC that also crossed with
this series.

+CC Cosmin for the ad4130.  Please check the result in the
testing branch of iio.git.

Applied to the togreg branch of iio.git and pushed out initially as testing.

This is a nice hardening of the code against future mistakes.

Thanks,

Jonathan

> 
> Yours
> 	-- Matti
> 

