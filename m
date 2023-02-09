Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664A690ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBIREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBIREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:04:33 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A7A2D67
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:04:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gANqzUmvqS9lJ9r8oGU2t3ys/rhLWb7WKzLxgkF29Mt0/qwoLj4lahtlvZRv4uVoLPekoi9jf/9SyEOGMOQbadGHySZKAEYqwyDtUBcL9Ck8YycFvwygr9yFTFRyArw0bQXrZj2EwiKHDpLDpGTI+/fOjHf1FRHpUIGnc9fpik14w/AdAWbzJL8PYHBA7x5q0ZX0WUYEjJBVg3CgLGrbqd7QJ720FUNvpsOFHqln2r5bkyPH+zUuCofwH3SJj2/15nZsJ0v+REiPTMdnqWBJSrtWs3WPg2o3DA6oU9ydXUBUmZcYES3Dw+6JGmW6IL6Bj7JfCD6O87YBegz8i11Cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0u8i85ZDm50So6qDpSBEY7cCv1TxRQdlk8KTWeMGfTY=;
 b=kxdrV2vhGxMIcc8qImNARfi/uU1SCF2urZ9kl9zusye5PBIlzZ/lNSt9fbuAZIBCpiimu3H7ukIb51GuxnziRHErMeH9RyMnZjvRj4ozFtoKW+Nk4W2h+v53G3dB6v2gMhLk10peyJ/ZCLafrLKXO9SZqy02TZO4L0Vr9E+ybTebTlUPT8wuPzbK/v9DlyBkzvH1YrBVnnpeu+OpmwrDNGFFrBGlU/My2p3E9RWzUYlJlpcG0XsyGYY8Pq4VgwYF5EfMBubBWdBQYGkyAoxcvcmVKQG5LlZ/Mql2DqkcdN2/e0OsyyURP/hhR/ZjudSJ6blTXChQcamMO9+aulISwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0u8i85ZDm50So6qDpSBEY7cCv1TxRQdlk8KTWeMGfTY=;
 b=fcR7NQvdAJY+bXSu3c2FBAQoOwCk8jBWgc1+ZfaIePswxnbyI0+IEAWkpXywmJkLkPrMUv6E+J6pHo74/R4dXk1GYxH7lh46VACa++Bp45LKBzrOm+ThdTySPrjr07s0IxpbmAYDjYSkCuaP7z0bVN0UCRaavK/essF63Jy30lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.23; Thu, 9 Feb
 2023 17:04:29 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::f29:b74e:c400:b24%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 17:04:29 +0000
Message-ID: <60713287-ed65-1d65-5569-e13066291781@amd.com>
Date:   Thu, 9 Feb 2023 11:04:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] uml: vector: fix definitios of VECTOR_WRITE and
 VECTOR_HEADERS
