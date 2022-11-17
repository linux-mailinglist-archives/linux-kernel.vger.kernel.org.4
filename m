Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823B062DD7D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbiKQODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239876AbiKQOCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:02:52 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166C876142;
        Thu, 17 Nov 2022 06:02:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwVIG6T0omLm4yjJJXWN4nkQThnum4jasbFAVWCIiCHOD2/LB9V48u3Ec11/TvBub50RtmA5i9iAoZeDsuymnLav+2cQDbkFLlp08sXBcswDmKlg0NOEVP2q84v4thp8wVlH8ch6yr/wdGQ8ntY/xiw17EIKe3lsAuVn08IzY+sBBkgi0zvSz7Xm3ONUlqbqbeGQ3Bea/JTZdnKE6DwepuptM07mL9mrsDhu390mjYVMr+NLsX47+gC4XzlHzXNPS7x5JXjSOm3oTciCJcgdrF4P+qlVLNKeB4svqhRA/owENcIKN6dytoYdz5NdnzbyaJBPWbZBmGS8RL5o6dD4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipGd5NRC4uFvPinzrCBtOymxkxOzrYLEi4ImmJnx4M8=;
 b=UTDxcwNTYpRRUuj/lixCAej97Br9I48VHN1CiZAfEtkRvT76rvOhecLsWzGOsebjU8SvznQ8Bx7tBOCcv6Wt7du7UzUA3eFybayRZy0cf0dct1uXpWxRUf343SThCStwbSRSLPq+fHqUAWHH+bIpYydvBkb54fGVFUTooM9a/bRYkv47TXdKUcbqDEwFG5/w7mca33LQ8JvEYkalBL+RrT+nXMN09bz/IAThMAr3bILUaYwkHhyh2P4jJrevorLx7Gam7JVvY2eOjnLMbG4Ij0EVp9k20VFJM57+PiYbEt0XIkFEyew0ckPI6AVs4wknfv6wXdkZJ35lMX0jiPel8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipGd5NRC4uFvPinzrCBtOymxkxOzrYLEi4ImmJnx4M8=;
 b=yH645eGsuNVeWslwe/TGMnh6bUX9nfKBRbzCrvExC+/qOSe9WIj33bov2qX/ZoE+CeRE1WscWSQRg0AuUcjeGZv6gQ4YOM4+AZUMfksGxdTGKJCMs6b8zAncs8roH41tTUgBaECVoo8kMV4Q3GEKlfYG2OBBtsPh5IR3U8SQJcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 14:02:48 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::b6f2:3174:a1c2:44b5%7]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 14:02:48 +0000
