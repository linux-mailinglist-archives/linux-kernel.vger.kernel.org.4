Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD91685D0D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBACHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBACHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:07:07 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D150D442D0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7MDyrJGgv+GQQV1XHXp7s1BLCFtk7mHdx/lFA2Ge7j59Er1UKiKUnvtHFKNTDGvBZhlqvRh6eNTzhEL2AvAOAM6RufoL9ai+b5gYypgU5LSSN1PMSnZ+FtSh9NEjdnV3PMR9jQccoozNwV5mPJlfMgADMP1Das+2hpgGHDpm54deFDs3y/iSd7rLkUUKfAshCpZx5pIzf65OPHMZMSMSSNrabzXmkERyHpKgsgcHrL3PnIOOJmG/PC4LVwekdz1kwOHfVkvD7GhGntTHOa/2kh//1bBzG1fbhHfn9nXJjngWKCYrXdhlze1UgeehwgCQ23RtyAEXzjX3jUe1F325g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWj/ALgzTzzd7HVnOzAhgER2X87vVBfOSRCX3owDelc=;
 b=J/qIl5z3W10BOj/3j+qLUsjVKSKx5zTI/ixijxNp21E4jblO2GjvUJdW49X/MHvlKak2BGFi7GbkuWsm0yf8kbwPNlE7vT0hTBXtG5jJl75VxBCjjJutcayq5Nry6sXAyuSGfynpDwa01BuPa8pmYd/CRIf/Rfu1Np06NJg5AqO7pQVQFqzQOUYNx5OhycU1WKXF+EJMkvT742kunpfWXHavegstv+a0aTBdVs7kIHpiucAIFJTCZhaSDfM/AJDfuQc8CgR/LHWAM2sgNTCPrnNMXStPDjTHhJ9WdpBzkrCBGdq44Crt9UOFMtqy+JXvigg+amUcGnsxTt1ptLLRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWj/ALgzTzzd7HVnOzAhgER2X87vVBfOSRCX3owDelc=;
 b=FbIRUsMifhMVGMbJBQSjAu2KnkTVfWji1mpxGePJgqFdFeek3HVLD85Yq9Pp8SH3EUgK4vsLfCRcC+cgOMnchsU/Q8pzEaauY8s1tT0jzpBmPpyOJwwYx7M2a6AqsfH18ZS9gSZ+p0PxStyYogq9BdF+TtEJDf/DLy2iND1Po14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Wed, 1 Feb
 2023 02:06:59 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 02:06:59 +0000
