Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C112D6F013A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242959AbjD0HHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjD0HHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:07:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912F2269F;
        Thu, 27 Apr 2023 00:07:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAghhbVQjNc7Wc79Ymsq9vKsAvLTTWn2IynRXUP6MtgxnoMUPJJSi5Rhkc4VPC/YYbVHxWFJmvrdQ4P7RZ+8jzYKdTlQn1+KzSz2FsGiR69YfNBKnkdmrf+t+ZtGHHifUO/GrBZKKGiil3k1uUNNNKM5BwT9Ae6uzpxi+RWVuIblji3LgdsoTCaLrUh6BJNnQ3gm4MFukXkH3VdKmDMaUHpyz+fLo15lmsWvs+vh6qeqyQ6zRUPQ4Rl6jM95VzfulTiQIQSpINXrSt7CeCjvlZxT2tk5xHIQuTw+ly/ikcGUHD9kAhQHi866HieZodY81vggTevmJ2xHd6ZcKTNDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nW7n2r71aOAiQItAoLWAilVTajs1vVUk6EETqi/XH4=;
 b=lSSZYpHzzk99/Lao/5tiPiB4aaGO3oWTMm8Yc3dctDvmv2KO+PIDK0c3MYA/4aih0+tSojkX7PW0fd/i2yH5NgOQRyykuKoDSBl5nezCWQxFscmNJs3SGr3A/cJKNTmiA61OmPWWXTGaf1G7A7JIWUqK/nKBpUXiP68lXw1/DhIqWZelGoqvKbtD89nyQp0KE9ATaHOJaPWSLEIjaLvBtQhix/FXq7iHXvi1KsKcjHcaf+8SILPaPF30oeJiE5DxVazautOb1/YGE1ZSD+O20auZ4qmECgzPzv2s2s2aYL1g73Xr7lJf5/cVi5iL9+FKiKE5Fwydos7+bX61OQJIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nW7n2r71aOAiQItAoLWAilVTajs1vVUk6EETqi/XH4=;
 b=DvGn2hWABnGkvDaeFHw3xWOB79Ph5MnC3TS9eCC90a2rdck1x+jY1Ha7zJfZEAXwaSxczdk/PiLIjzY116XHv0I7h02Lk/4ujrLzNEMFc8pOrwxxq5Zb8KSf5zEcxY6VSMBsNYR7GrU6Vf+TCoatgNJ4K7iFshOo1ABScKrF0jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20; Thu, 27 Apr 2023 07:07:34 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8c5f:e48:a658:7611%5]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 07:07:34 +0000
