Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5986F5A68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjECOuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjECOuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:50:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDD5C2
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OD8FGdPuaTgjAybMVdCOt3O85AszF1PR+VTcqJFSjDO/8I+ZBCbvn9tBo+7OtiPfhEvi3kqb5eugp7SsYWt15wEZFoI3VIJXEU9suEShs3ceNO5XJfYWFKEOfBvvgO5LL7sd7f0YRZdqB+rBwBvS45EeWksTe4VSzM2mWHH57qdSBqB5EAzT545VvY5HBnGDPB17OqO5KIA4uZXLdmwYufq0kxjtJsljKtXS3TKoZKeM+mu507epvvmOioZ5WVVUwHtt6q66TXZZKokEYaYoaWc7gCp1qUQ9lYl2IcVjcOYsh1Xj3LXrBUk+ZayR3YNUCMw/G9Ki8CPmm3QZy22W+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW3AmeVwyHICBEp9furUoGPt8mlrY+95Pb0BT4Dw3ms=;
 b=MLh92bRcWDYNFjEqoE2AdABfXox4jVjfzMzlN5nMD6qzZGJUyvGiq4E4Wb4bKbRMKBrUIe+0vKxTNlUC2xG0g3WuBcisp36la3vU4Xelri+AztxO57zdc0Z7GzjievnUpKnF3K0oQ+cXokjIvCu56Y+5x4Urq3SSqo+zd0rhhPXvrZnr+vAlsOXci6/PNGFkzukQcGZUBVYc1orqb6VtAm3eHe4QNHUIP1e3h4ArVaElpAVCunfLXCnikNVFczho9a45I+/UTx57veNO5Z3GI7b+Rd5oi3FUsmsvJDHrLRoTePffG2Ww/SRa3jt28MbQv8mHVa01uipqvA1vnxKwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW3AmeVwyHICBEp9furUoGPt8mlrY+95Pb0BT4Dw3ms=;
 b=k0tD5SnKGKJIrtFMHu/hfZiDpb8pDAUUbkKZA3e1D8RclWMC3pRKZ8rTAcbfcONELGAivYtgMozVH2KazyWDRGm6DpPHz3+H3RpGXo6gAQmLnrX7UPQBQ99DEUQ7uI7PKev1DHapC6Afr/awDV3WAyRxCEkBa3KKBPQtE5njroA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Wed, 3 May
 2023 14:50:27 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57ca:ec64:35da:a5b1%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 14:50:27 +0000
Message-ID: <9d050abc-6ce2-28e1-7b48-358f2a3db437@amd.com>
Date:   Wed, 3 May 2023 09:50:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 0/3] x86/resctrl: Implement rename to help move
 containers' tasks
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, eranian@google.com,
        gupasani@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, skodak@google.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
