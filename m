Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EED5FC47F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJLLqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJLLpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:45:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6F0C34F8;
        Wed, 12 Oct 2022 04:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QufZS7bipsRL4WaQ960tiiQf/m26hZkLnlm94JdsbCHvtPpe7JYR61a+9Q/QDvQFqcgnSxcpYQF6BjMDv4b9gN7KyG909grsr8gh41ax9ql6ULZgSsw8Yn57Bl1lQPFQfuHbvr5XCXFqDwRTKUNuEA//pR49Rx+u+UO3N2fZp5dZzb0EQ7uxOB2cm/tK65jDVM/nM+tM6jk5QSFfJRvLab8WK3bVRiJqGFU84KpesDw8A4PJYpuR8k7enOZX35lohvcXZclZkSMSVPjjgVh3edh8XVp1Zj3Dawi1kWv9JyRIRwsDV4Eb9IzJQXaUbJb/aSh5fBgSUUDvS2IHm6nE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVF1rMk6kt12XTz26t4bEKIPDbG7ZqI07HfzhwsXieI=;
 b=HrtlogOlXSSe3ZRdQKvh95vGC310zvQRVXn5kU+SLZPfbrCSIUy3pn1ch5qq5eKA7dzIA0aPcMmQbwKm9dofZ1jq1W3bt9qjXzeHNTcMty7hm/oQoBt9iIh2keuzpweWYy7ZBxP/uX5wIAPlzbTMFm8E/D0Fx7bDNaP0JeHMbLX2CZD5RllxwfSk/cTY0t2Brs5GcnN9Ki8i4fuaon0J11N8kIszGFQHujy0kUNP73m3kYV9UKuRYoFT0k0HiasiVndR+Lj82yjY9V6RyOQAbDRdXqHSlI3qEcrXjx3RGS27gART6xPHYARw3BQ55OtBRLMstMQcT9pXq25c9yMn/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVF1rMk6kt12XTz26t4bEKIPDbG7ZqI07HfzhwsXieI=;
 b=L3uNbdJNNxVvp5j/wjV3yVTbmPCrcoo65wabluZOeyF7ujjD6ky1EuwhdPcvlbIjHDSmNrR4bfdfYWtYGUpqGtbjGaY4qsWXn7d+UCciWhv/rGkaRpCcmbSnM6s4WwqvafHH0oRWTh38A6ECBxj139uVYQs1NEu6jETITFaJ3IqZ1EQp+C/zJ7/S/kFLlzOy/kFlGOts+cUjGYL244yap1m8Ccp0mO65L1Dv5t5RD37+OMDGlmUn08BHwCZ93r2U89lkxh3FBs/ScHRl9PsBPkBYoToNNm068iCbCcUQ7jvLc4ga8F8jN3fTk0kLHAmbh8f1/jqdx5HNAUXQzutU6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Wed, 12 Oct
 2022 11:45:10 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 11:45:10 +0000
