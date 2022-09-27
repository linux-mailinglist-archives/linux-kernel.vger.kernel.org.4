Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C985EC91B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiI0QJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiI0QIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:08:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20602.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EA2A74C6;
        Tue, 27 Sep 2022 09:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWeSQ9pqMf+sYbO3R5q+m0qz23lNTCTkKqu3YygdeVdhoQ+6QWo29JC03lA5dAD/zPx1iGEBceRO6dGBqPyb2YO5XT3HJ6ddxjHueayZlGUyHxY/9PoaFcAgpt3NvGErMW2WSp+KMDWgJgy+gAQNoEmBLgb0siYiwBEnQYqNUdfu/If08O6pHZ3fp2XS/SxpUYReoQv/at18Fy5lba1L4IvRMnhUtVPBv+3AOM/dJaYJ6lIL/RusxdwXbgVPUP0w6qy7qrhpTXN4mHeDJenib9K9URiaJFznOBYykXMMfhqKBvaj/d9uSw2kcqPxWLo5SWxLBk0x5kLQ6nvi91YJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvs3Aupf1ps2+UeNryTA5+qf1vxan1qdJLZ6Ne7bD8Q=;
 b=F1PHbtm+RZp9/YXB2vg46c8Q4wYQWgPx6ctFIuCx/B4YqbpiKBGX6JWr4+rKO2ULQGDu4l+xq9lLGkX63i2WodqtRcdrXwV1u7fnPh/QienlIS1J0Dh2u2yRE4fwaULzCkMl2fa6Du8yo9vrgLRyVz7s/EIOx7G+KGr6oPjzmVlUjbcoAWy/SnKSWeiQdxh+rsmp9+8ehkUXv3rMqQHHGl5ior324rcIHe348Mp4+Ic89SLYIWrNIAGBUaqrOagx3Q3fEG/4mDTC+nYCK9reDq2PdQaK/+7KGDDJEDp2cg8B4j+srb+UKOdR0NTIxsAlLt+ZjNon/ZDztb7cOSdbfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvs3Aupf1ps2+UeNryTA5+qf1vxan1qdJLZ6Ne7bD8Q=;
 b=HX7bJPuYR6iRNmBwwzqVxlrBHkINKi7V+5tDLv74jzk5474BRgp1Qokmwi/EvHVOxMuxkR3VMFh5n5KFxTiBKkxxvuEfDznpSJZSCgzGineoXQup4SN0x+NoNtkZFgI4MkjOpN3AeKWQZph+9MFi/CdNe1rBKZsqemHBMaI4e9I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 16:07:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%8]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 16:07:44 +0000
Message-ID: <df22755c-bf4c-9d85-2c7c-a149f8580d05@amd.com>
Date:   Tue, 27 Sep 2022 11:07:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 7/7] acpi/x86: s2idle: Add a quirk for ASUSTeK COMPUTER
 INC. ROG Flow X13
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     travisghansen@yahoo.com, catalin@antebit.com,
        Shyam-sundar.S-k@amd.com, ruinairas1992@gmail.com,
        philipp.zabel@gmail.com, iam@decentr.al, hdegoede@redhat.com,
        davidedp91@gmail.com, marko.cekrlic.26@gmail.com,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
