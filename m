Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D766F6EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjEDPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjEDPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:08:23 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFF3C02;
        Thu,  4 May 2023 08:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683212901;
  x=1714748901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3OeT7N4vcX0kAR+vQKeKZgdrbO+APQB3FyzqhXAZO1o=;
  b=C1fAeNzfzs+CiJpvpvITQ47uCJ0nsr26no/99f7ymhg4W9YvhPTaZMKe
   K3Df7oYnbQ5dq75WPk2N/PpIaAvhaQI+XMln+WiU/aHkpfByfT+AOV5H9
   Ksem6sCFhvA5asnNKVEJOA1BvX945bU5psc6YJ1VE0mHkaXcKVu+e1hVB
   YIXmF8DQszEZPHdjpJNuNrXqMA+BO+d0qdKPsD3y0xMt4Ffl1OsYiPx7D
   KDaB82VMaqo/jCvyuCKjXX1poq0cK5uTWly0z1aOBqae9l+qI/w+hrXXr
   sS0wGDBUW2p92oquuwmJUXuE0aJrTxM71n7DUFSfOVKtcla+KbV4KJRXy
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6UgQBv08SP7obYiSpaE7qIMTaTxL5ly7cYWN6IVHIowzkxUIPBBr/xk1+83yo8Kcv3uWo8hC1JIyU4e3f5R3jqMr2/IqELzp2qItMV32fSheu487GJ9XUVBtXHMbgD80UdFM2MirrDC6hYdnC/QXdSw9XAhWkxNbD+HvvWEO8sbRvHm5vdMsbInxilUN5b1tsVIH//0zVQ/v0WViGLCE7JHs76HCfE1XrcZtBcv3kvlrUn3LhMFZ2Nk+kvHZgOS1tluygNDfSYPe7YEZon3Zl55hvzXhLOGxi323axWytBr7LM6bBFfQVGt1/hgATzyZq8dL+WCxeuu/mFekSqHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OeT7N4vcX0kAR+vQKeKZgdrbO+APQB3FyzqhXAZO1o=;
 b=IE0tVqkA4ub1CC86uQZeaRzxHJGRyvsCz2DvQssspfUz5pKdddh89wnwrBKr1RYEqIiA/Xv4vlBIex477X4jnj5/8OSEKpkFpw9zL1Qq+A7iOO13XoBdVmvxW6/GP9G/E9DZ1g1Z02OyFSkMVw6ZKwvpV5ZAWEB47tMPua3SMwZ/C6p9wmUrmg1o7+EmLsBYmhxHSV6QPLarit+poWZlgTB9M8P8dSnRUxWQHg/SMSny7ivnppT+04U0L9Y8lSwsAGnsR8Z9GI4kQ8HomLh8YToT+vTcsQvbnikhjLxWvNoJn3/DJtwoLB0E83xsB6857Tz9JGHL+TkN20Fq7sqHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OeT7N4vcX0kAR+vQKeKZgdrbO+APQB3FyzqhXAZO1o=;
 b=wJwuYktGtZZeYT5E/Q5tjUcWw0YX4ueso0EcrnQoMGs/AtcwNIPFSIH7pdqStBN+g+eUc8JpQH6aCNm4cNtfeT40pcDegszsr33yZziBWwxFb7ZNoKJFlFrNYlZw0BZ/7XhaEyIgOM6WK7oksc1uI88unm+w/yiFCeVBMZtv75Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <c42a721c-13a4-16a1-efe6-002c76f5c69b@axis.com>
