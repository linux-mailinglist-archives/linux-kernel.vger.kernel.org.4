Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E906E3229
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjDOPtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjDOPtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 11:49:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C0E2D59
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDmKGuzGtZ0lVDBWwU3+bSAn3vIaxevc69Fuu7eGziQgo3uVVLlpB5TP1pQ5sRUbjY/M+ZrqxVPwzceOwhShplfsbxTsKBG7jZok3otP+6XL1aFXuIn0OX8QgukL7CPc5Hh2Ssef6mLZPryFz7bXzzcVFlWAHdRu7RZYMLe20phMGUQYl//0B2RS6d8Y6Odxw3qGHksU1mNMs5/yA7RmQPScFUVYgWPOwe/PcIKK6aX5sRQkfldL7xW9blAJKRKMU3LiT2REKol8HdFB+yj//j7KQUvTdn1ZIW27ZnxlasAdPPV/Lupd+RXE0E5FUf7aABB1mPPCBefWutE7RF6p4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8erQNTKpI6nvF8ycI1YQx5JDT193r+0fEonS7cIg3bY=;
 b=YKpi1rh2iAzPkdHwu2yOTefN/s0VO4ewT0Mcognl8en40pl9L5yIgMYa+NfXfi/f64//NNcmDsupF/ygnMr8VGxrpk1t3alzTR3HkS8cy9MHlvv+9vu4QCPuA+uFWiUlt8iBFQZlTljxzCM4EkvNEMX9qfP+THzWQh7IAPd7O29TsYbk0Q0DVEoNK28KLbxkVqAkjbbC5W0sElc0Bd2YJSKHA+E91Z2rfAd5HK8yWq+FzHt0BnoDQA68SOAdQRjLFSJ2YnpliYl5WIMo+YjYYWthYxr6lj8SclijqbJ5lGCkfDwsYYIBm12tMxnibV2iyhAShF0B4gKsYvzor9jNog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8erQNTKpI6nvF8ycI1YQx5JDT193r+0fEonS7cIg3bY=;
 b=P/fmWT5j4/jHhl1e/XxjsM+8IReRiHurY4dQA33ZrvjS2W6u0G7zRYnxaGG5ctOgmeMS7cisYVR/Tef0p8NZtOWojRSDI8B/yMGq0eCset8HLlb/FrU0HeZ9XKogJrXhSBIl3/FcREFoHDS1dwzLL3zmpQgPoc6jSUzdjzM/FndePeX80zlYxoI9xszgSgLkOqNTm/i5rSr/AHJ1SjClQtp9sBOl+YCWUzxa6f8A6pi/1qY5324/U7z/ZzzVRrUd7aP6UtvZjm2qoFpUuNf5R215gFfqht8e/Rhsxc5OG1KWL6fFwzAlBKF/u5cFE6BhjY6eWo5r0PQAx0ufgPmGcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Sat, 15 Apr
 2023 15:49:08 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::df7e:720:b6c9:df7a%5]) with mapi id 15.20.6277.034; Sat, 15 Apr 2023
 15:49:08 +0000
