Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD56AA88B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 08:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCDH2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 02:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDH2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 02:28:50 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2071.outbound.protection.outlook.com [40.107.103.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ABE199EF;
        Fri,  3 Mar 2023 23:28:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9Jnlau9dTM3c/AYB06IUp0OtLhm1XMyImrx9ZaGUG3RZyC0TqYv+W/QFfJTZNgaeBFmX2Q7XI8CuAw039gW365312I87COV3kyaqaZI/HZJwngfpcBa0d75FVj+6+G7AcN6WJUodTtjYHSkxGqUndSNdT+UFNaWRHDm0nlvegBY8RDvr+G8rrBLMmo5zSZGSzgL/CX8iHAFWH5/lX5+hsxLK1zFe2ZNIcIr3f1s26Htj0YjILJ3SA2JSfwiH7hkl/UtqxiH/ZzkA+A7d4bGt1Gtf86OcDCxZFRAhaCvD5+z4Kyhrp/YSiLYGWsPfM+1HjYL5s/R445dQLVklm7y/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWZ8+1Asxijua8du89ykVMAtpbQ/xnxUrDRsCV7Z/PM=;
 b=iTFTHauXde6ZUc3wnmrMzDvprRhkfUBnZIw44WxPfWkBMTd304R8o506CXgHXU8w6BM+fWHcMfOSPQfsjaTbJTob+0rtHkAmgn72aNCbFhVm4j2mRoos8CTfn7YI78gPRQLdq4Ph2iMQayApGkPyU/xcZqIkjnrJxzxpeLFG00REqY3TAkbH8/ekxQeUf1B2AHHWJgt6pQDdVM8yqVQDl/QykBVeLSLTZmFaX8wu+4GTiShhFihVyH6WUmQ0CPxL13lAippqzyfy8QAUtnUS2NpTGY9ZtUg0kEtQVPRwixQY9mZXZyBbTpbMHaR+dQD5R/l4FsjS1WjP6iEndMm/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWZ8+1Asxijua8du89ykVMAtpbQ/xnxUrDRsCV7Z/PM=;
 b=BRBGV7A5/9bqhXdq08Umjn5jc8LOgWoOxgpevex8RPdFkTNw2hqdODNlVnvaQl3qc5OiIgt8dEvqS5FnEh4kg4Z3gwU34jlcfeyeX4vt+omL5hDf1ym0S5254HLnB95KkX5l0B/rvyhD+GWz+bzhpaAjOfVVcUS4o2lHxib9bqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7252.eurprd04.prod.outlook.com (2603:10a6:20b:1da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Sat, 4 Mar
 2023 07:28:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6156.022; Sat, 4 Mar 2023
 07:28:40 +0000
Message-ID: <d4c76900-1985-428b-4050-26fd4a0daaf8@oss.nxp.com>
Date:   Sat, 4 Mar 2023 15:28:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] dt-bindings: crypto: fsl,sec-v4.0: Convert to DT schema
To:     Rob Herring <robh@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220213334.353779-1-robh@kernel.org>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <20230220213334.353779-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 96122481-bd3b-4813-2084-08db1c821345
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pPWjRmYPthD8qoOtpgbznwsdxGmMHKJEGy5UF7Yb1WTdDmB9T8RAjikwW3Sp8r96cJAURa1TpifufNQEi3QMRX6DaEKD/e3f2OxyewFsKJMVvR3gzQ4kjPLUEZd6rBguFFJqGPBhrlko9uTVqf+xw0RrbZHPCvQGdLBQ5a2i62PGb4RncpGJPD2HcK4sQWATyn4SqPeTIrfZp43JgcectxUj5WKPvAJJxU1/SisBtXxKUPqXp+FT5jIj3j1Ab5i5lVj/SAtM6paszOPdbffOAfRDGgSVGHDxKnfmmKXKwxVOX9xva0R2R+cVQglpyvzIvmhXOdpggBZqb25aCLktLU0gEBnOeh24NOhnempfczedJ1Qk5/r5ucVqp0jwgmR5kzXIazuPwRPFkVhkEXf9nYJh0QQIyRV4ZbMePoX6tdi7lPyxWEgqGcBTQP1dyVEfeQ3RGxQuDegfl3do6LHYOObjvuhMQ9uP7tbY3p2+El/jh96gL3NTwRNJz0jzwn4UDdYjVj6U/qY7xhHS214obqO/LhTt9Yz2PxpZZwhDx25nPQNzujwODHY+QZBYbO3G1IXXwMjHL+CivrEIG5/PGCqy5XoSCM6vg1gOwEvRAnWGglSYp9KSCwnZRaEZ8UQ/yOpl24iR1qRmvDZUtT9BBIJw2Ge6u/H044j1GDjzEG3H+2NApj30QhGjxySZ9WrFYcHbHJVtIXbrcgwOLLm2pdlXIFwEh0JElAHFfHUDTbpb+TpCRWjKjYqc/i8qXY04BYrbu/d/YQdL38NDGE4gBeqNuM9a8l/Npnz3OEEVbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199018)(186003)(38100700002)(38350700002)(26005)(2906002)(2616005)(6506007)(53546011)(6512007)(31686004)(30864003)(44832011)(5660300002)(8936002)(6666004)(41300700001)(316002)(966005)(6486002)(66476007)(86362001)(31696002)(8676002)(66556008)(66946007)(4326008)(83380400001)(52116002)(478600001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0dXdWRnOS8xSHdnRHdPaWVvVTJTcklNelFneFdYampWYTQ0OUlWOHRmQjRr?=
 =?utf-8?B?aEJzLzFsSjFTcW1zTTZCYzlPR3lYcHNlQjlRV0xQT0xXTXQyck9yMXhmZzd3?=
 =?utf-8?B?THhRbDdIUy9LMWpsL2g2ckFlUWQvVmRhWjIvdWNOWklLTWtkalgzZ2hoSktL?=
 =?utf-8?B?bVI2R0ZyNlpnT1BUUFVWTExLajc4Z0dua2hTV0RVaHU3ejhLc1VNTllTZjVZ?=
 =?utf-8?B?NkxkcjIzUTBYT1kxdktNbVBTQyswcXVpT0hOdDVYV3J4SUlMZ1RDY0tITFVM?=
 =?utf-8?B?QTVvdSs2UDFXbjF3S3RLZW5neHBGRmRyNE0wd3JFd0gxV21OVGFuK2kwRGRi?=
 =?utf-8?B?dTIweEJ1N0JxWG9sYzRLT0lBcVpIUlJmRGlaYVMvNWFiVFpoU3ZwUWJ3SzFp?=
 =?utf-8?B?TGpZbGwzQzR5Z2FOcXMwWGU1dzR0L21ubGxZeDJBNHIrZFRNU2RLbm9DSVcv?=
 =?utf-8?B?ektkdlA2enJIbGZVMmR2ME9WZDVQQVNpdUdOTUdqN3pBQXpVVkVFZlk2c1lz?=
 =?utf-8?B?Zno2cHlHdkt3cklFZXRZdHFYbWlEVTVsQnRuZmJ2bHpMc2VvVy9ZZjI2dkJx?=
 =?utf-8?B?V3BwVzlKR2pzcGdvZEg3L0xUOXBCbGZNTHZES3JRVVZMZldXR3FTSnZNMXBs?=
 =?utf-8?B?ZUV0cDBObklFVjFFdHRXT0RKa2tIRkhIRkZzUGRjeG5jcVZ0OE82UndCbWJY?=
 =?utf-8?B?MDdTTzQrWlpiSGlHZWVXQm94UUF6VnB0b2RrZkMyY2VETGMwWldOYnRQOWhv?=
 =?utf-8?B?eGRTK012dENIbjUwOXVhOUhkN1BnaEoxTzJvRnVmclZmblZwRGk2TDVQMzdn?=
 =?utf-8?B?ejdYeDhyZlN2WjcwRmxjTUlYdmhGQzRiY1BERWxIUHU1VEY0ZHFPM2t2QzNT?=
 =?utf-8?B?TVMzUG5zSHhnaFNmWHh6MkxqcUxweitPSkZ2dmE5NU5EdEhaUkZZc3NTbXdT?=
 =?utf-8?B?a1JXd2crS1phaVl5ckU2NFZCNHBKOWRrRmRhSFcwTWRMTlcyMEIwZlhObkJV?=
 =?utf-8?B?SFRYcUkwMWUzM281dDBub2ZNcHVjcEs5MGFTdDI3UkJSbHFWOUtkMDlhUnBS?=
 =?utf-8?B?OWZYL1BaQU5oTDA5UmlGUjRCU3dlMnRPa1NaMlFBa05SSk1QVHB4aEhkU0Ir?=
 =?utf-8?B?WnlJUU16cDRMOTdJT01NQWh1U3QvNnlkUWtQQzZHbFRPdzVVQU1WQldGSGNl?=
 =?utf-8?B?TjlZTENzc3hYYnZ2RlNITUFzUTd6UHlJTnMzZTdjRVFyNXVDRlRZRkRVU1J1?=
 =?utf-8?B?RDdDTDNrUndQRmU5UEl4UC94MDNrbVFKcHE2WDRkYmk2b2tVMmRlUW95cU5C?=
 =?utf-8?B?T0NwYUxqQ0ZlSGkvUDR2cTA4TTR0eTV6aDlZY0ZMVHRQa2tobkxVeTZCdk1q?=
 =?utf-8?B?YmltTWxBRVBIOFRSM2N1RjRyUmVneWtPNTNOVmlnWVhxNDRQZXJFNGpnTVpR?=
 =?utf-8?B?NFViQ2Q2UjI1WjBtQVR4QThwMTQ4UTJvOFJmemxQYnhpQnRZa3Q4SGdLMUph?=
 =?utf-8?B?ZTdkN2FkV296MWNLRktubGhFN0p1anI4UzJxNXlESlNjM0V1eU1rUktIRDJo?=
 =?utf-8?B?YW0zSkxCMkFQNVF0QUFvZ3JTaVVTRTlCQTV2TE9KempZNmdjcnFBeCtaNWVS?=
 =?utf-8?B?SWFOUmVhejVQbGRKQXhWTWZuQ0k1Sy9lQS9SNmgzUTdJUlI3bEt6WmJmNlhI?=
 =?utf-8?B?bXMrQjVPMDU5dzBHYjZjbTlwSGVrcUwwUU1temFTQ1NMNURESnJiTEJMWkR0?=
 =?utf-8?B?TW9iK0JWRTVoMlJOUkxZc3hXdkdZM2lNWlZzNkk0TmdKVGd2OHhCVjJGTU1P?=
 =?utf-8?B?aEVZaDRXSk9LSi9pQ3ppNC9rZWVxN1o3ci9iQ015bDg4aHpnT0dpTERRUm9V?=
 =?utf-8?B?MGs1czVNTHB2c25aelpBTkpMakR4WS84UVZwK1dpd05xSFZISXFYUUYvNzF6?=
 =?utf-8?B?K1YzWndCd0pGZ2c5U3UyNEpwdXVMNWg2TkdtRVNpUlh6OU4wSGdncGhvTmFR?=
 =?utf-8?B?K2pXVWtOQ0dXYXluTzc2VnlkVU1HZ2paZFRsazBvOXgxNlV5VWxhSExYOUpS?=
 =?utf-8?B?QitSR1orOWlWRDhSc0p2SG5KaG1BRmJ0TWd4Uis2aU12M1g0SGdTYlRkaVgz?=
 =?utf-8?Q?mTPteIwIVue6npBkVdIRqteAQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96122481-bd3b-4813-2084-08db1c821345
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 07:28:40.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lazQOxlLqycZzhaCGR4hh/frEbSZGTFHOOF8vdUbCAK0CK5I+/6o+rqc/zY8LPPc+piNz59tKzNSB2q3XEJ8EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7252
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/21/2023 5:33 AM, Rob Herring wrote:
> Convert Freescale CAAM/SEC4 binding to DT schema format. The
> 'fsl,sec-v4.0' and 'fsl,sec-v4.0-mon' parts are independent, so split
> them into separate schema files.
> 
> Add a bunch of missing compatibles for v5.0, v5.4, etc. Drop unused
> 'ranges', '#address-cells', and '#size-cells' from fsl,sec-v4.0-mon nodes.
> 
> There's one DTB warning for LS1012a which has a 2nd 'reg' entry for
> 'fsl,sec-v4.0-rtic'. Leaving that as there is no clue as to what it is for.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> ---
>   .../bindings/crypto/fsl,sec-v4.0-mon.yaml     | 150 +++++
>   .../bindings/crypto/fsl,sec-v4.0.yaml         | 266 +++++++++
>   .../devicetree/bindings/crypto/fsl-sec4.txt   | 553 ------------------
>   3 files changed, 416 insertions(+), 553 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
>   create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
>   delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> new file mode 100644
> index 000000000000..353d9140dcea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2008-2011 Freescale Semiconductor Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0-mon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale Secure Non-Volatile Storage (SNVS)
> +
> +maintainers:
> +  - '"Horia Geantă" <horia.geanta@nxp.com>'
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +  - Gaurav Jain <gaurav.jain@nxp.com>
> +
> +description:
> +  Node defines address range and the associated interrupt for the SNVS function.
> +  This function monitors security state information & reports security
> +  violations. This also included rtc, system power off and ON/OFF key.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,sec-v4.0-mon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: fsl,sec-v5.0-mon
> +          - const: fsl,sec-v4.0-mon
> +      - items:
> +          - enum:
> +              - fsl,sec-v5.3-mon
> +              - fsl,sec-v5.4-mon
> +          - const: fsl,sec-v5.0-mon
> +          - const: fsl,sec-v4.0-mon
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  snvs-rtc-lp:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
> +
> +    properties:
> +      compatible:
> +        const: fsl,sec-v4.0-mon-rtc-lp
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: snvs-rtc
> +
> +      interrupts:
> +        # VFxxx has only one. What is the 2nd one?
> +        minItems: 1
> +        maxItems: 2
> +
> +      regmap:
> +        description: Parent node containing registers
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      offset:
> +        description: LP register offset
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 0x34
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - regmap
> +
> +  snvs-powerkey:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      The snvs-pwrkey is designed to enable POWER key function which controlled
> +      by SNVS ONOFF, the driver can report the status of POWER key and wakeup
> +      system if pressed after system suspend.
> +
> +    properties:
> +      compatible:
> +        const: fsl,sec-v4.0-pwrkey
> +
> +      clocks:
> +        maxItems: 1
> +
> +      clock-names:
> +        const: snvs-pwrkey
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      regmap:
> +        description: Parent node containing registers
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      wakeup-source: true
> +
> +      linux,keycode:
> +        default: 116
> +
> +    required:
> +      - compatible
> +      - interrupts
> +      - regmap
> +
> +  snvs-lpgpr:
> +    $ref: /schemas/nvmem/snvs-lpgpr.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx7d-clock.h>
> +
> +    sec_mon: sec-mon@314000 {
> +        compatible = "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
> +        reg = <0x314000 0x1000>;
> +
> +        snvs-rtc-lp {
> +            compatible = "fsl,sec-v4.0-mon-rtc-lp";
> +            regmap = <&sec_mon>;
> +            offset = <0x34>;
> +            clocks = <&clks IMX7D_SNVS_CLK>;
> +            clock-names = "snvs-rtc";
> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +
> +        snvs-powerkey {
> +            compatible = "fsl,sec-v4.0-pwrkey";
> +            regmap = <&sec_mon>;
> +            clocks = <&clks IMX7D_SNVS_CLK>;
> +            clock-names = "snvs-pwrkey";
> +            interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +            linux,keycode = <116>; /* KEY_POWER */
> +            wakeup-source;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
> new file mode 100644
> index 000000000000..0a9ed2848b7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
> @@ -0,0 +1,266 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2008-2011 Freescale Semiconductor Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/fsl,sec-v4.0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale SEC 4
> +
> +maintainers:
> +  - '"Horia Geantă" <horia.geanta@nxp.com>'
> +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> +  - Gaurav Jain <gaurav.jain@nxp.com>
> +
> +description: |
> +  NOTE: the SEC 4 is also known as Freescale's Cryptographic Accelerator
> +  Accelerator and Assurance Module (CAAM).
> +
> +  SEC 4 h/w can process requests from 2 types of sources.
> +  1. DPAA Queue Interface (HW interface between Queue Manager & SEC 4).
> +  2. Job Rings (HW interface between cores & SEC 4 registers).
> +
> +  High Speed Data Path Configuration:
> +
> +  HW interface between QM & SEC 4 and also BM & SEC 4, on DPAA-enabled parts
> +  such as the P4080.  The number of simultaneous dequeues the QI can make is
> +  equal to the number of Descriptor Controller (DECO) engines in a particular
> +  SEC version.  E.g., the SEC 4.0 in the P4080 has 5 DECOs and can thus
> +  dequeue from 5 subportals simultaneously.
> +
> +  Job Ring Data Path Configuration:
> +
> +  Each JR is located on a separate 4k page, they may (or may not) be made visible
> +  in the memory partition devoted to a particular core.  The P4080 has 4 JRs, so
> +  up to 4 JRs can be configured; and all 4 JRs process requests in parallel.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,sec-v5.4
> +          - const: fsl,sec-v5.0
> +          - const: fsl,sec-v4.0
> +      - items:
> +          - enum:
> +              - fsl,imx6ul-caam
> +              - fsl,sec-v5.0
> +          - const: fsl,sec-v4.0
> +      - const: fsl,sec-v4.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    enum: [1, 2]
> +
> +  '#size-cells':
> +    enum: [1, 2]
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      enum: [mem, aclk, ipg, emi_slow]
> +
> +  dma-coherent: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,sec-era:
> +    description: Defines the 'ERA' of the SEC device.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +patternProperties:
> +  '^jr@[0-9a-f]+$':
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Job Ring (JR) Node. Defines data processing interface to SEC 4 across the
> +      peripheral bus for purposes of processing cryptographic descriptors. The
> +      specified address range can be made visible to one (or more) cores. The
> +      interrupt defined for this node is controlled within the address range of
> +      this node.
> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - const: fsl,sec-v5.4-job-ring
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
> +          - items:
> +              - const: fsl,sec-v5.0-job-ring
> +              - const: fsl,sec-v4.0-job-ring
> +          - const: fsl,sec-v4.0-job-ring
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      fsl,liodn:
> +        description:
> +          Specifies the LIODN to be used in conjunction with the ppid-to-liodn
> +          table that specifies the PPID to LIODN mapping. Needed if the PAMU is
> +          used.  Value is a 12 bit value where value is a LIODN ID for this JR.
> +          This property is normally set by boot firmware.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 0xfff
> +
> +  '^rtic@[0-9a-f]+$':
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Run Time Integrity Check (RTIC) Node. Defines a register space that
> +      contains up to 5 sets of addresses and their lengths (sizes) that will be
> +      checked at run time.  After an initial hash result is calculated, these
> +      addresses are checked by HW to monitor any change.  If any memory is
> +      modified, a Security Violation is triggered (see SNVS definition).
> +
> +    properties:
> +      compatible:
> +        oneOf:
> +          - items:
> +              - const: fsl,sec-v5.4-rtic
> +              - const: fsl,sec-v5.0-rtic
> +              - const: fsl,sec-v4.0-rtic
> +          - const: fsl,sec-v4.0-rtic
> +
> +      reg:
> +        maxItems: 1
> +
> +      ranges:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 1
> +
> +    patternProperties:
> +      '^rtic-[a-z]@[0-9a-f]+$':
> +        type: object
> +        additionalProperties: false
> +        description:
> +          Run Time Integrity Check (RTIC) Memory Node defines individual RTIC
> +          memory regions that are used to perform run-time integrity check of
> +          memory areas that should not modified. The node defines a register
> +          that contains the memory address & length (combined) and a second
> +          register that contains the hash result in big endian format.
> +
> +        properties:
> +          compatible:
> +            oneOf:
> +              - items:
> +                  - const: fsl,sec-v5.4-rtic-memory
> +                  - const: fsl,sec-v5.0-rtic-memory
> +                  - const: fsl,sec-v4.0-rtic-memory
> +              - const: fsl,sec-v4.0-rtic-memory
> +
> +          reg:
> +            items:
> +              - description: RTIC memory address
> +              - description: RTIC hash result
> +
> +          fsl,liodn:
> +            description:
> +              Specifies the LIODN to be used in conjunction with the
> +              ppid-to-liodn table that specifies the PPID to LIODN mapping.
> +              Needed if the PAMU is used.  Value is a 12 bit value where value
> +              is a LIODN ID for this JR. This property is normally set by boot
> +              firmware.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            maximum: 0xfff
> +
> +          fsl,rtic-region:
> +            description:
> +              Specifies the HW address (36 bit address) for this region
> +              followed by the length of the HW partition to be checked;
> +              the address is represented as a 64 bit quantity followed
> +              by a 32 bit length.
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    crypto@300000 {
> +        compatible = "fsl,sec-v4.0";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x300000 0x10000>;
> +        ranges = <0 0x300000 0x10000>;
> +        interrupts = <92 2>;
> +
> +        jr@1000 {
> +            compatible = "fsl,sec-v4.0-job-ring";
> +            reg = <0x1000 0x1000>;
> +            interrupts = <88 2>;
> +        };
> +
> +        jr@2000 {
> +            compatible = "fsl,sec-v4.0-job-ring";
> +            reg = <0x2000 0x1000>;
> +            interrupts = <89 2>;
> +        };
> +
> +        jr@3000 {
> +            compatible = "fsl,sec-v4.0-job-ring";
> +            reg = <0x3000 0x1000>;
> +            interrupts = <90 2>;
> +        };
> +
> +        jr@4000 {
> +            compatible = "fsl,sec-v4.0-job-ring";
> +            reg = <0x4000 0x1000>;
> +            interrupts = <91 2>;
> +        };
> +
> +        rtic@6000 {
> +            compatible = "fsl,sec-v4.0-rtic";
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            reg = <0x6000 0x100>;
> +            ranges = <0x0 0x6100 0xe00>;
> +
> +            rtic-a@0 {
> +                compatible = "fsl,sec-v4.0-rtic-memory";
> +                reg = <0x00 0x20>, <0x100 0x80>;
> +            };
> +
> +            rtic-b@20 {
> +                compatible = "fsl,sec-v4.0-rtic-memory";
> +                reg = <0x20 0x20>, <0x200 0x80>;
> +            };
> +
> +            rtic-c@40 {
> +                compatible = "fsl,sec-v4.0-rtic-memory";
> +                reg = <0x40 0x20>, <0x300 0x80>;
> +            };
> +
> +            rtic-d@60 {
> +                compatible = "fsl,sec-v4.0-rtic-memory";
> +                reg = <0x60 0x20>, <0x500 0x80>;
> +            };
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> deleted file mode 100644
> index 8f359f473ada..000000000000
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> +++ /dev/null
> @@ -1,553 +0,0 @@
> -=====================================================================
> -SEC 4 Device Tree Binding
> -Copyright (C) 2008-2011 Freescale Semiconductor Inc.
> -
> - CONTENTS
> -   -Overview
> -   -SEC 4 Node
> -   -Job Ring Node
> -   -Run Time Integrity Check (RTIC) Node
> -   -Run Time Integrity Check (RTIC) Memory Node
> -   -Secure Non-Volatile Storage (SNVS) Node
> -   -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
> -   -Full Example
> -
> -NOTE: the SEC 4 is also known as Freescale's Cryptographic Accelerator
> -Accelerator and Assurance Module (CAAM).
> -
> -=====================================================================
> -Overview
> -
> -DESCRIPTION
> -
> -SEC 4 h/w can process requests from 2 types of sources.
> -1. DPAA Queue Interface (HW interface between Queue Manager & SEC 4).
> -2. Job Rings (HW interface between cores & SEC 4 registers).
> -
> -High Speed Data Path Configuration:
> -
> -HW interface between QM & SEC 4 and also BM & SEC 4, on DPAA-enabled parts
> -such as the P4080.  The number of simultaneous dequeues the QI can make is
> -equal to the number of Descriptor Controller (DECO) engines in a particular
> -SEC version.  E.g., the SEC 4.0 in the P4080 has 5 DECOs and can thus
> -dequeue from 5 subportals simultaneously.
> -
> -Job Ring Data Path Configuration:
> -
> -Each JR is located on a separate 4k page, they may (or may not) be made visible
> -in the memory partition devoted to a particular core.  The P4080 has 4 JRs, so
> -up to 4 JRs can be configured; and all 4 JRs process requests in parallel.
> -
> -=====================================================================
> -SEC 4 Node
> -
> -Description
> -
> -    Node defines the base address of the SEC 4 block.
> -    This block specifies the address range of all global
> -    configuration registers for the SEC 4 block.  It
> -    also receives interrupts from the Run Time Integrity Check
> -    (RTIC) function within the SEC 4 block.
> -
> -PROPERTIES
> -
> -   - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0"
> -
> -   - fsl,sec-era
> -      Usage: optional
> -      Value type: <u32>
> -      Definition: A standard property. Define the 'ERA' of the SEC
> -          device.
> -
> -   - #address-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing physical addresses in child nodes.
> -
> -   - #size-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing the size of physical addresses in
> -           child nodes.
> -
> -   - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies the physical
> -          address and length of the SEC4 configuration registers.
> -          registers
> -
> -   - ranges
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: A standard property.  Specifies the physical address
> -           range of the SEC 4.0 register space (-SNVS not included).  A
> -           triplet that includes the child address, parent address, &
> -           length.
> -
> -   - interrupts
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition:  Specifies the interrupts generated by this
> -           device.  The value of the interrupts property
> -           consists of one interrupt specifier. The format
> -           of the specifier is defined by the binding document
> -           describing the node's interrupt parent.
> -
> -   - clocks
> -      Usage: required if SEC 4.0 requires explicit enablement of clocks
> -      Value type: <prop_encoded-array>
> -      Definition:  A list of phandle and clock specifier pairs describing
> -          the clocks required for enabling and disabling SEC 4.0.
> -
> -   - clock-names
> -      Usage: required if SEC 4.0 requires explicit enablement of clocks
> -      Value type: <string>
> -      Definition: A list of clock name strings in the same order as the
> -          clocks property.
> -
> -   Note: All other standard properties (see the Devicetree Specification)
> -   are allowed but are optional.
> -
> -
> -EXAMPLE
> -
> -iMX6QDL/SX requires four clocks
> -
> -	crypto@300000 {
> -		compatible = "fsl,sec-v4.0";
> -		fsl,sec-era = <2>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0x300000 0x10000>;
> -		ranges = <0 0x300000 0x10000>;
> -		interrupt-parent = <&mpic>;
> -		interrupts = <92 2>;
> -		clocks = <&clks IMX6QDL_CLK_CAAM_MEM>,
> -			 <&clks IMX6QDL_CLK_CAAM_ACLK>,
> -			 <&clks IMX6QDL_CLK_CAAM_IPG>,
> -			 <&clks IMX6QDL_CLK_EIM_SLOW>;
> -		clock-names = "mem", "aclk", "ipg", "emi_slow";
> -	};
> -
> -
> -iMX6UL does only require three clocks
> -
> -	crypto: crypto@2140000 {
> -		compatible = "fsl,sec-v4.0";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0x2140000 0x3c000>;
> -		ranges = <0 0x2140000 0x3c000>;
> -		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -
> -		clocks = <&clks IMX6UL_CLK_CAAM_MEM>,
> -			 <&clks IMX6UL_CLK_CAAM_ACLK>,
> -			 <&clks IMX6UL_CLK_CAAM_IPG>;
> -		clock-names = "mem", "aclk", "ipg";
> -	};
> -
> -=====================================================================
> -Job Ring (JR) Node
> -
> -    Child of the crypto node defines data processing interface to SEC 4
> -    across the peripheral bus for purposes of processing
> -    cryptographic descriptors. The specified address
> -    range can be made visible to one (or more) cores.
> -    The interrupt defined for this node is controlled within
> -    the address range of this node.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-job-ring"
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: Specifies a two JR parameters:  an offset from
> -          the parent physical address and the length the JR registers.
> -
> -   - fsl,liodn
> -       Usage: optional-but-recommended
> -       Value type: <prop-encoded-array>
> -       Definition:
> -           Specifies the LIODN to be used in conjunction with
> -           the ppid-to-liodn table that specifies the PPID to LIODN mapping.
> -           Needed if the PAMU is used.  Value is a 12 bit value
> -           where value is a LIODN ID for this JR. This property is
> -           normally set by boot firmware.
> -
> -   - interrupts
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition:  Specifies the interrupts generated by this
> -           device.  The value of the interrupts property
> -           consists of one interrupt specifier. The format
> -           of the specifier is defined by the binding document
> -           describing the node's interrupt parent.
> -
> -EXAMPLE
> -	jr@1000 {
> -		compatible = "fsl,sec-v4.0-job-ring";
> -		reg = <0x1000 0x1000>;
> -		fsl,liodn = <0x081>;
> -		interrupt-parent = <&mpic>;
> -		interrupts = <88 2>;
> -	};
> -
> -
> -=====================================================================
> -Run Time Integrity Check (RTIC) Node
> -
> -  Child node of the crypto node.  Defines a register space that
> -  contains up to 5 sets of addresses and their lengths (sizes) that
> -  will be checked at run time.  After an initial hash result is
> -  calculated, these addresses are checked by HW to monitor any
> -  change.  If any memory is modified, a Security Violation is
> -  triggered (see SNVS definition).
> -
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-rtic".
> -
> -   - #address-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing physical addresses in child nodes.  Must
> -           have a value of 1.
> -
> -   - #size-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing the size of physical addresses in
> -           child nodes.  Must have a value of 1.
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies a two parameters:
> -          an offset from the parent physical address and the length
> -          the SEC4 registers.
> -
> -   - ranges
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: A standard property.  Specifies the physical address
> -           range of the SEC 4 register space (-SNVS not included).  A
> -           triplet that includes the child address, parent address, &
> -           length.
> -
> -EXAMPLE
> -	rtic@6000 {
> -		compatible = "fsl,sec-v4.0-rtic";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0x6000 0x100>;
> -		ranges = <0x0 0x6100 0xe00>;
> -	};
> -
> -=====================================================================
> -Run Time Integrity Check (RTIC) Memory Node
> -  A child node that defines individual RTIC memory regions that are used to
> -  perform run-time integrity check of memory areas that should not modified.
> -  The node defines a register that contains the memory address &
> -  length (combined) and a second register that contains the hash result
> -  in big endian format.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-rtic-memory".
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies two parameters:
> -          an offset from the parent physical address and the length:
> -
> -          1. The location of the RTIC memory address & length registers.
> -          2. The location RTIC hash result.
> -
> -  - fsl,rtic-region
> -       Usage: optional-but-recommended
> -       Value type: <prop-encoded-array>
> -       Definition:
> -           Specifies the HW address (36 bit address) for this region
> -           followed by the length of the HW partition to be checked;
> -           the address is represented as a 64 bit quantity followed
> -           by a 32 bit length.
> -
> -   - fsl,liodn
> -       Usage: optional-but-recommended
> -       Value type: <prop-encoded-array>
> -       Definition:
> -           Specifies the LIODN to be used in conjunction with
> -           the ppid-to-liodn table that specifies the PPID to LIODN
> -           mapping.  Needed if the PAMU is used.  Value is a 12 bit value
> -           where value is a LIODN ID for this RTIC memory region. This
> -           property is normally set by boot firmware.
> -
> -EXAMPLE
> -	rtic-a@0 {
> -		compatible = "fsl,sec-v4.0-rtic-memory";
> -		reg = <0x00 0x20 0x100 0x80>;
> -		fsl,liodn   = <0x03c>;
> -		fsl,rtic-region  = <0x12345678 0x12345678 0x12345678>;
> -	};
> -
> -=====================================================================
> -Secure Non-Volatile Storage (SNVS) Node
> -
> -    Node defines address range and the associated
> -    interrupt for the SNVS function.  This function
> -    monitors security state information & reports
> -    security violations. This also included rtc,
> -    system power off and ON/OFF key.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-mon" and "syscon".
> -
> -  - reg
> -      Usage: required
> -      Value type: <prop-encoded-array>
> -      Definition: A standard property.  Specifies the physical
> -          address and length of the SEC4 configuration
> -          registers.
> -
> -   - #address-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing physical addresses in child nodes.  Must
> -           have a value of 1.
> -
> -   - #size-cells
> -       Usage: required
> -       Value type: <u32>
> -       Definition: A standard property.  Defines the number of cells
> -           for representing the size of physical addresses in
> -           child nodes.  Must have a value of 1.
> -
> -   - ranges
> -       Usage: required
> -       Value type: <prop-encoded-array>
> -       Definition: A standard property.  Specifies the physical address
> -           range of the SNVS register space.  A triplet that includes
> -           the child address, parent address, & length.
> -
> -   - interrupts
> -      Usage: optional
> -      Value type: <prop_encoded-array>
> -      Definition:  Specifies the interrupts generated by this
> -           device.  The value of the interrupts property
> -           consists of one interrupt specifier. The format
> -           of the specifier is defined by the binding document
> -           describing the node's interrupt parent.
> -
> -EXAMPLE
> -	sec_mon@314000 {
> -		compatible = "fsl,sec-v4.0-mon", "syscon";
> -		reg = <0x314000 0x1000>;
> -		ranges = <0 0x314000 0x1000>;
> -		interrupt-parent = <&mpic>;
> -		interrupts = <93 2>;
> -	};
> -
> -=====================================================================
> -Secure Non-Volatile Storage (SNVS) Low Power (LP) RTC Node
> -
> -  A SNVS child node that defines SNVS LP RTC.
> -
> -  - compatible
> -      Usage: required
> -      Value type: <string>
> -      Definition: Must include "fsl,sec-v4.0-mon-rtc-lp".
> -
> -  - interrupts
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition: Specifies the interrupts generated by this
> -	   device.  The value of the interrupts property
> -	   consists of one interrupt specifier. The format
> -	   of the specifier is defined by the binding document
> -	   describing the node's interrupt parent.
> -
> - - regmap
> -	Usage: required
> -	Value type: <phandle>
> -	Definition: this is phandle to the register map node.
> -
> - - offset
> -	Usage: option
> -	value type: <u32>
> -	Definition: LP register offset. default it is 0x34.
> -
> -   - clocks
> -      Usage: optional, required if SNVS LP RTC requires explicit
> -          enablement of clocks
> -      Value type: <prop_encoded-array>
> -      Definition:  a clock specifier describing the clock required for
> -          enabling and disabling SNVS LP RTC.
> -
> -   - clock-names
> -      Usage: optional, required if SNVS LP RTC requires explicit
> -          enablement of clocks
> -      Value type: <string>
> -      Definition: clock name string should be "snvs-rtc".
> -
> -EXAMPLE
> -	sec_mon_rtc_lp@1 {
> -		compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -		interrupts = <93 2>;
> -		regmap = <&snvs>;
> -		offset = <0x34>;
> -		clocks = <&clks IMX7D_SNVS_CLK>;
> -		clock-names = "snvs-rtc";
> -	};
> -
> -=====================================================================
> -System ON/OFF key driver
> -
> -  The snvs-pwrkey is designed to enable POWER key function which controlled
> -  by SNVS ONOFF, the driver can report the status of POWER key and wakeup
> -  system if pressed after system suspend.
> -
> -  - compatible:
> -      Usage: required
> -      Value type: <string>
> -      Definition: Mush include "fsl,sec-v4.0-pwrkey".
> -
> -  - interrupts:
> -      Usage: required
> -      Value type: <prop_encoded-array>
> -      Definition: The SNVS ON/OFF interrupt number to the CPU(s).
> -
> -  - linux,keycode:
> -      Usage: option
> -      Value type: <int>
> -      Definition: Keycode to emit, KEY_POWER by default.
> -
> -  - wakeup-source:
> -      Usage: option
> -      Value type: <boo>
> -      Definition: Button can wake-up the system.
> -
> - - regmap:
> -      Usage: required:
> -      Value type: <phandle>
> -      Definition: this is phandle to the register map node.
> -
> -EXAMPLE:
> -	snvs-pwrkey@020cc000 {
> -		compatible = "fsl,sec-v4.0-pwrkey";
> -		regmap = <&snvs>;
> -		interrupts = <0 4 0x4>
> -	        linux,keycode = <116>; /* KEY_POWER */
> -		wakeup-source;
> -	};
> -
> -=====================================================================
> -FULL EXAMPLE
> -
> -	crypto: crypto@300000 {
> -		compatible = "fsl,sec-v4.0";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		reg = <0x300000 0x10000>;
> -		ranges = <0 0x300000 0x10000>;
> -		interrupt-parent = <&mpic>;
> -		interrupts = <92 2>;
> -
> -		sec_jr0: jr@1000 {
> -			compatible = "fsl,sec-v4.0-job-ring";
> -			reg = <0x1000 0x1000>;
> -			interrupt-parent = <&mpic>;
> -			interrupts = <88 2>;
> -		};
> -
> -		sec_jr1: jr@2000 {
> -			compatible = "fsl,sec-v4.0-job-ring";
> -			reg = <0x2000 0x1000>;
> -			interrupt-parent = <&mpic>;
> -			interrupts = <89 2>;
> -		};
> -
> -		sec_jr2: jr@3000 {
> -			compatible = "fsl,sec-v4.0-job-ring";
> -			reg = <0x3000 0x1000>;
> -			interrupt-parent = <&mpic>;
> -			interrupts = <90 2>;
> -		};
> -
> -		sec_jr3: jr@4000 {
> -			compatible = "fsl,sec-v4.0-job-ring";
> -			reg = <0x4000 0x1000>;
> -			interrupt-parent = <&mpic>;
> -			interrupts = <91 2>;
> -		};
> -
> -		rtic@6000 {
> -			compatible = "fsl,sec-v4.0-rtic";
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> -			reg = <0x6000 0x100>;
> -			ranges = <0x0 0x6100 0xe00>;
> -
> -			rtic_a: rtic-a@0 {
> -				compatible = "fsl,sec-v4.0-rtic-memory";
> -				reg = <0x00 0x20 0x100 0x80>;
> -			};
> -
> -			rtic_b: rtic-b@20 {
> -				compatible = "fsl,sec-v4.0-rtic-memory";
> -				reg = <0x20 0x20 0x200 0x80>;
> -			};
> -
> -			rtic_c: rtic-c@40 {
> -				compatible = "fsl,sec-v4.0-rtic-memory";
> -				reg = <0x40 0x20 0x300 0x80>;
> -			};
> -
> -			rtic_d: rtic-d@60 {
> -				compatible = "fsl,sec-v4.0-rtic-memory";
> -				reg = <0x60 0x20 0x500 0x80>;
> -			};
> -		};
> -	};
> -
> -	sec_mon: sec_mon@314000 {
> -		compatible = "fsl,sec-v4.0-mon";
> -		reg = <0x314000 0x1000>;
> -		ranges = <0 0x314000 0x1000>;
> -
> -		sec_mon_rtc_lp@34 {
> -			compatible = "fsl,sec-v4.0-mon-rtc-lp";
> -			regmap = <&sec_mon>;
> -			offset = <0x34>;
> -			interrupts = <93 2>;
> -			clocks = <&clks IMX7D_SNVS_CLK>;
> -			clock-names = "snvs-rtc";
> -		};
> -
> -		snvs-pwrkey@020cc000 {
> -			compatible = "fsl,sec-v4.0-pwrkey";
> -			regmap = <&sec_mon>;
> -			interrupts = <0 4 0x4>;
> -			linux,keycode = <116>; /* KEY_POWER */
> -			wakeup-source;
> -		};
> -	};
> -
> -=====================================================================
