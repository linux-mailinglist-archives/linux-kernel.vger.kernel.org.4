Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48DF6110E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiJ1MLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiJ1MKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:10:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031C79929;
        Fri, 28 Oct 2022 05:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciUmrRlYgSsQ4WMzoEY/tYm/+YSfczD2LCbh/pp9vp+K/FE0RNyyPDgcUp21Pkd2JDzkPI6sILEO3ISIVZrn4/bIo2m0k6juqnx8t19I1Cd6OW8Rx9E8a3ek06/dlNsbzV5fZKizz+LO4klZNKmfoA+0biAwX+0kxgaKFSx9iAs5DhY5jgacBi3A93FRJAkiPha4WFVf4rb1WE6A2bX05/0nmf8OnVPnXM8cXPxNnEZDQWx1r0VnSnUrhoYHO6KFzjaQHs6BP5lB0U8Qh9m5oopbwFUBiZlIC5R462SoOtxdNRu2J7q0aceYKhBRCekM4tOwbOkjvW9gC47Bo1AEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3JiDgDTfvXTiIJbBd9m0dc0XIn5c4C1y4O6Hy+iz0Q=;
 b=BWJrTRpEAZTAHbdtzElHNdT4pMU6pbFCwK7LKUZUjVXiDt0EFboKl7yfRQR+ooM4O7/Lsa69SDwOxLgO1LIdY6ixNiYq8quO8m2L+0kQzOBnNpO98fs7gCVjCe8lQ7DfBXRknjaKKHQHt9mdRDsPaAq0UOrKz2XfWSVqNP1JKaQRVCdzWP5oxCJh83ifET3NmrdU6iwTedFsVA9GTcG8SaB7l65GVN8nwm63CJaoJMfsHERn3oa+zj1CoS7G/CyJdPMvPgyqnIlw+xV82i411Z1GkJ4Z/3cxZOst79X5BBr5jN/nntSAkUp8W9iEdz/Q7qlngswgTrXIyvJ2YA5qGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3JiDgDTfvXTiIJbBd9m0dc0XIn5c4C1y4O6Hy+iz0Q=;
 b=Ty6TU+X0qEgMm0cSZ4F/n+Q8DQsLenT6273gdEfXNmtgPBIkpPtIG6dDUUuzimnaQnArmwgDaQa8pgElwtMVF0tPohnnWJLhedrErGuksxceiSVbMsC4sEgs6y9rCjjM0+p//fy5ERI+Cx7Tb0ORk0sKTHDpVNtC4FJM4ac88FSqlCi1DsrEfk3mb38VbXJYQTml9bBNS6W9L+nO/QDRRcdvbPAknwJwv+Dy+eI0qNdH1YEdjEnpJkTUU7MqKfiWb3pQv7GKD5zDWucgN8JcAO1/2w72qY5QjhVGUMASDfAmyRHb303Yc9/zvO174tmtv8WhaIqFs7g7r7PWFsS6xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 12:09:59 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 12:09:59 +0000
