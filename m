Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D95BB08F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIPPxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiIPPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:53:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AB9B2D83;
        Fri, 16 Sep 2022 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343626; x=1694879626;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZktQHfiglOkLxKcYWuUrUAYA3T1eugKv1QiJHr9wY+g=;
  b=RHrp2vPtkYBQ6kCAko67Ue8a+l167IdK3bessZMjizgTtW3drFeej0Ru
   puGrNmZEbNosqtwKagYis+sWzlsJtQA4Gc8lwobjKzXAPvxk2w/oAgP4B
   MO1elOL+tCCCH1dhTMPVAuweZJkUlmJntcKS94/ZzsspYOaSahAthJL4W
   CjuUcWLJkjL4BFkCBlnqLu6T03DZapQsTKbJZeBm7OhKbKYWyAmTwv3Gm
   SBJn+Yj9iufYEc+X8FN30mKkpV1QoAKQ6aEAq31X5PX8QhKy/Ge6DGViU
   uDogWjtIgufiPutQ89Ny2I/0y63Jy63HYHyXGMW4BCHutkFNdij957Ox2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="278747516"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="278747516"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:53:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="743380739"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2022 08:53:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:53:45 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:53:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:53:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:53:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RalGcM10NVoZy0TdK1WcTX/f4dnEuH6J3PNyzgzbjYmYR3Vl1gI6AFH//FdaKBti4l6xLy47nP2S1E2K2j8myjUcV+STvQGvr2ux7SR0zWPOMDMQTt+a+0Wv3wNTpFBXflgGfSmaOJOSLbVd/2QLCMHsJ2da8/kWXfQf2NoCpDnojRPHzxmaj9vbl1uZAQM+mNbz/OXJUdmPYaR2fpGeKNC8kpu2sLIH73SGS9NAe87N+PHOKgRVfobkQoIotvpaxdk0QK7+zqeGG0z4bZqVochAF4D/ObDWxZiOEuCuBT/hj9cLtNvjzcubkIbGBmNrH4OCkpRUXoav5NXp+HZTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc67d0+tFF/uikFpNWhO9yMQ5CfyVJFai0YxD7oTwzc=;
 b=muNLLLGbmjZf9P8EqVUIVHvIsRd0z3XIqIGZ6jEfOma8P7cWRi2lsWzAhlhQprR/jb/rYGNJ4ai5RX+W5d2XKp8nOesWzMliaTYBfNobb7iUicc5Lp2DFDIaBWkLNAEjCEPlE7JrBJhkjP8wqHGVP3SlWsFcad6cC9LL1s9wkhO8aQalA1EuDvKSItAIa9JUMzNwQdmaHk1IlADsby8RgB8HjtooMiDdCPpCsfbMhnGf+hPJ1uZPGB2QtUDgw+BUNyQH2tCifF3T6pCqYEIs5CGlYivsYQKlUTd72CSBHF14QIOadaPypkBwTRkASfdLU2OHsPluW6RMkTG3g12ooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:53:40 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:53:40 +0000
Message-ID: <4d79d134-c6e9-3e98-e670-5870eff44153@intel.com>
Date:   Fri, 16 Sep 2022 08:53:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 02/13] x86/resctrl: Remove arch_has_empty_bitmaps
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
        <eranian@google.com>
