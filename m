Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34466B7AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 07:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjAPG4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 01:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjAPG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 01:56:03 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D476A3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 22:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3s79+15MohKY2JGHDQuHGvNejHTbXqcGRisfZyehcjZG5U0/gYMLaH+HWYK/UTC/+Wb7ayj9vyV/w9GuKt+BNbtTFTUezxK2l0IgSmOa4E5TcV/eBdUGvhWDrox6mka0YsEP1OMnMBY9Kp7drhzaTzJNhwUgfAlJ0/0fY1R83gMSoi+i3O+eOKXGyxMJdH0a4abVqLWeEbVOn8GKh4sO1DN1vk+ls80WEtYrzeQRElqTBcJWOFLRiUPxXlsG5T+6YQefTLW0/S20Mcy0uY0b79BB7PLlSOOAgVfQ09flleup9qPy/eYV7w8oUeav1WM0BqFNjjeer2a6AcD5UXTyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST6GRAUeFfjC6NQf/kJ+8dTF292Rpvp1SC4+CS9Qw3I=;
 b=O+1sP/Brmt+Aa1gIH4ILl8loRqIE1LBo49PF3izExTxwfeadTMTGZ0PEiwPwNEmwJc+Uy7Wvr+yWII8pbtWURNDsSjquoGqp13XI2cAr6e3bc6VUP/qTfPtKCR8ZRCDqvnxFF/vSvIIKppqM9vrCzuhTxbq0OUbjC7ztk7AbCUljQPVVJknXN4hA3BSjKZkQ5WnpA13zru2J6k65H+na5ZN+VzWvp3ru9BGmQFJngMcKZKb1e99VXcB+/gVIIoKUZL8In8f0dcJVn2ZuzBLl7wJVYwi+0ssG+W6UGWoaSw/7zYb9OcajFtG8Afrltqh3vXJDjWLRQvEj+spNFPVoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST6GRAUeFfjC6NQf/kJ+8dTF292Rpvp1SC4+CS9Qw3I=;
 b=b/cvNOp7kAyNL25T4+R3rEjEu14FGUch58li4AdS1MLGv/DlBNdhGmDhNm5vD4yWpnPwxsKJWaOs+DPVEd2XdXPvLFW8eOaIf6Uu9M6y2q9wslVAmHoi54Ze9idNVImDd3MKsPGYgJwz7sq4aDECGY+YxKiPHdWscjyQW6Nmpj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 06:55:59 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 06:55:59 +0000
Message-ID: <e0a87379-eb1c-b1d7-514e-5821e96e606f@amd.com>
Date:   Mon, 16 Jan 2023 12:29:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 08/19] ASoC: amd: ps: add soundwire dma driver dma ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-9-Vijendar.Mukunda@amd.com>
 <77e35f54-323e-42d0-9e74-be984eebc0fe@linux.intel.com>
 <6bb9b13c-2829-d7c3-872b-6e9586189300@amd.com>
 <3bb2114c-cd0c-f176-c837-90a665a25343@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <3bb2114c-cd0c-f176-c837-90a665a25343@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::8) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BY5PR12MB4869:EE_
