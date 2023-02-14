Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA6F696F35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 22:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjBNVWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 16:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBNVWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:22:13 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EFE9E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 13:22:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Br2243dD4FU/UbIGlUQq3gfAMRBx8/KvU1zeZo3EUpful/VIceOv2nWpHeLzrpuy88Bq2wFLxGqjBDVKM7VCH9qPpbhWAWHl1RvrBahHTrMil4inY/5Z+0JNjecTQTO1uiveL8D/0HikCMr2/iB5WRHc1yF7OcArd5Gwz0vtu+2hlKncknfnsxLqI5I3gj4qqhckw8BF/hj+Q29USO6r1CygP6+IzRAY1/Srg4YjVnc5Qgxe8ntobdoQ71r6/sAqZBnT9IQVlnQ7XGO6mGUXVMjIQ9Rlo0sWtOS7jOXkkQ4e1DP0PHk7ItmNia1m2F1myLrc7QpRbEgDNEcPZfh2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk1c97WWbsiX+f6ZN5k4sSZSQFnjFSVJ5hVX7ClACeQ=;
 b=bDl3VIqDs00C1+D0oFt7rHFOMBzNmUY6NsXXdgL3aMGTQ1s4BeN/s0x5fUiUKaQ6tGSPix63uaelUEf9PPwLqk11pmB+ASZTCgNjroXVE0fFtnJ8QyDohXUbKAy584LyHFO0Ip8qL2ROoGPZvN7If9LXikQxDwbpDhT1f4Hys6+IeSEcdtDbdw9dudQ601tVGn7tkRY+KnVkpfqm9CF6P5KsBNupIAEjeASbDTxaLIS/vWVRooXnVytSwHgykqV5Q+qWo7JvsOxUVSZjS4gRkN3KduwagkF2874H+sICHU+gBOK6AmW1KLwkY3aihZJmnkjwt+/2SpoNWPH6kXmiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk1c97WWbsiX+f6ZN5k4sSZSQFnjFSVJ5hVX7ClACeQ=;
 b=paxwZCh+prSMvtxj1HOSxD/HCPKh2nqAsdeqnpnBHSOgw23EHIOh45gC4PXbJWsvNQ10wE7AQSMpsexIGfrcVyt1egNTZhHrZJ7gYpdwvZfCZhMspqBxTROV3bN9mrzyx5MEi2w4kZ4b7UjCT+B5ULKkU7BcmwsMOq2GMKXnMQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 21:22:06 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 21:22:06 +0000
