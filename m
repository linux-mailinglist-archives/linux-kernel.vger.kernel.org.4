Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEA6AA895
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 08:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCDHhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 02:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDHhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 02:37:32 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA86B22DC5;
        Fri,  3 Mar 2023 23:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXNOBz8S8ZzVnbODqxFmTng5z5a2ZrUmIua7BEZLX5hTKhxmVtQQ110FROIHxhnyuiCo5qiq+joiR0CGI1z+kI1xEAQYzEJtp4WfAxzKuzWPzNkRpRCI6Vo8/kjAzVysOM/XfoeBJWH16UmoxAT+Z72lVMRQU4EotvNDGhM0AxWwsgeXQ+atHhiqp8FVggKfzGGQ6VCMlxThBoptE3ijRUyCWXn78g0psZ23dJVW0piYoHJ0sI11ZITrspvVd9kLEAHCxvs3NgMmP2IB23W8CypjM1+zfZ5iMzXimCqMECByqkrHS144V4FQmadRfF1DS8mWQZHQs5R5xCT0YBPgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clwcfsoo32n0GeOnaWh3IykIL3pW9YvxlsBFi7UntbA=;
 b=T6yVwvaiNS9PFd9FZ8HaGmgHLBAXJ1UTKovuJZeq/z4AgJpei2bbVYh9DWJ1Vxg+j0mwAEXBUvdL3c6ZVu4sICkG7X2uPVMSqH41mCF6GKav2IhsEOTDX422YrjOtoDhv1vD+xFfikjdDTvKEyjZDWAVcppVYRLUaqS4UUZKD5GZJgOJTxWLtue0y//mQfXLfjklmdbZy9DIAIcTpZbKSTrPnKja3fZBg2V/81dHT63TC9/R69MqwNgGLI7OLqH2nMYCUteIgmCkOWgTiXEm8QeyfeTXNulIKCLmzzIWBVlThN0cFisroq7Jc4Bt0cQo5ijdz3d5o4LY0CD37WzinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clwcfsoo32n0GeOnaWh3IykIL3pW9YvxlsBFi7UntbA=;
 b=gLZznb7q9BRoJSvT9y8loYg7JsX5blUgcheSjR2NprlEe4hVWiD7vnAvvwoOyDE8qJ072DfcCT9llrtDCFNAGRkfX+1CPpYumpJfkc/tS1K4gq7VwhaJM0H/wrdRJSE9QNUNYfJq8YE5/JQqPLR07chw9gzORM/3MK9Qoye7neA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8923.eurprd04.prod.outlook.com (2603:10a6:20b:40a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Sat, 4 Mar
 2023 07:37:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%3]) with mapi id 15.20.6156.022; Sat, 4 Mar 2023
 07:37:26 +0000
