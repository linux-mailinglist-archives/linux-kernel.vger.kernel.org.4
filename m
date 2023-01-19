Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3D672F3E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjASCuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjASCul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:50:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAEF6843F;
        Wed, 18 Jan 2023 18:50:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UY5WBl67ami4i6XN48OqDbz9sabBaLa4Wm6DOys3DHKlFwBifZlJ9jcObeR1WSUgGZsXrTW2Sg7KZOhObt4GtKD9d9LMh8fiBAekn2/2odwRZuZVRv6ykUs1K0fOMWTU2xLpEVXm36uf/j2DgQwn2NoaRI0FYoyjriCwL04CoB5bUxZzJTHKnaH6YgpPIkZY61C2RQZgTTAAbxGGuywUX1j1VUjLvCU/RVsaqj9s1yQnnG+uZXS43UgTpf81SJB9BhZQshwosoYTB0xWh9pVf7Wxukktkiutpy/NxJJf8JEq5RLyiAoaEb8L4Yae4ux3ijHGER/Z1VJ5pQCHvfF/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11bHEFOcE/qvbvFL4gCKtt/vQzEl2IVt9ZJCc3P0aIU=;
 b=VaxJs0NYg8s3Unq+z63HmhldJvqZ8c6YLp2g7ymJrsLdFXyOFjZA1R0vUtzUqKFBPNmDDX8Hi/H/ji2R+ydeq/aMPAuI+sumU1sEDAB9NyKz/9WjskYdYHP86Bqn1zriEqJv4hY9F1lhrIB4SARJ6wKXLvkO2fRNWW1EosxuNAUvV9zMwGPgRAXdDUmz9gw6RsQ+nymJfsBoM4j4q9O//Tg9BdGD1XAtTSzB4ZtoWpOKI494Du6Bhu8Hx/bIypf+B8OxT8DDDPXnPwmCA+aqGYLlduZABgYRBEAxFG5B58xXY8Uf7tMnqgQGDj/uh68KkIF7mMfZ6aRYs2nZxIFLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11bHEFOcE/qvbvFL4gCKtt/vQzEl2IVt9ZJCc3P0aIU=;
 b=LIAYlgeGpo0Z9P5glR7N+khXqQSu8cW3ewscSIqsK7Zog24Zaf0HT7V49+GA+RM247l/79kac5sAxMIvP3BgtTaFZ9RcdDaokGCKC7EEpIyNHZ/2AfqyozrDXn0zD3hl2hVgZ4t2vopXzUYLGh66upqJCLw+uh9Sk6qddZA9QJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2506.namprd12.prod.outlook.com (2603:10b6:907:7::12)
 by CY8PR12MB7193.namprd12.prod.outlook.com (2603:10b6:930:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 02:50:37 +0000
Received: from MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::444e:a4dc:f113:7751]) by MW2PR12MB2506.namprd12.prod.outlook.com
 ([fe80::444e:a4dc:f113:7751%7]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 02:50:37 +0000
Date:   Thu, 19 Jan 2023 10:50:15 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/11] Implement AMD Pstate EPP Driver
Message-ID: <Y8iv56PPKkhEsL02@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
X-ClientProxiedBy: TY2PR06CA0031.apcprd06.prod.outlook.com
 (2603:1096:404:2e::19) To MW2PR12MB2506.namprd12.prod.outlook.com
 (2603:10b6:907:7::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2506:EE_|CY8PR12MB7193:EE_
X-MS-Office365-Filtering-Correlation-Id: b00a87cc-2c89-4e83-a2dc-08daf9c7f16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bdvg0WH/4oivzVpNCgtWGJTwEhaTk5PDaIN/FSKcveLUZTSuDDuxyGfdhkU8JvkKepJx/89p/8Aw6Dl8uvn6jb0nW7rKDkkM8dr4DYZ2upcc8/+8FV4Wcc5DPd0D7BaWulp8U5tsRLY5zTmCG90m+DYu2ynrFHedCKiyjGbBA5i2/q1PUqYrkP8OA/ltmbOhZEg2bl/FaB/Hv47f3GwP5vT+qWIdAxPpFaElQGiI67G2RnqkFGpzkka57q/9JYXZv7MxJNnTYwEvj7mlmks3mk4H9fPmlHsL30UOyKtdVDSo9oxeHv6GeJ+C7Cm2seufn9ymnlc+4k4XQAqVZbQwLGPC1pndiFvdFFi3qVSUEMsRt5dWVi/l06HvP3G5tvjihaMyLTrbAi+EtGEwl8pVaFvieLks52I7usDuHliS1Uhpm46YZ9ijkjb/mgWdw4Tf5c/NJcWevyZLav+cyR6HM+f5XTmbUE1NUPInmC3YUb8KcCfjJXppClvWRVuTOczE+mHu60CpXt5hSl74Rl4f4+8tNPZT8/R4+p2ZiBrmLOeZTJerPu0PGEj7HU1vl4CZmOGVgxPhI+agMD4/1fG/H16xyKOR9+Tc+Tk0EkQVGtIgPju9jV4IFVYvmouR6tJm+CbK1ApIkZR+rxL0BSD9ZOV2kB34ZUauQhKUHdtUq2+WV8kqfEqu0sM4zr3Kdmb8xDQsmjIxMPzOTWG9MN/dwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36756003)(8936002)(2616005)(83380400001)(41300700001)(4326008)(316002)(110136005)(54906003)(66946007)(8676002)(66556008)(66476007)(38100700002)(86362001)(2906002)(5660300002)(30864003)(186003)(6512007)(26005)(478600001)(6486002)(966005)(6506007)(6666004)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfCdTMXn/3UbKC0IqqfiCnJg+95CDxkwtAztKsjaQ+RbExoiT5OpPtALQoXT?=
 =?us-ascii?Q?OmdwswOmvTJw4Vb+7ft812bIa6XQWqGnUJSH10pLXOwA8uKypqIH8LpXKO8p?=
 =?us-ascii?Q?RwKr1QlYcV45mFscJKN6RbQ29uA4SVgciydUP+TuFlfJaBY6o8J64yZop2rD?=
 =?us-ascii?Q?IuvHl0qym8KXgIQ1kSuqoOL5CEpMaIDJvsX9Y1VwCCfMiG7JwMd4Kw1E36nr?=
 =?us-ascii?Q?flrrRpcUpx3XMGG9KWU988hCrBXnmxBjBNbEBVQ6hyRhZWJVvTf9DhCxoMUS?=
 =?us-ascii?Q?CLOvk4gbc6qPabaZCD8QYPsLuXdSz+3igZMJYd5Vl7eAIiMNcrxghX2pvbw6?=
 =?us-ascii?Q?/QYplXKB7Tp7yRxAraCf7/UV2z+WEf2Oj2hBlOekY0TAeWA9HbH5pJuY6HDL?=
 =?us-ascii?Q?mn+If5J+AlzJbl135FguU3lJhYGdsElubqB9ryVeiOVD0WCrOtvUu1CJ0lWN?=
 =?us-ascii?Q?kZx6MrpthBkKfd38Fs9twtjuIyCx+r7FMH/tgKquG9pwOqe2rwc824u0N2Lt?=
 =?us-ascii?Q?Eli6yx7aqHD9TrSmuuLutFG78aUG4VUvCEze7vmIgASq6AxlAA4eBmM+RiT/?=
 =?us-ascii?Q?exPRlnrMuiYuXf9kXWcFEGtGF2sMBp1ewXJUK+uWQBV7w0bBMLd7uRpKVOl9?=
 =?us-ascii?Q?tMlsKpmq06XzrOqP+r7EF27FBo2h8nA7g0tk4JPqbqNqeoyh8WPdZbpDyVZh?=
 =?us-ascii?Q?OImb7jEmLSAQJ90B3GFFdvwH0I1l7rBAM95rJHPLP+dIzj66wxbduluOy5SE?=
 =?us-ascii?Q?Sq/xy/uLfcReFPn6Ztcbzm3MYpTUIUQhFtgb8YL8SZcZDJ6NQOc+EM3GgFhe?=
 =?us-ascii?Q?D6dOqw4Ij+eBB0ITbS+hGfaGZI0JmcbrCG4KIW2u5CQr9bgl9YanPkGhIndy?=
 =?us-ascii?Q?gnOt6W5G2OV6H5uizA75c0ACnchBqV1YUrlRRey/Bl20oFfgV79zK4fckMyK?=
 =?us-ascii?Q?Mp24g9zXMrGU4AwwdGkUkZ5AxZouEGlq9P1jLTjaHyjiwToUlH7UF1nXhxwL?=
 =?us-ascii?Q?BPmugx0Urgl5j0Rx9qpyhsqAU2efuL6BEI+3xS+vwdvaTSUknlPddpjSwWST?=
 =?us-ascii?Q?Kxty9vg3SWKcQYTfWO9PIL/b4RroVRbuALj+lewlsACEFGkV/Z0ylhfqN2JT?=
 =?us-ascii?Q?ci+iHii9qjuKTVibqSGEM/1SSjFhvaCWgWpFlg1jYsEvOJtkGb3oldZh6fPz?=
 =?us-ascii?Q?NJcZ9D8ECz3I99WEQZdb91fip7Mk79bLC9HaxqlksMVA0uj/Wm3Kxd19g7VR?=
 =?us-ascii?Q?60W5Q7cq2LtSLuqkTyfigxaggt8KPxPYERoJ/62Z7BMZBIbtLCewdkWNRKoY?=
 =?us-ascii?Q?GVOBMCNC8ZoYeHfO7yLQuC9MnblpIhB8TkzWi0nyJ5dybL7KxiZKzglCPndm?=
 =?us-ascii?Q?PHZbplydWw5XEcoRJ0cIRAnUBtGZ79ZOZwcCEDgKqH/FqVHOshcAyXWBooKZ?=
 =?us-ascii?Q?tsriJbSXq2qEW1rTBZ1gsaVRXCqL4BlAQBpoqzJEUcoMd7U5kjV4X9xIUaUT?=
 =?us-ascii?Q?fGeNFM57aC0t0RpxeIKas1bbBhEX12OYe4q/6DzaGDdxxI0+o1HGrFyMRMXo?=
 =?us-ascii?Q?7t/mhTu7IpkWvAyxbey+azUx5Jku+Xbrhuur4CQP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00a87cc-2c89-4e83-a2dc-08daf9c7f16c
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 02:50:37.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/1AMGlcbaCW1DxNxxlT4tEtO/m9SIFdgs2id+HBr/jzsO/Z6zO5otLWA477xFIeIjMT8BboL+D9GEdhiggrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 03:51:59PM +0800, Yuan, Perry wrote:
> Hi all,
> 
> This patchset implements one new AMD CPU frequency driver
> `amd-pstate-epp` instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).
> 
> AMD Energy Performance Preference (EPP) provides a hint to the hardware
> if software wants to bias toward performance (0x0) or energy efficiency (0xff)
> The lowlevel power firmware will calculate the runtime frequency according to the EPP preference 
> value. So the EPP hint will impact the CPU cores frequency responsiveness.
> 
> We use the RAPL interface with "perf" tool to get the energy data of the package power.
> Performance Per Watt (PPW) Calculation:
> 
> The PPW calculation is referred by below paper:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fsoftware.intel.com%2Fcontent%2Fdam%2Fdevelop%2Fexternal%2Fus%2Fen%2Fdocuments%2Fperformance-per-what-paper.pdf&amp;data=04%7C01%7CPerry.Yuan%40amd.com%7Cac66e8ce98044e9b062708d9ab47c8d8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637729147708574423%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=TPOvCE%2Frbb0ptBreWNxHqOi9YnVhcHGKG88vviDLb00%3D&amp;reserved=0
> 
> Below formula is referred from below spec to measure the PPW:
> 
> (F / t) / P = F * t / (t * E) = F / E,
> 
> "F" is the number of frames per second.
> "P" is power measured in watts.
> "E" is energy measured in joules.
> 
> Gitsouce Benchmark Data on ROME Server CPU
> +------------------------------+------------------------------+------------+------------------+
> | Kernel Module                | PPW (1 / s * J)              |Energy(J) | PPW Improvement (%)|
> +==============================+==============================+============+==================+
> | acpi-cpufreq:schedutil       | 5.85658E-05                  | 17074.8    | base             |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:ondemand        | 5.03079E-05                  | 19877.6    | -14.10%          |
> +------------------------------+------------------------------+------------+------------------+
> | acpi-cpufreq:performance     | 5.88132E-05                  | 17003      | 0.42%            |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:ondemand          | 4.60295E-05                  | 21725.2    | -21.41%          |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:schedutil         | 4.70026E-05                  | 21275.4    | -19.7%           |
> +------------------------------+------------------------------+------------+------------------+
> | amd-pstate:performance       | 5.80094E-05                  | 17238.6    | -0.95%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:performance              | 5.8292E-05                   | 17155      | -0.47%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP: balance performance:    | 6.71709E-05                  | 14887.4    | 14.69%           |
> +------------------------------+------------------------------+------------+------------------+
> | EPP:power                    | 6.66951E-05                  | 4993.6     | 13.88%           |
> +------------------------------+------------------------------+------------+------------------+
> 
> Tbench Benchmark Data on ROME Server CPU
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | Kernel Module                               | PPW MB / (s * J)  |Throughput(MB/s)| Energy (J)|PPW Improvement(%)|
> +=============================================+===================+==============+=============+==================+
> | acpi_cpufreq: schedutil                     | 46.39             | 17191        | 37057.3     | base             |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: ondemand                      | 51.51             | 19269.5      | 37406.5     | 11.04 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | acpi_cpufreq: performance                   | 45.96             | 17063.7      | 37123.7     | -0.74 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: performance(0)               | 54.46             | 20263.1      | 37205       | 17.87 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance performance          | 55.03             | 20481.9      | 37221.5     | 19.14 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: balance_power                | 54.43             | 20245.9      | 37194.2     | 17.77 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | EPP:powersave: power(255)                   | 54.26             | 20181.7      | 37197.4     | 17.40 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: schedutil                       | 48.22             | 17844.9      | 37006.6     | 3.80 %           |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: ondemand                        | 61.30             | 22988        | 37503.4     | 33.72 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> | amd-pstate: performance                     | 54.52             | 20252.6      | 37147.8     | 17.81 %          |
> +---------------------------------------------+-------------------+--------------+-------------+------------------+
> 
> changes from v10:
>  * pick up all new ack flas added by Ray
>  * pick up Review-By flag added by Wyes
>  * pick up Test-By flags added by Wyes
>  * move the EPP macro definition to amd_pstate.h and drop the common
>    code patch
>  * add amd_perf_ctl_reset() in epp init code as well
>  * As the warning which reminded by 0day, change amd_pstate_get_epp(cpudata, value)
>    to amd_pstate_get_epp(cpudata, 0).
> 
> changes from v8:
>  * drive all the feedbacks from Mario and change the codes in this
>   version
>  * drive all the feedbacks from Ray and change the codes in this
>   version
>  * pick up all the R-B flags from Mario
>  * pick up all the R-B flags from Ray
>  * drop boost/refresh_freq_limits callback
>  * reuse policy->driver_data to store amd_cpudata struct
>  * use switch-case in the driver mode switching function
>  * add Kconfig dependency the INTEL_PSTATE for AMD_PSTATE build
>  * fix some other code format and typos
> 
> changes from v7:
>  * remove  iowait boost functions code
>  * pick up ack by flag from Huang Ray.
>  * add one new patch to support multiple working modes in the amd_pstate_param(),aligned with Wyse 
>  * drop the patch "[v7 08/13] cpufreq: amd-pstate: add frequency dynamic boost sysfs control"
>  * replace the cppc_get_epp_caps() with new cppc_get_epp_perf() wihch is
>    more simple to use
>  * remove I/O wait boost code from amd_pstate_update_status()
>  * replace cppc_active var with enum type AMD_PSTATE_ACTIVE
>  * squash amd_pstate_epp_verify_policy() into sigle function
>  * remove "amd pstate" string from the pr_err, pr_debug logs info
>  * rework patch [v7 03/13], move the common EPP profiles declaration
>    into cpufreq.h which will be used by amd-pstate and intel-pstate
>  * combine amd psate init functions.
>  * remove epp_powersave from amd-pstate.h and dropping the codes.
>  * move amd_pstate_params{} from amd-pstate.h into amd-pstate.c
>  * drive some other feedbacks from huang ray 
> 
> changes from v6:
>  * fix one legacy kernel hang issue when amd-pstate driver unregistering
>  * add new documentation to introduce new global sysfs attributes
>  * use sysfs_emit_at() to print epp profiles array
>  * update commit info for patch v6 patch 1/11 as Mario sugguested.
>  * trying to add the EPP profiles into cpufreq.h, but it will cause lots
>    of build failues,continue to keep cpufreq_common.h used in v7
>  * update commit info using amd-pstate as prefix same as before.
>  * remove CONFIG_ACPI for the header as Ray suggested.
>  * move amd_pstate_kobj to where it is used in patch "add frequency dynamic boost sysfs control"
>  * drive feedback removing X86_FEATURE_CPPC check for the epp init from Huang Ray 
>  * drive feedback from Mario
>  
> change from v5:
>  * add one common header `cpufreq_commoncpufreq_common` to extract EPP profiles 
>    definition for amd and intel pstate driver.
>  * remove the epp_off value to avoid confusion.
>  * convert some other sysfs sprintf() function with sysfs_emit() and add onew new patch
>  * add acpi pm server priofile detection to enable dynamic boost control
>  * fix some code format with checkpatch script
>  * move the EPP profile declaration into common header file `cpufreq_common.h`
>  * fix commit typos
> 
> changes from v4:
>  * rebase driver based on the v6.1-rc7
>  * remove the builtin changes patch because pstate driver has been
>    changed to builtin type by another thread patch
>  * update Documentation: amd-pstate: add amd pstate driver mode introduction 
>  * replace sprintf with sysfs_emit() instead.
>  * fix typo for cppc_set_epp_perf() in cppc_acpi.h header
> 
> changes from v3:
>  * add one more document update patch for the active and passive mode
>    introducion.
>  * drive most of the feedbacks from Mario
>  * drive feedback from Rafael for the cppc_acpi driver.
>  * remove the epp raw data set/get function
>  * set the amd-pstate drive by passing kernel parameter
>  * set amd-pstate driver disabled by default if no kernel parameter
>    input from booting
>  * get cppc_set_auto_epp and cppc_set_epp_perf combined
>  * pick up reviewed by flag from Mario
> 
> changes from v2:
>  * change pstate driver as builtin type from module
>  * drop patch "export cpufreq cpu release and acquire"
>  * squash patch of shared mem into single patch of epp implementation
>  * add one new patch to support frequency boost control
>  * add patch to expose driver working status checking
>  * rebase driver into v6.1-rc4 kernel release
>  * move some declaration to amd-pstate.h
>  * drive feedback from Mario for the online/offline patch
>  * drive feedback from Mario for the suspend/resume patch
>  * drive feedback from Ray for the cppc_acpi and some other patches
>  * drive feedback from Nathan for the epp patch
> 
> changes from v1:
>  * rebased to v6.0
>  * drive feedbacks from Mario for the suspend/resume patch
>  * drive feedbacks from Nathan for the EPP support on msr type
>  * fix some typos and code style indent problems
>  * update commit comments for patch 4/7
>  * change the `epp_enabled` module param name to `epp`
>  * set the default epp mode to be false
>  * add testing for the x86_energy_perf_policy utility patchset(will
>    send that utility patchset with another thread)
> 
> v10:https://lore.kernel.org/lkml/20230106061420.95715-1-perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/20221225163442.2205660-1-perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/20221219064042.661122-1-perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/20221208111852.386731-1-perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/20221202074719.623673-1-perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/20221128170314.2276636-1-perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/20221110175847.3098728-1-Perry.Yuan@amd.com/
> v3: https://lore.kernel.org/all/20221107175705.2207842-1-Perry.Yuan@amd.com/
> v2: https://lore.kernel.org/all/20221010162248.348141-1-Perry.Yuan@amd.com/
> v1: https://lore.kernel.org/all/20221009071033.21170-1-Perry.Yuan@amd.com/
> 
> Perry Yuan (10):
>   ACPI: CPPC: Add AMD pstate energy performance preference cppc control
>   Documentation: amd-pstate: add EPP profiles introduction
>   cpufreq: amd-pstate: implement Pstate EPP support for the AMD
>     processors
>   cpufreq: amd-pstate: implement amd pstate cpu online and offline
>     callback
>   cpufreq: amd-pstate: implement suspend and resume callbacks
>   cpufreq: amd-pstate: add driver working mode switch support
>   Documentation: amd-pstate: add amd pstate driver mode introduction
>   Documentation: introduce amd pstate active mode kernel command line
>     options
>   cpufreq: amd-pstate: convert sprintf with sysfs_emit()
>   Documentation: amd-pstate: introduce new global sysfs attributes
> 
> Wyes Karny (1):
>   cpufreq: amd-pstate: optimize driver working mode selection in
>     amd_pstate_param()
> 

Hi Rafael,

We have finished the review for these series, may we know if any additional
comments from your side?

Thanks,
Ray
