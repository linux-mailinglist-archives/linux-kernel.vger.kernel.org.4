Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23B473B8E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjFWNkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWNkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:40:22 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768D2685
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 06:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alPMIL+0qgEF6wJDAaQnMALE8S1DqSaR9uOibLgxmHuBfIhQ0popENnbNM9fDWMfDoTVcHhsa2Mv8Dbyp0jhmIuti5x/Q280DCfcJjvPwIrNDmHhkbg7iG6LD03HkVZ0zLWN0T1m3jACDVOC6yrS7HdINmelvdaVEFdBR24mNtL2TkkdptRh4TV4h7rh31KAemoyGm1RgnAJ2WfRlMHrinqvWHDi7fLATB4zh2ltvgVdbTNlVXHV2zKKkUEIkiuZ3D3uMF+7R2so+ftvmSsttnUGvmv95ehSulNtFLPDEeQrFnhK2MufcLGOuNpe/LVOSst+a2oQD78mmY8Y6B2MSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ha4Vy+UE7hX1nQASwPPCcTaTrYqVB0VioY8uA69QzX8=;
 b=JFjBo/2aQJa5bOoJO4tc9hK2HqAJYfB6GD7Pa43uqcOYzCkQwEYg8nJaPAEU9D43NkFTec/eF/wAfDRcPl1ZOX9OHS8CqlvGWxdkI/PvrkzYBV5PBJ9ERRTigqKQ1aPeam387pVa22nM8MeJ+y2qJ7JahKULB5K3GrzMmiBkaa2yuEKxVBZbvbKvtCAmdAkzORVHTdJlPumfSZgxTcjkpKEs/TqJUdjaxPTfnKV3vMs2CxTrwgmfnXFVq67i5fAR+qgyf4XI7HNQW9MqOe6Ke/ZpZ3O2jkLig5eBzaU4t3zjAED3JfZTjmHvW34lk/2Tp/1nVJ7yIsFEjpUqwRbv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ha4Vy+UE7hX1nQASwPPCcTaTrYqVB0VioY8uA69QzX8=;
 b=zng2S16gjHYdFVqhIW8AibaFHfeVr8JOW/EFIlLchZXc9zBdG0SM0rAttaod3UHVrD29NeaXxwRCENMA6swKWG+aGHnqFXr2J/arEY6V+xoS5q30OX1A88ZMSmW7cVBJhN+dJ+sKfnrZyvX3AxHBByoc7IzJvmXLjDwaX90f61A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 13:40:17 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 13:40:17 +0000
