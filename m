Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8E622FF3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiKIQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiKIQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:15:04 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66658C30
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:14:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsgVWPZ+XPYKmXK9f+9ZTejWTWwOgtELqrExit4CTn0262WJT6oRjktSO+arBiFHFXn9XUh5FpFPmk2ClydHq0rQL7wvkTP3C4cJkHQhHfWZpGvYpObdH3ngH3N5PnV2NsDuBksisMYld8/5MF53uLxwFZJHZPJRDB63DifJgFB6DuCnBEDC8URH3z3WPrV7vUaEHhPNjG+oP79ELqIzwsUeubJfWfbYRUMWyZnwbR1zsvmyN6GJYll7q7bLxPWgv89dORkINuA/0nm8aahRM6RgLpp4nF9u6w4IOvMp9LgZgO3sryZ7DL8AZQK3RSdUMZFuQ7ouGhI0F+0hNqsBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lDQKIQqt/Oy+5OLkFDK3QvsD8TbE630eSp+s2l5AHw=;
 b=jd58+16R07b1K0kz4tRFU96KH6QCO0Ja0+3qYwtjLjtV1NC4EsWVHHMw1CRKA+mIZlUoyemSKaYb87712A6bHNo+ZKpRKPi8oDmMW3cOSRizYTRU25B9a82OeM/Vr9Cpzzu0mTuzy9xaG2gmJ3PtG9WCkGosN3JwQUtCa3lLkpLdS8VDwjMjCaAEgWcc+QDhaB7j77uvs9PfuUDvFCPfxbxaHpieeCO17bV6u8OtZwxctCjR8c7Z1uXXxYwW2xLKyLmNqw5h14LyI3SEuSwfaz1UBABB8Q+IA5vWAPDHNe6DczoAOb+6GXHAVPN1ZPAPnwviuGTUjHzc3bhntcIO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lDQKIQqt/Oy+5OLkFDK3QvsD8TbE630eSp+s2l5AHw=;
 b=hkOl1BHHchKJ/Z6hgk8KFmFnOCV8UhZ0+BfOO067Mc1YJcz45kLFu8kggBKqd+uiUhBCvE3Qp3jar5x7LkbAde97Iwr2Tmwd7BfPqj35V9LNr3hUlZRGRkYoG3rbHnwm1QIwAzoA75Zh2WqYHodR0YshRRwYK0psKudItx0u9NY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 16:14:50 +0000
