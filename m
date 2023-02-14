Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40C66970B4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbjBNW0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNW0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:26:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5047B2C66B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPG7ZEwpADHAx//l5RddkeHfAeKjIIPsAi4/ayHD0vhohGXIp8qa3RTxLHvHqRoFEtm3NHK1OOHbFWMO2VzCV/sPcpwQYChtBwFEiGKUVUrbUD0JUom5uzrn8W/RK2Q8HANoxtVx6hjwwZl7B0R4rXhoIulEg8aCXdrnoyDtGfPsJ3Kgd0X/Gd+aX0cpckU6ypJtyqGNR4OkbBRAmZGOx/EbAZvmf8v/4cM+7ZVsoWfXnjmYPHPBs0qhpuJX9444/iYo/GUgbqqgDsDCzEpAn0CXhtnoYSsFJw97f6lU8FXq3N/CsxIziK/08OoNTXJE/42ydKJerarVNjAaF7uamg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w6n4mybMaMTcZwMjiTcnD6eO6uWYPZVo/LXzlcllRY=;
 b=d4Tifl8VKdlvGr9VnTGjF2TiyRXu43FBIXdmQTuzteJoc70gc+uAYXyjJjrXVZavrvEf+Byf50XzxvMeiuQu0NmpATbDxm97lqpJuSZrf2zRl7KfpbSLAHTr38MMlB+EAGmEVo+irZG9LXROzuSP5DuDGZOgQPQHVv96+cI6kmXZxUqwIB7vCr+K15IssqCvfu+HWgrWrEmgFjr5plTc9jseYYau1H10Ghzh79mqkP4n0/i1RyrrDUQzHJjuoywyyee5E5X1O05uLpt/VK4XsDLdAfw2h2BMKd0bQmvrxuFLwrQt5SxOHfPxVxhQHb8MQxlonASbliIa0ULDjCZ/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5w6n4mybMaMTcZwMjiTcnD6eO6uWYPZVo/LXzlcllRY=;
 b=41+4J/EhHMoBWhVDZdRjKzJcsLcWmFaqrxlOZMouAuh4ibAENYOvy8sM8T9nXHJNlWel4zZUxcQGK1WNoM1qIv96w7GaSiawXw2TTUKkbGxAfs8/8rAKRFF2KgQk0MddejvhknpfH+Y4YTCRdQtkw1vlob1dSxLe1zAf9dAFouI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 22:26:10 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 22:26:09 +0000
Message-ID: <8acb6d45-df74-3be2-93e0-d3053c90ab99@amd.com>
Date:   Wed, 15 Feb 2023 03:59:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 2/8] soundwire: amd: Add support for AMD Manager driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     amadeuszx.slawinski@linux.intel.com, Mario.Limonciello@amd.com,
        Sunil-kumar.Dommati@amd.com, Basavaraj.Hiregoudar@amd.com,
        Mastan.Katragadda@amd.com, Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>
