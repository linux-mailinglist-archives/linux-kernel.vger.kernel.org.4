Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF86609301
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJWMu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJWMuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:50:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC96113B;
        Sun, 23 Oct 2022 05:50:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04F09B80D90;
        Sun, 23 Oct 2022 12:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA8C433D6;
        Sun, 23 Oct 2022 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666529449;
        bh=0V4LYT13xnR1I06Gp/9Rn+rpUpGXEOBQ8/KSUy7AvXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rTCHEHXEDRX2V2EmkUnUxCl+y7Z7f1uxCLxuriRiJMJBRnsHs6bl7NY9nDGPn1ZUp
         pmQIuvWZhX3Q/X1Wkm3Kn5dHwJQXfks0s/r3NPuxIZaVYeXKQPQBdCOtK+hiafIING
         SHsd9zBTwJg0vWCkJUbgmoegoifCWDia9DzHZblABigqYo6GY99x5+pL/+Nmnb8xpg
         mGXox15Z9+aT3fZH2mJKO3VlevcvSiLgwg6WsrlFILKZWLxhNIeJi75587ZrqFucSW
         6kb+jb0/ddHT2id2tt8bHzCd0dqwI9H5sXr+IafeI2Xzfo88aGahBoSDY0aOdycfdP
         Ju5vm9vYzoY7w==
Date:   Sun, 23 Oct 2022 13:51:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: temperature: ltc2983: refine
Message-ID: <20221023135124.1fdeab5e@jic23-huawei>
In-Reply-To: <20221020090257.1717053-4-demonsingur@gmail.com>
References: <20221020090257.1717053-1-demonsingur@gmail.com>
        <20221020090257.1717053-4-demonsingur@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 12:02:55 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
>  * make sure addresses are represented as hex
>  * add note about wrong unit value for adi,mux-delay-config-us
>  * simplify descriptions
>  * add descriptions for the items of custom sensor tables
>  * add default property values where applicable
>  * use conditionals to extend minimum reg value
>    for single ended sensors
>  * remove " around phandle schema $ref
>  * remove label from example and use generic temperature
>    sensor name
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin,

Just one question inline from me (other than the build bot report that I'll
assume you'll fix for v3).

Otherwise looks like a nice cleanup to me.

I wonder a bit on whether it is worth splitting up, but that would be
rather messy to actually do so will leave that to the dt experts to comment
on.

Jonathan


> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 309 +++++++++++-------
>  1 file changed, 182 insertions(+), 127 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index 722781aa4697..3e97ec841fd6 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -26,25 +26,25 @@ properties:
>  
>    adi,mux-delay-config-us:
>      description:
> -      The LTC2983 performs 2 or 3 internal conversion cycles per temperature
> -      result. Each conversion cycle is performed with different excitation and
> -      input multiplexer configurations. Prior to each conversion, these
> -      excitation circuits and input switch configurations are changed and an
> -      internal 1ms delay ensures settling prior to the conversion cycle in most
> -      cases. An extra delay can be configured using this property. The value is
> -      rounded to nearest 100us.
> +      Extra delay prior to each conversion, in addition to the internal 1ms
> +      delay, for the multiplexer to switch input configurations and
> +      excitation values.
> +
> +      This property is supposed to be in microseconds, but to maintain
> +      compatibility, this value will be multiplied by 100 before usage.

This new text has me a little confused.  Previously we talked rounding, now it
is saying the value is multiplied (which would make it definitely not in micro
secs!)..  So are we papering over a driver bug here?