References: <166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu>
 <166257360370.1043018.10126722515228365580.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257360370.1043018.10126722515228365580.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b88706-6b7e-405b-9c37-08da97fb9fd3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRreeUEACIXdmbr97tNwa+iSXYcklS2ENrERbpPnNnnv+NDF66UNaLcoNesjZ/LkbiBF3auqhPOJZZKsGvJQkzh8tcTVX5lNiQJjweZbFHYsDY3r91kTRMK7fsuR5eMavmdj3K/XnV5KjaPYuEd64Ze8bQ7/aDbHxCJAoKqOWkifSHTaqHnLIQuIl0qvycTNwDWaRYtXnOeJyfy0M9tZQx/5gts2MRcOIRdkK2LSyKy31dlMMTxswCV79YzNvjQwg+F4cdfR4HnOVDkQCk78k+iQc6TotCnjdfa9iEP9haXxeCuXSuJ0qReJIeUUqU1xbsi9a2fVCBskLFPK8mOUeZZHQG/qiUDHeIhY9eW0gLXI8neCdAnreyicq7MTnk+/YLDgFpEz4T633R0naHgg8F7tHE2EOezhYlieUsfAQF9a871vqgMbINGQ7L/iZzEDCMdF1Drm4uw7UO21z9rKIqYwmbSq+NkK/iWVK0poaoI+getZcKIRDSGw1XN247nqFCphO8T4FMk3tDFCsE/yu1jxnlXH7zBe3MwAYifoH/3fvEiYOXO2d09dTs8ogQ0Ty2t3YOwfN4J62jZRFLq9Jj5XX68ySZcSgWxvM63RpOzIjT1LfcXbpubuFNFnprykqnRP2zWTdpF/+s5nHOcDddg/ilsXyTjlqOvOjBGZ0JRI4qPF2hFuXuGmc5Enc8Sa1DxxrSapTpkSUDo+pGjpoyyaqmxcPACarO71rQxhJzWdEiAxwNo34xOKSnOnqRxWOd5AmADi0LghEcy8Lg7NfRXZ2c4qFeBbb20GROLASWk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(4744005)(36756003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(83380400001)(6666004)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODM3a3U0aGtXRlB4U21VbzNXMXlCRTdpTWp3R05KYkpQencrZnFMSmZaQitF?=
 =?utf-8?B?dEw2eXI5UWxjWUl4NGNpMEd4ZTNRaG9UWS83V1M4eEhqRXlaUlNzOEQxemxV?=
 =?utf-8?B?ZktHL25JOWQ5azVYREdML0JpelpLTlM3V0VXeXhESjd2M3pSVEVCYnNGQXlT?=
 =?utf-8?B?R3lyTVpQVnBtaDZWcGQwRHQ3U1F5TXZMYzN0T0duSVZSekh4cUNDNEdyZG9Y?=
 =?utf-8?B?bSs5NitDZ1ZQNDNOOVFDaEtFY1kybVJMQ1I2QXU2a1NiVVUyMkw5SDd1YVlY?=
 =?utf-8?B?dHBPOUlKVzFpT1RUd0hiRXl3U3hmaUk0TkRQZFYyTDVNcjVkQlo3ZHFRUzBG?=
 =?utf-8?B?d1hxaGYxTEJXcmRnVlNyRmtseTRtS0RNSW42U1VtK1pHWjJod3djNUF1WVZy?=
 =?utf-8?B?N0wzalZZOXZ6ZHhCS2xlRUUzTUtDazFqd0E3Y0V3OC9QYmJuazVRZldPZ0tO?=
 =?utf-8?B?YytIWlI2aE51NUFWU3JWZ2dsbUNIUmEwak16aVg4NThJWWpNTEFsQm9zOFdG?=
 =?utf-8?B?L0xzZFhZYm93UDlac0dSYTBXekR6aEhtRXg0a0phdFVwV1Foenh0R28yaXpH?=
 =?utf-8?B?eDY1aUM4TTBoMlBaajNmb3JLeHVZRGhFM25pQ096cHd1c3NicjZWT0dVT3Bp?=
 =?utf-8?B?a0V3b0lqK2trUEx5VmVWeHNZMXM0RTI1QzVvOXJiQlBTZ1ZLNmJKaStYaHho?=
 =?utf-8?B?MEFySEVEbmE3OHhGRmQ1bTJLME1jRnRyOVV2aFpyTFJPZnNaREx6NUVvcVht?=
 =?utf-8?B?TzRaU2ptcXFIWGFmY1o0UEF0L3ZENWllNkVMVnVIUUJ4QStDcHVzU20xcU9x?=
 =?utf-8?B?RWsvcC9NNm1hcHZobVVDQzBMSmlITHFxMXlIb2wvUDBvcTdjRUpVNEc2UmUw?=
 =?utf-8?B?TEl5VTF1czArWjQwd3RDejd1SDFqWWQrNVRYZ3Z3bWR3Y0RkVm9MSFoyODlw?=
 =?utf-8?B?YmlETmwzUzVnVWUrMnlDWS9zVGdJRjNkZWVIeFgvN3h3R2tTd2prV3BxMGNi?=
 =?utf-8?B?bXRlcFN5TVc1UFMweUdFYldSNUhOUHdjTittc2tMUjZRWGpIL0RkNVlqMXR0?=
 =?utf-8?B?S2hkdGI0N1F0RzQzdE1rYmd3YTE1Z0Vka0V5NGRNM2FFcUdFNGNvNThVTmk4?=
 =?utf-8?B?NHRyQ3lnQ1hWTFNXU3pFRm0vSnRlMWt1T0NaNFNPZW9yZ2JjSHdPWFhEVUVV?=
 =?utf-8?B?ditXOEJRRDREUElQWUFqbkVMTGN3V1RRZ2V5dTFsbDBxU3R0SDVJOVJUckxz?=
 =?utf-8?B?TXNicUNjcjUyYncvaUpNaERwUGZYWGZiaU5QQnYxWnFnY09NK3pDS3lxd3NF?=
 =?utf-8?B?aTQ1QU5zRnZHY0pjSk90RWNUa3RpdkVpc1VyRTNoSFJvYnk4NUpxcHpFYzN5?=
 =?utf-8?B?MTVWRTV3MHRNM0ZhdHE2Zm5OZ2p6MlFkclBDQk1aZW9uK1lHeEdvbnArdTNI?=
 =?utf-8?B?dHNMMFFTc0NvaEVyRi9nQkVTbitPMkoyc3dNRmpVVldOQXE1Rnp5TDBvRE1L?=
 =?utf-8?B?aFNnTSt6bEsvRmhlZ3RCdUlFR3FpaVFqYjZGaEpteTJ2MzZmcXRXNHJsK0tB?=
 =?utf-8?B?SnJVMVhEY3JoNStBL0tpRFE3am5wNjJwODlQMlQ3YU0wMkt3d1RMTG5SYUgy?=
 =?utf-8?B?bFZMeHlKY2JiY0pCL3F1UzlEMUdhK2dvWVM4N1JBS3FSOWg5dVlndHlLZzVm?=
 =?utf-8?B?VjY5dzFCSVkvbGVYeDNsSFdaLzhWZHVtL201cXl5TDRIamxzZFMxSXR1WThz?=
 =?utf-8?B?eG96WnNRM09TQWE1RTIwVUoyUnFGY0NVSHV3ZVBmY3AyL1pXVTJYUVlOTUR4?=
 =?utf-8?B?VDdTNUhqaWYweGNhOUtTaUw5NzdOL0RQenQwNHByV2U3a3ZxQkV1aTNxL09w?=
 =?utf-8?B?d2hMd2EvaGx4Zm5JUTM2aXVKeFFFVTJsc0pGYVRoaEZ3UUF6bkh6Ukc5RXNR?=
 =?utf-8?B?dXd1Q2R6cDhoNWxNTkN1bm91ZnRVSzVpbll2WGVCdU8yNFEvYWRTQ1h1dGQw?=
 =?utf-8?B?SUR5TXJNQk5PVFFwbnJVbWdzd0hjZ0tOOFk4bzQrdzJVU1ZnMnI3cE01TFI1?=
 =?utf-8?B?ZG9FNExBekkydzEzZnBQZkZackFzZVRUQmFhNFZaekdLT0l2MWVvNkV2QTFP?=
 =?utf-8?B?TXVrTzNoZkJHSStvZVNkZ0lTUkNWTHg3dmpZMjZWbCszTSt1QnV4TkcrSmZl?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b88706-6b7e-405b-9c37-08da97fb9fd3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:53:40.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXq+SPwo/xLWRlX38L5JwTUHGfY9ohZSx84W5XyEsC7xHNq7/phzaL8uHx4Gyv8yIgE29eHG1XxCc1k6aDZNWVgHcrTwVTADqvvg/MNUoRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:00 AM, Babu Moger wrote:
> The field arch_has_empty_bitmaps is not required anymore. The field
> min_cbm_bits is enough to validate the CBM (capacity bit mask) if the
> architecture can support the zero CBM or not.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