References: <20230213094031.2231058-1-Vijendar.Mukunda@amd.com>
 <20230213094031.2231058-3-Vijendar.Mukunda@amd.com>
 <a3a75ead-5430-ae32-a6ae-78314bc637f1@linux.intel.com>
 <7b5198f5-1894-5ab5-f84b-410cf102268d@amd.com>
 <e79dae39-faec-b2a4-82e6-e11325904f3e@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <e79dae39-faec-b2a4-82e6-e11325904f3e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c74ff8-699b-4246-f614-08db0eda78bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yi7OyrNqFI0xqsEYi+mAKz4akczC5VGVklLrzB7zco8mPHYiuwZTxEwCRoWAN/gg8KKmFyBuY+M8NfAYU2bdU1cNCEzAwKWAKl2QBnL0OLH5G7q83Sn81OPsx+OjHBcasqe8bFgYqV4TjvxcAtmfSVkotNyTURZ2vZlxIrL92VwMvpi/hwbsvCgU70jy22hB79pr8OhypOj+6NSKFyRSMdNYH4eytlGvqcZalDF01HVoO31x8vN2BqFVU3oBoo1T/FcryjYOp9aKjcRWOpDsw2jLLiXJAhmE2QzIzTTeQzG8s+5CCkRaadi0XNYk6kbNqESHhB0a9qrIyJK76pIkYAcmh2Q9IBesNd3gXmcSPmO03FzSk/MIA/bSWMJGTvpzPsKZvo1Qw/6kcEObbJxp/myX1lYPdWr5oC2wHsGAr+ZBXbR0EDA5bEf6+FMFeMV7Th4eK+G9nqgLh3Ph2Ql8040JN9My8XfBu6Kjhw/TciCgg0eSe/otnTy/FpS6KWOj1qWDtwzXnGP0QcEA500hbNBlf+YFjy+LyRmLs15GQR09s/DVppIItBBB6s0ILIrgs075o4nsSRSLX2eBgek1RH2QKLRnZwGlCXpTntb2Zop74uVGPsBrie+/BC+x8JSBTFfzo9iQkvBSGcXMxbQSkn2L/Cp1xBMqPP6/fRka4WTmkBq8/+FqxeNrFKPHh3vjVYMqLP2tCh5GwRjDX6sbyslX9eyc2yNo3LUnc/4fGU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199018)(31686004)(2906002)(86362001)(31696002)(38100700002)(6486002)(36756003)(26005)(6506007)(53546011)(6512007)(186003)(66946007)(316002)(83380400001)(54906003)(41300700001)(6666004)(4326008)(8676002)(478600001)(2616005)(5660300002)(8936002)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZDVXJRVzBveUxVSGI0RHJ6ZG9rM2VSMG1HKzMrZ2RsQ1pmRUVFeHNjVzBP?=
 =?utf-8?B?aG9laWQ4Uys3LzVnSXNpQ2VnQmYzNXZ3VXducmRFVlVjNG5nM0Jkelh6Zm5I?=
 =?utf-8?B?SnViRDdiM202ckVRQlVieERwdll0RkRGaDRTeXIwRzR2dEJUVElSeFRIWUtQ?=
 =?utf-8?B?THJ2dUxaWWJWSnlGNFQvSjhvMU1mR2VKbGJvOE53U204TzNGQ2ZhdEhPWlcr?=
 =?utf-8?B?VFFkbkhkVmpqRUtyL29VQkdicnIwYWVPOGhVUmZWR1lXZ2krdnMwLzllK0g0?=
 =?utf-8?B?UkVHV0xHeGxyLzBaK0tDNlQ1cWxkU2gzVGY5UXJoZW8rL2ZwcVF6ckxSSGE4?=
 =?utf-8?B?VnEwWjMwQlloMjVwYzZVdDVGcEtWV2tLdmV2c0RsZ25GWWx5TWdIclRJMVgx?=
 =?utf-8?B?UktqbnQrc2hOa1VkbU5mM3ZaVk1kMnpmYnNpeDlsY1p1T1kyZ2o5YlFDM2Zh?=
 =?utf-8?B?ZG5FVC8rSXpjU25lSHhXTUViSGUwWWo2TmlWN1BMamdrUExpZWlvaGl4K3lX?=
 =?utf-8?B?YUJ5WFhtQldMTWNSM0E2UGxWODVoYzJkYjhUdFdDNlZibFZUQmwzOWd3aktZ?=
 =?utf-8?B?RFEzak4wNjNnb2ZqMXcxbkk2MTJBdnBDc2ErVFpHQjBkVG1CRjZ1VXJkNEpi?=
 =?utf-8?B?SnVRYWs3Vk85cGdpb0ZhY3VwTDU0MlpVRzBiZWNHamp4QjUyQ3FOeVF3MUJH?=
 =?utf-8?B?KzR6dnZ5ZVBCclBNdDNEZUN3N0ZjUE04WnpnRkd5RU1rWVlydHlLRUdVV3Z0?=
 =?utf-8?B?VllSOTJkWGVTQkJvTVM2MHJZcU11aTZmRWlLVjVJK3NzT1VSVHZxTjVrYVhJ?=
 =?utf-8?B?cFJ4emUxMlk0R2V0bCtHV083ZEEwQVFpVC91UktSVGxyOERYRzk0cVQxWWR0?=
 =?utf-8?B?NmVrSkc3RmQrVDgyZUVXeCtjOHZxVEI5akVIbHVNN2JoSlVTVUVyVldFSzJR?=
 =?utf-8?B?eWFRcVdrUjlTSzVSMCtUZUd4V0lMNGZDbWhUZlRUUFlYNzlVQS9DOTYrYmJw?=
 =?utf-8?B?VWRJdzkwbXFGMkQ2Q0NkaS9keVAvNnhFdTIwWU11U0VHTHZSRHdpaGxHWUkv?=
 =?utf-8?B?Vm53VVVMYWJqWFl0OG9XbmJ6M3RZTG9tR3hEMGVxMnVyMUtaUSttQlFqSTlL?=
 =?utf-8?B?RDg5RDBXUXRCTmJGbFpXRnNLbkw5RGRjdkU1TVVucmd3MjBQdi9HVE5iVkR4?=
 =?utf-8?B?M3FsTUVCSExVcnlmLzhlQ245OFNZdFhOb0VwYUg3UG1OK0p2T0xiaGNnZ0tJ?=
 =?utf-8?B?OW5EWVVVRFNoV1RxVWEwMDd0aHlCa09Vd3FmRXpab0liNG9qN3R4MVhzTmd5?=
 =?utf-8?B?RWZtUnVUcVdVUExZcUtENjBHZXpMbjE0Rm9udXZjejFHS1BPaWxURE5heWNa?=
 =?utf-8?B?QUlZWGpIejRoWnlEQldoVVc0TnR2YjRVWEUrOGFaeGluVEg4Zm43cytCcVBW?=
 =?utf-8?B?dVhhWjR0RlEvR0VHcUo4MllyTVZNNUgydjcwdHNzVlpodG9VRHFkT1ZWWlVC?=
 =?utf-8?B?WHQveGR1YkduRHhSWjAyMVJabVpLdERxVVFlb2dWRWRRazY5elhHS201QTRz?=
 =?utf-8?B?cWJ1RldIUGRZaWk1V2tBV0RlUWplQjRNMzFLclhtMUN4eENNanNCek9OaEla?=
 =?utf-8?B?R1RaYm9ZUk0yRlRCWTEzZ1FGdkVPZjZzZFB6bk1oa0RQdXhvN01XQzkyQmp4?=
 =?utf-8?B?ZFRDRmRPVTJVVU9YdjR0U2RxaThhQXk5MHRaazFYeEJNWG9BLzh1eEFjSWxU?=
 =?utf-8?B?ZWQvMVVWQVFHbE9WUUg1T2lvczlWSkUzbWtQU05YSFkvZ0t6bE56SGNnb09R?=
 =?utf-8?B?VmEvdjBuOE96ZGhFQVdtUGQ4TFFtQUJYNmtLTEp6ZXJZOHgybkdqRVFnd2Zu?=
 =?utf-8?B?UVJQRDhhT0ZwQmJFMFFvcG9ZdnE3dnlKZW9Fcm9WalVMZE83TXBqTVdzWkY3?=
 =?utf-8?B?M2d5cmdtSzZVWHJONEZOOU1rTjFEZFlhdmdoeTFKZXBkME9INTFJTEVPVUJn?=
 =?utf-8?B?V005S1JWdTVZanhtemZJTml4S3dLOFl6R2ZTdCtwYURJMTZCdGR4bENzUWdW?=
 =?utf-8?B?SzhZS0MyaHJlYng2Z1hydGhWUUNISDRQZHN3dFFxY3BsWUg1Tmo3RlU5Wndv?=
 =?utf-8?Q?gB/JV4L8XGIvZGjZLU4aicA72?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c74ff8-699b-4246-f614-08db0eda78bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 22:26:09.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pd/XMlu88tLwwhShxYe8bG8SbUeZTuCJ+P6wnUsdYNQe5sd5hsdteiKrbjPSVbWD8hFp30GI6zDXXSpjHzZzKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/23 18:51, Pierre-Louis Bossart wrote:
>>>> +static void amd_sdw_probe_work(struct work_struct *work)
>>>> +{
>>>> +	struct amd_sdw_manager *amd_manager = container_of(work, struct amd_sdw_manager,
>>>> +							   probe_work);
>>>> +	struct sdw_master_prop *prop;
>>>> +	int ret;
>>>> +
>>>> +	prop = &amd_manager->bus.prop;
>>>> +	if (!prop->hw_disabled) {
>>>> +		amd_enable_sdw_pads(amd_manager);
>>>> +		ret = amd_init_sdw_manager(amd_manager);
>>>> +		if (ret)
>>>> +			return;
>>>> +		amd_enable_sdw_interrupts(amd_manager);
>>>> +		ret = amd_enable_sdw_manager(amd_manager);
>>>> +		if (ret)
>>>> +			return;
>>>> +		amd_sdw_set_frameshape(amd_manager);
>>>> +	}
>>>> +}
>>> There should be an explanation as to why you need a workqueue to
>>> complete the probe.
>> We want to separate the manager probe sequence and start up sequence.
>> we will add the comment.
> Do you need to split in two? For Intel, on some platforms we had a clear
> power dependency, we had to wait until parts of the DSP were powered
> before accessing SHIM registers, so we called the startup() when those
> dependencies were resolved.
>
> I am not sure you can count on the probe_work to enforce any kind of
> delay, worst case the work function could be scheduled immediately.
As of today, for legacy driver(no DSP's are enabled) instead of
having lengthy execution of probe() call, we want to split in two.


