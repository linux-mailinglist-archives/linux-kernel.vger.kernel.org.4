Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4AA6D3111
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 15:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjDANeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 09:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDANd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 09:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B417191DF;
        Sat,  1 Apr 2023 06:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9FF160E26;
        Sat,  1 Apr 2023 13:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32551C433EF;
        Sat,  1 Apr 2023 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680356037;
        bh=GoAwsdWrReTo+aUQUGqZo7eRCiNX4xBnQGE0c+74wfI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tQYecD6CA571Svm2DJG1YVzpTDWRQ4wZLu9qhFJ4Y8RjTsTrFKqxl6Uysnab6Ow9l
         R7fkOKgaw/+UpyLIlRlqkPPlFMQMqSwk2SXlSWe0N0B62/9oSO5/9SI2snHxPM5gYw
         pxCtmLLWMnVpxRMVI93hVSC8qnCxqT1Cbcbd/XVMW2vEztma+GblDt9qIjZUgwy/gz
         mojgxVCY0xgjjFVBka3xeS2u3M7r4FW4q7t0LfWB/H74Ul1seSyBNGXvVdX1DY7O9o
         aWRh4ZpnGXR9HqINHpK8uVJbcLH04re7FquMk7H9Yd+eMF/ij7f7PYTlbLPxmzrNwm
         Aj/Kg/CZ5GsVA==
Date:   Sat, 1 Apr 2023 14:49:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     William Breathitt Gray <william.gray@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: addac: stx104: Migrate to the regmap API
Message-ID: <20230401144906.709558bd@jic23-huawei>
In-Reply-To: <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
References: <cover.1679867815.git.william.gray@linaro.org>
        <4ebc1b6b609a086846420954b893e914fd395384.1679867815.git.william.gray@linaro.org>
        <ZCGBIAvr7OQLwNXv@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > +	gpio_config = (struct gpio_regmap_config) {
> > +		.parent = dev,
> > +		.regmap = dio_map,
> > +		.ngpio = STX104_NGPIO,
> > +		.names = stx104_names,
> > +		.reg_dat_base = GPIO_REGMAP_ADDR(STX104_DIO_REG),
> > +		.reg_set_base = GPIO_REGMAP_ADDR(STX104_DIO_REG),
> > +		.ngpio_per_reg = STX104_NGPIO,
> > +		.reg_mask_xlate = stx104_reg_mask_xlate,
> > +		.drvdata = dio_map,
> > +	};  
> 
> Not sure of compound literal is good to have in such case, but if
> Jonathan asked for that...

I didn't like the separately zeroing of the structure in a different
place in the code.  This avoids that (but then so would using an explicit
memset just before filling the rest in.)

Jonathan



