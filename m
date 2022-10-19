Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4F603978
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJSGBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJSGBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:01:09 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7485BC3F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DN97qrz5GrDMIJ9QL8RW7vjHmncocjIvtPbhAU/npSQ/SrNGqGaZ5y7mrZq2qiK5ksR3ovyzzih91MvmMcsy6Slmgg9hHL0K61eXEieADUvxBiJd0kbifpl399gOiYLZ3hy81U8vUPYyrn2LXztya7QKFvyTI20rAtVYR3ULi4uQb9ri1mXkvZ9sWVWJFPjsGguSQj98eXjpafYcKwggbCHr8Ww9rb6iBvLY6YCbLFkOFu0hyPX15Ak7PPqneRgkdxJYNYmQoc5AFaXXeTZXzkR1w513oMgfAK528buODnwFaX3PohmW95IClyvZ37ZfaebYAvmEPBKlRoGE+pOHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24JQvyR0NkcSTtKxb/3NqQ+dQJN4/Oeh8UHbHFPehqw=;
 b=La9GRQPWIJzjuuEiur7uq0aR+/znbBYDnOWgbgh0naRmDx576kM6kevjSK6YMAtthv8dVTjuzdTlaHG3HNjYSg8/LtAb4Lq/8o0PXH28cQGeYhEMlmbRyydMadITfzFagSeJpGc96bgaQ2kmxt9Y2vvpBJdEx+d9FCkgD8BEG6JIGN6kVjUpC8gLUUI/1f3W6IYn0jIGI1fDM9m+0e+12pi3r5zJ2QPdYoax6HoJr8Mw9eI/iAFGo/DrCsTNlCxR4OHf4Dbpixh2Oj5LyS4PFLeLeNm8YL1V22U+JBiP3O0KgFMPf97FRLhr8qlYmVqUX8EyFwJmTLzW8mS7jta9TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24JQvyR0NkcSTtKxb/3NqQ+dQJN4/Oeh8UHbHFPehqw=;
 b=Iv3sMP+Kz7CILgjFnVwCf32DJs+cSBywuyUYvTgyW73M/wDmF6hRDqvOGh3x7jXP5xZvmpuxyEJrxDAk3TYm+kEDvXtI9RAT3I2ZpumCUktEdSa9m1OW55CEHdB6YmnCwFIJQzKMvOQoaKDOSuSHKVauDXIpvQjm+sz5CTOPYfx1ro8rwunvwbPEeuTsAYfEEGMQLmCZP5UT9flMsmPsCjKVqBMvgdbbS+y0iT1BPIiTQ7MHPYS3kJs444eMELZErvByqo7mqbUlmdvTu6afR8WXMNmJLl+k9NIO0RhpzNCpfZRqHoF66V9DIRGL99ZW7C1vNe/TGQoOzz2N5YT4PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 06:01:01 +0000
