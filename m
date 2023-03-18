Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94B6BF7AD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 05:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjCRELp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 00:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRELm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 00:11:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D737B50;
        Fri, 17 Mar 2023 21:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4vU99XCbC1hM7VpD9ua3LwgYZPqyxb/A9ZrzCkGLVuczghw7TCpftKit6V+RoX8NOFbYYzX7p1LdeWqEi+ZH6O/BPtgLuu15Wu/+Lyt/pkt/CrhKalzC633oJ+ZFTYy4RLfxpTUPI0APJEC0jHjjOVjRM1hWWsIqIpzD4ExOwdy8XA8dNM9xDOXW1K4f5J6n8CCqI9D1IJhDooLdE0SRI9QFMLmfN03dAABqGydWX7MUFePBCUfJjDUwruO0l+6xL+f9rBDhw4vofyOQ+WEsxUx6JfW1ZYiALrhXuhCncergvLLLV53fJ+i3Y83HqJ0YYxsLP4fMK+lT2kVE0xRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8frYpDVHeTmX7sYH5rWXp+f/UibjoJNYXZz1TYWcdzY=;
 b=GDb5mF0LopRHzMSeEacTbxx7MYHvenQz91smgoqSbrz/M7ryeEWj/tvh8FXpUxTnimq3GSOYr8CQJGVw/1mE3nVq5+TTjuN57xGX+TXU/L5uy+uVTEpPa3xE1U7Y+VLukXlxjL47dKVn0yaAaRN9jyjz9AVJAMpaWXVy5KW8EeU3bdKu4ZSKPY3kVuPWE9v/x7DPVWe5QqFmSx5AQVDX5x9EU34XiECCc/mpwX4FZV0tSFpD/Xz+PM864QVRtujUACRTI8VDW7eRCvf2gX7KmDtR2kTdRVQu4WV8hdmFU9XTiQZ8yJhVx1p0bLOWchh0iDmJbBmzgjT0T+DF63H9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8frYpDVHeTmX7sYH5rWXp+f/UibjoJNYXZz1TYWcdzY=;
 b=oEQb4AeG/FyCv2hgqupLj/BQcfcKSMTy2v+phoN4JYj1m9+kREe6RLlrYqteFrnq+q6e9LFz+C66sfyUr0vVcOlASF88C2wT3Df3o59cv5ZjjjTzCZFt+5qa/7BB6JTLklN7FyfkxfUCG5bNXBng9uOdBVce7dfuIACONLNgVNvPFQ0WnwGnh5mxQb9kd3BuQHuURk0xeeEI/jCo1myQfIR6ib2VYq6kj+6UrTRaY4SZeR73vicRaYkRshwmUWIVZ8HSXDLFoZfl4zsMwRUbGBcK5oVGssAw6SykdtRTMIr9rC63M11/M3UZvE0gQl9Hlm8Km1g6yprCT2EIIjxZ4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Sat, 18 Mar
 2023 04:11:38 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f3e4:c5a8:7103:8ef1%3]) with mapi id 15.20.6178.026; Sat, 18 Mar 2023
 04:11:37 +0000
