Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893A66707A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjALLIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjALLH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:07:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6A93AAA6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:59:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaS2x/uVv5C8+dDx7efdSpGKJW7Sz08CMTWG49SEXINu3jImP+9ghzpHJxE8U8eWogmkbnDlB3NqKh6xN/IkxkjqerpoNFpxlxMFekQEyzP1qha/h1gw1vrYPGm7QMpd/B9aZmcw9M3BepFlMfpM4xH0jpI5UyYlLj9RCWPQS7lY8QKr1BEgG6lKPXsXJwwVAiTRxu2xvNPyZveHxcQeoFk0qYsw0gTTBS2p+o1Ro8zEaMKLP9XZ0aaX38evcxGSsr6RFP8fTKbQcxwaSTznhNsRe/OIyUxSmoWX6GUqByXWknlQAYTsZRcyw924LdrfmHudAQb1p9PoJTFSE+eC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwMgnC9WDVQj/JLJrTcmv3b6YDoMRLc6JaiLAZz7NVw=;
 b=YNnEE4RlheFvTDzeyk2qwI/MqbgqcVIdebKDLKRwoegiEjXQwEyUylAD9bgGVslgKk6t3rvvRbXxu+cgfY6g3qpYOYMrCgO+Er54bzVac/staUV9tAlMnbi1wFeTe18NZfTN4dPRAftSy/OIdiIZc6mYyqR60iPHgk82srK4H/8R6GeB1OmdhcpuD4kAcfU4lYD2RyP+ZODTCToNkcvd0wFPGmgAUpFqmRJVPMIl0yX/9pHk5NcYzPKAKCjTmZwUMCndXMnvtZTW5bCsyhfGCdmzOUttLf7OxCWsFzHt9BbRIErYlTQbhA3+maBkU1QMgzcWfpnUfAnEjo86seR7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwMgnC9WDVQj/JLJrTcmv3b6YDoMRLc6JaiLAZz7NVw=;
 b=g5mBBzBkYkLWeHdlzoTjGDXgsrjviiSf4GpIGMQSHK4aKXROJcreUIEnYolPT0TKQZfN96Flvd/dNyeOd5hsGLDx0GMbCO5+CiIMGt/IH310x7qhkqhht40jhj5qy5GlLcETcqyPWb6G6pGW7jHiokUWn38k3WLa7SqM56IuZ74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 10:59:00 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%5]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 10:59:00 +0000
