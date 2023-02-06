Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CD68B593
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBFG15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBFG1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:27:55 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872ED7EC7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:27:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcZY68y/zGR+Qdtf0BbVw0Gjtgm7NcHaL+SbFxAotO0EEF5ngOYa2yjBsKai/2///6MjmCChEvkgi/sT7UAKg4VNIXF7OJCtMMre/usK3E36L5I+24vE2qUijpZ74WwXd5t3KP9W4AOtiaslz4j80v9UJiwGl14UKh39Xv2L0VcjvI0v6Krjh1kyXULt6DEcXwy7R0f9jZ2lt/oE0N6cVaVKSIH7bqSve7wT3Wo/l5vkTMks4PKWyZcXBZ/Wgnbx3pLzEjrpEPj5d3xpElFWdCTNcsRM99ndyX7svEp139akPQiweEJCLuOQuNMlX3f+bUwnjSqlKd1UJPESRrAGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PugNNG/wJvCRnWb3cKhKkgbvG41PxAP9/4J6t0Hk86c=;
 b=MyjqP+R+2rezIQc9c0UrhQjSCcTh7H1Uz7nJBS+hxgquBEzOaViieW8qUqaCpa91EzKqPlXjvffFrNbaA0ZvLkyyXrHfN1IaMRUe7JQzwj4v4cFdq1SEHR2FZGo5gyFkNdDLeXra5MJ6U5fTK0ULmEO9+tsqs7HNu44A08dODmQC31U3kVnwAVRtVNKs2nu6ZYYZ/hogVltsPjudhdFKvXh4yf7Aqaul3+OJYZaSNqkE4HdL/xbM+eSp4GTlDuMct5uEsB+GeAw+9DTacegs92Pg58f8gxA1e+hoaPUA1Ev798Uev5GGlyfb/76FMBidM+C0QxT7Ve45TY7Lmndusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PugNNG/wJvCRnWb3cKhKkgbvG41PxAP9/4J6t0Hk86c=;
 b=hOlouhVwPEbjBGvr5eNUwNx596Hco5pVF3BvmSvqTHon4WqE4v1DjqQFqornu4Ks3vjAIiPTMAE7TbmEs5Gh9pz+A9ITcqUFDtXezI8ZZYBmbYfST8zt1GhOtjCJ5GOhSFfZWiKmkXL9byg7qtRZHUIUKHvfRhjXI44q7TVCD4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 06:27:45 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%8]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:27:44 +0000
