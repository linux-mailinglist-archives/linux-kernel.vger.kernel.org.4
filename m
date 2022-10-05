Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6C55F5AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJEUQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJEUQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:16:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C446D554;
        Wed,  5 Oct 2022 13:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONJWIiVu57OA5gs/1JlPsOJliD2Y0ZYNZPkm/SyN+Odxezyxm0G+aFyAZvtf/Ko0rYSXm9IklGTHLQ4esaYID6eEFhNS5qGf/0ZgUOEw0KDTb9Pl2zj4K5jipOsgUBBVxPKjQV9Xif2AcwD6sToKN7IVPJuJq/lV8/GukUQ1oiM6KfG6cswDyXA9JmoosnUhQmfuyXQhoB/DnhJj0HLZ3k7cU3jaOcnhC5rxULc/C9JZ0RGiA6IankJmJAepRRah7kSbjgZuiVXniGuT3++rQcevQZzORhfVtCfQYGPmjwybNvFT93p0GSA9xP7/KPOmdiGh1FnT8Ywx1rA3j6z+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mHBnoijPfOkMvIkS75PcX00WIHRQNsGV7yWprInEfI=;
 b=GEvKHxiDXoLPV8ll3eDOhoGCDnlhsNcymiSqgfzzAIjrJeSDul3NZ9Hd0VzbcBCSVyEVZbY4F1F9yNScoMPS186NlteP0fIlJjMNzKuuHP5f15dYYWlf5suoXcXZz3ALiCCYDAa+q1Qthl8erkrJ9AfuqtOMdO+XXk7gYofdwWXOTIMXnf24sVzXe4tHzwMR1q2VjlSbCQKRK6Vk8NVp7AKPMMqTjEf0reTKG4uXShvkByUCxIVl681i9+ldfUZp9LdUZ5yiMdvWmmWr5Gpg+gINcYxfOGbZ3TU7RFCTWn0w+GGIb+cubzY2AVyGYsmnpnvlFaruEsFdu0fVu7DGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mHBnoijPfOkMvIkS75PcX00WIHRQNsGV7yWprInEfI=;
 b=iDMRlQyRVYc+rRV+SRo4ofJ7Vahyxe1b0VZJuxutrCrmue0nGS/U5hWyA6T51Z8+49PPJUh/67gDBLgMdFwejxx3GVOXiKSRkrapHfJeDs4CYLXxZdLZRg+L+mJggquTPrlzLL0uxY0i/EvVF5QPIFMkx16aQdOI7YQwcWSM7ZFYD3JG+5UK59fxt5XfJujW98T3VcsL3bmAX+3EZI43w2pGQQn2OUh5Tz8votgk3JqUmhpmKiQtcdib+/99Oz2HLrJrx2S+jIBuOM3O7VsxvL8vvrX09Z2IZ72DUghc5k6qJtZNhrsC8mE+5HX7BiFb1qUH4VxqEZuc5hO71bjImg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Wed, 5 Oct 2022 20:16:41 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5676.033; Wed, 5 Oct 2022
 20:16:41 +0000
