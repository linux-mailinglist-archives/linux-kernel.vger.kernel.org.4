Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14D65F1A3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjAERBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjAERBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:01:08 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE04E94
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:01:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2gUOlmWG8GQnzVIYYNPZZsYigfnkknkmeY87o2sAJww6UviSMgS2dHbayXRnzGK0jhW0o/SBhnb9cA/di6J8tJRI4e9niBc0Jnh2GOxqgD5CXY/SGGIto5XDhIjgrflp53M35sXm+AuoaTnusWgBORkfa6d1WwouYdMNZ4TImTPx11z04dyKA+igfHuwK7Ghikj/OtKPyjssjsGAKdZslxhqVaSEgFysWo2Wy9Pmcz6cUSUy53ZXJDtHPB+H1N9WHkKi81F8+g9vEQBYPgyBCzTjAUbksfVV4Raqwy8PcipCD7s9SjXKiGIn0+5iy4I/YSXi4ejiG7cEJk4VKGd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laT3G4CEINr4n0HhMLqb5zpekeT6zI9KcaKg9IgOoTA=;
 b=NH5Rq7SERX+rokNRt2haEBdNFobBjMWC+WLtBkUo/pPuU/YuArt7VRXAR1YZnIeft5LNLjYK13VP07USGN1WicVt7FZDhopor4y3NLXinUcCvD1DQ8LZT0HeTc74igIgMPRLxV3e2lgZ93TTy7+HXomfiCykmfwZypGbSGuVxwUdORlE4HNY80gGmVa/g3kjkI8vv1I8Rx25HzKfoXxKS/TxvlQD4YDOn+z+hBbVJLC+0nKNcUrAy5XVeG1iPsZKcnQAypscA9rM6cULMxFZmFe4dxC8gdHDIWUG/0rZqi0ZaLXD3FCMfK/+ObhfFekvyqtoFAlPfEUtOXCLnaM54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laT3G4CEINr4n0HhMLqb5zpekeT6zI9KcaKg9IgOoTA=;
 b=addLh9yVJEwIdnz4oGdzuz0B5SVhE0HP5QOpi3tE1krdBfY/WJ+maRwSyBPcv3nWkLxMrF+ji+gVJBdmHYGCbaC8c8APCUL/IzrC63r3Y2MKdMG7IZ+3BUb492N81+CmvzF2g3bdrFlgXMYeD1qTh9CITIJvWfCET0xWqWfqDN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 17:01:04 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::7d2d:dc01:79cf:df79%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 17:01:04 +0000
Message-ID: <6bb126b7-1cb4-0c4c-d357-fadc3ffdd3f9@amd.com>
Date:   Thu, 5 Jan 2023 22:34:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: amd: ps: Fix uninitialized ret in
 create_acp64_platform_devs()