Message-ID: <9af4b672-29e9-0208-83f8-b10504186727@nvidia.com>
Date:   Fri, 17 Mar 2023 23:11:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230317162636.851085-1-sdonthineni@nvidia.com>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <20230317162636.851085-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d936004-bb05-42d4-d265-08db2766de22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FogbaudSrJ/QKAIYe0+mPEJYyigxEFnOYMrvFqDGaVtxkQOc0h7YB1Db+l9NQtd3TuNR44F+9Gr+BNcNqGW9WW5JmrqW44lPS1dDrvanIDGbO8hMwZWFV3GYCXoUPSyJ53/rWjIENoVPARQarQ4m41I7NedC7AiBHv5O3VjOOB0naz1JYPL4eW2/N4kfntyzrH594fTE2Fr+r9cdydnBHarMWS4ZMPsVohbHbcPKiQhtAhSSVbGvF/qPILd+ffW633hR05Smbzodh3UIFils4gv2M7AeHTyHFjdpFf87T0QiY3LmdnpywjN9a92NUKDvDxYH9G+WTRjO7RJVOxeXbBZScb0EDGY7uNe71pN1RxGMPPnEsVUvlpC9Ez9/AaL3xcjGJIGAxuJ0iDrqnGuKqlDucj66SSI3cbKoEjuvoP32vqSsyo2QTFqaVaVyTlB0ndaRHSIGDbFTRK/rEGdftJmLU70YXsKRh2+vsoriZ50rkE3VvvxhFZRu1Xq1ZX8ZLsEQDDhL6W+MoNVBVewXh7pK8v4Q0d3/zjlvurxBFFvYlm6iG6JL9Kq/H56pOZObKmxY1tRSz3a0SVtbwKje3buzwpNslAwfDFthgQLYw2yFsq/kz9Du3KKSH7nNjjC0s1XNChygMJFp0PPJgr/NbQW+EG/py5KpwqJ/DYVCpuV5A4/yBG4pFn+IBAiheEnpDpVS9AQqLDQ+6IPGQB8a6GAlJZXR7CxK4Xk1O4vouMndQJmF98XEn8vP3h5phVTC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199018)(31686004)(6486002)(36756003)(31696002)(6506007)(26005)(6512007)(921005)(53546011)(186003)(2616005)(38100700002)(66476007)(107886003)(6666004)(478600001)(316002)(110136005)(8676002)(66556008)(2906002)(54906003)(4326008)(8936002)(86362001)(66946007)(7416002)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9MSnFMZU1hZlZpMW9rU2h4cDNIem5WMDlPTUZuUVQvUFMxWElLVFp5aHh2?=
 =?utf-8?B?aXRScWdmdElZdGV0cS9iYjRzSDZnQ2VIRVcvaE1SRkJsQ2FMR0VFY1pIUHY5?=
 =?utf-8?B?TDJqUE44dVhweXRXaVl1OE5ER1dWMGZlQWN0ZnV3d2JtZm1Dbll6alRFQW5s?=
 =?utf-8?B?UG1oUHlUSWYyWEJTVnh2bXU1Wm02YlZwVlJscjB1RW1yNmdiNE1Fb09OWUhD?=
 =?utf-8?B?SnJuTXZiZ1p3cXpRczczOGttRUpnRVBXOGdldFlveU9RdUNqN1hMTVgvSUYz?=
 =?utf-8?B?MlpENHMvYlBObk9XNmo3YWQ0NkRYdkhYSU1KYjlzU0JyWjF4MjhPR29BcTMz?=
 =?utf-8?B?cjNTMHhDUU9IbVVZR2Iva3hISVYwT29MdnZhQURhdTVwZFN1bGVYaTFtN3lH?=
 =?utf-8?B?Qmk3VkFnL1RFT05pd2ZnZjBnTHlrcklyYzZBcDFCaXJ5UFovK0s4M0g4ZGlG?=
 =?utf-8?B?b0RiT1hQeE4vQW5NeFpZODNRMWZmWnE4S3Z4ZzRvWXhoQUd0OHJnWE1YVkVk?=
 =?utf-8?B?bEM5KzB2S3pvNlJWNmMwNWRPWGdzL0NMR0dkTWd0NGtqbVFia0t4MzRhdzF4?=
 =?utf-8?B?ZzJyaG00NTlla3pvWDl1ak53VFFZaHpNSmI2UWlZOGtuelZxMDUyVG5FOHlZ?=
 =?utf-8?B?Q1kyNXpLZjl2blc4dkVFaE1SYjZTQ3pYcUdqSVlMRTFzRDR3R0NqaVpuZnBU?=
 =?utf-8?B?U0o3R3lpMkJuaE5LVjl4MXBKT0NtVkpDWGlwVHoxUVdjNFd6cVd6dmowZ0ln?=
 =?utf-8?B?STUyRmNjYUs2YXZJWWlHWk5xR3RtbDBobSt5RUt2WXhIRHZmUUtQNVlRLzdK?=
 =?utf-8?B?VitBZ29pY2ZjN3g5MktCZ29hc2FYUTl5K1hteE5WUkZGbWhPRTNuYVF4R250?=
 =?utf-8?B?S3M1bU1MVUtsZWFPdi9qZ1RmbDFxYnZWazlXanVyYjlIeEVNME50cU9CZXdV?=
 =?utf-8?B?b1VmMEp5dC9TN2g5T1FlVGViZ2p6bW9xRlVaZHY5K1RvNk1ER2lyQUhBVXBt?=
 =?utf-8?B?dUZiUlRGcUdZWkhOZzhVZFUwcHE2L0Jra3J5bVR3YUl0a28raE94alEvWVVP?=
 =?utf-8?B?TkFUblorVUVENE1mclk1WkwwdlZWZkJmQ2hDNSsxczBOL3IvQ0tNazMrWGtQ?=
 =?utf-8?B?Y2FMNE5mRW9UR214WG1tQ2tZT2xLZ2h1WjRFQmk2ZWJJZUY3VlBGamRibHE3?=
 =?utf-8?B?Qk4yVTZCbStRZlQxc0taNUFoeENsTENUUlczRGhZRDR4MjErdkdwdDRaTERO?=
 =?utf-8?B?bkZHc3RaTkFMejVmNGVpWnZ3N1JmNU1XWmFWVmlhSUYxdVkzKzFmdVl1WElq?=
 =?utf-8?B?R1B6Skx4b3JXSGhVUVk1VGFNbW5XMFNmNndRUlA5emJHVHY1L1FIamJyL1Zi?=
 =?utf-8?B?WWgxSjdxSlQzN2dYaTU3RVp5MUdMckJaQWxQa2lrSzQ5Qi8wb25zdXhaZyta?=
 =?utf-8?B?VmVzVW5sNW9jaXBydDlEY1A1QmszTEM1WVQ4ZUx1eU9wVnJDdXpueXB4am05?=
 =?utf-8?B?REhXZ2tDQXZmSGZsaE53em1LK1IvdksvZ0xSY1pnOW9vMDNNQTJKWVdieFZx?=
 =?utf-8?B?QVBNYjRhVEdYZnV6bU02bGhBMU5WdGMzeExrYi91WmZKcmxTUTRZeUF3K2hs?=
 =?utf-8?B?cjBFSGpXaTFwS0hZWEFNNGdhNWg4UkQ1WjdJV2pyVFdIM0EyNWpkdFh3V09P?=
 =?utf-8?B?d3pwam53TlNXaEhOZ0RTeHFNOHBWUW91a09RbU9DcFprWmxyTUlQWWFVQjkv?=
 =?utf-8?B?VDRZYU05Mk9qSm9mWHNzRy90Q2tSUWVrUGE5TTBkTC9ocG1iYkVVTENKMmdi?=
 =?utf-8?B?T2hiZ2Q4Smw2LzBpcEdTMnpxWmxrR3drYVpaM3VsaWRxTW9nRzRuc0V5anA0?=
 =?utf-8?B?OU5ERXN1VklYbHY5RzM5Y3dXUVVybnh5LzA0YmZaelRtZklzSVI3THl5NEd3?=
 =?utf-8?B?STdvY3F1OGRzSFZTQXlsT3o3c0ZNZWxUUU1tUDRURGpsNGNzN253TTVpMWxt?=
 =?utf-8?B?R0c4bkJyd2xTdWxlMEhBQTlmQVZheVByRHpvQzh5RVBQeVMvbmxwVUJxWTEv?=
 =?utf-8?B?NnpSeDRKLzFDMVR5WmVkMnllNForaFNFbnJXZk80RktGUnBqZ2t6K3lnSE5n?=
 =?utf-8?B?end0dWJPa1h2eWVWZFRtSWRWejdIRGl5Vlo0K0FJK2VlMG1aMktHN3p6UExZ?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d936004-bb05-42d4-d265-08db2766de22
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 04:11:37.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDRuS94Cz0RPQ41XVZs3QBWYfj8yAMPiLjBSKLpScEYzEOxuW0qbirtEWtVWTqO0z4HQJhIzK3RkfkQlujrnMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/17/23 11:26, Shanker Donthineni wrote:
> #define T241_CHIPN_MASK		GENMASK_ULL(45, 44)
> +#define T241_CHIP_GICDA_OFFSET	0x1580000
> +#define SMCCC_SOC_ID_T241	0x036b0241
> +
> +static bool gic_enable_quirk_nvidia_t241(void *data)
> +{
> +	s32 soc_id = arm_smccc_get_soc_id_version();
> +	unsigned long chip_bmask = 0;
> +	phys_addr_t phys;
> +	u32 i;
> +
> +	/* Check JEP106 code for NVIDIA T241 chip (036b:0241) */
> +	if ((soc_id < 0) || (soc_id != SMCCC_SOC_ID_T241))
> +		return false;
> +
> +	/* Find the chips based on GICR regions PHYS addr */
> +	for (i = 0; i < gic_data.nr_redist_regions; i++) {
> +		chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
> +				  gic_data.redist_regions[i].phys_base));
> +	}

Apologies for the oversight on my part, I failed to address the build issue
for the 32-bit architecture and mistakenly submitted an incorrect patch.

Please ignore this patch and review v4 patch.

Correct change:
         for (i = 0; i < gic_data.nr_redist_regions; i++) {
                 chip_bmask |= BIT(FIELD_GET(T241_CHIPN_MASK,
-                                 gic_data.redist_regions[i].phys_base));
+                                 (u64)gic_data.redist_regions[i].phys_base));

-Shaker