X-MS-Office365-Filtering-Correlation-Id: a90b8513-3fca-4748-e8fb-08daf78eb906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8026kx9VifjoGPa+iivhqQoJVilC743GIy++K3rkcL3wbx2t3/9p3vCcbSUWltbttLITKDg2J1STfXRmKYR3KhoTKYiKe+aHD2X3gy+QNlkQrPcCbfDsP5ZaKB0nA6PtOxC41wO5NtjMwwlaMzzoac+OuGIHICuOeoHVkwl2ffnt/UBjn0+KPiKZRibuJLCwVoRUfL2gZMxciCizBlKsgOXZSB6azgu2/Kw3XApZrbWStxtiFY86qOfRGl4SG3jzEDgz7XYmnSBtaXAuNup11mIjTTbOCWBI/xDMVNf+mR/6cpIrWKaSJTzkXytdmFFzXbRVwKVMpjtOOMb90TazOHE0AzywYJAUk2CJGWx2IDYrK6Ab/kwhAJ+a+UN9UAn291nnbTFmCSqPtYi34rJjrRkoThw8UXdLW/PQDDhaM9AvawOopZftaD7QD88GJnbdnIdy/3uwPmBbzb2SBlF3WvVMTu8pdefLRJOGkcb1MddFL5/ZQ2X+XSKH2lhTATkU+fIJQcH00Bq8r6VZeHg/0O3Up10hjChOGsqgnJsHXWAv8lJXwh2KdZzkr5WIAIgwIjArLr73pHrzCdzs4d6e2p3NfJMjZskp8oeunqFYew+BMb9NdKvCvBceW3lj7WC3sLIQG+W5CbHrAHyUhz4lJz6MX+CFAiZyN3f95keQbAhosJYUdiyIunTBgylL1tyw/Sv0f0ySTK1l3MVoC/xl7JYgNuG6f/Ckpp7FjH+I2Sk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(366004)(136003)(376002)(396003)(451199015)(83380400001)(86362001)(8676002)(38100700002)(31696002)(5660300002)(2906002)(8936002)(66946007)(66476007)(4326008)(66556008)(41300700001)(6512007)(6506007)(186003)(26005)(2616005)(53546011)(6666004)(54906003)(316002)(478600001)(6486002)(31686004)(66899015)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhFZTlWQ0F1MnB4aitkeEZ6RDdrdU9LQlU3U1VqVStwVi9MTDlmZnUycjRY?=
 =?utf-8?B?dkNkRlliVmoyN0RrWExaQ08yTmtvcHBIQi9sU05Xcng5MmpPWEJmcnBZMzE1?=
 =?utf-8?B?UFVTaUdpQ3d1WHlIQVl6YXBVQ0drZ1BKeGtqc3gxVk1JR29RbjliN2pRbm90?=
 =?utf-8?B?VFZZYnp1ZEFMMmsycVc5ZzNsN0Y5dTJnM1YyVHVnZWFQMHl5OWg5T1kwNkQ5?=
 =?utf-8?B?RUFoaVdrNWtWSDFiMUZPNlJOR1J5MDJtcWpXaUNaUWFGRzdIdG9URXhaZzRR?=
 =?utf-8?B?UjVJS0FUSWY0aHdhcG53M093RVpFd0ZaaVdyRERPT3lZOEQrZGxVS1RmNnVX?=
 =?utf-8?B?MllDbVRxQ055YldHM2JDQ3JVdUxhenU1S0NFOVpyZ05vQlBKMEtxNENoQXBL?=
 =?utf-8?B?RkV0d0JqOEcxTjNGbjZOM2I5VXdGL1NwR0pzaVd2RjVRMlV4TmVuMW5ka2tS?=
 =?utf-8?B?eUpOaDhScTJMbHRYK3djeVFhQWo3eG1UMTRzYVFJaTVLUVptcEhsdGRnVEsw?=
 =?utf-8?B?Ymp1TVg4TnVaeGgrRXN0UG0rNk5CM0o5aUU4RXg2TUJNcmVHdDlZVlVCUUpw?=
 =?utf-8?B?dEtSTDhFSjJiZUF0WXdEZE5tQnorSnJiZmFTbUs0Z3pQQlpyVDFTNE1PU2JI?=
 =?utf-8?B?TTkyaC80TWp5WEcwS3NMT2p5VGZRQk9DU2tEUFBJTzZFMkMweG9tWFIyV2FW?=
 =?utf-8?B?aDd3TE4xbUJ2eVBBNzZWNzNsaW4xSTFaNENVb2l6cEZSZHNDclFSOW1tNXMz?=
 =?utf-8?B?MGEwTUxWV1g3MVpMVkVUV05hMHMxTENweXByMFhyTjlpdCtKMlRjR3d3Ny9M?=
 =?utf-8?B?RFdMcWJSVm0rcloyQTNQL2FMdDJjc1F1Ym04ejhjVTV3SzhvTUZjQXIxQkVJ?=
 =?utf-8?B?azJadVlvZ3FxcjhacElZTFRpcEdkYUZ6NFg0aVBlaTdYbnlES2VKTTM2b2k1?=
 =?utf-8?B?a0c5U1VOS3lMZStxS1pDcGpwWGdUbFVTanR6cWtTcWd3SGVCZVQ5aitWalg4?=
 =?utf-8?B?SXhsTHY1MXVsNU51dXlTbXZHNDNETFY3MkdTaTV3N2xnb01iNXpEVU5VSHND?=
 =?utf-8?B?ekhjSFlvTTJ1eUg2cTBVMTN3WFpvTjJvUGNxOGVFZ3ZxQ2VzS1d1YTFFTWdQ?=
 =?utf-8?B?VG1oU0NwNUJEL0hFZnpJdFNLeUQ3aTR4ckw5Um52b01VeVdzYlBLdnhjM2J3?=
 =?utf-8?B?QjVuakEweGVXLzJQMS9xT2kyQ1lzVUlzWXRpR2o5ckdOZlRCSXNEZGhvbGs0?=
 =?utf-8?B?bDYwMUxJTmRNQkM2OXE1bjhhUkZqYnUzcy83U3ZKTEI2Wm5UN0RhMENhK1JM?=
 =?utf-8?B?ZFRoV25TZ2t2RFplRUdBdnF0KzdJSU1MUDc1N0hJeG5sVXpNcW01SXFvRUZ3?=
 =?utf-8?B?Nmp1ZThjS2t1NWNYR1FQOHh6QzJEUEtBSXZoSTRVZkIwRGlIVjRnU3E0OExx?=
 =?utf-8?B?QW9WY2VQdWw1K0RHU3JDL0ZvSHArSitYNkVQTVMyQWdaMUJ1aUM1NjBSVVpP?=
 =?utf-8?B?VllLWGhCbjFJL24zeTQ1MXgvbk9EcW1iTnJKcEUvREYzN2dueDBpcmRzaUdC?=
 =?utf-8?B?Z3pSb0pWVnc0U1RGcjBub0F0UTNESE5hWUUwTk9tbDBuYW0zeE9rZkZucklk?=
 =?utf-8?B?TjNsVmlzK3IxZS9WL3YzNzFURXpRcDhENkFIYUd6N2owck55N0NtaEFibk5E?=
 =?utf-8?B?OGU1NUtDZUIrUnZaK2FMY2dDLzVPMHZvUW5FMFhCdXpIYmFyZGk5djJHaDlz?=
 =?utf-8?B?elhuTlhJVFJMOUxWSjQvREUweXVSZXBPS3JWNEVRWXZxR2wvU2JjK1FZVktz?=
 =?utf-8?B?amY3dEo2eGhEU3UrTE5VQ1k5OWNPdTJUbklYMTh2ZTY1OGFBZFVyU2JOM2lr?=
 =?utf-8?B?cGNaTXFocHdnY2diNkpLRjMzb05CMkNmWUpEdExwNktTdWFIYXN6enpJMWdx?=
 =?utf-8?B?RHBkc3FIQmZLWU5aa1ZlYlpnQUkxNkxVd1NEVy9nczluazl6TUxWTEVtL2Z1?=
 =?utf-8?B?YTUyMHJ4SktsYU5YVVRFT3d0UEtvZ1lnd1hCOU5sWkJxZWZYcWJLMVNtcWVY?=
 =?utf-8?B?OTlRVkdrc0hjdDBtOHRwY1NHcmlZeDRHRy9WNURJS3lLME1qK0RueFMxZ1hB?=
 =?utf-8?Q?cgz4qShIfnTKixCZOShfetUWC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90b8513-3fca-4748-e8fb-08daf78eb906
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 06:55:59.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hAWlDY5PjLMkycoJSvqiLLWYOl1FQffyb96DeqoHO7CN1b9DQIiC7TMtS7vhfE+1UGrEIw0FmuVTsqkA83krA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/23 22:35, Pierre-Louis Bossart wrote:
>>>> +	sdw_data->sdw_stream[stream_id] = substream;
>>>> +	size = params_buffer_bytes(params);
>>>> +	period_bytes = params_period_bytes(params);
>>>> +	sdw_stream_data->dma_addr = substream->runtime->dma_addr;
>>>> +	sdw_stream_data->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
>>>> +	acp63_config_dma(sdw_stream_data, stream_id);
>>>> +	ret = acp63_configure_sdw_ringbuffer(sdw_stream_data->acp_base, stream_id, size);
>>>> +	if (ret) {
>>>> +		dev_err(component->dev, "Invalid channel type\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>> +	switch (stream_id) {
>>>> +	case ACP_SDW_AUDIO_TX:
>>>> +		water_mark_size_reg = ACP_AUDIO_TX_INTR_WATERMARK_SIZE;
>>>> +		irq_mask = BIT(ACP_AUDIO_TX_THRESHOLD);
>>>> +		acp_ext_intr_cntl_reg = ACP_EXTERNAL_INTR_CNTL;
>>>> +		break;
>>> so there's ONE resource to deal with external codecs? How does this work
>>> if you have a headset codec and an amplifier?
>> Are you referring to playing a same stream over headset codec and
>> amplifier?
>> It's all about channel selection from DMA perspective.
>> We have tested speaker aggregation and headset playback use cases.
> No, I wasn't asking about playing the same content to different sinks.
>
> I was referring to playing/recording different content to/from different
> devices.
Yes , it's possible. We have tested parallel RX and TX streams.
Please refer patch 2 review comments reply.

For ex, speaker playback we are using Audio_TX Channel whereas for
Headset playback we are using Headset_Tx channel.
>
> Even when interfacing with a single device, there are interesting
> topologies in the SDCA spec that would require multiple DMA transfers
> conveying unrelated content (or processed content from the same source).
>

