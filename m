Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB860BF54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJYAQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJYAPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:15:50 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CC839A28B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:34:59 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id mxacoYi4Bg7y2mxaconyov; Mon, 24 Oct 2022 15:34:04 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Oct 2022 15:34:04 +0200
X-ME-IP: 86.243.100.34
Message-ID: <3ad8b485-9007-f7e9-f52a-d5644a688bcf@wanadoo.fr>
Date:   Mon, 24 Oct 2022 15:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/3] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Content-Language: fr
To:     mazziesaccount@gmail.com
Cc:     DDRokosov@sberdevices.ru, andriy.shevchenko@linux.intel.com,
        demonsingur@gmail.com, devicetree@vger.kernel.org,
        jagathjog1996@gmail.com, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com, nikita.yoush@cogentembedded.com,
        robh+dt@kernel.org
References: <cover.1666350457.git.mazziesaccount@gmail.com>
 <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <7baf3dd482ab1db0d8a3676d6d5d3e4ab7f3cf9d.1666350457.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/10/2022 à 13:22, Matti Vaittinen a écrit :
> KX022A is a 3-axis accelerometer from ROHM/Kionix. The sensor features
> include variable ODRs, I2C and SPI control, FIFO/LIFO with watermark IRQ,
> tap/motion detection, wake-up & back-to-sleep events, four acceleration
> ranges (2, 4, 8 and 16g), and probably some other cool features.
> 
> Add support for the basic accelerometer features such as getting the
> acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> using the WMI IRQ).
> 
> Important things to be added include the double-tap, motion
> detection and wake-up as well as the runtime power management.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---

Hi, should there be a v5:

> +/*
> + * The KX022A has FIFO which can store 43 samples of HiRes data from 2

Nit: 2 here, but 3 the lines just before.

> + * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
> + * 258 bytes of sample data. The quirk to know is that the amount of bytes in
> + * the FIFO is advertised via 8 bit register (max value 255). The thing to note
> + * is that full 258 bytes of data is indicated using the max value 255.
> + */

