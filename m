Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F769A849
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBQJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:39:40 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932F5ECBB;
        Fri, 17 Feb 2023 01:39:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDCFPoPT2Bq1+0sh+B5YGkgE2XKj0kdLmfV6aQ1gPoDhtqfPUX4G6LrhGEHmfpqO9WHdjTbft9LKZVTRHB/MuWC/Q/jws1+WorrysY3la2LW6T4bxjed6snuEhXUwWWZHo9pwS+ovSVSr3WSDX0ys9q6wPnq693V++9cAYzRM5rdexu0Hwx2MubhQP4iGebH9GAvXnJXIhMs3mx5VKLbBsfYyCtXXbNEY96TnPuRJU21wghLpSAMQr7CPMW1p7CIHZlnhFtQTjmyubllLYz3odukfxFsc6klziRZmplDbLevR1ThlDg1WrFl00tLIKflQFR9GtuWE7EseFhab0glYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2roUc0PiipfKtGeUdKfA2MKyOTjc4yNO5bTVOHlge4=;
 b=dRqYJ0X1XvdEv0nd1JSwSS7pYydjOP81is/tdgVfBYHthB465FK8IMTTpOxhjfo35vcOefybXC7Yqir2mZCPODAuk9icfZaTy+sF+DyGNnJ2nDdL+jF2lVRzuGp9Way63VGgCOuVxbJRP+CZWcH4DQjOjRAgKBgkFuJAxT1hrI4FjaZpbr9blpY+4657euoKrmop1Kz/HvjEJM7hIHTOQr0tl4mjSFlS2IMN6xxK6iZOLeDQWxP7SndklmHZgvTBTtnsjTTaGvir8DNMSB8dln0RpKFilddZffUyEvQxhIE5XsGNsbyiLK5M3P/CO1gdqTs1IdcvW+/T9KgH0MKItw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2roUc0PiipfKtGeUdKfA2MKyOTjc4yNO5bTVOHlge4=;
 b=tHjziLiDBpi5pyif4W6w7fZHayzqKIkBcMEvh1vz7fQN18zUrmg0OtVMkmyc/Rl78AGokQ3kaaaw6KyY9KLoQoxie891wnY7VSlLnM/BrkawwVwNgpJqyN2U58cquahJdi4uYv+460FfqceuqMvMYu+CGjaWWKHnYhLQGzo8+dKEjluEZXjMSn0IxCOtIFzeKlpUtdO8WKYLpR+FWnJXvJT4DlygUxtyzJYHnNiWCGvxeP/Jktw3dXorGsvCsC29dlWidFPOhSoYmtTP57UJICrlEQUWJ3rWhrtxmPDvIf/I+u3RuxpwXfgJ/HQ1xeTzPSguAR4xeJvjoTRHY5/8jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 09:39:36 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%8]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 09:39:35 +0000
Message-ID: <74818031-0a0f-bdcb-3a04-434203f7c99a@nvidia.com>
Date:   Fri, 17 Feb 2023 09:39:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Patch] [tegra] Remove unneeded version.h includes pointed out by
 'make versioncheck'
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Jesper Juhl <jesperjuhl76@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
References: <8611b610-a21b-6037-52ad-9439c4f44995@gmail.com>
 <f1b1c2df-b88d-e668-fade-ca0ef74e7b07@nvidia.com>
