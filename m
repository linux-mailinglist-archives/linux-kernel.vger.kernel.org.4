Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8705460D16F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiJYQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiJYQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:16:41 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2117.outbound.protection.outlook.com [40.107.22.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB829364;
        Tue, 25 Oct 2022 09:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krc4KfSdPLOWOT4D8hlkR4jqruGD6rk4Jv9aAEU3c7ci9Q8GIGs3Cya98SCDWvW47X2eAh+tKvy4MzxUmA4bHxSXWPi5CClSyAi7THgGzEKqCg0VecyfbvvA/kICZ2hpj5xtyUrAmeConbJ45auyPJoV6rrkQVcnURVp5SLnYoX5l292CLeXA3VTg5yVqk5toUmfuZkcGeH4XQsGcsMFp/h/a3sA4F1yM9gO1JlOT9pROZICrTBqWVlV1OIIoz1Rc0LLnYw2Oi+NXt0UyzJPRexmMc+9J/ZxtBw+/oXyqLNTPJsM6QAv9MSndr2EAZ3rp9VJ0yD1zBqwQM2p6qwvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDJbxl6g3szXidNd2MDeRBOe2EHJWi0bR4CtmTYEmvY=;
 b=XpR/M3sf+dFgHfoaJuWFtaY9h94PVfD3eRMF+PPMn7J+DwIPUFwafKyaWcLzWL/W0JFUxyE5J0ZrBrt/vnOW3QjyqQ4fyBIQY2mPl7pYPGCmkt6lD0IRxIPWKy7D7eIKkqR5c8L/t2O5r8SppXIKeIvAB3c4o6txzDdNYigLPoETbKbi0ClinIyl6scmzIrDm68ROHmLhe2ytUVV/F8ly2TxwFG6kmHgwZPSBbNENOOtRsRnI/44KCC8SYAew0IbbG8qd1NY9HvsOOT9LFEtqGyrDslHdtLcyhw/XS9Kx35htg6pTwt69Bub9DfPz8F+A44WNo/xUhDcjjeOWov2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDJbxl6g3szXidNd2MDeRBOe2EHJWi0bR4CtmTYEmvY=;
 b=Yi6CBoUV0gZyhoT0z/TUrVoZLCbQgukT15w0q4D8itafQgHQFqAfDgpQorDUfyy6/FNJ+4BUd4ckpzl7LbKIVvbnjJ5BDU/88SMs3dlpty9EiOOPnyPk4NrWkt4ytF7vEUERdt2XApYmU7lcAHPjk/mZrYt3TQih5+fk1glSe3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1838.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:274::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 16:16:37 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2b03:a6ec:3529:b969%5]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 16:16:36 +0000
Date:   Tue, 25 Oct 2022 19:16:35 +0300
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
In-Reply-To: <0950c52f-4b53-a823-a30b-c68bc73671e1@linaro.org>
References: <20221025101713.11893-1-vadym.kochan@plvision.eu>
        <20221025101713.11893-2-vadym.kochan@plvision.eu>
        <a980821f-9177-8eb7-ee36-1b1e614d30fc@linaro.org>
        <VI1P190MB0317E39BD8D5531F94EB185C95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
        <0950c52f-4b53-a823-a30b-c68bc73671e1@linaro.org>
