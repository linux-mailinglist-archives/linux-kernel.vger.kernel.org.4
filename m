Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B7734111
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346215AbjFQMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjFQMzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCC1BD6;
        Sat, 17 Jun 2023 05:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5D6160FA8;
        Sat, 17 Jun 2023 12:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8A7C433C8;
        Sat, 17 Jun 2023 12:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687006541;
        bh=9rtErtqoAEzQqg0zkXddXSShr9vSuldH5TEoYh3KshU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o28KeHaj253gtQ4WjWnZIHAR9/cKbvtJg/hFxZpCWjfgJz34bqKAHYECStcat09y5
         sJjEKyiizLReFUD0QCWScHOj0umrn0as9MglH1itUwVCpPNbj9gXiUXK0kRgCC4e9h
         5GLE9kFiLg5Vt5P/qsN0w8xjIcJoAJYmQ3IhBl96BJnj6jQrb16uYwQIUWF/SPHZnO
         EtAE5nkOa3u4VrM3bqQVIVhpATqc+UDOUHhHJDs0QbnSvTyrI9bx3iMa/OdzQHUSPh
         TseY8V/DA2LUhxSx5TFdvJTvFRDbG4fQKg2j93efJ0A25JJnfY3wrxGSZkvLYCVCBy
         FUK0BgqJiswPA==
Date:   Sat, 17 Jun 2023 13:55:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: proximity: Add bindings for
 Murata IRS-D200
Message-ID: <20230617135532.328dc3c8@jic23-huawei>
In-Reply-To: <9487391b0565434761055b39ba04900bd839580a.1686926857.git.waqarh@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <9487391b0565434761055b39ba04900bd839580a.1686926857.git.waqarh@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 17:10:42 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Murata IRS-D200 is a PIR sensor for human detection. It uses the I2C bus
> for communication with interrupt support. Add devicetree bindings
> requiring the compatible string, I2C slave address (reg) and interrupts.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

This device will have some power supplies, so I'd expect those to be both
listed and marked as required (maybe some are optional?)

Other than that and the points in the other review one thing inline about interrupts.

Jonathan

> ---
>  .../iio/proximity/murata,irsd200.yaml         | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
> new file mode 100644
> index 000000000000..d317fbe7bd50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/murata,irsd200.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/proximity/murata,irsd200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Murata IRS-D200 PIR sensor
> +
> +maintainers:
> +  - Waqar Hameed <waqar.hameed@axis.com>
> +
> +description: |
> +  PIR sensor for human detection.
> +
> +properties:
> +  compatible:
> +    const: murata,irsd200
> +
> +  reg:
> +    items:
> +      - enum:
> +          - 0x48
> +          - 0x49
> +        description: |
> +          When the AD pin is connected to GND, the slave address is 0x48.
> +          When the AD pin is connected to VDD, the slave address is 0x49.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Type should be IRQ_TYPE_EDGE_RISING.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

If it is possible to remove interrupts from requires  - and hence have
at least a partly functional driver doing basic reading of the sensor
then that is usually a good idea.   Far too many board designers seem
to decide that they don't need to wire up interrupt lines.

If it's really hard then don't worry too much.

Jonathan

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pir@48 {
> +            compatible = "murata,irsd200";
> +            reg = <0x48>;
> +            interrupts = <24 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };
> +...