Date:   Thu, 4 May 2023 17:08:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] regulator: Add bindings for TPS6287x
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-1-fb5419d46c49@axis.com>
 <dfd3498c-62ab-92d3-22d6-21729dc619fa@linaro.org>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <dfd3498c-62ab-92d3-22d6-21729dc619fa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0100.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::18) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|GV2PR02MB10046:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a7713b-2f29-4faf-1d18-08db4cb163da
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RY/ebd90D4c26hF7z6245GOW98G9zLaKF+h3GLipH6DQIEYYjMmemc8q4oDYaclS7NC19lvU3IAOP5iHOiUWczrpyXIwHf/XHYq4JAfgkbwG2V2uM7pecwq6bSqy4zipG90b1bp0VrzbFZytVN5ZZAfI1PC+rIWdVPI6dZiZzPs1QtdCji9/jkxUXO1sRA/W3D7vKLQO4Kn9QmqhWMVVs97Q6AYtu7iJlIKoTXIHU7lKQIqceUoIHcadRu13CogHof7gHA/7glMxuz2qg1CbgRNOwSrmylV64S598U+m1iBuMXlPA1Kg0v/56NJ7j9j49yrcI1Jl9y03Gj89+aBrCToyGWfeKqXagnvf55EceUdRa9Y/CB2jZKh2HoRnO7yxHqhD6HHUm/+Ukn3bFKMzIMqd0u5B33/zT2vBxv+BTMR32R4AGU8naBN85Y8SzC4oHWwESvVSnJVexuN4zDm7luVZL4bIxQrvR1Uunw/a9BDI7B1WCCVLUYw3b9jSCourEzdHwHCyKXGtt25iM4ZPbr9S7weXHYMu7gsrgI3WjeUSmclnX8VI++K+xPCGIFhJgRC25M70a1a3cNDxwWXp/AbBhfHaiATLp0nTNdzd65jhfjPXT/hidDi/Yu3iXHgDqvyzKU2SERUBaYPRVwsw6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(36756003)(31686004)(316002)(66556008)(66476007)(66946007)(110136005)(478600001)(41300700001)(6486002)(4326008)(38100700002)(8936002)(8676002)(31696002)(26005)(966005)(2616005)(5660300002)(107886003)(6506007)(6512007)(53546011)(66574015)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVlZd2t4cWxaN0tlQUFNbklRcU5SZFNVMWVwcjVxVHJGSlBVeXM2STRuNXVZ?=
 =?utf-8?B?SUhiT050YzVoMXZWY1BoUzNPei9oZmQzU3lpdDNZWXlidC9RTWJBR2xRenN3?=
 =?utf-8?B?UFcvazFrSklZOGRBb1hOMnMwUDBRNHUyRUVQckE3WUtSQW9iTURnOXR0dWFu?=
 =?utf-8?B?VWxGUllZWU5DVnp4UGRDeGlJQnkyd1Y5dHk2VjhHOVg0R2hhd24wMDFMNyto?=
 =?utf-8?B?aC9tMzYxTHhPbnhxa3ZRT0I5bjlhMHd6UFZNcTR1eFZCQlpRamEvMWVHVGQ4?=
 =?utf-8?B?YVlOc3hwaUxOUFB2d0owLzRuWklkUTlWWHZCSVFSOEVmaGZiMEtpS1hUZVBT?=
 =?utf-8?B?YnNzQjljcXZSbHRXTDAwS01kM0hSNzI1UzhnUzAxZmlWU1pVZ2FFTlJjTGpy?=
 =?utf-8?B?Q2hCL21JT1hHdUM1RWNNOC9BaHVmVmhQVjN4eVZRWGtIREhSZnYvSC8zdi9p?=
 =?utf-8?B?bkxkWU9PNjdDTk56cGFibHNxYkVmQWxqeTZ4T2IvcVJ1bmdmeDlISUdXZkov?=
 =?utf-8?B?aHk0SlA4anJ2VGc4dnlpU1NCK2JhRzBDZGZGNitJaTVzVlRoRWYzazZkS1Zh?=
 =?utf-8?B?cDdiWXlrZDdCRkV3d1BRSVJvSGZlNnJrQTZBNkdJNEtoUkNzOWU4eEUwdzBO?=
 =?utf-8?B?SXBpMk9jTXkrdFF4clRDMmxXcjQ4OU0wUWJMSG5sMTZUaDNvbGtuUVlOVjBY?=
 =?utf-8?B?ZGlZVUxFL2x6eFVTL09qaWp3REgwbmlJRE1WSVUxTFQ2eEk0b0tta1pqeTFR?=
 =?utf-8?B?MVdlN1IzY3Z1dDAvRzNybEd1czlxVkhRemZ6bnpRMlNVaXVaWXlvTk55Rm5h?=
 =?utf-8?B?bTE2UFRyVVZ5ZGkzUW5NZ3hMeDB0L25WYk5yUzZ1OVZZYWhxMHhhSkRwcnZi?=
 =?utf-8?B?dlpXcEYxZkFXaXRSL3RRaTVsbjloOEpaYmYwVXIwL0duV3B2d3pXdCtxb3ov?=
 =?utf-8?B?RldOVlZ5WlJFaWZtSVMrQ0Z0ZnVDdE9xdVNMOFpWTlhXS2JZUUV0cW1LaXhH?=
 =?utf-8?B?bHBkNnk5N3UvSFllaHlCUTFZNlpoVFJ3YWxMZ2YxY1hQMCtFcmdXNHZxeS8z?=
 =?utf-8?B?K0l0MWJTajgreGFlcjA1Z2tSUFF4clVUUVowMm1SV3ExVk5RS0lJVlNMWVly?=
 =?utf-8?B?RWlXaVB1VjB0ZDdCMmhxNFJxZi9DTkN6czJPWGt6blFlSzYxdWZnRnUyTlNh?=
 =?utf-8?B?NUxrOUdEY2p6VWgrb1d0MDR2a1JEaVJFemY0RVFuSXpjMC9qTTZYMkozNVNG?=
 =?utf-8?B?SWVnbjRUVmczWlVZT3JocllOWmliZGtjOERuZlNkSDNqNTNPNzlheDhOdGZn?=
 =?utf-8?B?S2VvREw5NjVjU0FLdWJ3YkMxdU1YRzZqMXdGS3FzcGhDR3FNVVUwbi9vaVFq?=
 =?utf-8?B?M0ZKa0ZldmRWVjVWUWNhODAvbmd2OVE3dGJ3RXY1WUNEV25vU2dOaDRXbTRK?=
 =?utf-8?B?TUtDWDJIS3JZbEwwZHFjN2ZES2pObXdpVysrWlgyR2FUNVJFVW1jdUs3SDhr?=
 =?utf-8?B?dHhZbVN2eWFJYms2Q2lJQmxZZjVLZHVkb2thd3piR2daS1RFcWlpWFV0MFpl?=
 =?utf-8?B?NnlMMjc3Vlp0eXZuWXY0YUR5OExKRXU0YjdpY0FjRXhyMHpId0VVb2FFS2VZ?=
 =?utf-8?B?NVZQK0tGMHFSMnRsV090eXpNczhwdGhHZjRMZTVuSlpQeVpzM3B2aFJudnZC?=
 =?utf-8?B?YkEwN20rRGVPaGFnUkx0bUIxQUw1anNKR3VlcFd6QldUY1paM0dMWWlXSll6?=
 =?utf-8?B?RktoQ3c2QmRtQmFRYnQ3SC93Q0QxUXdQRTU1ZllnMTZ5RXpnU0htK3ArQnp4?=
 =?utf-8?B?aTJlWGpxamRkWjhTQ0ppRjdiSUJnN1lhMU9JbkFMZTJoMUNLUGVJWDR1TGdI?=
 =?utf-8?B?bGhWRElPRTBGMzJHNWpEU2FSaXRCOTBWVi9FMk4wM0RVUkdseXdxRmFuU3c0?=
 =?utf-8?B?MWNJa0xDY3ZVWUtHU0VsT2JNSjMvQ1MzOFFaZDI4QjQvelhQSC8zTG50eU9s?=
 =?utf-8?B?eG1BQlBFeEMrTFVWUG1xcVZ4ZmhSK29vbHN5NU5OUEpFY0htdVZOMWJIYUxs?=
 =?utf-8?B?OGJKVXFpTjBad1p4M3FuVjBackowd1RuN0lzN0FDTlIzakFicnVxQ1hhNGdu?=
 =?utf-8?Q?qiJU6etLP6XyFQiwxQFC+l7rO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a7713b-2f29-4faf-1d18-08db4cb163da
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 15:08:17.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfe4qp2GbRB0jbofRaHV1Jj8p2UJIV44uOUNondiWCdgzFtrPWs/vwMuqmUUa2vvoaNBdxgVrWBkCiRSAoUYEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB10046
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof!

