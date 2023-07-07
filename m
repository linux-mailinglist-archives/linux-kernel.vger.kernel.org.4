Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650FB74B8B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjGGVia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGGVi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:38:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E30C1FC7;
        Fri,  7 Jul 2023 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688765907; x=1720301907;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dhx5BF1Yd6GRhn1g/TpzztJ7OywDvc0TmyFi6SQOBUQ=;
  b=oAYk4P0CSLuZP9YMmGKGXn3ESwzMz+W4D2TUUkZfhqBII+PsVDKS6dgA
   dt/+ERvBeLXkBCLsEBHrfPIcnTshrjusjhtAvkDu6YsATZXM425lFMixE
   SMwsvy57CkxNKNCl76zWI5fB2sNCPNbPTG0DhP+NBUiV+aNQyxdXXCIoW
   VltIEcY/m6k4ipyYhoR/mxuo4am27jGnG69GxXY2/Khi45hkrhpVxt3/e
   Om70WTszDVhCSPNoi7Z1l179N3hhrrNUP2jkTRglYOzYqnVoh/FG2r7CV
   ykOwH1i8V8elzdgGLIkPaGYiEC+OO4xnu+XZK5SCi8Wy3IfzaDrXl1B+4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="450344645"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="450344645"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 14:38:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="810171198"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="810171198"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2023 14:38:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 14:38:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 14:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaUWA/kmGR3l+SbO10BMv5GNyJgTNKyqZpA+rqiJGOMRqbKadNwrrrGiS/+vLUsuFwgkDJs2E+861W+E++R8qdR7npzxKPoVKxmhQA9oUgn9ZIzGhgYd0ghUXLi30LFcJkXmGPgklY3bjjqht0rBimWyRV0SKhPtbqM8cexSD+F0WYNlSUyS+W8I8ZwFM1UKBkxgfWkrzibo7UsBR6zkasMF+igMyhIdKmHuOnmM8bVHed3DRT90CI4jKCqwY+r76eJ4XJMnv0P+kFVTpRQGwauHU8IrdvOiRhdw9saUSoyGfJZKgsCVNQ4KbvUNcsrPlQW+y6z0Zl7dDG8XFu3LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcmafFgZ58PCXI6twRhKrTLZZk8rHFG4f6nYGrSGlhY=;
 b=UyB169nbyYdS0tpMpUuIT6xH43JwzROIwxsWtO57S/WsVu8n4orkcl+uCOZCnacR+ly7nCwR0kD/f+ATSj/k/SPThNDUk0ONyseJyyOrPIYdy3jukzzI+Cv6qcmdFrbCBNjrInY19mAv/Cetoge7RkA4AiKUSVo6A4os+mxyCN9wtwzRABjHgKgrPdznyJ3eJTsoZxPwahmtlP8Fx0vK4JqXFQbJCDs7zDyKY66gCutKWgd5sFlikouts70x9cIC597cIlXw77Z7p4KSHDEPHtTXoL5BKpRtAcOpHajuszDo+EJV2Qd/axL0VqWb912T+UPCxJScV31Q875wfFDzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 7 Jul
 2023 21:38:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 21:38:21 +0000
