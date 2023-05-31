Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5035C718022
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjEaMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjEaMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:42:40 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8A123;
        Wed, 31 May 2023 05:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOXy/kgSa0EBMdOI6fo93ybnNqHyusQGhzSzxNp8e79R5zDxVCYNQm5ZvtW/v3wMzABi4uqpRpac9VVjeMZNkMIHIUXYlBAaaNkKMpjYaBSsapkYeB+7vkOp66IPnEv2AOXQ6C7XxOEjTc8BuBY4+a1F1E6INYK9VbQ0iJ6lc6uHuAdu558bkIseCSZhUv5a5zGKZOfZ7FccVojsRK4qDWpCIFlpKibMo+RPZcz2jJuQcAKa8Knaadr1NjHFJcCJj/VCnjfmsXA9ari/J7K9agoW8FhL9PYZ1jXMLuDYERDv/LbFB+x7rLuOKpKPG+t8hoiQISpZ9ap72lfGEj/a+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueuxam54SkPyIyXm6rvG6SVCjuZma0eopc5+OBMBUAQ=;
 b=ZLr3CKDb8y//R2X+tzwqCm0mz849car2uloUgomdsTL6hFCX4UtrXqePe43DJgxcCzPh516x1qB26gkH/YOZFWaZqrxMQR8TI0jRTfVneapLHSnYSJOSs9Mf4G05/F+YQrE/U6X89SD55v9jhV989xc6wvBD2PbQnZwMSfQi8zAmOmCydaxdAp+j2phqnZl7tF3pcLmYtPLV8SVLICqgSf5DOtDeZlRQ0fQEf9Co2bC0y+joZdkuj5Ljm5tFEcQcD9LSOidpLTL+c1i3xM0xx7tcgFlreOV6SVL9IRAaKre0b+bY5UBgJqMSGBzKgdXUSL/T7bbuR1W6MbUmMD4qZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueuxam54SkPyIyXm6rvG6SVCjuZma0eopc5+OBMBUAQ=;
 b=vyN/IV/FCh9NLS7U+YISqjA/x9AgIR578xdDDUpdEoDfyJXyFwrW3W3lC7H+QozYeT61HQtHU3obqQ+UZOk+EbU5pDbzur27NsMcv1FNGE5xr+F/OHNeH+yS+/q24vB7Q+WQBvVJeCqmw4uKaFdB9AEWh2ZngGQSetfyO7EMKkfV5KJXujnSaoaSqAdGWf/o3ocDAt0wGfL/XiTc0lLwIo/lcFsp8aN+DB4umW4kUfEGJbX1AHiyK2bBgNjZEUw7O6faribqt92ogyaJL21KZrlCe/mUTI9ftwndDcX9A+lr+5USF/ryvtD9oqn7vcu9R4tvFwkFjobuqmO1qxkGYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VE1PR04MB6432.eurprd04.prod.outlook.com (2603:10a6:803:122::21)
 by PA4PR04MB7904.eurprd04.prod.outlook.com (2603:10a6:102:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 12:42:34 +0000
Received: from VE1PR04MB6432.eurprd04.prod.outlook.com
 ([fe80::67c2:e2af:275c:6b89]) by VE1PR04MB6432.eurprd04.prod.outlook.com
 ([fe80::67c2:e2af:275c:6b89%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 12:42:34 +0000
Message-ID: <31f25021-aaf5-a6ca-049d-bb47f62936b4@suse.com>
Date:   Wed, 31 May 2023 14:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: thermal: mediatek: Move auxdac binding
 to yaml
Content-Language: en-US, ca-ES, es-ES
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        matthias.bgg@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20230530150413.12918-1-matthias.bgg@kernel.org>
 <80108a00-4416-a419-e45a-e5e4c1f111a8@linaro.org>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <80108a00-4416-a419-e45a-e5e4c1f111a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0063.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:31::27) To VE1PR04MB6432.eurprd04.prod.outlook.com
 (2603:10a6:803:122::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6432:EE_|PA4PR04MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0a95b5-ec23-4f20-04f4-08db61d481e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y5jm5SDFwmo/LKOz8KraZ/5AZKCZ0VovDUQSIoqPJqt4U/5q7Ts8MxC2ZeHsMAuxE/SiJwRFLFe8ScRz7AgZNKaJg2VlK5oR037PujJRp65obHJGSz9EBjCBYQmniDJF3EH7gQqAMMOqsBByGYa1zrBBqb6+qUb0MfaQSUldo6JIQhQRMxKTmxF72AcBJMnxfbl6yv80FV18IgbU4tlPo7iX1ycoO6F3TYYH9K1/8g1QU521a3X0BCJV36UhC1WVFag7MDp1FIfi/2OmLC34/SqyV2y7bIbYH02S9PvlU9yqnlL1FeASzd3k5G/ZIG58Uauh4RTfn6E8yswF/AG6AVNF5Nv99tBZFi0J1uj8yqgTnshQzr3B002637I+t+R5WXoSyAter9vkqdf5AQIfCVh0PvYpY+mia/gr0p5XK8TB0fdskjlTKcuqnHLLtfZ1aDmGX18HqCNap9tnw4oJavElDa63xkgLw/GyaKELNLN8zfZZkAUxJ4c9bWcjuUUozFTCqpp5KkSBotjiU9FPguhX/R9gxM5iCobTbGxGn+wnsUTSLcn13T4gkM2ucFk6Uwnn/7MlQYs0VnuWWJl9RedPkHjyo7FqlwI8lM5KkFiCpixt9S3Wp1odpEI/yt0Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6432.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(7416002)(66476007)(66556008)(66946007)(4326008)(31686004)(316002)(41300700001)(2906002)(5660300002)(8676002)(8936002)(110136005)(54906003)(6486002)(966005)(6666004)(478600001)(26005)(6506007)(6512007)(53546011)(186003)(36756003)(83380400001)(2616005)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVxTzZGeHU3ZXlsSEZONGIwMXo3M1Q2ejNUbElCeEdIS1lZRFVZOVovNVVT?=
 =?utf-8?B?bzBabGRsM0pLTzNEclNXKzFMM212cEcyYUxnME9ORjIzOTdpc1NkVHF3dWcy?=
 =?utf-8?B?aDZQUFF3d0NPZjNvR0hjK0ZDQUg1aERPVHZpOXc0dnlWUU9laEVzK2pheEVV?=
 =?utf-8?B?TlVrekIxV2xIUUZBeTZtNHU5dm5zYWVUZjBQK3lDZGVsc2ZyREg2UFM1U3Vj?=
 =?utf-8?B?TDUwVWgwVnpqREpZcFRwdEg0emhrZCtTODlvZkplelJ2MEtLVnZXQlZWNGJV?=
 =?utf-8?B?UkN0U1dIZXhWdDI0eXlFSGZxNEo4NUgzMWFlRmdEcklIYXFTbG9LRCtVMkE1?=
 =?utf-8?B?MDRMSFA4NGVzRmlXazh3eU1pTjRaR0ZFOWtlaHZMeXE5MzlTYmdRSHdmRUo2?=
 =?utf-8?B?YjZuRm5iWW1uNDZGUnlscUZob0s2QUdXUzVybU1pem1VWlllWk80Uy9LYjJB?=
 =?utf-8?B?WEQ4MGpUYldUTUtPRWVHdHhBNUN5OGJ4M25jeVEwemMwSm9QK0RGckYyTzR4?=
 =?utf-8?B?bC9rbGlZbEJvMlR0Q053ZXdXVHYyNGpvMW1ra2VCWkFZZjB1NXl0TXBMQThU?=
 =?utf-8?B?QnhMYjNGb0dDazZSNVB4bkV1S09PNXlkamdlaG1LMHBxMXRhRkZiZGFtU3Qx?=
 =?utf-8?B?RXNZVDRtVXIxWkVacHlENE9IcDVsd1NCNUlQK3ZYRHRQelk3TTRnU3Ayei9u?=
 =?utf-8?B?eFlHZnhIMU1PWGZ0RXJsaUxhbGYrZUllY1RnVG0xa01Jdyt1ZjhqNHlQL0p6?=
 =?utf-8?B?cHowVEVnTjVGZDluQ0YweFVQcmpOcnhzWmo4Tm8xTnlESlRPaXBicUpGRkZZ?=
 =?utf-8?B?MUR6c2c1T0ZNWEtVV2o0TnNNaEJXNnAydXA5eVZ0UWJQSXhCNmFSeFhhdTJx?=
 =?utf-8?B?N1lzYkR3QTcvamNFK1NnUmJ5OSsxdEJlQWdobUJ5Y2YyZW1mbjhvWkpic0Vn?=
 =?utf-8?B?MnhUQ3FyUk5VbEtQdEhMQU1ldWlLZmV0NUV6UmRVWEN0QmJ5U1ZaanR0bGpK?=
 =?utf-8?B?M0Y1R3Z5SkE5YVBJRGtlUWdNemJmNjV1ZDNFZXg1VFNzWVhtRi9LODNPMDlM?=
 =?utf-8?B?bndaT1NOMTNuelQySFpveFRxVlByQ0ozVTRteW9YQm14R0VFMFB4SG5FQ2Zn?=
 =?utf-8?B?SndmZTc1TVJra1R3VG1JNjZLM0dVSWdZVzNWOE1mQVdCSG1oQzQwUTk5Mk9w?=
 =?utf-8?B?Z0hjb01XMHIyRGk1RklYM3NjUmlkRTZObzlSVEd4S0wxRjQvY21TUmxYNzA1?=
 =?utf-8?B?MFM5TFl1dmJLNytiaUNuc3l3d0ZDbExEcnNnYmJ6RzhBNWZJV1htYjBiRkZu?=
 =?utf-8?B?bVFxdE5aZ1pXNldBc2lQQVZCb2FlMk1HUThIUlB0S01SZXBpVmpEZFYydnMy?=
 =?utf-8?B?aTU3ZXA3K2x6Q2lpOVcrR0p4d3hINjZRWTIyU0EvZUg4STdqcWFFc0FTZGFM?=
 =?utf-8?B?cHFhcmQwK0tJeWRFbDBpR0RXc21OODV0M0Z2b2hZWXpGNlBHbDhCdEd2c2pk?=
 =?utf-8?B?VlhCRkNwVUhPbE5YaSs5NFVjb1ZkdmFQRVN6NzN1SmhlbDNWNGlZeFlKcFdl?=
 =?utf-8?B?ajlCM2gwWi9CUzA5R01jWnRqN1ZWUjc5R0dMWFBsOUNjQktkd0ZrL1FndWF5?=
 =?utf-8?B?SmZzbTYwRkFadFF0VkhmcmM2b2JCL1BCeEtzcnNKbDRJV2loZytES09JeGhK?=
 =?utf-8?B?Q2xkYk1IWFdYV2Q3YTZwV1pqNHdYOTVvQ2tSZFNWN3laQXVZNitQcjB1WFQz?=
 =?utf-8?B?R2txU1o1ZFBTbkhqbURBazBLTWMwakJxQkJQQ3kzU2dXREJFNFpLSXBzL1Bi?=
 =?utf-8?B?RSsxc29XaTRNSFRzM21xVDRsY0Z4cWEzM0JXb1gvam5BcXJ1UERDQmwrSWRv?=
 =?utf-8?B?VkZEVUhOTFVkT3Evc3N3MG9ISDJsV2FzaklnTkdnNEpUY3N4ZytFMklkNkNr?=
 =?utf-8?B?bjlPelg4QlJaYTlCeVlwWGFuUnRxcXNuSGwyNjRnOU9pMFIvMXJFOEZMVmZs?=
 =?utf-8?B?TlM3MWVvQUg3VkFDaHdab29qK01FbjZzNU1tY3NBNmI4cHphNmFVWVA0cjh5?=
 =?utf-8?B?VlJoZ2Nja1NKQU02Tlp5ODdJSFZGODFTenlDbDlGUzRYOFltQWJpK0daQnJh?=
 =?utf-8?Q?T5eIdMfxxWoH48ztAQYpjUjIZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0a95b5-ec23-4f20-04f4-08db61d481e4
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6432.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 12:42:34.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdD/ALnCAFE+YDgs/BYdm67xIYKP1DlO0ZfYMv7c/lQIAOTf5vNYzSiMgHHc4eFNT2rqGRecNSCvlL2ZmjYQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7904
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/05/2023 09:57, Krzysztof Kozlowski wrote:
> On 30/05/2023 17:04, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Convert the older binding to yaml syntax.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>
>>   .../bindings/thermal/mediatek,thermal.yaml    | 168 ++++++++++++++++++
>>   .../bindings/thermal/mediatek-thermal.txt     |  52 ------
>>   2 files changed, 168 insertions(+), 52 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
>> new file mode 100644
>> index 000000000000..7aa2bdc43567
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
>> @@ -0,0 +1,168 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/thermal/mediatek,thermal.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek Thermal Sensor
>> +
>> +maintainers:
>> +  - Matthias Brugger <matthias.bgg@gmail.com>
>> +
>> +description: |
>> +  The MediaTek thermal controller measures the on-SoC temperatures.
>> +  This device does not have its own ADC, instead it directly controls
>> +  the AUXADC via AHB bus accesses. For this reason this device needs
>> +  phandles to the AUXADC. Also it controls a mux in the apmixedsys
>> +  register space via AHB bus accesses, so a phandle to the APMIXEDSYS
>> +  is also needed.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - mediatek,mt2701-thermal
>> +          - mediatek,mt2712-thermal
>> +          - mediatek,mt7622-thermal
>> +          - mediatek,mt7986-thermal
>> +          - mediatek,mt8173-thermal
>> +          - mediatek,mt8183-thermal
>> +          - mediatek,mt8365-thermal
>> +      - items:
>> +          - const: mediatek,mt7981-thermal
>> +          - const: mediatek,mt7986-thermal
>> +      - items:
>> +          - const: mediatek,mt8516-thermal
>> +          - const: mediatek,mt2701-thermal
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 2
> 
> maxItems instead
> 
>> +
>> +  clock-names:
>> +    items:
>> +      - const: therm
>> +      - const: auxadc
>> +
>> +  resets:
>> +    maxItems: 1
>> +    description: Reference to the reset controller controlling the thermal controller.
> 
> You can drop description, it's obvious.
> 
>> +
>> +  reset-names:
>> +    items:
>> +      - const: therm
>> +
>> +  nvmem-cells:
>> +    items:
>> +      - description: Calibration eFuse data. If unspecified default values are used.
>> +
>> +  nvmem-cell-names:
>> +    items:
>> +      - const: calibration-data
>> +
>> +  mediatek,auxadc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      A phandle to the AUXADC which the thermal controller uses.
>> +
>> +  mediatek,apmixedsys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      A phandle to the APMIXEDSYS controller.
>> +
>> +  "#thermal-sensor-cells":
>> +    const: 1
>> +
>> +  bank0-supply:
>> +    description: Regulator node supplying voltage to the first bank
>> +
>> +  bank1-supply:
>> +    description: Regulator node supplying voltage to the second bank
> 
> These were not present before. Mention this in commit msg. Also drop "node".
> 
>> +
>> +
> 
> Just one blank line.
> 
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - mediatek,auxadc
>> +  - mediatek,apmixedsys
>> +  - "#thermal-sensor-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/mt8173-clk.h>
>> +    #include <dt-bindings/reset/mt8173-resets.h>
>> +
>> +    soc {
>> +      #address-cells = <2>;
>> +      #size-cells = <2>;
>> +
>> +      auxadc: auxadc@11001000 {
>> +        compatible = "mediatek,mt8173-auxadc";
>> +        reg = <0 0x11001000 0 0x1000>;
>> +        clocks = <&pericfg CLK_PERI_AUXADC>;
>> +        clock-names = "main";
>> +        #io-channel-cells = <1>;
>> +      };
>> +
>> +      apmixedsys: clock-controller@10209000 {
>> +        compatible = "mediatek,mt8173-apmixedsys";
>> +        reg = <0 0x10209000 0 0x1000>;
>> +        #clock-cells = <1>;
>> +      };
> 
> Drop both examples, not really relevant to thermal. It grows the example
> with code already documented somewhere else.
> 

auxadc and apmixedsys are no examples. They are referenced by the thermal node 
as described in the binding. Without them the example won't be complete.

Regards,
Matthias

>> +
>> +      thermal: thermal@1100b000 {
>> +        #thermal-sensor-cells = <1>;
>> +        compatible = "mediatek,mt8173-thermal";
>> +        reg = <0 0x1100b000 0 0x1000>;
>> +        interrupts = <0 70 IRQ_TYPE_LEVEL_LOW>;
>> +        clocks = <&pericfg CLK_PERI_THERM>, <&pericfg CLK_PERI_AUXADC>;
>> +        clock-names = "therm", "auxadc";
>> +        resets = <&pericfg MT8173_PERI_THERM_SW_RST>;
>> +        reset-names = "therm";
>> +        mediatek,auxadc = <&auxadc>;
>> +        mediatek,apmixedsys = <&apmixedsys>;
>> +        nvmem-cells = <&thermal_calibration_data>;
>> +        nvmem-cell-names = "calibration-data";
>> +      };
>> +
>> +      thermal-zones {
>> +        cpu_thermal: cpu-thermal {
>> +          polling-delay-passive = <1000>;
>> +          polling-delay = <1000>;
>> +
>> +          thermal-sensors = <&thermal 0>;
>> +          sustainable-power = <1500>;
>> +
>> +          trips {
>> +            threshold: trip-point0 {
>> +              temperature = <68000>;
>> +              hysteresis = <2000>;
>> +              type = "passive";
>> +            };
>> +
>> +            target: trip-point1 {
>> +              temperature = <85000>;
>> +              hysteresis = <2000>;
>> +              type = "passive";
>> +            };
>> +
>> +            cpu_crit: cpu_crit0 {
> 
> No underscores in node names.
> 
> 
> Best regards,
> Krzysztof
> 
