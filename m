Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8E56278CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbiKNJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbiKNJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:14:33 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A9FBCA9;
        Mon, 14 Nov 2022 01:14:32 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C223E0008;
        Mon, 14 Nov 2022 09:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668417271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBxa36/e2s5Q5a4tS85ZI4cWnvsxpE1Fze65dFPuccA=;
        b=OBYem1eOTJHUmpN8jQbSq1S5Z4X0EyvDyjSYqCYfNbgLZn8z5FSrEf5LVNaqAhnyA6Hzzz
        AFnBi1Z9KTnI81wP45e8L4yuauqL1ek1puJzuqgs3Sjtmut8voOi4/KZbwn6SntpgGMqrK
        /DJ2ofaOyV/ZH5pwFJ35evlhh2tOtKCdeyn4Lhwraq8Ir5knm8JRfliYpH5wY6MeaX5Khw
        pZkfd+45vUG0obMEp1d1kw9gv3agM0k5n9/RwGXRbU96VgZMdMmKlJBI0SRQ6yHtYrAXSJ
        0kR7wYFj9vPEBA9RKcJVu9SKmzxmRV8TuTIWEDX2+Vd74dq1LgEhEuMLUtIimQ==
Date:   Mon, 14 Nov 2022 10:14:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mikhail Zhilkin <csharper2005@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: fixed-partitions: Fix
 'sercomm,scpart-id' schema
Message-ID: <20221114101428.3932e265@xps-13>
In-Reply-To: <20221111212824.4103514-1-robh@kernel.org>
References: <20221111212824.4103514-1-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Fri, 11 Nov 2022 15:28:24 -0600:

> The schema for 'sercomm,scpart-id' is broken. The 'if' condition is
> never true because 'compatible' is in the parent node, not the child
> node the sub-schema applies to. The example passes as there are no
> constraints on additional/unevaluated properties. That's a secondary
> issue which is complicated due to nested partitions.
>=20
> Drop the if/then schema and the unnecessary 'allOf' so that the
> 'sercomm,scpart-id' property is at least defined.
>=20
> Cc: Mikhail Zhilkin <csharper2005@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Mmmh right, I've missed that in my little rework. I'll apply it with
the big series "[PATCH v3 00/17]  Improve MTD bindings" as soon as the
last remaining patch gets reviewed.

> ---
>  .../mtd/partitions/fixed-partitions.yaml      | 29 +++++++------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-parti=
tions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partiti=
ons.yaml
> index ad3ccd250802..39b715aad2dc 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> @@ -31,24 +31,17 @@ properties:
> =20
>  patternProperties:
>    "@[0-9a-f]+$":
> -    allOf:
> -      - $ref: "partition.yaml#"
> -      - if:
> -          properties:
> -            compatible:
> -              contains:
> -                const: sercomm,sc-partitions
> -        then:
> -          properties:
> -            sercomm,scpart-id:
> -              description: Partition id in Sercomm partition map. Mtd
> -                parser uses this id to find a record in the partition map
> -                containing offset and size of the current partition. The
> -                values from partition map overrides partition offset and
> -                size defined in reg property of the dts. Frequently these
> -                values are the same, but may differ if device has bad
> -                eraseblocks on a flash.
> -              $ref: /schemas/types.yaml#/definitions/uint32
> +    $ref: partition.yaml#
> +
> +    properties:
> +      sercomm,scpart-id:
> +        description: Partition id in Sercomm partition map. Mtd parser
> +          uses this id to find a record in the partition map containing
> +          offset and size of the current partition. The values from
> +          partition map overrides partition offset and size defined in
> +          reg property of the dts. Frequently these values are the same,
> +          but may differ if device has bad eraseblocks on a flash.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> =20
>  required:
>    - "#address-cells"


Thanks,
Miqu=C3=A8l
