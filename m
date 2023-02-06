Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3C668C372
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBFQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBFQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:35:43 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2045.outbound.protection.outlook.com [40.107.212.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21148193C2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Leu0Z5gpSbRpmeZhgcWWoKSbd81Ftl7aqTz+2fNf+uIkVJmWfY0wFWiv4KJX7n1KT0xXHc2dD3vKPmjK8v1JnVEva+yVLTS/PrMqGE+ISHRBQhGFy/Xrq5qeBinbN2fNJltH4Q6bdD+bLMfruZ91zSdeYqdvzE4gcrfzhOPmzti7fJI0UnfdtwSQbHLXLDcS28zr5LfplxWFAZlnk7pc3V3/QjYMCYVivNQlIwAi+SSCvGrusQjQu6Co7l92cHVFYey/ZIPn2Eu3rWL/S3ygVFmxM4kmMOG70ao60UDG7znVUIIJg6Z0uF9we0tGqFIW+rTZvf/sq2HNVpUov6YKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tGAbeOOjATfgNLftdeFoPjp9HqPPEtbYZB5liEXi5k=;
 b=b6G3ZX0sRtJKR4UrT78Rd5nPlQagbW/oHe5McLAdrJsQHBsLGCmmC5PuXDV2SQdp0fo3TkAB3BacfcooRKhBf7r8Mo7JTJA97iwQi6wq6A3zJKpSlnv5/gFuXY0OSatE/WMRCGVnLLnGqDICbeSjFzyv8WpfdS1yz6SKGQ0881wnUnNSgVgY5s8A8Ah/M56dWJnrPdX74sNq6SbjsuB8JOjqN5O1iAUTDVi4pq4PHfHmYSXwew7l3w34kXlC2/X90DZirTdY67ZIvFq2FNUcs8w6MB6241pekwzmt9XhyzuDqgEG0KkBXq5U732n0RYRgEDoOMa9WDclJoeftcqppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tGAbeOOjATfgNLftdeFoPjp9HqPPEtbYZB5liEXi5k=;
 b=rm8PCV1GU5K4LuelS28cIBRnepnBJjH6RIqfByK4GCUdHjzWD9zxnkhp2RuDYtWuh9rbP2gMMLX5cAt4SzeDNR/wVTmmf/WLyUtaHRRiSwYKazJACnf3kxeOp6CJtnRwTBKSnfipx9anK+K4tQXABqHKbuRzCYczc5uBrQdI358=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.35; Mon, 6 Feb
 2023 16:35:38 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 16:35:38 +0000
Message-ID: <cfc86e00-18c4-6971-78f8-2afb8cb28e56@amd.com>
Date:   Mon, 6 Feb 2023 22:08:39 +0530
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
 <9e6200ee-9b21-66d1-6bb1-832ec7399111@amd.com>
 <1473e1e9-b368-d8f3-c1f5-1b64e6e2ed90@linux.intel.com>
 <4c860ef0-d22d-5c2a-9657-7e2436b00101@amd.com>
 <8ff49f42-95c5-dbe0-e9a4-f4982185dd63@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <8ff49f42-95c5-dbe0-e9a4-f4982185dd63@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::17) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa146ee-30a2-41a4-e1eb-08db08602de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BT1s3C9SCmdRdQQjvXh7MeW+xD1IIN0osVNsv3TMV7PyjK0biTD5vWp5rEinmW+lcfKCMHUuCdVuJtyHFtate+4+xjCydNk7Q/QtMcrIImGjYDf2Oj5IMQG3AJH6Cx/DGLzk6K45Coqv2Lfvpt7jjak2jxJYRVwYaZDFZtYeq6/ewhF8wDqpkjg48u4Bc8xoj9QpgVaiv9+KSjrVZEiK7YjjUIDh02Z3fMrMnSDOT3SjUfyc/s4vm/Y6ljfsnMwfdvz7+8JjzM+kSAU7F4daIPfi874J6H5h9N+CFOQwhmSy+fCnr7I1pc9DVKmd/GzdghP13D5xbuwu8NBiM1bv72NVNq5BzputxdLGeoZ6ndmh3fAwA+Jv8/zWNFIEwx3xSVAz89wlZp8Uca4J5aADJNRxIoB1AblwV/aPg628yzHp+TgWMcVLzXUdv7IQeNcBbshpzxnx7PkCzfygfbWsp0NNqD/lbOKzzFzgJv26r5i4CnZaxwmqJst9MkDePsVzxhFN+tOFA3TJ7Zd/bcZWlbJ9O/bNjrTJH2Vcy7feuv522Zl4b4d9UaGkOkF3ZlfchNTX0GzcPiEel0ed59OrPXHCw6GTx6nCr0RQscK8Z9y5kqMdt/tYbk7q2eaHQlpa45+wNyhGjQAvrYjw2elBQWGhyTHZKerhstbzBevLm+yvlOtvQECnWRYfaAgbYATS57tjd0x7hVRMcrOCQitL92rr6LHluyczVayA9sM353RfIuo1bOpbIt2wG0oJzVU8Bkur5bvGAz5tTPNIRy3tXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199018)(31686004)(38100700002)(2906002)(36756003)(478600001)(26005)(31696002)(966005)(6486002)(53546011)(86362001)(41300700001)(6506007)(6512007)(186003)(83380400001)(2616005)(5660300002)(316002)(8936002)(7416002)(8676002)(66476007)(110136005)(66556008)(4326008)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZSbm9kN3grdGxUSnQzaXZObDMvM1g2bXBTQkMyS0JtNVVqRlNwTTBxQzZk?=
 =?utf-8?B?M0tzNmowVUsycXJYMEF5azI3b1Q1ZzNxcFE2NW9VSUY4eHB2c3pvRko4WkFW?=
 =?utf-8?B?NGYyS2F0Nysweml0TUM0emNVNDJuSStUdytqTUk5dm5idHJLa1ZHeXhQUXRH?=
 =?utf-8?B?bUVCYzdOQ2MyMm9vOVJaZ21wRDVGdWxnMlVBK3JVbVpLN2F5K2h5eUQzRXlE?=
 =?utf-8?B?RUIydkNOVGY2L1RSNFU2REZLS2dPeCtQUWVCaitPU0QyUU1QTXJQNjB3RXg2?=
 =?utf-8?B?V2tFbmtrTHZHUThhcGRGZjBldFgvbFBNeXpNQmJITkR5YmdyaEt4Q0V0Qk9W?=
 =?utf-8?B?Q3NVblB6THNIZHZQS3o0Mmk3a2o1NUtMaGlpbFJFS2dUdUhoWk16M2o3cUht?=
 =?utf-8?B?UW9TclZDV1JTRXFPQzc5alFua3o4UytmMHowbzNCMTFvTnhXZDMwS01BOE53?=
 =?utf-8?B?K3dESSsvRWpvVk5TaVNEcitzUkZHZFIxdElvN2Zyd1IwQ0NXREVJL0V0M3BE?=
 =?utf-8?B?bFpRVDJhcFNZdW5pTnRyWG8wTEp1VUF4SU5oMW9icXAyZW4zdjY0Yyt4aGJs?=
 =?utf-8?B?bmtqc3p1bnZUd0xsSFR4c0FKWDIveld4R3FmRnFkdzc3dXF6di96V3VnVzdi?=
 =?utf-8?B?NkI2KzBaend4OGQ4QlZmWUoyUkoxZlRuQlRUS004R21GVjgrUGNzeXVwenk0?=
 =?utf-8?B?Y094T3M0cTI1NDFJZlJFQytrSlIxQmxIZlZXTEE0MGZMU3NNcGVFbXVtSFhy?=
 =?utf-8?B?VURoY1UrMm9KYXNvWXBCZkQ3RCtlbStrdW1hUThvVm9ZS2xlSEllL05DNXhL?=
 =?utf-8?B?YkNxRXQrT3NTUGt4NXVvZTdNS2dmQ3lZQnBrUE0vRjBLWTZDRUpRa1A4QmN6?=
 =?utf-8?B?NnFhVUMxSEFHcUpBbjBraE1MSzNmTTliVmxmQWlFZnZobVVHNkM4cjdyMjZI?=
 =?utf-8?B?K2gvVFYxMWxJY1ZWVlh2V05xdk5kb2VodHR5WGxGeDJEN01IREtxSjZPVGdM?=
 =?utf-8?B?dndkbStXeGtFTld1NGorNmtBWFMrTHlZRWgzaDdRenhaeitFNU5DNXZBR25p?=
 =?utf-8?B?UzRJMjZ4NnpTQVNJMkVOQmRVcW9uSm9aK2ZUcGtyOTFkMUxTdjFyN2JBVXc2?=
 =?utf-8?B?QlgzUDJOazg1b3pBSTgyUTE4MGFzTEo3S3JYbTdMdDZMQ1l5dno3N25DTlhw?=
 =?utf-8?B?cGtpZTBGUkYzTFBBc0V5eFh0VVd1N3JsYUFwZ0tnalJYWm5GMnFQOHYySHhH?=
 =?utf-8?B?Ri9UVUJqT1lHc2l2bHh3T0FmVWNraHNXUlRCdmtVWlgxSGFnSVRzWFdnTDI1?=
 =?utf-8?B?azRhek4vakVuTUhWbVA5cmo5MzBlaURweWRkcWVMK01ETGxpN2tHaWw0b2Qz?=
 =?utf-8?B?RHB3MXg3dk9SQ3dLUGN2RzNuR2tkKzhIS0F5VTdkekFJdUVmaklZN2dLTGpQ?=
 =?utf-8?B?ZGs5SnNQNHhsT3JXMGx1V1ZzMkxBK2NiSWF6Yk9MZzc0OUVHek5pT2dNUFZ4?=
 =?utf-8?B?bGVmV2dKRmR4ZlNZcm5aelBhczRrVng2dmE4ZFhSdkJISjlyNUFCMlYxZTNp?=
 =?utf-8?B?WXB3TnRIQVlvd0ExazZZRTdhenNXVjJBQ2xBOTBZakUzWHc3VlRDTG8xaVVZ?=
 =?utf-8?B?d0RRU2hlUWdTMU54ZlZiZWpzcG50enp3aG9IWHJGZmVLZnJ6aFVjTWNwNnFu?=
 =?utf-8?B?UUprbG0zRXdGZW9WektFLzNZeXE3M1dlR21Db0Uzc1lEbDZpOXVVYkhmOWc5?=
 =?utf-8?B?QkFEWW5BMVBhZjE4bG9iRXNJMklTVktGd1dPd1NzODJvSVFBM2VDb2VOd0Zi?=
 =?utf-8?B?QUdvVUhJS3hWa3NUTHI0VWUwM295OFR5bnROUFV5YWJOMktPb3o1NjY5Qm5T?=
 =?utf-8?B?WDBMbU44OTNtOCtkcDdZY2gwdEY3QVplazNCeWpoUnVDcCtSd0wxMWE3cmlD?=
 =?utf-8?B?aXRVZlJpRlZnaFltMndKZXBHc1JPOHhqNFlEMFMzclBaRVFKZlRmRlM5Y2cx?=
 =?utf-8?B?MkltN1h3Q1lrVFZJaHhGSnJCb0djNnlQV2xxNStSNm5DaFg5dXFYTWVvWGx0?=
 =?utf-8?B?YmJJYlpLNzFCRWxvVnM3cDl2V2diTC8xL1dJYks3N0E5Qzh3UzM0TGdMQ1k0?=
 =?utf-8?Q?RlIVdf1QZT6mnzRb3jWgKIugG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfa146ee-30a2-41a4-e1eb-08db08602de5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 16:35:38.6728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE8ycZSwh5GTMwFlOSo75ZfHJssm2g51JTbZiMf9xQEOJtzGyrs+BTXPtVasO3ANjUlK3tdkAPynp6JS5aKwsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/23 20:20, Pierre-Louis Bossart wrote:
