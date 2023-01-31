Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827BE68240D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjAaFep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaFen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:34:43 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C4B3C05;
        Mon, 30 Jan 2023 21:34:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkxOBMpy5OYrO+XIm4U9kbaz+lKu2hooaCmYvK7KymjdO+U2gqdwICTEssg10Opbc883ef0c/S3GNKdWTg7C+fGHO7jmxo+yS3mozC0LCDwsUFy+7W7ygE9jHg2wONQHYYogs2Gxs0E93s/cHS/mWLLtTh0K13NNgSwYfL2JcPngcPm5QwmftUIH54AxTEF3T+OKdxO7DJcTiV/JNt5vNND+v2a+S97Yk2gcXypZ2GCuEs+hTr/p8qw2Vfp+//rBm3BDqWmyq7HJaW8dYZhMeTNV8xeMUdRivpMdKLMrcX70mgdfi9xZlSaOf7KJgWHya0ZByayxxb2rsxdkK+Iwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrfW9vP/cnJ3WfWQYCRJXGuEyWKx9wO3Rr2Fb1GsabI=;
 b=aNRIlVv3GgUgp8xiHBZDpT//ptEDc+nGKJ6HhWAa9c+ENZeQOPwB0Al9NiqjHoxYlo43C82CIvjmc1FMuPEIBnf9zcUKN4Ng77EjnD4nrvJ4gSs0jbLJCgtXNVPJJ8eAAFM61oMi6vivAvRhDYC6VEyiHXMVUhIMfw7NDx555I5I03B6PSF+7ZGJyIc+NLiHWEXLcj6IRPDVMA2kCR33XVzI33u7AeaVIkywDpQpmANTFzJwOqydijiLhedpYbpV8lEwbr4+Ydzusogfa/J5DebipoSa7aOn5VjwhnJkkPQlBtC+nQmUbQleIH6B9jtUQ40R5yuVYc0lg3yZC3YXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrfW9vP/cnJ3WfWQYCRJXGuEyWKx9wO3Rr2Fb1GsabI=;
 b=Mof79XmK5F2wyqomifCsQHh7Vy8TlnHVYauUnX1jibF96R7C3WK+AQbhWqO2/Etlf2y1YZprCCqHCnoVjYKld0Yq3RozHoGY7BtfL8SK1dnOcSHYQswuYGBPHgf43imEnk2iD+z0NRpAoOsKVlFXqCDuGA/zsZyeE2h92meKWvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 by PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 05:34:40 +0000
Received: from BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863]) by BY5PR12MB3876.namprd12.prod.outlook.com
 ([fe80::4ac9:c4f8:b0f:a863%7]) with mapi id 15.20.6043.033; Tue, 31 Jan 2023
 05:34:40 +0000
