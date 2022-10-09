Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0765F8C8E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 19:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJIRin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJIRik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 13:38:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2760F2983E;
        Sun,  9 Oct 2022 10:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1729B80D86;
        Sun,  9 Oct 2022 17:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25840C433D6;
        Sun,  9 Oct 2022 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665337116;
        bh=vG5xxQ1IE0ZAYCWj1ElLNJKIb8J8PN1GvB54lauAKwE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bh2yMMhMkI8SEUwxNLcyHdG5SEy7DEiJOwrPI/O0VSoAfJdlKTHLQUrDG/7yk1G/G
         Xj2AH+M2R1JNlSupbQhiYl9J4vJHp+9jz4ruLZ6ALoFNEHmQXlvIMEZtE0ImGLlLai
         CvtReFwAYXxqF+o6TpnODLqgnjGAUq8SMelY5b0A+tFrFy4cfJ4BJ0JLWay733ZxxJ
         6tLWwp0P8eZfSVYQbfnhsDsw2eJM7xEvpSLxlHoUyJt4aVea/sJmcHHJQZfUm/E2U1
         ezKAY2tGKI0HKj7Fpo81SvEtgb1HgS+Az+b0WBPuCQNcM7cbd27yR8hp0hufwkb5Hn
         y9o4OVdp09DZw==
Date:   Sun, 9 Oct 2022 18:38:54 +0100
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
        chrome-platform@lists.linux.dev
Subject: Re: [RFT PATCH v3 10/10] iio: Don't silently expect attribute types
Message-ID: <20221009183854.690e2780@jic23-huawei>
In-Reply-To: <8ef99012-4959-a674-13c1-186b9c1c2cd4@gmail.com>
References: <cover.1664782676.git.mazziesaccount@gmail.com>
        <63f54787a684eb1232f1c5d275a09c786987fe4a.1664782676.git.mazziesaccount@gmail.com>
        <c163203c-d87b-7e71-f582-964a99e37efb@microchip.com>
        <8ef99012-4959-a674-13c1-186b9c1c2cd4@gmail.com>
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

On Thu, 6 Oct 2022 15:53:52 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Claudiu,
> 
> On 10/6/22 11:35, Claudiu.Beznea@microchip.com wrote:
> > On 03.10.2022 11:13, Matti Vaittinen wrote:  
> >> The iio_triggered_buffer_setup_ext() and the
> >> devm_iio_kfifo_buffer_setup_ext() were changed by
> >> commit 15097c7a1adc ("iio: buffer: wrap all buffer attributes into iio_dev_attr")
> >> to silently expect that all attributes given in buffer_attrs array are
> >> device-attributes. This expectation was not forced by the API - and some
> >> drivers did register attributes created by IIO_CONST_ATTR().
> >>
> >> When using IIO_CONST_ATTRs the added attribute "wrapping" does not copy
> >> the pointer to stored string constant and when the sysfs file is read the
> >> kernel will access to invalid location.
> >>
> >> Change the function signatures to expect an array of iio_dev_attrs to
> >> avoid similar errors in the future.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>  
> > 
> > Tested-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > 
> > on SAMA5D2
> >   
> 
> Thanks a ton for the testing! I do _really_ appreciate it :) I am now 
> slightly more confident regarding the fix here - and a lot more 
> confident that we do have an actual bug (as you explained in the reply 
> to the first RFT) :)

You analysis was sound, so I've long been convinced ;)

Anyhow, one more coming through...
AD4130 v9 patch had same issue and so will also need updating with this
patch if it lands before yours.

Other than that static macro being ugly (which I can't improve on!)
all looks good to me, but I'll let it sit a while longer. If nothing
else I want to rebase the fixes-togreg tree on rc1 before putting the first
part of this series on top of it then letting them soak in next for
a few days,

Thanks,

Jonathan


> 
> Yours
> 	-- Matti
> 