Message-ID: <5bf0e975-d314-171f-b6a8-c1c1c7198cd3@amd.com>
Date:   Thu, 27 Apr 2023 09:07:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v2 3/3] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Content-Language: en-US
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Peng Fan <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1682513390.git.oleksii_moisieiev@epam.com>
 <a361b227a273315fe9a9b822419863f0eb59bb46.1682513390.git.oleksii_moisieiev@epam.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <a361b227a273315fe9a9b822419863f0eb59bb46.1682513390.git.oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM4PR12MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 207a72fd-1111-444c-4dc3-08db46ee135e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVERH/iFU8RilMYmjoFzKPgYroBFMWpOgsxjUfW/IRdSRcztYvSrNL2bidDitG/rq7MtJ0kBO/XJp1aoVd6A5WLtZdzbP1os1pAL0CSEJ9R8gFoEZv37xn2HuG+s9KbU5nSsK73PmgjWk5DXSeDVO5MVmLExBeo5tNqtRj1tMS1hm4o52GDqpctQRllezp7SbEwP/dPN8q2BXOZ7qfZ/xYNteO00oIIjAbMfHXjleCTDUitto5mAdNzuErGiq6uxNeAegmKMk3YAd1e96G2iEIebGRnCnHIZqdpifJjQKhIm4qNmjZCVzeSpuTcqaNPtCr3ONBGcO8nK7l9FTNFIKgMLU6TNyTq6QlL8t+7+yJCwPxyfKwo5x7xC42478i4GH3M3rFAoOPKmcIHnQOb8EuAtJ7FeOhU/SWn+wp8q0lBfrw5c+BLADJS9xx7qEsJacWbtALkXHsIOY/s1SjPdT5ghXmIWGinlotVj/00tKmKGpj6zmak+brS5EsxwK9Gxm4VaeNCsaQr/9rys4UQ2vRuRVNFcPCUOPXhV3FmEw8HWZQNkXn22P+NV0Fe2d6QqO6HFN0KizzTqoBwxUk1rKRhFrCjkx5dkMV6tAgOjwpgtjbBG/QMeUVdH+s9Dqw0hZrUF5oUVGoHYPAz3Jh8jqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(6486002)(2616005)(53546011)(6512007)(31686004)(186003)(66556008)(4326008)(66946007)(66476007)(8676002)(8936002)(44832011)(2906002)(5660300002)(316002)(41300700001)(26005)(6506007)(110136005)(86362001)(478600001)(38100700002)(31696002)(6666004)(54906003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZlOWdZSU81NlJjNVZIU0MyczZLS2txWkNzVE5LVXQzZzE4YnhmRnMwcUdj?=
 =?utf-8?B?SytMMjJsSGRqQzNlR1A0ZlpJc2l0VjVxdjdqbHh0eERNdHh0aEprQ0FSOWhD?=
 =?utf-8?B?TlR0OUNzdTJ1Y01IRC9xME5pYmJlZ3JYWkpFeEN6MVM2WnpkaDVPdlY5TTIy?=
 =?utf-8?B?V0pFV0VXcGpNbDJsdVhkcDFMT0JKd0RobXdpUUVOY3hOUFdCWXdiMTlnVVNz?=
 =?utf-8?B?aC8zRTZBSmNxSXpBOXQyeVZZeGZRaEdnWWdTcVJCYWc1SHhvdGxUeE1GUk1W?=
 =?utf-8?B?WTg5cnBFK1NRWCtScm41dkxrdFRnNThtUGpYbllSdkd4K2JDTXV0M24yRXU1?=
 =?utf-8?B?TWFNUVBRMHd4N0cwZHVjbHdzRWZHalU2SUpBaUFBNjM1VnlUaWVMZkF4ai90?=
 =?utf-8?B?YVJGMytEUXJXTmVKZG9Sd0t1ZVJFdHpOaUlpd2ROKzQ0TXY1QThBanY4bnha?=
 =?utf-8?B?Ri9hZnhtN0hHMFlaMHlrWFhTMEttTzMrTnZ6NDk3NXJlU2NzWDlkMFVJdE1J?=
 =?utf-8?B?d2gzOXFWR0t3ZC90NXV5UndKS09SNmtDc2FFc0p0NVVNdjhIT3p6K0Y1Wlo2?=
 =?utf-8?B?ems0NEVPQzltTFhVRFFzSVN6cjN0ajJ3WUgxaXJhOWFzOVcyaFlGZVdXcXpE?=
 =?utf-8?B?YUR2NUVqdElaU09zQTlVSERZSGNybkU4akVqbk1ZclFCUmpVSGl4SkJJUWMz?=
 =?utf-8?B?dFFLMFlYQ3pwbXZDMmxBWFN1Q1IvK2VicFV3Wmp5WDg4eGdDWnU4RWZjK2tu?=
 =?utf-8?B?Y1JRZ0ZxbC84WWhpM2VTc1p5U1NpZkorVGlxYXNjMTB4a3FiKzdTcWhYVnpI?=
 =?utf-8?B?QjM5eWlTdDEvWmxLMXA2SGpoQWVSS2VjNFdPcmc0VGNmY3ZBQ1ZzYytCdnpS?=
 =?utf-8?B?RDcxNSt1YVRZNGVFVEEwb0szTTZlOWcrbWN5azBYMGFqRDhqTVJ1eWd2U3Mw?=
 =?utf-8?B?d21lT0xDa0VHbTNxVktZVFo4Rzc5U3VIVEd5T3QzZDc1MkV3UzNMK2ljNldr?=
 =?utf-8?B?V1BBaDVocG1hdzcrQ0laV29OWFBxZ1llbjhsNU9WRVp5MjN0Ly9qVjkvbUN5?=
 =?utf-8?B?RzAxTW1DSXRoRWV1cGo2YTQrM0ZSZmdnWVBaQnRQZkswS3NXTENLY2NEWE5U?=
 =?utf-8?B?aDNMd1JWU2R4ZE1SRlVMWlNXeVZXR1g5WUZ2NXI1TmFUM0NESDI1WU1wU2xP?=
 =?utf-8?B?STFQbWJVZ3hRWm1hNlZYenNxeFhha0xwcmNERXBUVnBmZ3NDazVHaitlc2M5?=
 =?utf-8?B?eFdDeHZ6cjB2cXRaVlQvV1Jxb251Z3RzRnpiTWJETWkvMWlQOXhLNXh5SW5s?=
 =?utf-8?B?a2ZDUlRxbVlWVnN1UGZzZnhWNTFWNitxU0YvWHp6UkZQVVBYTTdjdTZIbW1s?=
 =?utf-8?B?anV6THZuaEpTcHpIMjluSjBUN1lBNG4wSy9ydXFTVVJTRno3WEdzMTF5OFAw?=
 =?utf-8?B?bCtINmliNzNiTk9RQXJJWlNIWXQ2VGJ1RjY3MU85N3FTbzI1MU1kWGlycU91?=
 =?utf-8?B?UkdtaDlCTlpZNS9ETUhteTNwQjhaSGtLZnA0ejMzNjV0SDhiMEVlUEVrUUxN?=
 =?utf-8?B?YXd3STJvcTgxMFlEVjJ4T24wMDErZlZPS21aRktkYXo2ai83Qnd3ais5Znh0?=
 =?utf-8?B?aUNCYmttQzNESEFBaTNMNE0remtQclN1YjF5RlhXZ09DTEJGOUFNZjFUWkx5?=
 =?utf-8?B?QVcybndaa2QvNEM2eHYvT2FIbldMaWZnY2xrdGFlK2JUanlabTNLaEdtbFZP?=
 =?utf-8?B?a2pJMlJteTd5SXRwWDRFL1hBaFp5Q2lDOVM2UExudWZpeld3L3ppL0l2ZjVx?=
 =?utf-8?B?a05pZkJPNmtKVGs2YWRFTnBhNnpUT1NROGJVdnJMRXE4NUg3RzlzenpBY0Z1?=
 =?utf-8?B?SzVGZkVBektleXFoVjRuNWVENXZUMTd4K2t5MmdOb3gyZW8zOWxYQzBWaXM4?=
 =?utf-8?B?Y2swWk9CZWlUNm5nT05jdU5KUEEzQUVJVnVrSmtqM2ljUjREbld5RURpdFFh?=
 =?utf-8?B?MFB6VlFjMjM1bks1eDJxUjFmdXBVbmpGZC82cXVDWCs4amhUdHZIL3UzWXlL?=
 =?utf-8?B?M1VkR25lWEhMTFh0bXdsWkNMb3pQSWlTaWFhREx1d1ZWVE5Na01tR2ZIdzRO?=
 =?utf-8?Q?L7/hED5zztZVdVqPt2SxEs42F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207a72fd-1111-444c-4dc3-08db46ee135e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 07:07:34.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYp+v4Fzmor2dxXZwAJvN2LLfgHYEuYRPKzUb5cwEZTfdeOoyLZHFAPw1e9CHsf6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/23 15:26, Oleksii Moisieiev wrote:
> Add new SCMI v3.2 pinctrl protocol bindings definitions and example.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>   .../bindings/firmware/arm,scmi.yaml           | 77 +++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 2f7c51c75e85..41ba5b8d8151 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -212,6 +212,63 @@ properties:
>         reg:
>           const: 0x18
>   
> +  protocol@19:
> +    $ref: '#/$defs/protocol-node'
> +
> +    properties:
> +      reg:
> +        const: 0x19
> +
> +      '#pinctrl-cells':
> +        const: 0
> +

As I said. pinctrl has also gpio part and based on discussion with SCMI guys 
this protocol can be also used for simple gpio. That's why here should be also 
listed #gpio-cells to be able to use this functionality.

And for complete implementation it should be also added to driver it but of 
course this can be added later by separate patch.

Thanks,
Michal