Message-ID: <7de3c5bf-8386-5d6e-bb64-2cf86a2bdede@amd.com>
Date:   Wed, 15 Feb 2023 02:54:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 7/8] soundwire: amd: handle soundwire wake enable
 interrupt
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-8-Vijendar.Mukunda@amd.com>
 <cd70a91c-231e-1bca-b0ac-4041cba0daad@linux.intel.com>
 <586a9f58-f660-1ac0-0506-91362b25f75d@amd.com>
 <e32e9508-9c91-b8ab-c862-b861aca8c02c@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <e32e9508-9c91-b8ab-c862-b861aca8c02c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::16) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bf3c6e8-9fe6-424b-1ef6-08db0ed185f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbHBM7Krlaq8H1e3MutLwkj9/MBktO3ja00ZKVY+4BYd51RztM64imoWJ17w3fcW14imU604w2avFxMhQ620YIbUtMCcX5JIjTy8bHTyzPF519sNoP8MBH4VHM0ysbKg/Oq/R0bYvl4LSCVroJB0XDbbXef4w5c/2RTMknYZww47C6FZEUT+HnY3xlQ/fI0hHzN4+Qv/at8roVgFkSAS5IRDNVPsU5kTWAvoI2QmZE3LNQL2Rrs9pwjb4IMJQT0yEXoJbc7nB3bhG7LVFuxoC2s/znR/C7/27/Sp+hc+3z3MCYh9xeYe79KXWp2emhexI+yLYbGe4My094uKcQvN9haJWxcx/LuYVa3l/IF9SVhHc+pW+Ggh8Q62KqFLzoeHLC31xUbUji8qP3z3RzvjVgHRhYokMzC9DfJVQzCcMpbZsK/qsj1VnN+yLRMpB/GZb/0la1JB/BUpU8JY9uioYdSH/Mu7iKIVUK1w4OQhSVtKCRdGnck5TnUcSRkxL2/bSQH4VfY3gC4CrUmPVAgDkFWuMZJdhGnl842s2tnwYrCX8dJDzp18qSomls982lKqjEtCT2KPOR7ZnVsUsldSpTS0fDvtjfppNUw5EveYi+A64sgmwoO9EpZ+M3YbklJ+taR9t4n+hTIGPeTa3InvuUx1Yz0jUOWbDHUqv60ZDcAzDPeYlx/PB47mLqI4Anechkpi1cU1wEKqgN5RDFshUjv2W7KMDlqJfqWQCarAIB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199018)(6486002)(2906002)(31696002)(83380400001)(86362001)(2616005)(36756003)(53546011)(478600001)(6512007)(186003)(26005)(38100700002)(6666004)(41300700001)(8936002)(54906003)(66946007)(316002)(4326008)(66476007)(66556008)(8676002)(31686004)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUhlNFE2RktXUW5USTRyWG1BNWpCM3BnZzZHMUtPZnM0WHU1NGprZU9PVU85?=
 =?utf-8?B?N3hxZnBIQ3duaXh6ZEtJYlBCOE80VXdPZ0xGeUdwMEdJU1FUU0dFRmcxazZt?=
 =?utf-8?B?WXRvelZIK0t2UVRsMGUwUzBKK2NMdmNvcS92a1ZiRk1xbUZpWDdYNjQvZVRy?=
 =?utf-8?B?ay8yZFpTOHFiWlpGT2JreENkcG9NRFdYOXRMOWphSTdZaGl2TFY5QVhBVUdw?=
 =?utf-8?B?ejQrUkhLM2U2d082U1NiSzU3b3NwR1VWUU0yTlFqRkZEbmhHekFpeHR0VU5Q?=
 =?utf-8?B?SVpBRW1UOGpuZFhob2dDREJVdzR3dGdrM0N3UXZuWXNKbVZjWnNYK0I2bmp4?=
 =?utf-8?B?b2dEcVltRnNKeHNXZ014cWxhMnhaK1k2Y2RuMEF4VjFmTGRYZ2ZOb2VIOWc2?=
 =?utf-8?B?aGpnNmh2Y0w4Y2tTQ2VoWFA1MFAwaUc3UTVXeHNlWlJaRkd1R1JaK0haTWVN?=
 =?utf-8?B?T2RTS2FxNU90eFZ0U2t0dFFnTEh6bmxTVkJqcWRWbXhGamlOUzQyY2lYS3Rk?=
 =?utf-8?B?akppTU5XNmlvV1NiWG95RHFIYlJXT3hGbXJPTUp6VFN0dVJ6ajFvMUR5NXBV?=
 =?utf-8?B?ak4rcTNRVkttWVZnYzdxRHNjYlFQd2JlYW1HS2wwRWpFS3lZaFR1SGZ0QTd5?=
 =?utf-8?B?aDhtQWp5N2NSRjZDQldIZ0Z1Q0lvWDdKN01WUGNCczZyRnZmMGhDU3JRMGV3?=
 =?utf-8?B?NmI5ZmluSG5GTkMyUStZRWJySVFrRlRtYXZVeHdsTmN2bE91SVdhcHpMa3M3?=
 =?utf-8?B?TVZadEFiRUJTVU5wRG5TdzVZTXN5Zk1RSU5hdTFKM1pOSGNDZkV1REJYM3RL?=
 =?utf-8?B?RXBHQ09PUWtjeTZJR0dWQ0xNUWJwYm84L0U1T2FaRmhWVXhWUGtRdEg4Zlkw?=
 =?utf-8?B?VXd0VzNGYXV1REE3SFpkZmEyZ1QyNzBtWXh0d2tQcTlqdjd0YTVQYUtUcGFJ?=
 =?utf-8?B?Zi9pODhIN21EVDd2K3lyOXgyZmJVd1d5M2gwalh0Z1FZTGFYbzRUQ0RtdnJH?=
 =?utf-8?B?UFMwa0lhczlmUm5RSk1BNS9QdWZGYllxR2dTRGNTbnk0dE9nYit6YXVlWGN6?=
 =?utf-8?B?aTczbGxYeWZDc2VJT1FtUFlKTG9aYUJHbFRVYmdmNmpETTRBSTE1SDgwbnV0?=
 =?utf-8?B?R1BxbjRqTWZLUFVhelBrc1M5ME9YWVNhcmlpcnlFOWFNK0lkM1NUaDl1VW9V?=
 =?utf-8?B?ZmpJRURzeEZaa3lUSUhTZWhhczAvL2I0NGg0aC9MNU9iMjFmQXBDcHZ2Ujd1?=
 =?utf-8?B?Z0NCMVBhNlVER1phZXpqbUc1bzdrSEpuSzZXVTVGRzdKWXBsblhYTnMxRUlG?=
 =?utf-8?B?azl4MXBWSGpDQkFPenc1bE54a2IxY3BYaGY4Zm82ajlNL2lrSTJGNGE3TUZB?=
 =?utf-8?B?VHU2MGxXUXBUek4xK2NrQTJqdkRETWVNSlhJM0ltOHRqekp5UlNZN3ZpWjJU?=
 =?utf-8?B?azRFa1AxMlppTmx4eU5yU0F2VlVSUGNSNnd5NzZFMG1TRVRmczlWK0EzT25U?=
 =?utf-8?B?cW1ydUpLVGhXVHk3ZStlMm9RSWtxTVNESDdKUjFHM2IzQUNRRHRQNW05UVJm?=
 =?utf-8?B?V2UwZWs4QTlxbnNrcklBa0x6R2o2NFB0N3N2QXRqWHhyMll5ekM1SWtwQ1ZV?=
 =?utf-8?B?RkRIaFIrRFh6TTNLeFZCbnVLbFJxMUx1bTBqSlBadG4yUHBSaDE2WjFMQVFZ?=
 =?utf-8?B?cTA1d2IvTWRxbUo0Q2JpT2lsencwTndobURIMjVyQ29tZWxkMlpqVDdHRVVt?=
 =?utf-8?B?MjVEQzZYNVdKaWMwanYxU0JYbW4rak9QUHRWNTlZUjlrcHZWdHhUOW5UcXds?=
 =?utf-8?B?R3hGZjlXZGN4T2FBTnhQQndDVXREODcrZU8vaU5wMmN2UkVUdmNjVVFCVHhI?=
 =?utf-8?B?Y3pEVi9sS2hUdXZtbncyRHVIWk45aWVyb2o3QXJoeXN3Y21DVE9uMFZ1RC9o?=
 =?utf-8?B?NmxjcXh5NHhYaUhHSE02OHIyL2Z1UEsxUFJRN3FjQUJUUUVEditFcFZ6dW5z?=
 =?utf-8?B?OVJSVElIZzcrY005eHBJTk1IV2Mrd2ZtRFZweWxXVENhM1BxU2I4bzFjQ0xQ?=
 =?utf-8?B?ZTZjMHJGbTdwRlhOanErM29wZGpJK01nY3ZhMG0wWGd5Rk04TGFsL0tkOG5z?=
 =?utf-8?Q?2fylir04A9rrwG5q8jmCfwnu9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf3c6e8-9fe6-424b-1ef6-08db0ed185f4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 21:22:06.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdRqow3QmK4wTlFzHaFASHMbAzwItNObxlSBvUCZwHXwhXpwM69rCjoelxo5E38RaADeu1xLcgzuurnmiSyszA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/23 19:05, Pierre-Louis Bossart wrote:
