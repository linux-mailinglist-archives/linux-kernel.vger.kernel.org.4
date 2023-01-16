Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7933666B91A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjAPIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjAPIcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:32:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3BE12F04
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:32:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcBtjfJ5gk/BI/ovLTm+V25Z+SCaLcTVVNvWkrt2FnulZXOPnOWbyCdxKY7vVZ8cd5KMC2omxz9tLVQ5VIQIQ/HYOfQiKuBb0+zbnbtACEGKXXBfIrg+Kxjty+aBpJ9+glFKZ9J9IcpimTk12relKEKZQTFL79sZzWOpuXAovJiIVET89XmSY7qXxssSNDJ/kH/RvSDkmmo1sClffGDLJL0r+5nqx7a9EVOK5SV3x+DeWk+bMjHpVfvRFjr0oqbCrXsZ4OgakJJhePQEDh/1v6qBdkMAIIBijsN5wkTVkMegWsrYk1+3KdeqiOQDDFzxn2OmhveiFyue45hGlES9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRR4/lX0t4KK/SMKr7nce5jHvom7shkw6UxKR3++RHE=;
 b=dm6jDjjZPAwPdACXhQWwmP5eWZWN5PG5uMY3MuthzmrKE2UCvJQ8OqHOAgm1YV+krVe8nI1CeYbIyW5JZe+y7Zg/iO7tbwWTS8obeZjp+A3tNqQ9CfjUiF+CHfCkbAUHyvNrRTsBpntuVFy30JMKhQIfbsOdNl4XTJp2MQw5kP3iqGLoFvPH+2cCZ3OFddvFqzYQXtN7oloyDiXuLzysui1TcgWJlj7r69e02TQ2VW3lf9kIOXWtu5nf+gC09nsxF6hV2xPl8EIMwz9S7liYVYrkAbDIc4Rk8QsiOIPIoTlyEHl33RK0lOEFNENa+KgUI/A7r+F8A5E1EoIs//GbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRR4/lX0t4KK/SMKr7nce5jHvom7shkw6UxKR3++RHE=;
 b=mlUjih9gpQwK8hL3N6wp9x8Dzcpkr4CA1NfnnKXt5KvTJEmDYnNYZGp+D9/AqX6ZYlxoZZGVb6jDhX9rr/0IKLkzaIVE5sSYbbLvtQkjhf5Fysb8fKzp16c3vgZhBqkh+eqmP6+34vWyxe/gpboBcm9D4Wv2vZGqKL22TlQsJ80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 08:32:35 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 08:32:35 +0000
