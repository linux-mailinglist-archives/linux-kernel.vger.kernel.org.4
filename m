Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7221725C1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbjFGKzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjFGKzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:55:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F3124;
        Wed,  7 Jun 2023 03:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1E1aIKEVGyEKs6ow5q+jlQemKeYkSWhkBkqfMoRvwSzGg/7rvcL/su97eJCziY4VVhjUfuQ7VN81nRh4sMrHKYzsWzau5Vg2eUK3WHmHStf4F/PPEEo26XIm8y6H4/PdxOOAGpTh4utC3QqqEvmFNFgUZymyiNWQYsNTD7MG+xCU4G0Rn89Q30zSSezeeZpOdcDsuzY71TpFNIxQ5gE74g52sR8Alp+/5JWKTPP7Arcimw9eZlkuKNiY7DbFFwvgiHByoT7kWSNbjghKxpOZq5XP/IlCoS9tWen/rVkxb1hHxmS5CbJVdoD2VYF1FJ+tRWrLIN3R6YwEhth8pfE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gKXJNnGK4THNA3xxalpEvXt+TghwU5wmYAMcedYyWA=;
 b=agtleSriJijtAq/TYmW0R6TzoS2bZFDcrDLFGwWOmui99zpN4NWRcj016q0hsngiwNoFe+P6z02r2Cr2Z0mYRpEYv00uJezjgG3KZeD0S0HW+hJ5gGF6ydnk6iyLY+x/GbaZTJ934NJzH3j7sIAwohxPiBBmUutgYIDTkbK436OcxNVfgGsTVw5XMhKia4Lqat2uLCZK71VRW7x079Dkul41VPqRPA/EDnonB+UkttfV7pR5CQqFKUX2MEW2FypuBSSuoMgJ6ir6mw9Mkd9gg9mgM/XOmeaBsg62piduWIVoUmw4ndBgf0BzVvmTdJo65iKJpxs+Gpf3O0OIkbyXKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gKXJNnGK4THNA3xxalpEvXt+TghwU5wmYAMcedYyWA=;
 b=Bf+gwcNeXu/e7e0NYMA9nMtZfusaoV41F4u7q+Ep/JRKftdaMomCdl6GZhhJadxT+V5c1JEAimKGvXMGwJ/vD71KVUhmqwptivQGwwMgJgZve8u/pJX7m0QFA9Y5GcHCrQue27LuUXehFDTzT1f810pmHf+Wfu6qJR1suIskbNqqhzvgPAxRM5Lo60/2GxPifVQVd9bgTXKc5NKV4ZQ1w6cJG6Fd1Dm5Tf/GKbASclj7WxVxgpEAyHqFW9d8+LToeLhu+AhPw+QdfRJov6ltVEiLuUEDKmfU2csWZHGdmcpFUz/MbbQcjlvHm/9VAfCjjUCJnIDmX540XoNq8ypw9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Wed, 7 Jun 2023 10:55:32 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::21ef:9d59:5b2d:f1e8%4]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 10:55:32 +0000
Message-ID: <496889ff-dd61-51af-c716-b9b9e2300be7@nvidia.com>
Date:   Wed, 7 Jun 2023 11:55:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] gpio: tegra186: Check PMC driver status before any
 request
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Prathamesh Shete <pshete@nvidia.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
References: <20230606071717.8088-1-pshete@nvidia.com>
 <56dcfcff-3b36-25ea-eb72-2b9d2f8f3883@nvidia.com>