Message-ID: <0aaf3fa5-bcf1-ec06-8f78-c61e8809398e@amd.com>
Date:   Thu, 12 Jan 2023 16:32:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Subject: Re: [PATCH 19/19] ASoC: amd: ps: increase runtime suspend delay
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
        arungopal.kondaveeti@amd.com,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-20-Vijendar.Mukunda@amd.com>
 <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c7f018e3-c8be-6819-0ece-244bfb943c62@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::14) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f31563e-47f5-438e-d155-08daf48c02db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqFlMEBzQr/M5qstR5zPOXY0EJWWjZLjfiFCuwnFl7wTaLCJnQ9BFHd/ceVku4AHVq/OheIUPfyT/UEE//UP9GOA9CoL0wGRYUvxYB320aMUvMQJu5xKShzgTF0DjU2S5LjubvbjmfpAZER5wfvnSgFbSnFO051FSYaa61SZMAjKY609UBJZxjIkz1HoG+EWSq62hN+M4/26YVmwa9bdNZwXHOhR/wn+ejyhVTm/8VK3kcNUX72vl6HqPr4X0D2aa3x+WTWImXDt1OCwJo7bOFfsDMPdwCqCMwJHz2Kolc27JIgkcBk27Vn3Lsk5xM10D1FTokBklEMYQSisp/DVteSWOnQcFnOjHARrhp1UolcRL39fzZmszYzC74WJ9yGVsF4q5p1Xra+vsiIpywcU5vJ+sTnFHdICakSJl5h9JlT9gNVIdVCGbq+71gVSwRN5t2eHs34bUeWLw12p2c3N6UkGCzjmbs/oWfTfmO3CheUIp6lOs2pwpgfNHvoVVXP60T3B6b8rUn/eAwNMpW3oPrGuhIUY73yW8gCcQAPQzUoZVNHrEQyHGEcbfDk2CQiHtJDQJ7AD8rDPL2Tnsl39UMMIg6mDeNgT6tw8l0gZ7plwXNiBDjqELu+PPnSy0U5YCOfY9fvQvvDHLc3phhyptffVas6DejKZi1ciD+MEcLEeJC7Iqt52GfTN6h8PLR2Ffv9HDEsHbi1jTkH3vWKVtcGNYyCs9nuC7t8vPIniUCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(66899015)(8936002)(26005)(5660300002)(2906002)(41300700001)(66556008)(4326008)(316002)(8676002)(66946007)(66476007)(15650500001)(54906003)(6512007)(38100700002)(2616005)(31686004)(86362001)(186003)(31696002)(83380400001)(53546011)(36756003)(6506007)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dll0c0hjQ2dkOC8rTjladUdEK3lyUXEreWhtaktKUnFDcTk3N2g4ZkxubCtN?=
 =?utf-8?B?U2sySlhHbXZBRmhBcnF0SHQ0ZlRkYWdnM0cvNjNSQWlyTkVTUmNNMG9XVHFq?=
 =?utf-8?B?S2RId20wWkxlNzdta0VrRTdJZGNmRlg2QjJ4REI1RjJnalFVenY1MzJmQVUy?=
 =?utf-8?B?dkp3d1ZYMnNWN3lyMlovYnYyMWVZRjBvdmtYeW9LbGt0MUF4cHl2QU5OM0dI?=
 =?utf-8?B?VjFHdEM1dGNDOUtRU1BnejR4Yk1XNFBaSjRwaXRrZEVZTWZBMHM3TDM4cTla?=
 =?utf-8?B?YlBQOXdEZEdMTVVDZURVNjhVdXAraFMwQmNlVFYvcFhHdkZKT2l4a0FZNGE2?=
 =?utf-8?B?b05xbmZZMk1uMmt6ZGhlQ2NOQ3VZMW5tK3hTdDRFQUpoWnFpYVBvTjYyaEhm?=
 =?utf-8?B?K25kT1ltZm55NSs2SVVHY1Z6d0pWcm1zUk03MjdEVlFyVzhENEI5UXAySkRI?=
 =?utf-8?B?emhnWndJNk5qU0FjT1NSM0IxMzIxR1RveTVTTlQwNHcwQkhzOVhZbnluazdY?=
 =?utf-8?B?aWQ4RlpQWTgydkRTcmlxTnU0dTBXeHNCQkx2LzdkMXRXQS80UmtUK1pOZTZa?=
 =?utf-8?B?SnBUaXFkbFhYeVNTd2MzR3hPdENWV0ZQZ0Z2bXJ1R1dkOHlFQ0JLMURsQ1BK?=
 =?utf-8?B?NFoxWVZDYjNLMjlwTkJPTWg0SjhvN0RGUThSYXZzakJwdlZpenh6T2dkRzlF?=
 =?utf-8?B?R296UVA3Q2xXTVRaSVRiNk5rVVJKdDdqWDlMc3ErVWdQY205R1ptelpSaW5Q?=
 =?utf-8?B?eFhQQVFBWFY3alhyZWpRdzhEejI1dGpiQzRBci8yQjM5UFRQZ25jbVJRdUdP?=
 =?utf-8?B?Njh3V1RPQm1KVkJ3eFR0dUViZWk0OUpEWlFha0orVm1zVWFXUUpJMy9UVkc3?=
 =?utf-8?B?R3NXdlNyWEJ0UlNabjB2SnJ6WXl2RlZvMjNNenVScCs3K0J6Tmw4Z0grWlp5?=
 =?utf-8?B?V1Q1MWdxOStuUGJsemppejV0ajNUSytVNHlmNndDYkhKbHFROXl1VXZxMmwx?=
 =?utf-8?B?L0xjYXpGZ21UY21sOEU5RURGbDJMWEdOVWI2dm5PK0V3bml4dDhJNURDL0sx?=
 =?utf-8?B?Yk9PKzdJaFd6RVNqdjFJR3FneXNycHR1dmNyNFM3dHVqWXN1K3NwNjFGOURT?=
 =?utf-8?B?dE1GU04vY1l2YWJUUjJMUnloT2FDOUJJRWlWRkdHaGs3TStjZXB0ZWpoTGUw?=
 =?utf-8?B?TnJBK09nQy9kSWZ2M2l6QlBMckNwd1Z3aEFsTnJESjFuVkZxQkszMGduc2hq?=
 =?utf-8?B?MFNFN0tVQXFCNlJpdll1bm43Ykt3UFVoTEU1Vit0NjBxTjEvMkZCZGpQdHlU?=
 =?utf-8?B?eDVBTERtTjh3ZDA1K0NqQlE0emloTGZyRnBIVlBFV1Jzb1lHY0JPU213dVR1?=
 =?utf-8?B?ZUJkck16VEdTNEp1TlZ2V1pHSFVVL2hkSEw1bDNqY0FsazkvK212SVhQRFdm?=
 =?utf-8?B?NjhEQ3VMbGpKWXR0MzdkVTkvTGxEY0FqMG9ZMVd1NjVKRmFTQ2lGeFJNQ3Bu?=
 =?utf-8?B?cmhXOWYvVjB3UTBkdjVZVm0yY3BNOHJIdzNZKzZ3NTJORnlQVzVGdWkyelUy?=
 =?utf-8?B?VVdzbWFJZWlROTBTYWYwYWdMZWFNS2pSWC9vcFJRemxSQU0rb3B1NS9pV1FJ?=
 =?utf-8?B?V1d6cS9CWlFVTTlBR1hBVEY2c1Q0S3hjT2xvM3VlSVduS3YyTG5Rc2NwTWRa?=
 =?utf-8?B?KzdBL1BrSDl5ZHc4T1FXUHRySURYZ2o1S01HUmRYaXg2TTdxU3kvNk5yMS9z?=
 =?utf-8?B?V0NKZ21oV1dVdndpZzB4aUd1VkxTNXJFeTFKMkU3QnVQTk5IZmRxdzMvWmxn?=
 =?utf-8?B?VTNlYng5T2kvOXBnRXlDY1BTZ2hJWHM2UG9JMzZjY2o5MEJEdjNtbXQ4Skdr?=
 =?utf-8?B?TytXRjY5VmhieFVPZ3IrSlVzY3QyRGNpbk50Tm9VcVpWS2o5ellZdC9QQjV6?=
 =?utf-8?B?TjdmbGJqRHdLZDBlVGk2UkVHMFdWS0lKK1FVaytULzczNzd6RHlGZWNDRFJp?=
 =?utf-8?B?SGFpM0R3YnVwd3gyQmtXWWRRTDl4ci9pUnVReGMxMG10cmtzL2dSSUFBT0Nq?=
 =?utf-8?B?bHR4ZkNJSDYzRVB3YmdSOU1LSFFWaGh4a3FJUHEwei9qelJURTBnb25rK0c1?=
 =?utf-8?Q?QQLplfaYXbPjj6RG1YbrGQBr1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f31563e-47f5-438e-d155-08daf48c02db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 10:59:00.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7VKrtfppSHxK0ts1XIdzwsv3eGETCm91CUPBiL72sFvdow2Kr9k97M8Wd/zwJqblqgtnBsRCJ4Kv4n4hMGVhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/23 21:32, Pierre-Louis Bossart wrote:
> On 1/11/23 03:02, Vijendar Mukunda wrote:
>> To avoid ACP entering into D3 state during slave enumeration and
>> initialization on two soundwire controller instances for multiple codecs,
>> increase the runtime suspend delay to 3 seconds.
> You have a parent PCI device and a set of child devices for each
> manager. The parent PCI device cannot suspend before all its children
> are also suspended, so shouldn't the delay be modified at the manager level?
>
> Not getting what this delay is and how this would deal with a lengthy
> enumeration/initialization process.
Yes agreed. Until Child devices are suspended, parent device will
be in D0 state. We will rephrase the commit message.

Machine driver node will be created by ACP PCI driver.
We have added delay in machine driver to make sure
two manager instances completes codec enumeration and
peripheral initialization before registering the sound card.
Without adding delay in machine driver will result early card
registration before codec initialization is completed. Manager
will enter in to bad state due to codec read/write failures.
We are intended to keep the ACP in D0 state, till sound card
is created and jack controls are initialized. To handle, at manager
level increased runtime suspend delay.
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/ps/acp63.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
>> index 833d0b5aa73d..6c8849f2bcec 100644
>> --- a/sound/soc/amd/ps/acp63.h
>> +++ b/sound/soc/amd/ps/acp63.h
>> @@ -51,7 +51,7 @@
>>  #define MIN_BUFFER MAX_BUFFER
>>  
>>  /* time in ms for runtime suspend delay */
>> -#define ACP_SUSPEND_DELAY_MS	2000
>> +#define ACP_SUSPEND_DELAY_MS	3000
>>  
>>  #define ACP63_DMIC_ADDR		2
>>  #define ACP63_PDM_MODE_DEVS		3