To:     Nathan Chancellor <nathan@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     Syed.SabaKareem@amd.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20230105-wsometimes-uninitialized-pci-ps-c-v1-1-4022fd077959@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::27) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfc6c28-7d90-4c07-a55d-08daef3e6e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AM/6n/B1L82ZSkY7vuZYnJKaRii+7ReEQj0lMAxd2/lejdlUKcnloSLOB2Pn+LbkY9F0IrytIf6v9SjtbtS2ZLbVR21fRnbVwtnXShlxndQAw6vnwkyAKzG78EyUq9mn/4iR8HbJBSBbTToYxuF1wLxFcKzfIHQsjw2n8vXNi56rBHW0+buJV/DSdEyX86p2f09fTtrucL+rrbCwaude+sFwEc71vtCMIkkEc7r2dZnqrIl0yVCZKdP5h51L1cePPa4EE7iwdnWFfk+V+m67NtPOxvHj8Ohvqv5HaZrahoup9CFW7u69HUgDehlAb+2eQ5fs/VnTTJR1clYmQXCXt+wLi76pAMn9ivqav7d2LJtFnmq7RAKXCJw/g5ac/h/SxR3O9jAM7FwfsTQ53sd0gFq8F8zQZdaQ4d60wMc5e8BFWFSXRf9poeMQnj3/GyNGiFbbqQNC5bcujp1VJV5lWL8IxNjibHKAIrj5yA1sjW1onulWJMSkQ1NVTilgizcxp0h5cl+JuKS8wyAHFlyF4YFR4nz6HQiPrDn8EgkqPR7rluL1ff2bkDm9yHGD2L6kw8DCW2q44zM44boShims05sSXvSKcYkKrr1YvLkcHGxLxMg84PWMKgfxjrAXGj9XhkJFL3TZJgTzD/vKES4aGrn8L+T6eOwJvTeyk1cwlP0VwrLKfF7C+4mkZKjs1KCUnsCHQ49LPbgu8NBvCTcu0MRo1R7GPcuSL3O6PQZmmZYV8v0hlV1OBAaizr4kWVi5Q1ozB0pkCALMXDylzlfhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(2906002)(5660300002)(8936002)(41300700001)(478600001)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(45080400002)(31686004)(6486002)(966005)(6666004)(6512007)(26005)(6506007)(83380400001)(2616005)(53546011)(38100700002)(186003)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjlvZnpVRjhlRFlDMXJ2Nzc1MHZveWptcm9RK2Q0M0hSSXRSOXhmb3owQm40?=
 =?utf-8?B?R0JVRERsTVlOR281VkhEVmJaOE1ZT0RoUGs1TXFOWnhSb3RNL1NiTFVEQW9B?=
 =?utf-8?B?MlhqTHhCQ3NnSkNtZ3JTYzhQRU1vVTB2UHNFdWJpY0pqNE5UZi9HbThSVVFh?=
 =?utf-8?B?UUVmVDNlR01nZXhoMytHQWszZnB6anhmbEk0N3QyWG83dGhSUjdydlNCREpi?=
 =?utf-8?B?Nm9WeHIrMnNsV2kwaThZR29KZ1JTVG5hZU9xT2xMbFVnZFpKZDRxaXJidkZv?=
 =?utf-8?B?QXRmbkVZYXJ6bTVCL1ArRzlJeUhURU80OEI5OU0vNlBVTmdOWWtqTG5BRU1U?=
 =?utf-8?B?OFVNdE1NQjlPUFdOaHVZTHJ4VThYTDRpWDNwdm5sUktvdFBWQUFGRG1kQ2xX?=
 =?utf-8?B?Zld3VCtBRkg1aEpyZmM1UlNFVDJHR25GUmFJdkNlc0prSDByV0E5L1N3RG5S?=
 =?utf-8?B?OG0weEF4VG9qS2RiL0xRVjBtMDNEQUx3WXFvYTJuMXJMN2ZzZDQrZytKU3Bi?=
 =?utf-8?B?YUluT1IyNmQya0pvOHR6ZDJyTWNqOWJWMGpFSWRMYnBSQk5rNGxyWGI3R3Az?=
 =?utf-8?B?V1BBcUowVlNGYk05Nlo2ckpXZi80Z3dHVU0reUwwR2RWV3lRQlVqWXZBcUJK?=
 =?utf-8?B?YVNRbW5yNVFpM0docXd4SThTUmxDQkRORjNIL3JnM3dOTXhYc25PdTY2akFZ?=
 =?utf-8?B?d1F4V2hjZEhrL2FzVURzSUhMb2tDckhuVGd2Q1Z3V3JDazcvdlhLZ1NRdUdI?=
 =?utf-8?B?YnJrRGYxTGdwUXB3VjQ1eUJHazVXK0lOaUVrVnRQd0F2cThCSEJOajBEaVpq?=
 =?utf-8?B?a3RGbCtxZmFXcnNJd3Z6Q2FwL2lCNi90WTB1ckNVNlpCOFZEMG13ejlMRm5h?=
 =?utf-8?B?TWFtR0xrK2F1VDBSRHg0cXdQdWVBaFkxeExUaTM1MkNFeEFHbjg3NTlmN2RV?=
 =?utf-8?B?ZjRydWEyQWZJWU90Q1Q5ZjF1bDZUZnMzVG1VT00zZnQxcjdlc1pDR2lFTXZr?=
 =?utf-8?B?UDBPNzVaWmVRSkNqOW1RWTdzOFFHZEN6QTZ5ZTdQbHVva1FDRjFod3RWQlJ5?=
 =?utf-8?B?QXh2ZjBmc1JlaDgrb2dpVDNWeW9VQzdVL2lWSXhkUGpFdHpZQUhsRXJtUDZj?=
 =?utf-8?B?UHZGQnhNREFTT1Nacmo5Qy8zVXQrdURRam9ENDJtb2RLUHJ4b1FYbW9XTW5i?=
 =?utf-8?B?Nk13SXBoak5yTFBQenZCOUVDQ21oOWxweVB4TDVTZU0vL2pSVm9ISVNRTFZF?=
 =?utf-8?B?SHJXSlBaS0l3QUZiZS96UkZtZHJiVVNsZ3AzM2hHOG1lUTFyMWNJNU44VHdh?=
 =?utf-8?B?TEdndWlRS1pZdmErOStYV2p6c2srcFVqN2Mxbi9ZZFR6VnBMaWpkWGE4dW1O?=
 =?utf-8?B?clpjOWRtVmErZHdxMUlRL1I2Tm5pSzhnQnpzV1k3MnZPQzRRNEoxUFQxRDZr?=
 =?utf-8?B?SUpIam53RGpiZlM4NDBITGFnaVhQSktzdmVrajhJYU5UblorT0sxV3B4Tkpl?=
 =?utf-8?B?bDgzVEtSZGVoZHlCVWZCZElxdEU0WjdZbTZKTTNIQStFWnFEY295ZTV3NUtJ?=
 =?utf-8?B?UFVjQnI0ZDU3LzV0Si9lMHdteDBoR3I0VkdkdUVkb3Q1STIwSFRwd2I0WjlH?=
 =?utf-8?B?OWRWZkZCVmlxQzhuSHFwUFFoNlN3UndLSHRLdnV5RktzOUl5bWFoczdBLzNj?=
 =?utf-8?B?SUNMcGcxeEZZTHM1OVF5dzY4eWgzTWJ6YUFScEkwWWJvNWRWTmxpZUJZQzlp?=
 =?utf-8?B?b1RaUyt3TDlSSysvcHlGN0lmTzM2YXRtV1pqUFhwSjFuQjZUU0J5MWh6bmND?=
 =?utf-8?B?MjEvdjFGU0RMRW9GQWk3UWlydDdCMXVlSDlPS250NkR0UEYwOHlZL2w5R0sw?=
 =?utf-8?B?NjJuTmxQVlpHem9lZFBTQ1RsRFhZVWVISU5nSzZqMjc3MzlrS0NsNER0V0Zm?=
 =?utf-8?B?TjJEZWRNb2tGV1pGck5IZzM1cTZ0VDFpcEl2dEN6VGlQK3dpT09kUHl4bWZY?=
 =?utf-8?B?MHM4VHFiMGRZRStPRTZJZzQ1QWhEaDF1aDV1QlN0K2IrNUJGT3FLRWVsdlZ6?=
 =?utf-8?B?NHBHZXE1akRFWDl2WkFBUjhMekQwcVBrc01RUXJDSmVUNnY5OFBLb2J0SUJu?=
 =?utf-8?Q?RiBYFf/6sDAF4KX0L8Rbbk75V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfc6c28-7d90-4c07-a55d-08daef3e6e4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 17:01:04.4811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rAm5OM0HeS2vpausXs96ySSNewvizO9Qkvk7oJT6AIW8UzwZtiSnrnMr5AAQrwe+aEIJXy9is1b5OZ7OTCS7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/23 21:23, Nathan Chancellor wrote:
> Clang warns:
>
>   sound/soc/amd/ps/pci-ps.c:218:2: error: variable 'ret' is used uninitialized whenever switch default is taken [-Werror,-Wsometimes-uninitialized]
>           default:
>           ^~~~~~~
>   sound/soc/amd/ps/pci-ps.c:239:9: note: uninitialized use occurs here
>           return ret;
>                  ^~~
>   sound/soc/amd/ps/pci-ps.c:190:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                  ^
>                   = 0
>   1 error generated.
>
> Return -ENODEV, which matches the debug message's description of this block.
>
> Fixes: 1d325cdaf7a2 ("ASoC: amd: ps: refactor platform device creation logic")
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FClangBuiltLinux%2Flinux%2Fissues%2F1779&data=05%7C01%7CVijendar.Mukunda%40amd.com%7Cad26656c3d2f4c75d00208daef350528%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638085308267581104%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=eeHVStOIOcy%2FdDISOKlGNeyEwx4i5AtJZmQ5dcNB7XQ%3D&reserved=0
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  sound/soc/amd/ps/pci-ps.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
> index 401cfd0036be..f54b9fd9c3ce 100644
> --- a/sound/soc/amd/ps/pci-ps.c
> +++ b/sound/soc/amd/ps/pci-ps.c
> @@ -217,6 +217,7 @@ static int create_acp63_platform_devs(struct pci_dev *pci, struct acp63_dev_data
>  		break;
>  	default:
>  		dev_dbg(&pci->dev, "No PDM devices found\n");
> +		ret = -ENODEV;
ACP PCI driver supports different configurations. As per design , even  when no child dev
nodes are created , ACP driver probe should be successful. ACP PCI driver probe failure
causes power state transition failures when no child device nodes are created.
We should not return -ENODEV in this case.
return 0 is enough in this case. No need to de-init the ACP.


>  		goto de_init;
>  	}
>  
>
> ---
> base-commit: 03178b4f7e2c59ead102e5ab5acb82ce1eaefe46
> change-id: 20230105-wsometimes-uninitialized-pci-ps-c-3b5725c6ed31
>
> Best regards,

