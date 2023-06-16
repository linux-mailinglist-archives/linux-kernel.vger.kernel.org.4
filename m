Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F0E732C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241354AbjFPJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjFPJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:51:32 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49D297A;
        Fri, 16 Jun 2023 02:51:30 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E4FE21230;
        Fri, 16 Jun 2023 11:51:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1686909088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W59P54ZQm4yLfNN4lYHed/UxX8Xd4Uj8ugKkX1f9adA=;
        b=UdWowJ0ZfVpq05woisOR+GhHljah1MbXIyLobDSQb/sDahAnSmch4ntx11HZ4w/WCHL64R
        soewo4QkKX9RIGkFt6yaHydt4hAT1zyml8RtYcd1CjyrKKjDXF4dCRnV5u/8xKso5sZcoF
        BfaqGv4BjebsBMFHrcSwwteqV47H9TwsEKQ7yovH1HHtLlRucJy+x65pqho1D7CvIjP9lv
        AtEzQk0z0iuGvdCW7SroaaF7EgPnNwsVVsYdS0Wh6B/9F4lyP8MsdmVWT0B8BttS7ZNTHx
        w4bNoEOG1cD7c/TgJsHXhO6NDoniYqOupYpzCzysYeQK1CtPp896yoqmjrFISA==
MIME-Version: 1.0
Date:   Fri, 16 Jun 2023 11:51:27 +0200
From:   Michael Walle <michael@walle.cc>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, git@amd.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
In-Reply-To: <20230616085513.17632-2-amit.kumar-mahapatra@amd.com>
References: <20230616085513.17632-1-amit.kumar-mahapatra@amd.com>
 <20230616085513.17632-2-amit.kumar-mahapatra@amd.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f1d065e98d7b0d115e6a2a562a2a5c68@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-06-16 10:55, schrieb Amit Kumar Mahapatra:
> If the WP signal of the flash device is not connected and the software 
> sets
> the status register write disable (SRWD) bit in the status register 
> then
> thestatus register permanently becomes read-only. To avoid this added a 
> new
> boolean DT property "broken-wp". If WP signal is not connected, then 
> this
> property should be set in the DT to avoid setting the SRWD during 
> status
> register write operation.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 89959e5c47ba..10a6df752f6f 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -70,6 +70,21 @@ properties:
>        be used on such systems, to denote the absence of a reliable 
> reset
>        mechanism.
> 
> +  broken-wp:
> +    type: boolean
> +    description:
> +      The status register write disable (SRWD) bit in status register, 
> combined
> +      with the WP signal, provides hardware data protection for the
> device. When
> +      the SRWD bit is set to 1, and the WP signal is either driven LOW 
> or hard
> +      strapped to LOW, the status register nonvolatile bits become
> read-only and
> +      the WRITE STATUS REGISTER operation will not execute. The only
> way to exit
> +      this hardware-protected mode is to drive WP HIGH. If the WP 
> signal of the
> +      flash device is not connected then status register permanently 
> becomes
> +      read-only as the SRWD bit cannot be reset. This boolean flag can 
> be used
> +      on systems in which WP signal is not connected, to avoid setting 
> the SRWD
> +      bit while writing the status register.

This is not true for all flashes, for example, Macronix flashes seem to 
have
an internal pull-up, so if the pin is unconnected H/W write protection 
is
disabled.

So maybe only mention that "if the pin is wrongly tied to GND (that 
includes
internal pull-downs) or it is left floating".

Same goes for your comment in the driver code. Sorry for nitpicking, but
I fear some misuse of this property to disable the locking of the status
register.

> If the WP signal is hard strapped
> +      to LOW then it is not broken as it can be a valid use case.
> +

I'm not sure it the bindings use negative notion of pins, because that
signal is usually called WP#.

-michael
