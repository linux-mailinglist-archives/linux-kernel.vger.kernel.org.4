Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7CE66DC63
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbjAQLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbjAQLaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:30:02 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB8B6586
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:30:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nra2Aecn+LSt78jE4wPrPplHv31Inh68YH97FwzuPhj2QLkdJ+8D8Qnt9jVRc/63+3Es894E46sKdP/qPERWyxfrkYMZc2Rpb5/MsfQVlr/eoBAbwmbiHSLptTz5+pVeTe9YO1UdtwuKx9oFbFOfN/qQSSbY+QNArxUm1u1N75/PcPBt8x/W4Kq0D7gc7wkAv0SNc9//xiEZZnRIShfSXmNzWccgoAXsJTrxuBtAiu8ZKCIPrC8aBfkt4xiCNfUZ10IC3QxJYztgYBz2aOaMBcLwtZf2H9H3Z3GExlVbtopRd3nnJFbDRYciWzmoDnz+JwgIJLWI3KutXJkulkeGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g//r7USCUb8XxQapyRZKTUsy0+eDGkZcDpRqU0xvvZM=;
 b=CWLb6hLji+un+DjY6DQVhDskJXOQpO2rNadBlieRx3TfBpjGjOLberyuKwz67StG7Nmyy2++TesCNcjCJ+h2LYTvSEwhxq2vmq6IoGyjQpwIAce3GWSXLaQstqTmgM3UDJYuGmFOPMtlL8QAweYNDvePz3UW/c7NMQxu+/Y1G8OYJ2JVSc2DU5G4GXxOI2zeAHgrUzjHokGPDrqgqEPmwaIp3faLciiLr1IYaZ9YPX/o0T/fR0WrJnTuJYwuGIMsLSBhUaFhY0ifZ1ecUiHDrtFcEAGJESjnlgrSEQHF53qqiNkp1FX4b5ttdVZnlaSMuajN9gKRmy1i/QlTzG0pfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g//r7USCUb8XxQapyRZKTUsy0+eDGkZcDpRqU0xvvZM=;
 b=pYaybpTouCCdsU771vlgJ023VsqQCBdcqIbGVBImtu294qYEK5O7dHRr4Syb0oC3YkhvGBTu1527fQhJ9ER5Zn+b1w6CpH8Hb3WOdwxWGirNPWsPwIpyfDj89UZyGLadV4oLkbbLPU85c8QHFX+wuCOWeUxvvy6l9usU/qbvTn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 17 Jan
 2023 11:29:59 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 11:29:58 +0000
