Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9F69EE63
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBVFgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBVFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:36:30 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573952B60F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 21:36:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioCRzVYYi90Iei/EweBmT9lPrtL9LV6UTwDDUpJ3NySEelKuMFq5q43II7QW1RXIC47vJeNzScYJf9mvncmf2132G0JYo7j395Z5Yt2CXZk+voENJqntvl4hGbRmuE2CYPW/JrbPC9ebVuFbiBpg5n1r/zWg3Sz4wpqS/8Y3RqCYut0g2HQXNCKD6sJHCiZDj6fYff1cc3nL+Yhgz3++nJwvnuXHR5f3ZRBIRJ3OSm6Ji6kg0OaYonf0nAe25j46rKgxuz/9Z4cY0m7XUJrbd5KTjFPTvVGRgfpcSDTlyXEQ1Mh3lz02j0nhZGnIO6LWbbRY2k7/vtclCDN5m+rhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNc2psW1s71ULzkhjlIeMrWTllTtkJOepZcVIIDMKqg=;
 b=bOg6fFL7dD2EpFNF6A1tG0qDLADoH5DrqwqX1zc2/WESfKZt/Cm9Yv+rFaVmRDLC4d45CaPu08eUxQSDxWOxD2oW/80XJFZgnS+8aSamK8VHo/Xxm5KL+pviQ95FPdHFV30eKMEYKccR5NE0u82o/fKE+770ie4I3bB4+wPGXyc8U/KrjXeaRTl+F/SEEcxeko2BWhcqqweclZeTMMPZv/j79E2Ul/dn3MF0VwyLKFGyCGjtPvOX0gom4xhQ0shSVTP2LCU5oxSKT7ZkhPu9Sol4Wk+UMLm5TVXKI1pM7X6ix+xO52Sa7AScHQkOO9B0ku/EyB17DYBIb5sfzO3O8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNc2psW1s71ULzkhjlIeMrWTllTtkJOepZcVIIDMKqg=;
 b=2dMKFoI4oszcbY7TnlNsbEIeBFroLQeTkAvveVa/uFq6KO7XP074YCGpqgsM3GzemAA/VItdl5Qy+e/AcHqQRgTvxTrMF2mGAlYcgXc/ASUHT052IMa1xmhvN2jWUjG0YvRKwF1JDnYNtmJWBeBpN+te5P7CYh53Ei260ID/6tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 05:36:26 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::fc88:7080:445e:6866%7]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 05:36:26 +0000