>>>>>>>> In above case, two manager instances will be created.
>>>>>>>> When manager under SWC1 scope tries to add peripheral
>>>>>>>> device, In sdw_slave_add() API its failing because peripheral
>>>>>>>> device descriptor uses link id followed by 48bit encoded address.
>>>>>>>> In above scenarios, both the manager's link id is zero only.
> So here you're reporting that the issue is that all devices use link0 ...
>
>>>>>>> what fails exactly? The device_register() ?
>>>>>>>
>>>>>>> If yes, what the issue. the device name?
>>>>>> device_register() is failing because of duplication of
>>>>>> device name.
>>>>>>> I wonder if we need to use something like
>>>>>>>
>>>>>>> "name shall be sdw:bus_id:link:mfg:part:class"
>>>>>>>
>>>>>>> so as to uniquify the device name, if that was the problem.
>>>>>> Yes correct.
>>>>> can you check https://github.com/thesofproject/linux/pull/4165 and see
>>>>> if this works for you? I tested it on Intel platforms.
>>>> It's working fine on our platform. As mentioned earlier in this thread,
>>>> we can't go with two ACPI companion device approach due to
>>>> limitations on windows stack for current platform.
>>> Thanks for testing.
>>>
>>> So if you can't go with 2 ACPI companion devices, what does the
>>> 'Windows' DSDT look like and how would you identify that there are two
>>> controllers on the platform?
>> We are not populating two controller devices. Instead of it, we are populating
>> single controller device with two independent manager instances under the same
>> ACPI device scope.
>> We have configuration register to identify sound wire manager instances on the platform.
>> Below is the sample DSDT for Windows & Linux.
>>
>> Scope (\_SB.ACP)
>>     {
>>     
>>         Device (SDWC)
>>         {
>>             Name (_ADR, 0x05)  // _ADR: Address
>>         Name(_DSD, Package() {
>>                                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                         Package () {
>>                                         Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>>                                         Package (2) {"mipi-sdw-manager-list", 2},
>>                                         },
>>                                         ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>>                                         Package () {
>>                                         Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
>>                                         Package (2) {"mipi-sdw-link-1-subproperties", "SWM1"},
>>                                         }
>>                                         }) // End _DSD
>>         Name(SWM0, Package() {
>>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                 Package () {
>>                                 Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},                                 
>>                                 
>>                                 // ... place holder for SWM0 additional properties
>>                                 }
>>                                 }) // End SWM0.SWM
>>        Name(SWM1,Package(){
>>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                 Package () {
>>                                 Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},                                
>>                                 
>>                                 // ... place holder for SWM1 additional properties
>>                                 }
>>                                 }) // End SWM1.SWM
>>
>>     Device (SLV0) { // SoundWire Slave 0
>>                         Name(_ADR, 0x000032025D131601)
>>         } // END SLV0
>>
>>     Device (SLV1) { // SoundWire Slave 1
>>                         Name(_ADR, 0x000130025D131601)
>>             } // END SLV1   
> ... but here you have two different link numbers.
>
> I interpret this as SLV0 on link0 and SLV1 on link1.
>
> So what's the issue?
This solution works fine for us. We have shared sample DSDT for reference.
By reading the ACP configuration register, controller count information is retrieved.
Each Controller device scope has a single manager instance.
To support this design, we need to create two ACPI companion devices.
Under each controller device, one manager instance device is scoped.
In this case, we will read "mipi-sdw-manager-list" as 1 for each controller.
As per your review comment, we can't go with two ACPI companion devices
approach due to Windows stack limitation.
Windows DSDT implementation will refer to single ACPI companion device with two
manager instances as mentioned in earlier reply. We are going to use the same
for Linux.