Message-ID: <ac734e4e-2f61-b9b8-0751-4e3293084696@amd.com>
Date:   Wed, 1 Feb 2023 07:40:04 +0530
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
        open list <linux-kernel@vger.kernel.org>,
        "Hiregoudar, Basavaraj" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        "kondaveeti, Arungopal" <Arungopal.kondaveeti@amd.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Saba Kareem, Syed" <Syed.SabaKareem@amd.com>
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <815ab487-a1a3-1978-94fc-b60e931c2848@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::21) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 68702e90-943f-4d4b-3184-08db03f90070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpVo/jYqiyZnRBJzJ/Xbz4NRBiXhgT3JSIxE8SkyLKgVI842fa/Sxt05kfNSyCuRGLW7YVXx5M/r0Vhd6Cz168JnyAF1K+9OI/0zZNWJF5vEOpKXzZJvbpdSWgoCUqckB89tmqAmnG1A3vNrGrhz3VRtMOZT68Dc4pwXpK+1Sd5gwA1GT55MtYEEcwMy0lG+Z78BSRJbxZVsPsYAPvFBrwwNlh/BnlBdiyRba5nr30LFmIPp/dQg36oU18uBq6O42OywsxEkTq+ayd8G9Onyvnp4LQlzue+bG4N21v3WY2Ve3M/THecX2CxqGnkGb2LqZbnqVfb8oRiPgSdd/pCiNpL9XTBa7Ue1PT2IqdM4edrauOyPemNztQYzpcGK5i+0ljj93+ycDXH80GnDLGaRNr84utwaWIzevTNN8aFLfVVUkPpxq+8R56PTzGKFyU39DC3MZhw+hEI33apLaqMXphf59V/SjMhfmIVe/+yLKRSXU+8gd5WLWL/vJ0426YkhX6LvMRXmZl2+e6YQzwgUQHW9SzRzDWcGynF+O4PVjROutAw+xAg9jYzffknfw/cY/Wy3a1MBFmIm0WmHZn21M4OJ659OteOfbn87oTfB9YU3pb4M/QNmZPiCi1r/U5Dy0EE4T9mgk+KEwh4zcQuI79Yic+Kk8DqDEq3/42y31mGzVxsyH8ctISr1UFCMJyhm2/AgAFLGRAWJg5AHsG8/YPmp3BAqphd6seRoD9jVP64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199018)(86362001)(31686004)(36756003)(54906003)(38100700002)(7416002)(110136005)(2616005)(316002)(6666004)(53546011)(6486002)(2906002)(5660300002)(8676002)(31696002)(478600001)(26005)(66556008)(186003)(8936002)(66946007)(4326008)(6506007)(6512007)(41300700001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d091blgwdDBFOVl6cy91NUtUY0tWaVExRWlDZjBCZXRsL0FYcjBGUG9XNE5Q?=
 =?utf-8?B?azJDQUhWK01tQTRqUU82czByUkY0K29lYXo4MzRGd3lBWFJDdHhUalJwL0xz?=
 =?utf-8?B?RHdJQVFhN0psb3l5a2hxRCt2L0R3YlZrRzREWkFxNVhNdStDN3dJTjF3YjFG?=
 =?utf-8?B?ZW9IM0JuNlUwdUNkOEJNeFpIdHRWaEZoam4zZkx1VFdaeGVXMGpEWHlnNjBP?=
 =?utf-8?B?a092VDc3QUVKR1VheWJVL2gvbDRrVUhWVnVzV2NZUnFIOEhzaUtHOFpQTlZH?=
 =?utf-8?B?Y2hsb3JyZTFPQVh5aE5XamJ0ZHlUMXVRMFlYbkNuWHp3MFRVVW9ZQ0ZKMXEx?=
 =?utf-8?B?ZTh1eFVwSW9SaWkwVklRVjFqRG9TNlAxMktBQXNJY3dzSmtlQnMxN2M3R3lZ?=
 =?utf-8?B?VGVsOUJhcW11cGJyMG5oYVdkbCs5N0dZQWpmYjJzUTZWNjdVSXppU1dTWmFo?=
 =?utf-8?B?SjI4cHN0OTQ5UUc3UHl5RUhrc3hnc0dwcENtVm93Y0pPYzJTUnZ4clpGTzdp?=
 =?utf-8?B?SUtISU1oZkhwai8zMzlDalZmdDVNVWt2RFRXUGd4UjVMWUZEWkxidTN4dVUr?=
 =?utf-8?B?dW5mM0VHWVhwMTJ4MWFrdllUVGxGQ0JmM3dyTk1uNmpDU1dpV1dHQ2k3am5i?=
 =?utf-8?B?czYzZHlrRkNpQlIzV0syT3NHUGZjY0xSdDBXQUcrbzZIVnJYOU1VTFAxWFBt?=
 =?utf-8?B?RWxwYkVGMGNSdnlHSlJzTmJab0Z5UDMxMnp1V2pHdGkyTzFmZXU4QkVhWVBw?=
 =?utf-8?B?YSt3cGlWTzBNQXhGSEZFT2FBa1hCR3ZaeW84dkFrcS9kNGhMOHpOV1ZIZ2JI?=
 =?utf-8?B?R2RHZnhDZ2VFV3ZKZ1lMWU0vL0o0MkZkZFNCc3RLUU4xRXdYdTk4WnY1N1hN?=
 =?utf-8?B?dkVDRDNzNzBTalB6Z0F4MUdYUkpCaEhiMHQ1MnhWWlVqemQxYWJRM3k3KzVY?=
 =?utf-8?B?NUJSNis5OTBFSVJTa2Z0MTgwTWs0U3VHaXlJczFMd1pKVnByRXBUMEZZS0tt?=
 =?utf-8?B?aEd4dElpcjBHd2tkMUYvWU9CMVlKTjJXTUdKQmVhL3o4RjVWcHcyR2dhZXpi?=
 =?utf-8?B?Z2p3bXhsWmpzVkJra1g1V0d1VHAzNHl1UC9Ob3pSZEh0amxRWXh2eVR3bHBF?=
 =?utf-8?B?RzhpZ1Y0RkUyc21MbUFjQWNsc3EwTjBzZU9jKzlqZ0ZxeExod3VsRVBwK1pn?=
 =?utf-8?B?N3ozL0VSeEljbHJPSWl1a2hENDc1QmJPVlRwZ2F0aVRENDYwaFh6RlJwMVJN?=
 =?utf-8?B?WU5uU011VGRFTlJpM01SRGxBYUx6SzZacFVMcitBU1FvdFBKcisrdjU5REFq?=
 =?utf-8?B?ckFaUllGaEZFMzduUytiREJ2YjhBN293YlZQU2JvYlFLTHVEUmh5cWJPQnJ3?=
 =?utf-8?B?eDFBRlVDYWplMm1jejJMNWx4YmlwSHZ2bWVucUIzMXhWekxTMkZxQUtSVXhr?=
 =?utf-8?B?RVRFOGdSY1ZSWEJsSG5BMWQxdWt6V21JSExrY0IyaVhhaFFsei9TemRiQVVF?=
 =?utf-8?B?RjRCenNBWkg4Wk10aGlsOVhMWnlQcTloRGc1ajAvZFA2SGwwek52alBqRVNE?=
 =?utf-8?B?a3h0WS91bnhYSGpPVHV4dW1oV2NrejR6a2wwem91WEY3SVlYczVxYmFQajVn?=
 =?utf-8?B?T1F6WjNMc3hqRi92TFBleU56eXcvZ3FQV293bEsydU9LRnVvOFFISGJremZS?=
 =?utf-8?B?UFVUYVBhalVId2NobFdiM2ZUeDkxRjJMbE5hV1JoYXV0c2EyQzdxeXdNZHpH?=
 =?utf-8?B?aW9UaTArVFFVN3pYNU1qWktYSzJiTXRLODkzM3JablhTN01odngvMHJKNlZR?=
 =?utf-8?B?MDhCSDdEM1Q5T1UxSE5XRWR6RFNQTHdWMGJjTys4WkdXSlpDZ1YxbHZSbXZl?=
 =?utf-8?B?S0xXekNtYWQrYU5iREw0ckNveHZrNDVtb3hvT0RWb2VOaHYyaStrU1Z3RlhU?=
 =?utf-8?B?WDc3c0tuQU9zTTU2YUk4RERZdlNVZjgvVld0RWxqSmpuTnk3TzFDcEtuNTB5?=
 =?utf-8?B?WUowVnhHNHhselRNcmxpM0RIODRZV2pHWGxPYU82N2NIaDdDUDBXVFpvV1lu?=
 =?utf-8?B?bG5wWXA2eUFDZUFWNU5NRVpSSlJBem1zczhtWWJydVVVdEZ3cllNUlhsY2ZY?=
 =?utf-8?Q?/8EZgQXogj7mGPY4LBbL+mwN0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68702e90-943f-4d4b-3184-08db03f90070
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 02:06:59.6211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3ktMem27Q20zeNVOULXsIE0Bn9KPfgmmyHknwzt2E3u+qHzNROQ7TPBXOA/MAqGwsPtTGGGth4hEqllY5EAfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/23 07:33, Pierre-Louis Bossart wrote:
>
>> Yes Controller has ACPI scope. Under controller based on
>> "mipi-sdw-manager-list" property manager instances will be created.
>> Manager and Link terms are interchangeable.
>>
>> Below is the sample DSDT file if we go with two ACPI companion
>> devices.
>>
>> Scope (\_SB.ACP)
>>     {
>>
>>         Device (SWC0)
>>         {
>>             Name (_ADR, 0x05)  // _ADR: Address
>>         Name(_DSD, Package() {
>>                                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                         Package () {
>>                                         Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>>                                         Package (2) {"mipi-sdw-manager-list", 1}, // v 1.0
>>                                         },
>>                                         ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), // Hierarchical Extension
>>                                         Package () {
>>                                         Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
>>                                         }
>>                                         }) // End _DSD
>>         Name(SWM0, Package() {
>>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                 Package () {
>>                                 Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>>                                 // ... place holder for SWM0 additional properties
>>                                 }
>>                                 }) // End SWM0.SWM
>>
>>     Device (SLV0) { // SoundWire Slave 0
>>                         Name(_ADR, 0x000032025D131601)
>>                   } // END SLV0   
>>
>>         } // END SWC0
>>
>>      Device (SWC1)
>>         {
>>             Name (_ADR, 0x09)  // _ADR: Address
>>         Name(_DSD, Package() {
>>                                         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                         Package () {
>>                                         Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>>                                         Package (2) {"mipi-sdw-manager-list", 1},
>>                                         },
>>                                         ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
>>                                         Package () {
>>                                         Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
>>                                       
>>                                         }
>>                                         }) // End _DSD
>>         Name(SWM0, Package() {
>>                                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>                                 Package () {
>>                                 Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
>>                                 // ... place holder for SWM0 additional properties
>>                                 }
>>                                 }) // End SWM0.SWM
>>
>>     Device (SLV0) { // SoundWire Slave 0
>>                         Name(_ADR, 0x000032025D131601)
>>                   } // END SLV0
>>
>>         } // END SWC1
>>     }
>> }
> that looks good to me.
>
>> In above case, two manager instances will be created.
>> When manager under SWC1 scope tries to add peripheral
>> device, In sdw_slave_add() API its failing because peripheral
>> device descriptor uses link id followed by 48bit encoded address.
>> In above scenarios, both the manager's link id is zero only.
> what fails exactly? The device_register() ?
>
> If yes, what the issue. the device name?
device_register() is failing because of duplication of
device name.
> I wonder if we need to use something like
>
> "name shall be sdw:bus_id:link:mfg:part:class"
>
> so as to uniquify the device name, if that was the problem.
Yes correct.

