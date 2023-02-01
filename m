Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AB685CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 02:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjBABmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 20:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjBABmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 20:42:52 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8EB521E2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 17:42:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHa6n4QGwx2yFzT7zZReI7b0OelV/7V4XuWCkHuzyUtfKJMgaV3IWfcjT9+0eARLNBuUeZR9ptUosW725Zb69uG1KAd5PNDNZPtKQ+3h7yNog1kufIO1KiLiJS+aQz+dbExqhyD2ua1RwSCAgiRWxYevvVCqQrtp/vH4/R3eWQCN3H0qg54bcaZcQBn4Va8X0LoX+RWxCP4ydEbd2r/GvPjPjSJyZhQ2YNVBBmDg68mgOvgWFc+9Lf76z/Gk0kInybWFs8i6MQphU2GFeiy9TxL6oKraaMEg7xngkhA9BxK97eS+WIfym5v2BtpyoHI0nPl+tE0pMAaP3aqJSVmsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q45O4V1iKF4vLx3rr7rvc+FxlqEVAswFn74cPKosQmY=;
 b=hngkvkZnSU0+2DyvHdpcFVG4lzRS8GfPBAqIEubKcb0OfcSh1KvbPfpdNvYD/lkXqlkmYao4b3JwTGMlMqNWj9nvx9Li8asS52kQbDk12Evqrtzj/jzpx+wbAt6tBHAYHElc4NxaY4mOUs1f4c3TOuHck6X0Oqm+7vHaVXo3MKX4Y2tbvyVOzIfssPWoOo4wsF7FzEscfRHWL+SGWvkC9dNYmd6kcUujhS6ofJJOTKPaTMhfRDTprj5epmctA6HDeOBRBWwNw/dKtR/dn3HYp7cTdCGF6NQDKDE04WWbxQlx1zb+N8mSc3Jw8264voChWlSfvTS+nI3EOVPPwWsZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q45O4V1iKF4vLx3rr7rvc+FxlqEVAswFn74cPKosQmY=;
 b=BppNSlmYRd2bSr1Mu/XPdDupkist9ObMU5g8civk8eOn7neckOK+i6wIvbzoi8DA6q73demjb4FXzl2YfpxsxHdBXcqjCPTTl0z73Nm69uw6za51iB3u7QBpFAXW18roGufIXu6LCA5qC2UUpyCDiVc0ainllwGr7N2yoWELr9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 01:42:46 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%6]) with mapi id 15.20.6043.038; Wed, 1 Feb 2023
 01:42:46 +0000
