Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D16612F90
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJaE4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJaE4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D470ADC8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5579360F37
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06C0C433D6;
        Mon, 31 Oct 2022 04:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667192160;
        bh=GAUz+juERAciVv8IqD0c3C4zKt3CzZRqEa0LqI1Dsmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GczfpQaAZ/Ge7rswNpoIirFbptr3bnjKqCWCvOwEKfgZAV6bKSqzsWLKoHPyJIbXH
         hDU6D+oIBTq84Ec4Ws9CCeEkry/P933AK6r8ZJ/OEFpQze/oQjvyzIidF//ML1d0it
         lGzl0ahaAU+vXs3vDe1rgV5wEsrZUecWumfKYNu8uBrXr9hMBQ0bap8bCZNBDae9EB
         vGfu9knXTWN8gVUq0OIlROUWoqb3ocuJnk1LG0jGS8jl/7UCU/wFRqNPfUuA4K/9T+
         13Bfi2KwK6LW4TsEca1i1ksz9/bHwrmjbmxWFIpkVcks8+ge00FZNMp/AFqrzaU/Nr
         cNWbt/IKpuQZg==
Date:   Mon, 31 Oct 2022 12:55:57 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] platform/chrome: cros_ec_lpc: Move mec_init/destroy
 to device probe/remove
Message-ID: <Y19VXaB1531V64EI@google.com>
References: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028141411.1.I0728421299079b104710c202d5d7095b2674fd8c@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 02:14:45PM -0700, Brian Norris wrote:
> Disregarding the weird global state hiding in this cros_ec_lpc_mec_*()
> stuff, it belongs in device probe/remove. We shouldn't assume we can
> access hardware resources when the device isn't attached to the driver.

It's also weird that cros_ec_lpc_mec_destroy() destroies a statically
allocated mutex[1].  How about let's remove it?

[1]: https://elixir.bootlin.com/linux/v6.0/source/drivers/platform/chrome/cros_ec_lpc_mec.c#L152

> @@ -586,9 +591,6 @@ static int __init cros_ec_lpc_init(void)
>  		return -ENODEV;
>  	}
>  
> -	cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
> -			     EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
> -
>  	/* Register the driver */
>  	ret = platform_driver_register(&cros_ec_lpc_driver);
>  	if (ret) {

There are 2 more cros_ec_lpc_mec_destroy()s need to be removed [2][3] though.

[2]: https://elixir.bootlin.com/linux/v6.0/source/drivers/platform/chrome/cros_ec_lpc.c#L596
[3]: https://elixir.bootlin.com/linux/v6.0/source/drivers/platform/chrome/cros_ec_lpc.c#L606
