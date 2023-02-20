Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C4869C695
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjBTI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 03:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjBTI27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 03:28:59 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0696B75E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 00:28:58 -0800 (PST)
Received: from [172.16.71.140] (unknown [49.255.141.98])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 46AC620061;
        Mon, 20 Feb 2023 16:28:49 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1676881733;
        bh=fXFu0XLA13XF+cazWWGEf49HqJUOQDfKQ9JtzfT9Ba4=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=R6tfCZuHDsBmU4JIqHwzq6TVoxUP5OKOYzxMjwI3REytm3t9sDxp5y7fTkYw5/r36
         THL+vY5NpIIOZABqwkpUeZiqROEgiUy8dcj8ALOcTnROSmM2iV+PZK9Mq+fCcoBGsr
         MVsHF+olsTZv/ff8bwBQIwf188QSIv9nbvD4C+RmoC8qNejQ9z2zwkzXpV0WmsDCaC
         FzXEl7R8+4dGl35MPnd7MeyhjjcEBp3ZN1Jg9NVSDe+3ucE8pqK0I+v2uxDp+qJFpm
         Om+8AHw+nwGmeoe4CF76gk6xd3ZQQCpZb2HFWFlWU6/9VLabnrgJIlPJhv7zsOktOf
         5syRHwBwvabmg==
Message-ID: <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 20 Feb 2023 16:28:47 +0800
In-Reply-To: <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
         <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

> AST2600 support new register set for I2Cv2 controller, add bindings
> document to support driver of i2cv2 new register mode controller.

Some comments inline:

> +=C2=A0 clock-frequency:
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Desired I2C bus clock frequency in Hz. de=
fault 100khz.
> +
> +=C2=A0 multi-master:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 states that there is another master activ=
e on this bus

These are common to all i2c controllers, but I see that
i2c-controller.yaml doesn't include them (while i2c.text does).

I assume we're OK to include these in the device bindings in the
meantime. But in that case, you may also want to include the common
"smbus-alert" property, which you consume in your driver.

> +=C2=A0 timeout:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: Enable i2c bus timeout for master/slave =
(35ms)
> +
> +=C2=A0 byte-mode:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: Force i2c driver use byte mode transmit
> +
> +=C2=A0 buff-mode:
> +=C2=A0=C2=A0=C2=A0 type: boolean
> +=C2=A0=C2=A0=C2=A0 description: Force i2c driver use buffer mode transmi=
t

These three aren't really a property of the hardware, more of the
intended driver configuration. Do they really belong in the DT?

[and how would a DT author know which modes to choose?]

> +=C2=A0 aspeed,gr:
> +=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitions/phandle
> +=C2=A0=C2=A0=C2=A0 description: The phandle of i2c global register node.

We'll probably want this to be consistent with other instances of aspeed
global register references. I've used "aspeed,global-regs" in the
proposed i3c binding:

  https://lore.kernel.org/linux-devicetree/cover.1676532146.git.jk@codecons=
truct.com.au/T/#mda2d005f77ca0c481b1f1edadb58fc1b007a5cc3

I'd argue that "global-regs" is a little more clear, but I'm okay with
either way - that change has been Acked but not been merged yet.
Whichever we choose though, it should be consistent.

Cheers,


Jeremy