Message-ID: <37b168f2-049c-c01f-9f60-c119fabf8606@nvidia.com>
Date:   Wed, 12 Oct 2022 12:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Content-Language: en-US
To:     Jim Lin <jilin@nvidia.com>, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, linux-tegra@vger.kernel.org
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221012102511.3093-1-jilin@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221012102511.3093-1-jilin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0157.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 81df778e-9359-4f89-e72c-08daac473787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iZWJ4gy894vqa2mY2OgZ2WcGEtu+8WTWd/3C780a7Tusy3N/yWsqydsVUPBmR+XMgvBuVG76l9WYsIhN5mRY4ae4t7sbNw6LZevGg/AKCfYMfCNQ64auD+TVxiSmUkd5FYo0uyU2fZ7mVERGmq08xOVPXb573kZx1RoQTGDRs/Y1CjoqDKa7bc9/iWxMNo6SlstVY6oveFSdxiZVGT0IsjI618nd2Wj0lq6Fs0gMeIkcgU5lS+462uTqm7PUTC8VZPfKq8DQboQExuo7/EdTUlPPEBFpGja37gaBAMoSmwybwBfRsLZc9pv09hC6nd+/LbDKkZV0i6TQqR1pR8ZZU7Z+AWGnYA3KBn0P8aoKGAfZC6o09OB25azoM57nTzkuFOV4F09GUaUW3YvSJIi43OzdQfmhhpqrumwASLLlXtsPS1WMEZ6skiTt5CKwD0f+cXB+7a65gRDPnBslapV9psz+wxrfWZ4+N71mx9vEILMKg9CoB1PvCJpItQpOmiXXonAsJJjmswBdmOWJ4gWHqrtE7lmeskUcwFkudr2w8SIarr74bvDYuOm07bvx5SS9wRubhlzsAb8W4Zgg+nwzZ2nxGOhnl6BkWYbQj1nmYpUQSmjgo7m2O0RXfkbL0Sqf7Zhzfs/lXUhJi2HtAoNrmFjI1eBL7jAKl30SQv+Q0asz49+X2dBRSo0CuHl4wQzaIdM4CGOg5ieZcdctWAk092I0tnTzbjsddlvlbcZJ9N+aysInxj7i0Sxm3hk/JQlcpdN54lPBCEg7RXdy/isptLjONP22KjMHO59WsQw6HCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199015)(31686004)(6486002)(38100700002)(478600001)(316002)(41300700001)(31696002)(8676002)(8936002)(6666004)(83380400001)(53546011)(5660300002)(2906002)(6512007)(6506007)(86362001)(36756003)(186003)(4326008)(2616005)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlXMWlPUVltWHZocnA4dEVqTWFUYVhiTXhWdzZRNGRDNUJPWHorb0pWWWVD?=
 =?utf-8?B?N3ExRE0xekl6RzZGNzlKbS9nOUIyRTlvOE1GbDR2dklDeE5yZEE1ei9DZ2hT?=
 =?utf-8?B?cVJkcjFlRU1TVTFMdkx1bThETFhiWU9vOGR4VEZINjNJM2luNm5aN0ZoS1or?=
 =?utf-8?B?alJKU0UwZjRIb2l1YWtJd1NRMXp2RWtQRHRHaG5DNzBHS1Q1cm9iRElGRjJC?=
 =?utf-8?B?YXRRalZMUkpBWFV2ZkE0d1BGRnMwb0ZKaGorRnpUM05sK3M3aGUwMlRSYWps?=
 =?utf-8?B?T0w3NGZ3Rnc4SGJWL2JnZ01LQnFuV0xLUG91TU1xK1FiNEdMUVAvZ25YVW5P?=
 =?utf-8?B?Yy9EcEdpZkVTbTBYY0tXS0crbVYvTVZhcW1nZU9HVjB2eURqUm8yRVlpNlY2?=
 =?utf-8?B?VzRRMkZSV081TGRCYXl6ODlVV0p3R3VzOEl0MmNTakpVV1hlOVNPc0d2VmdN?=
 =?utf-8?B?WkNEUUM2RjB2R2VMYi95cGJXc1oyd3h1Qnh5Nzc3ajZxWU8vUGVBS25mWFZS?=
 =?utf-8?B?UURzV2MyUUNDR2FCbEJGK01LQTY5NnFReW1QUEJZclFyZzZ0VmxoRGhQbjIw?=
 =?utf-8?B?ZFdmb3BXb2dZYkJoMFVrSFdGb0VKSzZqTkI4MEZKQzI5eUhONTVIZ1BwMHRq?=
 =?utf-8?B?QVhNblZ5N041Q0lKVTB3R1haWklqNVp6emtNS28wb09nWlpDNTVUai9Ecklx?=
 =?utf-8?B?SC9aVUdTQ05BTzcrU1BMeU53K04xRFIwUmRFQmFqQ25mTXlFSkpBVm9mYm5X?=
 =?utf-8?B?b2k4S1V5Zko2b05VUThmNnV5ZnR4SkJUMmhMRldSNlFnWFluYk55clRPWW9D?=
 =?utf-8?B?L3FEKzhCa0lTSERCZHBYOUxRaUVKUTN1QVczQSsrM280b2tJb1U3cWFkSG1k?=
 =?utf-8?B?eTlDQ2w1Z0dCY0ZYZjBrRDlSRU9KclJNQUZOVUdUeEhRSUp3S1N0elNyZzM3?=
 =?utf-8?B?YUYvUFhkb28vakZ0T01mOWdiaSt3Qk1sck43VHNwZDZXWjZaM242MGNUWGFr?=
 =?utf-8?B?OC8xMXF3OE9qVlZjODZpUXJwYWxqTmRMTkU5RUE5L1dXMysvd0tLbmRyQTlR?=
 =?utf-8?B?UzVvM1FzVVFVQ2RUYXFpbHVsbWFjcEFEbkVEZ1draDl0ZjdVdlFMSVByd2VV?=
 =?utf-8?B?aFdGakpJdklOc1UyMUJrY1dPWko4dW53WlVEdFZGeTVyVnJRZTYwakFYUFk1?=
 =?utf-8?B?dmQxNUxmaVBhbnBvR2tqUzcwdGx6UGs0bm5PczJQdWdWMzJ4TkMzMXFOSEhG?=
 =?utf-8?B?d29mdnNxeTZOTUlBRzBabzY5a0t1WCtMNGhXVUw5aWV3Yks0d3gyeU9STGlU?=
 =?utf-8?B?ZHRSR2o0UGUxNFZSOWJPNTEwSHBWOURQUGpTTm1FZEQ1a3B6MkJxaHpVMnB6?=
 =?utf-8?B?Q2dzSXN1cWZ6V09abE1zS0pFYi8xV0lSckdFY1UvNk9NVWpvMStucGEvWDNS?=
 =?utf-8?B?U1NHTnJGTjg3N1ZnSEFZd212cnFQeTJCM01RVExSNDBTbGgzNDhiREIrVEt4?=
 =?utf-8?B?bWV6NmNtT1U2OGRkaGtGbEIrREp1WWN6bUYzb3ZzQ2MxWHdLeEJFaXBJNEYv?=
 =?utf-8?B?dDRBeVM5bHFEa1g4cEtuVkV0UFBMMjdhNW1rNkpHaE5IWmlxY1RTdWIyOXVE?=
 =?utf-8?B?dHI1cVk2bXUvU3o4a24yVmN3d0hSQ0xnMDFUbzJYSklyZ2JwY0JRbXpFQTE2?=
 =?utf-8?B?czNNekVpQ3VRU1dJRlV2eFZVOHFab2krMHJpRVMwQ0NxMjBaMzVpa2tvRmNZ?=
 =?utf-8?B?WnhCOFZHejA4T0E1Tms0V2o3RW54OTg4aTdSa1ZmOERtSzRvRlErbWIzcDlW?=
 =?utf-8?B?a24xV1dWWTdQOUpranVqcHhIbmNUaTVuYWV5MUhCTFZpQThUKzVNVVNHY29t?=
 =?utf-8?B?MXJnL3djNW0rWTVSZGtoUzk2ZVRXU21JanUvNnpzeCtxZGZoTjVmVWhWKzV1?=
 =?utf-8?B?ZElHQ0hMby9oVnRnY2sxVTBCRlNJWTIrOUQ4ckxoSVU2ZnYxUDh4SFVrT1hU?=
 =?utf-8?B?YlF1aXdSY1V0Z09NcDcxc09UbytrRTRVOWUzMEs2L0R5RkdweFJjbnpHUjlP?=
 =?utf-8?B?Q1Z2TThNalpJUGdRQWVFbjVZUE9rRE1vSjQxQXdUTmt0Q05STXpmeGE2ZnVN?=
 =?utf-8?B?WFljVVZhWjdIZUg1TkhpRzRscEtFODZjMTJIS1pOQ0huNTBDWE4vRm94SmMy?=
 =?utf-8?B?RS9nODJnV1RVa2lsN3ptK1dNRVpxelVJNDFCZzZXU3BIU3Nkb0xlc25YTlRs?=
 =?utf-8?B?emRBOTlEVm5OQ1NvTk8yd2YyRkV3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81df778e-9359-4f89-e72c-08daac473787
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 11:45:10.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HEtRVaPsSTKz/gBI/gscatjzWY3F2kvXHq6ibKM2WdE17iJ3nSUQKH3vMzUc1iNbWIdUf0O64U/SceCClYnjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/10/2022 11:25, Jim Lin wrote:
> Program USB2 pad PD controls during port connect/disconnect, port
> suspend/resume, and test mode, to reduce power consumption on
> disconnect or suspend.
> 
> Signed-off-by: Jim Lin <jilin@nvidia.com>
> ---
> v2: Fix issue that wrong tegra->phys[] may be accessed on tegra124
> v3: No change on copyright
> 
>   drivers/usb/host/xhci-tegra.c | 139 +++++++++++++++++++++++++++++++++-
>   1 file changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index c8af2cd2216d..996182a1959f 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -189,6 +189,13 @@ struct tegra_xusb_context_soc {
>   	} fpci;
>   };
>   
> +enum tegra_xhci_phy_type {
> +	USB3_PHY,
> +	USB2_PHY,
> +	HSIC_PHY,
> +	MAX_PHY_TYPES,
> +};
> +
>   struct tegra_xusb_soc {
>   	const char *firmware;
>   	const char * const *supply_names;
> @@ -274,9 +281,17 @@ struct tegra_xusb {
>   
>   	bool suspended;
>   	struct tegra_xusb_context context;
> +	u32 enable_utmi_pad_after_lp0_exit;
>   };
>   
>   static struct hc_driver __read_mostly tegra_xhci_hc_driver;
> +static int (*original_xhci_hub_control)(struct usb_hcd *hcd, u16 typeReq, u16 wValue, u16 wIndex,
> +	    char *buf, u16 wLength);

Is it better to add this function pointer to the tegra_xusb structure?

Jon

-- 
nvpublic