Message-ID: <3951b23f-bafa-2979-f349-232c509a33fb@nvidia.com>
Date:   Sat, 15 Apr 2023 10:49:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/3] Increase the number of IRQ descriptors for
 SPARSEIRQ
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        Jason Sequeira <jsequeira@nvidia.com>
References: <20230410155721.3720991-1-sdonthineni@nvidia.com>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <20230410155721.3720991-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::32) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c720801-b10c-45f3-cdfb-08db3dc8f290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXTz3s1TTRpHd+4O8Q7Z1cIIXJVvN+U9wXMqMUAyDHTRbuqFx/jqZjSv6ju2AB1D/TKaYwX7ah7+gs0wd897zSQRAQKyRgk770X51jV/OH3l4Me+b+fB54u8zvCloWLZYXklqAW+ejuI5hm5w1gND/Q543DSAgP/kJN0LY4JPXHK8KKQg6W9fr4KqBqdGUyrjzYq3g2xH9hi+JFcqQqEentOpdjEPCp6hsluuXcibHfY4ZEhx0GxoXaCPPdcMh1Px5GpkDi3xuE3VhCalGPhx1OUrNm3y4kg5BpCQy0dIBVhQX8qCEOLWqocHTyk7aBF85rOSUHaUhD9+RDOKTIFLVtcWsqFIPPtE83SSCbC+DIac5A/NS5xCBC3LDIL4tpv0EOODGbbKKIwBas4OATrmm5N0SQcsSgjNUUUgxm906MRGte80Q7Z72RrArAnYWTQeXZMWEzGAUapkxw/udwd4Jsz1kTLYTryKr4mLkykQ37CkOUCsDSsFjq6hXCkLOMb5/X8EqDTejj8+n+gVOtokZC85fvWI02qSNO/5p8Utien918IWQcKEs2LyulZg6M135QeDlS0uzDPny7IxLdtSYGVQFrq6aOj/FBh4BkfsTv2zoZ4QEG0LkksGo25FGm4PuDEoCk4tYGOwIIVS5aIU1JhLUKaoS7Fhs3sEUKijLLK9AmEqcF3nQW/oBRnYTXs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(31686004)(478600001)(6512007)(36756003)(31696002)(83380400001)(2616005)(86362001)(38100700002)(53546011)(966005)(316002)(2906002)(186003)(5660300002)(66476007)(54906003)(6506007)(110136005)(26005)(66946007)(4326008)(6486002)(6666004)(8936002)(41300700001)(66556008)(107886003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjAxZDg5ODdwQVBHY0hJbm16c3MrOWoxaU9VZFR1MnBMVDVWdTc0Tzg5dGd4?=
 =?utf-8?B?QTV1RDZKMDJYMFlvNmNLL2xNeHBnajFJKzdVWCtQckZpZ1V5NkVCcWR2QWhj?=
 =?utf-8?B?V1ArVWluaFpnMnY3Z2xWYWtCS2szWjZqbkZ1NmZnNVdZNFY0RlI1UVBVMWEr?=
 =?utf-8?B?YTBRTXhET3QwOVJZU1kzTDE0OGE2S3BYa3V3ZlM0VVVrQjNjNkQ5NU5laFQ1?=
 =?utf-8?B?eWd2aTEyOEhOTEVvSm9uNkUyNVBBd3ZPTkdpcUdmTU1kekE0dFhaQ1N4NVMz?=
 =?utf-8?B?R3JvVGR0ajdaTWh0Sk01L0NVZXg0MXlOdlI0Y1p2WTBwZXUxVmZkS0dHQWpl?=
 =?utf-8?B?VnZMZkdKTEZSMm0wcERKdHlNLzhSZjc2SWpXNzZGd2syOTJuU2tGcjA5TUx1?=
 =?utf-8?B?cmNNRjJhTi8vNzd6eFQvWHVJajNTNEdsRk4wdnBmb0xYWUIxTUxaNmtBYmRs?=
 =?utf-8?B?N09mQ0pyYjIybk1LNTRLVFFUdDRIZVhnZ0VDUTJJaFprY2U0QUVrTmtTdDlm?=
 =?utf-8?B?RWkrblFjL3BYZ3BBc3pHNlJWRHFVcDRPVFFJbkxOSUxCSWJkVlhYTFYvaDhO?=
 =?utf-8?B?Mmd4NEJoRTdzcSs2azZlOEN4VDdYR3BFeWtZVEFnZ2lEZEd0b2FCcWwwMkph?=
 =?utf-8?B?cVkvL0V4TzhkTTlQbTJXMXB4Ly8xSVRDSWE4NFltaUpOVjRZMTNndzQvR3BN?=
 =?utf-8?B?bnR1cTRmdTl4OXJKem4yclZQTHBWV2c1bUFvYjNKY3JvZlhBTUxKaDBGKytt?=
 =?utf-8?B?T0NyMUxPeng2QkFYZHBpZmFmd0ljcmxCS3hQSS95U1oybnpwTjE5VGdIMDJH?=
 =?utf-8?B?L2lLcUpnTHc0SnFqNWpwbW5haFh1ZmtBdFY1Y2wxZHFmeENuTFMwTndqVy9E?=
 =?utf-8?B?K0kvZzhkeTdyK0doUklWb2pTTzlNVEYzSlV5eGdwZ00wVHpNd2gxdWkxU3lI?=
 =?utf-8?B?eXhVY3VDOEpyTDVKR1JyV2xLK0tMek5pSEV0M0wyZzVkT3hidHFydnNXVjNZ?=
 =?utf-8?B?c2FBYnBJdHhwa1F2U1RNTTY2M2h2VEtseVJWTXlOazFNUERQUERaTHR1Vkxz?=
 =?utf-8?B?SnN3SWUvMDFlOU03blZPV0VBTGNpaVAwZno3MkdnbVA0S1Q2VDdNOVdLaFdN?=
 =?utf-8?B?eVlNV29YWFhSWFFDL2ZkcmtOTVJsTTAzMVU2Nko1WG04RjZQUUlHT3I2eVJT?=
 =?utf-8?B?WDVxQ3BNTUVSR0hyMExZRjZ5NU13ME93RkdHNTNyc2hZWGx6bnpoa3dhWmY0?=
 =?utf-8?B?bUI4aWsxYWFCWlBsZlYxMVRWbmRYK3ptWFZRdGw0MVlCWVVTQ0NvR2lnKzdR?=
 =?utf-8?B?MUxLSGtKdnJoaTRhaEJrbGNlbnF2WWxUMWlIcjBjUzRzKy84amNPKzV5M3FG?=
 =?utf-8?B?emlVNnU1MU9LRUErc0pzWW1IMmtPbkdVSDdGcXRGZHhtNm5nNnNWY1BwYzVj?=
 =?utf-8?B?VnQxcHkrUnBITXQ3S3JzMldiUGhSK3BpdzJqVjUvaEhndG45T09qQ2ZEZFJu?=
 =?utf-8?B?dlJyaGpFTUxSZnV5SUk3TkxRTXl4OGZnT1BjTWwzQi9mdXYvWGpsYWxXUU1K?=
 =?utf-8?B?aitQNk0weW9DTzNQcm85MEJuQXNTemhkOEVJOW9hTGtpZ0YwTWhzNk40dVls?=
 =?utf-8?B?ditEL1FIdm45UU9OaktucWM0YTlYblMrUkFreUpWM3UvaVVWVGpCS0N3TUt1?=
 =?utf-8?B?Y0pqZmJiTjdFRkwzTEdlZ1lwRXVpTENES2k1V0RrM0VHTnZzZTdDNW9KT2hr?=
 =?utf-8?B?TWozU2F0dVlLTy9jVlRaVTVOdHZGWWpqT25OQlBRSm5tblRnK2VGODZ3dnpU?=
 =?utf-8?B?RktUZG1Jekg3czR0RTh0NGRJbU9oZkE1T2FsZnVjenNIUGFmWTllZlNHdkRL?=
 =?utf-8?B?VzJqY0laRDFkOEo4djN4dW9DSWJwUVdscllOblQvVGtqM3pka1cvYlhBZENn?=
 =?utf-8?B?dmFnSVhxTFZxb1lxNHpWNCtYNE1FT3luQlpJVDNDRkMrZTQ1cVdxYVRRNHFB?=
 =?utf-8?B?bHFZYmNneTZxNzdBZXR1dWhWQUlQOW5IeTFsRlhWZ21tZ0FWYlVrRTdpajBk?=
 =?utf-8?B?ckdFNEtyOEtGYkwxZ29NakN2NmN3Z0Y4VWIyM01lZlNzVFdBcjJwWWwra0JS?=
 =?utf-8?Q?+fcg9LHPxsuyO4bvMAWLTYAV5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c720801-b10c-45f3-cdfb-08db3dc8f290
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 15:49:07.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPuGC4mgjtrdQUK1+2GeK5S3Wx4sYRFoYEmDM7QBKvkut2C5pUcSaaAZrtMJ2KRZ1aADsblkVWRnxESN9xZCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

I wanted to update you that all the review comments have been resolved and
the necessary fixes for the maple tree have been integrated into the mainline.
If there are any outstanding tasks required to consider it for the upcoming
v6.4 release, please let me know.

Thanks,
Shanker

On 4/10/23 10:57, Shanker Donthineni wrote:
> The ARM64 architecture uses SPARSEIRQ with a default value of NR_IRQS,
> which is set to 64. This means that only 64+8192 IRQ descriptors are
> allowed, which may not be sufficient for modern ARM64 servers that
> have a large number of IO devices and GIC hardware that supports
> direct vSGI and vLPI injection features.
> 
> This limitation has caused issues when attempting to launch multiple
> virtual machines with GICv4.1 features, resulting in the error message
> 'kvm_err("VPE IRQ allocation failure\n")'. The root cause of this issue
> is the ~8K IRQ descriptor limit.
> 
> To address this issue, an initial proposal was made to define NR_IRQS
> to 2^19 for ARM64. However, Marc Zyngier suggested implementing a
> generic solution instead of hard-coded values. Thomas Gleixner advised
> to use the maple tree data structure and provided most of the necessary
> functions.
> 
> For more information, refer to the discussion thread at
> https://lore.kernel.org/linux-arm-kernel/20230104023738.1258925-1-sdonthineni@nvidia.com/.
> 
> This patch series converts the static memory allocation to dynamic using
> the maple tree, and increases the maximum number of IRQ descriptors to
> INT_MAX from NR_IRQS+8192. This change has been tested on an ARM64 server
> with CONFIG_SPARSE_IRQ=y, where 256 virtual machines were launched,
> creating a total of 128K+ IRQ descriptors, and IRQ injection was verified.
> 
> Changes in v3:
>    - Edited commit text
>    - Added a helper function irq_resend_init()
>    - Rebased to v6.3-rc6
> 
> Changes in v2:
>    - The patches have been updated to v6.3-rc5.
>    - The patches 2/5 and 4/5 have been removed as they are unnecessary.
>    - The review comments from Thomas have been addressed.
> 
> Shanker Donthineni (3):
>    genirq: Use hlist for managing resend handlers
>    genirq: Encapsulate sparse bitmap handling
>    genirq: Use the maple tree for IRQ descriptors management
> 
>   include/linux/irqdesc.h |  3 ++
>   kernel/irq/chip.c       |  1 +
>   kernel/irq/internals.h  |  6 ++--
>   kernel/irq/irqdesc.c    | 76 +++++++++++++++++++++++++----------------
>   kernel/irq/resend.c     | 47 ++++++++++++++++---------
>   5 files changed, 85 insertions(+), 48 deletions(-)
> 