In-Reply-To: <f1b1c2df-b88d-e668-fade-ca0ef74e7b07@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|BY5PR12MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: f210efbb-083d-4b5c-a8e3-08db10cae178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3grgB1lEpDxhgtmVfZ3uLncsU43Zjs9IljYGT/Tr1YNsBjCDf2tdldo5QrHKUjl/a4Hi1I9YwCUefn40P5H8A6pqXaNSVI4ndecJNSuA6MDlQAyuZXqOCap3CAV5IyjFGE8d4MiEkLewi/YwxM57H6S7w/3e4cLajFyB6jSJjxO7V2fYUccjUOONWiJDZMAA3dZcMdCXebi90nUjk+5k3b/qXZAak37JSWiRqRu5UitIXJM+iCzk2OwAR2U1jwUIAfqPwczY4NlZTSiAflhVYlC0NJcZY0uPGRE+UWLlf1sIGz930p5kyeDOmH1w4kWIIpFfY7njb1IUK3PYrrGXR3D2PItr2j/f+xzTFYKAzb4uZalRxW6Scze0sLjt1fhueLDx0w1SmFqPQHCA2dgSeFxOnxiwTnKzHG8QEu///jVaNbSqE0EJ6ejPcdRI2WBLxIMJEkdi8rdRFELCnHtTEEvHcl9QjhBWauQwTh7NX6DXG/6OFaW1PE3l6PA31V0/xYioeFexPMfQYOd9aZUOGCPewaBQQTlPDtoIAvSR3NXXVGATXC8wCq/bGZDBVToOmHD7/FBY7+yaMSdkPquO0E9iLVOAjRL3TH02dk0HPrxfgCAmFiLP5MRuPTnJHPQ3W/P94J59nKTP1i2uBb9INsoM/PkN3Veoh5NxgdWbP6ev+gjW3/DjOm6JbEvNDDDiABOfnlZ7ketNZIiIqnvgpYZ5OuK2B+CIWZMdOWz+WUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(8936002)(5660300002)(41300700001)(66476007)(8676002)(4326008)(2906002)(66556008)(66946007)(316002)(31686004)(6666004)(186003)(36756003)(478600001)(6486002)(6506007)(6512007)(53546011)(83380400001)(2616005)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlRRNEt0KzhiMDF5cUFyOENkU2dESE1tcHFFV1BIUzBzYlVzbGtINzF5a3VQ?=
 =?utf-8?B?emt1WmliSjNpU1NnK3FndTdEcS94RklYZGdyMUM2UnNyOG1RUjlhOTJXR0NY?=
 =?utf-8?B?R1pvbktMQ3gzejI0UDAxM3JESzRxRHZLcnE2bnA0VWNtZ2VBV2YxVXVFa2V0?=
 =?utf-8?B?NGt5b3NGdmNBaE5pa0pUY3RZWGdaTUdyM3pKaXlUVmFackI4K0U1SjVoV1lq?=
 =?utf-8?B?V08zWkJ1TkRDWC84QVFIQ21PYktnZU4vSDhIL2dOd043VTJ3QTJqbGNvNTRl?=
 =?utf-8?B?dFJ4OXZ5K2FoemkwT2ZZQWk0VHgwSVJQQ3pqamRKNUFZVU9UZERVM2x2cHRp?=
 =?utf-8?B?OXlhYkxrWDFrbTZIUUxQcXZxdUhWR21mRmRVcGRPMTZlWXZ1R0NvU0M3SVpl?=
 =?utf-8?B?YU9NT3BINk5GQlB6eGNRQmNMSHA4VDUwclhwaCtGZW45Qi9Ld1AxQ0NvZysx?=
 =?utf-8?B?NzVlVUxmMERraFQ0OFpnam4vS3FqLzNYL0tXN0JoUnFERmdlRXphK2VxdUVO?=
 =?utf-8?B?R01XM1Mzc0hLaDVaWDNBL0d6SnhTd0J3YUZhdmRsdlFsSkd3cm9RR3grdklK?=
 =?utf-8?B?a3pDTjNJbFlONVdTZitFMzhmUk80R0YyZE5CUTUzT2NmS2NSOTdlTG85MktG?=
 =?utf-8?B?WGNHSXQwcmh4U3ZqUWhWTmt2Y052VUFQdmZuL0Z3YmM4Vit2bTBTSlJNblVY?=
 =?utf-8?B?RFZKLzJkVVNNTnRPSFJqNlBRSFFMY2VEa2VoVmxwazcwTTVNWGZpb0RLWng0?=
 =?utf-8?B?NnM2NkFUMWdobmtyTHhBWDJqRm44ODNEMFNIZjhycjhRN0NOcTQ4VTBiTXZM?=
 =?utf-8?B?S0lUdUZmaWtlUWxXSnFEZlZkcExPRzM0K1JCNmxTUHh5TmJ2K1U3ZmFjblB2?=
 =?utf-8?B?NnZSTUxFVHlhVWtDUTFjeTBnQ1oxVWYrS1lHaS9TamFKZFBsZjd5NzJwM2ln?=
 =?utf-8?B?SXAzVGllZ3UvTFBlSjFlWWhydDdkRFNJNVpmaGRIeVl3MWdwWnZiV1ZvSXFx?=
 =?utf-8?B?WXJJZ01Ba0J4bW1YTElzTks2Y0ZWdFljNHZheXdsUC9ZRmNadjhuY1FKODlk?=
 =?utf-8?B?cm9CWkU3d0Q0Tk5taE0zd09KU3laR0piUTlqYWY3TlM4NjhoWkowK0ZuUThR?=
 =?utf-8?B?ZXd4RGp5d3k1REpIWStrbCtrYlhZMzN1TjlWQVVzTnYyRmEwUVNFdkkreWhL?=
 =?utf-8?B?bEs3YTkxWjdYRVljY0tiMnJ6dVZFeElwT1lzR0UxeEczbjhMbjMxbkVYeFpt?=
 =?utf-8?B?aGFkZDVjWkh4dmxJMFBGdmppTVNVOGtkK1ZOc29ZQUxYU2FMcTkrNnFDZnJK?=
 =?utf-8?B?TEkyUklqeTZnR1FFVG8yWGRNNGcwQ3R4cDlFcno3Lzk1dFhwRkxiYkdlRHJP?=
 =?utf-8?B?N3ZmU1VJY1BydWp0R2RnbU16OEEyUDAzcWRxZ09TQnpxbzQxTmZkMzdlMnFJ?=
 =?utf-8?B?NHJhelJIL0I1NmE4dkVqNlAwdkdoRkErL1QwTmMzaDRaOCs1L0xmWWE1QVRI?=
 =?utf-8?B?Y3ZScnJwcmxSZmlUSmRsTnRCY2xPZlVLZHlPSDJWM21mTUxCeHpDRzd0TzRh?=
 =?utf-8?B?bGtmVThKKzNSalRsUzRkZ3JaVFVXOEFFaUN5VkxBZ2cyRDRKaWRUYVRXeUIr?=
 =?utf-8?B?eUc5N2YvcnozcnorcXZ3RzRqMG1uam1KUmEvTDdGUGp0THJjZWRUVVNYbVFC?=
 =?utf-8?B?ZEF6THQyNHZVUXN6Yk9obnd2YnN1YWJaN2t2ZUlsU0FRYUNYQzlWbHpLZDda?=
 =?utf-8?B?NmJtWGJnK3Fnbkhudm9UMHh0UkJiQ2FmRkpFWnYzeW5YWGcvZ2swY1p2NXRX?=
 =?utf-8?B?eTBnY1FGeG5ra095bFI4ZGJVMndiOGlnaG1PTkZFNXpTWld5R0UvUXlNSzRi?=
 =?utf-8?B?bThEc3VNMmpIYjZ2Mi9NR3FKbHpjRWZBZit5a214MkJhbjVNcDc0OFpuYjgr?=
 =?utf-8?B?MUNFQ29qYkwzVU16V2RnaU5mb3U0UDFRZDdoYzZEanUzZzVRSW1wZ1dVSCth?=
 =?utf-8?B?cDNBb1AwZER1OG9ZWTFpU3lPTUJiVlFlWk9zWjVUTmdpVXdJVVh0VitUZG5q?=
 =?utf-8?B?eG9VTHJnb3o5dEpLdWFGVGQ2bVZhdVgwSit0MXBhQlZHS1pUSS8rS1A2SlVm?=
 =?utf-8?B?cDV2eEEvQ2Q2RkhtNVA3ZnhacXJ5SzdwbVZWeHM0VDdyKzdTbit2Ykl2M0dW?=
 =?utf-8?B?TDVBTzRJNXNxeDVyRlhnaWxQZ0FDMjRmbzlIaGZGdkZMTld3ODc1SUc3dzNT?=
 =?utf-8?B?L3RLVzlaNW5xVVlmeXBkMjRyWCtRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f210efbb-083d-4b5c-a8e3-08db10cae178
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 09:39:35.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYOgo+0N/TOnQUiw0X240utUKb38lIsfYD3thKaTTJ0ozfRNcJCxgVa3i8IWyPk6+6FSUkKui8WGt24zzSJ4hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/02/2023 09:30, Jon Hunter wrote:
> 
> On 16/02/2023 00:53, Jesper Juhl wrote:
>>  From 7264ec7d00ece4b56fe9fafa3237d4870cbe6785 Mon Sep 17 00:00:00 2001
>> From: Jesper Juhl <jesperjuhl76@gmail.com>
>> Date: Mon, 13 Feb 2023 02:49:50 +0100
>> Subject: [PATCH 04/12] [tegra] Remove unneeded version.h includes 
>> pointed out
>>   by 'make versioncheck'
>>
>> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
> 
> 
> The patch looks correct, but there is no commit message and I am not 
> sure why the header is in the body of the message. Make sure you use git 
> send-email to send patches.

Also the patch $subject prefix should match subsystem you are patching.
You can check this by looking at the git history ...

$ git log --oneline drivers/soc/tegra/cbb/
b6c6bbfc65f5 soc/tegra: cbb: Remove redundant dev_err call
fa9b5246e260 soc/tegra: cbb: Use DEFINE_SHOW_ATTRIBUTE to simplify tegra_cbb_err
2927cf85f487 soc/tegra: cbb: Check firewall before enabling error reporting
55084947d6b4 soc/tegra: cbb: Add checks for potential out of bound errors

So you want some like "soc/tegra: cbb: Remove unneeded version.h header"

Jon

-- 
nvpublic