References: <20230419125015.693566-1-peternewman@google.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230419125015.693566-1-peternewman@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c40ce56-e344-49f5-5573-08db4be5bbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaIBoV8JaVz5v+hdCZgLzE1Lel1IqnTgsOIrtAODk4+ENsHcowKF6I8mpcL1i6f87WerUJXKNy2NgrGBiXaFMclLe7F76tF5/+EenA+eAD4Beqyk8X7r3zAVM06/Y5Obi7lG2bYH47vJcmGBe/FK+rqZ8Tj/AmLa2EqOebIm+PCospFltaeZByoW9i0V33TblrXQ11RvLG0U43SaULweXJFKIGftkw811tPg6XY9vXzhe1ZZweVUeRAGEmTHEL+77hpTORQxScS0GBh2zJ/O9mEzv8wZ4lWEql8i5j0He8eyhP8rMEssmGnHHVYztbZkT1UhCTnRovCLcCBpNx97dFnkVQAvZE7BD8E+wJNdgPo2arT+3J6Mwdq2u5vTx6n8FY1vZesNpq+DImetSp3eXAY6jKe4hrVHHT8f5FBRZFVX7TRltUAgimNU1ZKZDntKfk+linbTOT6QQSG+ikymNQ50tOIBKsoeBQvoMCAsD1Y3/jo3aoAv0epdH6fBVgQF/RTVfYPq9exwa0I09hpH/2sKQs4r1y82ryx3Q3p5s3M60M2Zm3HwVOIS0hNxFnXSMoAZ//rxdeD17dgU//kuCEdcKPjOILNYU9Yolrf3lqW3Ls4+w7lfGcXka6aihtkZA2jVMQ1iht/5E/Mpvj9bYrZVha2JrEwaG0zGqoJZd+5DKlMPWPI8QO/Qrqvxvegm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(4326008)(2906002)(3450700001)(66476007)(66556008)(66946007)(7416002)(31696002)(86362001)(36756003)(2616005)(41300700001)(38100700002)(8676002)(6486002)(83380400001)(316002)(8936002)(6666004)(478600001)(966005)(5660300002)(6506007)(26005)(53546011)(6512007)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG54azFTSDRhN3k2N0krMk1hVU1CUlRacXJBdXpCaFA3a254bGtNZFVlWjdp?=
 =?utf-8?B?RjhsQ0FjRHFudXRkTklPYXZWWDZEcndoZ2VZeWxzMXpFeW9IWHJjM25RYnRH?=
 =?utf-8?B?R3ZnNmhHZFhYNjIwZ0tKTEdXUWNKZXpLQy8vRUo3dkxvUjYrK0dRNXJxaXRp?=
 =?utf-8?B?MSthNjJnb3Q5TEJsVGNBNm5wOW9ydFQ3NVdYS0gwQk1EOXBVVXZjWk1WMVFa?=
 =?utf-8?B?MnVONktBeU9BRytFSW1ma0NjKzJzM1dEdUowYU1qZFJ2TDRCMnlRUUZ1TlRM?=
 =?utf-8?B?bzlZK0hGVnpqdDJxTkNCRnpsdEpLRjNSY2tXOVFoY0I0Q05ZajU4YmxucXlq?=
 =?utf-8?B?YUZRTEo5NTBuWTdlbG96dkxpeWd3VzgvdUJYYmJZYTVIMnZweUtSelptbE5z?=
 =?utf-8?B?amhJNmdtaW5xQ2JQUnMzNnp5NzU1UDBvVWxhZnRRdWVVZGF3NGx4SVhzL3lU?=
 =?utf-8?B?RHBIVGM5bFpJR2sxUnJhS2xOWFphOUhRZURCeFViUUVHcFBvRlZoY0ZUWHEx?=
 =?utf-8?B?QTZpRlVyRkc5MWJOeGtDUml4VTJQRTBka291RHZCTFBvaWVOZHAvcE5sR0kw?=
 =?utf-8?B?M3JjL2ViR0JNQVJIZEdva1ByMy9VNXdWWUNRVlNNaEtZVHpUdEgvdXZqQ0Y3?=
 =?utf-8?B?K2JKMHN0aG45MWY1QnIrZGlQbEJNM1ExZzFnYktYOGxzYTFkY09yOUZ5eWhG?=
 =?utf-8?B?RmNTcHA0RlpKSkdjZ3ZFdnBCNDdiWDZRTGpCNnBPWHVYbHdqd3BYQkUraUl3?=
 =?utf-8?B?RHNIRjRheUVxMkpQZDJRc0dVcjBxODJEVktLQ0JxVk04WXladnVEU0dkZnpZ?=
 =?utf-8?B?Y2VpRmN0cHJBdHRmUTNRK2RZVFFxTnB2L1VpQVl1UTdkQWdlcUE3N3VwdTlj?=
 =?utf-8?B?VmFPa1h2L01ZSmZFaEZyZHFqKzBYU3JjQlRIeDVEczhWMGlGVWRpTHRzU25G?=
 =?utf-8?B?SE40UWNzdi9wRUIvS0oxa1MzMSszdjlOdzZpOU1RbWZoRXFmbnNNUHRua0Vm?=
 =?utf-8?B?ay9VTjFERWQxK01XUTBtTzAyTDZVdENzVUJueGZ6UFBxSmwxZytBbEZacksz?=
 =?utf-8?B?L2tockZ3bmlNU0M4YXQ2Wk5HbVJlbU1wVEluaS93UVZueWp0Z1ZicEs0ME42?=
 =?utf-8?B?c2FpZmtxK1RUTlVYK0ZxcVRmVm5oV2RzdzdKR01rTmQ4L3VKYUp1dUJKSEJC?=
 =?utf-8?B?TTg3dDBiTWtaaWliRXQyMlNOa0tVU1p2dEZDZWQ3Tjl1aG00UnZwZDlXRGpv?=
 =?utf-8?B?T25ybDNXcWRyMDdzRFVxNDRTdEJab1l6dnJUNDlibE8xZ1YyTWRiUWNHMzJN?=
 =?utf-8?B?cEliZkZ2RVBHQlh2ZjBzOXNLNkhlN3hyNkRYS3ZhajRMNVlPbTRycjRDZW52?=
 =?utf-8?B?K29VTXNDYVlzL0R4WGt1bytJY1FlQm1nR283UUFRSTdWdGJ5SVlWZHRnY3ZB?=
 =?utf-8?B?M2U2QXlVeFRuSlBHTjIxa2VjQU9XbXIxZWVSancxckkrZUdLbkVHVXZBKzQ1?=
 =?utf-8?B?QW9uQTAwRXYxbFVyT0dvNGxralZqU3N5SThBcHF2ZHpReXhLTTdrM1Jmdjhn?=
 =?utf-8?B?TkFJZERCMDYxREgzUFBpbWdyZ3JqTlZCcUwxaGw1V0U0UVVLamsrODVuNVJi?=
 =?utf-8?B?RFA2aWRpQXlhY0xLSXBVTVpvNXNtUHNKSFprVjhlMjlKbGkzbVRvUWxzSnJ2?=
 =?utf-8?B?WEtDbE92aG04czFRTDFZS3RuVXFnd2o2bExlS09KN3E3N2I2MzNDZVROS3FC?=
 =?utf-8?B?NEhGQUdjT1Z0REtaV0dUeUJlQ0E2ZVRSbkVNK3NqSjBUZjJMd0FqNEdPYk9a?=
 =?utf-8?B?ejZhQWdoT0xQbVc1SGFiQkZHamVwWm1QUTlxdC9zWUZCRFNnTEI2QXpSQTc1?=
 =?utf-8?B?bVBESFBCcUlhQWszZFhjRHRXY3VMbHZ0UTdQd2dHT3FYTG1uTnRUQnVQREFs?=
 =?utf-8?B?V2JwMGQ0cytHVjVLUWlpSzJLRDBFM3JvR2lhRWNzc1RvbTYrYWZtUVRlQnor?=
 =?utf-8?B?ZlcrWXpYS0w5T3RsNzZBWFFXT2ZJYW9MdnJWZkxmbmxWNTFzbnJVdVY5SGZi?=
 =?utf-8?B?RlNsaGtEd0VpMkx1Sm1FUWd6OEVxVzlJZGZub29ORS9sSjF0YlJMV1QrMDJU?=
 =?utf-8?Q?xEDE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c40ce56-e344-49f5-5573-08db4be5bbee
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 14:50:27.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5Lko3usvdRG+fi9LQLvFwH1ChovYxcUuz91BFFrF9D+NfYe6/lbCMyLk8Uj4syF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested the series. Looks good.

