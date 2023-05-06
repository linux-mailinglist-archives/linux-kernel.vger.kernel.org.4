Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1F6F935E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjEFRbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02911608D;
        Sat,  6 May 2023 10:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE6560677;
        Sat,  6 May 2023 17:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDADFC4339B;
        Sat,  6 May 2023 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683394293;
        bh=amJno4QQ+jgFZXOzLKev1VatVyFZZh6AJVwPxwidzCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e4GRKIBv7AReNH3O3yt+BylmGeICX1l0+Vm/AIQ0FwIeH20fBKOq9BlBcARXl7TtX
         K0/yajora7/QBt14gcsWvJO80xgvhORu/jY9zWAZzUhQT+B9vZNTXlt2pssGuijG6k
         G+LmIRSkQEfhzysmUCdcC9bFMxrDd9cXXa0VWSxdJPYJvioNfb7Aw+6IBUdrEK9BBH
         F2lxjVFd3TQg7aRBdF4bNoxWOff3sW+ZoWviZjINTfpx3zvwR9iGcMqiuHkhrjc/C8
         ZejZKtRapaNBjoRlkjsNcDA5NUzruJ+mpW2IK1F3MKBCnenw++MuaphUYa1t4alELl
         oDkJskRI77u8g==
Date:   Sat, 6 May 2023 18:47:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] ROHM Sensor async probing
Message-ID: <20230506184727.344086c5@jic23-huawei>
In-Reply-To: <cover.1683185765.git.mazziesaccount@gmail.com>
References: <cover.1683185765.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 10:56:13 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Devices which may take a while to initialize during probe and which have
> no strong reason to probe synchronously can request asynchronous probing
> as default probe strategy. This can speed-up start times on some
> platforms.
> 
> There is however some caveats listed for asynchronous probing for
> example here:
> https://lore.kernel.org/all/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org.uk/
> 
> I don't know how tolerant IIO users are what comes to asynchronous
> probing but I _guess_ this is (and should be) handled pretty well.
> Still, guessing could be said to be somewhat sub-optimal when doing
> kernel development :) Hence this RFC - if someone has better
> understanding on async probing when using IIO, please let me know!
> 
> As far as I know these drivers do not currently have in-tree users.
> Furthemore, they are so new they don't probably have many user-space
> users either. In fact, the BU27034 is not yet in any official releases
> and BU27008 is not merged in any official trees yet. Thus, testing out
> async probing with them should not break existing users. KX022A is also
> relatively new and I don't think it has yet been widely used either.
> 
> Finally, if asynchronous probing does break things, then:
> a) We should try fix the thing preventing async probe.
> b) We can pretty easily revert back to synchronous probing.
> 
> Please note that the patch 2 depends on
> https://lore.kernel.org/lkml/cover.1683105758.git.mazziesaccount@gmail.com/
> which is not yet in-tree. If the feed-back from this RFC is positive,
> then I will squash this change to that series when re-spinning it next
> time.
> 
> Please note that the patch 3 depends on bu27034 series which is expected
> to land on 6.4-rc1.

Generally it should be fine, but given that weird things sometimes happen
we don't apply a blanket policy and it's up to individual driver maintainers
to give it a go.  Also it's only worth doing if a driver is significantly
slow for some reason..

I've hit problems with async probe before (usually showing up bugs that
weren't visible before), but not in IIO drivers.

So I've applied patches 1 and 3.  Plenty of time for people to shout if they
can see a problem though.

Jonathan

> 
> ---
> 
> Matti Vaittinen (3):
>   iio: bu27034: Probe asynchronously
>   iio: bu27008: Probe asynchronously
>   iio: kx022a: Probe asynchronously
> 
>  drivers/iio/accel/kionix-kx022a-i2c.c | 1 +
>  drivers/iio/accel/kionix-kx022a-spi.c | 1 +
>  drivers/iio/light/rohm-bu27008.c      | 1 +
>  drivers/iio/light/rohm-bu27034.c      | 1 +
>  4 files changed, 4 insertions(+)
> 