Content-Type: text/plain
X-ClientProxiedBy: AM5PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:206:1::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
Message-ID: <VI1P190MB031793A72ABE5A792EE9754195319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P190MB0317:EE_|PAXP190MB1838:EE_
X-MS-Office365-Filtering-Correlation-Id: c3685192-c3ce-4da1-2dc7-08dab6a44a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1Qiuug9WJYpLe+c64FSdoVoQuZSTLuH2osVFFOMDEl015tlRXBDR2ep5jmCGefpy1jp1RrdLgkb5RJZtTLqnd5b7tlF+5t6yBFN3tSAo/MWZri09Coojs4NE0GOxErqDDZAOGJniJbcR1UDOr3vzt5lHIs2TaWu/EAXniFLGvvU2oHNFAGCsA6pplLS7k3SP2fmBEcVfiY7jVS0SA1QIn6SqL3Frwntzry8uLM+OfpJKcdpwkaXLkd/HWrc56503saoEyHLMLiPfrgBeDp8ULdhHhbbj19ulW+pj4PPQqLPPk651cRZ/mrfzudVI+IpoNVG1Nst0Zhin6RUNdLJEibxjQsxhXyRiRNddacfjvLysqKkXrM2TZKYGR/bSqnYwV8T20HV8KddrQuecPfQUpkEGuPK88mhJ+JXya2kPEgEsUFqNyHaK6B8q4frKrwPITMhUCd7aZkLGtS4TFL9TMwsuasGsCdChF5wPmeURZ3RZK7KQYYIx+dvxxguhh3Ds+6nk9Auh4lzOIUF9ShlFe1Xx3VplunoM/KdfIuM/njZ+KIkR3a3ewdSSJ96LJL0A8Bs02n0eH9Cys0flOnyVc7N+uTVuX23kv5bVMxaDua3cYgqFWGrUxFG7dxz36owL5LW0d9Xn6Ur6SWdBTXAY41tI+W2X/UjpM3FTxrjDG3MkV8hWp3YafduQvkpm9FvrAwbMSMrF8bwNmJsEJ7PWfBV7WnMIOMI/BS37QZH9hYCn+/j39yLsuEeP+qiUb+8TVTDlTZkXeuVrRoY0ODk4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39840400004)(34036004)(396003)(366004)(451199015)(52116002)(53546011)(9686003)(7696005)(83380400001)(6506007)(26005)(186003)(7416002)(44832011)(41320700001)(55016003)(2906002)(110136005)(508600001)(54906003)(316002)(66946007)(66476007)(52536014)(5660300002)(8936002)(8676002)(41300700001)(4326008)(66556008)(86362001)(33656002)(38350700002)(921005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WdC8cNDPFBM7bpdFKJUqaH4conkGZB3HVVjIdl4VLk5YCHdOotgAuyONIc3x?=
 =?us-ascii?Q?EqcTikF2xY6l96zeAPP9YF0CuOmcrrQRuYys/BdEHaU1jJnI/x34RpfzsN/q?=
 =?us-ascii?Q?qr8OocI1O6xeqBJLFUjxfoAzmo5gMP5svKW+ad0Zyaqf4idql5hQSHenlcE2?=
 =?us-ascii?Q?EBVSEHu9/oon7Qa0V+qNRsIiQOnCPIDY/2HBEpKKm35ATnuvlrOqGTGvRYRA?=
 =?us-ascii?Q?+W4JW24VgOkW0NNqnG1LMuOuxOxn/LHJ3+He8ko0RLP59n7YQ3I/falG5ZJp?=
 =?us-ascii?Q?RQ40C7TJNN2lHyfepcWGxvhsqI8rftT2sjKUVbhKrUFcTeCSBqixFnjYQ/gk?=
 =?us-ascii?Q?ieXhlQZ/GTbFx8kSATj+UOcDNONrPQI2/NVwJrZk1xiWjjhwvGq63AUXuAxv?=
 =?us-ascii?Q?Ru+Pe29Hoe3IfobfsnA6OYfcN6p2X0N5rUVBQu00XHGK5Mvzk8xRtp1+V1su?=
 =?us-ascii?Q?c8la0h28J/xjeiUs5YyxuYalQe4gcE9OTPEHWp28AdycrLUfBIaeqClrd3+z?=
 =?us-ascii?Q?/r0dfZq3uB4VeJtIXQzquuDuNKhlM7+m2bJoNyZIx1GHbnUOrNWh/Aiag/jG?=
 =?us-ascii?Q?nNtDHgYXrVp7dCopHsrrJFtzJVK+96Dm6OW+wI+1PQq/hPymBKMpheBkzPxr?=
 =?us-ascii?Q?PNpVLVmO2vAAvcyhE0QQNJ3clxoQKWa6WTrrFQ/5Ts12ZQZCP81guocv0jpO?=
 =?us-ascii?Q?tqJkJYwtsu/3//ELCkcr/Q8n4Oc3UhdWjQbTlqv9AljzIfo7VG8iSpiV8IHK?=
 =?us-ascii?Q?sbDubOIsnEZrzenaCn/0dqMct4DqIGGgHA0qKlIkYkCvcTAzPcAxwTj2BjCT?=
 =?us-ascii?Q?v29UFhomQ6gIBX2OFBXJNtknpiGs24Os2u9kMy9whk8+Qn3ePTT4sPbBgYcH?=
 =?us-ascii?Q?D5nSjmYr4Us0DurKRTZKPRa0X/0+yZq7jOlbX7D0rcoG/7Nt+kt2eu2U2230?=
 =?us-ascii?Q?VdAGPOdt5ucnmeBAPHNhdxVFlQAmmOXeQFK4/33CDdTCOL/vFndsgItldoy6?=
 =?us-ascii?Q?r7lnq2qNzvzBvRFdNNl2v9qkmdKL84CWLpOfzqcDYirJ2Bk1TrP8vpr4LU6/?=
 =?us-ascii?Q?QeMQLMMweh97V+UzTNMsxVl4zqNQH9zGXTIkTvn+PVe6zRstQMgzQ5Rf9ili?=
 =?us-ascii?Q?msxbmx/6nb24dJ7B44L0Iv+BevIUggBX/WIGabOO+LHcU8M2+9ntIc7yYmVC?=
 =?us-ascii?Q?cGBhbqPwsUyW6bRtl+8xfUp8syFrTHwXCzIFgzWz2frBbe7Drj+6m/jb45Pl?=
 =?us-ascii?Q?9zZaMQOcpaUAwLoBg8Wx1Y/6hlYZfryzyB0jJ6FbloZqqZjHKaDDWCJaHJXi?=
 =?us-ascii?Q?N08HM8meXaaBe1IYAl649kx7t+o+tN+DoMwB9zNcqBbxzdJev39v+2zZnT9c?=
 =?us-ascii?Q?5LamLbpD7kWLb65Lsib8qk3vAwzV92PSIMiZNWWjpnzZSbvfVRBy6xqREaHp?=
 =?us-ascii?Q?M09NM3OnFScE8W9FHYvEA2sMM45LY5/p4akoFNlQfTIju8TA2vz+hU6T9IrU?=
 =?us-ascii?Q?vImpFcHPagNHyWGfzoyUJe7f0ijLRcWaYo0hpUyw8+Db0OJbUYaO+LdcLvJ/?=
 =?us-ascii?Q?2ygIy6PJFVvyFYXFYNn1J/VMlGLLiIFt3C1lGViJrZdvfz393i9SJyJG8UoQ?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3685192-c3ce-4da1-2dc7-08dab6a44a61
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 16:16:36.6839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jme/K18zmju6XXFR/YfT35d5BxmxV5YJZc+7ISbXe95SGdFx71LPHrpBcJhvlBRM/1wIg0fUrVI2dTUIsLg+UfZzpVKiJaEKEpbJuCIdJ7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1838
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 09:51:14 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> On 25/10/2022 08:52, Vadym Kochan wrote:
> > On Tue, 25 Oct 2022 08:25:01 -0400, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >> On 25/10/2022 06:17, Vadym Kochan wrote:
> >>> Switch the DT binding to a YAML schema to enable the DT validation.
> >>>
> >>> Dropped deprecated compatibles and properties described in txt file.
> >>>
> >>> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >>> ---
> >>>
> >>> v4:
> >>>    1) Remove "label" and "partitions" properties
> >>
> >> I think you did not read the feedback.
> >>
> >>
> >> (...)
> >>
> >>> +
> >>> +  marvell,system-controller:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: Syscon node that handles NAND controller related registers
> >>> +
> >>> +patternProperties:
> >>> +  "^nand@[0-3]$":
> >>> +    type: object
> >>> +    properties:
> >>> +      reg:
> >>> +        minimum: 0
> >>> +        maximum: 3
> >>> +
> >>> +      nand-rb:
> >>> +        minimum: 0
> >>> +        maximum: 1
> >>> +
> >>> +      nand-ecc-strength:
> >>> +        enum: [1, 4, 8]
> >>> +
> >>> +      nand-on-flash-bbt: true
> >>> +
> >>> +      nand-ecc-mode: true
> >>> +
> >>> +      nand-ecc-algo:
> >>> +        description: |
> >>> +          This property is essentially useful when not using hardware ECC.
> >>> +          Howerver, it may be added when using hardware ECC for clarification
> >>> +          but will be ignored by the driver because ECC mode is chosen depending
> >>> +          on the page size and the strength required by the NAND chip.
> >>> +          This value may be overwritten with nand-ecc-strength property.
> >>> +
> >>> +      nand-ecc-step-size:
> >>> +        description: |
> >>> +          Marvell's NAND flash controller does use fixed strength
> >>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
> >>> +          will shrink or grow in order to fit the required strength.
> >>> +          Step sizes are not completely random for all and follow certain
> >>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
> >>> +
> >>> +      marvell,nand-keep-config:
> >>> +        description: |
> >>> +          Orders the driver not to take the timings from the core and
> >>> +          leaving them completely untouched. Bootloader timings will then
> >>> +          be used.
> >>> +        $ref: /schemas/types.yaml#/definitions/flag
> >>> +
> >>> +      marvell,nand-enable-arbiter:
> >>> +        description: |
> >>> +          To enable the arbiter, all boards blindly used it,
> >>> +          this bit was set by the bootloader for many boards and even if
> >>> +          it is marked reserved in several datasheets, it might be needed to set
> >>> +          it (otherwise it is harmless) so whether or not this property is set,
> >>> +          the bit is selected by the driver.
> >>> +        $ref: /schemas/types.yaml#/definitions/flag
> >>> +        deprecated: true
> >>> +
> >>> +    required:
> >>> +      - reg
> >>> +      - nand-rb
> >>
> >> I have no clue why you are doing some random changes. Now you dropped
> >> additionalProperties for nand@ about which no one asked you to drop.
> >>
> >> No. It *must* be here.
> > 
> > Sorry for this mess, I was confused with the "label" and "partitions"
> > because I got errors about these properties when I used only
> > "additionalProperties: false", so I tried to put reference to partition.yaml.
> > 
> > Then I looked at other nand-controllers schemas and I did not find inclusion of partition.yaml
> > for them so I decided to just drop it at all. My understanding is that "additionalProperties:false"
> > is needed for nand@ if to have "label" and "partitions" properties, otherwise it is not needed.
> 
> A final schema (not used by other schemas) must always finish with
> additional/unevaluatedProperties false. You have errors since beginning
> - I wrote about it in your first patchset (v1). You had error visible
> after adding proper unevaluatedProperties in proper place.
> 
> You have partitions node, for partitions. But you reference only *one*
> partition.

Yes, sorry for that.

OK, I think I need to do this in nand@:

      ...
            
      label:
        $ref: /schemas/types.yaml#/definitions/string

      partitions:
        type: object

      ...
      
    additionalProperties: false

So the "partitions" will be validated for example by fixed-partitions.yaml.
And additionalProperties:false in the nand@ protects from adding other
non-valid properties on it's hierarchy level since all possible
properties in nand@ are covered.

> 
> Best regards,
> Krzysztof
> 
