Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6180F665218
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjAKDC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjAKDCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:02:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDB17040
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rf977WbUkmkws+Tf0N7MUie0baTcjk60JL8ob/+ph9voM2ofohSKm+0tmT8mr48p8Hkimhh7hvGvo+45Wl9bYOD/BWDbfmaqGq85hrpHraNCWmChPYsjKUYB8A4dSaRQE3xlxzENpGYX61A1n3t4JxVZlcqGTFK2hxaBXkLkFY279d2aKb2PRypjVX/bwAsz0nflmqIr8G5X5raakIoqK6ihh7VGuIypXqr2iYl709ftW2DvsPCccXixRdgFI0Wdbpq4ZLlJTXMktSc4X6vbmFOcbFK5DDGVCLxeKXystIzlDji50U4IUvhwEWLrmXNVhytIh/xIsunnSH4NZ5zzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaojYCiPLq0PIgzZQ9RNXov7TzWHpN1uIXezUiZa8Ls=;
 b=B4WXrjHON4lZD9QywYWTzwc3AqMTkeKt3t/yjP7b7Do6Q8XHfkTidR5evgv+4MJ4LR9K2lLe1cR62Wz5wL93OOUo4et5++o3xQhxZmNYfT4qNIw0fzd5uBKYoreAd7McH5pI9O5Ma5O2bvLcFKYoZtVnXBjHjdsvBX2j8Qr84DsB86VUItMY34B9Bnl7wSo0cp9ArmLACJgGq89hrn10lposrkxQfmMk63j+EyPYc2fQ/UNVAXvhpbjkghBwFjIt65on3N7JhS+uZUPNYuzaBDvpLfZRCmwTh5Xgxqn+4r7DPD/xQf/zdioyZ7f/6CRqqzFH62AhPTMM3cMe/7U0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaojYCiPLq0PIgzZQ9RNXov7TzWHpN1uIXezUiZa8Ls=;
 b=iWTUYvRCQJPPEIb3AddGbC0isYf29ZTL16wpUdB4czzr7vvatcSEMSK7tINl20sxLBCA7Z4BkT30bk/tw+CKV5be12BLXIe2eTBACHiVR2c4If5NyGpKL6yNDtPWOxPcmCIQcqEXGLH3353Ryh+qmN4q6liKO1C8wC85JO6y7Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 03:02:48 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 03:02:48 +0000