Date:   Tue, 31 Jan 2023 05:34:27 +0000
From:   Wyes Karny <wyes.karny@amd.com>
To:     Tor Vic <torvic9@mailbox.org>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>, santosh.shukla@amd.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 0/6] amd_pstate: Add guided autonomous mode support
Message-ID: <20230131053427.cdpg5zaqyxf7ou2f@beas>
References: <20230119115017.10188-1-wyes.karny@amd.com>
 <8c09f806-b00d-515b-bd1d-2f433e44b1a4@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c09f806-b00d-515b-bd1d-2f433e44b1a4@mailbox.org>
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To BY5PR12MB3876.namprd12.prod.outlook.com
 (2603:10b6:a03:1a7::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3876:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0253af-8c2e-40e9-87e4-08db034cd93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rn/BQDAsQYs6z0rdhywNYLwrP2auuKgKncwi0dn1WvvpJ9mczBoAMSK1sMueOGeytwI0XDSpuy7gx3DE+ZmvYaMk652pOSSCR27HVAsyaHnTRJnYaKXbG5vI6BmA8iDVEcqQDB+IoSgBcJ/qvaOU/1KWsedzKqeN4A16PRq0M/5Kiq1Ecy4Dq7rPWt8+1qqhLnJCwp/ruOcPudqrtQ8lo7Tx3yTgCLFYJmbSfhvZ1CPAU1bLhA40ajFRzsQ7DuRp7GOJGJYd7aFQ8lwjf0o8Wxg1+m7Zujbwl4r5hpiKXBero3Z5DjcyehN/8KZFkcX6E8SMrgmYdlItbPygfU8IxzfgEPwUNf2VGX7gMoa2PkBT55Z6z7aClrlcYbCP3VPkdZ/W4I7u4XDJvk4avVzTrL9DaszlLijqqXOZMdwrlgh04AqRTZWy/8fiiQI2tcN1VoCQybsiLml50yZLRh9DwPZqFe+/V6QDtZdbtQ0Uh4eUA+F6vMo9P8Va+TDCp9i2ejPLPb7UQakZOWA+VC2qp2IOqI364IVbOLE1ANhTzsVqzoX4lyQjUpSarZBZB1zkrU7H9ybntgUrbLA11yuOkdAITl6wbYP651n5DsiggmwEzrbJgc09agACNiWQLbHui/tVwtbbAyXqO0PxIdXRqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3876.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199018)(6916009)(66556008)(66476007)(8676002)(4326008)(41300700001)(66946007)(8936002)(83380400001)(33716001)(478600001)(86362001)(2906002)(316002)(38100700002)(6666004)(6486002)(1076003)(6506007)(5660300002)(4744005)(186003)(44832011)(6512007)(9686003)(26005)(7416002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gAVue0XIByMFizkYV1R5Ib38pXfb6lZr6y9mrIC4N3aXv1JgP8fDVjQrt610?=
 =?us-ascii?Q?foWL1fELNDPBfbHDfG1zbmeL+eK87as6Bpf3obYm22bB6XVLdiZYDMNbnLAd?=
 =?us-ascii?Q?E0x132Zz41c56nUK9q4WweeI14Rzq6G1wBNg5Rn95Clj5GitRJVhwgcXPtA1?=
 =?us-ascii?Q?9kAxHRKtdivU487q92jxRAXSk4cOjDfUewv+xAg+gzc2qu3Tv+ftBh5RT5S+?=
 =?us-ascii?Q?kuA5oXs4Z6b9y+xGoUl8MLV2ocoXJ6Gq8k7jn29B7m8/GMfWQIK9H+PMx04B?=
 =?us-ascii?Q?znRjK2BlzlJrzpBy5eIpNGIc2XCdVYwvA9cwLTS7aaPcPKWw0sFmbhHfz9Vl?=
 =?us-ascii?Q?a5E2ZtjY5D38quR5cDDs3YOct5YH2vmi+kxNkchhakXG5viseTsLsKN85Dit?=
 =?us-ascii?Q?wcoSjpumgdHYIGUAVCbgKmjySKYAfZ+zhOu/9MLqikWguznSpkWUbT2UudsO?=
 =?us-ascii?Q?83hSiALFAZm77oUO4XGgfOH8/nM+0EUFpz38DTvDuGpTsd81kJwk1XFUfRIs?=
 =?us-ascii?Q?7IOkCRNFfSezZwCw2xw38JOjXxzsklhvyYMnVBJo0SzoRvMiIN2jbFOa2TOv?=
 =?us-ascii?Q?b/LuiI0TGSQ1iA5iHFvhXEae3mZEAxYd+/dBJw+/HOvv6DSZcbxCz08hm1a3?=
 =?us-ascii?Q?THieE6D99nYN0JdCu+GsBW8a/NrD/ADlfDKN2t3vILe5MlhAI6YuwJQhFTTg?=
 =?us-ascii?Q?gvN+CyGNBo2fBhv0YqX6vyS0HgscoDpv0F4JS9Vo288ajUXq8RD2jyJEcpws?=
 =?us-ascii?Q?YUxm52vTkZvujAQu9DlkfavLZP2scoM8iWsrkvYnuy2+sar5+ZxowxI4kgg8?=
 =?us-ascii?Q?bHR2xqPZwa0pyzVh+p/oWz6SX3J/6eIrTrajNeMsiVv8K0Ym21hZT0akwH6+?=
 =?us-ascii?Q?ptOaNbOWGqD/QmElNI9ODXH9iRmPpmca3nzD5pncsfBIo0Rlk64vxN2b5qmB?=
 =?us-ascii?Q?7m5tUqpCeaIJTi/WYV1MYK895jboIXXdm74baBbgrLqHInWi1QbAphyFYXu8?=
 =?us-ascii?Q?8dV66fSLG2Lw7byP80FdFQWTs+iUirAztyFpQIc8afGGg21yQIRqbWb5v/Te?=
 =?us-ascii?Q?Qaly1cYNfKyZmB95WThw/QwPszTAocaZpWsoNoJv7Axu3+xTnEG5tCgAiAjz?=
 =?us-ascii?Q?XcjpKkaTOAIeXkuwGUiDd0fdDn17QWgRWi6jjpEOo33i5gor6Hq68wZTexnn?=
 =?us-ascii?Q?mX5ISnOJBqOPskcGA0xvjdYGuWPZVvKvbmlM/B9g9MnuHBjXckvl2EylQkn1?=
 =?us-ascii?Q?NMyMk1sjGBxG8g4FrwrDEXVY5NJi0bNnDi73tjKFpR8K3SuA1s6aFb4+mazw?=
 =?us-ascii?Q?+JyDrLHlD1lh/mNKArSCLKFDZyFuoIERPzow4+gtk3W09um38FtGCa4uoHVP?=
 =?us-ascii?Q?YmTlhQQ0CSA/hbfu3gmSqqkgCzZn2kh4AcijU/CwNL17imXQkus+zuYnsvIf?=
 =?us-ascii?Q?xz25s0U+It6OG6aWinwRCXZQ+/v2k/tU/VD/+2rvCmzYycDvynp7WZrU87YX?=
 =?us-ascii?Q?ftMmqovzb7Gl2O5z2C+BT1aiiycaHBiJAkhQD90qvxkY3LfNCUaFOxkCmRPq?=
 =?us-ascii?Q?CbY473uUx4WZtjSmzGs37b+5DGXQV9ifJjHyBvpv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0253af-8c2e-40e9-87e4-08db034cd93c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3876.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:34:40.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83Zvlhcd+gAx81k7MfLLCV/DK8mph6Fa3wfWdpA3gADwRG0ccOa/DWRraXn/lEUfl+tJYozt/Yd3+WYrA3yqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tor Vic,

On 24 Jan 20:40, Tor Vic wrote:
--------------------------------->8----------------------------- 
> 
> The "active" mode seems to be broken here on a Zen2 3900X running Linux 6.1.
> Frequency remains stuck at minimum which is +-500 MHz.

I've fixed this in v4.

> 
> Some queries of the new /sys devices lead to I/O error:
> 
>   # LANG=C cat /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_*
>   166
>   cat:
> /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_lowest_nonlinear_freq:
> Input/output error
>   cat: /sys/devices/system/cpu/cpufreq/policy0/amd_pstate_max_freq:
> Input/output error
> 
This issue I'm not able to reproduce. Is this issue seen with only EPP
patches also?
Could you please check if this issue still there with v4?

Thanks,
Wyes

> The "guided" mode seems to work fine with no stuck frequency, but also
> produces I/O error on some /sys files.
> 
> I haven't tested "passive".
> 
> Cheers,
> 
> Tor Vic