>
>>>>  static void amd_sdw_irq_thread(struct work_struct *work)
>>>>  {
>>>>  	struct amd_sdw_manager *amd_manager =
>>>> @@ -945,6 +952,9 @@ static void amd_sdw_irq_thread(struct work_struct *work)
>>>>  	status_change_0to7 = acp_reg_readl(amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_0TO7);
>>>>  	dev_dbg(amd_manager->dev, "%s [SDW%d] SDW INT: 0to7=0x%x, 8to11=0x%x\n",
>>>>  		__func__, amd_manager->instance, status_change_0to7, status_change_8to11);
>>>> +	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK)
>>>> +		return amd_sdw_process_wake_event(amd_manager);
>>>> +
>>> it's not clear what 8to11 might have to do with the wake enable?
>>>
>>> Can't you have a wake for devices 1..7?
>> It can wake any device from 1..11 .
>> SoundWire Wake interrupt status bit is part of 8to11 register.
> You probably want to explain what status_change_0to7 and
> status_change_8to11 actually control, it's not very intuitive for me to
> see device 1 interrupt being handled in status_change_8to11?
Peripheral device status interrupts on manager side will be read by reading
0to7 (for devices 1..7) and 8to11 (for devices 8 ..11) registers.
8to11 register will contain field for reading Soundwire wake enable status
for Soundwire manager instance.