In-Reply-To: <56dcfcff-3b36-25ea-eb72-2b9d2f8f3883@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0232.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::21) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: d67cb3c4-90e2-47eb-2cfe-08db6745b6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KVwIlTCQ7sNKND4xn4anRWQwgXxBAAvY+4TM3TPc1zFT5gJvix5p+tj/gdm2Am2i4HogbCRixgdvVOdQSOGWfBb+2GcqbOr2MzARMRAWmLzyLF2jSq7TfXej5ArtJZiiOC0/iHsjsmxutiOGAk4cC/y5aN5PYGGSU1rC517f6tkoPgA/71k4DF9HdKniY90hIoIZfuFpy/6bLqGtD/e5rbEtnFXTPwObGcTtD2+gRoHYqP8YwwTLUhwzV6n2m5vump7z3q9mHcV/2hzjLde+e8S0Vvfcxnp+thsEK+YoEJ7MN6T0HgiT85VZ6f2aJwfY5jirfA1mbLuNugDiQUDpWjZVSdifbIjWZrceFnWpG/2DnheHUCsQkLAuTRfY2A3jooMgXhN96BMDuzEguoulMPNjJrjAL7fPN38bsQDC+2enMLSFdKsMDypcNAhaiGGAFVopkU3pE/wjuJNvt0beXoPEYqFb4rwn5IYkrQgPaMW7pDYzXBt4ua1kIwZ/jZ3ZAeBkRB4VTmqcC/P88mFio7AGcIXYIjbGxhwgwNq1QAf695I3DmsQpU8A1jx4PKDX4buUYMwElcnjmAlCxDUKmRGNGdPJN3KKM1bITjXN/MPM+5uTNv7rlweT5mEE0Ajs//pNSd7NmOV83bcQQM9hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(31696002)(4744005)(2906002)(83380400001)(2616005)(36756003)(86362001)(38100700002)(6486002)(41300700001)(6666004)(5660300002)(316002)(107886003)(8676002)(8936002)(478600001)(66556008)(66946007)(31686004)(66476007)(4326008)(6512007)(53546011)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGhqVlUyd0VHQ20xc1F2ajc4Tmx1S3F1eXVzQU1GeDFWQWd5L3JuTjlYVjNC?=
 =?utf-8?B?bWg3NUtxcDNrM0xFWU9zZUV2ZjRiNGg2WnpEZXc0QzlYTkdTaEhLNUNTSTVZ?=
 =?utf-8?B?TG9zaVhacXZRTUhnRTlrL0wvUFFmcFQvMXg5OWRYSEhoRThIc1d4V2hjbytq?=
 =?utf-8?B?ZW9rU05XZzNJOXFIQmZYRHZZMzB0REdyS0hpNTU2VDdoS041bEVxa2RiSXk2?=
 =?utf-8?B?Wjd0RFNJdXJZN2hwNGRKVEQwTEF5N3lxd2c5QmxteHRVeTlac1lmZjMvcnRO?=
 =?utf-8?B?RVlUWjR1aTB1ZjlMMk52K3FaZzB5bGRZTE4yL1o2LytXejRLcU95OVluUFAy?=
 =?utf-8?B?a0NvOG1ZUmRDWCs2OUlxL2hHMGZJa0plY3hhWWlmV2dsRXQvQ0JzWER3aDJL?=
 =?utf-8?B?Ykdicnd5UzlJWHZ0SGFOU2N5dWo1aWtzU3ZTcDBCVUtnWjl4VnN1V1dLKzZM?=
 =?utf-8?B?dkJHKzRnMWszbDlDbHpodSs0SG8rMCtUMGJzWmxYQmxEVzZreDZseThrb3Nk?=
 =?utf-8?B?ZENGSSthYVVTK3NMUGduSnc5T0NKUEV6Qk1HdEVSYVVJdkdaZnA5NW9Qcm9H?=
 =?utf-8?B?ZVFMemxXNWo1ZlNEK1luV0d6NVlzelp1bDkzTjNlaDl5Z0xlTitkZzUzZFVw?=
 =?utf-8?B?TE45Um9IZGhKZEwzMFJORzNLY2hoV2hHZVorWkdTZkpHVjNPN2kvRzh0bEl6?=
 =?utf-8?B?cDFGdS9qdmpZa2JKTXpTTVhzUTBoNGN0VUNPL1E3L0YxcElmclQ1SHRzNlF0?=
 =?utf-8?B?SnREK1FsZXR0V25JS3R0YTVzTGlyT1l5NHpBS3NBRWpFREMzZ1IyZnlNa25B?=
 =?utf-8?B?WDhOeUZEdjI3UGFZakhSZVhYL3VXZ21HZFM4clZhR0lHYmxSZkhHd2pHc1B1?=
 =?utf-8?B?elpTZ1pqb2x3OU0zSmVqZ201d29wUFE3ZFBiZ3ZiSTQrN3lIbG5uelA1VjB4?=
 =?utf-8?B?M29HNEhLamdvWjdWeTl2UlR1MmYvQ0ZObkdRTXdPYklMYmtwMmFEbm1vRU5z?=
 =?utf-8?B?SUkvcno1dHpoNlE2U2psTmhSZE5sZjhDdXN6WlhScE1CZzhMaFRHVW5YRXJo?=
 =?utf-8?B?WVJKcDRQR3lmUVNrUDJOYXMzdEJYV3huUWJaSzJ3TEZNZEk1YXIza2hoem8v?=
 =?utf-8?B?V05UUnhTM2drSVhsVFZlMGdyOENxZFJkc3g2Y0hIb09mQkpQdis4RkJqY0Jv?=
 =?utf-8?B?ZW1za0NaTHZVZGZLRVYzalZaSS9JcFdHNHAzaXpnc2hUMnJ0NnhKVW41Wmg2?=
 =?utf-8?B?dEh6VDNlUEhRUExNM0pDS3dxVkc5T3FvWitVMVF5UVpJdTRCem91czkyb0t2?=
 =?utf-8?B?SVhJcXFIbTZiYm5Md1lEWVhZdjdUSk1VY3lWWTJsMHBRUExBS2kyODh0OXAv?=
 =?utf-8?B?MXF4TUEzaWlBeVA0L0FKZXlUUERsSEc5Z1B5UlhQVzBUTEw2Q213bWhwU09S?=
 =?utf-8?B?T0RsQXA0WmVkUmhZTmNlb25LK3ZqSGNLQ0JncmZyUzIwZ0JaSmFocmkzbUZF?=
 =?utf-8?B?RlJDVW5pbnRZc2xOV1lXUkw3dnFrYWhDSkRDaGFab0pGeEYzWkdGTjFXWnJz?=
 =?utf-8?B?RWg3RU5pU25zRjRiOU4vT3huV3l3Vm11QmplQUFSdFFWTzgzMmlFbzBheXRk?=
 =?utf-8?B?cU8wMEZYNkhlb3NkbkRkdHZHa3dCbmdQVkhaZTNIUVluTitiaGo0SVZRNFBs?=
 =?utf-8?B?U0pHeXovWHM3OVZPT3U5c2djRzBiNzYvK3o3N0xaTmxkL245Y2o2aFIweW1T?=
 =?utf-8?B?VG9lMExVa2JxckxSNWloaWZPTHF2MVl2a3hBeEoxM2ZhbTJZMThLNWs1WHRx?=
 =?utf-8?B?c3hpWXo1RUdzdGpmRFBrSTlDTnFXWWFuSzhkSWZyaW83Q04xWXlOUXNMdEN1?=
 =?utf-8?B?ZG1uM3V6eitiTUhYVE9wYjNnbWpScjRVQjV6M0VPVTVvZ2dXakc5RkN2YVR0?=
 =?utf-8?B?Vmx5TDJjenptVWN6b1RhNFBFYTM1UXVLVVY2ckVSVEsvMmxCazQxZWlSMEVV?=
 =?utf-8?B?Y29pc3BYR1VQUFFDSVYrT2VPa2lTNzVrQVVBSUJKdzBZelhtWXFtTW1IdlIw?=
 =?utf-8?B?cGVxeUNMTVdYS3U4c1dIM1RzVjE5RE5zOEovZWJsUkpDalV0c3MwUnRzNU5Q?=
 =?utf-8?B?THpWWHNzMXFuUUJRRkx6aFhDWjgzU2pFTUhtTEp4bnlTcklJVksrUGNVMzVn?=
 =?utf-8?B?Q1ZTYWV3OE56b1NMblJtdHJ6US8wM3BVbjFxelY0UlBWUEx2UVRSSVg2WmFj?=
 =?utf-8?B?VExqaEpKcms4UzF0NFpQOUU3SldnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67cb3c4-90e2-47eb-2cfe-08db6745b6a0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:55:32.0166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ltX42xOptV7xjGEJobxZ4xpPxe/h6eGiv6zdvbjybPu50F/wtBO3iohxvBXhL8tSenqysf/59GQ5NurPbMLKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/06/2023 09:53, Jon Hunter wrote:
> 
> On 06/06/2023 08:17, Prathamesh Shete wrote:
>> This patch fixes the issue where even if PMC driver status is
>> disabled still we are trying to look up for the IRQ domain
>> that PMC driver would've registered if it had been enabled.
> 
> It might be clearer to say ...
> 
> When the PMC device is disabled, probing of the Tegra186 GPIO driver 
> fails because the IRQ domain that is registered by the PMC driver is not 
> found. Fix this by checking to see if the PMC device is enabled before 
> attempting to lookup the IRQ domain registered by the PMC.

It could also be worth noting that it is OK to skip the PMC IRQ domain 
in this case because this only impacts wake-ups and not GPIO 
functionality in general.

Jon

-- 
nvpublic
