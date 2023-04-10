Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B207A6DCAD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDJSeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:34:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EA1BE8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbg5/U9o3BVBq+fvjHLtDU+oRWD4x9e2p/wS8M5FPo6S2xxnVVY1YpnX3nC09V0jvki6hhbOH/qw/JmBEjixpUKtqf/nW1/USgkRs/XfzDhNtu7MEYUtZU1vc2+hU/Yowz0HF7HuwF37mwDmazms5n4SBa/2M2q4OoP+uwwqE9leE3M+9P4mW2U060atdodz4e/QZL/Wvk15vIn8zBu4FXeR96awRRMTVCiBSaBBtv7IoZzcfyoogQ34PTlkHhUnevNroKZXtwEOYYdBzf0JHCElslz7b0ajOmR+21QQc6O+TqDxaXnbVzkLKTEzf5dysy6PlReOWxKVO7ffCcqeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+001uIEIJNmW1sTGlXFcyPLvTltDRqvrPhGo/eww20=;
 b=iZUH0aBQnE2zdi4X6O6MU8w/9w0VB+8TCtIRhQCHZ9uEOgiZD/+CyL60o0K6tPjze+K3bOkP7kMdXVSCscSzQ/Y8aMpsBBdAuyIfL2TgTj2NqbklJqoqfNvtrbJ3lh5ldEIjNOihZ+fyIaX1AV7zWYinKZjpTaa3BzBhH1D+KFuTFYDVi9yLBLoZwjyiZkzXSK/6kcyjO/vtJXn0EceJx4U7SgbTrS60mZX/CRQc9TSn1D+IwXIRkdoLSjyMkxvLT6NE/6rS4zWEHtIH9NWc37dMOGz8VI6nRHFi6DAewCEbRVb6CoLtHIcOiBghLUy5AJ7yL4kU9ZOTDSQ9tsxPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+001uIEIJNmW1sTGlXFcyPLvTltDRqvrPhGo/eww20=;
 b=WLklyB9+KQlPFo3r1V5Hfbqma5esVaTlqtr6tsmvjl64lE3Cen4gluQ2hKQDdcPUkwHd/hyt+JkKuiaA53d9y8MjeL+N9p5XkA7eVEr4xSGLTykF0oS5tGen/z064iNIn0CGvZ7ywKonnVDTok1FfWwHvw3MiAV7tzReTfEzyVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7904.namprd12.prod.outlook.com (2603:10b6:806:320::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Mon, 10 Apr
 2023 18:34:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 18:34:03 +0000
Message-ID: <4e551210-f4b1-406a-5b1e-e10d6003d452@amd.com>
Date:   Mon, 10 Apr 2023 13:34:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Subject: [PATCH v4] ASoC: amd: Add Dell G15 5525 to quirks
To:     Cem Kaya <cemkaya.boun@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
References: <31D1DA75-51AE-4868-B959-F0BB53DBA658@getmailspring.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <31D1DA75-51AE-4868-B959-F0BB53DBA658@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: b678152a-1b47-4a94-aef2-08db39f228ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptGVdFHslzpfH9/5xAXIgLqHpO4Ix3fImQDU0bEHtymWHYWUIfGkEM1WNe0SChEz1X3ewiDBxdvz295hNiwHlltYNc/wPpd8wSKe6neWWR/pRyRpM6WGBA6M9qcXQJrZVLNsRp7QG50SiCNAx2e+adiXN6aVDM1qHpHyVNiCaHLlwaweGiCw8AoyVe059QZxO/H7WROzw66RLKKiqhcpDAFwGnRuzo9r9Dh6QdAz08QnoldvPa95Eak84uVVF229QbGWsuidMfDjwDfbwiqvY97FD391cApeh17hX0Xj1ACigBSWrxrwJgHqouzKV6vpV/Y+upwHzA5ELEuA809Ttw7EHIvoZfthpCztqRu4qNDhcXExyqtKVcFle9hHukiexwAuFO90mq5hQfO4w1zzhtTSp1fMGktOrxlny52mQL+nlLuOa7AtwmvTXdnbLKAvsGnxAmYLd9c0oTNl+R8/D5Hd3L5hSqW4ZtGgZSHv0amWtZaGpOdhdtH2BeNwYAKXMisEQECQ7x5W5M8WtgXmkqMX4WSZtRa5ipXEwiDCH3vLtK4NfgvKvA+KIBwFBgexwYpLJ/0GHnUpO36vJQP785ublq7MoWoSzzFcn658o6GyKg1MFVtJZNU7d1/MRs6GWjr9feHvaZZsD+UnndRW8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(478600001)(316002)(110136005)(6506007)(53546011)(6512007)(26005)(186003)(54906003)(966005)(6486002)(2906002)(66946007)(4326008)(66556008)(8936002)(66476007)(8676002)(41300700001)(5660300002)(38100700002)(86362001)(31696002)(36756003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHBKa01sWms2TFZOS2lXNVVjWnhFSUpxUCt1aGlGNENMcjVWdWN6RitiNmM3?=
 =?utf-8?B?R0hHZEpoNFVSaWoySGozcHlqMytrcDh6VGxYSlBNQktiSDlWTUpsWVY3dFEx?=
 =?utf-8?B?WFAzbmFoMFR1WG4wb0FnWXNxY29ZQ1NlczJYSzY1b0w2eUVxOStnSmROYWxT?=
 =?utf-8?B?R0RuTi9XSGVlVGR4Vk1OajNCTkZKQnZpbDF4bEJvbFlsSmRZQWtsUmRrZE1m?=
 =?utf-8?B?NnRqNzQxbnorSUpURjNPUWpockVESGp2cklRVDhYdTAvajdtUUdsMGNNSWcx?=
 =?utf-8?B?bDlkYVc2d0RVVlpQMUZvM2ovSUVEUWY2NjJ6MjZrVU9HaHBYUkVTcFdRTk45?=
 =?utf-8?B?WkhmeXQ4Rno4V0NMZlhnTnVNcXJCY2VkNHBnbmVyZGNTSTV2Q2ZvWmRmR3BK?=
 =?utf-8?B?REFNclVmRG5MQ2JxM3Y4VTE3WE1SNGptb0VjaFdTRVNHUGZFNHpLQjl0RnVS?=
 =?utf-8?B?V0lBQUV4WFp0ZUhLeHFkOGkxMmpSR2M4UEZBZ2dYN3RRZngwUTdENFl5UWNK?=
 =?utf-8?B?T0I2b3NXQjc1b29GYTNtVEk3c3VyR3lzYW1HV2xsUjY5aDFmRGZiYXQ0ZXN6?=
 =?utf-8?B?b3RkZDNYUllyY1RVazEramNkSjFnbHV4Wk5zU21tZDFRN25wQjNFdkZ5bHBV?=
 =?utf-8?B?VUhaV0NOSHM1Mi93Umx2OS9WanY5ZkxUdlF1Q2ttZDMxbnJEQjExNENLemhP?=
 =?utf-8?B?SUJFbXJQMDdYQ0lUQ08wODFtN3doMVV0OE1YN1lKMk1UbS9xZStLRWNDK0x1?=
 =?utf-8?B?QmpobTFvU3UvMzZZYlo4YXVUNDFhd1JBdVhwc0dpcmZvM1NlTDc1K0ZNOGdn?=
 =?utf-8?B?RXg4OWNhNTdVOWtCaUtidkt6WHUwTkZ6dWNSdStDWWN3UXRHK1FyMGwxSk9v?=
 =?utf-8?B?VWxFWmd2RkUvbFVNMENlL1AxSm53SkV5d3hLVUJuQVRJbDVxVVBsOWl4TzVX?=
 =?utf-8?B?OENFMy9laVFzV2dEdnZPdDBKS1gxT29LVGt0RWVIRzNNUXBuS1ovV2Nhenl3?=
 =?utf-8?B?d0FoZzE4MEIyMmx1T2k2YzVvQzVXdml6UVNvS055dHZNWFhmcUtUczJVVHRM?=
 =?utf-8?B?VytWQUZ2dWpkYlpZRTRGV2RQYTNmVEJpV09TY1JLMG9LcG5LNEowTDExNFVJ?=
 =?utf-8?B?eVRWRnRpWWRxSFJXb1B1aENPYjl5ZDh4WVJVZ3FwdFFFSk8vRjhhYXJuM1Qr?=
 =?utf-8?B?VlRSeUk1djJaSUs0SHZqaUpRNHBUa1E5aDVndDZWQzVVZDZDWVdvcUpIKzV4?=
 =?utf-8?B?VzZ5MkwyS01BVVFRNXRBT3JueU9PeU5OTGFtVUJXcE9abXFyU1dibmlnS3d2?=
 =?utf-8?B?UzEwbjhxZGU4OTV6aHpoM1hHMEp0S2ZSbGRCVmdDSndITXc3aHZlWFQ5OXZz?=
 =?utf-8?B?RGV4N0pUKys1QS9PRDFOd0JjeHFsV0VhazZTK3NRRmEyZEcydXNKbXFWVHBP?=
 =?utf-8?B?WGpzTFFLV3VtTm11aHAzNlFWdGJ6UVZjU1VLSjhwUlM0NDYwWTU1MW01elZR?=
 =?utf-8?B?aFR3dklKSitMOHZyL3ZuKzBxLzVINUJuVkJONlJYQWNDK2lra1djRTQ4SHlt?=
 =?utf-8?B?aGg5YjUvL2J0MHMzUlo0OXZuN2p0N1dnN2haR2JSSFd3WG9hczJRR3NQOFpl?=
 =?utf-8?B?RFZyNlM5WFVyQmJpSmVuNnJ4YlozSVpZVlZmYk1GdjFGd1ZSK2RVVTAvRUp4?=
 =?utf-8?B?c0RsVkpoVnNDOFJENTdGTDNBSzUzOVMwd0lUS2tUNEJqbHRXWC9CQVhqckhu?=
 =?utf-8?B?Vm1SRU9EQmptQ0NReVpYNkVXOXhDK2MxL1JaWVp6c3lOUlh1bno0NThJeGhj?=
 =?utf-8?B?QVhOZ2l3V0ZQSGlHOGpCWHdNTFBJb2c4dVdZbDk0UGs2VzlGTEFBbXpBYlQy?=
 =?utf-8?B?eWw1aTdyMU1VMUNEbU8xOHNNRXU5UFBVVUJZNDRZaVFtTjM0cHZPb1MwVHlz?=
 =?utf-8?B?TnphaWNPNHFJdWFFVDlBSHozcFJXSExCbXg2ME82eGZvZ0VTZDhzd0ZZUzJN?=
 =?utf-8?B?d21hSzlDdC9tZis5dWlsYlNoeTE4ZXZEQW1SbFVmMVUyaytrd3RwNHRIQzl3?=
 =?utf-8?B?S3lyREZBUnkvTk5ydWwrcUFjdDd3ZStiYjZMWWt5T3hJTko4cFYvUkx4Tm1K?=
 =?utf-8?Q?Hvz7GVw3sYnqkO58lk4g74Vwz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b678152a-1b47-4a94-aef2-08db39f228ab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:34:03.3028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUM90qT7rDG2uXha1atJKBAzcWbjLfTLZ8m2aQAo9MidDgUdCzwXWfciXBE6Iq/yWSzhKfxpQJA++x4JZK9p2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7904
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2023 13:21, Cem Kaya wrote:
>  From 20fa2a4fbb58eb775c0d4865c3cfcecd6a94ef18 Mon Sep 17 00:00:00 2001
> From: Cem Kaya <cemkaya.boun@gmail.com>
> Date: Mon, 10 Apr 2023 19:43:56 +0200
> Subject: [PATCH v4] ASoC: amd: Add Dell G15 5525 to quirks list
> 
> Add Dell G15 5525 Ryzen Edition to quirks list for acp6x so that
> internal mic works.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217155
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Cem Kaya <cemkaya.boun@gmail.com>
> ---
>   sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index a428e17f0325..e044d811496e 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
>   };
> 
>   static const struct dmi_system_id yc_acp_quirk_table[] = {
> + {
> + .driver_data = &acp6x_card,
> + .matches = {
> + DMI_MATCH(DMI_BOARD_VENDOR, "Dell Inc."),
> + DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5525"),
> + }
> + },
>    {
>    .driver_data = &acp6x_card,
>    .matches = {
> --
> 2.40.0
> 
> 

It seems like this is getting pasted inline by your mail client and mangled.

Can you perhaps send using 'git send-email'?

