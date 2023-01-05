Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B7F65F0B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjAEQDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAEQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:03:48 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6CB1AA15;
        Thu,  5 Jan 2023 08:03:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROAseuMe4YCoWbPIDpX8sP45nvgYXNttKf9AC4Jn9dfaWvEjSLN0Pj1H0360CWkMRXFcCIHhbwtGcL/xWi+onBJaqyqWAt5cf7vqcjm4HOhboDzRUJnu3TVojB8ZLUk3lMjhekZqzNnuctF/MzAXclQ9aM+2WSfGA13EbvQCzmW2oH+kVTDYfioEdCPRS5964TjqySKpGJdZSMRI5qBM72Ie2k/21jOaCpwve/v27YZ8xhVpawqNb5FhscuPNaEELCJtmyaS9pUf/jmph6dGjPMmAiD9mXuy6dl4h79Vmwagin8m4hO5CR4k9rgnEgpUfmA/XC468QUrXEgTvJqozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KrvlfgFRbiBZnZNVBR4TV983B7OdZZM7IQ+32PNCpA=;
 b=LJaWQIUh5oCxa5r/BX1SwR9S4wwAgMf6v6Tpa9qWhBCVGGqAB5OqzYdANvgPJc3dLmYifHMvIs2zCKGqty7SKEBV0a/XssNOTJhheLQF9gjyybm1U4kp6ZTom015930qv0A/lIriVJA32Zwb/ZImSRwdWIgBcUY7xz6vvm6qMTsbDmeZfdVO+smmFNx5vn8Zvdw9qKNH8RZExgT15KIybZqgyy5mf4PkErenMD0Q9BJQIhG56gp+TvI72QxkSmXERHOMis02EzeIYxhahYFrkJd/6dQPkpsvuE2WYv6ku0+9W605NkXzIR4645exdMVDDW2qnEjJeajmQAeWHhsmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KrvlfgFRbiBZnZNVBR4TV983B7OdZZM7IQ+32PNCpA=;
 b=gHecbSP9PllK2i3JTFqSpDeZj/R9walMO+jkzmTujjdZWG3jaxvsvAd2iza/+c7lp4ragXs1Tf8vgpfYXPtAA6XYx37FHMBHu5w1adsIpkLcUwQR5boevUg1fPxNoHes3LOURqbCIDWDNvaB9r1mdSJ0jKVL6trOyB5SBkqzkJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by DM4PR12MB7549.namprd12.prod.outlook.com (2603:10b6:8:10f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 16:03:45 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::45ef:724b:4b64:b98%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 16:03:45 +0000
Message-ID: <9afd6384-fb1a-933f-7873-eaeec38cc65c@amd.com>
Date:   Thu, 5 Jan 2023 21:33:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 09/13] cpufreq: amd-pstate: add driver working mode
 switch support
Content-Language: en-US
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221225163442.2205660-1-perry.yuan@amd.com>
 <20221225163442.2205660-10-perry.yuan@amd.com>