Message-ID: <3cb0a5d9-2268-6111-db9b-b99ef185607d@intel.com>
Date:   Fri, 7 Jul 2023 14:38:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH v5 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564605452.527584.8450496267087240475.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <168564605452.527584.8450496267087240475.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3121073e-6031-4d57-61a3-08db7f327c64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3gF2ebU4NkIKX45xVm5nQ0EJVN2Fru2RKYfARAeMpq2JIWDobMrF4h0c9EBu2i8tn8Mhra9SbLKNwT2HlfOC5fMeV3ScWAdke/GCyt3BqMSg3SNOkYmSdmjL9hyOL7DwVZWJ+YtAhS6vpuzagjA51m6p0SidSVgWHZM734qPdNf5xr4SO3Fwaz99RZ1yFQ/S/99eT0dyKkEaNDC4ZZ0J3HextC8R/gdl+/LW3jEnvwfqm7Wg2C79596O6rjl0u5hA6KEr4CveBPMQ64kAdc4vanP9peGj7JwVMSjopke9zALL0VJChAed3m/NkW5yD79aN71H9n79L8sCMngT5otdw6Ruu/5g6evHXieKbE1VXJ85eZD9CY2SKZdlGW2nm2qZxYQ4poMyVLGIBTg6BCY1FZej3QsRxtPsHEAgLO40tWozJeRGcVdm0DA0mgKhVd+DDexztM7gcP8ZEYFW6n7kQOkW21HYe12LIdckZJFTRCUtX1xXNrwVH5OC/c22fMDo36Lzyi9j7xM48cn6h3sIs4VTW7dEK+k0QPk+gA5kz4Ms4rkTcHKORGafZ7F7KXSiS3hn83KywUNLFAmap03yv1pjy2yQqSeqpq+KeiL2Po5207ZGADbWzlpLoHeer/eTcYsGqi28o1ys8ikey8hGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(4326008)(6506007)(66556008)(66946007)(82960400001)(66476007)(478600001)(41300700001)(38100700002)(316002)(2616005)(83380400001)(66899021)(186003)(44832011)(53546011)(26005)(6512007)(6486002)(7406005)(31686004)(5660300002)(2906002)(7416002)(31696002)(86362001)(36756003)(8936002)(6666004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJaUFFaTGJBOXk1dXlSTkNJOWVYRE9QTzlwYmxxemdVRFpGSVhWUFVQTzgy?=
 =?utf-8?B?Y3R3MzAxcW01U1NwV1FyZUpLVmFDV2lGa1p5VUZEdXM3WkxSVnRzZExWQzky?=
 =?utf-8?B?akZNaklnWnVqOWV1bXNpWjU4aERrK2NHZnFDVFpTZGg1ZURZMXByTVFZbHpD?=
 =?utf-8?B?V0NhdkVPK29SMTRiUWxZcjdBMUtmMFFDS3EreGhHbDVEeGZXQU5ta1AvMXo5?=
 =?utf-8?B?TURJd2VBSitjNVZFMG04VlpCZEY0NlFqdDFoaUpxTHBwTGtmUk1Ya2JRWmxw?=
 =?utf-8?B?R2RuNGROejdWb2tRWXgwRm81NlljUFhVbUM3SnpJdTBCdGloZWhKWk5EaURw?=
 =?utf-8?B?QjRqd2I2cTVzNFhRd1o1Zjh3OWJ2YVlTQ3NjRUwyenYxQTlvUjVGRVBLUzlj?=
 =?utf-8?B?VGdtKzlYOWZQK29WaUtldzdzWTdVT2lQaUxSdXpkMTdFY3lPcHZQUU43a0pI?=
 =?utf-8?B?SW5ybFRTZFNmbytHcTJtMXpQM0FIRWs5Q01ueDRGVXFtKzFhbHZFQnZmU29Q?=
 =?utf-8?B?a3JvZmN2M2FwUWVSTm9BSkFKWjJDV2NrbkxUdUhMZHBEcExEMCt2aWN1U1pl?=
 =?utf-8?B?MERyMDY3Q2ZGUG9PcTU0Z2JVSEVPM2ptWkdtL2ExcGNRdWVsWGttMXdnREpN?=
 =?utf-8?B?RHFPQnhtd2lBNC82dmpRbjBYdkFTK1JhelhmNE1la01aYTJvZTlLTTF5cGtG?=
 =?utf-8?B?cmtyS1FIUEF2a2ZUZ25STkJyek11NE1aaGs0SXRkb0VGczd6bnIwMEVWNHZ3?=
 =?utf-8?B?SDd6UmdnZy9URHlnQmlmdGxqTGVlZFpSVVpaVnY5bXdoa05GZ01BcXBKcFFC?=
 =?utf-8?B?dnNkdDJXTXBOUERObTlZUzRUYUNQZUVkTWJZOHlheDBaMFZMTktzUU5kTjlp?=
 =?utf-8?B?M3pJTHNtdTVKWGpDdTh2VTlpWC9xbS9la0tFeGZ3K3pHZWVFZGhUSm9HZ2hr?=
 =?utf-8?B?YXBtOW85TmpUVXQ1YkMybkVkUituUjRYZzhIWW9kOGFFejJXMEdJZmNCYlJW?=
 =?utf-8?B?ZTN5c1h1NVJ3c0N2dnlyZ1QwQldoYVUzeVNMbS81RlFsVTRYWGo0MXhyOXZ1?=
 =?utf-8?B?RzdCTFluT3FxRXh6WXdEbHRBbHQ5cVFGbENTd1V4ZHZLak5RaDlzcXFjbVUv?=
 =?utf-8?B?U2lEVVJWSjUwTEc0eXlYb2xDZ3YxRGY4cS8wcDM5MWp6NGlmUXIzSHVJd3NP?=
 =?utf-8?B?aUp0NEloZDlqcHJ4bXFzTXBRSG5sWHhGSm9yLzh6N0ErcnZXMXZXMEJXQXZG?=
 =?utf-8?B?YTNnRWMvNHlaREhaTUZJdXlMWk53ODVsVU1uL3pkT0E1ZlJ2bmRZclk2MXps?=
 =?utf-8?B?aU0rUXAxMDNIV0phU0o2UGQ5UVJYK3lDTlk4aUNuVDJRbHVCSDQyN2FaZUw3?=
 =?utf-8?B?eG1PUDhxWG5GM0FCb3M4YnZPTjdZN3NacmhveDlMNjhjYnZVaVptVnZwbUJF?=
 =?utf-8?B?aEo2bitOSGFrWG9GcnNNNkN4c29kdW1zdlhodjhoZ1R6ck9RcnM0andYTVQ4?=
 =?utf-8?B?QnAyL1B0eUtHS3BhQmczZ2ZmcWNJV2dtMEpoNjhwcnZuZm9BUkIxRHN6bHRH?=
 =?utf-8?B?Z1o3WmRObjdHVEJmWHE4RmIxSE5nK2FYUERubS90eXN3Qm5PRU1WLzZTOWhD?=
 =?utf-8?B?Y3U5UzdOYnVJMW8rK0tyY3ZQem5SMW8vK1dON2QwK0daaUdQMjAvd1lmVkwv?=
 =?utf-8?B?Sk5Na1pHOFY0SmE4MjVXM1VQOGcwVG1PZWRiSjdHT2RiZDR3UTBVS3AyaVlR?=
 =?utf-8?B?UzFjeFIyaUMwYmFWeURkZllKd25WT0RRc1gydHcyWWZqV2IrSjZocC9kMkpP?=
 =?utf-8?B?MVFNNGMyMWh0VWpaSVg3YmxUbERIVEw1YTZGai9aS3BleWxUQzE5ZjJjblRW?=
 =?utf-8?B?S2NVdTRwWXYxT0dFaUt3Zmw1ZlFkc0dqeS9qYVRhdjB2UTliUWdjalpOM1lW?=
 =?utf-8?B?MWdwMW9qRmNCSCs0R3dmUFJLL1hsZUhuUkNNaUtUZEloUXljUnpQaUxmSjhD?=
 =?utf-8?B?eU12Q1FKZlFmREkvVTZTaFZyWDZSM1I2M3Z5WGx5enUvYmJkK3Z1ZXR6dzMz?=
 =?utf-8?B?c0JnK3Y2WEhMdDUyWWlLYVc1UkFzSHp0V2hrTitSZ0dTUWE5SmhLOHpBUGZq?=
 =?utf-8?B?eUVscFNXeVkyemFsMnY2bGNoNjRnREJRTDMxcHpyK0ZIajFBb0kvT3ZRNGhr?=
 =?utf-8?B?V1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3121073e-6031-4d57-61a3-08db7f327c64
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 21:38:21.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMi01aVfROQP3tUi608wt6V2KHP8yPZ3fUTcWarfCDK4cZk9d/iJFxG2Pq7gSfxuYEJEMN4HWRMlGVdHaMzLCcquNoMwjq5Fdzyy8S0fSLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 6/1/2023 12:00 PM, Babu Moger wrote:
> The resctrl task assignment for monitor or control group needs to be
> done one at a time. For example:
> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/ctrl_grp1
>   $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>   $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks.
> 
> Support multiple task assignment in one command with tasks ids separated
> by commas. For example:
>   $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6ad33f355861..504137a5d31f 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  				    char *buf, size_t nbytes, loff_t off)
>  {
>  	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>  	int ret = 0;
>  	pid_t pid;
>  
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> -		return -EINVAL;
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
> @@ -708,16 +707,27 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  	}
>  	rdt_last_cmd_clear();
>  
> -	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> -	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> -		ret = -EINVAL;
> -		rdt_last_cmd_puts("Pseudo-locking in progress\n");
> -		goto unlock;
> -	}

