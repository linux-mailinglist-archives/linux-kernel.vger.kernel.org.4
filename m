Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5460E73182A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245381AbjFOMI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbjFOMIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:08:54 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64473184;
        Thu, 15 Jun 2023 05:08:53 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 7A8299F4;
        Thu, 15 Jun 2023 14:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1686830929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByiMuKGszO/RULKL4xEPKNdqXuS6jdAajX52qRjoh/M=;
        b=z1xaFEBkLnxAYp4GTvNn4sIiMexPl6yL+tZeEf4oFbAD9M/vTcQYJ/aBHzCqECIZy9qNZs
        gH3af8xsGNtbSR7m/ntvDk4bRgcDKl4ZfuLWxLJWO9anWnQsyGU/Kk4ydt7JBYDljsVOyV
        fJSk5mLwGMNzog9JHJJzcjcQsLd9Fr9JabOoAyapDw16xocJWlb58PQyL3j0It0twNibOs
        pVDs7mETUwrDSYRRpRQ4kULF4je8bVInj7feUdYZG+bjJVXnvw7eUEn49cPLvN0KC3ArCG
        zcnjkT4NjGvurohIYeNXNx9InB+RaeqDVLPMQkg3aCEoHt6Xd8gWHRsBUBJGLw==
MIME-Version: 1.0
Date:   Thu, 15 Jun 2023 14:08:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, git@amd.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property to
 avoid setting SRWD bit in status register
In-Reply-To: <20230615111649.36344-2-amit.kumar-mahapatra@amd.com>
References: <20230615111649.36344-1-amit.kumar-mahapatra@amd.com>
 <20230615111649.36344-2-amit.kumar-mahapatra@amd.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <54a22a94be29786f055924714a1ffce4@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-06-15 13:16, schrieb Amit Kumar Mahapatra:
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
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml      | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 89959e5c47ba..a509d34f14b2 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -70,6 +70,19 @@ properties:
>        be used on such systems, to denote the absence of a reliable 
> reset
>        mechanism.
> 
> +  broken-wp:
> +    type: boolean
> +    description:
> +      The SRWD bit in status register, combined with the WP signal 
> provides
> +      hardware data protection for the device. When the SRWD bit is 
> set to 1,
> +      and the WP signal is driven LOW, the status register nonvolatile 
> bits
> +      become read-only and the WRITE STATUS REGISTER operation will
> not execute.
> +      The only way to exit this hardware-protected mode is to drive
> WP HIGH. But
> +      if the WP signal of the flash device is not connected then
> status register
> +      permanently becomes read-only as the SRWD bit cannot be reset.
> This boolean
> +      flag can be used on such systems in which WP signal is not 
> connected, to
> +      avoid setting the SRWD bit while writing the status register.

FWIW, this is also a valid use case: have the WP# pin tied to low, the
OEM will program the flash and then enable locking making the flash
permanently write protected. IWO, if the pin is hard strapped to low,
it is not always broken. You might add that to the description.

-michael