Message-ID: <2ea354bc-4263-1db6-4423-4de1b0d4e535@amd.com>
Date:   Wed, 1 Feb 2023 07:15:52 +0530
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
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <c5161bc3-62cb-d0a1-2ba2-d670285b6958@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::10) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb5f5c9-5b5e-4679-9efa-08db03f59e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3sZB2XcgWWNNUwO4BhFQS78Gm2vI4o1jl1UtcGGa0ajabacpl6Y72kePmdsREZgEYpU624cVEeDYve0qil4z3kS7sN8EvcIl+MqIkEMYLNEOCbv/dFCg1097PfttAzy65MyF/ZN7m33RF5no3o1mLwQHT3dfKkluXLFP6AchjhTLkYDK/k8MTEtoGcUczygW3pF4tlJ3apCHFPY435lCRxCrI6sIyMlkBGeHlaHg8KK7EgwQCHQUz9eaLDXZuYLIa928wFdlSphHSmKPd5Bo9dBH/jx30c+EgFpbEFXWzRbR5br51VsBS05eU8k1diySK7+36e2ww6IUktSBYdRUGB2NuRJnN1BjbAJZvsC3Hd4f90wib3zpJhNf2/LPvJCEnPw3Kz+i1+yObHS6M8Om/tawdc6OD8nqhWnWTg8470uPrONX1niw3YCR0tRjbR24np6B71HpVq5qPXU+XPjeGZJx/95jcf8463xhzJDkbc08MmqL7HWNavhJPJb/p3Huxt5wGnYFWD//6q0Pn+/WPGiOhjAWLXNElGtsI/IFgGMgmV5iRxO9jxCXcZkUARVZ0IrBu+gBMCW7X2b6WA6IBGz2xo4C0pCnzkxlyK6RBJHlBeQ588ABbfMhOz7KyyFiFNFQ4hHcN3/rtkHCj56aZjJ14LB/FvzlnqcBNE7FuZFGiqqaJdjmFCw7zt4493SowlidkJi4jpHju2uuynH+fOziYARJycd25cIUcys+krY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(31686004)(66946007)(38100700002)(36756003)(2906002)(5660300002)(2616005)(316002)(86362001)(66476007)(7416002)(31696002)(66556008)(41300700001)(6666004)(4326008)(8936002)(83380400001)(26005)(110136005)(54906003)(8676002)(53546011)(6512007)(6506007)(6486002)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE4xM1c2NHZMbGlVdWtIZzJ2UUR4aHM3RWhJdmNydzJ3L294TVVYa0JsOTFo?=
 =?utf-8?B?NmM5dEQ0VTR0TzBpTUcycmk3cGlXWWEremxZVXlOTUV0U3JkT3lWTzFmNkdG?=
 =?utf-8?B?M0FlNlg0Z2t6QmtEcG0zS29idk1UaXlZMHlpakVTS21IWGZIWWtkUk9UbUVy?=
 =?utf-8?B?eWdOdEpCWWhXa2pieERVZ2ExVkw0c1pjbHR5SFdtVDQyWXl5NXpMa09IOHRG?=
 =?utf-8?B?b24rY1lBOVhxQVJweXp4aVFoY09wVnA0ZWlOZDBDbXZ6WFVMakI3bkVUemhq?=
 =?utf-8?B?OXBkQWxjMkM2Q21RNEZwVzNGZUIwUHRJaklKODNhR0hYdjhUZHFQejZ4QlpI?=
 =?utf-8?B?Wi8ydHJHZXlPM1NpR3prbUF0cTU1blZYL1FmUThERUgwYjJmVkxTZm1kdUdM?=
 =?utf-8?B?Tnpma3NnSHdUbzhMakwwcFFhV2hPa3BKT3p4cXlFTWlQTVFXeSs0VTBjVWZr?=
 =?utf-8?B?ejRKYktXRHpsaGxmYmhrVllUYmp3WmNZM3REYW16TnVWczJwdFVOZjdvQVBE?=
 =?utf-8?B?L3YxbUoyZkpYZ3FSQjU4Yk0vbURhdWZtRWsvb0VuYWFNaHZJUXYvV1VpdXF4?=
 =?utf-8?B?ODlaR1FMU1RCamhHT1Z5SE8vVjVZT29JN3BOdG1xclBueFVTYjNxbDNzMDYy?=
 =?utf-8?B?N2JOSGtZUWRJSUl5YVcvSHRLdUE1TjAzMHBBSXY4NVJROUZYcCtVTDBBalF0?=
 =?utf-8?B?MzU5STQwN2JsZzkrWUF3eXBkb3hnSzE5ZHg1Nk5nUlRVRmYrUndnN3N5VUoz?=
 =?utf-8?B?dlFLUU1DOS9EMTN4SGpNcFJGNVRXSElaZDY1NktCZjBBQU1FcmgrVWl1dEJj?=
 =?utf-8?B?RjlvS1MxT21xUzV4ZGloYkFORHJNaWhaaCtKRU9jYmRoWW1weXVhWmhQbHBn?=
 =?utf-8?B?Y1NneHFCQ3NiT2RiOTRHcUdIbjZtdVh6OG9GVkJHWnNhVkJsTEp5ZlZnd2Nz?=
 =?utf-8?B?UFlIRFFTbWV4bHkrcjZ4cGs3NmtDTTlURThaeGp2RllYMHZOV2J2QnpKRStB?=
 =?utf-8?B?Wkp6MXpFcllnQ08rc054bHBGbDk3MUFBNVFwWFF4VnFUK3pqeGNESERLQ3Zk?=
 =?utf-8?B?bCs0UVpWNHlqY244UElYY3hScU9Vckplbkw0MW5mNTd6UHRHcDV1Ty9jZ3lH?=
 =?utf-8?B?bGJQdHR0YmU0RjBaOHZsTFZEcExjdGkyZVUzWUduenMxVktMU3FrTXlhdXgx?=
 =?utf-8?B?TkJPblZWWmdIVVNPWnZHTTgrdmoxa0Y1MUNIQkMyZThPYjFaOG9pbkRBM0oz?=
 =?utf-8?B?RGFicGxscGh4TS9kdDJEVlRNTFdrb2wwSjR6U3lBR1kwM0syZlQ5MXVuM1dS?=
 =?utf-8?B?eTFPaXpRcWJBOVJaOVRYVUhidENWVFNlVWhKZnptUHlRbE9jeXlxcGFCU2NN?=
 =?utf-8?B?cG9IdzRySkdhNVJ6ckt0eDFVQmZKR3JuL1IvWEt6VlRFYXhIdjkxWERaa3Z1?=
 =?utf-8?B?Y0FOMlpwcVFQS0h0THhENlRoeE1vckpJNDhKY1pnOXAzVW9qOStBT0FVZFVE?=
 =?utf-8?B?bERtbXNRU2dvYWt2bm1weTV1eDJiUGZQSXpsbWlidWJqQVhaa1k0cG9JdHFr?=
 =?utf-8?B?VXpnMXVmWHZQbWxhcmdsN09oWlFtM1JuQ2kzNEtpUHR5YTJsRm54UlplMC9z?=
 =?utf-8?B?VnM0dVQ1TUs3amc3ZXF4VEJ3bVJnRDV6MGhDbEFGZDVNY1Vuc245b0RNT3M5?=
 =?utf-8?B?UjJiTjNvaExHL0VZQ3dPakQ1eGpkMzdVRWxrWC9zVEluUm1QNTUrWUwvOXRH?=
 =?utf-8?B?TlcwODFBY2wxNDlpdVhJMmtTdUJ5OXFCazVralNhTVdOeFJ0dTNKSDFCaXBy?=
 =?utf-8?B?UVhYNndUOGZMdXk4MG9aOFRPVmZqaXN2Z0dpVGo0akZuaGtKZm1KSTNDQ08z?=
 =?utf-8?B?ZmlNdnRSRERVODdReUlCZWY0dllmQUY5QkVZTFIrN3pBNEhDQjVQcXBVMlBN?=
 =?utf-8?B?MEFvLzhubVo3SUJCYU1vSE9Hc2NkUmhLWFJkU21GcGJLQml2ZzFVamxJc0ZI?=
 =?utf-8?B?VUxCQTRFd3F5NVFIN0JxcTM0dVRIdzNpdmlmRlRQdzRzVHZ3VkpZaGpERlNW?=
 =?utf-8?B?UTdKVnlTdVErOHRpb0FDcFdYamZKa3BibmtEcHFJbkxadUZUKzlLR1pXY2xT?=
 =?utf-8?Q?Ujgp9HC7Q3NOXNmVz2cMVjzb5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb5f5c9-5b5e-4679-9efa-08db03f59e11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 01:42:46.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCmTe0fl1+3q7vYSCcDGSzdAGx+lK71OUGfHqpVjbQybun+VP0PXf+DzE+kJlKMyps2ja1/5IkTrZVF/x/uN7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/23 06:21, Pierre-Louis Bossart wrote:
>>>>>>> we should create two separate ACPI companion devices for separate
>>>>>>> manager instance.  Currently we have limitations with BIOS.
>>>>>>> we are going with single ACPI companion device.
>>>>>>> We will update the changes later.
>>>>>> Humm, this is tricky. The BIOS interface isn't something that can be
>>>>>> changed at will on the kernel side, you'd have to maintain two solutions
>>>>>> with a means to detect which one to use.
>>>>>>
>>>>>> Or is this is a temporary issue on development devices, then that part
>>>>>> should probably not be upstreamed.
>>>>> It's a temporary issue on development devices.
>>>>> We had discussion with Windows dev team and BIOS team.
>>>>> They have agreed to modify ACPI companion device logic.
>>>>> We will update the two companion devices logic for two manager
>>>>> instances in V2 version.
>>>> After experimenting, two ACPI companion devices approach,
>>>> we got an update from Windows team, there is a limitation
>>>> on windows stack. For current platform, we can't proceed
>>>> with two ACPI companion devices.
>>> so how would the two controllers be declared then in the DSDT used by
>>> Windows? There's a contradiction between having a single companion
>>> device and the ability to set the 'manager-number' to one.
>>>
>>> You probably want to give an example of what you have, otherwise we
>>> probably will talk past each other.
>>>> Even on Linux side, if we create two ACPI companion devices
>>>> followed by creating a single soundwire manager instance per
>>>> Soundwire controller, we have observed an issue in a scenario,
>>>> where similar codec parts(UID are also same) are connected on
>>>> both soundwire manager instances.
>>> We've been handling this case of two identical amplifiers on two
>>> different links for the last 3 years. I don't see how this could be a
>>> problem, the codecs are declared in the scope of the companion device
>>> and the _ADR defines in bits [51..48] which link the codec is connected to.
>>>
>> The problem is that there are two managers in the specified AMD design, and
>> the codecs are both on "Link 0" for each manager.
> You're confusing Controller and Manager.
>
> A Manager is the same as a 'Link', the two terms are interchangeable. It
> makes no sense to refer to a link number for a manager because there is
> no such concept.
>
> Only a Controller can have multiple links or managers. And each
> Controller needs to be declared as an ACPI device if you want to use the
> DisCo properties.
>
> The Managers/Links are not described as ACPI devices, that's a
> regrettable design decision made in MIPI circles many moons ago, that's
> why in the Intel code we have to manually create auxiliary devices based
> on the 'mipi-sdw-master-count' property.
>
>> So the _ADR really is identical for both.
Yes Controller has ACPI scope. Under controller based on
"mipi-sdw-manager-list" property manager instances will be created.
Manager and Link terms are interchangeable.