Message-ID: <b61474ce-01a9-7602-e3c0-df8fdc5191c6@amd.com>
Date:   Tue, 17 Jan 2023 17:03:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>, vkoul@kernel.org,
        alsa-devel@alsa-project.org, Mastan.Katragadda@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        arungopal.kondaveeti@amd.com
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
 <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
 <5a34e6f7-eaf1-8128-81e4-81f65541d9a8@linux.intel.com>
 <1a14e117-4216-b98d-f972-c9a02cf79d1e@amd.com>
 <eb12ed5d-a9f9-cb8d-28f5-ac84c75cf441@linux.intel.com>
 <90782037-109b-b197-ca17-b7d199931f7d@amd.com>
 <e73032b1-ac5b-4a3a-e2a0-8ac121853dee@linux.intel.com>
 <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
 <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
 <62272f17-bb97-aa10-d5d9-0914595e5431@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <62272f17-bb97-aa10-d5d9-0914595e5431@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::11) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0772d1-bf17-4b06-6309-08daf87e2a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXiSrFzbqLYICOubLJOxSyNnxxpCneDMp55D10Qz2B2XdQ5/crlwuuZ5Aex6VFf853TiunpNY67Cei6yB7WWVUdtB+aNFLXZqiLsRI5GH2iuqLhVj6geypqOkhV3mjBg7ovTT9nrurMEeJfoLxkc//o7iafsqwi7d1OK+YVhCtRJrTeC3PJF8PKMBBt1oY9sCh120vtU0LVb4KNY98p+xwRDowpI4Pt9gkcEDSZqMqkPe+gG/aLrE9tAs/PoksjpvisBqjfeZDM/T8J5mtIW8geU9e7DjtQpSpEFNLbfdoWVEY9gQI+QQEYKa2F79i3kRhRDnauY6IQQNO/DTdQGaYNooLTnloEmrBmw6uweJbYD41hViB7SiygqedbztHXKwxj2JtgDgaVWWcLHzIboB3XjrCuazoFozY6uNWN2uQ9o/IyP9O0+9rGbeOLy1cpTIxO4dnTLNnwfVOnqUGfJ3d9yVn+s3At0pcjTH5okGX13Parpiz+N+p+BYnjefuZi3bGTbMpqjti7ysk6tHSzCmfK85Bd55Uilyw0rnu5oXnL6C5WFX7VdqDmV17pRhGA1+4ZmCiQOLZIXQ0rp0bemBLrE5hLqM/gc5his/S1nkmqES3D7TZ5Aw0i0iq0+P+zAb3ycgNcmLJvhj8MjiHxvgfSs7zDQc4SKGaImcutG+sI5om+45AMM6EtF70yMzWb/Y9mX6HvgcqIRUieNIU+w2OJdWzImtwKtaUIoIHlU/V9d/lXx6mzs7oAZeIoUEcoznLV99Uw3HQH53mO9sSvenEw9uwdlAVoi1BidKVuHMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(6506007)(966005)(31686004)(2906002)(66476007)(66946007)(15650500001)(4326008)(8676002)(31696002)(26005)(41300700001)(66556008)(8936002)(38100700002)(36756003)(6512007)(110136005)(186003)(54906003)(6666004)(6486002)(478600001)(86362001)(5660300002)(53546011)(316002)(83380400001)(2616005)(10126625003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FtNllYNjIzbFd4NVBNdXp5SVc3SnNQdFVuakU5M2Q3a0FTa1pxSWRCTElx?=
 =?utf-8?B?UnNjbmh3YmExVHp6VHpHa0JSNGhNclBOMmMwQ3BZUWszZVg2QUpnVkVJLy9v?=
 =?utf-8?B?bWpFMWJQZWdPQ05INXpyZS9jSmdYME5pUkJialBraHF4RndSTXhUZjA1aGg3?=
 =?utf-8?B?VEJBbzNZbW5XUGpzUHBYVzlvek1NRkxId200ZXlseVlmaElSTS9oNlhFemVY?=
 =?utf-8?B?dEQ2bUZ3MzlUdjdZdmhDTUUxWmwxWkkrY1BIM0xXdTRtNzB3ZVNnUFBFaldi?=
 =?utf-8?B?V0dLVS9FaGtmYStWRUI1YlVuZEpDakl5RVRzYTIvcUpjMTdzNnV3endLd05K?=
 =?utf-8?B?a3ZTL1p4bWpxTU1WOEhGQ1dUT2YvdVViRTltQVZOTE5jOU9lMFh5R2htenov?=
 =?utf-8?B?MmpaL0wxNGx2bGtmL3B0YWpjY2xtVWNJeTMvYWpoRlR5T2dyWEpsVGxRY1RF?=
 =?utf-8?B?aVd2Uk9UR3hPTzRSbDRueE9vanAxSGRrT3NvQXR6SlhNMkZuWVpjczlLS2di?=
 =?utf-8?B?R3dlNk8vQ2lLRjczM0JOYlhKM1V4R096MUR0akhGVm1iUmxIRTNweDJmNVph?=
 =?utf-8?B?anBmT2lPMmdFeFBCYmtIZVl5SG1iMTRBWWZXbE1NSHNuRDBxRitVUjNTcVpx?=
 =?utf-8?B?ZFRkSHZEeFJ5d0ZocGpLRE5PenRycFZ6Yk1KRDB2VWlNWVBDaDBGcVJoMGYw?=
 =?utf-8?B?eGNmWDZ1Vk0vSVQzWmJvUTZhdGV3UktuMDRmN3VKMC9WY25VcXNXQjZBVTJH?=
 =?utf-8?B?Y1F0S2k3aXVzRldDdWhmSnlsUW1uTFBodVJsS3R6QXZIMUthUDBrT2dUTlh4?=
 =?utf-8?B?TTJienhPTEtuNUtKem5MUTdXSW1VYnNib1JUSyswaDNDYTN0L0xYSVoxWnRk?=
 =?utf-8?B?WkRKR0tqd1RDbUJhckZVVzU5K0tCN3k5WTJzVEVKdHA5b0FFQnUwR3gxUnVq?=
 =?utf-8?B?bnVVSEs2T0R0b2JLa1o3TmgwU2hWNHpUU3JMMmwrY3kxQ1ZSSlkzTjFVUEIx?=
 =?utf-8?B?WnhGVE00NEFxVXUxNWlCSW85d1E2NXgyQzlPd0xCRkdKd0VWL3dGSEFqVzBs?=
 =?utf-8?B?L1RQRDd2c0FqbmYyT1Q2V2VHODRLWlQ4UHhWMGhzeVVoYmx5NjJMZXptY2d6?=
 =?utf-8?B?Z3RDWEJKNWpieUJzbE5DS1ZZTWRKd2hDRFJiWllQcE1hVS81b1gzcGl5S1VZ?=
 =?utf-8?B?Y25obFM2WlNLbWlVTEZtTVVlaitzTlpWVjB4TW1FdmhYUXJoc3d5NjB1cytY?=
 =?utf-8?B?bldUTzBENDZIYVhBa1A1UGZVUzFEUUxzdFkrTE1jVUcyRFFJNGI0OU14a2RK?=
 =?utf-8?B?bDR4Q2FFTHdrRFVBNUduc3ZvUVpnUXVMMGt4dGR0T0JiQUp4Um8xai8vMGtu?=
 =?utf-8?B?ak1LeVY5YmQvVXM2R1BWU1RGajFueTlSVGMxdDBudEJFN3Y1cXV0Y29vUFJa?=
 =?utf-8?B?anczaFYrMTV1ZWxVZGlvNGFUeW16VEUyU0QwYmNKYjMvRGRWcHRqNGNMY2py?=
 =?utf-8?B?T2JyckliUVdqa2IzcTRMVjJhbHFubHBBU0VNNWJHZHBvdjFkSUtBYXg1WWZl?=
 =?utf-8?B?VjZrMHRDTkxqaFhMVFhPWXJEUVUwMFR1SEdqaFlRcXFQdFVKYmRFN0tUZ2gv?=
 =?utf-8?B?SDUrcGp4ZXpHY1R6TFRrRlI3VGdvVDV4ZjRHNVI4WlBMSkptL0c2dXZmRUpR?=
 =?utf-8?B?OE1MaVZGVDZCanhCb0hyOUhnRWQ4dmtvckxkQ3JMYVkzRGl0a3M1NzZkNTF0?=
 =?utf-8?B?bnlJcnY2T3g4Z01iWURXMFZaRU1SeW1FSldBN2UzYjgwQ0JkcFkyaGVlMUhK?=
 =?utf-8?B?cHp2NHNqYmxlWnQvdEFpcFhoSmZCK2NTZFVpdVBJZ2I1UkhJa0dxQkR4Tlk2?=
 =?utf-8?B?Wkk5cEpJVHZ3T2k2OHdWeWQ1ZjFLVU50a2JKSk5FSE8yZy9taEt1a3Q5SVpr?=
 =?utf-8?B?b0YwUk1pNEVIMm9lWkQ5eVhrNFFSOTBGTDVnTkdCYkE1NEdvYjllSTBYK0Np?=
 =?utf-8?B?UHRlaG82eSsxdnZBMzlwY1F3d2d1Y0taSld0bWxYMi8zaXM3bzlVZXNkRG1G?=
 =?utf-8?B?eTFnTWtjd0x5T0FURGdHUW5GQ2VCeU5xa0FCQzRnNW5LNmFCWFpvamJpS1Qy?=
 =?utf-8?Q?QUoP8Z8+pECJjhfy1SyUfUoyj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0772d1-bf17-4b06-6309-08daf87e2a3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 11:29:58.8798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSB1OEFoEO9bLdw4ZDrJfxT7g9nJjttvwIeMrCTfaZjHvW1vjCbMcGXr6BVQA9gGRs98R4e9JPgEocBnFaJUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/23 20:32, Pierre-Louis Bossart wrote:
>
> On 1/16/23 02:35, Mukunda,Vijendar wrote:
>> On 14/01/23 01:27, Mark Brown wrote:
>>> On Fri, Jan 13, 2023 at 11:33:09AM -0600, Pierre-Louis Bossart wrote:
>>>
>>>> I do recall some issues with the codec jacks, where if the card
>>>> registration happens too late the codec might have suspended. But we
>>>> added pm_runtime_resume_and_get in the set_jack_detect callbacks, so
>>>> that was solved.
>>> Right, I would expect that whatever needs the device to be powered on
>>> would be explicitly ensuring that this is done rather than tweaking
>>> timeouts - the timeouts should be more of a performance thing to avoid
>>> bouncing power too much, not a correctness thing.
>> Machine driver probe is executed in parallel with Manager driver
>> probe sequence. Because of it, before completion of all peripherals
>> enumeration across the multiple links, if card registration is
>> completed, codec register writes will fail as Codec device numbers
>> are not assigned.
>>
>> If we understood correctly, as per your suggestion, We shouldn't use any
>> time bounds in machine driver probe sequence and before registering the
>> sound card, need to traverses through all peripheral initialization completion
>> status for all the managers.
> What's not clear in your reply is this:
>
> What codec registers are accessed as a result of the machine driver
> probe and card registration, and in what part of the card registration?
>
> Are we talking about SoundWire 'standard' registers for device/port
> management, about vendor specific ones that are exposed to userspace, or
> vendor-specific ones entirely configured by the driver/regmap.
>
> You've got to give us more data or understanding of the sequence to
> help. Saying there's a race condition doesn't really help if there's
> nothing that explains what codec registers are accessed and when.
We have come across a race condition, where sound card registration
is successful before codec enumerations across all the links gets completed
and our manager instance going into bad state.

Please refer below link for error logs.
https://pastebin.com/ZYEN928S


