Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A35600592
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 05:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiJQDG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 23:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiJQDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 23:06:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02CE4B480
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665975990; x=1697511990;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xdELnJJexhL8yWqz/OoEfdlgLu6DNFfGugQqaoZToj4=;
  b=H/nSR0FtCJWCfv6UEMU3yyG/LN5qqvvOzydeKaiJhaGEuo8HK0uNkfUn
   y/g4qAYi7BNDa7R0OMn+EWqzuisxqFdy2trhGHTzuSh3LtaaylXHCvklm
   VFi33tE3LqJLlYp5lZ/StW2PRBnC+C5EA03H+xxSqJTcm1eX5vNQsjPba
   lP8VgiHbJ5cXXeXkjQlZvmjeNyv5rBLK8HYWlF91K30suknF78fFzSwOc
   dK5ovwqZ7Nrd4BssljGAgGR2TQXvufFK2McPb0CoV4m9WccH6k5d8pQzP
   VdJDj8AuP4dLmf6HoUEPAP2U1n7xL/vKUHVWl9L9pBqNt2wTz5wnzIUDq
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="214364780"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:06:19 +0800
IronPort-SDR: xyfy7hk+17nGAfV5e0u8NNUpyGEovIoq1DUYvFnsu2uHrzSxcgKKAktCezIP3gKvoU4GtVA/sE
 qlV6E9BlXg6bWR/fJ7bC5UC69Hb3krwE2VXwii+JwioAW84+qOvXC+uHzdH3sHZD51Bksd/Hat
 pN8HFt1PnzB8w0lxDSpTaMZbkT76WPeLfQl2/4x9xq6PazxjMfEK1b38ylzi4zGYByTSl9M53e
 ZKuhzjxk1g2iOYro97QjrFGXvxpwfF+DpbPWrDBJUL6iBCslOIDrWHzB568f2Xhu2D4byk8Djg
 GzxoS20OyRTK4JliVfAeEl//
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:25:52 -0700
IronPort-SDR: TbhGOfLIv14RfwRPEyA9aLYh+Bk5co4SnEPB+4LTZaBPRc5zl/FqhkFBozvyFVT7Z23nXjZTcQ
 PQdB4zVxLs7SClj8m/zD0Q+HlcE8QBUtALuVeDdBEqX2/F2OV5o/wAyHhbkf0PbmAGCvm48Z/C
 9veBuirbfHzCv1yCjeZU6kNTBWA/NtL+EHsbBaahepSsf7VCnnvLi0tnrptehvwoBSDXu4b9AI
 s3dG0mahgyeIDwhldL/4XKaOYLIh3ZCj4OTl3jF6BTqNXEKTGRHVDOvNuhDBV9Pf2i14krC8OR
 svM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:06:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMMZ5pQHz1Rwt8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 20:06:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1665975978; x=1668567979; bh=xdELnJJexhL8yWqz/OoEfdlgLu6DNFfGugQ
        qaoZToj4=; b=P2rY1boatCbL1fMRSR2oTyi7HWkdW4fEzEB9PaMMFmES8VlU1LG
        FRngwMd2S2CNm4cGxlgSC16fCOi6ySznlkfmqTfp/GAI/bLWsVn0f1jXbCwcwclg
        wgDAIbK4a0C0W/axrTWg0KxI9zjNV5WdYm8uVjxWzvcj1GOIld9orwu9R/93BbqZ
        0BfVmC3VBxu5UPe3yboDCV+caAeARNLYPlb8qG1aG3Bg8F13iW76VJwCfzzQBu7u
        tGxbuQFV8QjsQVhn3nbv7d//HbHTJOf9R1zQF+k2kDA8q7jbVM9k6lRq5NuCzbVo
        NrvOyTRzNFFzWNruCGPI2aslk6toU2/pusA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2KsZT-YkkE8N for <linux-kernel@vger.kernel.org>;
        Sun, 16 Oct 2022 20:06:18 -0700 (PDT)
Received: from [10.225.163.121] (unknown [10.225.163.121])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMMX6VCsz1RvLy;
        Sun, 16 Oct 2022 20:06:16 -0700 (PDT)
Message-ID: <0f330b8a-b4c3-3dcb-2754-2c95d8c85037@opensource.wdc.com>
Date:   Mon, 17 Oct 2022 12:06:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] dt-bindings: ata: Add 'ata-generic' binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Shiyan <shc_work@mail.ru>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011135849.2785834-1-robh@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221011135849.2785834-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 22:58, Rob Herring wrote:
> The 'ata-generic' binding has been around since 2008, but never
> documented.
> 
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> AFAICT, the ata-generic,use16bit property has no effect in Linux. The
> 32-bit transfers fallback to 16-bit if ATA_PFLAG_PIO32 flag is not set
> which it doesn't appear to ever be set. Looking at the history, the
> driver always used 16-bit mode.
> 
> Linus, Okay with being maintainer here?

If Linus reply is positive, feel free to add:

Acked-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

I can take this one through the libata tree also if you prefer.

> 
> ---
>  .../devicetree/bindings/ata/ata-generic.yaml  | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ata/ata-generic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ata-generic.yaml b/Documentation/devicetree/bindings/ata/ata-generic.yaml
> new file mode 100644
> index 000000000000..0697927f3d7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ata-generic.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ata-generic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic Parallel ATA Controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  Generic Parallel ATA controllers supporting PIO modes only.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - arm,vexpress-cf
> +          - fsl,mpc8349emitx-pata
> +      - const: ata-generic
> +
> +  reg:
> +    items:
> +      - description: Command interface registers
> +      - description: Control interface registers
> +
> +  reg-shift:
> +    enum: [ 1, 2 ]
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ata-generic,use16bit:
> +    type: boolean
> +    description: Use 16-bit accesses instead of 32-bit for data transfers
> +
> +  pio-mode:
> +    description: Maximum ATA PIO transfer mode
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 6
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    compact-flash@1a000 {
> +        compatible = "arm,vexpress-cf", "ata-generic";
> +        reg = <0x1a000 0x100>,
> +              <0x1a100 0xf00>;
> +        reg-shift = <2>;
> +    };
> +...

-- 
Damien Le Moal
Western Digital Research

