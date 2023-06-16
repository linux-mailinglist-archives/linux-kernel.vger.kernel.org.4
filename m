Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9FC7331C4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjFPM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFPM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:59:26 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB99F2713
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNFmCTbg+vzNnaZjwmWbBWsmCCdpICJiAN+CCICQgRvme2eTjspaHua4cZJTBF6i7Isf0O/9iEXyM5bEbSo+urlL3oxqUVIRYU5WmY7qla1HCk+Aynq4/qIxYfq6LRxaPagKGbc7dLazNlsGy2O13O0Y8TwEvu3b26CzMRLEXAdB4x1QczxoaLRajTJo3j7hOwXSGBRevv+PujFK6GlA77RTTa/2GDN77lPcbXam5Gu19XyRME1DbctSpOO188ALGVdNrxbW1IV7UbGEsXMqWgS/jHus2SPQQQxO49BMmVmocHKC39ex6o/6TRVvI3mVOg+Jv36Q0qNcOPskEuI8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgJFji6HrZzs4J/tPx2z0mpRtHUT3wHPAw4k1umF/TU=;
 b=H3ZeHgmVPXZWQcBjIwDtiTFNIPilQ0kuTM63AKrsmTonhH5nfNfUJ2QITuU4epO4GXrX3/F+v0DSoIexrMx/JJwyG9Gl7r7OR4e5LM7nT12gVfHwjayoJj98vGpwMbNEo5kb0wx7EScXRAo1wmaOJGL6Zt+gL1mDJ/HmxLu9CA/N2wvacEpeAZJsXHhKRg2BByeXmn7aguHQEzAaGcddgE8Nr9kMo2c6J0v6g3IA+Zh7p62gMSHORBsXXiFJusJHpEj4szN2tEZE4vME1sIDLsSTQFEsaQQhE/VquGFHlRN9ANRDWTtqK7VextBH1g+ndrB1+SDBcT6PLKKjHOpRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgJFji6HrZzs4J/tPx2z0mpRtHUT3wHPAw4k1umF/TU=;
 b=PEIbI2M8YRuRHaY7R58FO9r0wQAsXcMIR+vQ5/yCo115WzefdDRfzE8K4YRX4PEoT7svsXT/X05g335KWKaBt5Kyt1PNISmXtk9B/VbmrH75U9Kr8VibItQ4dcIFO8s9rzBdJdxfCKlvd7zhKwctbcN2HATCofjJ9KXTuOi3JzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB4770.namprd12.prod.outlook.com (2603:10b6:408:a1::30)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Fri, 16 Jun
 2023 12:59:10 +0000
