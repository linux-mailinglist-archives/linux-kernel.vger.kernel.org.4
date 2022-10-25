Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F7160CCC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiJYM5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbiJYM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:56:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2115.outbound.protection.outlook.com [40.107.104.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C15B1ACAA8;
        Tue, 25 Oct 2022 05:52:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvUO/Pcj1BjGqP0GQgjrsqo4QwYbS6WZTdJY4BGU7hpTwOJLC+za/fiy5WL8Df0B463c3r0AkU5313zxxYGcGoPeInPZICKzgj8dyTNx5w0nnOMt++RSVGQHED+EDTiUS2zRsvhiTKJqULHR+91ejF84/K86UfQBFyesEPh7a1/z/B55TCecM9Kl+Msutjv69C9wKmappRjtuyRpWFV8q/F8xemZvayz1KDqF7aIAKPf0DBJZq5Pq+6n++OwvCIJaBPfVydy0TwoPFs4mv+1tYDKjcAXtQKUwDIBa4kG61f9nISNJTw25mXof7MmVj0v+DtqanmWM3lMFmVLyqy49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoSF+MQgoTv28BWW2+K87scOuGbGQbOV3v45q8t+ptI=;
 b=jvwRUGINQb/ndocFf4nyRV/7MLu9yP/lz3uW2Ilo6/XrkkvHKg3rynqtz79OBhkvh3C1n2SlMLAQz2/jpCzCPBNA3cb5L+EDn6J+FpepVdeuhQa031pJE1QjsdjsSQE/8hAMWK1AuN2JrGlyowGlu5Jjxc+NbCAJ8Fk8J1TDbadSItT9T4lgizUrc+f5wNv7Yuq4Uv/dB1ssSNWQxMaZjme7ZoRwYC60ANqvWRsBg8EesoHQiJ9Ayh5jjj2jvrg7uuBy9hQhmgEz1wuEu2v6DLHQgafZ1nzshiGtDw4cAtKwWP/J+cfvXeLMIUUAk4OL8jqoUrCcS11lNHgPVdP0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoSF+MQgoTv28BWW2+K87scOuGbGQbOV3v45q8t+ptI=;
 b=V26GcdYxHbCrngifFzawCd6OK2fs+XXUJbJWrKved/9Fbj//pRcJy+/y63Qb7UhMyDNBJ17y8apf8BC1nazbsLzRkgm9BiA1FsFqFKfDLmEiVhR7OQMKPXxWGxe0HWQZatI68tEzrTYIyUBbLsg80XcZchVJpfpIgEBj/RzILY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AS1P190MB1725.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4ad::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 25 Oct
 2022 12:52:34 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 12:52:34 +0000
Date:   Tue, 25 Oct 2022 15:52:32 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
Subject: Re: [PATCH v4 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <a980821f-9177-8eb7-ee36-1b1e614d30fc@linaro.org>
References: <20221025101713.11893-1-vadym.kochan@plvision.eu>
        <20221025101713.11893-2-vadym.kochan@plvision.eu>
        <a980821f-9177-8eb7-ee36-1b1e614d30fc@linaro.org>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB0317E39BD8D5531F94EB185C95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|AS1P190MB1725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f740423-ffe3-4830-6856-08dab687c93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nAIWgGS6+HqubhdQ/Nn8PKi4FJL8fYmIqTNySN8ILRnwTLCiV8JROlkwZ9PYkHM3nNw4tKx42+xHC24f5de0imBLL2J3kDGWNQ9HKui5ELxYCrdES1WxDTrd7k8DpwKL30OJ8loX0WhTryoHZTUFQyYoFlaizwFZ7W4AbvOKDqGp02GqdQ1nxW/U5I/8tEqwUk4yXnPD+oSexY7BERDWWtRZhjDyEc+cT3TSDq9KPLJV7IewWWa7gZilvLhy6OMwlHfeYwCdOumHFdiUuv7dZV5XIht5DHFd09B8dyyQZmXYoFN13ckYLZiVg4DzPtoyHB8brIxhYe6GBCnSRswrx5zY8v51PD2S9U6uUF9983uRT84xzRK/FKjh+6GFl57s4V65mIcgN1pIOf8kVpQ7B8uHVy5f/ZbSgAjeQfSyDyoFoWaoqi3QB1O/3ZGXBJmEpEAxqccn9IDTxefkOyi2RUUZ3d1BJgURFxgDruPAxyiPB6r/Kc1kLn9hrLAE4tsPTCVfLoFtnpb+SAehC4PIkr1LYO1NNEbOfdPKU7XDzimT0P5/q6Vw1LpzwJZ7aqDyLTuKwppMfWmkTfJcKUJvAns8/8Q16wvXZnhLXAl8aw5+iGpQcr3S+zlNlbH7d5Dc9WUkzYj8dKQYiPB3rPSAdoqGlxRhlERmbMwxh+GA72PWon3fc6rW3HnjGyv64XmaZ2ax9LinEqP5WSmQJeQ++uJ6D9Ce1g7BJLfmlIY5o3RTrLIdXCg2wKDf61o+O2eET27aTn/Rb33t7SGuynA4SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(34036004)(346002)(39840400004)(366004)(136003)(376002)(451199015)(38100700002)(38350700002)(186003)(2906002)(921005)(33656002)(508600001)(44832011)(52116002)(66476007)(8676002)(83380400001)(41300700001)(66946007)(4326008)(66556008)(86362001)(9686003)(6506007)(26005)(7696005)(53546011)(8936002)(316002)(110136005)(7416002)(54906003)(41320700001)(5660300002)(55016003)(52536014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4914nMVfcJVUZC5EanCXMG162GezQxCeNBW2XU7zmtiihzIWAB1q3b4W4ap?=
 =?us-ascii?Q?TdRf3rbOVZIG08akY7f3HkvFc2yoA7EZUHoU4snl4R2PDeQvdz38w3Aq5PZJ?=
 =?us-ascii?Q?e6pclvLPthhwpAas6uUbB+kqwRKuEPqHYhYD4598iv7Eqjm49dAhqEoEjU7Z?=
 =?us-ascii?Q?++JCka1Z0zoTG1p/Sva1CN4Pdx+4u6feuDjufxPRrHgZR7y48a3AEJIBDgXj?=
 =?us-ascii?Q?R6ZydhlYB2nW9UBZ66s13tJpKBSJQ0szCZvLcivGj2tSt/DPZ4Y1NLWIwy7m?=
 =?us-ascii?Q?li6q9mzqUIaww0eycioIhGM8VUTGcFQP7qEl7iwl4qW31SLR9IqhTFZz5Yau?=
 =?us-ascii?Q?IrPeXoRHJTtrTHpDqAdaXmy23GUFHvvYidiuQY6Rh8mB8KrdQbdY4Zyrxh6u?=
 =?us-ascii?Q?PIKTHxq37D9R3dsmQ0f3NyXhLFWFlmDdrfjMeWdqUJQzrr437P6ogiKortAW?=
 =?us-ascii?Q?ze3ZnTdICmph93p0H6kyCS2hz2lSMygoESqvcGmFDJsSOCgCv8ZHi3uBz+0j?=
 =?us-ascii?Q?e7ylpUIuIC9VGgu0RNtJe2rC1uHVjbJjsz1mGBUezw5Kweq5pjGYGyhIvRqN?=
 =?us-ascii?Q?XKXp3RPtKj4UySYSq1/mmL5TNNnhkkFwQhbCe7pZMHonPBA1EFbgTDP9b2lG?=
 =?us-ascii?Q?mzxJlRIMQDYXIgS4c3zz0dpLd3AW4jr/sXVoTiDXSOYrPONiquLxsGmurylW?=
 =?us-ascii?Q?5SYl7a48cUCVo7S6BF+EQa9H5MSlPB0tGzQz+HOI7xVvt8lHvMuuCMgfcIHo?=
 =?us-ascii?Q?p4rfCHQCke1ktORfArwMNzcNt6cdiNH6s2BWBlff7SQ5ak0OJI3E2cDBUPvI?=
 =?us-ascii?Q?Xpt75Z7/PCntD3o9Fg96f96lO8J4ZMia73FNaMAEgzReOPCabst/nbxA7E2F?=
 =?us-ascii?Q?x4itTG/zJodMG5gmF5fCsUHEXWRQeHhUjaMihmGRyZ5GI4h3ZdHswzZceHuI?=
 =?us-ascii?Q?uQ/nyS0bVJsbo4jaCg0wIAuaeNGvB+zheGyRXdc6num4S8DLZF8qWyLHXoB8?=
 =?us-ascii?Q?EipFB+XZTja4Xjpk3wr0K/6/96UpBw9IVOYF6HnHa3j1rWFSuyOEAwmGBL/D?=
 =?us-ascii?Q?DWk2szlY8GAHsHiSbm+w7VdbRN9/OL83HSjgG1Hgnggm6hOVovHQ/nJAivoc?=
 =?us-ascii?Q?UqYz3PV9iiB08Y/XSOPIbGT0tX6VOBch29tTBySNzj6fBVrloedrK8XJgNxu?=
 =?us-ascii?Q?lV8/SRCiVDfNe+QwXHoJubx4rnzyZZyv2JkdEvfxkBM9DJ9sZgEYpEWm8/Yk?=
 =?us-ascii?Q?E+ldJ8lSyPTJxde48c1UdEpAhjeD3soqmdXU7kCjylv+tltdCT4BNW4jELzw?=
 =?us-ascii?Q?KxRc2fN1gV7emGIi7o0yap/1d0IMUVQgmjC04T7kj8AzBkFFqCmrYm+X/1/o?=
 =?us-ascii?Q?ANirR2LklwwzSSkNY/Zr1U5OQVd5R6FHoOiTsK6PLwkIwcmFwVkd8sA9hl7o?=
 =?us-ascii?Q?UJgAiEg3jQ22StY3yUAYdAXPt2b3pdbDvAoPyYz5IkrI57P3F5M2pdgpCqqn?=
 =?us-ascii?Q?qYREQc/mdLZTAUtcVLBvbZPMDnI45KCc3tTZ0er9ZtMN68xGxAqUQy4lIsjB?=
 =?us-ascii?Q?m30voiqwXAzlLKzl9XKARQGO23TOBWGpMLVZd6ilLQGjrfV0Y2DNNYhS6/yb?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f740423-ffe3-4830-6856-08dab687c93e
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 12:52:34.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G077uKCh0if43lOrkd+vvIYrBkgZ/Nb939s0LkQ3n7aHGXvYoKlwImH4il5m0+XH+fF19MZpx05fdt6NVDdbJWFhuP9t/TL3enpEAFscbTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1725
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 08:25:01 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 25/10/2022 06:17, Vadym Kochan wrote:
> > Switch the DT binding to a YAML schema to enable the DT validation.
> > 
> > Dropped deprecated compatibles and properties described in txt file.
> > 
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> > 
> > v4:
> >    1) Remove "label" and "partitions" properties
> 
> I think you did not read the feedback.
> 
> 
> (...)
> 
> > +
> > +  marvell,system-controller:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: Syscon node that handles NAND controller related registers
> > +
> > +patternProperties:
> > +  "^nand@[0-3]$":
> > +    type: object
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 3
> > +
> > +      nand-rb:
> > +        minimum: 0
> > +        maximum: 1
> > +
> > +      nand-ecc-strength:
> > +        enum: [1, 4, 8]
> > +
> > +      nand-on-flash-bbt: true
> > +
> > +      nand-ecc-mode: true
> > +
> > +      nand-ecc-algo:
> > +        description: |
> > +          This property is essentially useful when not using hardware ECC.
> > +          Howerver, it may be added when using hardware ECC for clarification
> > +          but will be ignored by the driver because ECC mode is chosen depending
> > +          on the page size and the strength required by the NAND chip.
> > +          This value may be overwritten with nand-ecc-strength property.
> > +
> > +      nand-ecc-step-size:
> > +        description: |
> > +          Marvell's NAND flash controller does use fixed strength
> > +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
> > +          will shrink or grow in order to fit the required strength.
> > +          Step sizes are not completely random for all and follow certain
> > +          patterns described in AN-379, "Marvell SoC NFC ECC".
> > +
> > +      marvell,nand-keep-config:
> > +        description: |
> > +          Orders the driver not to take the timings from the core and
> > +          leaving them completely untouched. Bootloader timings will then
> > +          be used.
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +
> > +      marvell,nand-enable-arbiter:
> > +        description: |
> > +          To enable the arbiter, all boards blindly used it,
> > +          this bit was set by the bootloader for many boards and even if
> > +          it is marked reserved in several datasheets, it might be needed to set
> > +          it (otherwise it is harmless) so whether or not this property is set,
> > +          the bit is selected by the driver.
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        deprecated: true
> > +
> > +    required:
> > +      - reg
> > +      - nand-rb
> 
> I have no clue why you are doing some random changes. Now you dropped
> additionalProperties for nand@ about which no one asked you to drop.
> 
> No. It *must* be here.

Sorry for this mess, I was confused with the "label" and "partitions"
because I got errors about these properties when I used only
"additionalProperties: false", so I tried to put reference to partition.yaml.

Then I looked at other nand-controllers schemas and I did not find inclusion of partition.yaml
for them so I decided to just drop it at all. My understanding is that "additionalProperties:false"
is needed for nand@ if to have "label" and "partitions" properties, otherwise it is not needed.

> 
> Best regards,
> Krzysztof
> 
