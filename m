Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B225A682D50
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjAaNGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:06:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjAaNGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:06:40 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8BC656
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr/nsfryENXhzmtlve5aJewe0lSmCGDOkFeUpm5BWq04hAHsA78DqA7YkWBsZfwcaBZHb0mihr9gy26aAU4sk4rrfRmaKsTDHiZXI7q1N+12KH8aklVF1ykB4exsOt+Kd5MGYG01mDKKvXM3/ewf00u0FF2SzV4IjBG8+8IKQc16vFfxZx2Wg5VVZSigfTE3yrsKGbUCRFtIGfxC4WZiluZNqGH+gxMWBOCE6nkWB03wnxi38iFhPNJnKlRxUkMRgIi/40A+sQ+CWfHMpQUdaueqdPhMjrOJHrWiXahv1S6UD1/LHuyukUsy61StCH8+u4ODGxrD8BihViWHopS/pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reBLPJBu8aOUtKR0WlJDvXK0672ibZY1uiP2UzeS4dQ=;
 b=WufpXbyjgzrbLcLeJppTTCHoXsQI3KKtTfNtpJYBUBczEZrGyOqEEuIF5DBzlltRTLcFNPFv9MHJklh7IEBZDeYfglDIKodVWzU8AF2T2db7dlY7G8dr4YcBKJlERkM0NI7zi07yKOrbPxwUh1F2ezVFLVZsUmH/nVbjbhf3VyCt4wuHLNe9ZSd98gi83PT2sJ2bjRgiulzBJIoikKfRCqJbc6IcbqN6B1WDvQFYJDx17poNOJ6YNl09AGGCuQM/0gY3iM/OCCnWVIFOhlls9IgILshPwuacBONmi9TyLTqBXN07ssyOjWnSVwrP24A9hFq00bUNkp9HJ427+WJ8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reBLPJBu8aOUtKR0WlJDvXK0672ibZY1uiP2UzeS4dQ=;
 b=aySOM35rYSSA63uONwK6FmzC3mTKsx42HQmv1CsCRY+9QXgX5brKqRs0d3fUT73t2tnGioKBPpD+FVBvxkjbkOZY8TA8C7n2+W9iQFDCfb8SzXnT2E4HICGrIyWLvUVjIAy8nB8xr9+oqsFtmxEKClDF2DVc2g+23bH4iiuD22Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:06:36 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%6]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 13:06:36 +0000
