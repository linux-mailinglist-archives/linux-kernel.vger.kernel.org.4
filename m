Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85163622F10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiKIP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiKIP3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:29:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813B1141;
        Wed,  9 Nov 2022 07:29:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgVkJ+dvgGFFZPcgyom4JTydI/D4arwkuHeOfl2o0DdcKYad5ZhguOcWJZyf9l5eWqSs4mIU8uIHL//YKSJIRtX+7juHFv+f9iD58DQ226t+d/rDlfSspiWqA/0bjt+RTiTaTj2/alAU9fslk6ya2oNwrb4rBaSd3F+uXbKik+A6uWOpFPElG2yEeeCVCFOrRCzCmJTG8B9SAztdE4bT02B8vFAAVPc4+PfJZN/dMRU6BH1P79JAgT2kt/YpL7Ja2vD7dkMfPYUejXOlLhg3k2TQ8ii9tNIfgZV7kpA1QaK0c2eJEf0vP6e/NaOMcbXFPO9XOuHUQGge+Ee/4P3yPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoK8UIHpf0ejfqNR3az4CCcOl7P6I5WsXkf1v5OSMAg=;
 b=n6zXvnHl3VTBd1XHLYmej6iIiq76zt/TI+gbT5QDWBz/t3TK/Yph+pYXvQY2npDsbkzOpnW/weDYmdxOo6dODD3ug2UgSlX4GGRelLwkVc48WUU58kbmmVqxLl1N5If0+9qvpR37xXm975U+s4myJkg0GB5orUbPVqTa7/C3FTi52XUbc6T0S6fnTTq96BBSI+Z1VoxMpxxvuDvuOBDCCgTrSH3ytZQevZa6SuDSTttyRsZiDaKf+n3aLT2M9F8O4ryGtKiC5odf9a1kkAJsqLDYI0vMxjIBu2TdSzxoFTs1wv8HaNjoR/1Up7r7HMWJH9PJMZ3UzqP3iKL8+EtR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoK8UIHpf0ejfqNR3az4CCcOl7P6I5WsXkf1v5OSMAg=;
 b=jwmh5+7/DfWPasrYUotxHEgDhF2KEKvOrdmHtmHldV7Stys+zAuRBXgv3lFGdDtqR5K0d2WoflFgJg/n9CdPb+R0ly1ZwrBhZR3MCWzMejxWvcnKav1RH3QQ2DhhawoFFNfVWHvcE/d8MJ7UI9rNNq8zer6uOqjlnl0hcGXvUDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 15:29:02 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f33b:e12e:7621:7959]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f33b:e12e:7621:7959%9]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 15:29:02 +0000
