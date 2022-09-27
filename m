Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F75EBBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiI0Huw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiI0HuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:50:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE67527142
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664265019; x=1695801019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kIS6FbQp4ppqvxhzyDElhxreQOQpl2dqXD3qUtFqwmo=;
  b=dqsXR1jGYwoJRHSR15JEcQiLZyqaMeioKeew7wIibwemFlt7YF/FQ0vs
   YiUS2gBjzPkCVzBKDAvSXbIpK4HFf2kNi+fgp4HjYDqqwHA3b7K53gT35
   kzC+B96beUqG0wcGyoRjG3wUlswEXayEsJJAxCYqi3EOxZ5ax//XaqQnh
   Zt7RphWtOAdAZ8Fv59kNd+TWwrWNpNxt378h79/QmhH0ejwH4B1pqk09V
   zMMgxoMdVJtbau7riG3Rn32HrXGhXQ1woMiCxCA9yca5jIaTobVy+uMC2
   em2SUEMJLlk0qBVceoOw3sSuN4LSiAOqv5L3rHjgTytwbN9sBWy9Jm+XU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="302161905"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="302161905"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 00:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="746954257"
X-IronPort-AV: E=Sophos;i="5.93,348,1654585200"; 
   d="scan'208";a="746954257"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 27 Sep 2022 00:50:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 00:50:18 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 00:50:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 00:50:17 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 00:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3BqyZBKkD0TtQ55PD/N5FgJFXEGhLs4t7/leV2Lz870Hc7ZtF/7gENJ5twuu6U73fg+p0kBZ2eIRk9YlttqloraiVE+6oBjZfCpgNiEN1oH3slmPL/NBR7HmZdDV5Bd+tpc/RccLsriOFDUM1mweqYp4egEj7SAbKQehy3GACTPWTvlG09ho5mTtTQk94ZlogTiyC9BjZTy/izBwQDGZC6zUxUiXevP+Ysu8iF3nV8ZAe2QHfnTodyk4tiA+bg7nVKewqUmozxPGpe2XbxyCHssuvu6t0GwdYibOktTPb67eXEOi4O3JTVvQ+4haKwcCCkYklt6XgUHaRHubfcFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIRzFYX7T30QA8lO4MRJUYZrjr+95UJ13DOQZFipfgs=;
 b=ZloghzkB/XzhQ+OI2jVXu/EdM3GTvbc/Oe44nTfu3NJGvTF4b+KC2mT1tkR6GK1LD1tbl8xnWjeXLqUtMOe3mY94VoJXwahdAbcbQSw8lX+3TKXfiUaHVxM90vTQnucJhIsZwF/Hx5fB6QzEz7pHvy6D8H61BY23dIzyLcKefEq3CJXtjexIsEUHeUE6vXG7+HsCShP/Btx5yRYjm70piBw5/5YucqMZPdKGApzy4U4q0ND5KqP7vPyzPv4r2EEHyIJF17ODvASIiUZlXqT7AQNEw/v6YzJotkm6m+Rq09CSrj360Pf6ACbn5dezM4wShYFP8m3SUNcEg87mnOImhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 BN9PR11MB5557.namprd11.prod.outlook.com (2603:10b6:408:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 07:50:16 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::e6f0:5bc:111c:1068]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::e6f0:5bc:111c:1068%6]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 07:50:16 +0000
Message-ID: <2f5a510b-082a-60e2-5770-58be086b5fc8@intel.com>
Date:   Tue, 27 Sep 2022 09:50:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH] ASoC: soc-pcm: fix fe and be race when accessing
 substream->runtime
Content-Language: en-US
To:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yanmin Zhang <yanmin_zhang@linux.intel.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Zhang Yanmin <yanmin.zhang@intel.com>,
        Ramesh Babu <ramesh.babu@intel.com>,
        Dean Jenkins <Dean_Jenkins@mentor.com>,
        Ramesh Babu B <ramesh.babu.b@intel.com>,
        xiao jin <jin.xiao@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