Content-Language: en-US
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230209161916.3729757-1-carlos.bilbao@amd.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230209161916.3729757-1-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::26) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CH0PR12MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb91ca6-c80e-4089-6aab-08db0abfb4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02efRLpfWJZApk/yxI2aqC77u9WC1wFuq0AwEtDIwaefNByiox7O0vJJ8V9S+usVejYUq5ly0049IT7Ajt1yrV3XUMFqeeea9iChIeheWnCSGmYapI6migh44fjrfDVdGhobYNnM9K99bsU4knxb4gzytQ35yT3Xzo3m+/b6E0+ug372j4jlN7pOhZYqITzZcwl9FysFQ4/Vo7Q87qvV2rTYAkH5hAVMmc3LOm6Y4Ms5CGUDe5hPgXdt8AObWpC7POiGNtZuLSBITIv6sCDA43NZz3R7EZW4iLzH/TUcqPIb/3ZlPrN8aPy8d54QaCL2FSHZlV6e7dqz7Vjcx1q+gwr7wUCkyypkqn3H8AJvJDQFgUM6xhCLlz7Gm5zAAm9RnyNQbqvx9Z/i+esDoCBvUUCDjxDeB69S8J5XaokXankAboWwR0w8SSbc5uzLw9qLQp9/RqeUaV7tFtnQ0snhP+N4tri/9f/wDKuZnoNKEfl0naNJH/kOCRRy0S5hUoxGta196E0aXBGQBeMFjXn/N4bS6qMAmUHEDvZf2L76NSCIiD9d4KM2HAJiFUKdoJ18DMRLzQ9fsmpRcb2uAVgiNrKudU5qIG/FO1L8GJJjVkeDXCJIiz1n3sPlceUkwXjup++bBjy1HpGQdXZVEwUkJy/vZIguELTUoJae46PkrlIN+8EGSjYj2r+aOMz5fe3QCRS68FDxtug6ZewW8rdP6O5UhKP86ApuRcL3umzNtQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199018)(5660300002)(44832011)(4744005)(53546011)(6506007)(2616005)(186003)(8936002)(6512007)(38100700002)(83380400001)(4326008)(66476007)(66946007)(316002)(8676002)(66556008)(31696002)(26005)(86362001)(41300700001)(478600001)(36756003)(6486002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGc1UzVvNWtVVVhoY2thNlErR2ptYThiWFNUa0s2VExTQWdieUNhekZwbTlI?=
 =?utf-8?B?amZSSityVGpybzliWDhtRmI0dmJjTDdlclc4aW5KV3FiOXgzUlpPZEJORGFk?=
 =?utf-8?B?LzcrM2tHVXVqMDVvUVZTRGFTZCtHOXVHQnlhVVJEckd1VTh5SzRrODd4djdv?=
 =?utf-8?B?aU9saW5CRnJuM3cwaE9VdzgxSG9jQWNyMjM5RmVlTTVMdm9DUDhiZGhESEw4?=
 =?utf-8?B?cXFiL2tXYVduR3o4ZGpxQ3psZnZQMmp5OXZOUjR1V1o3UzE2UDdyRFh6UkJD?=
 =?utf-8?B?Z3NwbUlPY0NGWURGWG5GQ3Z0RmtpM1R6SDRMQzE4QVgwaUgvUEVEc2duNUlK?=
 =?utf-8?B?UTZ6NEp1TGZaVUlGUGdDNE13YitzNEhhREFEaHlJNHlCdGJVK3YxWjJVSkVL?=
 =?utf-8?B?OVRHS3dVQVdrbXNZNjVXRTdMMmU3eTFJZVh3RnNTQktoSkl0NXkxQW9WTHpW?=
 =?utf-8?B?YWoxdlZ2VGhxRkpibFBHRXU1M1d3dllqTjMzVzRPNUtBSUxGN3ViSERZWmtT?=
 =?utf-8?B?QTN5bHlrOXBKSVJPMnU1OWF3TFBxM1p6VStRUVkrYXhYMVNueG1LOHMzcXVz?=
 =?utf-8?B?VlVKWWhTcTEzV1BwYWIzc0IwUndabFBrcDlMeUNRRGNPL1gxdWYzMHJHcE5F?=
 =?utf-8?B?enJKN1FqblJ1NkZucmxVSGhCVHB6MnpKZlVXeHR0cytLa25rRVd4N3l6VUtT?=
 =?utf-8?B?aWd4eW54WTF5SG9DNE9MYk9jWitrK01xcG1QbXhlejQwNWNGQmwvLytSSmp1?=
 =?utf-8?B?NjUrenRhY3NIaTQwMmRvbzNzTXEyaEx0MFdDMGVVL2VIV1pZT0lncjdvSk1a?=
 =?utf-8?B?TzNKa3VWRVJLQldWcEVkRVJ1aUJlRDFDL2dNZXFIckY0UkFGWWdlZTNUR1NT?=
 =?utf-8?B?anNwTnVxazlQZTRSK0xyNXlUTm9jTTZoOWY2UnVCVEtUVHptakhFQWRWQm9F?=
 =?utf-8?B?YzJvQmhPN2RRQXJiS0NoWkd4aVR3UnJCZGxZYU1PaGtwN2NnUGJ6SFMveTRr?=
 =?utf-8?B?NW8wVFBGZnVDTjQyUDZGbUVzNHZjdEkySFdqcHl5QjU2YkhCbWhwMUVCQy9J?=
 =?utf-8?B?YktvUWdHdGdEcGlUKzZhaE5Oa3BZRndMS3VtVk5CRDRiL01zMUdKSDdnMmlL?=
 =?utf-8?B?czNudVQ0OU4wM2VhVDlYZnhPcDhFTlVhaHlqdWVITWtUMGgyS2U3U2FpOVNJ?=
 =?utf-8?B?QjlvMXVIUTdYMk1HUGpWRXB2WEFLMG0yNEovNGUwSFNJOXErdFU0dC92Q0hN?=
 =?utf-8?B?d21ZcVF2ejBlaUxKSWRhSDJHT1NjY0h5ODdIZyt1N2lNSzY2VkpGWjNWbStG?=
 =?utf-8?B?RU5yUXJ5S1YxY1RiZjBlZVg5Q0hZNUtXSS9XQyt5WmNDNHRRbDdLMFRtL0lt?=
 =?utf-8?B?WWFnNFpDaytxeUFUbElQbVgyOU5YZW1mU3BTT2YyRDV4YmtScW52R29GZ3pS?=
 =?utf-8?B?YkM3MFdSNy9uREFrNGQxdm03dTNPUHVSQlhpcCtIMk9HSThCbHpTcFR4ekgz?=
 =?utf-8?B?cnF1aWY3bkFxMHJwTGx1WXBtVEtQcTJGV3dncUE3ODhDeXRFd1JURjh1L3dp?=
 =?utf-8?B?TTc2WDlRNktCSnpLY2RvcnMxTlRIS29zQ2g4OTA1clB4TEFyNkYzVHJPOE14?=
 =?utf-8?B?MEowZTVDeXdnSEdGMTBhRGltanBSY0JXcVRKbVBlUHZoR1RIV2NzREJ5Vml5?=
 =?utf-8?B?SHVNU21wN3EzU1JiVW40ZUQzQkt5MFQyNzRDWGh6QU1qd2VhYTFrdm1uV0do?=
 =?utf-8?B?c2dZRUtQVDNra090UHVRS25SL0pJVmVWbXhCajVMSUVJQ1NZN0lzTSthZ1pL?=
 =?utf-8?B?VHdTVWNDWjhLMHNFbmFMK21kUXN3SzFkbG05eHh5dHZLcklXNC9HSE01ZFMw?=
 =?utf-8?B?UzZXV1ZBeUpKV3N5R1JpdDMwMFl0MlZGOFJRUk9VRi94YXdWcDFWVWJUOGR5?=
 =?utf-8?B?YjZPUng3SThaSktiMmNzYmdkQkFoTVVuUW1aeDNDT3FzTHJndzUwcm5hRXdL?=
 =?utf-8?B?ZUU0Q0RSdE1aNldIaEpmd1hHRU1BQlVDbmRCbkVVZEx3NWRoN0hORkJCTmtN?=
 =?utf-8?B?UmdrclJqdmdTZUdYaVR2L2RJay9EVkNNdTJZUGZrb3hoNTdjckhMK3AzYzBP?=
 =?utf-8?Q?DxdbCk4OQEEJr8wqSNDcKGScG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb91ca6-c80e-4089-6aab-08db0abfb4ff
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 17:04:29.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbGUmt3FLulu4B/x7XKXO0nQKwxe2GasGT5IO4vhKnKRaZ3o58ZY23Fy8qztT+NBxWLbSzztfVElMWkrhdNu8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed commit typo, if you could please fix, s/definitios/definitions

On 2/9/23 10:19, Carlos Bilbao wrote:

> Fix definitions of VECTOR_WRITE and VECTOR_HEADERS with proper bitwise
> operand for bit shift.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>   arch/um/drivers/vector_user.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
> index 3a73d17a0161..f7d3956f5c15 100644
> --- a/arch/um/drivers/vector_user.h
> +++ b/arch/um/drivers/vector_user.h
> @@ -68,8 +68,8 @@ struct vector_fds {
>   };
>   
>   #define VECTOR_READ	1
> -#define VECTOR_WRITE	(1 < 1)
> -#define VECTOR_HEADERS	(1 < 2)
> +#define VECTOR_WRITE	(1 << 1)
> +#define VECTOR_HEADERS	(1 << 2)
>   
>   extern struct arglist *uml_parse_vector_ifspec(char *arg);
>   
