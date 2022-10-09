Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE735F8B37
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJIMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJIMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:33:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2E22B07;
        Sun,  9 Oct 2022 05:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E23B8B80D19;
        Sun,  9 Oct 2022 12:33:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE19DC433D6;
        Sun,  9 Oct 2022 12:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665318810;
        bh=9WyCokWSQ+YPo9bet+5rKNeJq50AKYj52DF+Ejp3zSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VhIE7ZX6bvCAMvLCfiTxs2711lzx+ADlYUD7YVVTTFrZdjCxgqc8GTEHic/JE+W7d
         yj7Wtfcm3anovQseN1Kif2qsLA78Or+kWC2wg6zQNnfsXnmWZ3K6HguSlX6PK2mw7D
         RTdYJmUYTTEW7FqtwIqYCw1ceA31QBG9YckYxvURkeukotwI4yQWXiHJfQ+37UsCGy
         8V4kMsOuv96o9t9+PC9NRXWwVxEiJsPnFY4f+Z3ZNxQ95MpzBJEXdeId5GnQhh3GI5
         vE3It7kegVzCe2EAyPGUPpF9QPYjMtbfFlDwuEZiTscf1a7drJS+a4kAaZaMkPP0z8
         gq9djqm7WPoAQ==
Date:   Sun, 9 Oct 2022 13:33:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <20221009133351.6ff4894b@jic23-huawei>
In-Reply-To: <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
        <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
        <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 6 Oct 2022 21:32:11 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:
> > KX022A is a 3-axis accelerometer from ROHM/Kionix. The senosr features
> > include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> > tap/motion detection, wake-up & back-to-sleep events, four acceleration
> > ranges (2, 4, 8 and 16g) and probably some other cool features.
> > 
> > Add support for the basic accelerometer features such as getting the
> > acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> > using the WMI IRQ).
> > 
> > Important things to be added include the double-tap, motion
> > detection and wake-up as well as the runtime power management.
> > 
> > NOTE: Filling-up the hardware FIFO should be avoided. During my testing
> > I noticed that filling up the hardware FIFO might mess-up the sample
> > count. My sensor ended up in a state where the amount of data in FIFO was
> > reported to be 0xff bytes, which equals to 42,5 samples. Specification
> > says the FIFO can hold a maximum of 41 samples in HiRes mode. Also, at
> > least once the FIFO was stuck in a state where reading data from
> > hardware FIFO did not decrease the amount of data reported to be in the
> > FIFO - eg. FIFO was "stuck". The code has now an error count and 10
> > reads with invalid FIFO data count will cause the fifo contents to be
> > dropped.  
> 

> ...
...



> ...
> 
> > +module_param(g_kx022a_use_buffer, bool, 0);
> > +MODULE_PARM_DESC(g_kx022a_use_buffer,
> > +		 "Buffer samples. Use at own risk. Fifo must not overflow");  
> 
> Why?! We usually do not allow module parameters in the new code.
> 

Badly broken hardware - was my suggestion.  Alternatives if there are usecases
that need to use the fifo, but it can wedge hard in a fashion that is impossible
to prevent from the driver?  My gut feeling is still drop the support entirely
with a strong comment in the code that the hardware is broken in a fashion we don't
know how to work around.

Jonathan