Below is the sample DSDT file if we go with two ACPI companion
devices.

Scope (\_SB.ACP)
    {

        Device (SWC0)
        {
            Name (_ADR, 0x05)  // _ADR: Address
        Name(_DSD, Package() {
                                        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                        Package () {
                                        Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
                                        Package (2) {"mipi-sdw-manager-list", 1}, // v 1.0
                                        },
                                        ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), // Hierarchical Extension
                                        Package () {
                                        Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
                                        }
                                        }) // End _DSD
        Name(SWM0, Package() {
                                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                Package () {
                                Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
                                // ... place holder for SWM0 additional properties
                                }
                                }) // End SWM0.SWM

    Device (SLV0) { // SoundWire Slave 0
                        Name(_ADR, 0x000032025D131601)
                  } // END SLV0   

        } // END SWC0

     Device (SWC1)
        {
            Name (_ADR, 0x09)  // _ADR: Address
        Name(_DSD, Package() {
                                        ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                        Package () {
                                        Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
                                        Package (2) {"mipi-sdw-manager-list", 1},
                                        },
                                        ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
                                        Package () {
                                        Package (2) {"mipi-sdw-link-0-subproperties", "SWM0"},
                                      
                                        }
                                        }) // End _DSD
        Name(SWM0, Package() {
                                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                                Package () {
                                Package (2) {"mipi-sdw-sw-interface-revision", 0x00010000},
                                // ... place holder for SWM0 additional properties
                                }
                                }) // End SWM0.SWM

    Device (SLV0) { // SoundWire Slave 0
                        Name(_ADR, 0x000032025D131601)
                  } // END SLV0

        } // END SWC1
    }
}



In above case, two manager instances will be created.
When manager under SWC1 scope tries to add peripheral
device, In sdw_slave_add() API its failing because peripheral
device descriptor uses link id followed by 48bit encoded address.
In above scenarios, both the manager's link id is zero only.



> That cannot possible work, even for Windows. You need to have a
> controller scope, and the _ADR can then be identical for different
> peripherals as long as this ADR is local to a controller scope.
>