Message-ID: <80e86035-f6e5-3059-6cf9-7f6cd93fa2ee@amd.com>
Date:   Fri, 23 Jun 2023 08:40:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] ASoC: amd: update pm_runtime enable sequence
To:     Arun Gopal Kondaveeti <arungopal.kondaveeti@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        sunil-kumar.dommati@amd.com, venkataprasad.potturu@amd.com,
        syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230623214150.4058721-1-arungopal.kondaveeti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: b883f3e5-b4ad-4010-02f1-08db73ef616f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPAUK9iSsY3vV6AEVcoXR3/RXtaxtBn7iXaD9cKVHssx/XdHbdDEOTzhgwIY9gtmnjtfw5KMBr6EmpgV/crO1S1ZefSSohzveaaKShfnpmpljlMaXIyupVb1setAJkT9XugFlPpYYsfFzne/NyfQjaymlUliKUPEC9uNr0twfYbnlMQNF6x2sOjyGnlr3rlIM7GAH3AEtSBiiq1iS0VFYfDkaywflQBmZzkxEqoycXg3ufZXkdzdH9T57Cg4rwBGiP+uXqTSNasHvBWDTWQWzvtilLq5rxrUhq4gWl+8wCFKdrwxgqSAMYspZ9qEtGBRIPAY5tbWL5W+ekWooRNsZ/AQVRYYp+M1HTYLZD4E1VMvIr7svb1wGVv+X+bxGf6ZDAAbk8Mik2/NahQDOHkgecW3+JJRoaXNbpoaWZ7sQbYSTIfjA9+UJKE7mk4nXKDax3c8iPtUJ8CI+9aJvOBbTWB7+Ah5og6tg2n3PAYMspwmGchTuUOWvzWbPMLQBBfil8NXEt/aGvAQcFWu4JqlRS+czWZUAq5Gmgg35wirTrJI5Me3C41P5SWizqDkqMxylqEQ/c8cA0Z/LXYVgjM/t9gbvIcLzGEglMvE5ZHSBI60O5oDltNjdEmqa1B2r0/9G1HZZ5ozGe8uo1AT1ud2Sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(54906003)(6486002)(478600001)(66946007)(186003)(6512007)(8936002)(4326008)(5660300002)(66556008)(8676002)(66476007)(316002)(41300700001)(6506007)(38100700002)(53546011)(36756003)(86362001)(31696002)(83380400001)(2616005)(15650500001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vkh6TkY3YnMxNHd5bno2ZlRyeGJRWnp6WjU4VER4SEpndkIwMGEvQmNyeDBa?=
 =?utf-8?B?aEMrUHQrcDdicnFDSnd3VTlVeFdPQlkzUGJBRWFHNVIwVUFMZnhyZ1k0b1Z6?=
 =?utf-8?B?YTlGS1d0MUpIdXA4MklMMnVVa2lOUzNYRkt1SlhDeUlqbVo4SHp2RTlIcjR2?=
 =?utf-8?B?dCtDQmlqUml1N0ErWGxHLzgwbng1d01nK25La3lnNVBleXkxa3ROT3k2bHp2?=
 =?utf-8?B?eVd5TUZaa0EvWFZQQTBmY3hUL3pnSDFnTEFld0RxVVk2TFpVZTNDb250YkZG?=
 =?utf-8?B?dHdnbUZNU1hJY3IvR1FDVUtyYW1mSTNlNytzTlUyZkR6cVBHNzFYZ3FRcjdq?=
 =?utf-8?B?dlNValhaMnBldy9PVnV1NEQ0SWlTdHdjZ3FPajNaTGVKTDhRMUF2TlYwbStV?=
 =?utf-8?B?SVF4c2FHRmE4TW9DMk5PUVlMbnpDSHl3TVpmeTU2U2puUTllcE9OSXVEY1JE?=
 =?utf-8?B?Z2FSTm5hRjVIMytaMnFBMC83RjVLejQ4ZnJqcUU1K3pSVk14dWtEd1Fud2lG?=
 =?utf-8?B?L1dmSk5iMnNFMkR6T3hKTW1BbkErK3I0LzdaMWJGMy8xQlJ0Y1JvZzJGdEZh?=
 =?utf-8?B?UzU5bEVwY2lkcEJxbVRzWWliRUtUaVIrRHNMMEdOdGlyVmtFMmxPdmw3NkNw?=
 =?utf-8?B?RnhJTmQxcGM2U3JHWVFST05VSEtHcmg2ZEMyb0VkRmZQTk1IWVVvYnlITGNt?=
 =?utf-8?B?Q0tUaW9LOU83RGlOM3JkTzdaZEp0NGg5RC9nYUkzcWR3OHVIT3BuRFQ2bEtT?=
 =?utf-8?B?OHFJOUZvZTBISUZWbDlDZGNPajdTYXlXQWpBdy9pMHFYa3BUMTVqNllmZjVp?=
 =?utf-8?B?UnFoNnlsbmFsY3hyZ1JnOER3SE1NeVpqQ1NXRlM4T256c2poSFhTaERLU2FQ?=
 =?utf-8?B?a3pLTkQ0TkFyMStLZGdpUzJUYS9STHVoVjVPaS9wUE1ydlFDZS9VWnZvM0Ri?=
 =?utf-8?B?RG9CMW8rdTJNRS9acXVjWmRHMnl5SDJGNTREUU03aVhMY09WZDd6eVRZUk1t?=
 =?utf-8?B?S3FseXVZQnN2djN0RUE0MzhJT3g4Smp2U3VoS1NqVTdDWVRnT0F5ZFA3U01K?=
 =?utf-8?B?Qk1FaVF0OWJTUXNJTGtJekFGaTgvQ2c0bFFOQTYrbnJtU0hLY25waHdmTXVr?=
 =?utf-8?B?eTVNRXk3a0tKaDlXS09rakM1VWYyU3JoQjhlQVhIbWM5YlhBRzE3Y3RJemJ6?=
 =?utf-8?B?cml1ZWpmZ1BTMXJ6WEUwYmcxNGtURktmT1NseXRSUFF0TW9QRGdPOHRKaEta?=
 =?utf-8?B?YkpNVTR3cHplWUhOekZCSzgvQ1VtdkltWTlIbUVjSmNjZE9Pc0NtMW9PczF0?=
 =?utf-8?B?M0labDEzZmR6SWtRNzczSVE1SnpWUExvRFBkS2svUHJEb3MrNFk4Tlo5S3ZV?=
 =?utf-8?B?MTI4YVZzWjNSUi9Pc2lHQVNGRVRtTE9qUjhjWSs4ekFQQy90MHdqT1czN0lB?=
 =?utf-8?B?UFRqazBJRzJtS0FlMnk5c3JPc3pmWG9iWjlyTVhuQ1lRREZhT0psb1hMc0tX?=
 =?utf-8?B?NTJaRExNSXE2aGwyYVVKUm93STZJVkMxaE03bzJDS0ViQUhNMTdiZENTOGdi?=
 =?utf-8?B?ZHZRVzgrSGJaQjdjTENqRkVZWFh6cXdCRWdYdkRocUdBT1U5M21qOVE3K2Fz?=
 =?utf-8?B?amJNYXp4UDFXTTJkUFhpajBpbGovQ3Q5VHpIRFFqaGMybzFDWmVnRFdkVytZ?=
 =?utf-8?B?bWxTaWU0NkVheXhSb3poaGtDR2ZTYUdDbWZZNzAyNlNackJZTFY3Q0dTODlB?=
 =?utf-8?B?a3dxeXdKTE9JUmlVbkYwTi80MDdlOCsvSnlRQ25yWHBDb2szeXVVUzZ3amZn?=
 =?utf-8?B?Y0hZQUxwZFhrZUVqYTFpR0QrSG9MOEgrN01wcndTQlJNSS9WRWZWYkY4Z0U2?=
 =?utf-8?B?RVd1M2tXejZYazlBaFNyTC9ia1ErazBBTTlweDZNQU8wZWo1Vkw5cDlXaDlC?=
 =?utf-8?B?ZEYrVmkvbm4wbDg3NmhUeTNGUkpib2NTYjJnZEtQNDZJMWdZdlZCTlBQQlFY?=
 =?utf-8?B?a3FLVittMVpyRU1MeUFhYU02cmJodEoyc2V0MTVYTlp1THVQRVY3eFBvK1J2?=
 =?utf-8?B?VFBhbVdQNGVsNExGalphZXVmRFpvOTVFeGRNaFVkanVzR0FqbHExSmVvOXcx?=
 =?utf-8?B?TlBxcDk5SUE3RUVyLzBwdkV5MEQ2VU9IcDdYb1FDVVFWS3U2YnJxS1p1NmUz?=
 =?utf-8?Q?VaQivbXYMx6g3VdGqCaCDzXteHQdojaa+wIZ1YymYZaz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b883f3e5-b4ad-4010-02f1-08db73ef616f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:40:17.3777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kp9pf9R2u75hPssmDP7leCkpr5QD0AJtxg2RSV7eYy/aKKNppYCqvAIg/8Q0zXX8LjdxvhBBiSRPtNjE2x/Dow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/23/2023 4:41 PM, Arun Gopal Kondaveeti wrote:
> pm_runtime_allow() is not needed for ACP child platform devices.
> Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
> & pm_runtime_set_active() in pm_runtime enable sequence for
> ACP child platform drivers.

Can you explain what prompted this?

Does this fix a particular bug, or is it just to correct
things?  If it fixes a particular bug; I think it should be
split up across 5 patches (one for each APU) and then
appropriate Fixes tags applied for each on the code they're
fixing.

>
> Signed-off-by: Arun Gopal <arungopal.kondaveeti@amd.com>
> ---
>
> Changes since v1:
>      -- Updated commit message
>
> ---
>   sound/soc/amd/ps/ps-pdm-dma.c         | 3 ++-
>   sound/soc/amd/raven/acp3x-pcm-dma.c   | 3 ++-
>   sound/soc/amd/renoir/acp3x-pdm-dma.c  | 3 ++-
>   sound/soc/amd/vangogh/acp5x-pcm-dma.c | 4 ++--
>   sound/soc/amd/yc/acp6x-pdm-dma.c      | 3 ++-
>   5 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
> index bdbbb797c74d..d48f7c5af289 100644
> --- a/sound/soc/amd/ps/ps-pdm-dma.c
> +++ b/sound/soc/amd/ps/ps-pdm-dma.c
> @@ -391,8 +391,9 @@ static int acp63_pdm_audio_probe(struct platform_device *pdev)
>   	}
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>   	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);
>   	return 0;
>   }
>   
> diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
> index 7362dd15ad30..9538f3ffc5d9 100644
> --- a/sound/soc/amd/raven/acp3x-pcm-dma.c
> +++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
> @@ -416,8 +416,9 @@ static int acp3x_audio_probe(struct platform_device *pdev)
>   
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
>   	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);
>   	return 0;
>   }
>   
> diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
> index 4e299f96521f..c3b47e9bd239 100644
> --- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
> +++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
> @@ -430,8 +430,9 @@ static int acp_pdm_audio_probe(struct platform_device *pdev)
>   	}
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>   	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);
>   	return 0;
>   }
>   
> diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> index 29901ee4bfe3..587dec5bb33d 100644
> --- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> +++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
> @@ -409,9 +409,9 @@ static int acp5x_audio_probe(struct platform_device *pdev)
>   	}
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
>   	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);
> -
>   	return 0;
>   }
>   
> diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
> index d818eba48546..72c4591e451b 100644
> --- a/sound/soc/amd/yc/acp6x-pdm-dma.c
> +++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
> @@ -383,8 +383,9 @@ static int acp6x_pdm_audio_probe(struct platform_device *pdev)
>   	}
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
>   	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);
>   	return 0;
>   }
>   