References: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <1664210154-11552-1-git-send-email-erosca@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:203:69::11) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|BN9PR11MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2a8dec-4924-42c1-ba93-08daa05ceaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MgnT/iMDXm8sGDg5Up6/zmgUTFYG0Mt0dRcosORVU2AyGtUXEIS4ELrhCsrl7v8URUTKvwuqO65yw7UhfLCbjxleKDi/adZwob+cPf6ShOMUjGn5ajEcvT2Ne8amHnH6oucQzkMN0Bd5YakfYDEGHgxnhm+9+3H8ufNoe8jHCM/yr/e5EH/M7B3k8Tk8xFohOdGR7GeIWttB+8qADHX70VMWacPp8i7Z095940YDlHQ2TOvUvFmFy6Ri0bwzORR9WpdYY/g+lE8lEP2C3NJSJDUX8o9QGkOM13vgkRJm46+zp9zlCG/2JQeWwTXWDBfaUpZVEHzQluTEIKedl0UNEDmbCfHKF71m5klr/oKSvd+3uo+uYCooK2/SG3Z5KDn63/QXhtTV9LlX7oO6VPM12XB5LVJGBDP75TjtXtJV5CK4ytJcYw0WnJLPyAtfbjPY8MjSGsBjFTtlOyvQbRqKfVuskr7LF2RUr8oIxi2dzrROlDaeeR2xm8WHdVJ6c4UIIh25EHwgXm9IUid5u8rhFIA812XnUuuZkNWCELwAfU8ObrWMhQgCLImGUCBxssMVk7SSS7WyJgGe29OZYbjSivSC7w6MRDRLgYBzZ9IFIfYzGAfatt7lEEijLTPjCZT9/fBUs+mk5OQUiXNio3sHoVP2lTPfmMwBuAF95itPK1oIS5kQS0LQGWSqGiWzZlpKOIz9vUJdLgNFaxp0F9vEHQEYnBr7ZU3cuu5iwPP4ZH4fpOgkVUtoorLio2Y39RCt+2CDjdgLrZ7+4nJ9UDLhkbpuOcHC1xHtF9necicVDE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199015)(31686004)(83380400001)(186003)(2616005)(38100700002)(82960400001)(44832011)(6486002)(6512007)(26005)(53546011)(6506007)(478600001)(6666004)(41300700001)(8936002)(66476007)(66556008)(66946007)(8676002)(4326008)(2906002)(7416002)(5660300002)(54906003)(110136005)(316002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hvTUFrOXJjYVh3d1dXUVc0N2JlSjNWc3p0Vm9GNXI5ekFKTkFHVWt0aVBY?=
 =?utf-8?B?Q2UyTG9iT04xMkNIRWRhcWJTTHFzK0lPOUJ3N2hCNXZlTkhVTHF4Zi9PalNq?=
 =?utf-8?B?YmoxQXE3c3BCT2FWYU90L0VmZmc0M2JQb3YvbVdKbjNGZjRkZGJVQ294c2dv?=
 =?utf-8?B?VFpXMVlISklLRVp1YjZVRDlSYnlOM1NHVzN1MENxMGNweHJaTlU1N2FZMkpy?=
 =?utf-8?B?UHVCQmRRMEZFdjhRUit4R2tGTnQ1eEpLeWpaSVNjZjFza1lNMEdlSk9NdDBY?=
 =?utf-8?B?cFR0LzV4M3JSekZ3R043dHpBd3Y0bXhuekZnRFJ2WTFLZGVqcWtTc2lrRFJa?=
 =?utf-8?B?VkJ3L3FYdWQxZ0d5aTZiMzZWTzlYTXFNVS9pZGRQZTBYV0NMWUo0VmYwV2Vj?=
 =?utf-8?B?WDhlNDVkOGNocHR0by9vcGVUSHNCN0FrdSsrS3RYVDZjOElDSzdaVnlXeVdQ?=
 =?utf-8?B?djV6WFJhVFhYYmJvdDdIUWRHdjlNaGQrU0NQNFhiOWNHa1RNbytpeDJHUE9P?=
 =?utf-8?B?YWo1RkIyUnNzbjhON0xLSXJXTWhHc082L3c0QzBhRVNIaTFZVjh3MXV0bG45?=
 =?utf-8?B?a2IwaHRVWVl1QVdHNWxVdmIxb0NEd3FIaGtkK0pBQkp4WnJPYWY4bEZGOXE1?=
 =?utf-8?B?SUVScXJtR1ArVUQ3MWU4dVpMbjc2NmhDZFlLZWdTNmxiWVQyQVROdWdmNnpD?=
 =?utf-8?B?WmVteEpRRHlZa2RRbzZGZHduR2IyT284K09JWmxsbnFMeHZrRzY4WG1iMjlm?=
 =?utf-8?B?Z0NVTnNoRDRZL0VqejZsZnUzRXcvSkdHNFdDd3dBaENrV0EwRThNTWV4VjNJ?=
 =?utf-8?B?WDdVS3J2WCsxRXZWSVZWTzNydnhoNWhwOU4raVlGMWUyZnpCektvbnZOd2o5?=
 =?utf-8?B?MkZKSFJEdGt4a0VSMkY1YkhkYmRQZTJYcTJqNnR0amlpM2xKKzU2Vkt0eE42?=
 =?utf-8?B?UG1zY2Z1TzBJd3NkK3lBRHNSaUMrVGJGVTZGTFltcGlUSmdGT1NNbnFJUEE1?=
 =?utf-8?B?T0hSNkVYTDF5QXBBWU9iRlNpMEY0SlhaNGNOUml6K3RsSkJscXlNRjVPb1Fl?=
 =?utf-8?B?UWJVeDZDMVB0V3FMQWVmc2VnRHRoSmNURGV3YUJLRnFiS1NPYjJhaFJ3d3dD?=
 =?utf-8?B?MWlKWnVQVjlHUXR5Yi9odFl4WXVQeGJRVXlKV1YxYW53eEYzRXcyeWJsK1Qx?=
 =?utf-8?B?MDNnZGpid3lUeGprUE5yWTNkM0Y4QjNhRFFFb2RvTmtJRk95dkFmQVNXYmNq?=
 =?utf-8?B?UWpSSzB0c2hWbEUvZ2xSUWs3OU9jL2IzM2VKU0lBNElQQ0VRaVh3TlIycU1i?=
 =?utf-8?B?b3ErbGpPell1YUM5T3ZHaHpUMmREWk1zZVo3dlhrbi9SblBpK0MxT002N21x?=
 =?utf-8?B?Q3laaFVudGYzc2htT3NkWGo2ZUtyZTZySm5aSW5mQkViMUF0ZG9kNmpLS1BN?=
 =?utf-8?B?Yktza0lsWWdSemV0aC9uZGF4azY3bUtBSzIxREJmY1Z6c2E5Qjk0SGltOWR6?=
 =?utf-8?B?VXJsS2pmenk0NDdmNkJWait2bDh4UkdnclVWNUJ2MnQ1RU80NkFWd1Rrcjdu?=
 =?utf-8?B?NHlmUyttdXBRMlFTeFg5R0dLK0xzZk1jTGE5QloweG8zOGpWYW9yMjUvNnZH?=
 =?utf-8?B?blY1YUdSVGpLQWw4bS83VXp6VTdnK3hselBsQTVJZW5XOU8rc2VJV1prM28y?=
 =?utf-8?B?ZEE1eFZkaXNSVDFDN3JjQlFBdjlvRHZKaDRFQUFaQmlza0ZQODl2NUhUSU92?=
 =?utf-8?B?Myt1a3UxMHV5YzZ3SitLU0d6TG96Qmg3ZGFmaVh2VHdOUXU5MmVqRGMzTnJU?=
 =?utf-8?B?RHpBSlJzSWNXZ2N6TzlFSTJPU09oYmxGVXpYb2t2SGdZdXRvSVZqUURNSG1s?=
 =?utf-8?B?bUZvN3VsQ29kamNEclVITVp2NGJYOTlmRVI1MzcvYWZqbnNRbFN4bXhUcGJ0?=
 =?utf-8?B?blYwSmMwQ1RDajZ5REJwektYU2xaOTJXNGNrT1IwcVhaaUZWcU1tbXJkcXZC?=
 =?utf-8?B?eGNGUVRmb2JHNXR5MkdrWGJkd01VSFdTU0JlQVFENHNPYWUwcUZFS0J4ejI2?=
 =?utf-8?B?S2VJZWRnZ2FnQ05MVUw3U3JoZEx2UnlmYWwrV2tKY0FQVkhPSE1GZFppK0cz?=
 =?utf-8?B?dm91dENEc2pueThVbnhsSXBEang3V2RHYlIwMXJad2hMUkpwZmZWby9OeFFa?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2a8dec-4924-42c1-ba93-08daa05ceaa2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 07:50:16.1264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crBKLLtamOgVA0+VO0cJLYyoY6ZL5sQ0FnYiNUFr62kerxl+QEeZRR/miIvY+KWet0WERGBx7qXyZv7w3fJpsjY6W/HhZolQzv5oKG3buBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5557
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-26 6:35 PM, Eugeniu Rosca wrote:
> From: xiao jin <jin.xiao@intel.com>
> 
> After start of fe and be, fe might go to close without triggering
> STOP, and substream->runtime is freed. However, be is still at
> START state and its substream->runtime still points to the
> freed runtime.
> 
> Later on, FE is opened/started again, and triggers STOP.
> snd_pcm_do_stop => dpcm_fe_dai_trigger
>                  => dpcm_fe_dai_do_trigger
>                  => dpcm_be_dai_trigger
>                  => dpcm_do_trigger
>                  => soc_pcm_trigger
>                  => skl_platform_pcm_trigger
> skl_platform_pcm_trigger accesses the freed old runtime data and
> kernel panic.
> 
> The patch fixes it by assigning be_substream->runtime in
> dpcm_be_dai_startup when be's state is START.
> 
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>


Hello,

The change seems to be driven by the skylake-driver problem. With all 
due respect, why not ping owners of the driver first? There are some 
crucial CCs missing.

I'd like to know more about the scenario you guys reproduced the problem 
in. Configuration details and kernel base would be good to know too. 
Since our CI did not detect problem of such sort, if the problem 
actually exists, we would like to append a test or two to cover it later on.


Regards,
Czarek