Message-ID: <fc5af6dc-4eeb-1832-c2cb-1074ad2dbf9c@amd.com>
Date:   Wed, 22 Feb 2023 11:09:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 3/8] soundwire: amd: register SoundWire manager dai ops
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, amadeuszx.slawinski@linux.intel.com,
        Mario.Limonciello@amd.com, Sunil-kumar.Dommati@amd.com,
        Basavaraj.Hiregoudar@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230220100418.76754-1-Vijendar.Mukunda@amd.com>
 <20230220100418.76754-4-Vijendar.Mukunda@amd.com>
 <b6f06e29-22cb-a996-5dfb-91544059051f@linux.intel.com>
 <70f873a4-5b41-aede-55b5-8a731c892198@amd.com>
 <84a9fb4c-daf3-84ac-3946-f554a8d5d309@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <84a9fb4c-daf3-84ac-3946-f554a8d5d309@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::20) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 0778947c-8b1f-4f55-1106-08db1496bd7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFWHwAurE9hf1TEp9xylzQcTK12oop8wDzGAsI2hoF+eG1W3dmQkcv7hcYCN7SzDf6YmIXFsmTPIMadyBKeqJUZcT8+t79V/vm2lB/vDSf9paetY6GtsFqbJt1dHYRjBf93xaLBRQuRS8+juA6wZRnx2OMLh/3Rfh4aUYkZIyPSP+ZCIMv/zlttQ5di++ICNfq6DqqWfZZP4irRIuyjv/9QlpC5CW4o9qDBNaeCve4rP9c5v0baqAvAZwhG3Azks9IV3zhngeH2a4txLZ9Gv8coWSWN46iN7fj+io6qw+7r5lJ8Z7k9KP76ps8NQHzQ5d26eRHTduh1c5YA+h28hjMCLYD3Q68nD0QtjZ2oISic7J7QUQY6z4ttamKOZSnvH4GV+dfoZXx6Y9Wk2LhXqz1kYhO+sA5jnjPKaAhStba9Xs9hdpUm20ZkaYB8LnOjpnoDbbaQU8B9CzG+t0m2ytKmmfnCiBVNtU8WBjjGLvNy3QxGVL23gMHciyj79kNX1N4Dyw9WsHeJj+HO4koLicGU0iyBSRKej9TkZ+/AMkGoDo+65Qx8vBXEYMTL7W52KxHiw2Z5R/45+drwFpPxUrVrCBIihmcI5mDbTrhNf7PLpG+Vl/VeBQJnjl1/3VCVOQcyJrZgycZumyYQDgE9bGCCqNYzwP5VF8/cT0arLHwjAANsHx1MNM6YGboUT/bcT7jvLHw62REuPbtY4ZvXf8BK1PecHfM3LwbGKR6XjJcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199018)(83380400001)(316002)(54906003)(478600001)(38100700002)(36756003)(2906002)(4744005)(86362001)(31696002)(66946007)(66556008)(66476007)(8676002)(4326008)(41300700001)(8936002)(5660300002)(2616005)(6486002)(26005)(186003)(66899018)(31686004)(6512007)(6506007)(53546011)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3ZKTmFacWhEMWVXUDNtaVdJZ1h5eDJIY0pWODRldUdPYlJOY0pqSFM3bU14?=
 =?utf-8?B?YW15aGtWNEo2UFpsOG9xNGNCM2F2VmtjdS9oV1hqemdRSXlwRzhGb2d0eG9P?=
 =?utf-8?B?Y1YwVzdSMEtyUmZmb0k4c2pOUFpyeEMwdmlheFBsTlJNS0JFU0piUC8wUjRh?=
 =?utf-8?B?YmRsUHhiOFptSjZUT2pJUFpxWlZvd3pJNHpVajlNeSs2S1ZBUk9KNzNUZzl0?=
 =?utf-8?B?Tmo3ZmRLNEhNcEVmSk9GZmFkbjc1Tll0VkFpRWRLTlFFa1RyOGFYbmJXSGNi?=
 =?utf-8?B?bkd0TzZpZm5GdTViOGRsWVZleWgrWGxMMUdCZkVqM2hKREdnYnNPdTdCVEVE?=
 =?utf-8?B?RDU4dEJsWGFySnpiUFZqakwxMHpuNjlFTEFZZFNESkJQcHd6YUVuT2Exek5F?=
 =?utf-8?B?SnI5ODRqWVNxVjRuWVhWYSt3Z3RlZkZyVHB3WGdsUDJySExYak9XbTdGcUhG?=
 =?utf-8?B?ckZVenJJZm5FSW9wRzhlUlRDRTNOUzd6ZVBMU0ZvNTh6WmxNL2JoMVZqMFFn?=
 =?utf-8?B?U09FQ2dGTXB3TDd5V0JYRjNVMXlWTkRjcHRzMHc1MFE1RVZ1Vkl2TFkxMWlk?=
 =?utf-8?B?dlR1OXJZZ1RiYm40TEJJQXRVeEZMalY3VTlDQ00xa05rZ3RQUlhQdlBNUnhp?=
 =?utf-8?B?WTVsOHBoNEFUS3RrS0JqMjNxZkI1Q0JKSng0Z29DZTFBOW9nQXVMck1TUEUw?=
 =?utf-8?B?UWhTRnJ4eFRJRHcxc3N5bzErRklFWCtpdFNITWJqbi84VExTZFpoQUJUNlkz?=
 =?utf-8?B?ZkxyQkppMlJXdEZQNDYydURpQm5wK2h5ejZsQzQ1RndMakEzMWdxZStzQkQ0?=
 =?utf-8?B?MzdZRjBSNXNYNUdObW1DK2VMVktsblYyeUhPU0YrbWZQYXBhQ05IQXhJa3JI?=
 =?utf-8?B?REc1cWRUc3RWTHdRNmtrN01GVE56ZXI0eUZjVjU4Y3lETkZIYWhXMHEydmFS?=
 =?utf-8?B?Kzc3U0dwSTMySFBpZ1M0V0FhejFvR2Nta1dKcFhOcnZDSkR0clRBYWpnNGtE?=
 =?utf-8?B?SUxJNm1xcXFhNS9zWE5EYnAyeHNoZENBWjNWa0xLOVRPSm9kKzkrNWkweSt0?=
 =?utf-8?B?WE9iVXEveHUrbk4zaGp4TmRpWlNBVG1td2Q3c2t0OCtsZDFXeTU1aWRNSitq?=
 =?utf-8?B?bit0a2hmNXBpb2NWY01kQzIwRWFlUkxWWHlQY09hby9ya1lZakQ1eVJNS1di?=
 =?utf-8?B?aW8rdjFmMjNBOGorUjgwb1RKcTNsUklZeHBsbHl1aHBlY21LSDM0ZnRuaWQ4?=
 =?utf-8?B?cExwanpNSUNmVHBXZ2JuaTBaZFdQcHJaWTZSK0ZWWS9SVDdpRklHWG9mZ2JT?=
 =?utf-8?B?L0lKYUlVRmROekJNcjdGbVd3ZU4yeGhxWTVYRVlnY0RyWE1LMXlZY2FvUGpM?=
 =?utf-8?B?eXpDM0Jka1IxTXpIRzFvZE0zWHlybjhrTE1ROFpkS0FHcG5KRFViMWg5dkpx?=
 =?utf-8?B?WndCUHRKTHRqRk9MQk9FaTF6TzZhcUlVSWFYZDh1Nm4vdVRSZFZxWi9WN2c2?=
 =?utf-8?B?dW1FL3FmcmhoWHhDQ2o0bDZnS0dBUzdVNDk5VHZrRkMzak1YeXpMRzNwaDRl?=
 =?utf-8?B?MFhNSnRoRE1vMDF0N1V2Rmw5ZmIyazR3dlNPVDBrNzVIc1J4QzBDQnRXeGFJ?=
 =?utf-8?B?aEp6bkpMY2t3Z2ZPMzVGSVFGeG5xS0kwTmVYcU10bmpuQlBmbTBCMWRFdlVE?=
 =?utf-8?B?dEduWVI4ZFhuYkRIQ2hlTkpFelB0Wk1FQW83cTRsV0lTc1dKYjF6VmFEWW5t?=
 =?utf-8?B?dEEvTVFiYUM4dHRxdzk0cVk4anJJOVBBT3hNczlRVmR2bGJ5V096QlU0cDVw?=
 =?utf-8?B?VDdHRUIwTFNEWC9jYUVHVjhVOWF5eXJ3YzN3NUdlSG5Ba054RUNhQ3JhVDZo?=
 =?utf-8?B?VFBzcU5lTGVTV0hwdHphNHpkQWliOGgwL0V4b21hazJmWmp6YzZqdkRzak5T?=
 =?utf-8?B?OXBncitPdVVUOEg2QXpXTFRhOTlQVWluNTNibGN1NjhHOFdsbHhVZks1UGJM?=
 =?utf-8?B?Nm84YWlMM1J5Sk8yTU9Sb0RqNWhmb3lIZ3lwd3JzK0IvdlU0VzRQQ3hKa1VD?=
 =?utf-8?B?eVJYRnBybFFvTTRjcFA3TVk5NElNaFprakoreUZ5UjRqYnhhVWFPWWc3V1lM?=
 =?utf-8?Q?wuA459QlRy5YZ+843EZyvgldM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0778947c-8b1f-4f55-1106-08db1496bd7b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 05:36:26.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNu3L27lin0ORKLMYdlG+/yhAz9StrZ2/TQRe0OyolmzqXPSuoNSBKBeQ+Rc223k2wDdsAOLm1en2lD9GyKxRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/23 05:18, Pierre-Louis Bossart wrote:
>
> On 2/21/23 16:05, Mukunda,Vijendar wrote:
>> On 21/02/23 21:29, Pierre-Louis Bossart wrote:
>>>
>>>> +static const struct snd_soc_dai_ops amd_sdw_dai_ops = {
>>>> +	.hw_params = amd_sdw_hw_params,
>>> don't you need a .prepare to deal with suspend-resume?
>> DSP based solution is not implemented yet.
>> As per our understanding In .prepare () callback, there is
>> no extra logic needs to be implemented. Because of it,
>> we have dropped .prepare() callback.
> You don't need any logic IF the IP keeps its context while suspended.
> That wasn't the case for us, we had to re-program the registers when
> resuming.
In our case, IP keeps its context while suspend. No need to implement
.prepare() callback.

