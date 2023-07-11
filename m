Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC074ED20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjGKLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGKLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:44:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75775E0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDiFeJywlTw5yNOV8BenLDYxDn/D8gnAxoEfDo6KhYhBHPQk6DBEg/uZxXZxzxGoSda3Pr72WEMya/CNJKN2Y0/GFUBDOXmhmnNFORBIAHkE8mifdd17BVeQbFrB2oXrM3GP/JR3iIE/RbhVXz8pfpE4J04Rys0Qg8tFKDz1Azclgqa46o8GF6duWAXXv4U0d6hhOJsGSBjK5rwOESang1zL3RsyZorA0Rfq0A1KouJrhhBJNNCYcDusjlwpHFV99Of8+tNsm/yyzkUGOP8wV8BrbZDSpvt6O+eFqaon/9tJf9jzEeakEGTaewRVjhPvhn82IXIuRuV/HNGmIGbbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyvWJ80Tf4mRx62V28HGBbA5hpFFG1MgvN9t2Z0j2xI=;
 b=JpwEla5YARmzmXuEoFPjjDGn30jFrNPuus2Yqh9D2RP1hLqN6zbZuJ7hCj8IK/6Q5mb4mIAEBEPx46nG44X6SQfXdXFwnT2JC8hAbO9oiTtHo8RF/GSZGaGAljyRocNIlY9waCHTJ32mGbCdsxWWaufZn/LP6i9tYwbYkudtvBU85dbcV9OW3fGextNLQCr/JEWOjWaYHmhkY5jYMtukblK4zpU6K+8pnWSoV4d9AYGpe1fD/57rNZwJ7aIlco1qRxYVyyhQLfadCINEREYZNM64PAIH8IuM1XVxSJUwmzhLn2nMcM78aAhE6UtExx05GrFBUmAzve7mLbrg/CzKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyvWJ80Tf4mRx62V28HGBbA5hpFFG1MgvN9t2Z0j2xI=;
 b=vr/jljUDEVGpwHi2HWhjHYXhqGP1Dlj98nLSIy9vvmykmEMy0hDPPgzGq6efm4I9M7Y9QmMz4ye967vkfRhrO/Ay+uR4Ck4ULIlQnvNFkkbK97eJhGNTRR9dGfu9HzsE+bMJtpH/SfMwtH3m2udSIZoZBMwEGzzDfLyFl4kmmp49gb+Djm/yiBttBHsnR/JrzpE73tHNtNx2/TXTbr4BwlOTFgicsgY+9Vmm4PMyX8zcDPJBnzG1UvD2X41nDvvkoK7WdTHTlj/mG0YnFyiY4SR+aTED5HapiEQfLG3PhS8biha+ucvm2EBmXFciNDha85uXymwvhxyH4JFT9qjHKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DB9PR04MB8188.eurprd04.prod.outlook.com (2603:10a6:10:25e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 11:44:36 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::66a2:8913:a22a:be8d%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 11:44:36 +0000
Message-ID: <3b2d58d9-a8c4-1315-3f1d-d19b701d181e@suse.com>
Date:   Tue, 11 Jul 2023 14:44:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86: Remove dead declarations in ia32.h
Content-Language: en-US
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230612154438.638491-1-nik.borisov@suse.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230612154438.638491-1-nik.borisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DB9PR04MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d59cd71-00b1-4910-7a5d-08db820433db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9IVWExi8w32XVxmXNuU0D2BpeTJG4M4pDbdE7znn8QNByNeFb50m9NwsPckDa7NQji4TJthkhnHVgggmvbBiz6w1vt9D/htgcpQboYvZA2A769hgr+j13kzOk03JLuM32Efe6uZDAHFSjltc33nojOisIwzz7vJi5R9Bxc17IvI88f3iDuCAlf/r3S/LhjfbJE0bwLP/0IDm/8prHIHF87EwyEIKLoQx4KXmwgPIDCdhMPAN7KMt+Ln8/3IWF1XWVBjDmU44lvGmqvZqgknUj5Z9i7TSWyJF+IzcAQ62fmEKx8Yjm/QP/LML2/OEdZBh9JaZaeKR9Lx/kDTpPsA5ynFG4VheGnu/bn3p89CUGkAio3Fdo/zCPp/PgEyemCMm/ffr5bNU2urnz//ndAysT1pH56PrlzdAfFeLQbEoqDZeJxshu75VRTAZhYa1n7MHSGmOqgtKGwlc8SlnO5fXeVMxg10QDTl1ebvAj7uz+O2l3Ylxwm1RifArUM6ITZlPX2czxpX7CBmTN0L+EPJ84j4/9lDQ/Ion6yBss+DmipY6VtWUs8SrhZaCJ6zl+UEeQqXB5rEheuSZrWFBPZshtlPEyH5grEyl/bA3SkT1UBJXnS9KG6Dsfyg+yz6fl/vxRfsd4NLj63ymmP0AKIOsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(186003)(6506007)(2616005)(6512007)(83380400001)(41300700001)(4326008)(6916009)(478600001)(4744005)(66556008)(2906002)(316002)(5660300002)(66476007)(8676002)(66946007)(8936002)(6666004)(6486002)(36756003)(38100700002)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW04d0h2YThLTnI0VlFjenQzMWF3ZTdoODNwZWlETFh2eU4zQlpDbDFVcmhj?=
 =?utf-8?B?UzZkWEhNVjF2MndQaVdYY1FrdnY4TjdCN25XZ20zTEhFUGFNb3cwa0M4OUZi?=
 =?utf-8?B?RDkxc0ZOZ0F6QUd0Y2pQaWcyYUpvNi9reVlENjdBUUFZT1cwSlZRVVJRTU9C?=
 =?utf-8?B?ZHJFdzlBMW90ajRENG4rcFlTTVZKNTlCKy9wbVhmZE4rRFZia09LK2UxQm1E?=
 =?utf-8?B?M1cyb2dFcE0rdGk0eTBjSXJXRE5LT2hOUWpiblNTMWt1WFFwMUYvQmhSWmhW?=
 =?utf-8?B?ajN5dkVBbjJKcjViOVp1dHhPODdwTXViVEp0dU1jcWtjdndhTGRRelA4V2Jh?=
 =?utf-8?B?NXRLMUlWaitlbUY2enVrS2FjVkpadHB2OXBYU2FQeHlLdjZRajlrT2xmRVBR?=
 =?utf-8?B?TDducmhIMEFVa2pxczR1MmIwUWNGM3FHWVN0dUxvSncvN2YzNDY3cU15b0h1?=
 =?utf-8?B?S2pUQk92UTNnaS9DZkxRYjRjNkJ6bUpZWXdVL09GRmkyd2d3cnBXVG1xL21t?=
 =?utf-8?B?N2ZseXJxK01oNE54UTJKWHVXWXRZckQ5dzEyQWY4bmNBb2JLNy9EZlRIczlr?=
 =?utf-8?B?eEtqWEhLa3VRajNaUy9CdlhoakRjazFEUDJNWEpIWGwxTkpqRGJXVEdKN3JH?=
 =?utf-8?B?N09SRnlOY0l2THhzWWM5SnVLVElXYllqaERjR3RiTUZOK3dYYlpjelByMHAw?=
 =?utf-8?B?cmdudWRkMjVPU25SZm53eTZtdjRmVURjU1FKdm9sTmdkS1YvT0tHaTV4WHdG?=
 =?utf-8?B?eXhhMWxOdmZ4dEVhdzNxNWtrYjg2WUl0UGpCQjZUTk03SXk4L2kxVUM3aEpK?=
 =?utf-8?B?M2Z0aWd3ZWZiZVlpTFZ1ejNGSFpTZ2loYkQwcU9EcFB0S095RU1CTURNUHJK?=
 =?utf-8?B?ZmRaSjBUNXB0eHNlVzdKSVJmb2hObDR6c0NIVWg0dkk2S2trU2hBaWpRYUJV?=
 =?utf-8?B?Q05iMzNPV0FYSzNNV0diNUJVK253bVJUeDgyUDYxWklRblpuNlpCVVNNYmNh?=
 =?utf-8?B?ZytQaUFTWnBLS3dSYzAxVUJlMnJROEJFRmthVXdkOTFRaVBXZTBxWHJqb01Y?=
 =?utf-8?B?UEg1aDJiVUZSSXdqNWRSMjNYUG9DbmdMTzd4cm43alF2eURKeGxIb2R1U1Rk?=
 =?utf-8?B?ZFhMa3ZNelZBM3AyaCt4MVNnV29tYlViZ2wyanlVeEp4TTF4NUlJRUhTYkly?=
 =?utf-8?B?WllXaFFxV0c2US9LZ3ZhQi8vc1FPOG9QMW1zVlM4dnVJcU1OKzArSUpPcllR?=
 =?utf-8?B?OVBDdGhEeTFOMDhrY1JCZUxmc0VocE1QTzBwa1RlUUZUWGNTakx5UUhHNlYw?=
 =?utf-8?B?SWxydU80bEk3RzMwb1Z6cjVFRStMMmc0WHhINWpzNUo0TVJySFc4TXA4ejha?=
 =?utf-8?B?RUlzZWNENFZOamEzOXJJMVJXTSs2RjBPZGZTK3NjVzlIUjZDa01GWFJPTjM2?=
 =?utf-8?B?WEl0ejY4bkFkWStwVlMvYWgyMEd1OS9tZHFiS20rVlY2Y0hGekdGNUZkWk1R?=
 =?utf-8?B?ZGZQN2VKWitIbjZUcm5BT2VyZTl3UzJyYVA0N1lmT1lPanh4eDZEVFI0Ri96?=
 =?utf-8?B?QjJEVWVESWxJeFc0MkdDcFozSjFEQzNYZFR0Qk9jTnQ0SHY3MmNuK2VjckZh?=
 =?utf-8?B?VkRyMmF3ek1qSHlWWXZORmo1UlZ6K2lvalV6VkI2SzFXUU9IRDlIbjloVWdh?=
 =?utf-8?B?MTVMcUVjaTl3b2VISmFaYkFFUXNwUHNvWlBjWmZYaHN4OVhQbHRKaCtKZU9Q?=
 =?utf-8?B?djBxV2JVWXdrZjZ5VU43bTRvQ3I4RUZINmVCNExudWpsZFNNaU9TcVRwUCt4?=
 =?utf-8?B?UTFodkVrWVVZeXlOS2VSS0Jvelp4Ri93V1cyYWFiMitUN3NpUVF0NTViNnky?=
 =?utf-8?B?eVBoVGhiajRsSTliUWxIdmh1Y0ovL3RqdHpkOGFVcEN1VXNDcUVXT2hJSllF?=
 =?utf-8?B?N3V1RVRLRDBSdmFPZmxLaE9Rb0cvbGZlQUZIU3dDNDVOc2s4dnhOaGxqbkJH?=
 =?utf-8?B?RUpqaDU4UEpxY2oyazNvQWZtaVhlbVhVdmVXbkhsbkFlTmlmTUJLR1BXTFdK?=
 =?utf-8?B?NzNtUXNERHNEQ2pMOUt6UFFkWUZ1dXIxd1JTaXFOUlcrSHR1b1FqZjY4MjB1?=
 =?utf-8?B?aGRJTzJMa3ZmWU9JcXQwYUdGNmhNUzRRR2FseFVCUkRoZmUzcmp2M0FkcmI0?=
 =?utf-8?Q?J2oIxlMkd6VreWJkuR26FMcFbs4jd/rpqXbf19Nqh7LH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d59cd71-00b1-4910-7a5d-08db820433db
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 11:44:36.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNqNysLxIPEHLg2afzmHEUeK4nCWpu+WAZmaXyXEXdTtdnCvEBGyn53HjCDFuVcjBs+6lBSY3PFR4BVxLbCm2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8188
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.06.23 г. 18:44 ч., Nikolay Borisov wrote:
> ia32_pick_mmap_layout got removed in 675a0813609f ("x86: unify mmap_{32|64}.c")
> and ia32_setup_arg_pages was removed as part of
> 32974ad4907c ("[IA64] Remove COMPAT_IA32 support").
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>   arch/x86/include/asm/ia32.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
> index fada857f0a1e..068f6227dfdb 100644
> --- a/arch/x86/include/asm/ia32.h
> +++ b/arch/x86/include/asm/ia32.h
> @@ -59,15 +59,6 @@ struct stat64 {
>   
>   #define IA32_STACK_TOP IA32_PAGE_OFFSET
>   
> -#ifdef __KERNEL__
> -struct linux_binprm;
> -extern int ia32_setup_arg_pages(struct linux_binprm *bprm,
> -				unsigned long stack_top, int exec_stack);
> -struct mm_struct;
> -extern void ia32_pick_mmap_layout(struct mm_struct *mm);
> -
> -#endif
> -
>   #endif /* CONFIG_IA32_EMULATION */
>   
>   #endif /* _ASM_X86_IA32_H */

Ping