Received: from CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::c4c5:ded7:55d1:dad5]) by CY4PR12MB1576.namprd12.prod.outlook.com
 ([fe80::c4c5:ded7:55d1:dad5%9]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 06:01:01 +0000
Message-ID: <90f43267-0a8a-4928-54b7-47b4ab0c55bd@nvidia.com>
Date:   Wed, 19 Oct 2022 11:30:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] ASoC: simple-card: Fix up checks for HW param fixups
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221019012302.633830-1-aidanmacdonald.0x0@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
In-Reply-To: <20221019012302.633830-1-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::16) To CY4PR12MB1576.namprd12.prod.outlook.com
 (2603:10b6:910:10::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR12MB1576:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac7b2a2-784c-49f1-1065-08dab1974c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auqifiQNZRFyesFY9PjDyJG2B4OOqR209aprlKVXKzNoeRpKGQ23bEM0lrflfVyLiuz8+OHo0XsOrDkhl+99NkE9zqBA+Ywd2lyiUy4UIaHFAHI/O07BqIUwKMbVQxBNlPdEl35/Qqj6+ElrqY59cOFjogdHi1ZYIJrDa2wbjs9pIK+F09DFH8mk0L/YWiT76s/AbCsfGlpc6zgZhpUDnNjLADBiRrsXK23AVtEe1uUineXfTc/Gj7jXoikDmGoGVpags/wNSpRPRxfTYe4kaNI0MgdcpK4gSBinj2LIfAxPhJ0BrEduYr2mmiHf/PMbghnZks+WGGoa0nz7fjpKH1WZPT8jdTATvZfsXEQk9KIOoA6vTnDYQmNMmqOdYknekBT+wPdbMWFRnGtFxbYAjgkh+EW3K2eaOJazaNY+JbVhPuujtLH4HlQ6rA4z7Wstjn6wsUfzSNnTr6PT9rThez5E4NrcZYv6DBgBR3Do33DVDKQhzbmZPbics/0wL6nSvT7aCjySsMIVJiF+nVewlz9VQ8/XCOHRJ+p5jQhJE2HpWpbtXfMdos5RXmqu4fdXia3HlY2o42WVOa8rSfHtrkXfZOALog2kSUnxoEVHysvSPNovb4/Zcg8wfHxe06tNiLkEI6pVUVUWyfw2pfOIfynSCu4h7zrCPPAlYT91zbdvNE9U4hK+b2wmOAd/hiDG9Hg3Ji9O99sKAyeTSmFK220HZCrtccQ+/v9xuJNUEtQl2ncaYEzXp6mY0OY5Z5dgzYxResJEixE3gFxV/2EZqG/8HNNVxehkgylXTdtTautSXyr4sfwun1Bla+zJZHco
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1576.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(31686004)(6486002)(478600001)(38100700002)(8936002)(6512007)(83380400001)(316002)(31696002)(53546011)(41300700001)(26005)(186003)(6506007)(36756003)(4326008)(6666004)(2616005)(2906002)(5660300002)(66476007)(66556008)(66946007)(8676002)(86362001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2IxVGVvekhNdjIwRXlIRTllcGgrdmlPSFRzU1N5dmhNNDhRdWxIREJCdUJD?=
 =?utf-8?B?VnlzTU9Wc2dES1d1eFhIRDR6RVlaMlFUK2lVWUJGUTUvSjFGTTZCR1JBTVZQ?=
 =?utf-8?B?d2NkZnFkQTdLM2hXdGkyQzB2cW91TmJmNitRZy9udWFYOUNLMXBTNHpKcU1J?=
 =?utf-8?B?L05ySFVJcnNCdDdpS0hJUWUzbXhnSmNidWtmd0VyditxU0xJbzR1MVI1ckJJ?=
 =?utf-8?B?b3VXdFZoSlVsNXUyUVcvVlJZd0NZZDQ3eEZyaytqb2FLSEc3aU9MSlYxN0NK?=
 =?utf-8?B?b3V2VG5WZzM4ZEsvb2c4WFNOMUF3MUlKMjc5M2l0ZjZLb3orZ2IreGI4RjlU?=
 =?utf-8?B?bmZRbGswdFNrU0tLbGcvTmlaRXJSRnY2WFFOREVJR2hyOVlFSm5rRE02dEFD?=
 =?utf-8?B?bTRpY2IzaWRhb0FlaEdjZTd6aDFiV3FQcWpZM1lRaFB5NDlKdnBDUklLMHRB?=
 =?utf-8?B?LzNheUl4MmVaOEExVlVUOUs0VlJTMlMrWCtmSjR2Z2Vlc1VFY2JGMHozd0d1?=
 =?utf-8?B?YVVIUk1henc1cnpBVTQ1UXhiWEYydXVNRXdtUjJpS3FSNDF4VnlBakN6RDFp?=
 =?utf-8?B?c1FrZ1g2OFRuK09qSEVWRGpqcU9QamNPeFlmbHNSVnRnRlAxUGNsU2ZyTkhx?=
 =?utf-8?B?WVN3NS9KWFJjZ1NFMEFad2kyZHVhcTI4TC9zMXM2VDJmb1ppWUFNRGdFdXFa?=
 =?utf-8?B?OWNoRzg0eHBLUEJIWUJVeVpzendkc1ExbnZNRVhlOHE4Z09IN3dEWmFjZ3I2?=
 =?utf-8?B?S1NzcGhtSjJ1c2JxRWxvMXAyaHBxc3R0QTBYbnVqUGFUNi82VXIvUWl4UWdH?=
 =?utf-8?B?UkZNRzBTSWdWRzhVY28vQmxVUlQ2SGpaUERqUFl1M2lUeDBxVWlreVNZZ1E5?=
 =?utf-8?B?VTdZM2U1ZnNzL09jdDJKQ0xGUmF6bWVWUXorZkJJZ0F1dFBGaXJqMml4U0h3?=
 =?utf-8?B?eTRxT3Zob0xTbC81QVBFVCtqYWlVTndSM1ZQMnB2ZG9yeUR1amI2SkhrM3pD?=
 =?utf-8?B?ZmdlS2V1QXdzR0M1TUFieUo5NEdoRnl0MGNydTBhUThOaXNCMVBXRnFjV1o3?=
 =?utf-8?B?aHl6SHc5R0loM0RTcXIvbjByczdEQWxSalBGNGY2aFFzSHZJbEhlYUsydTlw?=
 =?utf-8?B?ODdnR0YvanhFVisxNGRoS0xrdk54blRGckxDSEVjazlITzNPdGF3V2hRZEM0?=
 =?utf-8?B?R0krVGlmb2FoaXh0c2xjUURhYVpFRmYrU0xzdG5GSzZXdmZVZjNRUjJaTmtq?=
 =?utf-8?B?ZHcxdVVGWFJ4SlQ0bm9BbDJTYi9oNXhlYXRpSzRtcHZMRTdsTnNqSUtSSzJJ?=
 =?utf-8?B?cllqdEhubXRZQUVTQTJXL2ZybEYzRFI2aFZkTVYxdWM1RFU3cVliYmhkdUR4?=
 =?utf-8?B?Mm5tNEJrbFBtMUFIZVdtNHlIaFIzZUx4Unhwd2MveDlzbUhybTJZemxFdnNU?=
 =?utf-8?B?UE42U1N5NzJjUWRwY2xRRGlvSnJyamZwYitmajV0Mk1JNEh5cUlvdzVseWVD?=
 =?utf-8?B?M2FmYXJzc1Vuc2pSaXpna2JzdFlodGVzVkhUWkRDL3hxZUFWcG1FNk8wZ01o?=
 =?utf-8?B?cFRFUDk2MFRZUE43dkZqNktVWUk0TVlxNXBaRHhMa2xJRWFIU081MzNDeUtW?=
 =?utf-8?B?UVlPTWEva0F5cDVJdDhEUDhHM2ZLZmFDbklIS2ZGajJodko2T29UT0dmaldz?=
 =?utf-8?B?YzM1Z1F6cWNlVXl4V0YwUmVKdkRENmIyNTR0Ty82dExFNTI4Q0NOOC9XM0F3?=
 =?utf-8?B?cDVhNEdDNWQyMGFvZXRlNS9zNkJvWG1CZWZhc1dFT3JZTFVxWXNManlQaVIy?=
 =?utf-8?B?dllyUXJiYlNKUXVUb0VmeXBOM2FKUWM2em0xUWpPUEhHZUxQSmdlOVl5VmMy?=
 =?utf-8?B?UXprMlNjMkhzS3hteXpMOUduNWF4c2hwRWxSNVhMWXBKK3oyZlZIUE02di9k?=
 =?utf-8?B?QlFHTVpKYmw0eHU4MFRCVDBTaUMrbmpGVXJnblZSTVdDQnlsZzgyS0JXMlUy?=
 =?utf-8?B?VXpoL2E0V1pjRng3TkpZZzNUNUtGTk4vcFZIT1lER1d0VmRUSksyVE9HM2h1?=
 =?utf-8?B?YkFJWk1oREVuSmNIS09UWE1lNlRYU21WTGpIUUhzb3dpbjdFNFpNYWRRenY4?=
 =?utf-8?Q?Ol0vkdS7yz9xj2i/2DDtc5lLt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac7b2a2-784c-49f1-1065-08dab1974c7f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1576.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 06:01:01.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MJ4TwRny8q8CYaaHI+ttRZ2glMH3eMJZOlbitPP/tR/VXAJoYjQxI/IHzJ1j88PN1EsM4IiBvOuVjyUTKNWtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19-10-2022 06:53, Aidan MacDonald wrote:
> The "convert-xxx" properties only have an effect for DPCM DAI links.
> A DAI link is only created as DPCM if the device tree requires it;
> part of this involves checking for the use of "convert-xxx" properties.
>
> When the convert-sample-format property was added, the checks got out
> of sync. A DAI link that specified only convert-sample-format but did
> not pass any of the other DPCM checks would not go into DPCM mode and
> the convert-sample-format property would be silently ignored.
>
> Fix this by adding a function to do the "convert-xxx" property checks,
> instead of open-coding it in simple-card and audio-graph-card. And add
> "convert-sample-format" to the check function so that DAI links using
> it will be initialized correctly.
>
> Fixes: 047a05366f4b ("ASoC: simple-card-utils: Fixup DAI sample format")
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> v2: Rename helper function to asoc_simple_is_convert_required() as
>      suggested by Kuninori Morimoto.
>
>   include/sound/simple_card_utils.h     |  1 +
>   sound/soc/generic/audio-graph-card.c  |  2 +-
>   sound/soc/generic/simple-card-utils.c | 15 +++++++++++++++
>   sound/soc/generic/simple-card.c       |  3 +--
>   4 files changed, 18 insertions(+), 3 deletions(-)

Acked-by: Sameer Pujar <spujar@nvidia.com>

