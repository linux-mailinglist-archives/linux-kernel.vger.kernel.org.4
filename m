Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4789F6731CF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 07:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjASGfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 01:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjASGe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 01:34:58 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2055.outbound.protection.outlook.com [40.107.8.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F41715C;
        Wed, 18 Jan 2023 22:34:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuwAi/KJKbE2UFWlmnCL42UrYBIvNzvlwzaqr998Q5qfUEqKy+O2v/a9Klh8GngolwR3eK4VmF2VWVJrByKhwqu7SzXJ0zEEzFutaf5vjADl5CGuTeI/C+0JNbVQ0yffLfSNgMrBQKrVdbkVLaznf0nI1kpoGvsxo1DibT12T7t6eqMzRUDlx0QVxISJR8xLwbatdedKV+6A2lAGd6IaftNKpJanpHBuH6g+wOin23jOqu14jDCtiK9l4Pja7aF9HlOXDkQKVuDyo3bXF4SL88pzAi7zX7q+J8ZVt0AyXZzQ2RS842579EOAiIItaPY0e3MEj5pFUvm22SavNlOQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZTlk0ZRPwJTHj9OCv4mc+EQOfce29BR+e6XnPBuCC8=;
 b=N0wRYM0kdVI4Chg1ZoBLj6+UcAeMDSqzTvlXiDCIlRJEleI4h7MZ8qfam2x93bOuUUuBXpgRAVUrF48EorYTq/bu5Paua6J06hewCsputtG0pvG3Re7B9IFkHZ5D0S4Ji2zyPyWTKsSHqiGD6Wek2sm5cWmhcMH/ksCEArbFmKplLxusGiFF66bZvhmmKkABrrUQkt68jiNJRlC3KYXaszERtj9rLZ0N0nfECLZtbcirFfG4oPflWt3eCjxDXnDfbJC6yV54HIDEV18rTVuh/PNaLdHTIdvREN1lBEAvvQWA8DQ6xUJGCWdJhbKEZ6/tNc1ztHYzhYS/W+DbWfLv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZTlk0ZRPwJTHj9OCv4mc+EQOfce29BR+e6XnPBuCC8=;
 b=INcstre2rDGUo9u+mQrQ2oGQpd0FOxQc7DTaWC542c+OiJ4G2JRJp94nzBDmT1gefGPN8OvdcfsKIHcua9jyZCpyInEnKzad2YZexwuhaDkfZZLSB9EcS6ldnswl93rTaYtajd/Mg0b9TENsfqhzckFKpciu8xeEMiAbAnZzYgIO/5iNMgApavdT83bveU5fBbnusnwvDbrmEOmQbiDmvnpmVCk9AnNyRCaWPWcGCgZSB/HxJm2wbTJpVaQWtYwtofYSJf3bqokynei8Bl7ANTGKhghtRVUpsLo4ab4A9bdPXxIyI96JSt1D51+ZV5rl8wUSGKXXs08SpgaKNQ7EKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6333.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:522::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 06:34:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Thu, 19 Jan 2023
 06:34:53 +0000
Message-ID: <dc6fc5be-0b53-00fc-3664-4dfd11b1fea9@siemens.com>
Date:   Thu, 19 Jan 2023 07:34:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: ti: Add binding for Siemens IOT2050
 M.2 variant
Content-Language: en-US
To:     "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1674059300.git.jan.kiszka@siemens.com>
 <3f825ff8853b1ffd8228d3283c7da0483ddf55d5.1674059300.git.jan.kiszka@siemens.com>
 <a219dcf6-412b-a9f8-cf06-1896df0709de@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <a219dcf6-412b-a9f8-cf06-1896df0709de@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e18413c-acec-4db4-7a4e-08daf9e74604
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2yI5Y7Q32fzgmZZXKjFwlFEsGf1LKSw070jcdW33Wwha25GBdEpowHmyiU5cgP6aymjsQCGDTdQVEoU9UiMf9NZvigbeRgohW2RUhS/me+Bwly0joQPwKcc8TXWhudXJuQrSZs3++0qvi0F0BuF9uXbiTGGKcC1l5sKydihveuQ+j1FMFE/ILuNny9ODhFViV0JTbXHE3tUP1aIT45K3MFKDOc2YFeicsbxpEC4g2CxqsyuPod6RjHjCcT//EhXCXALp2vS/sZjpT6VGyhhPM4D4wKMAlUw3MeKpZI3Wqw9WoKRN99vB/7bGuJYPhAQ+jdUBjLZNU5e3VmVrYJVnelpsmvU1cJk3ZAQaHAh0U/I7AkqKpp6pBCHxhEoflIPenI3TMtlpv+giZnlNE0S7jF13cWcB7YS5LcVqbgab9lwBzJn959MbuCm7S5ZazNAdVCx3VlhYclylGr18OfHxgE+nckX1JgkanmxfaiCUCZu/RKv2vxSo3pxjSomEUY54jZXFLGWR6iCr+2uK5AZiSwDiUhbSG6Rw1GMixqCcKXWH+bWIE8gurEC+FR1srM1L21lfkwt2mzleQlC27GKo0q5/UpdCAF7lIvhYJS/mzbVvczfPQzPMhg2Im6KBcgvqlKkAEG9zHgre2Vild6IezP2Rz4aNxQczCMAuXKJRCR2ZvJZGheTIRF7U8SDjYW7IdMdOEKmmQcbg2G9Uz4Pp6hdh/uGgrD6AaVwbLVOojo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(31686004)(44832011)(2906002)(66556008)(66946007)(5660300002)(8936002)(66476007)(82960400001)(31696002)(38100700002)(110136005)(316002)(6666004)(107886003)(54906003)(53546011)(6486002)(6506007)(86362001)(478600001)(36756003)(26005)(8676002)(4326008)(41300700001)(2616005)(186003)(83380400001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhoVFV0QUJ6V0xQUHVSUFNXZGN3SDl2V041blFjdWwxYjZuUHFUMEZqQU5k?=
 =?utf-8?B?elc2N0FwdnFZb3R4SWJaaDF6U09kREV1cy9CY1RUenFMc0MwOXJLT1dUTUVs?=
 =?utf-8?B?cGpITnlpQ0Nrd0dvM1RITUIzeUFpbllleWV1c21rOWdKbkNqZVU0ekNzNmps?=
 =?utf-8?B?M25KUEh1NzhlL2kzcnN1SFBqQlQ3Y3gyUFUxRlpBTWpZd1kzWWFnY1MxV0Vs?=
 =?utf-8?B?OTNEU2lqMUhaYlUrbjd4bXZxUE5vaGVzMDhOWlVGaW9ITEdoa2ZEeXhtVTVj?=
 =?utf-8?B?UGpBV0RBemtEb0djSEFic2R4NlAxMzZYbWoySjN2WFZOM3cxTlZ4dWRMd2tC?=
 =?utf-8?B?RzdIV1Y4Y3Bad2ZyMmZwaHVGSnhVWkpqUllzMVo3eklUMWVUYmJOL3ExUTd6?=
 =?utf-8?B?VnNLWm51ZjVocThCa3Y1aFhWc1Azck5KQXU4anhPemJMTGdyb2Z6Wis5Szcy?=
 =?utf-8?B?Z3ZINFQxc213L2JUc3lUd3ZBb3VvZUNQZkJvM1RHMTRFTm5ldVZQWWxkSTcw?=
 =?utf-8?B?Ky9tb3UzMkhseVBNOFd4eGRuSGhaenNlblhLOElSUGtQVjMzSzdwWE81ZWRa?=
 =?utf-8?B?TWI0c09YZzM0YVRQcEZhQ2xjU3NKU2trTlY4SXhHcUV2a0YvYVB6UTNidTNJ?=
 =?utf-8?B?aG5wazlLNHRhS082d0lGYndyOWF4cWp5dDR1ZlpJL2IvcjJlNUpCZ21FMVZN?=
 =?utf-8?B?TXYycDljTDdSVHZDUXlEU25HdXRmNVIzeVJpK1ZjUkkzRUJsdEVuaisySVh0?=
 =?utf-8?B?UC9SVHcxTERPMm90YVFCckNhT0ZVYjl0ZzF3WWtSOXRBai9MZEovQnljclph?=
 =?utf-8?B?Q2t6OWFqdXpjdmVnRDlZZm40WkxwVEFhZUtsajkyaU51VEF2U2VPS2JNM3oy?=
 =?utf-8?B?QlhVdlphZmQxZ1FVZE12Z0xDT1N3UDVDMTRhVVdrMUZXK1RwK1JIM3dvSGo3?=
 =?utf-8?B?Zlk0SmFvMmsxVkJuK0ZVUHlaMGRnb1dab0NOcGdJdmF2WWo0VVJFN2xBYXpo?=
 =?utf-8?B?Zk5WT2JmdU1zN20rQ3NpSlVBUVhleGcrNXMvNVN1bzluekg5NWZTTWxSV3Ja?=
 =?utf-8?B?WG0yT2RXbHVMbFdDbk5oSE80dWtVcG9kMm5ERWJPc25HUytLVUNOems1NnJH?=
 =?utf-8?B?VUFJenEyOXpWQjJzYyt1OTBvMC85N3FJMS8yVHh4bUxXdGVCYjQwN2NkaTRk?=
 =?utf-8?B?OWtpRDlpc0RVVmlrRkYxN28vUFNNai81YVI4L0pra0VaVUNQWkVGUi9mRGd2?=
 =?utf-8?B?ck5XMzdzbVZRZlVaMTB5V2hrTHVrWW5Jd0dLWDRkK05kUEo3Zkt3S2QvMnYx?=
 =?utf-8?B?dDkwNGNYUkFybnEzUnBCREJvUDd2cmFnTGxhQkRIYmhPaFhTYkhxbWswRnZC?=
 =?utf-8?B?TTBrMVV5SjdqWkdmaHM4RGdzYjZya0MzL2UrbCs1ZzdNb2NITEVFTkhXTGVv?=
 =?utf-8?B?YXByaXhXSm53YW9pelRtY3BBOGZKZTRtTE1YV2Rhay9MMmJMRnRjT2lrMjYx?=
 =?utf-8?B?UmViOHRFMmIzNUZaSmE0bmJyL1NnY1FPUW5WUDI3R25ocUNTaGdaQ3BzckVx?=
 =?utf-8?B?ak1EVFBSWFBiODBIRG9SVy9OMGFNb0h3QTJjSU9WaVBERmFEeDlNSU9yZHBX?=
 =?utf-8?B?OUYwN255ZXluYnk0S1pMS01xRVBrMHBIWE01Z3ViWW1KMHBXMloyNVZuRTVM?=
 =?utf-8?B?a0pha3ZLY2paejBGdDJRenRQMFRHbmEyRzlQNWYrVzVqclcxcFVZNjJhU0hU?=
 =?utf-8?B?VnUvNEdOQmVmWU1hUjJoRnlGcmpyNnFyL1ZvS0d1MDNHbWkvYUVQaFBsQTN0?=
 =?utf-8?B?djY4RjJSR3JVVHkwcFgweHBJVUhmaFZ6TU16aVpDZFd4RVRFZ0VFU3ozanpq?=
 =?utf-8?B?VXZ3MWorRUlkYzFFeXErcEd4SE5jVU1KSVJNa0ltdlYxSDJOSkNXTkFhNWkz?=
 =?utf-8?B?Rndzall5c0FGVnRPWjlSYkRwVkNoTldzUTB0cmFJQ1FrTk9ybjZXdVVOMjZx?=
 =?utf-8?B?RllhQy9HRFhxVVlrNDU4Q21ULzRvNSs4VTdUa1YzTVNrQ09sT0dhbWlRcEZF?=
 =?utf-8?B?aDBxMG5ZN3oxQ3UraXIvK2hXU0QybGtXQm4zaDUrSUYyL3NmSW5QSjRmQ1hG?=
 =?utf-8?B?aGhxNGR6Y3ZzYXFQTm9BUEF2V0FEVlRwZVZHUU91RXZ5VGVPT3pPY0s2MjdS?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e18413c-acec-4db4-7a4e-08daf9e74604
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 06:34:53.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7n34eZzQDmOxZfHwzQBOBOOwMix+znD71cRIazIjEc9bPZAr3kwpOm3mHJ4Is0CwiQYHvAYHRdfP+JGA3LmLNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6333
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.23 18:43, Raghavendra, Vignesh wrote:
> Hi Jan,
> 
> On 1/18/2023 9:58 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This new variant is derived from the Advanced PG2 board, replacing the
>> MiniPCI slot with B and E-keyed M.2 slots.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index 203faab80142..7af813202f1f 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -43,6 +43,7 @@ properties:
>>            - enum:
>>                - siemens,iot2050-advanced
>>                - siemens,iot2050-advanced-pg2
>> +              - siemens,iot2050-advanced-m2
> 
> Could you re arrange alphabetically?

Time of release ordering, but I can reorder as well.

Jan

> 
>>                - siemens,iot2050-basic
>>                - siemens,iot2050-basic-pg2
>>                - ti,am654-evm
> 
> 
> Regards
> Vignesh

-- 
Siemens AG, Technology
Competence Center Embedded Linux