Please do not drop this snippet. I think there may have been misunderstanding
during previous comments - this snippet is required, it just does not need
to be run for every pid the user provides since it depends on the resource
group, not the pid.

> +	while (buf && buf[0] != '\0') {

I think it may help to add a check for '\n' here also. It looks to me
that a user (shell) that provides "pid,", which is "pid,\n" would encounter
error and this may not actually be an error.

> +		pid_str = strim(strsep(&buf, ","));
>  
> -	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +		if (kstrtoint(pid_str, 0, &pid)) {
> +			rdt_last_cmd_puts("Task list parsing error\n");
> +			ret = -EINVAL;
> +			break;
> +		}
>  
> -unlock:
> +		if (pid < 0) {
> +			rdt_last_cmd_printf("Invalid pid %d value\n", pid);
> +			ret = -EINVAL;
> +			break;
> +		}

I'm trying to image a possible error and it does not look right. For example,
the above could be "Invalid pid 123 value". How about just "Invalid pid %d".

> +
> +		ret = rdtgroup_move_task(pid, rdtgrp, of);
> +		if (ret) {
> +			rdt_last_cmd_printf("Error while processing task %d\n", pid);
> +			break;
> +		}
> +	}
>  	rdtgroup_kn_unlock(of->kn);
>  
>  	return ret ?: nbytes;
> 
> 

Reinette