Message-ID: <f6e89bd9-fa39-867b-288a-6dc20bc083b9@oss.nxp.com>
Date:   Sat, 4 Mar 2023 15:37:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT
 schema
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
 <20230226130539.277336-2-peng.fan@oss.nxp.com>
 <20230227205229.GA880857-robh@kernel.org>
 <DU0PR04MB9417EDBB2ACDC761D6D6C31488AC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <DU0PR04MB9417EDBB2ACDC761D6D6C31488AC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: 8970111c-a7b4-412d-45ba-08db1c834cac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sr9e88VVJMXNBZD1z0K0w6sHvfGpUbIZ/PS9LGrEzL2A/affimJqeDDNzvn/ANDthINvubVk3owcAqcwnvMOYPMR9QjfFjQDWC0pc6WElYSh8M8SQC4BPfrIHW7zAaIEkK6mH5Sqln59/fHnmTudztWUV4Lj8Bg1bMuLLDEylIqBkK451Yc/yZ27GweNJ7IzeMU5n0ftqnkC/C7QOZkJgVeKlCpb7WyNv4Dsz6PUg2f5qIg7dBhpZ3Q8hfPi6vMrleFYbxhNLO2k7icPyX7DR7rmRSuErJ0NKs8OkInYt1x6LMD/cgQS4IEHz5+HbQjCWe3I1hBWro0+P2pvsJuMQw5ECgOWThNHXY61EhF0509aUo1yZiLw8Dd87OJzv79M9oiWpK8JoyUNTjJWv4XMRMUXWi141lTcMJuzCYsoqr65zagdWJXdF52BROwcZVWMN90wnJYd5sgGOBbNxnp6vSeFfHKDXlwo5LdZdo7H4B/1i1Ndv+k+1GIPzHcQEKqMcv5noYP7I2MNxMsq9NEcIrrkZO/D5X2B4uW3+T9PzNkqA99FEqUp4Yi+Z9N5Qej7nMN47lPIF5D0ZzbB9AosLMVFc4775+asDAKn999+DDVu0meBZKcAuhjZ0Jl80elAcho6IZGxgLFsK35ErDUX7u3cjyxBRJZPZ94rY5BycnY5NQQsiALJNzYylNzVXq1EeUnFEvbMCph8j4iY1UL7qmKkyaz+f16IjsRBP7GYF3M/NZdTsszcGilYZpbT1Ib54Qe8axQSw7Blry1+i+VkWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199018)(31686004)(6666004)(83380400001)(478600001)(110136005)(54906003)(38350700002)(38100700002)(316002)(41300700001)(2616005)(6486002)(6506007)(6512007)(52116002)(26005)(186003)(53546011)(5660300002)(7416002)(44832011)(66476007)(66556008)(66946007)(31696002)(8936002)(2906002)(8676002)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHUxSW1lMThib1ZtWHpKbGlLZk9GcXF5K1NZeXVQK1Frb2tjdXhOTytGRTF6?=
 =?utf-8?B?TmlHUXFBZDhlcHhnRzY2clZ5SzVIQS82OWZIWll6ZE5keTNtMVlxVXNlZnNj?=
 =?utf-8?B?Uk05T3hlaWo5ZmdRZ0tyUU9NekZRNC9VNGtyY05aNDBNS20zRzlhbng2YUlh?=
 =?utf-8?B?WUY0TGpjYmFrNHBieDdTeWszd2RuMXpkQnhPZ3FCMnNrMk9nOWdTcUFjSFZh?=
 =?utf-8?B?QldGakg4dldmVENONXFNL3YzRWxwM2k5ODd5eHhxdTFnS0RxU3pMRXRYbVgw?=
 =?utf-8?B?eHpOM0V1WkZ2d0w3ZDNtdURrSFRvbVFDODNOeU9KaytVM3U3dWJOYmpFZUty?=
 =?utf-8?B?VHRQbEJjY1dqVWNYK1A3MllFSWFPd0Y1elA0UUNESlNqaCt1S2ZZTmJiNUtX?=
 =?utf-8?B?V2NyOGpwR3hnVXIrbG42QzBzQUFHd1ZDU3J2dmZ4dWV4eGdxMXE5K0J2dlh3?=
 =?utf-8?B?cXVBY1Vad3hFekowTVVDUXZVRVdBMTZUbWIvMEJCUEs0YlNMc01vMUQyUlVa?=
 =?utf-8?B?MElsTkxkRnlLNGVtdWZpQ050bWExdHpHTjBIQTMrWmNwMldjTnplUFFIU0Zw?=
 =?utf-8?B?WmsxeGlITjdHSXlwckdSblFlQXVSTjJ6d1N4a3ZoblRiOUlJWG92anR4eXVF?=
 =?utf-8?B?Rit4ZVJTRDROV3YwTUFJNldIc3lIUWY1NHg4R0JCOXlkNkFZb2E0elhtMmd5?=
 =?utf-8?B?N1d6N1p4SHp3RndGcUFMdFBrZmN3SWJWcWxScDdzVWNiVHVISnkvaTdndGlS?=
 =?utf-8?B?aVhoeDZieXBDZFROSXM2ek9BS1E3M0hYTlpCSEdIeUQwSldVTEFEZ2cxb0xa?=
 =?utf-8?B?MlAxZFUwSE9kRWZOeWgvMlRodVRCQUJ0VXVPMXNEUG1TRkRCKzlYUVZGV1hz?=
 =?utf-8?B?Z1JsVkpmR01JUTJWVVc1dldORkR2aVNWY0ozR3R4eEpVS2RkaDNJNUlRVENJ?=
 =?utf-8?B?MGYveXlIcUlmb0dKYkpBeXRtSm4zOGgwODJ4TzFHQjZvSVhIZ0FuR3ptT3hs?=
 =?utf-8?B?dmNPcTRRczc2Mmc1NUVpcWhJc0t2ZGh2ckF6cUhObURFVXFqNmtsTTlYNjBQ?=
 =?utf-8?B?VU84TXF4TjlWeTlnbVB1Q1NLck0yeHVFNEw4dXBuT0tPM010NmJxWGp1Nmha?=
 =?utf-8?B?dzV0WDVwVWRhbTFVcDJISS91TmNvVzlhdi84SnRUS1FvUkc4bnNOR0hnand6?=
 =?utf-8?B?SkdjVFRHMERBNThWSFgwT2cxbFV3Tkk3eFAzUUNzeFh5ajhmN3FIdW5ZR3Ax?=
 =?utf-8?B?RVQzenhtdHRSSjdZTjh0Ykx0TEZENkxpZlNWZUxvWUVnMGtsQ0RIbWhwVWdw?=
 =?utf-8?B?WkJhcnpja1FqY29LWnRWK1g0TjlSS3RZbkdMZXRoN1dKTlRLS0NsLzRPSUVP?=
 =?utf-8?B?WnFyQng4ZldRTlROancrVnlydS8zTitWSC9TcDdnZkc4Nndwakc5RnA1Q21M?=
 =?utf-8?B?Q3NNcHFQUjRjVmlFaG1odWQrN2tPWHNjM1VSSjRtVnIyTEE2Tko1djhqbURr?=
 =?utf-8?B?SjFGZ2dibEdqbnByZDEvdXdMRy9EN0R1ZnB1b1hVVCtFR3Z6QjhhZk14WFpk?=
 =?utf-8?B?Z1diYXpvSXVNdGJzWlRsUThDSExIK2cvZFZLeUJ2R01xa3BBN2REd3ZCWFFk?=
 =?utf-8?B?WHhnQTEyMysvZCtKOUtOcFFFTDMwbzNZNStLMzFSRWl6V21RbkVCbGl2UHdp?=
 =?utf-8?B?LzNmNmtwV2xhNUFwK1g5c1A4QjQ3ZVZrQWVPbFlaUVhaN3lxN3VpQXR4QWVm?=
 =?utf-8?B?TExOOGt2UUozak9HRTlaUmE4Z3piekxNdkw2TDJzR1NIZ3NhcUhyckR1MXVr?=
 =?utf-8?B?ajl1TEZKZGVld0NmdG9LSGRNaHk2bDFOWXl0dnEvejhXQTlpTFBhaFh3WUpF?=
 =?utf-8?B?OEpYeTZxOHBUb0VucnQrNUVlNWJKZFBPWG5UQmFWWnZrQzhSTGM1YVplQUdo?=
 =?utf-8?B?MFh2Uy9mQXY3clhLUFc0d1RIeTFOSE15SnB1NWtjSVJHUVIreXlTZ3ExTU1h?=
 =?utf-8?B?aWZVK0NlVDM0ajdHSUFXRTNlRXR0ckkrSDZjd2FJK2NMUk1tRXBLZ09tMWNB?=
 =?utf-8?B?aUZDTVU3ODBORVpzL0srRS9BZ3p2M0YxSVJaaWMxN1BKekMxZDNWVE5MdGlM?=
 =?utf-8?Q?7SQJ9WIKVSyvBh0WcMnGVL3D9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8970111c-a7b4-412d-45ba-08db1c834cac
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 07:37:25.8676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xlgAKmcWhcHnZxT0zpPEDvvIAv7jOQdXTQLcxPrDlq/RlVC0qS3xyV0y9qOp03lUsGDNWs70sNKdgRUFDLlnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8923
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, Krzysztof,

