Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD54679F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjAXRAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjAXRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:00:09 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26738474E4;
        Tue, 24 Jan 2023 09:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674579603; x=1706115603;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yx793IId8TyQOfDnPAULbtVsujRGKVHrKOZmNY3JNvA=;
  b=OmKbUiC8rrNDT0/2MzcZwBTcM3GPkuDbywB/OFDIZWFBELaC1KTaZ6Uo
   khR3lOVVfOcmmhtB1ZFBMV7F56MXutGxrh7vLLBnE0z6j7eY38ogVx+Xs
   63hyrY5NQ005JeMAduWm6BZs+K8jyRQugsMRnpVq4jkhPJp8o7o4olpka
   0XJsn9rVkEMwmDW4tV8GNZBpSuV/e40zzf36zqvKqqjY2Rwq02Ossh1V+
   WiPlWMcNY+2qZUpZdPWFO8ZF2lu2nfFKgt0t53CRUe6dI3BCxErk/lf4P
   aY6fXU1wcBA+Gz9B3jVGWnTfu5a1mCLrPayBFt58pGIw/0WCt+BKPsAPb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="388688183"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="388688183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 08:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="694415463"
X-IronPort-AV: E=Sophos;i="5.97,242,1669104000"; 
   d="scan'208";a="694415463"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2023 08:59:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 08:59:40 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 08:59:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 08:59:40 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 08:59:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ff4QW0L8bmg+KYCleIXyPdRgTBQwrFd8x18GgsVBptCTL/vgo4DB6mgTS19//TmbZy5o6D0muczDA/RgeDkc78BkWIt9VkMF+ihcvzkuQORMIT89B2KLjbHVKFantdoQMUkYC0w8Y7YlQZJtSoz+ZtqkOnp0f5JYtxkHpMJIUarGMDAGjQF/d9nNd+gwi/f5QXypaYbJ//zxwYQ7KyKRUF7I0nTy3ETC4ZQMwa6OMuVQ/pXoo/pJZej+MkAakmxCX9Xa4zX1bSjhvc0Kg+Y//aKu4XFm4WZLldrevxHFGpT/VdJnw5mgwITv1HwrGNpTovbALwYasUEUGcau6FkEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GOnOHZer35VWn5USdcWI7Fs5XGJ8kco9TCFeAdaMFM=;
 b=d01hVtinp0gYZcS78DZX49+Sui+vwYyQl8HquixxrnmCv5vJk3dVCYDgmoAYypRq5IOamUtQlgQoMgmXOYmN+n+1qDtYEyt1g2syBOPgabZdLvvb46RKPIeelH4J7zy66QVwdexzVopIQ4QZEHUCl5HzYZCsjxz4y7qKfQ0DCR/jCyodmGnhEkl4Ysq1APYgHnJoQqnqnUoXmyAOd9i5d6Yqq518j6KXuH5DxFCY670CktEtjNzRwUmtayz0O+GTYznOllRPi4OdG8iE3QUNmOwvNFCNDGKEqM6TbxGlAalAAiM3dYJ/mPBgYpPk2xvm33v7t/K91HXQljBSNAbKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB8234.namprd11.prod.outlook.com (2603:10b6:610:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 16:59:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 16:59:32 +0000
Message-ID: <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
Date:   Tue, 24 Jan 2023 08:59:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     <babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-5-babu.moger@amd.com>
 <Y7xjxUj+KnOEJssZ@zn.tnic> <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
 <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic> <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
 <Y8/07cV+t0PrqWX9@zn.tnic> <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB8234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc593cd-20a1-4fb9-4d5f-08dafe2c5d45
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BFYyXYu+a2qnmEgPjvu7CMWTOrcmx/npXYsH1JKUTfyoAMM3/N1JMo0EWyzXIZlnpfeR+MeHQytWhFYlFQp4qqmzF4jAmBNZ1Hwm+c7LCG8uabea26bRL4/YtQjwxIm/y+/HOBNUcAfXUl3GHWxnLArj/e0tJYZL/TAA94KqIThadGkSB5QOvkvhGBUbzsBjPbmwz4Ux2JS30AXxEsSEjSYRQtwnjqbVeMatH6Hxv+BQ1AjQQxm1dkzQiuiRo18o+kwqgoOUDMi91JNNXgFpLAnbbBCFeKJzbeyQU8QoMde4NZ0xpTZ8NCf+ocZ7eN3wOzqJLZDuz/vepSHtQTV/cKvx9KEVE1Z56qIAwXA1x3YJjRLUmb5n9eoQrCz13bEX87WN5BzsaWjz4wMFXLLZbC4HR5gq7k2xFFZpElUNVwVFykdU/FQDGfv4GsFJoasobilrB9O/sQacz8jxfVaqQTEq07CvvjWn/7rd/9ahQ12HIvJLoGvepbja0OLM+j7UFL4Gwz8G/CcFZPjjyN5ho/9nCEu8bKyh3ReUv77LdqOEdV3u8aNULUV1aUWR0t6KEu8AH6bg8modfS+vG35Y38fuqSUaicLOBGzzsF4p7gvzvkXgemjwrUrjXmJ0/H1sKl+u4TFIBOLl5LCPHUAgLJyu5iPrPm7Y/76sDws8fkKBrPHg+t1b8PdEe28MuDjBLMe/xnsv2I28KIMrmsP6fD17NoG8Q9Xw/Xhpfi9NJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36756003)(2906002)(5660300002)(7416002)(38100700002)(82960400001)(7406005)(8936002)(4326008)(41300700001)(44832011)(83380400001)(86362001)(31696002)(478600001)(6486002)(66476007)(31686004)(6916009)(6506007)(53546011)(6512007)(186003)(8676002)(26005)(66946007)(316002)(54906003)(2616005)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnViS1FGc1F5ZmZxRWdKVDhZYUJwOThYU3R0Z0N6RlQ4MXRkTjEzbGF0UnBX?=
 =?utf-8?B?MGxpWUNvQ0o3RkFraGdQMmhQVFhQVHNhMVJRTEFiVmE2NWUralhKVTVOSGFN?=
 =?utf-8?B?UEVLWE8xRlBBbE9uN1FjdVpWRmZsK29STkY3Q3NLcDJLQk1adWdtUUtFSnRj?=
 =?utf-8?B?NlY0SC9MMDIrSnRRYnpvR2tyMzhoSVRPalhJa3paSjhtbmtsdUFWSldleW9J?=
 =?utf-8?B?TGIvSGpPQitRTit5cjg4TTB6UXhSakRRNGV3b0Q5YmR3eVd2d2NmcVFwUm9T?=
 =?utf-8?B?Vm51OWtHMnVKRUJJR2hja3BNbWxUL09ybEJOZDF0RnZnR0NsRE9FVDdVVnV3?=
 =?utf-8?B?YmhPQW93Yi9kYmRZL1k3b3gyUVBKWUVGN0NIQnl0SlVrcm5jZW1RelNCYUs3?=
 =?utf-8?B?T1F2SjdNeTR1ZmdXbmZIU0xoKzhtaS9IMXhlOGlYbDRkV0dJeXQrekZXbXpo?=
 =?utf-8?B?b3hNOFNYWEY1SVV3c210WDNaaW5uSWpYWjVCYXNwdjY1M3RVY0FWSmZmU3JL?=
 =?utf-8?B?YnhTSWdqTmRvOGdNbUsySW4xVU5kTFdER2NtTHFGSUNhZU5Ba040cTJIc3Mw?=
 =?utf-8?B?UVhxSzR1ckkvTTNmNVpFazBVUVdEYk9sY1NUbWV2RlFaTFVHeFdUaG9kcmpT?=
 =?utf-8?B?Zm1iVG5pTnhNeW5OdENGenlpRkRhQXk3NFZXK1NQcVQyZCsvMzNUSVRVZnpC?=
 =?utf-8?B?THRKTUpoY1Rkbit0TkhFS3Z6U01jMlNTQW9jZkdZOFVlWDU3aWlzMXBTNCto?=
 =?utf-8?B?ZnViVjZjL3N1LzVOd1RWUGQvNENGYllPQnJvbUxTaVdza1BReG9oK0hBdnpk?=
 =?utf-8?B?QmVsdFNiZnNUbmlIRGk4UDV4TlpYdFdVT09ZL1E0bThKYVh3WU9DOEo1b1dx?=
 =?utf-8?B?bWlOOVRtWjIvRkFMRnhadEVGNEN3UExJOU9tRXhUdHBVTDFIelIxb3YyZXAy?=
 =?utf-8?B?K08wMDliUGRJZ2ZJT0dscVRRd0FDelo0YUZaN1o0RUVKNXlacDBhN2M3ZmVl?=
 =?utf-8?B?VG5WSUkvWitoeFlIM0J3VHhEa0hxL3RtUXRMWjRid1o4YXFLWDFiZDByRWtx?=
 =?utf-8?B?NlNGQ3k5NG1IL3llbTFMeEFqdlNaa1lGN1hiMStXZkpPUGYrVCtNejhQL2xJ?=
 =?utf-8?B?TkZRVmJLa0hUdVdFNG9wekNPOGEya2ZISGlrdWhqUjV4ZzFkTmVnMm9GM1lt?=
 =?utf-8?B?czFjb0RwRnQ1b2M0SjJVQkdtUkp1M0N3b0hvdVZoWkQ2dFYxZnFndUs1ZkZm?=
 =?utf-8?B?Mk8yRzlaT1VCWkl4NmU4TTlxMlc1NkR3U2VLNEQ5M0JtekJ2UmJlRHF3b1Ft?=
 =?utf-8?B?UzZ4ZDdUdnJ5eExIT3FlbnlENStpSkVOemxrbm9sZFo2S0tWd2crZ1ZRbGx4?=
 =?utf-8?B?S1B4YmVNdDB1eUFMMWRGYUl5b3E0TDdKUEVNdHNkTDh4bTZWTWR4NjJyaGV0?=
 =?utf-8?B?NlBpZ1JvWGtMUThlazhrV0VDdDNzcm1oTS82VEx5dzJCbGdCd3RGSy81akh6?=
 =?utf-8?B?YktzbmhuanRKNTlpZTRCUXAyUFRIWjlkV3VURkRIQWZLeG44ZmxzSG40bjhY?=
 =?utf-8?B?Qm5zWEIyRTd6dUU1RGpCclA0S3dQTTJvUTNiZFM5eXBtODBja3RUQmxoUHBT?=
 =?utf-8?B?TE44L215Qk8zU0JXQzVpSlVqV29nc0VpWm14RmM2SE0raDhPVUJCNkpLZDJF?=
 =?utf-8?B?WUZCSTljS3kvZENaa2R2dCtGb1FFWEpHK1VSQ0ZBUGlta1ZZcTJ1NXkyKzJ6?=
 =?utf-8?B?cmxyZEdLUjgzczNCc2tTY3BHL29NbEd0cW9rbjUxVUJKRjNWZ0dWMFgyMDVu?=
 =?utf-8?B?ZDJvYlE1cUMvMWU3V3ZxbDR2cG5sWHZnSW9TWHBYVmovVkxia3BXamRRRjJj?=
 =?utf-8?B?Q09OVjN2MjQ3dU84YXlBbjRxWDV2SHgxOFBDb0tIdHlnT1ZCWnNQWHNWMUFr?=
 =?utf-8?B?QmpoSlF4ZTJ0TFBCSnV0QnZ1V1FNUDNOVzJCenpYbmRpZlhVdjQwT2F3aVlr?=
 =?utf-8?B?MXBYNnV2TlNwM3hIYVd4WGhJeEkzeWU5UGZlSndNZGJGY21SbFQrTDllK3NF?=
 =?utf-8?B?czduNlN4eFBHU1MxNWdIcUZRY2VvQ01UbjdMd3dhcWJaRUMzZWx2M2xsenhq?=
 =?utf-8?B?UkVPSkp2UXBGLytKOG5hZnZySnpCc0l4U0VhZnNQZlA2SlhSVWRkVFRhdkFD?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc593cd-20a1-4fb9-4d5f-08dafe2c5d45
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 16:59:32.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTVGtvmUIbdFCE3bj4w4VXmnZ7WkzKXBqp/miQCjamGCCI2PLjGZpEZKX8hxCW1xjCievYzjhZbdfCcZcrJHShsnViPqGnR2YwiykrxuRuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/24/2023 8:06 AM, Moger, Babu wrote:
> 
> On 1/24/23 09:10, Borislav Petkov wrote:
>> On Tue, Jan 24, 2023 at 08:11:21AM -0600, Moger, Babu wrote:
>>> Understood. I am planning to add resctrl feature list inside
>>> /sys/fs/resctrl/info/ in my next series.
>> Maybe I wasn't as clear as I hoped for:
>>
>> so you have a couple of flags in /proc/cpuinfo which are actively being used by
>> tools.
> Those flags will be there. Not planning to remove them.
>>
>> Why would you want to move the flags somewhere else and do the extra work for no
>> apparent reason?
> 
> With this series(v12) we have added two new cpuid features(SMBA and BMEC).
> 
> But these features are not visible in /proc/cpuinfo. Planning to add them
> in /sys/fs/resctrl/info.
> 
> So, users can see them here. 

Could you please elaborate what you are planning to do? 

Existence and support for SMBA and BMEC is already visible to user space
in your current series:
* On a system that supports SMBA with the needed kernel support users will
  find the /sys/fs/resctrl/info/SMBA directory with enumerated properties
  as well as SMBA within the schemata file.
* On a system that supports BMEC with the needed kernel support users will
  find the relevant files listed within /sys/fs/resctrl/info/L3_MON/mon_features.

Reinette
