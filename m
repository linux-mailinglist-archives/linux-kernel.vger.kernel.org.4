Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF76F730C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEDTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjEDTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:09:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C751984;
        Thu,  4 May 2023 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683227335; x=1714763335;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ovhWSyk/LSigEU65gMI+SFTwzko8de+ecGeDC5Y0Zs0=;
  b=A0zdgSC5cSssftac8jBLwCEleaGCtCqpZnPgzevSCafH4JU8M1sCt49K
   oOJSigiWAd7eP850LQSx9VUh1+G587/KT4HjRfgdm3Fwr1ES62Md1lTxF
   OO09J0VU2OX1wgl4SNrp6aNzBJ70g/F5iwydfNex9OKTbRej/1ZnR4S9G
   Ln5aRwCP/0ND2ZYuVyp/sKDzNvxM10yM3JbWBfO4BCHlgrqwRiQnHultZ
   /lxabWgF9Jjrg3Ccz5BpFD6eLtE+ZqaHSClEe/553m+zVQVuqPxuBRoqH
   nOLedeyaNYmyiT2LPUMQXZ2zcE3NBKg3KBnUTVyohaE8Yw/jMt26S7L3L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="351156216"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="351156216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 12:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="841307936"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="841307936"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2023 12:04:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:04:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 12:04:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 12:04:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 12:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn7Bj7KWLA2JvE5d4UmZyAoFmWNUX/VmsRq0CjdmDFaisdKqKlLrAUsiq5+zrOU/sBK4kM/Ei/5zYc7BW2dyeo7bzGm5wSj5l1Z+kZbdsTlQGMG8UvgNOZVcumy9YuI3jI2snmH1eFmletLqmLvGbCCudc8wm+6KiVZylsZ1UTzuBsOOunHGHgjYgDJ8gzNMjadDY9pF5R3mQb+bv89YyRj8NHOb0ytC7oSNbRPk4wnuKa4JjW9jYgX+fUba21vCO6bQAaG9kVnq3ZfeXzhVNNs6ND9WP3EmOv3pf9kStEeco5D22+6Lc5CM1UUTsYx3Ywba2TJi72Ay1pUpKcawiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDBCfeEWaV0XXfZcSoKN3J5Zl9R9r9OkkZjFmGF7rHY=;
 b=Ya17EaH5EqtCGUclEKmefDy05S0WRYEZs0nVGH9N5VBx9cFXX4ILsMcccFCEhve0hR12fG9D9DJ/wbiEHczzHqRN2DECnm0DMYcKpHseViOhGYLWSgnu7imLh/kuS46+j3WEdNTb3TI/AlqXSlgnCqTvQT26RmItOEhO4DEgyj1mQuyRy3XhJAvID47MXDBh6ZjIAZCdEqiSqPPKWYp43/NgsYAaBQWp4lCEce9bUwL7dS8w2fZBfPg4PnyWdZOsZu3j0J+8os50ISCuul5ifRQ+6abBM4XIgko4kdv70ugZwQLicKYyd25wWCPJNNC21GwHoVuO+hT87x7erHZksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 19:04:36 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Thu, 4 May 2023
 19:04:35 +0000