Received: from PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::43f5:9df3:a0ef:3da3]) by PH7PR12MB5951.namprd12.prod.outlook.com
 ([fe80::43f5:9df3:a0ef:3da3%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 16:14:50 +0000
Message-ID: <bca8ecb7-9f3e-2916-dd23-e35d31441ea4@amd.com>
Date:   Wed, 9 Nov 2022 21:49:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] CHROMIUM: ASoC: amd: acp: Add tdm support for codecs in
 machine driver
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, Sunil-kumar.Dommati@amd.com,
        ssabakar@amd.com, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Venkata Prasad Potturu 
        <venkataprasad.potturu@amd.corp-partner.google.com>,
        Vijendar.Mukunda@amd.com, vsujithkumar.reddy@amd.com,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20221028103443.30375-1-venkataprasad.potturu@amd.corp-partner.google.com>
 <Y1u1vj0K3m33wCTd@sirena.org.uk>
 <b384e012-31c5-8412-8b05-cd026c5d6a0f@amd.com>
 <Y2EttkwUvMReQcqg@sirena.org.uk>
 <ca006546-9b0c-34df-2a33-a4f10b68f815@amd.com>
 <Y2JVWmJsprt0xnKH@sirena.org.uk>
 <7b97682d-5cf1-8be1-9c62-41c9fbd89018@amd.com>
 <dff6e7af-6a07-587e-79d0-706fe7ec6504@linux.intel.com>
 <02a0dfa6-fb6a-25cf-4111-fb609b9b6b68@amd.com>
 <2ac3f9c9-5fa0-1b2f-de57-0774eb0acc5e@linux.intel.com>
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
In-Reply-To: <2ac3f9c9-5fa0-1b2f-de57-0774eb0acc5e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::27) To PH7PR12MB5951.namprd12.prod.outlook.com
 (2603:10b6:510:1da::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5951:EE_|BL1PR12MB5335:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b261fa-3dea-452b-e38c-08dac26d8753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24qtN2mBWUDS6TRrsIKuyre3xX4N12bQDwvD3ABQpoapOzdewg3lXjMlItyRZGusZs3zvwfW8+/FP7mYogqc8uoDT8tt6IiUF70VhWXVIA8nRc3C8rYy6rdusS8bGNCva9jsWwDehb4ZbLLfXeEpKulem+H8UuP26qisjjPCzhv744JKSTDJZVwp3r1EaCLz7rH5Rmx5a0mHAUFuDVKB6+X8EJKwvbvVIoz12a0IoGrg6pSEFkMkHsRz8ghaf2HueywPyaC9JdlbaDEVcyL/anqgTSZ8Xwqn3WzqC/EXDJe5887SRjMaDzJ1W9pFi76kCYFtSD4XlBiNoXgAaMx1zJ2Kul6mHn2uQPet82GsLfdS7toVa5SI4BHZMrQU8P1Yq3OFF+e7Vt1/Oy8lj3GMUhHKXWItah1atB/PVo+v4dj63j3uM6lM6sadjnhH9H6pOFhh0+qCpxFmPT1mMVOWlp6HWPA5lo8RhKAYsxa29ZobNJJcnSDvjZgYwCoUlnBtB29pzifyFnN4B6FvPq4YnuARvo12y5iKTwnirX0EGCJj5th1VEgOMs3zJV0pUblYbuzO3swibkpV5dXpjCJarKaNjn8JAZM2f2+xkw2SkyTEVCRB4hcIANe9bRYVGbN0orrCbYD2YwCwSTQWn/CZRbE1/gKMKWLMRNRnhxJ6tbKwrHoz1l01vP5rBXEzVljKnNS+SiFuRe0hBsYpFWiKzVLuzSWKhOflj4hK1uLcxpPAjcACYn7QLZWuuY3HaEG96Avj6Eo6GLiGofLcdi/+lvXTogn0123w8O2ibyMYBug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5951.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199015)(83380400001)(31686004)(86362001)(31696002)(6486002)(54906003)(2906002)(478600001)(6506007)(36756003)(53546011)(38100700002)(4326008)(6512007)(26005)(186003)(2616005)(66476007)(8676002)(66946007)(6666004)(316002)(110136005)(66556008)(8936002)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNWSGtCTVVoSWNrTSsxVXRsY1BiZnVUUHErbis3anpLMGhsT0lmak1hU01E?=
 =?utf-8?B?S1lqck1sanVkY3dxaHlXc2hNa3d0UzdlbVJzazZQN2Mrb2xiRHYyOVJFbnE2?=
 =?utf-8?B?UFdETUkrV0E0aVhONTFNeEF6bDlxbnpobE5aNnJKdHI2aGt6RVA4WjNMK2E2?=
 =?utf-8?B?L1gva0VFRFI1dkRUQ2pXVG5WdmJUeTdJQ2Q1c1JNZmZMdk4xbjZxc0k3U29p?=
 =?utf-8?B?UnBuSTZ1LytoR21GeUFPZUU5N2RCOTlFYUpzeVNMRzN1b3JZT3J2M21VSlFl?=
 =?utf-8?B?TkMzTVJpa1RnN3laK0FWZ1lEU01kY21UU3Q0TnZ1YXVkb3JrK1FzT3Vzd0hY?=
 =?utf-8?B?TEJuem4wOXhBOU1lN29kTm1BUzd4U2FrcmtZUW0wMms1bGxrMXdVMS82c1U5?=
 =?utf-8?B?SkJMUTdvVFlEZ3FsQ2krL2h1Z0ZHZUxqK0swTDcvMGRmT3pBSXFYbDhuZERn?=
 =?utf-8?B?Z2dZeUVoc2lQZ01SdFdKMWxKS2hVSnJta1ZuNmZnUVFxc1k5bHBjbkR1N1VL?=
 =?utf-8?B?NnVBT2hKb0JrZVFJOHc5YUt4TXBWSWtSVytYYk9oQ1ZYa0NOcUNWamVQb2dX?=
 =?utf-8?B?UHlDM1loQTN6L1AxYTlFdDBsc0prWFdLbUVJVFlRWXR6b0pONWZkL0hNQmpI?=
 =?utf-8?B?Yi9yNVEyOW83ZWFubTAzSUxOOC83Q0p4S3NWS0szMWczQW5BcmJNN21DYmJO?=
 =?utf-8?B?WUR0bUdQNG5NcHpRRFJxS3cwTTU4NytWUXFpZndMWGI3ZDBxbXJ5cjRQRkRW?=
 =?utf-8?B?a3IyRUF4MW52RFpqYlJ2VzBmRDNNV1drYldCODVWNTFUQkhjNkE3Q0JBc203?=
 =?utf-8?B?UzFQTkdyWDEwdWhUc2ZjQ1RBelB1YVJRTHNkaitTN25aZUNGT0l0dC9IRHhB?=
 =?utf-8?B?Mll3OVZqZ3pVTkIwK0NVWjVVbkp1RUtBQUhkODczWWhTaGQ3QVhvbG9DNjFG?=
 =?utf-8?B?cG8za3dvQlNRbDg4WnZmQldGZkZHblp5R2lNQ3ZyWkhHZm85M1VOYWdNbUdG?=
 =?utf-8?B?RTgyWFRhY2FQOWJCK0JXczk2MjdJR1JyZ3Z5Wm5HZE9hK2RUQUg0aUc5cGNj?=
 =?utf-8?B?WDFzT3kxdFlVSlJLUzBXL2RlQU5BRzR1NUFRRUtKU2dLQWJIakxZOVNLWHAy?=
 =?utf-8?B?OE9pbkdZZnlEc3A2Sk5rOUhKcWx5UlNuckVpODhXV2p1cU1aTWRDU3hreCtX?=
 =?utf-8?B?bFVtMW1VRFdqNVkxZTNJTWk5UmJvb1JMN1o4ZTRuL1d6ZEcxdHdsWERvUTJU?=
 =?utf-8?B?UFlpd2hyWS9lbGNyNkJOTDRjNUxqNXFNTmx4MnFHOGFWMC9EQ1VXWHZiTElQ?=
 =?utf-8?B?N1RuYmVlQitaSEY1TWcyRzE2emtIcHZEckc5S1VMVTBpUlBxNFFoOFdyRWxV?=
 =?utf-8?B?QW11VTlIUEdPOElUbE1ibHpQNm1QdXVUQUpzS0UwL0dQL2xtdGQzMS9BRW1H?=
 =?utf-8?B?UTVLd1JINzlYa1hFRlE1UTc4aGdlRktLLzJVeXpYYm5zUlBFTWFyOVlmNnNa?=
 =?utf-8?B?bzQxVXpReHBWdG10b2Z0SUlpVjc0Tm0xZDAwQXNueDQ3RHdHMlZiZEVhbDNn?=
 =?utf-8?B?OWR2cTYxRVFwQ0RYeUR4eEdSTFg2NStMbmJtcGNzNGZZS1U3R05uTU5HZGRa?=
 =?utf-8?B?QmNBWDZ2NGRPS1hXSG5neTBEMDUvajkzVHdobGsyVDljWHp1dXpEd05ZZCs0?=
 =?utf-8?B?UThWQTQ3ekJsSkJhUGZ0RzJvc084b2dQd3cwS0R4ZTRUZjhqNjJSRHZVWXVp?=
 =?utf-8?B?eUZ4Q21GUyt3ZUMvYU9oNkc5aVNpeERFTlVweTlTSW1lUmtocU4zcFB1dS8z?=
 =?utf-8?B?RlBCbENuTXNWNXRuaHF3QnFseU5NTXp4WlJLby9Nb3pVRldRQ2U1MWFENUpU?=
 =?utf-8?B?S0pYNktmbHV0bmRZUWM4RWpxdkZmOG91NjBvdDhZUWMzcUtqcFh0QTBXSHVm?=
 =?utf-8?B?a0FsMlJneWtMNHg1enRHVjZnSzBTWDN2MXJoUzV2eURyOTQwQ2VLTHYvVlR3?=
 =?utf-8?B?NkhyVGt3QmNNNDlXZ3g0ZjFSeTlaZ1laODFLd0xkR0JyM1JKQ04xSWlFNzBs?=
 =?utf-8?B?eUlhTkhvNmpTWlpVdmpiMGJlVDlKd1h5SXoxNGljNDVzekcxOXpnVmdmQ3Fu?=
 =?utf-8?Q?fk3cMCKrEqIaF/92VOJV4pNW5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b261fa-3dea-452b-e38c-08dac26d8753
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5951.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 16:14:50.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzTKCQN5tydcyS3jVbGKA0miy+onapXtxfjWqR/Wmi5LZMGXNjJuYXojOE+W6Cogo2HAownyyPxovBE3ui0qOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/22 20:34, Pierre-Louis Bossart wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On 11/7/22 09:02, Venkata Prasad Potturu wrote:
>> On 11/7/22 19:44, Pierre-Louis Bossart wrote:
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> On 11/7/22 04:34, Venkata Prasad Potturu wrote:
>>>> On 11/2/22 17:02, Mark Brown wrote:
>>>>>> On 11/1/22 20:01, Mark Brown wrote:
>>>>>>> On Tue, Nov 01, 2022 at 03:15:08PM +0530, Venkata Prasad Potturu
>>>>>>> wrote:
>>>>>>> Right, that's what the code does but why is this something that
>>>>>>> should
>>>>>>> be controlled in this fashion?
>>>>>> This machine driver is common for TDM mode and I2S mode, user can
>>>>>> select TDM
>>>>>> mode or I2S mode.
>>>>> Why would the user choose one value or the other, and why would this
>>>>> choice be something that only changes at module load time?  If this is
>>>>> user controllable I'd really expect it to be runtime controllable.
>>>>> You're not explaining why this is a module parameter.
>>>> Different vendors/OEM's use the same hardware as one need I2S mode and
>>>> other need TDM mode, using common driver  to support  I2S and TDM mode
>>>> with this parameter.
>>>>
>>>>
>>>> static int tdm_mode = 0;
>>>> module_param_named(tdm_mode, tdm_mode, int, 0444);
>>>>
>>>> And this can be runtime controllable by setting permissions as 0644, we
>>>> will change and send next version patch.
>>> kernel parameters are difficult to manage for distributions using a
>>> single-build. Either all platforms use the kernel parameter or none of
>>> them do. That would not allow a per-platform choice of parameters.
>>> Using DMI quirks or ACPI identifiers would be a lot less problematic, no?
>> All platforms use the kernel parameter to select the I2S/TDM mode.
>> Runtime parameters are not required here, by default it is in I2S mode and
>> when the platform needs to enable TDM mode then pass tdm_mode module
>> parameter as 1.
> How would a distribution decide to set this kernel parameter, what
> criteria would be used to determine that the TDM mode is required?
> You've got to think of who uses that parameter.
> This may work for a Chrome solution given that there are per-product
> overlays but won't work in the general case IMHO.

Thanks for your time and  suggestion.

We will come back with DMI quirks.

>
