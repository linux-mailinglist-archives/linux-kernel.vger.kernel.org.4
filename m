Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513A7685F53
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBAF6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjBAF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:58:45 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A971F48E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:58:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA3aTijOwrsIM00EqmpVk1lfafZpdi481aNRkqXhWm9qHhf+zc8siENhZNgSt+nuPXziTiYD8CpsYgHcNwnEuSM3Dr3J59pXQ4RtJS0fh0fnI11Iyx+oCV0nyVubZNN4TG3B1Vcb1b8130XTbG673noK/qE19CfwkPl1TY01OhldDHz5yYOLUhUnivEld/bJGvjmRV9fTSHvi/550o0K4xMEGAdyASN7dh21C0/7jOHBtQDW3vw4IHCXI8gspivGqHMhFQ9Ob9vUb7nUBO4hviFqwC70mPLmXBQNtRp8l1W677FQCh8o5lJ2G8UN2vqUr2/AeQ0zPuqVF/b0vZNXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVs7BBN39CHNpfDzAap2vC1TF/ClSWqpDXArWvaCM/g=;
 b=K9gMjPf8blJIS9qZA/8u2wvOtX/Dh7lLgPKf+vm9F5Z2k9ajJyGwNJsh32S5zhzswsdRZ6gkWpkw34RJ1vMvDi6XJy7dPYOMQohCY8cjCVNIoNFHTrOWr5yUAhsO0nYHSs4ipEAo2uGa+aX7u3UQ4cxvZ7Kv+3HGCWwtpK6OeAndQzIBr4tyGgZIcxX78LJn/0wvikUGVj7AnZpTJGssgZdLQDT2sYN4Cy7H5Hds2V34Z3c9BdlIZaSbJer9KTTAZVNx7m9L8OC1D1qaMoef/nh3HxLt/ot9XMXbyqL3udkVP+AqM8VuUFgCD3CkXrgS8Qa0n1zf3t4O5At75J6w7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVs7BBN39CHNpfDzAap2vC1TF/ClSWqpDXArWvaCM/g=;
 b=oYfha8iPd4PHg6W45Rr/WnNAAquBXbO/vk2DXbIyyOvVpOlHLZZea6PyuJwrOX8zdyFUUtIDMht6D39s2XRM70tJK69BlPYmNeDa2eJYBiSWBW65rXKb33r08gokxMZmzdm8weu3leQrHdd/eOlPvJlnve4CZmgcetO+zU++kvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 05:58:42 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 05:58:42 +0000