On 2/28/2023 1:55 PM, Peng Fan wrote:
>> Subject: Re: [PATCH V3 1/7] dt-bindings: usb: usbmisc-imx: convert to DT
>> schema
...
>>> +
>>> +title: Freescale i.MX wrapper module for Chipidea USB2 controller
>>> +
>>> +maintainers:
>>> +  - Xu Yang <xu.yang_2@nxp.com>
>>> +  - Peng Fan <peng.fan@nxp.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - enum:
>>> +          - fsl,imx6q-usbmisc
>>> +          - fsl,imx7ulp-usbmisc
>>> +          - fsl,vf610-usbmisc
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx6ul-usbmisc
>>> +              - fsl,imx6sx-usbmisc
>>> +              - fsl,imx7d-usbmisc
>>> +          - const: fsl,imx6q-usbmisc
>>> +      - items:
>>> +          - enum:
>>> +              - fsl,imx7ulp-usbmisc
>>> +              - fsl,imx8mm-usbmisc
>>> +          - const: fsl,imx7d-usbmisc
>>
>> So imx8mm is compatible with imx7d, and imx7d is compatible with imx6q,
>> but imx8mm is not compatible with imx6q? That doesn't really make sense.
>> Maybe all 3 compatibles makes sense, but only if s/w understanding only
>> one of the fallback compatibles would function without knowledge of the
>> newer h/w.
> 
> I added the list according the current device tree in use. If using
> three compatibles,  that would involve device tree upate, and firmware
> update for SR-IR.
> 
> My understanding is imx8mm is compatible with imx7d, imx7d is compatible
> with imx6q, then imx8mm is compatible with imx6q. it is just not put
> them under one item. Please correct if my understanding is wrong.
>>

