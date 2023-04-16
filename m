Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB0C6E3897
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDPNSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 09:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDPNSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 09:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCB9D;
        Sun, 16 Apr 2023 06:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2169B60C52;
        Sun, 16 Apr 2023 13:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55F7C433D2;
        Sun, 16 Apr 2023 13:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681651092;
        bh=+FPtkaUTRXePLRNBJSgv9UUmb/ltMYZ+A18jeS+pDtc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZBeFbPfyDR3lgBIxF7/T9d+VU8R94vyIIDmz0TZ9UdR5dKxwviPR7uBxQN5AkuGh+
         8Un0tTkcplR8NXGayLKdGiHVIOtM7CGauI7Wm6/A9TTmFRgg4g4HmL5Z8kZ1Kq5z1/
         P4J3KfBwlocr1nZlXUOLs0VG/Z82iIjWdX1fPLok/5Xtb7v6rMJR8+46t+n6PaMVXo
         +dc1+eL82v3oVI2B5f7qY1Eupn4DFGPKS0YdOK10FzHJ/advSy13ccs7yYfq56giol
         m0A8JTLz1oTu9nt9829HWQwKgEvwcxbXtpTYwmYnPA0NOdKSL8VPF4bMfwUOQF4HR5
         X5BN7IuTgFq/w==
Date:   Sun, 16 Apr 2023 14:18:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Message-ID: <20230416141813.18b29581@jic23-huawei>
In-Reply-To: <64ab56d2-7d67-4432-6c81-1d63b41811d6@fi.rohmeurope.com>
References: <cover.1677331779.git.mazziesaccount@gmail.com>
        <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
        <20230408113029.35429440@jic23-huawei>
        <64ab56d2-7d67-4432-6c81-1d63b41811d6@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> + * @IIO_CHAN_INFO_HYSTERESIS:
> >> + * @IIO_CHAN_INFO_HYSTERESIS_RELATIVE:
> >> + * @IIO_CHAN_INFO_INT_TIME:	Integration time. Time during which the data is
> >> + *				accumulated by the device.  
> > 
> > Unit? (seconds I think).  
> 
> Really...? Can you please double check this?
> 
> I believe the BU27034 uses micro seconds. I thought that was correct 
> approach - but if it is not then we can probably still change it w/o 
> breaking userland...

It's seconds in the ABI docs.  Thankfully time to fix the
driver.  No huge rush as long as we do it in time to slip in before
release.

In the early days of IIO we got most of our scaling from hwmon.
It became clear after a while that those weren't appropriate because
they tended to not have enough precision.  Hence things shifted (with
a few exceptions) to the SI unit without mili etc. I think the time
related ones all came after that change of approach.

Thanks,

Jonathan


> 
> 
> Yours,
> 	-- Matti
> 