Message-ID: <4c860ef0-d22d-5c2a-9657-7e2436b00101@amd.com>
Date:   Mon, 6 Feb 2023 12:00:44 +0530
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <1473e1e9-b368-d8f3-c1f5-1b64e6e2ed90@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::15) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DM6PR12MB4926:EE_
X-MS-Office365-Filtering-Correlation-Id: a36535f9-bf9e-4758-7521-08db080b41a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXqhEKlBJNoY8FHKsbAk+1bl+XeTmznoPEfzSlgPiJL/I8ES4jQ1SPHS/psgKoTAY4XVU+5Y9qB+SsEVzNPya6YCMJy5Qt0S/9VSvZuzSybEBcsBfAwRm6Z2xbnVqA3azN9ocBbc1tEseXt23LAAadvnCu45WiLxiukvCWJAPYzD0ItT65uYIfdnMWAjSWoRQBsascnB0All8FOPwn9gRWkxKKBYaliTWTpk7IQcgCPq2LTJpRrgpYLeTZQOEHtWgVRyTWPlHGaWYC67aNf0omTI0Aa4kKn/exvZJZ9tYRSRWvcNaAoI7uEyG0/SHog7bW06kJ0qHF02v3u9Eqyh9EOPRnvjlNCXMu4DqT/KHiFIkadvyX0XNempFsiGuFFDmZMz8mwhmG0q06fS2/0mu/VBWxX73HwR21VLkJ1Vz0cmisZdZrUYZ3aYOIHEG00CKGUZV1q5/GnLHckPy/U/EmRnsdNLZLLPiRd/qkp3Kb/iqCnqi9TjmOc6+WQ8c37T3g6rlpOu1JK09OaUDV0Aq1XHjutb8eroqK1NvPEXU569syrrk854uP2bdCWGyNtFGC70C4jr0s8CTjM+u9bJnJ+gSmB48j7s8M4ufD5okIlzOKHNH1jtXGWWtO/mRCaddYeyO9yFlTaYEoE9oort25eWsmof9qMmfF818RDkv56didQYZlS/gx2LOFVn0k9O9AGj1MVHODxW6tNl/JS7f9PcoBcPEaWp+siMtRXCcd6i4gUNa2GBFWcVQkaEqvHMZzfmuxRCVxRXgNrfNvT2TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(966005)(478600001)(110136005)(54906003)(316002)(7416002)(6506007)(53546011)(5660300002)(2616005)(26005)(6512007)(186003)(31686004)(31696002)(36756003)(6486002)(86362001)(38100700002)(83380400001)(66946007)(4326008)(8676002)(2906002)(66556008)(66476007)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUF4c1orSTRwbEEwUGZlbXFmQTM3OTRPM1FXWnVMOFk4S01qRHRPRU1IT2xY?=
 =?utf-8?B?T2hEbzllS010QytOK1lKTkRyRlFDM3VTOUwwMkZzSitlRHNBSWVUN0F6bitn?=
 =?utf-8?B?cWJsK0JCajIyQ2w1N01qN0lIRytFcUFBVWdZcDZHR1ZVZ0xaNyszakZhMSti?=
 =?utf-8?B?bFB4YlVoak5DQ2RLZDB1ODFiVldpN3NOOEQ3ejFnbERXOTRPYUd5bUhmQzVa?=
 =?utf-8?B?am0yV1JVU1hTTEtiaGFjanlNV1NCTkUvZU8zVGVzNlRzNlg0eHR6UWNNK29l?=
 =?utf-8?B?cHFubkZwN09MSlVKbW1qc1JkcnRlaThjMEJhR2JBU1NrV05DOHVzdThONXBa?=
 =?utf-8?B?TE5MdUVSc1EvQ2FnWUhxak9xb0NBVXVnSFIxRlNzR2dpdU9rSmNhOGVUczky?=
 =?utf-8?B?bUFsRlk3SDE4Q3B1dk9sUjd2SzhicERRTlA0WXVjMlFoVVJjMVRMa0U2SndU?=
 =?utf-8?B?QlBSWEpBczhFdldBRVZRUlA1NS9BeXpnUFRCLzJ2SXlhekRSOE5CRVlhZVNk?=
 =?utf-8?B?ODFIRVRySWx5RFFDTk1TRjBUTTB4N2NNS0N4MVlyS3c2SjFVNVMxbmNsamkw?=
 =?utf-8?B?TURTR0hMSmRlRm5KNnFPUjk4OG5VYkVsUFNQZEhlRFV5YUlPdFRZYXk2aGJB?=
 =?utf-8?B?M2ZxUEViYkNTd1BQaVpZc2VYMG5Ja2I4Tm45ZWtkV0pLNitDeGRkZzZPcFV0?=
 =?utf-8?B?RVp5K0IyNklOVlBoSDAzbERvNHpoVXBRS0xtTTRwRisvb2h0b2YzTGVvdFpo?=
 =?utf-8?B?Wi9zTXFETUZQdDQyemJRUGNHR2xwYW5rM1o1NFRuV3N3N2VIbkhRMkNHb0to?=
 =?utf-8?B?aHF5RlJvUUZobTJMM29wL3dTWGlrdEZrVmlRUk94a0t0dWZ2SXcrS1ZqNlBv?=
 =?utf-8?B?bkU5UlBYbGNRUi9wUVgvY1FvWmcvRHhNWmozVVJKdEExQnAwN1orRllhdENi?=
 =?utf-8?B?NStrTmlEMmx0azZyZ1pURmZPTExkeklLMjRFQkFtTk96TlUvU2FUbGh4Z2No?=
 =?utf-8?B?S1JEMnVQZy9FYlBTMXpjYzlZaHpPQ1ZxOFkzTUVVMWszaFRMR3FoY20rSkd1?=
 =?utf-8?B?ZTlmbVkwdnB5WkxZYTgvZWR5T21KdFR0MGw3eFNWR2E5Vm01SjJ1elZ0Wnl1?=
 =?utf-8?B?bHpoNGJYUXJYakgwYm5BZjFrNWEzbDBGa1gzQ05ldkpZdFV4UmFtQnExL2c4?=
 =?utf-8?B?eVlDNnZMYnpIZUZUUndPc3NhUkdSWklDR29hUnpFMnRORzQ1MFNWbTkxZmVu?=
 =?utf-8?B?RFZDY3JEWFN3SG0wZ3E2Y0dQVHRvVUdIMVd1Vm5IN3U4c0RwNE1mSEhMQWsv?=
 =?utf-8?B?OHQxOEx4YWowUUp0blFhLzR4c1NvRUlvcG9NWHNjcFduVlQyOVd4TUk4ZG5v?=
 =?utf-8?B?UHFBVm12WFBxYWppVE4xblNsSklWVmo0U2ZWbFo1aTJ5NG0zZXRmSlU3Q015?=
 =?utf-8?B?VXlyaWFhSjl0dzF6Mk04OWM3SlhVdjROaHNpOXoxOG00eTNkMnZOUEpvY29Z?=
 =?utf-8?B?WXNYT1ROSkhFbkJDYlc5d0Z2VmR1UmwyN2FyUUIxb3hzeW5ZZ1NOUkRvVERO?=
 =?utf-8?B?bFozVExaWGpvWkZRQWR0NytsRGJEeXJHemgwaTVaSHRUVnhIU2hTQmNyQkVn?=
 =?utf-8?B?bENpOHBqeU5zMFZOMVFzYStndnNtUWprQ3NzZDZXT1FuR05mSWFvS3ZMYTB1?=
 =?utf-8?B?ZW91T0JrUVhxT1NpcXB6UDJrN3h1aEVndkN6RjNVY1VWVDV5NzNJUnFNZU8v?=
 =?utf-8?B?cFVRTlIrNXVJVkFBbFRXNFN6YUVxM2ZRd25sakZncmJZWUc3N3NNeWhZZXN6?=
 =?utf-8?B?aGhGalp6UEhhVTFJL0lPRm54cWp1dXYvOExTSFZPWjVUTzZCbTJ3cDRVcVBS?=
 =?utf-8?B?bk9KTEtZVmJWUVQ1cytWY2tISktDMUlwdlB5TlhYcXc3MG9VcGhOaVVwY3pi?=
 =?utf-8?B?OEdrUXF6VVVRZFA2bWc1Q0tadUF0OHc3RnhjRkJxeDJOVXVLWmVmV3V4WFM5?=
 =?utf-8?B?dGNvZjZwZ1AzVlZKVGl2emwzYnpQOWN0RWhUMEtMbHhIbklPNEw2L29JLzB6?=
 =?utf-8?B?RWZlQXBFY2dWejFEeHgrRG01YjZQRzZ0VFYwK0l3VFBTbDFnbFNQSnBCczBD?=
 =?utf-8?Q?5JDoneMIkjudwkbGet3XY7Yad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36535f9-bf9e-4758-7521-08db080b41a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 06:27:44.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCR4RojTcLrnjnC6cyUwfDGJCA1VuFxmz9AEhKddv3YST8Ouj+s06y+cPASal6Qd40dQR3tG73vhbITZJa1hyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/23 04:38, Pierre-Louis Bossart wrote:
>
> On 2/1/23 00:01, Mukunda,Vijendar wrote:
>> On 01/02/23 09:22, Pierre-Louis Bossart wrote:
>>>
>>>>>> In above case, two manager instances will be created.
>>>>>> When manager under SWC1 scope tries to add peripheral
>>>>>> device, In sdw_slave_add() API its failing because peripheral
>>>>>> device descriptor uses link id followed by 48bit encoded address.
>>>>>> In above scenarios, both the manager's link id is zero only.
>>>>> what fails exactly? The device_register() ?
>>>>>
>>>>> If yes, what the issue. the device name?
>>>> device_register() is failing because of duplication of
>>>> device name.
>>>>> I wonder if we need to use something like
>>>>>
>>>>> "name shall be sdw:bus_id:link:mfg:part:class"
>>>>>
>>>>> so as to uniquify the device name, if that was the problem.
>>>> Yes correct.
>>> can you check https://github.com/thesofproject/linux/pull/4165 and see
>>> if this works for you? I tested it on Intel platforms.
>> It's working fine on our platform. As mentioned earlier in this thread,
>> we can't go with two ACPI companion device approach due to
>> limitations on windows stack for current platform.
> Thanks for testing.
>
> So if you can't go with 2 ACPI companion devices, what does the
> 'Windows' DSDT look like and how would you identify that there are two
> controllers on the platform?
We are not populating two controller devices. Instead of it, we are populating
single controller device with two independent manager instances under the same
ACPI device scope.
We have configuration register to identify sound wire manager instances on the platform.
Below is the sample DSDT for Windows & Linux.

Scope (\_SB.ACP)
    {
    
        Device (SDWC)
        {
            Name (_ADR, 0x05)  // _ADR: Address
        Name(_DSD, Package() {
                                        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                        Package () {
                                        Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
                                        Package (2) {"mipi-sdw-manager-list", 2},
                                        },
                                        ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
                                        Package () {
                                        Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
                                        Package (2) {"mipi-sdw-link-1-subproperties", "SWM1"},
                                        }
                                        }) // End _DSD
        Name(SWM0, Package() {
                                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                Package () {
                                Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},                                 
                                
                                // ... place holder for SWM0 additional properties
                                }
                                }) // End SWM0.SWM
       Name(SWM1,Package(){
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                Package () {
                                Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},                                
                                
                                // ... place holder for SWM1 additional properties
                                }
                                }) // End SWM1.SWM

    Device (SLV0) { // SoundWire Slave 0
                        Name(_ADR, 0x000032025D131601)
        } // END SLV0

    Device (SLV1) { // SoundWire Slave 1
                        Name(_ADR, 0x000130025D131601)
            } // END SLV1   

    } // END SDWC
}