Message-ID: <7229a2a6-d646-a8f5-50a2-cca6c44d16d5@nvidia.com>
Date:   Fri, 28 Oct 2022 17:39:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V1 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20221027051214.22003-1-vidyas@nvidia.com>
 <20221027051214.22003-2-vidyas@nvidia.com>
 <4579404d-b3f7-8342-6704-2644f5cd489d@linaro.org>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <4579404d-b3f7-8342-6704-2644f5cd489d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::15) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|BL1PR12MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d0baea-f9b3-4436-d6c1-08dab8dd559f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDhgoigEX4b7Txrokm9tgCmeZb2lizQ84iJHd+4FfQX2aQKsIbI/KqLRcyRNSI8gSoqNw/AD9X7rR9bkeBT31IW/mzbWNdBX1pHxBdkPCx0ITTTWsetf87sBx/gwafYk6zJjwBX4XVkpior6vib/7FBftbJbue3uUKNq7BMrngUnjjTljVAUnEjjn5ZJUCZeQ7zaIeexr+N7dNw0+86QwOtMx+l0jCzHFNPqX2UWfUr6RwM4SxN9kLHL046MQuBkaiHEMR39tNdJKwqv+UVZgkRQYzHZYD/vtYij79dfEFnBg0xsZrfv4C+DIk/BHOCfpbwI4AD+dBiWKj3u3v5/d6nZU4cpQRE64eZs/2TwHqfj99I6hVZuIVvuLH07l0FJUYx9On+VyJ3vyagGKHFHB6D+eIxFgdRQWRgtgZ4TQ+SO6M2Xve5XGAEVIBN2W4rZtcq0lPgtjZrh/CH6kJL2H3gy1DKGpgnqn9Em32jMc8kuXmYQyoHZKpIuzBaSukCf1AFOQmjCwThN1uMV1YFcFqDOE61/b7goHdX0Cd79/hTFkAJAh1L+NuW5g7WqPz4l81bBANQOpieAtLxDjbXCxfD/Hh8Fdf+87ziVE5uCPjc97FKs0JY2dV9xB6DpUJPTJAzjy9ued+51HEC/cOxrFV98gXmOX1nYzD8DMlsgjzrc8sqMBKGTfwxRqwYO0Q6QFbp3Q8+1HP+7k+kZiZlj9qq5JigJ7dH8/a71Kn7VhTSmIuDZTv78eY3HCXGM5XWsk3XfMLZqcyz9bh0wwTXXhc0C2WU3hZU42gFzU4/MAzAzegb9b98ikcKskOWntyBdLxyGI4lG/PdCrrye04uIwufVXqSR9sio6GZe/u5r9sf81MhZqYGPQT+W0zasyjqk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(38100700002)(316002)(36756003)(2906002)(83380400001)(8676002)(66946007)(478600001)(5660300002)(8936002)(966005)(66476007)(6486002)(4326008)(66556008)(41300700001)(6512007)(2616005)(186003)(31696002)(6636002)(31686004)(86362001)(26005)(53546011)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clM0ZXRzd1hLcnRydnR6NVRoTUZLNkVYYUZrK2dFRTNsRW5yODZiN05pV0dF?=
 =?utf-8?B?ZmFhWW1zcmpNS2ZnYU5RamtKYTFlYUJyUEpIQ1l1V3VBQmhadGdvVXpFZlRl?=
 =?utf-8?B?R1JGS3BqbEJDREhRRTdYZ1dkVnBybXNweTB3aGozN0tNa2lIZ1NlZmtYR1Vl?=
 =?utf-8?B?RU1IU2hzUlZDQTYyNVVQbWwyN21mVG5pMVZJaDROc21HVGd1cGlYM1VkUEJs?=
 =?utf-8?B?a0NSelc4Rmd1MkhqY0l3Ujl1NWhFV1dlSzhTM3FndTNjQWdkb1U4TS9jL1lH?=
 =?utf-8?B?Q3NRTjJPc21SbmNpVUo0TW1URGNiY01iWWxMT1JDVCtBaWNObUZ6R1RPV3Bs?=
 =?utf-8?B?MG5YN25JVmdoY3JFREUzNW04MUYxMHNZNm5Xd1BaUFM1elBNQjNjTXAvZS96?=
 =?utf-8?B?Rmw3a0gzTGdZc3EyM3B1WTd3Mnd2TEdvVFpmR3AwUG0rQzZpbDdPbXM5Qm5y?=
 =?utf-8?B?VGVZeTU2YTFrUnorN3VacXB3c0VjaHBOdHRkWFovRTlTOCtCVERsWTZ0Y0l4?=
 =?utf-8?B?NkN4RUt2TkIrN29VRDBIb1BpTGJKNytjODl1V2FQQ252Wm82MnRyNDJKdnUz?=
 =?utf-8?B?bHE3MXJQMThSMmpGNlVFMnVJU2g2ZlFRdzJvOFFrUnZ6bFBQeVY2d2RoYlk2?=
 =?utf-8?B?VC9tU0ZHY0FFTll2N2gwaXJSaUdMQVJRUHRBREJBZDEzUFBGSnZVMklFaWk3?=
 =?utf-8?B?dENZVGZtYmppc3pUeWw5SjF6M00zbzYxbzBha1p4dysxcnUwNVgwZDI4WGFB?=
 =?utf-8?B?cXBqckJxcU16bXpLYWE0S3l3YnZNMWgvL1pldWxMejZOV0RVM3ZjOUFabWtO?=
 =?utf-8?B?Tk9MZnRuMFhkVDFCclg1UDNHN01UUlRuaFpLaFBIc0UwNmFZa2tBN21reElK?=
 =?utf-8?B?M0Nqd2FvMkV3RE8zYzM2Uzcvc0JNZkhBM2V0RGF0T0dFWlExZ0xrOFhuQmRC?=
 =?utf-8?B?aklDM1A0TUJoOWJaNE5ITjIzalFTQ0M4dnlvVmJkR3l6RzZ5V2xqa2V2WTZD?=
 =?utf-8?B?eE91b05OVHJWN245d2NUVEhteVo5MUw3WS9iUXJKczQvSmRTVUlDalNNMlZp?=
 =?utf-8?B?dE5oMENrREtDUlBnclIwMldmSkh1YkhMOUttN2hpS3BOMUxpNjNmQ0lmczAz?=
 =?utf-8?B?SEwxMi9tUjFKaVF2OFpxSXdwc25HaVBnczNnSTd1b0FFR1RocUhRck5Ha2Jm?=
 =?utf-8?B?QWRoMnJ1OHRnVUswWlpRTzRSeHhPVE4zQ0RRc1VDWXhtbXh4MTEycHNvWmpq?=
 =?utf-8?B?a3hDVHF6c0h3MkNCUlpnajVGL3oxMzNlVU1sTmRGRnRWWTd3ekZTZGk0Y1E4?=
 =?utf-8?B?Z3hVdjBvMzVJdCszeFhHSXhTZXRtLzlGMmtmQU8zQnZNUmNVeFpsWlRaMm5O?=
 =?utf-8?B?Y2IwT3ozOEJhdFZqZ3lDdllpeDhnQ3k4WWY1Tk5kK1QyU1ZIblpUK0FlUDB1?=
 =?utf-8?B?bUp3b2xwNURKZW1BRDJWS3YyNG9ZbWovUUV2UWNoQW5hK1IzbWhFTlJPRzM5?=
 =?utf-8?B?U3ZtK2NGdnIraTZwLzRScjQwaUw1RU5WWUtEVzk1YlorbE9wUFFCYnhVVVhZ?=
 =?utf-8?B?cFl6WFE4UVpEYUF6aE5wOUVTemlpS3BDcmI1MHRIbHZrdjVCRlVuUGxXYXZJ?=
 =?utf-8?B?YXljeEFra3AwejM3Z2tPOUNGajJKTktxVVJhanI1eTI5eEdQNFJaQ1pVZ05Z?=
 =?utf-8?B?YmhiK2diVEw4U2N6RGJPMjJGWXlIeUo5NHJsdGRiL21VRFpSSThhdEt4Y3l2?=
 =?utf-8?B?SnJaaDViOVVDd0doVHlLaWhiRVRWc2RwSXNsdS9QL21sLzJZcWNZYTZtZk9L?=
 =?utf-8?B?VDZScXNzcjFjM3kwUGtobGkybzZvMkRURkdoakNQdENPeGVkUzRiWnNoZ25O?=
 =?utf-8?B?V29tWmIzd3FlRTNDbWRMZTJzNGlQd3FXZGJQT0w1ZDQ1Q2RzLzJWTUxHY3FQ?=
 =?utf-8?B?RURHNmFJTGFFR0NLV3djY0ZDSWpmRnFVSm1Zc2NVRzdwRlNpcGRpYnFvMS9L?=
 =?utf-8?B?bEdpNTc4QjJDc2hTamh6VjhjSk9DWFNGa051aXNVVVB0RjRML0Zhc1FvUXBI?=
 =?utf-8?B?QzdibDMxa0ZVOWFoVzg5Tk1lOGdhaWtqSm5VZ1RIVWZJWGorN2NyaWg2OGxB?=
 =?utf-8?Q?ilVKFn9ekTfzxyyECYpiJeOyR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d0baea-f9b3-4436-d6c1-08dab8dd559f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 12:09:59.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSpJrWx4NIelaugEi8QBDaYrbHhPJeNoAGURDgBZE7ulcLK2vjumF1pPRdz4/1onohhtt+ENqyycz0Cg777o1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 2:48 AM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 27/10/2022 01:12, Vidya Sagar wrote:
>> Add support for ECAM aperture for Tegra234.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml  | 10 ++++++++--
>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml          |  2 +-
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> index 75da3e8eecb9..15cc2d2055bb 100644
>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>> @@ -27,6 +27,7 @@ properties:
>>         - nvidia,tegra234-pcie
>>
>>     reg:
>> +    minItems: 4
>>       items:
>>         - description: controller's application logic registers
>>         - description: configuration registers
>> @@ -35,13 +36,17 @@ properties:
>>             available for software access.
>>         - description: aperture where the Root Port's own configuration
>>             registers are available.
>> +      - description: aperture to access the configuration space through ECAM.
>> +          This is applicable only for Tegra234.
> 
> Then restrict it per compatible in allOf
> 

Thanks Krzysztof for your review.
For a similar change here 
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220707081301.29961-3-vidyas@nvidia.com/ 
Rob had said that may be it is not worth it.
Let me know if you really want this change and I'll push a new patch.

Thanks,
Vidya Sagar

>>
> 
> Best regards,
> Krzysztof
> 
