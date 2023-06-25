Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9143573D029
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 12:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjFYKoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 06:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFYKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 06:44:07 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2130.outbound.protection.outlook.com [40.107.215.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF7E4F;
        Sun, 25 Jun 2023 03:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDbgkkWs/VDzBJdyAzVSMq5I2hmuUN+IiFj4CUhJ0IKioiADzOE1pUIelWPnSARoP2VrRbyN+R3jCxS4NtITfaxqvqKLrc2i4DF2XFcPJLucPPvupipt7jJTvGE0IhiRsyRlysKdVPEJmonH8WOkG9+PQLFY2gTNq/gM5/1nsf+8KPRQ4XsCt1Vgs7ti9TpB6QgM4hwBuMPQPsnSihRqW6hfYfv0Xy52jqLcxTG0nV1v2pKRt7fzU1FdNG9zRMC5rSmPrHbV9BGPZ9kop6vnhlqHNEL7TelUhQ7nU4jFUPkZpGi4CFCdtmf1MRdTHEcIVTgb2koTWSKtj5v4wgZnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJEz8q9jWPBy7L+CnHIqe0PZjTBYEf6JNWey99BrvVU=;
 b=SdVuWG6wtN3gXNZyScBrpKTb6wVtVd9yz8zaAcalAYjs5x7sKl+WmKxjYSXLcSl3qymwGx5gs10j3iOlrHOOfc5y0J5GPfJ28kipnLC7C+CvWG7S3JqJSol4rJJa5sghqisRBT6wGQbMTjibBH/UNkZSokmxIbQ0ysSyxmrW29UTU3ukMitHy+Lgq9YDmsYrDAN2xQ/+LQBz0L0kz/GhGTM+kT47w2UuXgXVgSejxvghffumC0aqhM8quvqzwGLVJ3yf9vCGsyKT19ulUY+e91QkvqYibn5Lkd2IHR9tX5Ypf5gsYdXfUOCkKEhkJGFe4kur/JzozkuAxu+JDXjZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJEz8q9jWPBy7L+CnHIqe0PZjTBYEf6JNWey99BrvVU=;
 b=e/G891IYqc8EDbjA6y9N11iViasXAZEG/C3t/cFjYULmuSf4M5FUGqYfiKPnC5IEBDswFM7pAZ+zCAxFYvW2CJa+x0bPp5+tKHg1Ze0K4ZKDt1FP8IjzHy6OHotrTqFAUviGZ7NME9lfVGaDdMZCGeoWPu4d/aGfG6RDIKx8bVsyTmyPD0JnAPl8Xdy7r2GDRsbasw83QkZkS4SpHg0CwGaobeFZq5V6LcAzt1mPcsq3cnb+aBbYK/SVa+jXnm4SnufY5jglr37YEIoPS0o+0GiqxbapfW80kl3no2+VVr4NdKGqgng43goQHWkNUtF1DmolknZlDPeiqC7D6twrlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by SEYPR03MB6673.apcprd03.prod.outlook.com (2603:1096:101:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Sun, 25 Jun
 2023 10:43:59 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8c09:1fbb:8f34:685c]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::8c09:1fbb:8f34:685c%4]) with mapi id 15.20.6500.036; Sun, 25 Jun 2023
 10:43:59 +0000
Message-ID: <57af9a3a-058f-5e11-f681-58928013f0f0@amlogic.com>
Date:   Sun, 25 Jun 2023 18:43:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: amlogic: add Amlogic A311D2
 bindings