Tested-by: Babu Moger <babu.moger@amd.com>

On 4/19/23 07:50, Peter Newman wrote:
> Hi Reinette, Fenghua,
> 
> This patch series implements the solution Reinette suggested in the
> earlier RFD thread[1] for the problem of moving a container's tasks to a
> different control group on systems that don't provide enough CLOSIDs to
> give every container its own control group.
> 
> This patch series assumes that a MON group's CLOSID can simply be
> changed to that of a new parent CTRL_MON group. This is allowed on Intel
> and AMD, but not MPAM implementations. While we (Google) only foresee
> needing this functionality on Intel and AMD systems, this series should
> hopefully be a good starting point for supporting MPAM.
> 
> Thanks!
> -Peter
> 
> Updates:
> 
> v6:
>  - rebase to v6.3-rc7
>  - clarify changelog wording
>  - clarify error message for non-directory move
>  - remove unneeded parenthesis for checkpatch.pl --strict
>  - add Reviewed-By's from Reinette
> 
> v5:
>  - rebase to v6.3-rc4
>  - dropped rdt_move_group_tasks() task filter patch
>  - code/comment clarifications and errno updates requested by Reinette
>  - added Documentation patch
> 
> v4:
>  - rebase to v6.2
>  - commit message updates suggested by Reinette
>  - replace rdt_move_one_task() patch with rdt_move_group_tasks() filter
>    function patch
>  - prevent rename on files or renaming to "mon_groups"
>  - optimize simple rename case
>  - disallow renaming groups with non-empty cpumask
>  - ensure source is a proper MON group directory
>  - fix missing rdtgrp->closid update
>  - add more last_command_status output
> 
> v3: use revised task CLOSID/RMID update IPI sync method from [3]
> v2: reworded change logs based on what I've learned from review comments
>     in another patch series[2]
> 
> [v1] https://lore.kernel.org/lkml/20221115154515.952783-1-peternewman@google.com/
> [v2] https://lore.kernel.org/lkml/20221129120149.1035444-1-peternewman@google.com/
> [v3] https://lore.kernel.org/lkml/20230125101334.1069060-1-peternewman@google.com/
> [v4] https://lore.kernel.org/lkml/20230308131452.383914-1-peternewman@google.com/
> [v5] https://lore.kernel.org/lkml/20230330135558.1019658-1-peternewman@google.com/
> 
> [1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
> [2] https://lore.kernel.org/lkml/54e50a9b-268f-2020-f54c-d38312489e2f@intel.com/
> [3] https://lore.kernel.org/lkml/20221220161123.432120-1-peternewman@google.com/
> 
> Peter Newman (3):
>   x86/resctrl: Factor rdtgroup lock for multi-file ops
>   x86/resctrl: Implement rename op for mon groups
>   Documentation/x86: Documentation for MON group move feature
> 
>  Documentation/x86/resctrl.rst          |   7 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 163 +++++++++++++++++++++++--
>  2 files changed, 157 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026

-- 
Thanks
Babu Moger