Message-ID: <9e6200ee-9b21-66d1-6bb1-832ec7399111@amd.com>
Date:   Wed, 1 Feb 2023 11:31:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/19] ASoC: amd: ps: create platform devices based on acp
 config
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Katragadda, Mastan" <Mastan.Katragadda@amd.com>,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-2-Vijendar.Mukunda@amd.com>
 <9f2229fb-499b-f802-993b-56a7ad2ce361@linux.intel.com>
 <257b6f1e-f403-573f-3978-13ffb14342ad@amd.com>
 <2b4c12ce-2586-0277-ede0-560f8317e4e4@linux.intel.com>
 <27eabbf2-eff2-0964-b72b-f9db251c3b57@amd.com>
 <87ddd91b-fb5f-4f27-942b-dc439b32ce20@amd.com>
 <fa4cdd91-b430-eb1b-a151-d144f62e827d@linux.intel.com>
 <MN0PR12MB6101DBF0419C2C565F7F6840E2D09@MN0PR12MB6101.namprd12.prod.outlook.com>
 <c5161bc3-62cb-d0a1-2ba2-d670285b6958@linux.intel.com>
 <2ea354bc-4263-1db6-4423-4de1b0d4e535@amd.com>
 <815ab487-a1a3-1978-94fc-b60e931c2848@linux.intel.com>
 <ac734e4e-2f61-b9b8-0751-4e3293084696@amd.com>
 <7b8fe2b6-84cb-e8c8-22aa-2d940a5c68b7@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <7b8fe2b6-84cb-e8c8-22aa-2d940a5c68b7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|BL0PR12MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 09031059-104d-4d6c-a34d-08db04195f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhaJfG/+ntR5suVEpZlhsPnfFliLS10rv0Isi8Rmi/6AqHRbkiS7shgXZBCb4IATn6KdUKTXBCsuw7O1SbD9cWi63QNryWoe8FQbVB1OJA9avvuMlU8Log/+6q6nvyl/X3rnredo9V0EQTNk6t1yemCb/YdtvcFeSDCAvgUujAvRTbg/IPaT3izC6q1I2VZMkDhK6M2eS/fh0p28ABlbn/Ey6EIMR4SccQXR7UWpEOD1RSy24Er0xlPDvVeYyIJhtMD+eaMQmDlrMFhfe5k8W2535xy2FZOVKdyHTKIA23raUeqeHZmPLfYevkfmIsOuztWSurZTHOTvu1ymefsjdtH/ZqJjTkBq5jXVCfDXlCpAC3RsgrPPqhbjicIgVDN+fxlNIC5m0FVxqE6zcORoI88QBtWx4QlUDcnDyTo1AMP4qG8EbwPMyxXGV1n4/M5hk9enUNE4b8alpR4+7c2iQF5Dx0x5LYrLOjDgRT9c24vYln8E0gB/1M5Gb9RxcuXdvMydzXbLD6zvW++A2qKlws+QbtS1C42nCO6L45EBjsls8DtEtMpK2CPWFBNamIK/3Opes083y4B1cKwyRBKPRGIKbfCWcF6h7BF3nn1/zeFOh/Re5rahann6EeTdrfk5PbL8YiqacOVfRTWj/jYR+9CRULcjh9LCClxB2wCHzqVEfW0I51iKMJ2f3ezWjpOKrviScWcoVzxyln9xqd3fBCj5/xxgRvTjYbbGNbkMqoOJ7oritD/EML/Ysbo3WQVDUapGDSNAmG7nuPCuFyc4hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199018)(38100700002)(66476007)(4326008)(31686004)(8676002)(8936002)(41300700001)(83380400001)(316002)(86362001)(31696002)(7416002)(5660300002)(186003)(2616005)(6512007)(110136005)(26005)(54906003)(66556008)(66946007)(36756003)(6486002)(478600001)(2906002)(53546011)(6506007)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTk2ZFFiTnZaSlpZckhZZHNVTlB0UjI5TEtaZGZIcVkyTENETThLQVJjWlBh?=
 =?utf-8?B?TzRYSVR5YzdOWk5GZ2xRcHl0T2lod3BPTU5OZzBUSFlaM2pnTHRxVlgydzJj?=
 =?utf-8?B?UVZhKzJta2REa3pQa1FQWE1QT3FMZVNGYVRSOStFTkhYeFRhQVdkYU5mb3p3?=
 =?utf-8?B?NklKTzBWTXZUblJnTTZRcHpPZnBWVWpCY3RoZTUwYlNpREtoN21XMEdGY0VZ?=
 =?utf-8?B?M3JYbnc0TGpiV01BMjVsLy9ETmcyVDZGOVN4YkVlcllORlVCQWJ5NWVIb3M3?=
 =?utf-8?B?c3A3QnJId3B4TlhoZlFlRXN4K3ZOVHFrRHdpVjZzdGQ1Qng3VkNJYXFFREJH?=
 =?utf-8?B?NlVSNkdsN1E1KytuZEtqSjhWMkYzVGVWVmF1d1NaMnVOSkVCdDgzT2hlOThI?=
 =?utf-8?B?K2Z4NllOSDFjWU0zVG1jd3Vucm5hVlZEK0ExKzhSQk1pOFJnbXFiTldQK29Q?=
 =?utf-8?B?TnpBOElCNEhTaTNnREd5NTIwNm1tVVNCcUQvdUtxQ0IwY0p6bWhqaWtwRzgv?=
 =?utf-8?B?V0FIdUdKdWppUFBHYit5NXR4UURxQlpTZyt2RGRuQ1JjWlRpY2dJdjlOY3dm?=
 =?utf-8?B?NU40bWtLVVJlVitHM0VVcWlVQmE2Nyt1RWg0NHpsQ0hjT1U5SFBLc0FVL01S?=
 =?utf-8?B?TzlYOCtRb2RWc2N4QmFGeGQvNXMrTDFzaFNHY3AvNEg3THJldUlKbkpqWWU0?=
 =?utf-8?B?d3dnQ2NlUkl2bnEzUElJeFduV1BlcmNQYTdvS1pYQ0w0ZnZrdXJLZXUxK3Z1?=
 =?utf-8?B?MWk4TWtRbzJSTWdXcE5tbHo5YWdwSkpHeHNCWkx0VzNDTXV2cnBlNnVtQXUw?=
 =?utf-8?B?MFFHWm82MEhLOG5NeFRzWmpFSVdIcUhjTEtFQUovV3pxclAzN3haZkpDQ1RS?=
 =?utf-8?B?eFpJM1pjbWZFN0RUK2lSbHYvVkx2QndmTHRXZVRVa1hSeDlYcit5UnFXYUt1?=
 =?utf-8?B?MitLeWxHQitXa21wUUY4aUhwa3FhNjdPbzdLUzZKcm5XYUkzd3gxS1lxY0lk?=
 =?utf-8?B?bjFaVmQvelExNjJndnU5ZGFiWTZMaVFmNzVKUll2anVaR0kwZHhYcTc3d1BC?=
 =?utf-8?B?emw0elNpOVA4R2xjZmJ2RkNHTHMyWWYrTWFIamtuVnZ5Q3hrTDhRdEROUGhB?=
 =?utf-8?B?Vml5WGNGZ21lN3pUUm93dWc1aStlM1p0SCt0Z3p0bVBTMWRwalJack5zeXBR?=
 =?utf-8?B?cGZsOGNWaVB5ajVlRStOYyt2ZUQ1NTV5M2dYb2JDVmViU1dWZi85Y0RxS1Ux?=
 =?utf-8?B?eWc0eDhISjVTT3hIY0QwMWZJdlR5Y3FMTENseHpDUkxkMHViMWpXSWJCd09M?=
 =?utf-8?B?dDJMSTZ4REMzV1JsMUlqZjdtWDBWOWluMjlENjNIRGVhZDdkTm5RT1VkdWdu?=
 =?utf-8?B?dU9vcnhsSWxYdTJQVktTNGhDbWxJSHhtWnk1T0htV294MjBBTUZRN09PWkNC?=
 =?utf-8?B?SFdjRkJnd1hNZ0RnQ0FLQXdrcnA3YXl1YWZ1cjZvRXJoUDRzbnVrWG1KQ1Rk?=
 =?utf-8?B?WmR1MWg0aHQwZmhUMkcrUW85R1JoaVh3MG1lYlhkNXFBZzU3ai9vbHExeXlt?=
 =?utf-8?B?VE5JV3cvNWI2UUVSVXMveDk1WC9DNHo0ZGxtY1ZqalN3WnIvMi9scTRwK1ZL?=
 =?utf-8?B?ZUU3akxTK1hPNEFlZ0UzZ1BKczQ2Wm13QUtReWZFcGxnVVJ4cVczSXlJUU93?=
 =?utf-8?B?Z2FEeTVQYmJxcjBnQXFobWp1d2hjN2hrOGE4OXorNnFpQWFEMEZ2VGdHNFB2?=
 =?utf-8?B?dW5OV1lBL1duS1IxSXNvRmFtNS8xMG5idWxkdnJKNy8yTnQvOW1WdXdOMzF1?=
 =?utf-8?B?Y0FyWEpzRVdSOTlad2NSbTdMTWt1TXBacDYvSXMwcmxRWThUWGZFUWJ5RXN3?=
 =?utf-8?B?KzJSanRTcldVcysxckVrcEdZdi9Yd1FBL0NTenVjMGs2cWdDUmk4bHRaa1JH?=
 =?utf-8?B?UFN0cTBFTUt1NWlsUzAzY0ZHdHNic1ZLRVovRWhaVFdLNjJFck9Ga09KdG4w?=
 =?utf-8?B?WkdWSVJyZ1U0VFdTTUc1MnFwTTRlYXBoWkhvWGVFbzRuOEJ1WWloS1NrSnEv?=
 =?utf-8?B?RzRRL0RIMHlUUys2czBjMUExUWJxMFpadmdMdjNCaDVlN2JqU1piY2luS0Zt?=
 =?utf-8?Q?5iDdrTmNVknq4bv6OfGFe7pMj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09031059-104d-4d6c-a34d-08db04195f73
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 05:58:42.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGPwwm4ENsuJK8z+lMD8DFPO8RcFur5o+t6XZuWLRYFe4dcQfcNyKKwzvd/up9JhKxxnEQUvcQSzUkHZCMlFRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4961
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/23 09:22, Pierre-Louis Bossart wrote:
>
>
>>>> In above case, two manager instances will be created.
>>>> When manager under SWC1 scope tries to add peripheral
>>>> device, In sdw_slave_add() API its failing because peripheral
>>>> device descriptor uses link id followed by 48bit encoded address.
>>>> In above scenarios, both the manager's link id is zero only.
>>> what fails exactly? The device_register() ?
>>>
>>> If yes, what the issue. the device name?
>> device_register() is failing because of duplication of
>> device name.
>>> I wonder if we need to use something like
>>>
>>> "name shall be sdw:bus_id:link:mfg:part:class"
>>>
>>> so as to uniquify the device name, if that was the problem.
>> Yes correct.
> can you check https://github.com/thesofproject/linux/pull/4165 and see
> if this works for you? I tested it on Intel platforms.
It's working fine on our platform. As mentioned earlier in this thread,
we can't go with two ACPI companion device approach due to
limitations on windows stack for current platform.