Content-Language: en-US
To:     Lucas Tanure <tanure@linux.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230623081242.109131-1-tanure@linux.com>
 <20230623081242.109131-2-tanure@linux.com>
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <20230623081242.109131-2-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::32) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|SEYPR03MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: af9cf33f-c112-47d5-db92-08db7569148d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y3SBSp4FC89QbjKwR+9D8ib2bSnWeUjwaXN1AiWh5KYiN15wPhat7Z27NnSF4T+1bQR43D1ySDbO34VKR2V4fRnti+FKLCmO4/omzgaFwpPpgPUGE1Ykl2cz5FHSDoHjDaFi8+kpOJvsEOfIK2Gww73rSKJUGNFnBqmL9RmmlA8wUbaVFWkfpX1rfCq4gI3MWCC11kUWkLDhRVVHyf/3hEVzgSEyOGydTMhuG9GJrSgWhQfpSdcdGyQoj2Td6giNIdVCjOswXoBlnJ92f3ThU2QMuvVxgFgrQMxnmJsrr6evvAInHSm1lucK2r2dQzo/KZ0I6ZfobYYzKQ+pilcq8xk8q1wWJIg5j58wAWEYo3ZA1Ya3TosnrGRrgswpkvk3TDh42aRcA34CZXNuSMOGlozxCEn2+kJB0lym5wDy/x7HbQDxziVhi5Jf9Xk/mNR26nb2eDo29Bjzn8F8acGRgs6wq3VNL2zcmJAMTRv6os9pKJJ9F0gGksMwHuTFz75G4tNvmZXFQRa/ktHA2L8LFsZekHt8hbdW1u9dRRGMwXtti0wLoovL6+PPcw0Get+uAODaPWEid/ah1i4kYDPZ+okHGh1ph4AO+gf13nkyu8gRu1aUtrmqlw55NRg/DTgAwLwfXLhBbsUbI0fvGtzvc0Sji2jyhukXusAgOlxA8EEVYbrw1hId172Hpbbt4i4y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(136003)(376002)(366004)(346002)(451199021)(36756003)(316002)(66946007)(66556008)(66476007)(4326008)(478600001)(5660300002)(8936002)(8676002)(7416002)(31686004)(44832011)(966005)(31696002)(86362001)(110136005)(54906003)(41300700001)(6486002)(2906002)(186003)(26005)(6512007)(6506007)(38100700002)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0xZMFlEME9DR2c5KzVLUmhMbnNib0FkeDdIRkFuck1PcEwxMWQ2QXdtbGlO?=
 =?utf-8?B?SllQc3dBUzR3YlkrU2YxS3pwcnM5Y1pwTUg4K3grQUlORkVzVzBGNHFlelhk?=
 =?utf-8?B?TXlrdUVXSEc0WVR5am1uMGh6YVFhRFU2WGVVek55bGNBRXZOQmFqbStJVDRS?=
 =?utf-8?B?VW9mVWZlZXB2T2ZXSTg5WHA5anFqcXhXTXFZMjUxQjE4NE16Y2tQWExZUGEz?=
 =?utf-8?B?OVpyNmZEV3ZtQVJONGdPMXpBTGMrMmMvNTZRVldqd3p2bWxEbGxUeUNSdGk2?=
 =?utf-8?B?b0phOXRVc0JpbVhYbm5NV1ZIbmZzZ1lObWpQNVJvcFRtL3B4T3ZNNmNZNWhv?=
 =?utf-8?B?a3l1MEhndUh6SGtjWTU3SStyeFVoNEIwc0FGRFZrV3VQWGdEb2Y5bER5TkxU?=
 =?utf-8?B?TG9Sb2N6MVJJaHovY2xKSllSSzV1eDhhU3MzeUNZditjajIrTEFIVUliRTBk?=
 =?utf-8?B?aUtQdUtyekRqaEdla0VoZGtLMFZMUkIzczZyaUZEci9MUUV0TklQQU90STFa?=
 =?utf-8?B?TFVOOWFmZlVPcm8vbnREbXFNUFlXZm5Fc3pwaWp2Z1RyV0l0RTNWUkZoaFMx?=
 =?utf-8?B?VS9zeVNndlViOHFYcUwvUERsRFREWHpOQkZ1Wk5rWWpJeENCak9CaGpIVjFo?=
 =?utf-8?B?dWdhSU5LczAyZXZjaGJ4MWZTd2xvcWQ4M2orNTZodnRnMlpGM2tPbmpLRkEw?=
 =?utf-8?B?ZE43ZCtXZTZHRjlDZzZwbDRhMmF2VTN1N3VIa2VqUVA0K1dwWU9DdkFtQkhW?=
 =?utf-8?B?alRpTis1eGRPc0F6dFFQaFBjK01GcElVZm1oYlRsTTFTZTEwSGd5MHBrdTdC?=
 =?utf-8?B?Z3FtSXBmQTV2NmUyUmVWMDNwak9HV2Z0YTI2L3NHN1N5WUh1MHV5NHBwcWRi?=
 =?utf-8?B?ODljRHpyamZMbGYvdFgrYmU5M2hKRWlHcXFYdlRoR204Z1VYSnZIazJrWnJO?=
 =?utf-8?B?Tjh2TGo0VjZEZG9sRjlNUU9sL2I0Qm1qaS8ydjlTeVkzQ2hEK240OExHVklC?=
 =?utf-8?B?VWN4VS9hT0Jjd3k4UTJDL0grblFSMG5vVU1YcmJZd2E1eE9KQWpabjdJMVpn?=
 =?utf-8?B?dVJ3Sk9ldFN2dytXc2tSMXNzMmRVOUNseWx5encvY0dkNGdlR2JPYVV2WDBi?=
 =?utf-8?B?Nm5TMDcvMUdlTGtoYW83b1hLaFRDZUhvNUNYU2IrcjF2WUFxRmZ6RU41R0tM?=
 =?utf-8?B?Z3FZMnE1RGsxTGpWYlFxRklUcHBqNTl0a1FpeHZWMERTYkl4cWN2QUJFeE1B?=
 =?utf-8?B?RjlIT3pGN2orK2hGem1jNDNwN2J2dXZkcWVsOW5Tekg5ZWVRelhiQzRXMmpv?=
 =?utf-8?B?L3J3SXR4RE95YWhsNXFSSjBEckJrdEYvbDcvb3Y5QlNSZFpXNU4vY1BZQ2ZO?=
 =?utf-8?B?RjNhRkQwNElKcmtrYkRWeGI2Sm9qR1BabzNlNU9RQWo2QkVwT093bzRELytN?=
 =?utf-8?B?Rk1UaEtleXZpK3hHc2xKRUtvOUQ0M3BHR2tjQlVSMUlCTUVCT2JZdUI2aG5y?=
 =?utf-8?B?NWdlOUhvbWpXTURlV3h1VmVBcTNiNWp1ejltRWVLd3BUNnBYeXcrcHN5Vi84?=
 =?utf-8?B?R21mZnQ4UUg5STZ0ZGZCdlExQTBMdGZPWGZVdGQ5OUY3Q053M1EyODJub0ds?=
 =?utf-8?B?akV0RkdBUDhnbFRkOWRlY1BNb3BHcXREbEhpb29PK1Z4V2ZKOUIydlBtNWJG?=
 =?utf-8?B?VWFHV1dRWEptc0NPWUhadGlMR1VsQm9oYUs0OTZKNXFRUVpvR0txQWtLWVN4?=
 =?utf-8?B?RS9XSG16UWZvTDBPNzJWcmlwVVQ2bVMxaVdNZGhwNnJuMnZiZko3WmNza1ZV?=
 =?utf-8?B?WFRVdVF5ektBUzYzZWNrSUU2aitGbklSaDhNK2VScnFkVnVaYVQzN1UzZ1Ur?=
 =?utf-8?B?ZXdMVVpaR0llV1M3QWdWcHFRUFRSbXI5VHIvUlhLaXMwOXppUjlYbjBZRm4x?=
 =?utf-8?B?R0xFS1l3a3VNZFBZaGxzNXE4RkVvb3o2Z3VKSVpTendoRG5SVnllbWpYalNQ?=
 =?utf-8?B?c1JqY3prcUtwQ1Y2dFhRTlJnTFZMOFR2cDVBeitxc1ZHS3htT1JNZ3Q3UWtn?=
 =?utf-8?B?bzRaVG9ndTJ4S0R2L083dW56UCtnQzBJUzRuT0tuQndEVnBCVFBuUTl3VmR4?=
 =?utf-8?B?V0JuVytlcG15OElZN3pBbDUyUHpjdXU4eE4vS1RoUVpWSGZmZjAxQWs1RzZu?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9cf33f-c112-47d5-db92-08db7569148d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 10:43:58.4367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHFkRxSRs7Qn3078/zSkX0cm+n2ZGNlKkkJP3FKz12nzyZya9vSuDKOVcxE+eEv85apdOQ/YJWwG7eAStbLWVq1oSGnbuqxYsmT/KTiLFdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6673
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Add bindings for the Khadas Vim4 board, using A311D2 soc, a Meson T7
> family chip.
> 
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
> index 274ee0890312..8dbd65170c50 100644
> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
> @@ -211,6 +211,13 @@ properties:
>                 - amlogic,aq222
>             - const: amlogic,s4
> 
> +      - description: Boards with the Amlogic Meson t7 A311D2 SoC

Lucas,
Based on the previous discussion, I strongly suggest dropping "Meson".
T7 is designed for smart display, which does not belong to old Meson series.
You can refer to S4.
Also, t7 -> T7.
Thanks!

> +        items:
> +          - enum:
> +              - khadas,vim4
> +          - const: amlogic,a311d2
> +          - const: amlogic,t7
> +
>   additionalProperties: true
> 
>   ...
> --
> 2.41.0
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
