Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904A6D31DA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjDAPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDAPHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 11:07:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DED51CBAE;
        Sat,  1 Apr 2023 08:06:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17554B80B8E;
        Sat,  1 Apr 2023 15:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32960C433D2;
        Sat,  1 Apr 2023 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680361616;
        bh=eWcVLmXAyk7tSxPhC2OzEJekG3r3oryXZpDIeJwufmw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BJb0n7v17H5lXS37AtJDN1lUce8/JT8Xvt/YBpZAu8d9ah9pf/p6BbJraxG/8n/MH
         lzV9RDthwlt05kF51HqhN3ssgKzbKbaxmJZY+1pPOWFch4HufpcZTHi53lJ2Y6R50h
         4rbzhgpbuJQjO9S6zLmtKYBYlF4F96Z+zOl+Tttg1cYh+9ET9VT64hjRXJhIQh1M9k
         49HDpGbb5eBusZFiE/nyqRLV/v/q/f86wXn8UK20pIx0GSno0sBoK50w7ZwHlXyy0k
         +/XnvPgwDS9zV/z+xNuwbN0Lz9CKTSkqHHaRYzpLvrgaJuY4d25tnWMYCun+e8f6qi
         vkSr1AXpKLM/w==
Date:   Sat, 1 Apr 2023 16:22:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Message-ID: <20230401162205.021bc413@jic23-huawei>
In-Reply-To: <ZCf01btsJRXcIOce@arbad>
References: <ZCf01btsJRXcIOce@arbad>
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

On Sat, 1 Apr 2023 11:09:41 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> Honeywell mpr is a pressure sensor family. There are many different
> types with different pressure ranges. The range needs to be set up in
> the dt. Therefore new properties honeywell,pmin and honeywell,pmax are
> introduced.
> 
> Add dt-bindings.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/pressure/honeywell,mpr.yaml  | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> new file mode 100644
> index 000000000000..d6fad6f841cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,mpr.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,mpr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Honeywell mpr pressure sensor
> +
> +maintainers:
> +  - Andreas Klinger <ak@it-klinger.de>
> +
> +description: |
> +  Honeywell pressure sensor of type mpr. This sensor has an I2C and SPI interface. Only the I2C
> +  interface is implemented.
> +
> +  There are many subtypes with different pressure ranges available. Therefore the minimum and
> +  maximum pressure values of the specific sensor needs to be specified in Pascal.
> +
> +  Specifications about the devices can be found at:
> +    https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/  \
> +      pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/          \
> +      sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf

Ouch. Anyone want to suggest to honeywell that they add some short paths for this stuff!

Please add regulator for VDD.  May well be a fixed reg on the boards you care about, but
it's still good document it's existence.

> +
> +properties:
> +  compatible:
> +    const: honeywell,mpr
> +
