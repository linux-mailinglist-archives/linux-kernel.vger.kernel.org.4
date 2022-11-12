Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC4A626AA6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiKLQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:42:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0715A3C;
        Sat, 12 Nov 2022 08:42:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67AAFB80989;
        Sat, 12 Nov 2022 16:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E0EC433C1;
        Sat, 12 Nov 2022 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668271354;
        bh=mgo1N2SwwhYrdlOLDbEzP7m41GRLmkMdSIWWhHWIS1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nquU2gGUrv+0L+KZS4DMWinbum+KVubwlicNlKEbqIJadga61DhSeT8W55SFEwo+M
         HwYHwJoQahLG560iZfA8D9UGe6spmkpd09PyU5zRip2Z/vH9IWsC7F8bRWKwAbseun
         WVs+CxyAp3zNgT/MKfSrAw23PWegK4dUgMKYNy4E0NsJzYFm2V/Gst6GpfT5d+0yGX
         5pikukkxI2VvLaNN7/IlNDpeljS0oOAgBi4g82Z/27d06yw1IdorLmW1l0UOvrVgb5
         YlkGUZjPFXku4JBHITbm6/2DrL7CoIo8R97C3gzoGzX+LT6u/L1mRVJIRlcOGCxAjT
         vwNZNTv2fluPw==
Date:   Sat, 12 Nov 2022 16:54:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] dt-bindings: iio: ad74413r: make refin-supply
 optional
Message-ID: <20221112165448.17489ef1@jic23-huawei>
In-Reply-To: <20221111143921.742194-3-linux@rasmusvillemoes.dk>
References: <20221111143921.742194-1-linux@rasmusvillemoes.dk>
        <20221111143921.742194-3-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 11 Nov 2022 15:39:18 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> The ad74412r/ad74413r has an internal 2.5V reference output, which (by
> tying the REFOUT pin to the REFIN pin) can be used in lieu of an
> external 2.5V input reference. So stop marking refin-supply as
> required.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>


Interesting corner case.  Given we have no way of knowing if the
wiring has REFOUT connected to REFIN I see two ways we should fix this.

1) Just have any DT doing this provide a fixed regulator.
2) Have the REFOUT supported as an actual regulator - in theory it might be
   wired to other devices.  This might get a little interesting ordering
   wise as we'll want to register the regulator before we try to consume
   it in the same driver.  I'm also not 100% sure there are no other issues
   in a driver providing and consuming the same regulator.

I'm not keen to just assume lack of regulator means the chip is wired
like this.  Would be a different question if this was just setting
an internal mux to use the regulator without external loop back being
needed.

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> index 03bb90a7f4f8..e954d5ae4f4f 100644
> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
> @@ -56,7 +56,6 @@ required:
>    - reg
>    - spi-max-frequency
>    - spi-cpol
> -  - refin-supply
>  
>  additionalProperties: false
>  

