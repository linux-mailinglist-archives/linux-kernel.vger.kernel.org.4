Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF4573F439
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjF0GIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0GIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:08:15 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C812B;
        Mon, 26 Jun 2023 23:08:12 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CA9BFBF3;
        Tue, 27 Jun 2023 08:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1687846089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZI7i8mJ6vzWRz8q5uNF1QNgSOG0ThKzt12UTgm9PcA=;
        b=L3mZn4f2JH8rxdmXJX1Bz1uoCvsHRZd943LAmn3EvSI0Ydsk7RPFzNom2Tcp/7NwvUUt4g
        qIV6Ri6QXBAe8hfdgdZD0D9L/mgBxCIAe2E0CZNYkfm9e3L/N3X+BHaZSCfNvv00fHNwPP
        hd7NAZdNQO4YLhif+8qul7M2no3blLa2IDU8M+b0Ri5vPdKgVdmL3cfqQ07x7ekrmFTj2F
        TPD5I/3rHyVaMq5u9b2zM/Vps3E8egvNoszEIQxnTylJ3liO1wiO9Kg80FMbUN41/xaGwk
        rnSQ815ESwq35W70Aqj1NIMy6dgqnKI0v63Kh8Gj2rjuJ21Fzh5CZef5C6DUMA==
MIME-Version: 1.0
Date:   Tue, 27 Jun 2023 08:08:09 +0200
From:   Michael Walle <michael@walle.cc>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, git@amd.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        amitrkcian2002@gmail.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: jedec, spi-nor: Add DT property
 to avoid setting SRWD bit in status register
In-Reply-To: <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
 <20230625100251.31589-2-amit.kumar-mahapatra@amd.com>
Message-ID: <0e76360e43c411424e361911adbe1e0c@walle.cc>
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

Am 2023-06-25 12:02, schrieb Amit Kumar Mahapatra:
> If the WP# signal of the flash device is either not connected or is 
> wrongly
> tied to GND (that includes internal pull-downs), and the software sets 
> the
> status register write disable (SRWD) bit in the status register then 
> the
> status register permanently becomes read-only. To avoid this added a 
> new
> boolean DT property "no-wp". If this property is set in the DT then the
> software avoids setting the SRWD during status register write 
> operation.
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
> As the DT property name has changed so, removed Reviewed-by tag.
> @Cornor if possible, could you please review this updated patch.
> ---
>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml 
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 89959e5c47ba..97344969b02d 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -70,6 +70,21 @@ properties:
>        be used on such systems, to denote the absence of a reliable 
> reset
>        mechanism.
> 
> +  no-wp:
> +    type: boolean
> +    description:
> +      The status register write disable (SRWD) bit in status register, 
> combined
> +      with the WP# signal, provides hardware data protection for the 
> device. When
> +      the SRWD bit is set to 1, and the WP# signal is either driven 
> LOW or hard
> +      strapped to LOW, the status register nonvolatile bits become 
> read-only and
> +      the WRITE STATUS REGISTER operation will not execute. The only 
> way to exit
> +      this hardware-protected mode is to drive WP# HIGH. If the WP# 
> signal of the
> +      flash device is not connected or is wrongly tied to GND (that 
> includes internal
> +      pull-downs) then status register permanently becomes read-only 
> as the SRWD bit
> +      cannot be reset. This boolean flag can be used on such systems 
> to avoid setting
> +      the SRWD bit while writing the status register. WP# signal hard 
> strapped to GND
> +      can be a valid use case.
> +

Sounds good! Thank you.

Reviewed-by: Michael Walle <michael@walle.cc>

-michael