On 5/4/23 11:34, Krzysztof Kozlowski wrote:
> On 04/05/2023 10:30, Mårten Lindahl wrote:
>> Add bindings for the TPS62870/TPS62871/TPS62872/TPS62873 voltage
>> regulators.
>>
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
>
> Just a hint - I in general ignore all the emails without dt-bindings prefix.
Ok, I'll prefix it "dt-bindings: regulator:"
>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>> ---
>>   .../devicetree/bindings/regulator/ti,tps62870.yaml | 62 ++++++++++++++++++++++
>>   1 file changed, 62 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>> new file mode 100644
>> index 000000000000..32f259f16314
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>> @@ -0,0 +1,62 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/regulator/ti,tps62870.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI TPS62870/TPS62871/TPS62872/TPS62873 voltage regulator
>> +
>> +maintainers:
>> +  - Mårten Lindahl <marten.lindahl@axis.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,tps62870
>> +      - ti,tps62871
>> +      - ti,tps62872
>> +      - ti,tps62873
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  regulators:
>> +    type: object
>> +
>> +    properties:
>> +      "vout":
> Drop quotes.
>
> Why do you need entire "regulators" node for one regulator? Why do you
> need child at first place. Drop it entirely.
I will remove the regulators node. I think the vout node is needed to 
get the of_get_regulator_init_data.
>
>
>> +        type: object
>> +        $ref: regulator.yaml#
>> +        unevaluatedProperties: false
> You missed that piece of explanation:
>
> "The set of possible operating modes depends on the capabilities of
> every hardware so each device binding documentation explains which
> values the regulator supports."

Ok, I will add a description for the valid regulator-initial-mode values.

Thanks!

Kind regards

Mårten

>
>
>
> Best regards,
> Krzysztof
>
