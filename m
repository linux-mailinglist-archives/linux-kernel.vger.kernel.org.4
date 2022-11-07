Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF161FDA2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbiKGSeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiKGSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:33:57 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED3C209B2;
        Mon,  7 Nov 2022 10:33:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVpdolVy0RsAfggYX+vqVp9qKhyTFjy1UGhW3DGrM4V2y3fJBQQGXhxumc7RlSx0Z0Oa7Km65eWKcb/xVS6lfdmIhXYRQOI0qRroIv8dvCRzXhV2j5NciVoaGLw1PcmZeysDzmMq8SqKMNRyThI0rUA63EVD5KDmrEA9rtt4oIs5sX3VRHLqugLvicp9onrW6AFKsKaUs3HsRWfEu5+Gpg4uJPT3XdFOw/POYUplkAonQGOMoPn/b6b+Qy24HNG590LojA+eQCnTG1Mwm1uddZItylZvSyk1Y80WXq0jQmSQqlvAnjF8cun6F5Cn5ypO9xbh3bu2B4l76nQMVHtfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWX8v9oFDrcZCKWdMeQ7BJEhEEhjxFzbLHw6nXpiwsU=;
 b=ICJQKN28QeHpKJaHUTa14k5NQlrNeLnwhoZ/j90JEdnxCEYfVVEvhg8Q89dGLG2y5TV682UI9/yyfQbdd+PYlyGaoVmRJfHrrx925nqa58kkw02UhLVw7ThruszdlWBeo7kPqSzNov2o3E4jATYYZ57CP/yrQLA7w3yt6u2UKJkkK7NQosv+kHbJ8v+B5lE0o7sXwBHKgUwnOEWFqnpayaDUGJ1PFpflVi92sv3A6IsMXTnXP98HCGPL2deGjYLJOKqt9+x7jm8/37xoEWRfV1TRdtMi2fM62sAdarrpHF+/ANmdWp23tpt7umk3iINbBx8rF7eV0yil8ohrcE9jZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWX8v9oFDrcZCKWdMeQ7BJEhEEhjxFzbLHw6nXpiwsU=;
 b=YuRRTTqSJP+I9EegXQqhimS7IsNOznE1HPtpUixn22+ZGWfRorHBkmzhrC1CoPdYeZF1T9nEynZuJJecxyMAqVb915arfxwl02d3kRZPYk8hdG+gT8yz2edr6pnFbgh7AEnzuzBkc8Rs4S8EZuFHhMU0NKB6hvAVbzLkfOkeaFk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 18:33:54 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f842:a9ba:3f41:3c3c%5]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 18:33:54 +0000
Message-ID: <8ca9feaa-90c9-93fc-38e0-3c41d51dc845@amd.com>
Date:   Mon, 7 Nov 2022 12:33:50 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 2/8] Documentation: amd-pstate: add EPP profiles
 introduction