References: <20220921204055.22889-1-mario.limonciello@amd.com>
 <20220921204055.22889-8-mario.limonciello@amd.com>
 <26bbda5d03f0eadc54dfa0036e24e16ae9134f5e.camel@ljones.dev>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <26bbda5d03f0eadc54dfa0036e24e16ae9134f5e.camel@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0115.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6b1660-c034-4a34-751e-08daa0a269d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kwonnyErBlT7eDLq++8k25ove9CG+V5itqMry97zRoR+Od0V6++8DrJhVR2yveXndnEzX4CBJQmBZrVNotYo4a3kGPssCOjgb8o6uYPzIds4aB9g2rE3yeXtwrNFVB6wdE+eOOkvryIjsPf9cwhPh6BamCLOdKNGsLB8TLKBga9fcojOX/M4o6G2kx15tvw/0Vmt8Y7yDcP6Hl9Z++N1bft0gY1shZKvrtKZVJK1ogCrN6nAfg6b7HTakZmKVi9EovKabMt0C0BVPHKc822r9ALf+z9SNpLoaHEvIKRFfu47kWx/dhogxjcJiOv3kZmAPla9Ca5bQtVvv+8roPtPsDI5qFm7k8tssnh6FyI+yLsI/czEcCuUI33VZiqOihXHdC4FQ4C+pOa7h6bIw3WwN6bzz7AvHHImSAWYJEIPLgZAb39P3DgNfFLVLSoYh0GFkPXGLWgrGgKM7oIxt6ZwDJnhcWhTLThcAndqhSKWFIlNmNOQtaOgBSnHf3jlvTgW1s+TPb1SXVG7bbkI5/nJkT0fUCW6coUqzkLG+bw+an6CkePCkpb4uk6K8KBQAWAbEvdxNN0FBiErDS46tt2p7T8JGOUE8Jin4uvVqVs2NI21CsSbdKTAMyTgML1d20T5p28hFsV3ygX5i0DpMK3PB0Fdfo7PhGYCPrGjNgYYPlGKapKI+xPyBVk1M/Fi/n/m7RDCvvNZ27wTC/nzeHGIDBKvz4dVvwIqR7o6S8Tm+B81jih9gQaqmg9Tv+hwKO7RxynC93wq7kv2Q4cvnEJgf7ckC5D0g7vcDrbUf7XyGg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(316002)(6512007)(6486002)(36756003)(186003)(2616005)(86362001)(31696002)(66556008)(83380400001)(66476007)(4326008)(41300700001)(478600001)(8676002)(66946007)(8936002)(31686004)(53546011)(2906002)(6506007)(45080400002)(26005)(7416002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clFIcytzSVVuUnIwdjJJN3B1N3dBdE9VdDFVaGN4TkR3NHVrTHMzQ0N0Rkgr?=
 =?utf-8?B?dmJsRVJHSGV5c282WGUxOFJqSVhnUDByWVNucFB4Vm5YMnNVT1V2aUxoNmpD?=
 =?utf-8?B?Vnh3b3Rnak4vTG5qYS8zOG83ZlczSUlMRmRjRUpEVjBYU040UkxTTXFGRThv?=
 =?utf-8?B?S29wSzUvZExyUjdPdjg4elJYd0RSYWcyV3o4VjU4N3dmVzdySk9hMkZFWEx4?=
 =?utf-8?B?cFp6dlJmSzN1dzZST29hUEpzcmVSMjBPT0ZBajRSTzRlNFNnQVRpbEtkdGNl?=
 =?utf-8?B?LzZSTkZPNTJ4V0xVVlczQVEwcjhnUHJLN05BM2s3eDY0aEJuNFBRRUtQM2Rj?=
 =?utf-8?B?QVdham9zUTVnY2tHczVWKzNqSVdUTG51bEtDSGhQaGYzcXVIV3pCM0lwQm5E?=
 =?utf-8?B?ZTJNQk9KQ1lvaWtoUEh3bVhVSlYzY01qNUxJY2dRU1BKaTNnR2h0UG12Qng2?=
 =?utf-8?B?QUdEN1VRZFNRblNsT0pyZkcwajhjMjZocUdVZlZ0NS8wQVhzYldqdzlWcG1S?=
 =?utf-8?B?ZTBjVlBZa3F5S2FJS21WcllRb2N1WnN2eWhURW5XdE42cHZHVitId3JXbWFv?=
 =?utf-8?B?MVpjelB0dEJIdVg1bWl6aEF2WVBGcTZDMDZ0VHhBS1dqZnJ0VGRvVDF0NUJU?=
 =?utf-8?B?L0Fzay9kWFlBZG4yeVlPNG85T0VNRnVTTHFsNGNucmwwb3dHRHBnNjljNzlE?=
 =?utf-8?B?by94RzhKa093bkNkRkpod0V3OStUVk5STUtleGloa0FkOU1zbTAzK0pMREg2?=
 =?utf-8?B?NGdhdWlLeGU0VXdaalAyUFFjZ3FIdWswT3ZlOXBINW0xOUJzdnhJSzhzTWJm?=
 =?utf-8?B?R3NadExEQy9GNlZzcFhHbnlhVWExWGY1MThTT2N6QTNOaVl3VlNSdStXN3o4?=
 =?utf-8?B?SGdTVUtXYUsrd0hzazRRVGFkNFNxZjNUaEtWVnY0MjFCSGowMnJSM3MyZlJk?=
 =?utf-8?B?TTJkQjhrdFRXY1krT3ZFbHg4MldwSUlrbDkrRk9lUSszdmFvNENTM004cTRH?=
 =?utf-8?B?bnNsWktjTXFSRmZhOW9WQzRJc0IvTlNTUExsbjgxVW9iZlM1M2toVGZuRkY2?=
 =?utf-8?B?QURadjBXT204NzVCcDM2dGh2Sy9abmdaUlZGbTVLR2FjVFFtTytiWSt4RW1D?=
 =?utf-8?B?cEJHYXByOTJMNW9heWNZcmFUNS9JSDZIcHJOZjVpV3JUVlhaRkV3amp5MTZQ?=
 =?utf-8?B?T25OUUFyb0xDclkyVWNsQVR2bml5NTNCTjMveGt3L1UvZVZ5VkFPVnpsaXhT?=
 =?utf-8?B?b3djM0diaE9qVEZoT3cwNHcwU241UGZlTm5lZU9nQVpOUXlreEpaSWVZbTZu?=
 =?utf-8?B?cS9zOXZVcUgvWmVuNldSUVdvSGNkQW5ON2lyalVWRkZmNHBXVUdoNWloRzJT?=
 =?utf-8?B?N1RtK0Y3MGdrRUIwZkpMOFNDN3psK0haV2xMMUlxcmlvR2xUdmFKWkYza0k4?=
 =?utf-8?B?dUVEdFowSjluUEJSOVhySjBoSUdNcHNnb0Rnck5jY1BlUjhyNFpCVitibEtx?=
 =?utf-8?B?L1RUcHA1Z3lMcHFSMFVXVm92Mmg4aDRrNlpCQjJCMVZjZm5YR0Z6b05CRDdR?=
 =?utf-8?B?aEpZSG5sdXAyeWxoMVNnZ2VXajNiUjhvWCttOUNtOWxaNHdYbkZmQU1uMU1U?=
 =?utf-8?B?ZUhYK2xKbWdLRk40NVhHZWpjVTUzUWZGUVhWRzNSY0FkYzdWRWdMN0FwQWFs?=
 =?utf-8?B?RWNtRjkwenhGSmlvQUM4bGxKaGpHZmd4cEVsNERrcmxCWXdpTk1NZGVNdGVM?=
 =?utf-8?B?WlJuWjJFaE9DUjhDZkdKZEQ5ZmppMVU3WnlYaW9iZHRHYnNlb1hQSkxnb0Fi?=
 =?utf-8?B?N1ZDNlltZzdxMzNXbFJYanNrQmd0dXo1Qk5lUFUxVHVHa093THQwbGdnbVNT?=
 =?utf-8?B?akxsSmZTMmJIUXY4YmtGQzlhdlppaWpndFE5cXhZbEVvNlF3TGNIZCtpR0JE?=
 =?utf-8?B?b0s1R2libURlTGFGVnpPTlkvRld5amlIUzNtTTZzVDFMZkVPMEs4NG44TmtB?=
 =?utf-8?B?cGJmZ1BBYlJhcWIvQXNaT0pQSjZ0bjBCbmtsL3lSOU80OTZjcDArRlRqbFQx?=
 =?utf-8?B?Y2lxanFXVElRVjA4bDFuZG9oUWJEV2dmS0pSY2tBSGlodEtyNDQ4M3R5ZGIw?=
 =?utf-8?Q?4KwwXlByJk/YUc5usB1I2CgmI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b1660-c034-4a34-751e-08daa0a269d1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 16:07:44.8389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYtX9b2q0HviymqNyQC270hne0tX9LVhKCFNzvdiA7iG4n8mZ1yL0DdtqsizYzL1wZA8FOzay3ntxggPGRxCfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/2022 04:06, Luke Jones wrote:
> Hello Mario,
> 
> I have confirmed that another suspect ASUS laptop requires the quirk,
> patch is as follows:
> 
> 
> ---
>   drivers/acpi/x86/s2idle.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2cd381f6c002..c811eeed42cd 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -428,6 +428,16 @@ static const struct dmi_system_id
> s2idle_dmi_table[] __initconst = {
>   			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus G14
> GA402"),
>   		},
>   	},
> +	{
> +		/*
> +		 * ASUS ROG Flow X16 - GV601
> +		 */
> +		.callback = lps0_prefer_microsoft,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER
> INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "GV601"),
> +		},
> +	},
>   	{}
>   };
>   

Hey Luke,

The series that was under development has been merged for 6.1.  At this 
point, can you just make a proper patch with a S-o-b on top of 
linux-pm/bleeding-edge for the new model to add to the list and send it out?

In addition to that, if you can please add a Link: to the acpidump and 
dmesg if available?

Thanks