Received: from BN8PR12MB4770.namprd12.prod.outlook.com
 ([fe80::2dd2:bbdb:58c0:9bec]) by BN8PR12MB4770.namprd12.prod.outlook.com
 ([fe80::2dd2:bbdb:58c0:9bec%5]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 12:59:10 +0000
Message-ID: <f140ae96-a1fd-e636-2b8b-d453fba5c6e2@amd.com>
Date:   Fri, 16 Jun 2023 18:28:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ASoC: amd: correct pm_runtime enable sequence
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com,
        mastan.katragadda@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230614003206.933147-1-arungopal.kondaveeti@amd.com>
 <317a0f1b-94a7-4bd4-9f64-8877e0552b6a@sirena.org.uk>
Content-Language: en-US
From:   "kondaveeti, Arungopal" <arungopal.kondaveeti@amd.com>
In-Reply-To: <317a0f1b-94a7-4bd4-9f64-8877e0552b6a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To BN8PR12MB4770.namprd12.prod.outlook.com
 (2603:10b6:408:a1::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB4770:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2c72f8-5161-415e-33b1-08db6e6979a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deSeaTwcrpgjgARgsRJJx6p+Qqz+EFmsmuuJW2Yb9LxmO27LviuD29x7Mor+HKuk7qqhN7wXGjjfWDc3IWzFV1MGPy1m9uafbkFWIk2Gfdn4xA/TP6/TwmXzZNz9xXxZ7sEXiBI/N30QP4WKomonOyaIUgthq9x7GEoAAOgwkBKNCRF1picxMtlpQCVM3/m/obXcbpBIswnz92c+qZ9IEpLPLztjIyczR9nWUml0brxiS3XtLp00b4F4HABegbMTWWd02EoCLE3J/liTVZNLprGSIwX4p8l7sAmNcAlXO9WGNI5mSCChM75nAnPsQ4pLeZri9WUSKcr3vwvZ6f8xpLGrXnBiWdVqJ7CvW/3k8q1x3ekfby/pHZT5aZHa5A3KmnExqPa7vppaQdeyU/Vvggfn3Wy6/3xYoyBBPGHfw860AtH1v012ZtZgk33ybOhRV4rhZ/34ZrO4qVO+6vqUUHFrFqNuoWEtUzs+deb6igUmMXU8jlwwbomeJvymUS1cYfWvjkXlPTHeTqLD2zMgsAerwxwr4vhQWR7ZLx6fsNyYA3Txs5+p2mee2WS5+ODKCEUEB7VC0V8NQkVQnrpoE5VnqDx3dR+QRdioAnSJxW9RG/nXtssa5MGBdvuwU1+GOZVUutSjNq7B/iTuh2VsKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB4770.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(54906003)(31696002)(41300700001)(8676002)(86362001)(66946007)(66476007)(66556008)(6486002)(6916009)(8936002)(316002)(6666004)(4326008)(36756003)(478600001)(6512007)(26005)(5660300002)(83380400001)(6506007)(53546011)(2906002)(4744005)(186003)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW9va2lvT0N4Z28rb0xXQ2FpMEt5d2x4ZFk3M1dVV2JmN3pCMU5PcHdqalda?=
 =?utf-8?B?ajQrR0tUTXdVMlhtNlEyOUJnNHJ3d3g2WndkRTFUcFhiY3V0QW8xWDhkRW1h?=
 =?utf-8?B?WlNnQTNOa1o2eUJRL0RsODFxWkgyN3NPZWw4YURHd2M1RzVKWmsrMHI0My9l?=
 =?utf-8?B?WkZjQnRjclpCdURsRGphOEg0MUFQdDZuQUdOOXpnV2lpdmZZcm1HMGZ2THdN?=
 =?utf-8?B?cStQbkd1MURHQTBHL004QjY3Q2huTUhwbWN3WTBUUlZDQ1lYWmRTZDlMV013?=
 =?utf-8?B?aStCSGhJRXMrai8wd0JEQkl5b0drVXM5bHIybng0V0JkSERWQlJzTnA0YTZj?=
 =?utf-8?B?NFVsU1F5VzNZaHZZejRHQ0UyTDBxYTVQNm1jQjFsbTZFRzM5elEyTEpKbFFQ?=
 =?utf-8?B?bCtJQ0dETEt1SXRlQmdNNHFrVGltVHVybnJqZkFXNllQeTNDbzhzbVBKc3hs?=
 =?utf-8?B?czNvSER2a09ZNVVNUGNZc2taOXpsZndKSDd4MXVrUm9BdmlHMG81Qklwem1v?=
 =?utf-8?B?Q0Z1eGhjZUtab09WUnBjdmFidTNEVmxtcTFxaysvdEhBQnlZeVhwU2kxaWpC?=
 =?utf-8?B?OWQ1TEZhSXhNSGNSZW5GTi9aSnJKQWIva09aQnY2NEhKZUdRbjZIbTBKN0ps?=
 =?utf-8?B?QXB0VFJ2cDNpQVBrNGhNc01rVTdFNmpoTHJpZVl6Z2Mwc2dxMTI5ZlpCSGda?=
 =?utf-8?B?QTBPN0ZnUytVWXhLdmJGMGNaYkZuYXJqam9rSE9USXloNGZteUc4aXJYeFVt?=
 =?utf-8?B?VHRtNHVGaE1oejJUVy9HY29iYTY1RjhERXF3d2R4dXEwVFA5T1lCMGlKbkh2?=
 =?utf-8?B?U3V4UHI4TzJYb05KOG5NbWFOVEVEMVdQYmZucGJRUjdYRG03b0dLbVpzQnE3?=
 =?utf-8?B?c1RreXExc1hHY2ttSHVwT3pkMlY2MFBSd1NtT0tONExqZFVsL3BnUGdRVXlX?=
 =?utf-8?B?OUlsSWNhZUh3VW9EQWZpL25OUXRLZThGN2syVUJzaHB6ZE9yMzBjM2tQZ2xr?=
 =?utf-8?B?Rk90SGZydFZNRjBnOUtaYVNWVklLcGhaUW93WHNTWDB5NlljZGMwSU9POHF4?=
 =?utf-8?B?clZxSFE0RDVTdVNKRU54NXJlRDk4d2NiaUZaUWJuaU9KV3VweDdheUVqQXI0?=
 =?utf-8?B?Tjg5cUJUd1VJd2VYWkI4YkwzajBsNVRZWFN2Y3pMRUFpeDNaZGNZUE9Fa0I0?=
 =?utf-8?B?clVVbWt1cTBFaGdHR1Jlb2E1RzE4K09nRmt2clJVSlBOOTdIUitVZTBRYzhH?=
 =?utf-8?B?YzlsY1hYWFJWMXFmdm9ubWlDbjJ3NzJCRThwVkxqU3Zhb2ZuV1EySmIvaVNo?=
 =?utf-8?B?Nk1IMGV5S3lEeDNWOCsyRlBPdlBpZS9FM1ZFL2V2c0M1akJMK2lJb0VCYmkz?=
 =?utf-8?B?aXZGK2M4czRqbEwxa3ZWcys0WWR6OXd3VXc2b2JsNGxxRkNoblR6U2g5Qldn?=
 =?utf-8?B?cCtlR3pJK3c3WWpFWDRCRHA1MVR2cklibkh2ZTJPOU91ZHlPc0hucHozaGFI?=
 =?utf-8?B?dS96bklNaGRFU2docnRoQ0xCS05BelhadG5Iek1WcVY0eEpuck95SjE5bGN3?=
 =?utf-8?B?QVZaYjhYYVF6SktmcjFpaStjWHlVNlhRaGU5N3NvRUo2S01xZDRMeW90WTZa?=
 =?utf-8?B?bXhkYlYrTks3Yms2R0RGRlc5SklZTytpYjFFSnV4MkRBUFRsWDVKNTYrcHlZ?=
 =?utf-8?B?SDFyMXFjMVMvMytoWFNNM2dmZ1lxcmlKeENKQ1A4dzNBUm51NitYeGZKbCtU?=
 =?utf-8?B?d0YxcU5LaUF1ZHRhdW1vZ2hidnBBZzFzQ2ZiWDdncE1kdGFiY2dubHJ1U2pk?=
 =?utf-8?B?MzhVQlp3QUs2ZGJ3eHNsR1hkUnRjVEFYVm9meExMWFJZVXMzSEVQZWxaeXhu?=
 =?utf-8?B?UGg3ZGpOaFNhWkg1SklFbjd2cTRIVE5JZjREZk8zVmhOTGl1Ym80ejNIdjNY?=
 =?utf-8?B?Nld3RTZlYjdDTFJ6OVVzS0dGQXZvNGlwMmVQR3VESXIzN3hFM3RWekF2RmRR?=
 =?utf-8?B?NEpyNmJNei91aHJaWGFpOW5IT09tWFRLZ2lBS0RmdzhXWWJpMXJtWmJRR0w5?=
 =?utf-8?B?Nit0SnJrb2t1cW5XVzV4eGNkN1NVM2M3UzlZMzV5QWM4RkltN0llcTY3ekwv?=
 =?utf-8?Q?VLqQf5wzLuCKbhEkA7svuxLrx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c72f8-5161-415e-33b1-08db6e6979a5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB4770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:59:09.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMw45zFBShDlhae7+bWgrE2dXZC59MdnK2ovsaDaNEnjLKTLdmb9t7p+j5FnCIdqOlmuy6TX2gSU0An2UO3TDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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



On 6/13/2023 7:39 PM, Mark Brown wrote:
> On Wed, Jun 14, 2023 at 06:01:59AM +0530, Arun Gopal Kondaveeti wrote:
>
>> Replace pm_runtime_allow() with pm_runtime_mark_last_busy()
>> & pm_runtime_set_active() in pm_runtime enable sequence for
>> dma drivers.
> This says what the change does but it doesn't say why the old sequence
> was a problem and the new one is better.

pm_runtime_allow is not needed for child platform drivers .

Previous sequence as listed below which is incorrect.

enable sequence:

     pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
     pm_runtime_use_autosuspend(&pdev->dev);
     pm_runtime_enable(&pdev->dev);
     pm_runtime_allow(&pdev->dev);

disable sequence:

pm_runtime_disable(&pdev->dev)

Replaced pm runtime enable sequence.