Do you have any guidance here? I am not sure how to proceed on V4.

Thanks,
Peng

>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#index-cells':
>>> +    const: 1
>>> +    description: Cells used to describe usb controller index.
>>
>> Please mark this as deprecated. If it is always 1 cell, then there's no point.
> 
> Fix in v4.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - '#index-cells'
>>
>> And drop as required. That all can be a follow-up patch if you prefer or in
>> this patch is fine. Primarily, I don't want this pattern copied.
>>
> 
> Fix in v4.
> 
> Thanks,
> Peng.
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    usbmisc@2184800 {
>>> +        #index-cells = <1>;
>>> +        compatible = "fsl,imx6q-usbmisc";
>>> +        reg = <0x02184800 0x200>;
>>> +    };
>>> +
>>> +...
>>> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>>> b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>>> deleted file mode 100644
>>> index 29b8f65ff849..000000000000
>>> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>>> +++ /dev/null
>>> @@ -1,19 +0,0 @@
>>> -* Freescale i.MX non-core registers
>>> -
>>> -Required properties:
>>> -- #index-cells: Cells used to describe usb controller index. Should
>>> be <1>
>>> -- compatible: Should be one of below:
>>> -	"fsl,imx6q-usbmisc" for imx6q
>>> -	"fsl,vf610-usbmisc" for Vybrid vf610
>>> -	"fsl,imx6sx-usbmisc" for imx6sx
>>> -	"fsl,imx7d-usbmisc" for imx7d
>>> -	"fsl,imx7ulp-usbmisc" for imx7ulp
>>> -	"fsl,imx8mm-usbmisc" for imx8mm
>>> -- reg: Should contain registers location and length
>>> -
>>> -Examples:
>>> -usbmisc@2184800 {
>>> -	#index-cells = <1>;
>>> -	compatible = "fsl,imx6q-usbmisc";
>>> -	reg = <0x02184800 0x200>;
>>> -};
>>> --
>>> 2.37.1
>>>
