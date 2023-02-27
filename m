Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551656A4948
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjB0SJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjB0SJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:09:23 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9766D7D88
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:08:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2g+F/vQzdXQr9bUAnqDL4XjPv4zA6gLWARXddPTadDRrcO2znR9bfWPrpwHw6vlHHoW/M8FMSaTMChhHRxTWf9dqEQf8qsayiCSDp473LT/iyOI4UEUkg6Tk8njRYBoIggu+JQ7kOKDjx3w/NbdbNaDoZ9SB6ULDISxg+OEBGisLDab9FxGknI+f0RIQDnsM6i0BV0cEAClYoDhQD1/u589xUDDf0TTbBDGpfFc8t7MdQfjIO830xo/Iw3qDiYhejyUDEuZwkOVUvAF+ZfbdVfX8T4JX1U5CPc8CkrnTb0mrVI+VUtBwZjAadpmNDIazycTrmo8r+4lLkVB5gHSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u3ET0I8uktnQCkKSRJhnWA572cH5ff5DxgYHlsIj+I=;
 b=jGwew2WGHlElPN/W2awfF/sdusJ2Rcc9D14QcHVv7hGE5V2wSu3mfK7wxtfVKYpCnZA+03xrHOMTwJEfjwNrJ9bLsAb8USoo2NHn4gMUZqo4S2LZxaWU7GN7LnoZKR7pKChbYWeXLbTMXSHNxiBaTSORPKUITpNwaaQNTcGrSCmAsTDQinbGZnv85zpD4+YN7J7KGTN8EYt8lg0y0BjpVzzbQ7mLHTvWxjR0YBD0ALeGgOrWw/CPO1UqzsVpF7pvxGjDKpLOB1vxGR9VgeIhk0yICSxls/UMzKj7DWBev80FZvzvEZjLVJenpTPqbtnwGNxgbNnXqEXAmSY0Vh+lLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u3ET0I8uktnQCkKSRJhnWA572cH5ff5DxgYHlsIj+I=;
 b=z+39X6IPL0PoXcfoF6k8BWak2hMGROMU3j707Rxe0w+4y4/HGUtGpp6DChYdHzvPjF7dvbkfTVReZDNK3ejCg/3PK+1vT8h1Xw5KbCCwYzh5JJWGGD3tyf1pGB6826oj/0vwaaAHni38A1cygk2bAX/iuMwFenW6WBC07nrMeVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN6PR12MB8513.namprd12.prod.outlook.com (2603:10b6:208:472::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 18:08:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 18:08:48 +0000
Message-ID: <26e1ce6d-05f9-a38f-8af9-666fb5f5406c@amd.com>
Date:   Mon, 27 Feb 2023 12:08:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V4 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, amadeuszx.slawinski@linux.intel.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230227154801.50319-1-Vijendar.Mukunda@amd.com>
 <20230227154801.50319-3-Vijendar.Mukunda@amd.com>
 <606c1b31-d83e-6ef0-8b01-45e7e0be4cbc@linux.intel.com>
 <ff01e54f-72e2-8baf-ac31-3c249002e3d5@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ff01e54f-72e2-8baf-ac31-3c249002e3d5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0091.namprd06.prod.outlook.com
 (2603:10b6:5:336::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afccd35-1c74-438a-6f26-08db18edac1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jm93SLNhykcoCik/luxajFfhvn9ZHdBUfk1RNanMDRzO0AN3eAxavl4r8FTvaa0w+0jZ4MaJ6+dWGtOeelEMD03QnIbLp4KZxxxLFMsk61HgOHnqOqvgJRPIReO1BgcGpIRFkPi/vIcr9IXRXwNXYVGM2sNAZ50Vm1tBf29/edmuiijFPAiynT5OJbO8hBkD8Fr9ylXglpcjweshUwKnQNqE5u3b5NHacmcwdYF1f35ujzO/tJ7EJB81TfcQ3W+PW0lKaIqLuNFQEh6gGzJp6Xkqhk/vu5v5NpHGHcMjAKXIRGCYi+A4ig7n9ki89Xdt5XJhE7F/HnvyN1l5o9J+Wi5JUExlD/Y58eCk2G7rFCoSopdhWbSXagkRSP/9qc0fYrijaUEKibhWPkQjpsrPIJNW/TsChn582S4AG1mev7sj0VmeRpqDxttwIN0CkUOeshfy9lq86DyNCVmZxxy3RId/Gjip1anWdD8zwHdDoX2chTDnvvLNiNKALagG4XZ8qSvJKgGaXAkyHI5reYd6cOaIzUjcE1t19Hu7MRwiQ6M2F4MSI2f2u6u0IegngHXdFXGtCGbChhFf39hSJSp5fWFY/Hl8jBJ1FA4G5pNYLrUz2bNYF6913+G/atu+z3UpW6rEbyYljQGU8xYdD0jR0b5ab9urc98EA5ezc4ABY/cCCoJoUnh7xkb06yZTMOhDFKmIz+YP9mOu1fDigDCQOObOPK1dMgVIKe7lxQOBh1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199018)(36756003)(54906003)(110136005)(316002)(83380400001)(6486002)(6666004)(2616005)(6506007)(6512007)(53546011)(478600001)(186003)(2906002)(8936002)(86362001)(41300700001)(66556008)(5660300002)(31696002)(44832011)(66946007)(66476007)(8676002)(38100700002)(4326008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStFd0xHNitjOU9lb09vckgwc3ZMdVd1SjNwZFllWDZjVTZxcUYybWozUlR4?=
 =?utf-8?B?VXN0T1lpOElxc0wxb3MyTGVnNmhTa1UxK0YxN2U4Zyszc255Q0NXN2dTalhh?=
 =?utf-8?B?Q1JCRmh4T0ZjK3NFdDRIRks3bTZ2eFpQaENsaFd1ejJKejQydTNVTURScHdS?=
 =?utf-8?B?SlpDb24rYjhmVUJXek01aDBLR0lHZDRCS0FFZFgxTDZtdk0vazdiaXpKbC84?=
 =?utf-8?B?VUxZYjVQR0RlN3J2M3R5UjlvcWpBSytHTDVVYjc2WC9KeFBWdDBXa3hwTFlF?=
 =?utf-8?B?QjFDT3ExamZCRCtEYUV2azlJZnYvVmtXZE5uVmdMT1Vwa0RISjNXSjZwVzhE?=
 =?utf-8?B?NzhsM0hPd2JRalFpWURuenBBNE9uWUY1QlgvUFluWU9Pam1SV0t4MGM3ZTRr?=
 =?utf-8?B?YXNPcVlNbjNrejcyTXdBSmlCZG1USnhqdU5QRnI2M1JuUU5iR0NJVkxvVS9Q?=
 =?utf-8?B?QzYxNFlkSlpjd0ZqZEE1VXVhWXRGVUQxbVpNY2hSMjErdFN3UENJWGllZnJO?=
 =?utf-8?B?NnVuTXhFR1lhRlNnN2c0MW5GbkVUZHNiWUtaL0dLR2MzeUJjVXVTRmRxMVBu?=
 =?utf-8?B?THJodzZqU0xXd1RQUTdnOGltSm1ucFRLUllyaG1iSURIN2N1aUpDdTd5UjlG?=
 =?utf-8?B?VU1MSTFrMDA1VjFGVWhkYzhMeHU1bzZGZnREcEJtclkwYTJZUllhTUJ6Vkti?=
 =?utf-8?B?ZDAyK0E1aENiQjRVMDNJQzRqdmFkRjVtTjlzL3lJdGV4d1FQSzczb0trQ1oy?=
 =?utf-8?B?aDk1cndlRS8wZ0FMQVU5SGNtQ0NDbFBqOUxndmFDeU9qR1BmZlJNY0NYQ2ZT?=
 =?utf-8?B?VzZHanJKQWFOR0VCeXEwZ1VpN01wT20yazF4VzB0ZWo0RFZhMjFqcVUrdkNu?=
 =?utf-8?B?VGdaOTZKN0ViZGNrSnIyTlNqYlJ2L1dzcHovaFp0eGp0VVJIb3pTSC9MZEFl?=
 =?utf-8?B?V2pERHkvR0Z2bzErdXN0am1ML2xySklGY1FoN3hyZDY4SmsxMkpnZGsvdVN5?=
 =?utf-8?B?SU8xT0hZMjduUTUyYVlqZVlxblowemlFTXdmNnNyVkxvUEJndTJwaGtxblRW?=
 =?utf-8?B?V2s2NDRRaWJ3UmEwbW9Lc081NjMzSDBYamkxY216RXIvN3oyZXlQbVR3aTJt?=
 =?utf-8?B?ckVaQkl5Q0lpZWZld1pDR01hVVoxRmp0bDVKRFlaVFIzRS9YWGVxa3pYNHNk?=
 =?utf-8?B?SXYzcW5mRzRLNnptMzYwb1lrSnFSN1kzQUhOY2ZlMzRJSVJkNTF1MWtBeEdz?=
 =?utf-8?B?NmVib01OQzBkUEw1RnB4Sm1zT0VYWGZidTVtZGpieWgyaTBPaEZ2bnVORTRh?=
 =?utf-8?B?V2dBQkR3dmpEWmdRL2pWWFM2bnF4aFRaSVV5QnR3MFYzdUlKZ2dzQ1g3czRx?=
 =?utf-8?B?ZFNHODJhVGwxQzR6NGxoMTBNNG9OV0tLeG95RncybEh1WjN2MFhoZkZXMVB6?=
 =?utf-8?B?N3VhT1I5ZGZDS29MaWNHbm5hcDFsU3NTaGxHQ2ZJTjJjSTZOSWpkQndNazdk?=
 =?utf-8?B?YjlnSlB5cDU1NWtPdWZ6VFJOT3FsY2VhcXNMWXozRnBLODhHUzErelZSNi82?=
 =?utf-8?B?UWY4aitReU5WeDVQZHBXSjAvY0xLL1dOU1JOWFVGZ1NZeWtYcWFVandiUXZt?=
 =?utf-8?B?bWZNa3VLVk1aUlNmNlZZSWxXWkRmbFNhd3o3bEVBeGFSWjc3V2xWWlUxUFN2?=
 =?utf-8?B?K3YybEc4Qm1mVEVSOGJiWEtmdDk2V3dXZEdpcTk1azByV0h2ZVpSNStBNWZC?=
 =?utf-8?B?N0t0QVdpYkRRaUptNW92cXB2Z09laUxkWkl3V3NCRGdwL3pGSjcxTCs4SmpT?=
 =?utf-8?B?TnBtZmtkMGtvcnZZSUhIc3ExMmpTV3NyM0JHZ0Y0UmZVQURxSWo3cWRNcDg0?=
 =?utf-8?B?eHJ5MDdNOWVwakJIUE1qdDJ3bWU4dHpYUFhHSFMyZjdtVVFrSTV6QWkxRGdP?=
 =?utf-8?B?eHMwYnMvQ084Qm56M0hhSzRDZGZxQU0vczI3MWRBNXdhdE9MamJrNktWalZ4?=
 =?utf-8?B?OW5wZ2dtek96QUhzWWRnS0t6bCs4MTdQYVpPQXUxTzhGV0NJbmtxNjVZWmk5?=
 =?utf-8?B?SHNuNWxpMUlrcUNJSTNXMitBV2xYbllweHJ3VmI1M0JyWEFJVWs1WEkrejAy?=
 =?utf-8?B?dEpmSTZTV1ViS1U2QmxWaTJ6bTV0MVk2d0NkVXA0bWk1a3BoTUNkTmJYeHp2?=
 =?utf-8?Q?Pk8lXAD9GlfXrSDSIZbvQNuF5NmxXl3FnIHtTGhSJbBk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afccd35-1c74-438a-6f26-08db18edac1d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 18:08:47.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83ZH+YbSdStcDQ2OteSdqoF52VrNFWNs6NsiF76c4xVhmsqP7Arg3coeVxUbtndaotunSVZsl23Z18UimuiJow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 12:08, Mukunda,Vijendar wrote:
> On 27/02/23 22:05, Pierre-Louis Bossart wrote:
>>
>> On 2/27/23 10:47, Vijendar Mukunda wrote:
>>> AMD ACP(v6.x) IP block has two SoundWire manager devices.
>>> Add support for
>>>    - Manager driver probe & remove sequence
>>>    - Helper functions to enable/disable interrupts,
>>>      Initialize sdw manager, enable sdw pads
>>>    - Manager driver sdw_master_ops & port_ops callbacks
>>>
>>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>>> ---
>>>   drivers/soundwire/amd_manager.c   | 749 ++++++++++++++++++++++++++++++
>>>   drivers/soundwire/amd_manager.h   | 252 ++++++++++
>>>   include/linux/soundwire/sdw_amd.h |  67 +++
>>>   3 files changed, 1068 insertions(+)
>>>   create mode 100644 drivers/soundwire/amd_manager.c
>>>   create mode 100644 drivers/soundwire/amd_manager.h
>>>   create mode 100644 include/linux/soundwire/sdw_amd.h
>>>
>>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>>> new file mode 100644
>>> index 000000000000..63cd8d066602
>>> --- /dev/null
>>> +++ b/drivers/soundwire/amd_manager.c
>>> @@ -0,0 +1,749 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * SoundWire AMD Manager driver
>>> + *
>>> + * Copyright 2023 Advanced Micro Devices, Inc.
>>> + */
>>> +
>>> +#include <linux/completion.h>
>>> +#include <linux/device.h>
>>> +#include <linux/io.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/soundwire/sdw.h>
>>> +#include <linux/soundwire/sdw_registers.h>
>>> +#include <linux/wait.h>
>>> +#include <sound/pcm_params.h>
>>> +#include <sound/soc.h>
>>> +#include "bus.h"
>>> +#include "amd_manager.h"
>>> +
>>> +#define DRV_NAME "amd_sdw_manager"
>>> +
>>> +#define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
>>> +
>>> +static void amd_enable_sdw_pads(struct amd_sdw_manager *amd_manager)
>>> +{
>>> +	u32 sw_pad_pulldown_val;
>>> +	u32 val;
>>> +
>>> +	mutex_lock(amd_manager->acp_sdw_lock);
>>> +	val = acp_reg_readl(amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>>> +	val |= amd_manager->reg_mask->sw_pad_enable_mask;
>>> +	acp_reg_writel(val, amd_manager->acp_mmio + ACP_SW_PAD_KEEPER_EN);
>>> +	usleep_range(1000, 1500);
>>> +
>>> +	sw_pad_pulldown_val = acp_reg_readl(amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>>> +	sw_pad_pulldown_val &= amd_manager->reg_mask->sw_pad_pulldown_mask;
>>> +	acp_reg_writel(sw_pad_pulldown_val, amd_manager->acp_mmio + ACP_PAD_PULLDOWN_CTRL);
>>> +	mutex_unlock(amd_manager->acp_sdw_lock);
>>> +}
>>> +
>>> +static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
>>> +{
>>> +	u32 val;
>>> +	u32 timeout = 0;
>>> +	u32 retry_count = 0;
>>> +
>>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>>> +	do {
>>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>>> +		if (val)
>>> +			break;
>>> +		usleep_range(10, 20);
>>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>>> +
>>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>>> +		return -ETIMEDOUT;
>>> +
>>> +	/* SoundWire manager bus reset */
>>> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>>> +	while (!(val & AMD_SDW_BUS_RESET_DONE)) {
>>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>>> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
>>> +			break;
>>> +		usleep_range(1, 5);
>>> +		timeout++;
>>> +	}
>>> +	if (timeout > AMD_DELAY_LOOP_ITERATION)
>>> +		return -ETIMEDOUT;
>> nit-pick: add a new line here since you're starting a different sequence.
>>
> will fix it.
>>> +	timeout = 0;
>>> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>>> +	val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>>> +	while (val) {
>>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_BUS_RESET_CTRL);
>>> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
>>> +			break;
>>> +		usleep_range(1, 5);
>>> +		timeout++;
>>> +	}
>>> +	if (timeout > AMD_DELAY_LOOP_ITERATION) {
>>> +		dev_err(amd_manager->dev, "Failed to reset SoundWire manager instance%d\n",
>>> +			amd_manager->instance);
>>> +		return -ETIMEDOUT;
>>> +	}
>> and same here, this is a new sequence starting here so a newline would help
> will fix it.
>>> +	retry_count = 0;
>>> +	acp_reg_writel(AMD_SDW_DISABLE, amd_manager->mmio + ACP_SW_EN);
>>> +	do {
>>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>>> +		if (!val)
>>> +			break;
>>> +		usleep_range(10, 20);
>>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>>> +
>>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>>> +		return -ETIMEDOUT;
>>> +	return 0;
>>> +}
>>> +
>>> +static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
>>> +{
>>> +	u32 val;
>>> +	u32 retry_count = 0;
>>> +
>>> +	acp_reg_writel(AMD_SDW_ENABLE, amd_manager->mmio + ACP_SW_EN);
>>> +	do {
>>> +		val = acp_reg_readl(amd_manager->mmio + ACP_SW_EN_STATUS);
>>> +		if (val)
>>> +			break;
>>> +		usleep_range(10, 20);
>>> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
>>> +
>>> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
>>> +		return -ETIMEDOUT;
>>> +	return 0;
>>> +}
>>> +static void amd_sdw_ctl_word_prep(u32 *low_word, u32 *high_word, u32 cmd_type,
>>> +				  struct sdw_msg *msg, int cmd_offset)
>>> +{
>>> +	u32 low_data = 0, high_data;
>>> +	u16 addr;
>>> +	u8 addr_high, addr_low;
>>> +	u8 data = 0;
>> nit-pick: this looks a bit messy, usually it's simpler to have
>> initialized variables on separate lines. If you keep the low and high on
>> the same line, then at least use the same order.
> will fix it.
>>> +
>>> +	addr = msg->addr + cmd_offset;
>>> +	addr_high = (addr & 0xFF00) >> 8;
>>> +	addr_low = addr & 0xFF;
>>> +
>>> +	if (cmd_type == AMD_SDW_CMD_WRITE)
>>> +		data = msg->buf[cmd_offset];
>>> +
>>> +	high_data = FIELD_PREP(AMD_SDW_MCP_CMD_DEV_ADDR, msg->dev_num);
>>> +	high_data |= FIELD_PREP(AMD_SDW_MCP_CMD_COMMAND, cmd_type);
>>> +	high_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_HIGH, addr_high);
>>> +	low_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_ADDR_LOW, addr_low);
>>> +	low_data |= FIELD_PREP(AMD_SDW_MCP_CMD_REG_DATA, data);
>>> +
>>> +	*high_word = high_data;
>>> +	*low_word = low_data;
>>> +}
>>> +
>>> +static u64 amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lword, u32 uword)
>>> +{
>>> +	u64 resp;
>>> +	u32 resp_lower, resp_high;
>> nit-pick: resp_low? you seem to use this low/high pattern in a number of
>> places.
> will fix it.
>>> +	u32 sts;
>>> +	u32 timeout = 0;
>>> +
>>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	while (sts & AMD_SDW_IMM_CMD_BUSY) {
>>> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
>>> +			dev_err(amd_manager->dev, "SDW%x previous cmd status clear failed\n",
>>> +				amd_manager->instance);
>>> +			return -ETIMEDOUT;
>>> +		}
>>> +		usleep_range(5, 10);
>>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	}
>>> +
>>> +	timeout = 0;
>>> +	if (sts & AMD_SDW_IMM_RES_VALID) {
>>> +		dev_err(amd_manager->dev, "SDW%x manager is in bad state\n", amd_manager->instance);
>>> +		acp_reg_writel(0x00, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	}
>>> +	acp_reg_writel(uword, amd_manager->mmio + ACP_SW_IMM_CMD_UPPER_WORD);
>>> +	acp_reg_writel(lword, amd_manager->mmio + ACP_SW_IMM_CMD_LOWER_QWORD);
>>> +
>>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	while (!(sts & AMD_SDW_IMM_RES_VALID)) {
>>> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
>>> +			dev_err(amd_manager->dev, "SDW%x cmd response timeout occurred\n",
>>> +				amd_manager->instance);
>>> +			return -ETIMEDOUT;
>>> +		}
>>> +		usleep_range(5, 10);
>>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	}
>>> +	resp_high = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_UPPER_WORD);
>>> +	resp_lower = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_RESP_LOWER_QWORD);
>> nit-pick: newline here.
> will fix it.
>>> +	timeout = 0;
>>> +	acp_reg_writel(AMD_SDW_IMM_RES_VALID, amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	while ((sts & AMD_SDW_IMM_RES_VALID)) {
>>> +		if (timeout++ > AMD_SDW_RETRY_COUNT) {
>>> +			dev_err(amd_manager->dev, "SDW%x cmd status retry failed\n",
>>> +				amd_manager->instance);
>>> +			return -ETIMEDOUT;
>>> +		}
>>> +		usleep_range(5, 10);
>>> +		sts = acp_reg_readl(amd_manager->mmio + ACP_SW_IMM_CMD_STS);
>>> +	}
>>> +	resp = resp_high;
>>> +	resp = (resp << 32) | resp_lower;
>>> +	return resp;
>>> +}
>>> +static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
>>> +				      int cmd, int cmd_offset)
>>> +{
>>> +	u64 response;
>>> +	u32 uword = 0, lword = 0;
>> couldn't figure out what uword and lword refer to. Is this high/low as
>> above or something else?
> its high and low. Register naming convention uses
> upper word and lower word. will use naming convention
> throughout the code.

While fixing it, it would be good to start off the code with reverse 
xmas tree everywhere too.

>>> +
>>> +	amd_sdw_ctl_word_prep(&lword, &uword, cmd, msg, cmd_offset);
>>> +	response = amd_sdw_send_cmd_get_resp(amd_manager, lword, uword);
>>> +	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
>>> +}
> 