Message-ID: <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
Date:   Tue, 31 Jan 2023 18:39:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
Content-Language: en-US
In-Reply-To: <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fc3761-c390-470f-3ddd-08db038bfbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/5ZtE+5WdxYVQx9pI/wmO4P1qh+LNFuR6uucKtKFSq7SsXJ+9a3Lma+p8Iky48t765Zvb6lW42+pTR/r7/1D93qEN8BAk3r5uHIL7JqiCyu8FL64ZNr2NDQhT1PDbIf7srqqW6ltLPRZu7IpJF/cKA56wZdsf7lsk85o6pGFapiQy9Wp+DDHlI4c1FMFihLQHahdmiBzFJFeOT1Gyhyrv6KHcRsdmkUwvXiLkpTl+nV23i85qLz+FZ7goM3EJNcojw6g+KA650r3A8qtq9m21mwYVvgOHrScY7GLZOrQ6PjfG/TJnT2hzLwGeZ4jnysygrzxG5dLMjum57xqk5M8hTW5ssQPFwoqo7+qgX/NpNNJlY8IFCbT5Bzno74IMKPDYlD92PVnGW7xU5u0dFFigXaDUlySRxUfGgzarzrnaXjwGreD7BCdscxvXpMyyGhWGdZ5pRcF2V/6v40eEDMMkqr+WlxpLZFcyQHW3cUhlFM1AmuJ29IVVmTuJkol8h+xGIi7vUrsYU+P45uswRA1228+UiAb5bqClg+I8x72cs3X7wTj3k7UhGP3eoI9Jnhb9Bc5ZJiA331T4mvgAIzfEoHwoESpr+bs+caw0WOzoQaYU+vhpwWQufjLRpI7DRGzkgwJqiicrq+euXzMQgQ2zU4iHN6XpnUl3O/rGXrkxffxLWB8Q1flMPWMc3tTECVnxFPqo7e1zG7Wr9tsz3z28QqCF/1t7r4rroi1ap6hFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199018)(6506007)(7416002)(5660300002)(54906003)(6486002)(316002)(38100700002)(2616005)(36756003)(6512007)(186003)(26005)(6666004)(41300700001)(8936002)(4326008)(83380400001)(31696002)(66476007)(8676002)(53546011)(66946007)(478600001)(66556008)(86362001)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0ZkZHQzR3M1Wmd2ZGV6L3l4RFZSWjhqSzgvUncrLzBlU1h2S3hPelRYc3Uv?=
 =?utf-8?B?L1JzR2VJeWtZQ0FZeW1VaUVzRlorcTdkcnYwUk5RaERFS3QyNWhxWm1WcmlX?=
 =?utf-8?B?RGtWSmhlbFA2L0dpMGpFTWJZNHVZYTZhdURuMU02czkycjdwSmF2YU5Ja3RY?=
 =?utf-8?B?NnFqN2tUMFl6bXJEdTRhNVdJSHh2Znh6THpaMmNXWU1sNFFWVUV0b2hTaDEy?=
 =?utf-8?B?ZmFpeGM1NlZZSjNKamdZdjllMUFFMVBRbWdMNTl0ajFvUG80SEZYVXdOa2F5?=
 =?utf-8?B?TERTdWZWQjZvQVYyekNscDRFUDdVc0VWbnkxQUZVYmN5RnliTjFhY2tEbTNO?=
 =?utf-8?B?emdIUXlKaFkxQ2FVUmc2N1FkQUQzQlhKWHdtdm1XMlArVXkyZVdneE5tdHBr?=
 =?utf-8?B?K3RYYzFqM2QwKzd4WE9ONmdPVndiUEdmMDJOaTM5NzNzd0kxYTlsR3VGRzZK?=
 =?utf-8?B?aHBrSXVaRENvQ2V0U0o3elVjcXAzeWNBVDBJM1R2NlVPOENJQ2tiVS8yZ3U1?=
 =?utf-8?B?RnVubXVNbzhoNTZrUDVsVWpmZ3g3dWZBaVh6NGl6ZmxoTFB0bVJ1VGNyeWFM?=
 =?utf-8?B?VTRYcWN3aDBiL2FIb3BjTDNQZmFDbkVnc21XdTV0b09oN1NZVkErWnFUQW05?=
 =?utf-8?B?UHY2UzRHVHY3R2xoUGNvdEUzai90Y2lOWnRXVEYrSnh3V21MT1RMbkx5ZGM1?=
 =?utf-8?B?Q1lvZHBzT0FlSm51eUxIODlhM2U4Yk9TcCtCYi9BWGo5NFpQVTR1QStjeU1x?=
 =?utf-8?B?L3M2dmtsc2tSTW9ISW1Bb0dKOFU4UUdCcVBKTUhIejJEbUFUak80Q2hBc1Rx?=
 =?utf-8?B?OCtiSkFzQUNpN3dxdjMydEMzZkY0a0tvTEJrMTN0b3FsY1BES3RTUFQraHQ0?=
 =?utf-8?B?a2tobm1oekw3Rk9DaytEcXg2R2VvaHJURmp1L2JYVUNWOUxWd1pNVW4xcEdI?=
 =?utf-8?B?ZmRydTFBWFY2TDhscTBIT1ZFOTd2bTVORTFpTGZ2MnBBZnpOK0xlcWREZ0dU?=
 =?utf-8?B?Y204MG1seXhoeStWUm1VT2hxRkZCUHM0dk84NFdwMHJVK1FRbDA4QzJmZjVr?=
 =?utf-8?B?Z1Jpck1GM0ErcHdlTWVUYzJtMktyREhQbVRTbTR0c1Zmb3hJNEExazFVTVBC?=
 =?utf-8?B?ZFZweGRYaDEvWkUySXZRaFFxcjhneFVIMkhiNEFGeHZEYlJkcEFVS1BVMFJK?=
 =?utf-8?B?b2dFT0VuMmRPU3NRL0RNUFdOZ2lKMU9ZOHFlOXhNcGlUWnpWUUxGdVlTL081?=
 =?utf-8?B?Nm1WcG42VnNxUHo4UjRmNGNrUGxFNWdMcEJva2s3azM0UVIxQVRTeFBWK202?=
 =?utf-8?B?V2RJN3NGT2RwQkkxUzNtaURWNkdKdFhDV3d0Q0kxTWNhMGxLR2IxVTBGM0Zh?=
 =?utf-8?B?RFVsbWw2N3dYYUlRZ0p6TndEU2p6REhHYlAvNU02VHh5eTR5WVllRWFPREps?=
 =?utf-8?B?ZjlQeTRPV2V3MHFSRjBZZG5VUUVldEM2WDRkdHVXVCt2TG40ZXVxckMrWGR6?=
 =?utf-8?B?d0UyNlozMnRQZ0R0TVhISEVCc1pqbUVPZUEvcTVhZEl6VDY0cTBQOW5oOUtz?=
 =?utf-8?B?QTVPL1l3K3E2Vjc5cWY2YVorZVRFWXVmVHBDNnRwZ1lweC9qaHBxay83Si92?=
 =?utf-8?B?VHFkOUh6bDQ1aE9ObzhPajA5UDB0bThBbE4wVzBub2lKZlRuZDk1UWtHRCt6?=
 =?utf-8?B?UzBDWWhmS0R0K25aMEZMZGwvUE40bE9iZlo0UGo3aHhoRDg0STF5WWxoVitk?=
 =?utf-8?B?YkVzN0dEOVVJTjdGelc3M0c0YW9BaHFSOTMzcmt4RW15Q1laWEZ0RzNvNTB5?=
 =?utf-8?B?cE91VysxdXcrejc4dUxVTTIwWTdJOVg4dFJlRW5VYm5tYU96MVFBdnVDbTZs?=
 =?utf-8?B?SjNUekVyWFlnelBFYUYrOWpjS29FYzhXeklJNFpkV1kvVy84eHphRklJOTM0?=
 =?utf-8?B?OW82YmpId29TVkRsT3lmekxEZXB3V3R6cUZSaFBHYXJoWVM0bDBiUEJOSy9O?=
 =?utf-8?B?eVZxVDU3dk5VRmhCTnV1eVA4dG9MMk5najk5VmlYVXk3dDAxRlc1Q29zUm1a?=
 =?utf-8?B?VHRMVWhJeVBONVorcE95bnZkV1lUK2JhaldzTnFtZk9NV1dheDN4SzROWWZ3?=
 =?utf-8?Q?uY0swth+r3jLsAhFEzck5G855?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fc3761-c390-470f-3ddd-08db038bfbb3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:06:36.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a26wSPjVSCuWEdgFXe/egbgneK8I9wY7iqzh5BGb+p7SdnGWB9yFS6pb0bW7ZQpJk+ZtUD7YDqEMjporPfAOWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/23 13:32, Mukunda,Vijendar wrote:
> On 13/01/23 22:41, Pierre-Louis Bossart wrote:
>>>>> +		if (is_dmic_dev && is_sdw_dev) {
>>>>> +			switch (acp_data->sdw_master_count) {
>>>>> +			case 1:
>>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>>> +				acp_data->pdev_count = ACP63_SDW0_PDM_MODE_DEVS;
>>>>> +				break;
>>>>> +			case 2:
>>>>> +				acp_data->pdev_mask = ACP63_SDW_PDM_DEV_MASK;
>>>>> +				acp_data->pdev_count = ACP63_SDW0_SDW1_PDM_MODE_DEVS;
>>>>> +				break;
>>>> so the cover letter is indeed wrong and confuses two controllers for two
>>>> managers.
>>> ACP IP has two independent manager instances driven by separate controller
>>> each which are connected in different power domains.
>>>
>>> we should create two separate ACPI companion devices for separate
>>> manager instance.  Currently we have limitations with BIOS.
>>> we are going with single ACPI companion device.
>>> We will update the changes later.
>> Humm, this is tricky. The BIOS interface isn't something that can be
>> changed at will on the kernel side, you'd have to maintain two solutions
>> with a means to detect which one to use.
>>
>> Or is this is a temporary issue on development devices, then that part
>> should probably not be upstreamed.
> It's a temporary issue on development devices.
> We had discussion with Windows dev team and BIOS team.
> They have agreed to modify ACPI companion device logic.
> We will update the two companion devices logic for two manager
> instances in V2 version.
After experimenting, two ACPI companion devices approach,
we got an update from Windows team, there is a limitation
on windows stack. For current platform, we can't proceed
with two ACPI companion devices.

Even on Linux side, if we create two ACPI companion devices
followed by creating a single soundwire manager instance per
Soundwire controller, we have observed an issue in a scenario,
where similar codec parts(UID are also same) are connected on
both soundwire manager instances.

As per MIPI Disco spec, for single link controllers Link ID should
be set to zero.
If we use Link ID as zero, for the soundwire manager which is on
the second soundwire controller ACPI device scope, then soundwire
framework is not allowing to create peripheral device node as its
duplicate one.

If we want to support two ACPI companion device approach
on our future platforms, how to proceed?
>
>