Content-Language: en-US
To:     Perry Yuan <Perry.Yuan@amd.com>, rafael.j.wysocki@intel.com,
        ray.huang@amd.com, viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
 <20221107175705.2207842-3-Perry.Yuan@amd.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221107175705.2207842-3-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:610:b0::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 070fedeb-7f7f-438c-1edf-08dac0ee9ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+tRs2IKM+Wg4NScIJoGnf4TG+bU0vMpBHTzbbeEqR7lXeUkzToxYl8th0WfmJl1luZk7UCP+vORr6a2byowSodPuFzCeWyVuFKHWhB7Sa8gDA4EyaYnLFB7tCzZoRQ6IDBg4pfTNPMHXaKDvrqxE/bsDtBpPbFBPg5uYrpfXKuEc0CbWlnh2fefC0+MiZ4g5K+5tHihJsT06sYwi9NHWvDK4zJCFgBNIe81GE0OAcsG8XDUc73odJn7g2nrjRLjLJG1kZWISx+S++3Qzr+ejgPmZcZ6ylBorez/JmpKT/drZqbroef95QmcF2EeirkFHL7iO47iK+BAVNmlXIKmB+psEUlnJgxgEeI68d+/03u13CRxn4OYu4XCv08LMgrnB0Ygjo/SpC4j1mj2gq1qDiANw+/0kSlvD+I+FZokC468cP44ZH4cIYVExQSr1nGKMEJhOOBO/mDCQqByTBBsmimdwiX8A0oOfxZAFLlZWcef6WTw5MCL3PhrNLgVmyAnPD5STVQwV/sR7iujavG9iCYoiPw2q3gLkZXXPHbph73RcWMmKpcaLBeG2TMaxWQ1nj4agGwxLpH5S8iwCb/m8TInUHIZh2tZzdKazElfk5EzFlraaNMdhIp5rq1OtYPT3+SuiO2sl6COGlfvYCO+GF6Z7FaPZIFlrjEtIkie9PoiYTita8+vJ5nbkFEyqvG9hiyhsjALQlpkjMX+VZ7rOricjTf/z8pG3awsOfy46N20925/BEZnur0XbTMpBSCcP7HCThzRm6NAdlu1zpSnICzmZVbA1jqDlZH223hkTzz9k6GUnj1r8bJzR1y8/7NDEJJVp38zdDcBrf1uOh00kd7i6sLBdfZ0KdLLfZDhvTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(31686004)(83380400001)(186003)(316002)(38100700002)(8936002)(41300700001)(6666004)(2906002)(6486002)(478600001)(36756003)(6506007)(53546011)(6512007)(26005)(86362001)(31696002)(2616005)(5660300002)(8676002)(66556008)(66476007)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NDVURMMjNJbXdLaC91SE1BSDh4RzRWS0tFMTZ3bWxoNjU0dVY4NmlLWTJn?=
 =?utf-8?B?eGVDNWQvemc5VmdkUm1JYzRPL1c3eUZoTWF6cG9QTXhnTklRNDkyaWVWYVl0?=
 =?utf-8?B?Q1VHc2RWdE1aOE9pb25xdWhlc3ZZZEwyaDhodGp5eGxiTFh2OEo2TDhycVZa?=
 =?utf-8?B?dTB6c21GQ1dUYmdkNW8ySVRwb01nemx6TTJQbm1xTjFPTXU3N2ZUVWFDdnV5?=
 =?utf-8?B?eHUzWjMvbjJGbzBDaFo0ZEEvQnNhNnRSYzM1dytaWlYzKzQ4R1ZucXFJR1FS?=
 =?utf-8?B?REJYcHhnYkl2QnR2V0c5d05iQXhBQVJRUGpvRjlTWUUxSXJreHg1eU1pVXFJ?=
 =?utf-8?B?WHRGcWg5U2dUS3JNakovMkhidFNEbVBIdzhZMEZ1NFdGZURTTUxnN0llSkpC?=
 =?utf-8?B?OXZaRjQ1Y2NTSno4Z2RWdThzdUpxM0JhcnJRbWdrdlR5VDFnNjJnNjBueGdX?=
 =?utf-8?B?cFlsV3NKZm1pQi83c096bXE3NGZrZDFtZFpjcjVHd0RIczVaN3pBZVdNenBS?=
 =?utf-8?B?UHpIRlpvZ3dhdTEvQk9ZNEFXZ0duQVpIendJRGdlS0RCTWFHN2RscCtMTW03?=
 =?utf-8?B?UkZiRTczSG1YM1lrYmhXZVJIYmF2N1JyVU8yQmRlLytqM2dJMEo2V240ei9B?=
 =?utf-8?B?dVlVWUhFbGRBaENSZHRDcmZkUXBNYU9Qb1B1TXJlbllSb21QTXFaYXdCeW51?=
 =?utf-8?B?N1FDNlZ3a2lIbndpNjAyUFFIR2hycE5HaFB1WDd1LzZDeFg0WUptZ2ZlRldj?=
 =?utf-8?B?eXZ2QXUwVzRNcGI2VVNtTGF5eno2Vm92My9VaStyL1hyNEdtZmY5bXRDSzlq?=
 =?utf-8?B?MjRPcDFrcFZzL3ZsWFpSaHlRaGJGWlFkYkhUTzVnRHBxaXlKcXRFYXJEamw2?=
 =?utf-8?B?bnJ5TXNOYnZHVG9NWTIydnJUbW9OMzFtc0FFVHgzQi9EUDE5b0IyblZjOE55?=
 =?utf-8?B?dTdiWVdPcUIycWYxd0VMYkJhMi9JNWFDUkNZVFloZ3U0T3h0aTAwOW5ZSTQy?=
 =?utf-8?B?c29vUm5LT0RMU3dwQXRMeFJmdTJ4UG9LcERWd2VsMGROUWlqMkpYajgyWDR3?=
 =?utf-8?B?UkN2ZXJqcjZWaSthMkwwbDh4eVIrT2lPaFlqQ01OdHFWWjBybVQ4S2dmbFdG?=
 =?utf-8?B?MEY5Rms5ekpsWXlMekRYK0haUHk3TFlZSE9MMk9jTEY3a1JJd3FXdEdvWUJH?=
 =?utf-8?B?TEF4dmx3Qmk5dXhJdU9DeGkwYW9RcHkvdWROLzFxQ0xxenBDTit0eVRGYVIx?=
 =?utf-8?B?b1ZoSHhKMFNsYjU5M2cvcmVCOTlZVkpjcFMrZ2U0eVBUL1VIZEZQTXJLVEZx?=
 =?utf-8?B?RW02RkdFNk1LcEIrdHpzendZNjB3QkJpN29Hd0QzSVRHdmx1S3JxdWd5bklx?=
 =?utf-8?B?MFU1a1hhOWQxaXJrWW5OenRlcUlUUmNYbDlMZ1FJWFpBdFNiMUNqVktIT3VE?=
 =?utf-8?B?dEpxYnhZWGFhTy9jTzgwME1kQUE3anJxOW1KaGhBbVFBWEZoNUo1Wkw1MFY2?=
 =?utf-8?B?NjdtaEpBY3NNdklOYzlyeTNUWk92eVZoWitsM1krcEVxVC82OGVkeG9nUVN1?=
 =?utf-8?B?ZHluNUk4R3QwTHpIS2tINk1qSllBUmx2ZE1IWDNmc3dNYmxFU3dXRHZPcFUx?=
 =?utf-8?B?aUgrSS9oaEg5YkZVV2s3Q1czTlhWRWJpb2swc1FTdHo5L2dkWWxuK2xXVVln?=
 =?utf-8?B?WlVwcXJIN1R5WDVqS1VVZE00emZCOWg2SU5yaE9XVGFsMjdNMm9wQUN0SWNJ?=
 =?utf-8?B?YTVnWTVZOGh2ZnU3RG1DclhOeG9Qd0xsRHV6OHRwKyt3MkEwRmZhYTVzRldO?=
 =?utf-8?B?TzVNa1Q5YTJJMlR0dnRQaTgybUtYeXQ1b09vNThyYmhrZU1zNjJPekoyZzQ4?=
 =?utf-8?B?S21WbTJ2cyttTUlwOE90ekFhTWNGRmt2dXcwRUZET05qZTBTSHdVZjBiR2dN?=
 =?utf-8?B?dlljZHdYaFdoVzVrUnJiemltUVNhRm50Z2RpK3FiQVJoczZnWGZYSHZmTnR1?=
 =?utf-8?B?ZHgxRElSMEx1VW5iQXdWYy8rcmVNbklCYm5Kc3VjTFVZYWtuL05QRUZMcU5v?=
 =?utf-8?B?VUgrWnc0WmM4RXNhY1pWeHIyR3ZBSjZHMkUrTTdtZllSK3hZTVZmMExieVNp?=
 =?utf-8?Q?3xUx24ODVKvR4HeZgRmchqP5P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070fedeb-7f7f-438c-1edf-08dac0ee9ffb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 18:33:54.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFqTDUsYy1uVY4luDQAg9wOkNeVTOXcXFkHCeoWrpazff7QQKwDfUYt/LKw+IzLota95oW+tCn0KRk7T9YS7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 11:56, Perry Yuan wrote:
> The patch add AMD pstate EPP feature introduction and what EPP
> preference supported for AMD processors.
> 
> User can get supported list from
> energy_performance_available_preferences attribute file, or update
> current profile to energy_performance_preference file
> 
> 1) See all EPP profiles
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences
> default performance balance_performance balance_power power
> 
> 2) Check current EPP profile
> $ sudo cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
> performance
> 
> 3) Set new EPP profile
> $ sudo bash -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 8f3d30c5a0d8..78c6525d5a49 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -262,6 +262,25 @@ lowest non-linear performance in `AMD CPPC Performance Capability
>   <perf_cap_>`_.)
>   This attribute is read-only.
>   > +``energy_performance_available_preferences``
> +
> +All the supported EPP preference could be selected, List of the strings that
> +can be set to the ``energy_performance_preference`` attribute
> +those different profiles represent different energy vs efficiency hints provided
> +to low-level firmware
> +however, the ``default`` represents the epp value is set by platform firmware
> +This attribute is read-only.

My proposal at rewording it.

A list of all the supported EPP preferences that could be used for 
``energy_performance_preference` on this system.
These profiles represent different hints that are provided
to the low-level firmware about the user's desired energy vs efficiency 
tradeoff.  ``default`` represents the epp value is set by platform 
firmware. This attribute is read-only.


> +
> +``energy_performance_preference``
> +
> +The current energy performance preference can be read from this attribute.
> +and user can change current preference according to energy or performance needs
> +Please get all support profiles list from
> +``energy_performance_available_preferences`` attribute, all the profiles are
> +integer values defined between 0 to 255 when EPP feature is enabled by platform
> +firmware, if EPP feature is disabled, driver will ignore the written value
> +This attribute is read-write.
> +
>   Other performance and frequency values can be read back from
>   ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
>   