Message-ID: <1b154a54-381a-a8f6-f0ce-20bce05f27fc@nvidia.com>
Date:   Wed, 5 Oct 2022 21:16:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use
 macros
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Mohan Kumar D <mkumard@nvidia.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
 <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
 <657d2418-0c3e-296f-8f4a-dc10ced2dffe@nvidia.com>
 <87a66av4gk.wl-tiwai@suse.de>
 <9677f39a-5297-bb1c-d4e3-62484ec1cf25@nvidia.com>
 <87lepugy85.wl-tiwai@suse.de>
 <d2772c7b-bea9-e3bd-3b6b-c657566649d8@nvidia.com>
 <cd3918c8-64c2-fc8f-c184-3fec3ae01e3c@linux.intel.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <cd3918c8-64c2-fc8f-c184-3fec3ae01e3c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0386.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::13) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 7119c964-8513-4856-1335-08daa70e8429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rau3+l9cHMPVMNX4qUd8LlRvlw66TUXMr2CvacDqQ/OsaauaimI7ysu8msQ8IDhaBKm/75obCaxz77o+2/M46qH38/Bq2f88ofer/9xvst/su2+LBsLjjLiAzfYGtsa1PBcqH5knyuV51yddNZSpl+Ofq/MPxqJ3ni1htc6IrTCeYr8SaRYtCyeo0XVfvd0Iv8UMRtLRTWePaUkVz3AehhsaY7YHDEhpnLuK7TsUbqfV29Y/Ffuuh9T2OHWGSp75JgwZAf2qTh5OdLekoHylGcuQTu6IJlGTWNUq2hlspsDZDS+pqK0wJeNS5bcVkeZGeoza1pBpNCNJi1Fk2+vynYI1fxx3/M0yPY2Y3otr8sD/dMMXneaF7lis5brcA1aD2kdS4TL9jFT6JsKSzTaEqSgtcB4s7JcsUQ1Gvc6AZSYllDCRWzkXzrH9BbZcq2RgFS8jDntRjmQVeby7QdKNrjyx+kXNIJNVHg4dOzyMCRxsOxwnmdw4BiUkqWdm4iIB4CI2ZNaUoN1dbhFzaEANt+drS9n0MwK6qo4xleTG68fNRu/Kiigckm+40SR79mNq6typ8p5EAvWTcEjV9lQkpDooHDUCcE4ugdQCSsuHz46ghiIuxbPOU8mjqOB1FpMfAWqvLuJPpMOKjF2INhKGAQyxvJiXIQ97rQHyYys9/cYSR+EBjkBHeWS+pYsJM9wwFu2wo5jDD7Csu1Z3swmruf5XC2VnF+kMAdI42FlGY2QZcnNYg8y9npktUmH2i5VnI9HBRO2m9epQndS2QoDaG58EuxeN8U53YeA2aHF19VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(478600001)(6486002)(83380400001)(110136005)(54906003)(31686004)(53546011)(36756003)(41300700001)(6506007)(107886003)(6666004)(8936002)(6512007)(4326008)(8676002)(5660300002)(66476007)(66556008)(66946007)(86362001)(31696002)(2906002)(186003)(2616005)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnpJWWNYN096UFdwaXdXTDh3RW14Y0VqZjJMNzQ5UzYxS0ExQUI1V3piNmhL?=
 =?utf-8?B?dkJLYXFXQXZ1R2xhYmF1OG5LelRyWkViVnYxL3pvTnI2RHhhQmdIMkkxTlZ5?=
 =?utf-8?B?YkxWVGFQZTJXYmQvcWs5QWZLZk1LeFNqN0NtcVJ6Wm1hZ25nbHFnWXVKWk9y?=
 =?utf-8?B?SmxhdGhCY1FoOWdvZjBCRStwWWJueEtsdExsTGVwbitpUStHc1p1VzVlWnkx?=
 =?utf-8?B?d2c2Ly9DTnl0K2wzUG4zck05TXRZQW5hQVpNSHNvN2pGVUZ1VEVtSGNTZEZY?=
 =?utf-8?B?QjVsS0VYMjR2UjRSZGF6SlZ5OE4zSnFKcWQzM2gvSFRrSTNBWHE4clRMT0Nt?=
 =?utf-8?B?a1gvR01NV2RqL0F0N3BsVTc1VnpvVVh2RjlTQnAxMWc5dFF3LzlCbUFFcmR3?=
 =?utf-8?B?ZFFSbGpLei92eU01Nzk3SjN5bFViUVlWeUhaSGFjUmxCYk1aV0k0UWc5eTBh?=
 =?utf-8?B?Mmd3NEpLTGJLbEZCK21lQ3VqZHo5VGF5aUN1cnpYaVA5MXFteVdoVFozSnIz?=
 =?utf-8?B?REd0OVlDdmdtRmJuMUFPN21LUEVPaEVrak0va1R5Z0JuMEQ3V0xITk82V0hP?=
 =?utf-8?B?c2NDYlJQK1hGSDZUbGwrSVpyUWZnTGJiUkNSU1BPMTdjNFFyV2wrd0o2cUtn?=
 =?utf-8?B?VWQ1eVdaZVEzZmtZSTJDRGNEOHViUUZKY1VvVmtRUHIyOHRTNy9kTUpQK0RI?=
 =?utf-8?B?TDNManJnMWV4MFMzakhFTUMyaHEyYVdKSmRibURXNmxmcWdBdnM4T2lUT2Jp?=
 =?utf-8?B?K0lNL1JYSEZHRW5QSVFTRlAydHZRYXU3MFBEMkYwMWZxTjNjNC8rRWdsWkJD?=
 =?utf-8?B?NnV6UTA0aXBvQS9aVW1xVlN1Wkl1cGdyK1U5dkFIcjh2bWsyWkpiTGdhNVZz?=
 =?utf-8?B?SVJ0akZGVzk3SXVtMU80REY4Y2I0QUpwRkVzSXpYN0Q1ME5RVEpCcU1Vc3Vy?=
 =?utf-8?B?a01JQmM2d00va1FHS3dsMnlwSjh2Z3dmNE1KZkt6YmlCSTBvN0RkRjVtVXBI?=
 =?utf-8?B?Z003T084enR3ZUJOWXNpZzdVMnFXWkVROGRUck8wSkw5UG9ad0FnMExGMFRw?=
 =?utf-8?B?WkxhN3hlelZmUm1vOFJvR1FTZFhqTG16dzVlVU9LWmlsbG1JZG9yRWxFd2hn?=
 =?utf-8?B?MlNPWDJ1b3o2WVl4bk0zMXhLOW5aZlJXTUw0ZHdmSjl1NFVBNjZ4d0Z6SXB2?=
 =?utf-8?B?bXRzREVOMGtsYnNYUVdIcEpacU9vek9hNTNLVkJVQWtNVmMzNmxuUDA4TWhp?=
 =?utf-8?B?Y1kyK3lPTVRXbWRKSUxKVDdkbys5S2lkd0RCTHQ5RHZXbXEzamc1MHZXU2NP?=
 =?utf-8?B?aEh6ZFE5OVo4N0xDQW1oeUZURlNmWDR5c0ZYUmZpMnJNZzZ5S3p5UUFKc1Ry?=
 =?utf-8?B?OUN6ci9paldhbVk1SjJrQ21oRXREaWRGSFh2QzE0V1FvUGFtWlVlZU5mVU9N?=
 =?utf-8?B?NWE5N2dNTk1LblMvUXpMcHF3dG5ZYThIYTdzdXMxSkdoZ1Fuc2JMNjJvRlFH?=
 =?utf-8?B?dXJ0b3RHN2pmNkM0a0ZLWWlpOVpuVVRoUTdhVlFEdDNjaWptZ0lEWE5mazhx?=
 =?utf-8?B?VEJSMDZmdXlaVjM5OTQvdTZRcXJUaHRhUFMxWTJEUXlsNm84akY3MGpwVGVh?=
 =?utf-8?B?UzhTM0ViRUR5YytPOTlvYlJOMzV6S2gxRlo1MGJwQmpnbExveWRreCtSTzBi?=
 =?utf-8?B?cU1uTDVxNFpva2RSWnhuK1J4K3d2R05KdjlUMkRPWS9yS2hsTFFtNzRXZVlo?=
 =?utf-8?B?YkNKR0M3bXdJZXVyekQzVi9xQ3RodFVGMSs5WFQ1dVA0RHE2TU5jSXVRdUkz?=
 =?utf-8?B?WU5rRDFCNWtjaXJnbElqSTFMU2RySjg4aHJjZ1FGYXYvWStSNU1DK0lIanUz?=
 =?utf-8?B?TTRFNHdMeUdrbFBpMnN0TUUyejdjMlEwS3R0N2ZSQ0VtclZIeTJPVXdlditl?=
 =?utf-8?B?NlM1R1lVOUVWb3kvWDhPeko3Ty9BeEZmbjFYY1VMVmEzdFlHNHZ4TE1hb0tu?=
 =?utf-8?B?QUZTY3hHT0hzWXNUeWVnbFNjdlRWcTQ0WkFsVFY2enNaTDF0Wm1Xdk96ckhE?=
 =?utf-8?B?YTdCelJKbHdhQllaK1hZOU1xRjg3eFppMlFGOEJsZlVBd1Z1YkF0MXpnUVZn?=
 =?utf-8?B?bTE1KzZJYjgrZkVLVFdlanZtMVZ1UXdmZlQwbW1RdVBaL2pFQW9kcm1oT0tX?=
 =?utf-8?B?c1JZdEdFZ3ZBb3JhQlVZZUJ6elArRnVwT0w3dHRWeHN3amV0S1p5S3BNTEg0?=
 =?utf-8?B?UGIwNStTTENTenNmS2JQSmlPYi93PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7119c964-8513-4856-1335-08daa70e8429
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 20:16:41.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWXo+j/rflmN3OEEH26A+sp46NZY6MJ3C8jSuA5SDMxVXHQilK8Q5LJh+PKw8t6UcNh2MgRlSQPRsqDVNk/2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2022 15:47, Amadeusz Sławiński wrote:

...

> Well in worse case we can revert the patch in question, but I would like 
> to get it working...
> 
> Maybe also try to raise timeout to 1000, as what original code called 
> timeout, was actually number of retries? So 300 * udelay(3) which is 
> more or less 900us, so we can round it up for test?
> 
> I mean, something like:
> 
> --- a/sound/hda/hdac_stream.c
> +++ b/sound/hda/hdac_stream.c
> @@ -176,7 +176,7 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
>          snd_hdac_stream_updateb(azx_dev, SD_CTL, 0, SD_CTL_STREAM_RESET);
> 
>          /* wait for hardware to report that the stream entered reset */
> -       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & 
> SD_CTL_STREAM_RESET), 3, 300);
> +       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & 
> SD_CTL_STREAM_RESET), 3, 1000);
> 
>          if (azx_dev->bus->dma_stop_delay && dma_run_state)
>                  udelay(azx_dev->bus->dma_stop_delay);
> @@ -184,7 +184,7 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
>          snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_CTL_STREAM_RESET, 0);
> 
>          /* wait for hardware to report that the stream is out of reset */
> -       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & 
> SD_CTL_STREAM_RESET), 3, 300);
> +       snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & 
> SD_CTL_STREAM_RESET), 3, 1000);
> 
>          /* reset first position - may not be synced with hw at this 
> time */
>          if (azx_dev->posbuf)
> 
> 
> in addition to Takashi suggestion?


Thanks. Tried that on top of Takaski's patch but still not working :-(

Jon

-- 
nvpublic