Message-ID: <ef05d550-c2aa-e256-58ec-612c2a3294ca@amd.com>
Date:   Mon, 16 Jan 2023 14:05:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <Y8G3mPUDWWUu/3ZR@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: a962f92c-2794-4ce8-aeaf-08daf79c3793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNnj8ufpSkLGa6sze29OGF1vhzsIRDQzzxb4ol9bMFiGn95bl+ZNE9SrMi/NYXWMH7yHwya4ukyjyxj+jQqgEpFXRGQxgZ6NHKVgK9LR+mBO0b/L38py1FwYmdIVrUKIhw7ySz2mtlWWRmUJ7IORwv5ZWR9KN/sPbHmmSEcy+j0mZ8UOS/pnfBHHwDL+NHcAhEwlN1/7sn4R+8ejpi084ybD9r6GimvjZfp6QoZ3XW0to21xLEu7yZS46/fpQP00C6nyLmVC1p84NXdZqvhLQfxBLdjBxwJ7Emzv6vc+rSIf4fiw+19Q+bw7aSUV9xYJE72onHvmeB5Gz9wwdtc3e/TTLOB8y05OrlDJCChFobOYXsgZN3S38xI4hpSAtbLV6hM/nGqb3dmqpeZqHXbFN4UAgWGjLHbwojY4W6rtaejHKxpqC1MCVEM6khANW8I+pVSf1nis8v8Cy0LXayJ3Q3jdI1dFjhhw2suSyIO73wAcfEHPFqkAGc2zQqiuG/bmhtTpQvhbMqu0A0j5FEU2TfBKEKQ8kJO2ZBQd5fQoExsHD/N/uYMsqu1COnEHmV3z79ocAcr8V4YcPwHNCP0ZTQDPHDqc7hoVRjbmsZoi/TWrFRBB7Fa8BoLddsCyZxxIJxE6q7XJm+/JqoAI8gb+BSgO5a5ps420V3HS8WucR5+98MaPrcBFvGgy07LKV/ug7HYQBNnkWH1OlKkWdWHw4yQUgHy7/UnpTlwBlV7C3EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(31686004)(38100700002)(5660300002)(6666004)(53546011)(6506007)(478600001)(66476007)(8676002)(66556008)(66946007)(4326008)(26005)(6512007)(54906003)(2906002)(186003)(15650500001)(6486002)(36756003)(8936002)(31696002)(2616005)(110136005)(316002)(41300700001)(83380400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dKdjdsR1ZCNXZKU1NNdzgrTGNMaUpQWENlK1ZPSVljMG4zVm12L0hWcTND?=
 =?utf-8?B?TDFoWk8zbFc0MUhDaFM4YnlqU3phcjFBTDh3TGd1UXhpb21jV00wZjVTR2tw?=
 =?utf-8?B?VEw4Q0dvRW1RVGNqSU82cTlyaXJySEpXQ0VNNTJ5aVNRTzhPL1RXdFZ2Z2gx?=
 =?utf-8?B?NnVrZFZzV2pHaDRkOUdIWGhWRlZiVitUT1E0djB0VDAzWFFnQ25mVnlUL0or?=
 =?utf-8?B?ZFFBMkM1U0kweFlHRDZFL3E5Yy80SEFRT0JHOGZsL2tOa1Arb0FvZ3pjVXFj?=
 =?utf-8?B?NWRlSjNLd0RSbk12anlSUTlCbmRGWDBOVFgrNnR4SGJmR0pBNlpkQjVmOG1x?=
 =?utf-8?B?dkRrNnluTERaSnhSS0I2WFR2SmhkVDNKMTh3UmtjVXErUTBiZlFSTEZrZUY3?=
 =?utf-8?B?OVJsUGFuSDhJOHl3d3oxU3gwMjZzdXA4a0NUT2paZFdiNEhlQmdwWlZSZ0ha?=
 =?utf-8?B?MVlSdkxGN21SMmJGUjNKOWxheGNleTNnTDNEVkdPMFhQa3lMUEFPNUhacHAv?=
 =?utf-8?B?L1hIVVIxQlNPQkhIZVVaOGFUeTloZFI1RnlGWGYvUXpqYjBscTJBV1d4d1M1?=
 =?utf-8?B?NUhRSFk1MjJOVnBwN1VhUXA2bmE3MlN2Y2p0MVRQOGtZRklNYVBKbWVhQ0xk?=
 =?utf-8?B?cFlsekY3V3VaU0FGWUkwUFdZY0pHN3JIeXllV1lXamdUcHNxQjhJb0VjWGM3?=
 =?utf-8?B?blErczQycFZSUW1JWmlZc0VNWlpYWkJSb3pOcGwvK2NWZUdDZDAveDkyNk9W?=
 =?utf-8?B?SXgxaExobktQWldSVUc2MlBXVHZVZ1dtd3FqcUxjWFVOc3prclZiUHVvcTN4?=
 =?utf-8?B?VlVjMWl6cmNFNkl5cGxDSFNDMTV2RGNRTzVJN0NDOWFHdGdVdmNsYTRHQ0xF?=
 =?utf-8?B?MHZVUmxvVU0xaVBhbkdNTkR4Tkw5VExyTUNPWGxUR0E1WWZVemVDQU4yZEpW?=
 =?utf-8?B?S0d0Y0I0R0VkTng0UlVYenV5WFZVYWVaMjRLWVgrSy9OeW1pSTFWOWgwbFNZ?=
 =?utf-8?B?VEdaREZ4UTkvbS91U3V0NU5JeS9IRk5IRkRieEo5VkprbkRUTG8yajFjdmJv?=
 =?utf-8?B?Z0JBY1JDSVgzbHRmcTBJMHpMUG1NakVUZFRuRnpqaDlnVkt5NExnZTcvVWlH?=
 =?utf-8?B?M1JPcTZlb3NNdHJ6QlNLRGVTUUduUUhDRzNXZnZNMWdldXZrS0dOYVdPQ1Fq?=
 =?utf-8?B?TXozdDBpMzJ2b09QOGtvdUZTZkh0UkpIR1h5ejBUNUJMZmY5YWRBZUNHNStG?=
 =?utf-8?B?Z1RvclNJYVFFMDlQaUxxcUFpTnFjbVB3NlNpS3lheUErdHJST3lDVGR4YSsx?=
 =?utf-8?B?RURKeDdrMUJ1dFhKd3E3dGVsVi9kSElzbHdIb29oMFhyUjl3K0tZTktKV0ZW?=
 =?utf-8?B?OHRqTHpVWXpvOWhKVXllTnJ0ZXRRRytpZ0tlZ2lQd3JNQzVvU1pqN1FIWmJK?=
 =?utf-8?B?Y0JUYUJlb2h0ZkVYQkRwcnlzNUJjbGxKLy9ZUzJyQ09rTjRraVluMkZDM2JV?=
 =?utf-8?B?NUE3TlU3d1VIZVRJSENPZWhXS2YzbDk3cXZ5QWVmbmtzT1RkSWV6QXE4SVV6?=
 =?utf-8?B?UGh2d3lpMUh3cXIzWUwrZVNERVJaV3p2SmQvT1NnNHM0U3hjbXlYNElRdERv?=
 =?utf-8?B?dCs0eFVWUUQwMDdGc3pYKzR5enl0ZEVaRlNUZVd0RURJeElvSE1TTVoyUWRw?=
 =?utf-8?B?ZGVQaDNTaFdZQ0dkeTZ6YTI0ODZNcHhVblhTR3B3Mit0U1VVWDRPa2EzVlJk?=
 =?utf-8?B?dTQwbVNXaTlWbTBvRFR0ckVteUlmMW1iZDMzaFh0S2c1WkNpaCtYNmFRdVhM?=
 =?utf-8?B?Qk1KVTg3QW5mbmUyTjA4N1I0RGtVa2hsZklxZzFLbUxGLzVkSnlNalNqYTBO?=
 =?utf-8?B?Y0JNTkRtdGhvVHZmMFp1TU92UzQxYjVtUFM5NlRSVkZic0ptdllHLy9zZWRZ?=
 =?utf-8?B?Sk8rcm5mbm13MmZuamtOalZuS3g4RW5sSkx4L1cvUklvUGV2OEFuNGw1cXRJ?=
 =?utf-8?B?cUFFbk14T2xwTTk2dG85dHlFWTBRSGhEdWFhSkhmeWFLMzdxOGtWL1l6bVFu?=
 =?utf-8?B?WGk4MFF5RGp3VnpFOHpPMjFySTFOdHY5ZnNPd2tYL0U1MW45OVZ0RlF0aXcy?=
 =?utf-8?Q?xyL1lXU5O2IlDJJuz63GC0f9B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a962f92c-2794-4ce8-aeaf-08daf79c3793
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 08:32:34.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+/fBRou7qMF2DObyyoVKLHoDXBj6bkB8AhrvKfRMIckWKGYejsqmePdygz/Hv0JmDc2GrFwtRbSYsLKeRoAeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/23 01:27, Mark Brown wrote:
> On Fri, Jan 13, 2023 at 11:33:09AM -0600, Pierre-Louis Bossart wrote:
>
>> I do recall some issues with the codec jacks, where if the card
>> registration happens too late the codec might have suspended. But we
>> added pm_runtime_resume_and_get in the set_jack_detect callbacks, so
>> that was solved.
> Right, I would expect that whatever needs the device to be powered on
> would be explicitly ensuring that this is done rather than tweaking
> timeouts - the timeouts should be more of a performance thing to avoid
> bouncing power too much, not a correctness thing.
Machine driver probe is executed in parallel with Manager driver
probe sequence. Because of it, before completion of all peripherals
enumeration across the multiple links, if card registration is
completed, codec register writes will fail as Codec device numbers
are not assigned.

If we understood correctly, as per your suggestion, We shouldn't use any
time bounds in machine driver probe sequence and before registering the
sound card, need to traverses through all peripheral initialization completion
status for all the managers.