Message-ID: <1cec24f4-e4b1-682a-3ada-b51d2a7c83a4@intel.com>
Date:   Thu, 4 May 2023 12:04:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v4 6/7] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168177435378.1758847.8317743523931859131.stgit@bmoger-ubuntu>
 <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168177449635.1758847.13040588638888054027.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c452a7b-a42c-4d61-4f2b-08db4cd266bc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MHLxga3cWqAhUIaNjwOerRHcXntfvqtqvL8o3hD5Eh+R9+bwv8tv9dZuJ/KJyueLEsV+v/QibsIAAoFz/2Xv7ZWIK+tYYJBQSohiufa61JYBO7X7rUJrwKFpBpus0rblMzbrEt2yvrZdv+xiLO+CWNsKuSr/gwE8l9pCFPLIhhuh9akvMrFJgkvKJJkTsJabceNVkDEnDDhVAuTKxEa2x1QtI2uqdUY8wM+3xdXHxhNQH7tq3Uz+V1xVRHOg4JDyo/DolrDDZ9aHaqsxjfLEZz4dvuEaw+CdB61s6MNr2LIEDEvcBggZ/3nOvmgRIJnRN7/C86H+XPfUY7qYnZNnjFgXu9UUCpGzEaEZcIMcVFkaDjZFVAnQZxyh0TnlnaMJMbVsUCyMWVNlN7uUHySk8oKoZLSdlXQgKkttRqvkXLBJ5Q+jA9ZPuVpaRycZ5P9e1ojcYXRrelCrvfzTIF6kpu92o4DmBmMzpmKSfahzFpigKCrPVS8CYPIMAeYp2BX6plXs+YBQsJ9d5LH7eaDuWYv2XTf3ZbwlC/s+FM7Gd3LpPOAz6tzKDwqYq4ukUHBy/55g1JtfKgHIuwy0OHKC/G50g7ZCEatdOZJe1Q+n0mZ5WF5DtCez5eu2kBzMg3baRcLdL5WB/hbD14iacLCyvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(5660300002)(44832011)(7416002)(7406005)(8676002)(8936002)(6666004)(31696002)(86362001)(36756003)(316002)(4326008)(6486002)(41300700001)(66556008)(66476007)(66946007)(82960400001)(38100700002)(478600001)(31686004)(2906002)(53546011)(2616005)(6512007)(6506007)(26005)(83380400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lwYlFxanpGZHlaT0ZVS3M5MEg2YXdkVlNDQk9zaTBkRllDbjl3OUo5dUZR?=
 =?utf-8?B?aEpUeitnVXRZTlR5U0RyODVZenFoZmE5Q1RkMk1ldUpob2VHdzlrL01VRERa?=
 =?utf-8?B?SkhubFVIWmV6YXpsdXVJV2xqRE9CR2ExeDBjTUlBMVlUYm5sYngvS2w1NXZy?=
 =?utf-8?B?K082S3FsbUpZNHVXM2t1VWorSG9weTlFN1Vtckgvb2NwaUptNHl3WW5xR2hW?=
 =?utf-8?B?V3hvUUQ5TnhGbE5VQndXYjQzb20zSld0bzFweVI1cDBxRTNRb3RqUzFCcjRO?=
 =?utf-8?B?T2UyTDNSZ3dhbVRTN2ZkUTlHVXFxUkZSUGM0WEo1aTJEZkp5NzVvbUhKTHNM?=
 =?utf-8?B?VXljeVk3emM4UTNzTk4wUEVROWExOUJNdHdRWmFhanRScU0rVTYvVGhYZWN0?=
 =?utf-8?B?UnYxRzlGd1NkZXFzOVRyQWxZdjhuNFFBSG1sTm5YeTlUNkY5MlUrNUhLTHEv?=
 =?utf-8?B?aXpZYVFCakFweWxvOEVsQUJNOWs1OUxyRC9jckhqcWo5ZXh1MEFVQjMyV21Q?=
 =?utf-8?B?SUlZbUhEcXVNT2F1WVJ5NVNXRk02LzFIRHZhTnBKVFB2bEVvcXFiMlViM2RX?=
 =?utf-8?B?MnQxbWR3aHp6NmFQYWhtdkYxUTYrQWdQaURHU3FDazFjZThONUg5VGZXRWtk?=
 =?utf-8?B?RDNBQnNuRC9EUSt0Zkh2OEI4V0RCVkpqUEVzQ0tRU2NZbXpIWlRBUExEb2tr?=
 =?utf-8?B?OHM2dTJXZjZIcGVoSCtlV0o4enRpcEthYXpYbU1ZOUZEeGpVd3d1eHVSSzU5?=
 =?utf-8?B?ZGxEbHBBQ2FjalhmQ2t3NUhIM056VzFzRng5QlJxS1lVOFZ0c1JPRlNaSUJs?=
 =?utf-8?B?V1dyTU9Wa01PTmNSVXZHTyt0Wk1Gd09JVTY1VW5YNjNtdGpwaFU3WFgvU2NO?=
 =?utf-8?B?NDdIdElTQkprVFJoVXRTbllBNHUvNzZLRERJcmZIdU9Ea09RSGovQmlvQkxu?=
 =?utf-8?B?MGp4R2VwSDA4SUZCZzJHTTNOR29UaGoyTTN2MWV3VzNCMmcxdjdJWWdDUkFK?=
 =?utf-8?B?Qi85dHliOVFFWlhkRmJETXZJVnE3QjAxK3NHbHBSaXZtVmFhVnB5SFNCUk9D?=
 =?utf-8?B?eTFoQ1JLU2lqcmVvbVpnYWZISHFlYlFwalhnVURLMzFIcmtPajVOU0RYbGcv?=
 =?utf-8?B?OXhTZ081SDJxd0tWNTRFWFpuQXc1KzNsZUZVb1BqRzIwakhJSEJXQitGUXg5?=
 =?utf-8?B?MURqb3gwYjQ2cU1mL2RCN3p0VnBMOTZSdXVlNER6bWhsb2hMSjlzUG5DL041?=
 =?utf-8?B?TVVKQjhNS2pvc0RlWXdXR0lncWlESWZhL3c1ZDhsUGgxUlVhK0FVWHpDSXc1?=
 =?utf-8?B?Q2tWcmt3dndJZ2NWdlNFR0pZVXFDdy9uUFdXWXhoSXZTd1FFTXZEaGVyaS9r?=
 =?utf-8?B?RkNtRmx5M3VTNC8zRWQ1Zmxkd3RJVys3ZTJCZHB5ZmJOMUtzT2FRbXhEZUlp?=
 =?utf-8?B?S3ZpTG13UXc3bHBqSGNUMWFaV0NkOXlUU2lyVHoxTURlTkZ0bVRObi8wRkNR?=
 =?utf-8?B?V2FVaVNwYzgyeEc3VXFkU2E3dWJwZ3lvZ1pwZWFEbmo0K1F0UXJYL2VXTTZx?=
 =?utf-8?B?UHN2NnFJN0NFOFl6Z0hkOEVCMHJqdmsrOXJvNVZkblYyLzM5TGpQMlFuRCto?=
 =?utf-8?B?cFprYTdZU1BnUklOWldFbVEydG1DZ1J0WFI3bzhDczA1R21hTktyUEp5dmVX?=
 =?utf-8?B?bU1UYXF4NzZlUUpkYmZlakptb0pvYXFYZDVZUmlONnE0RE5kc2Mvd1JlTXNW?=
 =?utf-8?B?Szdya3ZWWE1yaWU5RisxYmpwelFhNERwUmE3TGZhRWNWanN6OEVFbmtsVFMr?=
 =?utf-8?B?TkhIem16N01JYXlzU1duVnhKUVhFSDJTcUg4QzFrWXNMSldnNk1lYjNUd3FJ?=
 =?utf-8?B?VFlXZU93dDdZUmJyM0NaUUNTWUVvd1ljMXAyUFJ5U0UydjRmTDBkc1lYY1dD?=
 =?utf-8?B?SThCYVZoVW11VUgwdWJiZHZNMVV3UjhBU1V5eWV0NGMwTDQzWGhOT3VDWXNu?=
 =?utf-8?B?bWFmbmdWelU2MHJ4TFBnSjNIZlFsMXNMUlJLRmVPL1h5UU4wdXVOTUIvNHJh?=
 =?utf-8?B?cFFNaFVyT1Z2T2NPL0YrZEpqWDhOTmNZZE82RkNOVm5WT1I5M3pSZ29PdXVJ?=
 =?utf-8?B?WEZPY0xoNkdHTDBNblMyQ2hyZzNGVmNjUFdBa2krenpaVjhQVWVwalVhYlNh?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c452a7b-a42c-4d61-4f2b-08db4cd266bc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 19:04:35.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQQoiljsI5DEfhfh+26yCF8SV7UnMhC768nE6MMlOPVL7RAf89ZUTBqfbOHWdD79EhekPBZ/qtRW6W8OGRz8kTZnotgDFYuYmdyZqpDqCLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 4/17/2023 4:34 PM, Babu Moger wrote:
> When a user creates a control or monitor group, the CLOSID or RMID
> are not visible to the user. It can help to debug the issues in some
> cases. There are only available with "-o debug" option.

Please see: Documentation/process/maintainer-tip.rst

"It's also useful to structure the changelog into several paragraphs and not
lump everything together into a single one. A good structure is to explain
the context, the problem and the solution in separate paragraphs and this
order."

> 
> Add CLOSID(ctrl_hw_id) and RMID(mon_hw_id) to the control/monitor groups

Please highlight that CLOSID and RMID are x86 concepts.

> display in resctrl interface.
> $cat /sys/fs/resctrl/clos1/clos_hw_id
> 1

This example does not match what the patch does (clos_hw_id -> ctrl_hw_id).
I also think this change would be more palatable (to non x86 audience) if
the example resource group has a generic (non-x86 concept) name.

> $cat /sys/fs/resctrl/mon_groups/mon1/mon_hw_id
> 3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |   17 ++++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index be443251b484..5aff8c2beb08 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -345,6 +345,14 @@ When control is enabled all CTRL_MON groups will also contain:
>  	file. On successful pseudo-locked region creation the mode will
>  	automatically change to "pseudo-locked".
>  
> +"ctrl_hw_id":
> +	Available only with debug option. On x86, reading this file shows
> +	the Class of Service (CLOS) id which acts as a resource control
> +	tag on which the resources can be throttled. Kernel assigns a new
> +	CLOSID a control group is created depending on the available
> +	CLOSIDs. Multiple cores(or threads) or processes can share a
> +	same CLOSID in a resctrl group.

Please keep other content from the documentation in mind when making
this change. CLOSID is already documented, including the fact that it
is a limited resource. Please see content under: "Notes on cache occupancy
monitoring and control" where it, for example, states that "The number
of CLOSid and RMID are limited by the hardware."

Considering this the above could just read:
"Available only with debug option. The identifier used by hardware 
 for the control group. On x86 this is the CLOSID."

Similar feedback to the "mon_hw_id" portion.

Reinette
