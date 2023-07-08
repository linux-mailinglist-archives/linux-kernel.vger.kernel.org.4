Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF074BE62
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 18:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGHQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGHQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 12:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85981BB;
        Sat,  8 Jul 2023 09:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62D6160D54;
        Sat,  8 Jul 2023 16:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AFCC433C7;
        Sat,  8 Jul 2023 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688832416;
        bh=bfacAi1qvYjJDVjtB0AN9xWgrygw2bgt1Va270A9l+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P0OGSgT8d5FK4EdEr0Y8Z0a9vcRtzXqRE3O0M/DlDMfPKKPlqMjBoNO+wiUeGeESL
         W4BxHZl2QIZQfNNOkE5z7Kp2rfbB+gtBqWqWaZre7kYKEZX4wmYq91k2Yv/5/iB3XT
         YypWkWQETZ4BEyFB7uiG/9od8xBYy3nIpUnl2cgxE2FDKpBfxRuUGfNLuuRKBjirfi
         YccOlW67qmQ/tgvw3BxE/alWlY1NsXpC6lPycYjmT9kpgwTF6E6KNhkkdmyeqyLvKz
         Z3iLDbLkpgSrjZTO3/i30beU202/Fh0HkzOcesgkX74MVj8aBNb1+B0y8yh480klJF
         3TVJWXGPmXpQQ==
Date:   Sat, 8 Jul 2023 17:06:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Support ROHM BU27010 RGBC sensor
Message-ID: <20230708170649.6bdccc62@jic23-huawei>
In-Reply-To: <cover.1688723839.git.mazziesaccount@gmail.com>
References: <cover.1688723839.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2023 14:22:14 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Support ROHM BU27010 RGBC + flickering sensor.
> 
> Following description copied from commit log:
> 
> > The ROHM BU27010 is an RGBC sensor with a flickering detection FIFO. The
> > RGBC+IR sensor functionality is largely similar to what the BU27008 has.
> > There are some notable things though:
> >  - gain setting is once again new and exotic. Now, there is 6bit gain
> >    setting where 4 of the bits are common to all channels and 2 bits
> >    can be configured separately for each channel. The BU27010 has
> >    similar "1X on other channels vs 2X on IR when selector is 0x0"
> >    gain design as BU27008 had. So, we use same gain setting policy for
> >    BU27010 as we did for BU27008 - driver sets same gain selector for
> >    all channels but shows the gains separately for all channels so users
> >    can (at least in theory) detect this 1X vs 2X madness...
> >  - BU27010 has suffled all the control register bitfields to new
> >    addresses and bit positions while still keeping the register naming
> >    same.
> >  - Some more power/reset control is added.
> >  - FIFO for "flickering detection" is added.
> >
> > The control register suffling made this slightly nasty. Still, it is
> > easier for maintenance perspective to add the BU27010 support in BU27008
> > driver because - even though the bit positions/addresses were changed -
> > most of the driver structure can be re-used. Writing own driver for
> > BU27010 would mean plenty of duplicate code albeit a tad more clarity.  
> 
> This series is done on top of the iio-for-6.5a + this fix-up series:
> https://lore.kernel.org/all/cover.1686648422.git.mazziesaccount@gmail.com/
> 
> I didn't spot these fixups from iio git although I think I saw mail
> stating they were applied.

They are now on the fixes-togreg branch of iio.  Things are sometimes
fiddly around the merge window. That tree may well be rebased again after
rc1 is available.

This series is going to have to wait to be applied until those fixes
are in my upstream for the togreg branch.

Thanks,

Jonathan

> 
> Revision history:
> 
> v1 => v2:
>  - make vdd-supply required binding.
>  - Some re-ordering for struct member init.
>  - Some re-ordering for code to get rid of function declarations.
>  - Tidy up the mess from patch 2/3.
>    - Refactor parts from 3/3 to 2/3.
>    - Clean-up commented out code and tidy things in general.
> 
> Please note: I'll be mostly away from the computer during July. Please,
> take your time reviewing and forgive me if sending follow-up revisions
> is delayed.
> 
> ---
> 
> Matti Vaittinen (3):
>   dt-bindings: iio: ROHM BU27010 RGBC + flickering sensor
>   iio: light: bu27008: add chip info
>   iio: light: bd27008: Support BD27010 RGB
> 
>  .../bindings/iio/light/rohm,bu27010.yaml      |  49 ++
>  drivers/iio/light/rohm-bu27008.c              | 622 ++++++++++++++----
>  2 files changed, 556 insertions(+), 115 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
> 