Message-ID: <5db2e4b8-cff4-8aed-a3ac-e26d0668d996@amd.com>
Date:   Thu, 17 Nov 2022 19:32:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 4/9] cpufreq: amd_pstate: implement Pstate EPP support
 for the AMD processors
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
 <20221110175847.3098728-5-Perry.Yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221110175847.3098728-5-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b016c6-a00d-4481-107b-08dac8a46855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBtFRMlLOBy5RayyA9H4khvogfY8ShfoVSEhMsd5A17g0zA+Gf3vz+i+xxpN9RuNJrYZuLn8QgniVamSG8Prec/teKxb0MkAnK//udRgtFrRsVgOmUE/xqCLFUFfxT741aEiwW3nFySj0YVwxb9ftFNSmG3gXzs+iMxu+AJAwp1/qOQXwBDZZPFY5mjxIOkqF36XHv4PMyfzXlNWowg6zIbgvzVxCB2M+hxXvxy9NEixnJQiqFg72ySbAVmlSpQ6eWxYbR/UCDPXO3wYUBHCS+skqHsIecI2KT1J6EqWEGnt4ST+52cTxKjKclEFITOSdgodRttpuxR0Mk1U4aLA4XnrvM2NFOfVHkKtPqxsc155B4BbkTvDTnHFOb9I/dNRye7Uieib3CanclYDtn3R78mZTWE8XtX7qVdekzhkZVaj6oH6Q8m3VCROCjJBiYMBkev13/iw0gNXGsoKUGq8sRLsgP3EBxLuuseYui7tJRnxjUTbX2LsF2WdQ5Oq9V7O+M4Wj3+gH7F32ZNEWsSIIYKFu7jMGw/Oply6904hkUP77J3gj6ofOn3+7UO+l867xjB5THaOmpQLxbwxzEVly/qX+5Sw9dqC7QYex9pqlxig/pLnSk4CSAwFIUAK6JAnJDVecC23FgVSMh8q+lgJeWUniDV3yV5aBB2jzUiDOY7n4qcnjir5oPjMh4He69aSEoRzdfN1XsUM46qCPZ6sMhkMeiR4UcHuS13/Jx/qymg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(31686004)(44832011)(8936002)(2906002)(86362001)(31696002)(36756003)(66556008)(6486002)(316002)(2616005)(478600001)(186003)(38100700002)(66946007)(5660300002)(8676002)(4326008)(41300700001)(66476007)(6506007)(6512007)(6666004)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExLT2NLWHdFTnRHcEtQN2F3K25kYmdsRFVRT1Q3Zzk4SnpEL09jZ2dQYmdP?=
 =?utf-8?B?S2IvY00xWmIyZWpVR09mbE1nRWg0cjE0MnUvWW5NRXdwWGt3QnZNcER6bkdX?=
 =?utf-8?B?QnJwRHNoUVltWW1hWEw5V1dISEZIMjBuVnVpdnErMW92SGJqamswaFp0d0pD?=
 =?utf-8?B?MmJBdEd0MmpyRFB1M3V6T1JTNzFqZTd6blErek9CeFZkbGdrWGtJYTdYREtr?=
 =?utf-8?B?VUsrc0hOZDdBL3dJeTc4WjI3bDc1MWZYNTl3cGgvU0VqRUFCc3I0WldDZ2V3?=
 =?utf-8?B?MWdiUjVGWW1KdHZxaDJSY1FqV2R6YXlFSkVLSG80K1JpOWo4K1pTbnBub3FL?=
 =?utf-8?B?N2ZKd2hGam5jeHJaSFBSREdCdm5PcGlLZHJWckVOaDRaS2R0Y2U5VFlHL3o2?=
 =?utf-8?B?c1gxL3I3WlE2Y1REME5ablppRU1SdDlsdXZnOVNMT2toL1pWUmJhNlA0KzdF?=
 =?utf-8?B?UzhDUktOOUQyaWlkZHBnTTBHc2g0VDBsdTlpV2FlaW5IS2hoQnFrZVRtSUQz?=
 =?utf-8?B?eTV3V3pITGpkcE9Ca0JPUzIxN01FM21ERjJjeE55RTFlZDBmZ3ptMnBCb0Q2?=
 =?utf-8?B?aDgvSXJTTnNHc0VqSkNKbDZDa2NnNVFZZ0xBK0I0blkrMTl4c2pZZW1OTXdn?=
 =?utf-8?B?NTRMc2FteENWb2dPUTlvSDVwelFvRWh3N1MxOFR4bU5ZSmd3b0swUXdwS0tR?=
 =?utf-8?B?b1pVOWV1ejVyQXUrNlRmS1ZqWFdXakJ6dmVsRUlrNzJndm1lWXhuWlVuTVhw?=
 =?utf-8?B?MFN6VU90Q3lyTmRaRWQ4NU9zeENLam9YSFZKNml0ZDVQS2hibU9LellHK3pM?=
 =?utf-8?B?QU9qUFRtZ2RpUkMycGNUV1pZU3cyaWtYYXlvS1JpSFFLbnJSOGlRcFE2MjFa?=
 =?utf-8?B?YTZQRGFBQTUvYzVScVV0bTBCTEFQSk5YbFVUN1RQQWRCUUlTVGljYWlCYkI3?=
 =?utf-8?B?cWZvc0c1aGo4cmJzZkI2Sy9MaXp1YmlaYTFYa1VFTS9LODNrM20rUGJUV3JC?=
 =?utf-8?B?NzFvcWFiZW9RbTc2Y2lUVDNBR3RxYUNEN0N0eXBobGt0UTVVRXQxRTExZU5r?=
 =?utf-8?B?ZTBsZjQ0NWhiak9XNFNCZVdiMkpiTkxUSUQ5M3A0aW83WDRIUk1QcGJTWC8w?=
 =?utf-8?B?a1dPK2RvR2RGdi9Ka2dZTExNQXl2MlB3UVdSd2dtTnY5UjRTSmk4SHo2cjN1?=
 =?utf-8?B?dEZtVE15N1Y5UXFsSkJMUXVibzE0OStQZVVROUN4eGNTazBZVE91NHNBZEJv?=
 =?utf-8?B?ek1YdmtJOTVDQ05YQWcrVVNlb0lHV0lDVWVwVEdpTjVpN2Z6aFJycDV4a1dF?=
 =?utf-8?B?Vml2a3dhNFFBbFdreVRvKzZmREM0M1B4MnZrT3J4UWJUOThZQzlhM0QvZkRa?=
 =?utf-8?B?SVRjZktmWVZ6N2NEYTIrWGJVeWtQT3o3OWRvRGJQREY2RGlNcS9vSW4zaWpV?=
 =?utf-8?B?MnVyNzVqR204YWlMUlExVXZvNnU5Nk91OXAvT2N3VCtOQnVkVEpuTk52YTJY?=
 =?utf-8?B?cDZDZWZwU3AzOTFCOHZBaTJ2WUdFdFlJa2UwY201czFDOEVUOG4ySzlyTzA2?=
 =?utf-8?B?U1dVNlNhWnVQbmo3THc0WFZCc1NabkY5RW9jZkMwYWpTYVYzWUlpamtrZ3NH?=
 =?utf-8?B?ZTQzOGtoSC93NjN3eDVzNUtoZXhDNUd1UDRETUdDUXY3bkpuU0p6RERwV2NS?=
 =?utf-8?B?SVB5U3hYZ0g0TEZHTVVKWXhGc3Axd09ublZ1ald6cUZ0STdhN2p1QXBSK0ti?=
 =?utf-8?B?RlBzcmhvOWdtSGpJd2MrOUFISjQzNVhiWEJCNjNITTZsWkROUEJqYkxNTTBI?=
 =?utf-8?B?SVRQTUt6em1aMzRsQXBGVTk5WXhIKytjU3EzR2Z2SGwxc3ZmWkRZYjVseVZ0?=
 =?utf-8?B?Mm54TUdOL3J2VkxscmMycFNacTEyRVkyRmlYZXZrVmE4ZVJVcDBuTkp6dUFF?=
 =?utf-8?B?ZFNJK1UzUzdUY2dPb1lPdTFaZ1dHeW9sMS9zTGpRYStrcEZpM1Q3TEgydER0?=
 =?utf-8?B?a2VLTTZtZVg2TTN2Zmkwa2VJb0Z4c2JXRGpJWlBRSXJoWDNLMEdlN3RFWllw?=
 =?utf-8?B?TkZ6QmNvaVpVRUwzbFVZYnhjU1k3bU04dXlaMWdZc1I3TU1Sa1JjR3RjMVFZ?=
 =?utf-8?Q?yClCWYXIZU5DqH/CgUEMxR7Gb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b016c6-a00d-4481-107b-08dac8a46855
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 14:02:48.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9dHxwBo5IQ1EtUX74Zzk0wnYBz5uR8tWFFhQ6xGXJeKOOjfKoz7Py6re4TIneePsANLUTLJelFymHc611mSKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 11/10/2022 11:28 PM, Perry Yuan wrote:
[snip]
> +
> +static ssize_t store_energy_performance_preference(
> +		struct cpufreq_policy *policy, const char *buf, size_t count)
> +{
> +	struct amd_cpudata *cpudata = policy->driver_data;
> +	char str_preference[21];
> +	ssize_t ret;
> +	u32 epp = 0;

Here `epp` is a unused variable.
 [snip]
> @@ -657,6 +1281,20 @@ static int __init amd_pstate_param(char *str)
>  	if (!str)
>  		return -EINVAL;
>  
> +	/*
> +	 * Disable amd-pstate driver by default for now
> +	 * append amd-pstate=active or amd-pstate=active
> +	 * to enable driver loaded
> +	 */
> +	if (!strcmp(str, "active")) {
> +		cppc_load = 1;
> +		default_pstate_driver = &amd_pstate_epp_driver;
> +	} else if (!strcmp(str, "passive")) {
> +		epp_off = 1;
> +		cppc_load = 1;
> +		default_pstate_driver = &amd_pstate_driver;
> +	}
> +
>  	/*
>  	 * support shared memory type CPPC which has no MSR function.
>  	 * enable amd-pstate on processors with shared memory solution

In the shared memory support section also `cppc_load` has to be set otherwise
amd_pstate=legacy_cppc will not work.

if (!strcmp(str, "legacy_cppc")) {
	shared_mem = true;
	cppc_load = 1;
}


-- 
Thanks & Regards,
Wyes