Message-ID: <6d3380db-5e21-a3e5-b1c2-8618819d1cb2@amd.com>
Date:   Wed, 11 Jan 2023 08:35:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/6] ASoC: amd: acp-es8336: Drop reference count of
 ACPI device after use
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20230102203014.16041-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::23) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 8055c751-e4b0-41c9-9487-08daf3805201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjXzFO+FZxNUJ7nKor1veaDQki6zXKjaJTF3Z7VtdQBu8Rp8MememGB6NXQksUUbN92XJypXpeqgXPdJzQmaUSV4pJy4Lz04jo/s2OJaYofoxSKXHlregXnZioiOSWbKr/BYqkpVM6VGVkKyDhMbHLTjevRt8TJGNxXzU/FVyq4HgTf4wRIQAffJWbAhWxlwMLdZyrB7/QA78g9QjLh4UG7zQHrje9DVWev3aLrFE2oq/052SboVK2rUdkjC5euJrMnvCtB7pW3UoA/wkjHlghqJLGncI691RDs8nrGshACyQw6ONtu9c7dBQUWViz3NsZKqVO8pChiNDRV4QhShoJgO4txcU29R6gO3yeHjJCr9rnXYetXzQ5sgJuWWiSUbrn18idwb3vWBENUGC0jZwgYYMY87S9PQAdyJC40pvu0iGnHPnKI/pqyIQf1M0DgxgDSx4cYXIiaL5rYTAst8sF7FGtYBYKt1xp9wasfQgtM6ekjBVF3v4JEDVHLXkxcHoEZyrf6MFapS1MJbydUs+n/lGjtmvb+U5QjKqlj/zURYQ7fNLwVBPAyiAiMxsq1jxx3/+fdVgFe7vgwkIzAaAnSSfEUmnXW6UuUdFTGWXH/dR+VXIWq5qWon0nBZad8cZcxRcV/gKfVNhVZ0L1ec35KoF9ltLHWN27LrQLGtIHXd6EZ0HypEAxmniSFVVKptTiIGChJGR6M5Y3sRdD3iDbSKDF51OilrHb5sirpEzA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199015)(53546011)(6506007)(6486002)(478600001)(6666004)(2616005)(4326008)(26005)(186003)(6512007)(66556008)(316002)(8676002)(66476007)(110136005)(54906003)(86362001)(38100700002)(83380400001)(31696002)(41300700001)(66946007)(31686004)(7416002)(5660300002)(36756003)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzhPQ2dyRU9OS3dLUVFIUG5DSk51YngwNU1KUWVtcHBadWE4ak53Z3BWOEo1?=
 =?utf-8?B?dWQrQkVHUnBnTHFIcDRNeGx4YzZCeTJNVC9NVjRCbk1xN0xFcGZFb2taVmc1?=
 =?utf-8?B?ek50aEl6UmpObDNncTh0RFR1Vno3TmJybUhQcEo1Qm5lQzFJcVpzaWR1SlRr?=
 =?utf-8?B?aXZCZkhIUkI4YlBOWU01Nmp5WEY1MWM5bHFuK1E4L2lvL3RKc0pjNlJUMWtS?=
 =?utf-8?B?UUkxRWduWTMzbXFRZDl4L29FcGVoMWdYQWFEVnhiVnFRM3ZaZEF2ZERjZ2VS?=
 =?utf-8?B?bHZ3Y1VpRUM3RGZzQVk1Z01SMmpaV2ZWM09nTGkvN1lYdldhc2lSeVhqWmZF?=
 =?utf-8?B?ODMrMHdlQ1RnOWRZTWU2ODVPdDlRYlZPQ1lWbDdzcUNIM1NJSHFqVUlXY2hr?=
 =?utf-8?B?QXJNTzhnY2lYUGE1YTdOOHhaMlhUNTRHQk41S25keW9yeVZjM29PSEpHUytE?=
 =?utf-8?B?Yyt0RTVEUTA5aVQrZ2xLQ3B4SlRIMUhCOU5OaXdJQktBNHpSRVFtNG1kOTYy?=
 =?utf-8?B?bUo5MXBsaDIwYmVZcmNiaWpjVnNDeUxmcjBWdnoxY215TVZLd0ozNGJySCtH?=
 =?utf-8?B?aThxaVp1eEE3MER5S1hBQWt6cGRUNGNDMFdkT0x6dHdkWUZYVzRRWUVNclVj?=
 =?utf-8?B?UHk0Y1I3aWYrdUVzRkNRUFFRZVdQSkt5Um1wWnNvbXJXbnhQOW9acXRDNWZF?=
 =?utf-8?B?QUpKT09uTFlFY0dmUVdMdFFYRTliV1dQRnF6bWFHWVFWUm9sc2dFYWdkMkxZ?=
 =?utf-8?B?SnF1Mmx3Z3l5cHVmamdmWWt4QW1lUlAva2swQWNjOUdOa1F5Z0ZTZTZ5ejdK?=
 =?utf-8?B?SGtwRlRUdzFpZmN0YjdycXBWZWpHaEpybWIveEUwSlB6bENBNEJpYTYzVGRw?=
 =?utf-8?B?NGNWczhDZFpYeVJtR2hiUW1CQ3d1UHNVeWNhN0xmSU1nOXd4ajdxWVZLOGF5?=
 =?utf-8?B?ckcvMWJkVktIVEtGeTdKTXVkc0dJVkhPb1MvU0FvZ1k2cXRrQWFiTFRnSHNP?=
 =?utf-8?B?RmgwRzIzSGdaZjY0RGxIQitUNnprSGgrWXlCOFhtdkRIQ2l6S1JENWViZllB?=
 =?utf-8?B?OXBGMlpWQUF4VjZuSDIrSjlMZkZIVGVETkNVcGZLOWNpK2tLTnZ3Ti81clpi?=
 =?utf-8?B?c2xLeWxpdUg1RXcxdEZ2T1VaUmN1dHM0YXprY0JMSy9meEY0RGFoaWw1UEpT?=
 =?utf-8?B?S0VuRDFUZE83UGRIM0pxei9IdEFTRmtSQUFHMWkvSVE5Mktyak9jdGR0NlhU?=
 =?utf-8?B?YjBJdzBaamlGbzJrNnhGT25WUmdjYVVOTGYyb3VLa3hPdXk4N0hUMHZ4REtD?=
 =?utf-8?B?ZDIvaS9CTjRCSWdQWVFjYkF1NElWRktmcUpRTjRjd1JTN1g1dTI4Tm12YS9o?=
 =?utf-8?B?cEhyejhZMksyOVlxQ29ERjloTURWOVJtWk9hSkY3WVRPcnEzcXMzZVhlNlhx?=
 =?utf-8?B?OFlyV3NSQW5XaHNJeUtZNkZ4eTdDUnlscEN5Ri9nY1h3cjkrRnAzQmlHc0Q2?=
 =?utf-8?B?dllTczBzTjJ6NTYrYWRVMDJ1dlJROTZ0V3pHVFBpYVlxTHl4dU82R1FJbGhS?=
 =?utf-8?B?Qy9JQlRralBUazdBR2ZkYzNIZ1JPd1JNUDdIUDY2ZEpTaXlSU1Q5QmZJTDdH?=
 =?utf-8?B?TUlTRnkxaXMwTTQ5R3U0Vmh5c1FMdlk4NGkyZVBEQ0kwTVF1dDdUdjFvWGIr?=
 =?utf-8?B?ZTRBTXZNeFhOeHMwR24vMTVMeUgwVGt1MjFHM0phdkUraWNVWnB1L2tmRW1B?=
 =?utf-8?B?dWROV1dKYkJVZFpKUjREOUp3bWY2eU5DMEVxSWdZZXMrVkEzWVdEU0Vad1N1?=
 =?utf-8?B?ZmE2NnNZZitpc2VkQzY1cEZwOWMxbmJUTW1yV2x5TGFiOFR6NGlWMkwxWXRs?=
 =?utf-8?B?eHBuZzJFRFh1dVVKVzhrWllPYXBjY3FDb3N3Umx1dzZzNVlTbUhPdTNhT2dl?=
 =?utf-8?B?b3h6MGJLeHF0QlNJMmtHL1hlTHpMTEhjWG1LK0gyTFBjUUkzRFJoZ29lTElQ?=
 =?utf-8?B?ckRLL3JSQ05JMTF1U2ZUeXNYZ3BTd21VaHNzQ3lqaWNlSFVnL0tKMXpNTUR1?=
 =?utf-8?B?bU85VEMwQ1prMjdOZ2FnNFVGbERBTHlYdWNnMTRqL2d4cEhXUFcrVWdPRC9h?=
 =?utf-8?Q?Mu8uNJUCWoqUyFRLdKCL4LXdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8055c751-e4b0-41c9-9487-08daf3805201
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 03:02:48.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eE+uzSOiW27A2n4KvDygUon1nFz6LEyI+RnVkrZUsRwOShgZ+NRwDsnQSEc1gp3m+INrlj8VmOaHUtAGc1xJ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/23 02:00, Andy Shevchenko wrote:
> Theoretically the device might gone if its reference count drops to 0.
> This might be the case when we try to find the first physical node of
> the ACPI device. We need to keep reference to it until we get a result
> of the above mentioned call. Refactor the code to drop the reference
> count at the correct place.
>
> While at it, move to acpi_dev_put() as symmetrical call to the
> acpi_dev_get_first_match_dev().
>
> Fixes: 02527c3f2300 ("ASoC: amd: add Machine driver for Jadeite platform")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  sound/soc/amd/acp-es8336.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
> index 2fe8df86053a..89499542c803 100644
> --- a/sound/soc/amd/acp-es8336.c
> +++ b/sound/soc/amd/acp-es8336.c
> @@ -198,9 +198,11 @@ static int st_es8336_late_probe(struct snd_soc_card *card)
>  	int ret;
>  
>  	adev = acpi_dev_get_first_match_dev("ESSX8336", NULL, -1);
> -	if (adev)
> -		put_device(&adev->dev);
> +	if (!adev)
> +		return -ENODEV;
> +
>  	codec_dev = acpi_get_first_physical_node(adev);
> +	acpi_dev_put(adev);
>  	if (!codec_dev)
>  		dev_err(card->dev, "can not find codec dev\n");
>  