From:   Wyes Karny <wyes.karny@amd.com>
In-Reply-To: <20221225163442.2205660-10-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|DM4PR12MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: a39a8a03-e118-4f9e-00b4-08daef366bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQElmYx4FsZC4d+gfNtdudf9LRNLNZ5SHbkD7R77lp6+36pRubAA/W3R67grDCdpiCRyB7vwpbIgqFg/yyce9EQP4l27PjV7VULnlM5GdD7DCKSwfSByRAUcEVSU9xMy2WYQs6N83mWW9b5RK50TA/nMoWWjFxB0fKQhkIucJdsJvNCurQmP0ozlQfsr53aYE9D/KgmrthFM4iosE0bmnvgrVf1Y9N17ObwfYFtjc0C1jn2Pb+85vV3R3JjWWRuaDUPkTQrDthqyP/5sr70n1xvU5XcMslfXyilet0Dm+EZgO3APD9jL64zIlLU5Iz44n77LePBNHbr6zZvx9TuW5stGROMQYFo//AsXAWPj79RQYZfNmdiUTu4j35FQHCLGlzwgUxWwCYw/7KU7VqjqqZ2RRxzzTLKGskAjDu1OCs30ZYZVjL9jJfgpJwX+GrzyT8Ha1SOXnpk8euo3lkhAJU1TmSLiv31DfXgslwgVK8LrQjsLeBnqsR2CLdZkd1d12ziEuxiDvSM4m92fCYWDBndXVAFbNELuJBsFDzhD0dz7ugbBqJHCkU2AImpxRK0sziReU3RZK1T/BrzpJBqtuyE6V0gtyvmf0W7HtIbv7Wi6r9jcWRByK55pn6HsV8gbyEFWoPmLuQzfbCTgs98KhGLk1Nsch2AnKU1kalAr15m+SvEEezA9/lbBoKmdW9ZvPAWZZlC18ChUhtSGvF8AWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199015)(2616005)(83380400001)(31696002)(86362001)(38100700002)(4744005)(36756003)(44832011)(2906002)(41300700001)(5660300002)(4326008)(66946007)(8676002)(66556008)(66476007)(8936002)(316002)(478600001)(26005)(53546011)(186003)(6486002)(6512007)(31686004)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9FenJUcytkTWtNNTlkL0tRUnBvQzVMSVFyRW5WcS9pbjJ3T2tTN3lhQ0NR?=
 =?utf-8?B?b0g3aUl0U1o5ajhVcHgrNmdnQitwVUJiSW1EWWlqWHNxWGtUTkRmWmpTdHpZ?=
 =?utf-8?B?YTIxSkk0QlhwdERNc1ZPYzVnM2ErZXQyYWNaU3l3bmxiK2dZUFFTb1VLaVpa?=
 =?utf-8?B?MDlHTFRuUTR4aVBLdDVsQ3ZuZmJBbThoWTRFc2N6cFpkRkdKY2FDZTJQamVj?=
 =?utf-8?B?d3FZNFhKRzRzckF2SHFCemVDZzhqQ0RMM0FHN0N0OUthOFAzRkxNY3VEVjB5?=
 =?utf-8?B?YlFxUTZrcGh3NzVxeExhSzc0d3ltMXRXQzVTcEdCVm1XaE5hVlBiWFVYVG1U?=
 =?utf-8?B?MVAyUFpvalJJaU1Kc1BKL3A4L1l5V2p2bldTNk84UUJsd2p2amNXUHNlVS9W?=
 =?utf-8?B?amF3SXN3NlJsQ2ZLT2hweEpqNEYvM1ltYlEyNjRwMUxJSVgrOHJPa3luS25o?=
 =?utf-8?B?TlFoNVBSWUdScktFUGdXV1phdXQ5Mmd2WDRjcml6dy9pZzUvYS9sbENBNzRU?=
 =?utf-8?B?YUQzMW9qdUw5SzdTMHdlL3VTQ01hVjk2NzZyaUpCZlFyeFFNajZzZ0s5bkM5?=
 =?utf-8?B?WGFzWDc2ZVNOWWZGM2dqQ1JXR3krZnYxZ3M4TnVXOHhweWxZaFdYd1JOWGtO?=
 =?utf-8?B?VDM0bzBQeERCQ1Iva3hSTEtYVzludkZRemMweDJxc1JHbjV6bVF1SG81T1Bz?=
 =?utf-8?B?eC9lK0hGYXQrTnRTTU9pbFVpRzd1RnNKcEVSdS9pM2s3aFNJRFhjY0hmc3Zk?=
 =?utf-8?B?UVcwNmNUNFlJUFRFRlN3clNEdEZxVWZzQ2RzLzZlL0JUMWQ4SFRvUWVUYytx?=
 =?utf-8?B?aXZVdGNkTllGcXpsdWxOdWNPUkxwNmxkREMyRldOK1NaSnNSajgzVkpCKzhQ?=
 =?utf-8?B?dTF1QWI2NTRERkQxc3BaNStMQ1hEcFZuNjZPOUdxT0FzQlJtVEpCa3lDQ2JK?=
 =?utf-8?B?SkRQK0N4Zk55emk3R3hDenpYbkpORTlBbm5aRGJXb2xla3g2QlVrZ1YzSWdm?=
 =?utf-8?B?QlhORkJNOWY2SnozSmNTNE1ZMFltUnFXN29aNEZVeTlncHVDbGFad3hMSWtk?=
 =?utf-8?B?TzVPM1JWMVFkZmRLS3Q1cjdxM1QvTkhZL0lOYlZtNXY0SUtud0FseUVSVEFP?=
 =?utf-8?B?U0dNbXY2ZnJON1RubGdZdE1ySlNiNFplTWxsc2c4Qm4yUjdMWmp6UE9NZE52?=
 =?utf-8?B?Y0x3dnl4ZW1RR04yZFZtc3gvRkNHUlB5NjNGVWdubGZsN0Ezbm1JVEhRMEFR?=
 =?utf-8?B?TVgyNDNJZk1aQzNscTRHeE54V0Y2VlFpZDhKSzBNQVR4U0NrdnFWeTA5K3l4?=
 =?utf-8?B?VTVwc1FKMStlakhqY0JRMjc4WTNLT1NRbkpwaEwxZ2NTakdFMkM3RnFYR2lO?=
 =?utf-8?B?U2FMRkQ4bzM5aEdBeGQvZnc5KzljODVaeHFKb3prUW1vNzV5NWpiMDRzSFZY?=
 =?utf-8?B?M2E4WVVQZXU1MnduOWZndVhGdDVzWVNNMVpjM3JoYkYvY3lQUGlTdFVONmpF?=
 =?utf-8?B?QXZ1R2tBQVVvaU1vbjhRcVM5R0FYczF5czc0aHk1Tmw5bE84Q0FBRnV6SzJz?=
 =?utf-8?B?eWR0YlVmNlJ4dXF5Sjd2ZTFHcjV1ZnE0NFdMTWZYMGFhVFhjTjR0NXg2YU1V?=
 =?utf-8?B?N3A1S1JGd251SWg2cTBPc1Jaa0xqWnJIU2wxcWsxazdMZ0RUUUF3L04wbG9o?=
 =?utf-8?B?dGJmNnh5R3J2ZUo0dTZ4TUJDQ2hoWFB5Und4RXZKd2VJN0ZJMC9Wb3hMZmdp?=
 =?utf-8?B?c2t4U3kwZVQ2Y01qTmNMbzJiSnVGeGF1N21rdklYUzZXazhjS1RoV3V6VUc1?=
 =?utf-8?B?MTh1QVlYNmJOb3B0SnJsNlNlazF2OUFIdkZoMlZzSlV0N0hTWmtVSlFXTHJ6?=
 =?utf-8?B?NTlxWXcvTU9WbmtGc2lxamkyaWZDQ2V3dWY1Y2t5MnBWRFczUWl6dkg2S0hx?=
 =?utf-8?B?anY0MTVGa0pxbVgxNlAvZG9nQnBUWS8yWEk5cUVGUTVVdlNlSVFFOHM3MXhN?=
 =?utf-8?B?QmU2RXlQdHd6VEpqS25vVVQrU3pFbURnYVFwMDJRMkE5dVlZc3JvYVpqSTZI?=
 =?utf-8?B?OVJsa2tJT29uRnpnY2N6ZWp6MDIzTFBINnpxN2xCaUdHRHhpWG54cElRN0Qx?=
 =?utf-8?Q?jNLCGkdo5PoLX59C3BUpsbSvs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a39a8a03-e118-4f9e-00b4-08daef366bed
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 16:03:45.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2370xOi4IMtRMSa1fkeOzNgW1E0z3sEhbe6XRuPnBxEQXxexHA/Zol9pY02ITCfLDt3zNhaL1LS1arwWUOAw3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7549
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Perry,

On 12/25/2022 10:04 PM, Perry Yuan wrote:
-------------------------------->8--------------------------------
> +
> +static int amd_pstate_update_status(const char *buf, size_t size)
> +{
> +	int ret;
> +	int mode_idx;
> +
> +	if (size > 7 || size < 3)
> +		return -EINVAL;
> +	mode_idx = get_mode_idx_from_str(buf, size);

if (size > 7 || size < 6) right?
because possible strings are: "disable", "passive" and "active".

-- 
Thanks & Regards,
Wyes