Message-ID: <482c6af5-0b55-0e9d-0b1f-d22b9546f062@amd.com>
Date:   Wed, 9 Nov 2022 20:58:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 1/1] pinctrl: Put space between type and data in
 compound literal
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
References: <20221109152356.39868-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20221109152356.39868-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY5PR12MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ac3343-61b4-4f73-d752-08dac267208d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXjLwv4a+g/e2Lr7hUL6Qi8IaL1/ejwD7OwwAtMMIwgvnxPGG5CpgfxiOTZqs0O3+J0/fuP1L6RBZPWnnhlwO8hfakmUYgvQ305ubYm2oSTTYtbmzyFInE+qtQvwL3D772w6QsUABbiuCUdI3Hj1fudR41zzluDhYMfRNTROp8Xsyxqe6NxZW0eaaqhFgYFbcT2ljsCEm4MRBC0bjX4jmZ7Kdze/2wpztOv9zOB3e9S4HTpLrkGDUdIPhf7LLMznH8fov+VsNUwbBs/z1QLZ5NX5zTpZQAgKe2bu9Tu20nTdfmA9lSGgoGTyvKs417QIlEdaD33uYVujcFWiLNG8EdspcVOc6j9PILH0KOcHm5iNpmpPYQ9NqT3e++UrlEml8M8oKCmLstRh7mCLT1OXlRqKemluLhDkxowbVyRNuryHzp3+cNXsNrZz+63w6F4LA9DYEM1FLzmTOMgxMTSCFAM1Nih/8wR3IHr6kidsLs4HEutSva9RrNChi4VrrB9Fw1fg9RuyjC93BXlH3VxXKiceClHNfjpuTwG5hPwiBxybJygGKsr5X3R8UJsuiQ7dx+1CiMOuEUDSAaNy5Jf5VnP2s5S3AF9IR3qb6GZTVTEvKIBduaXGZZ4kXoB2f/SKDyh7XTj1GEmttuHVfhogcZkZWlAxc/zma60Upp1qN1LUPPoL0TjCUr7zZdzhJIQjTt8R66WJtOy/CaoHgbZ99YL9aeDYvBbZF5aJKtaaEQXfMZJVyjtH+j0OkA4J+/M06vW49nuePz5MhfnH3jUFUldKLj7XKfL5rgqfXS7QXrs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199015)(36756003)(66556008)(316002)(8936002)(5660300002)(66476007)(110136005)(26005)(6486002)(83380400001)(2906002)(186003)(8676002)(478600001)(66946007)(41300700001)(4326008)(2616005)(38100700002)(6512007)(31686004)(53546011)(6666004)(6506007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RUbHduS3FUZElxMDNPaWNPYkNDbjQreWFmK25JQmZyZVNWWldHYXJrb25q?=
 =?utf-8?B?WlFUdXI5UnFOSjdnSXVkSld4QmVxN3Y1dXhobWVIU1FaZmlibUZ5WmJwTnpQ?=
 =?utf-8?B?L21rTWsvN0pHdU1JVjFDOWd4OVUzeWJZcFd2alJLTmYraXgvelMrVlFjREgr?=
 =?utf-8?B?S3I2NHBobDBoNHNsU3J6Q0xXMmJiSFJVa25hZjhQSHBBcFhZMHk2QTZCeU53?=
 =?utf-8?B?OFN5VURXRkVRTHBZcDVKK2RSay91dE41MmRSUDRZeHlJcGhMQmh0OFpwM1d1?=
 =?utf-8?B?ckxZTEs5ZFpRdHdkQ3ZLMUwwbVlWVlVWWDluQnFhempIcUtqb09VbkhDUW9n?=
 =?utf-8?B?dVljSUNNVDU5UHV0OXNYWHgwS1hjUGNaanNlSEd2OEJ5L2ppTTVoVCszamFy?=
 =?utf-8?B?ZXFSY2RLelpua1hKbk1wZDhQL3hobWRtanAyZVRGeXJBZm5vTmttbzFPa2ox?=
 =?utf-8?B?ZVVYemp1dnQzbjJzK21RZFJ4emtlYzI3MFdGWnVZZlhBd0JWWDlhT1JsSDla?=
 =?utf-8?B?SC93emxmZ2ppSko4ZnAwWjZBYXZndmRoWno1M0U4d0JOcm13NXl4VjBJcFBZ?=
 =?utf-8?B?OGo1ajZEbU9jei81ZzFWTnJBQ1lvSWl5WkRwN3drcytsYmRKdkFSc3V5VVNx?=
 =?utf-8?B?Z0tyV01ieWdqWHlRckVYbW44eUF1RWI5YWl5MGk4TDRDcGRBRHVjMksydTFS?=
 =?utf-8?B?c2FFWVNEbWlGdVNadlRIRVUxSUNibUx1V2RtQkU3QnZGQUt4dk9FY0xaOTBp?=
 =?utf-8?B?cjZmNHpKRWYvTE9HcnJqNFZ3OXNtWVlVdU13V2dCL2lyRmtyZE9Fa0czbUxt?=
 =?utf-8?B?UURwNTlBd1NvaVl6cFQxaDc4RGNRaFZvRXg1ZS9tS2puN1VSeXgrRlVwVlRN?=
 =?utf-8?B?dTBlTk0vUFBmYzdmbUpyN0cyUnBUV2VJYm96Q1pDZnN1dUI1LzFXaXkwSi8w?=
 =?utf-8?B?cGdPa3dZRXc3SnovQkR6OSt6cTZsUnF1dlZ0T01zaXUwRDE3MEhjbW5Xck53?=
 =?utf-8?B?UWVyVFZlZ2UwTUMxYVlMYkdFdlJGRHhlZFI3aTYxVWFqcWZvdk9FeVZpSkdz?=
 =?utf-8?B?dUFpRUUrVGdIbzFIMDB5YmVCSWJEb0JFRUd3RGh5bGRYOUNkdTZKUHFsT3FE?=
 =?utf-8?B?SGhDSlFsVW9xTWpINitpTHdybFhiaFZkWjBMODRvRTFqWGpTVnJkaWFOVXQw?=
 =?utf-8?B?NGVGNHJLTVNvN3lrbWZQZlo2YjZPS2NQOE1EYVphWldjTEhLRkM0VHNwNFN0?=
 =?utf-8?B?R2RKcjMvcnVONGtKUExidXFqUTlESTBocys2d1VOK1V6ZlQwR0dxR3hjVTh1?=
 =?utf-8?B?ZVRadGxmcU4remMvanova3AxQ3YvOHFOKzRkYTJwU0NEbHZZTjlpU2NmYlhM?=
 =?utf-8?B?ZUgyd0diakhrT0hMNVpTTjZiUVJpSGVtekt5UytGckw0RGJWbzhOQ2lzM0NG?=
 =?utf-8?B?aFZSd2oyVGlqYnQ1aENHWVUwRmZaWUZiQlpHU0hNeTZqeVFvNG02UVBjNmJB?=
 =?utf-8?B?cXZIV2VDeVp1L3RGWER2ekdZZSt6bUFIVDA5N1R1SE5iSlFVeE9VL0RqMk5Y?=
 =?utf-8?B?SzFFQ2V0YVBxczNDek03TTJRUmdKVGRGWUR0NHl3WCt0M0RaWGZQWkE3VzV1?=
 =?utf-8?B?YVhJUmhiWWwrY0xxeUE0bS85emtQZ3pFcmxRTy9wZkZ2ZHZXYmdqd2gxZjNV?=
 =?utf-8?B?bUNnM21pT3hsRmo2amtNZUI5NDBNdC9BKzd3M0lpZllScWxhRyt5cGZNZ1Z4?=
 =?utf-8?B?QmFNMkVJdnJiTUZvaGJkcllLUWIyVGI2dWx1V1NqMkk4Rk5FQkV6UVJyQmNL?=
 =?utf-8?B?d2dRTGJxOThRYzRKYkVEc0pNUzJIM3JITUwybmJ2K1pIcHRCVlBrSlNoZ3dW?=
 =?utf-8?B?bE5vS21wUWl6TEIxR28xQmhHTTQzWkpaSWcvaDRXWDhzV2RmZmR5YWIvY2lw?=
 =?utf-8?B?cGFXK1ZmTnltbFo2dlVDU1FVTGNHNHVEcmRPNEV4Z1NTU1lXeTdSUnVld2FE?=
 =?utf-8?B?THFNWFQyZ1ExY1lRVTRXRkVSK0lSNkowWGwrVzVTTCs2akg2MmltemZHVjRB?=
 =?utf-8?B?alk4SDhLSkNHcjNzUG1LWmRxa010cThVQmdTaGhHaTNJaTg1OElGeG50SzV1?=
 =?utf-8?Q?McFobSM30CLOqsP/W/fJVriE3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ac3343-61b4-4f73-d752-08dac267208d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 15:29:02.4474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yj3WyO35/BwsrL1Apomn209+ztx+Yen6dpqg1vkzxRcFa8wimjFudKc6cuqb0LjXsn4B5cGzALhtLHYNMksK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2022 8:53 PM, Andy Shevchenko wrote:
> It's slightly better to read when compound literal data and type
> are separated by a space.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> It also standard practice in the kernel:
>
> $ git grep -l '(struct [^()]\+) {' | wc -l
> 1384
>
> $ git grep -l '(struct [^()]\+){' | wc -l
> 306
>
>  include/linux/pinctrl/pinctrl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
> index 487117ccb1bc..f6ff2590657d 100644
> --- a/include/linux/pinctrl/pinctrl.h
> +++ b/include/linux/pinctrl/pinctrl.h
> @@ -40,7 +40,7 @@ struct pingroup {
>  
>  /* Convenience macro to define a single named or anonymous pingroup */
>  #define PINCTRL_PINGROUP(_name, _pins, _npins)	\
> -(struct pingroup){				\
> +(struct pingroup) {				\
>  	.name = _name,				\
>  	.pins = _pins,				\
>  	.npins = _npins,			\

Looks good to me

Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thanks,
--
Basavaraj

