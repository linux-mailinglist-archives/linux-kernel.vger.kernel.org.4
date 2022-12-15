Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350964DFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiLORn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLORnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:43:53 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63E37204;
        Thu, 15 Dec 2022 09:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671126232; x=1702662232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z8+EsnJvAsM+KC2ZzglG00KO0NE6lqAHLeDpZlj+48I=;
  b=Wz/Ag5HLT9wzmfIyd4ifVkBQZ4rGXTiGUBWKWd+TxlcNwW5aJYrNIM+D
   N4JvwrtTdpIddx+P7kN395XoiXw9fkEqleM7UJd7JQ1gNNq+tf6OQ49pb
   kX5DYW89wPBIOZ7869to/Tf3f95xI+elPeutbyXlqDW4XQVAH6Otu47YG
   HbzPRZ7f3Du9ydT6h7UNbUVLYE5adzuuqjBR0PDJD1iNrINZdEJRw/ScS
   FcyLuuliD0seKeayotSusZ8+QhA/+2J7BYRcAmOMxctKS+uhkXtrB9QUd
   QT/do9reFyv7SHXZxlOrLtvJB5NpIrYC36iRudlgLizkFDdwfQKESQf7S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="380965965"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="380965965"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:43:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627281188"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="627281188"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2022 09:43:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:43:49 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:43:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:43:48 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:43:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfsVLAjlb8H0ZelUzII6Nu/24OXDckyD99j48ZKat+rRoWqv+a6TigDldTd6I9d3gSwcdyF2XnpkQkWUyi+/sDW0i40DUUCHUZGAlMB57a4L9H6EgRv24+3zGvQrIQBk/3V2PAEWgj1XNqFknFNyYu9u5iWFrPdtNlbpo0Taqj3alhQTOHW6J1e2YIAOwKRmM5b5UH7XKs4vRbbdvlFdEMTpN69kpx00FJpENuuDhgeDKJD1M/gWffdHRLGXPKKckRxJWqQJYrC2TdjwhxbO7vrqjle/On7wII+s8SorL5ZRAGbaKSa9vJevQw2kGm2gRCTqXwAJQrjKJhWmB/Wezg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JioISJWE7JXt0rFquflgdIKqvgKt+cfFxSmQua4fdME=;
 b=FluCC/eTHRoBFq7hikhkwFEZl82vjFkaEA5WHAzRaax8vgVhygFy/pjJnpfIqTKmo60ECQijb03m7h3Ob/5ujdZe72AnSDY7xNjA7aNKKVMBZCdYECXYc92WCHZR6d4wfSewuqvhUn14ZTQhmjZS64xjOaMa6ufZ6CE2GzfC6XzU3T+1d/npkXFFNOXQOQR0xBj+1Xi/WoYddKUA6eBGgPtlWG7K468esvT57UHH+ljx/3hQDcj9/aeZN68Pd/pkF6OejDy++QuuZKIWaVEpxgu6gEKK7Eqj3djP0KAqcjovV9lHP0uSz63Lhc9Y0XBMLdI/Im40XL6ytYOXFtS1YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5690.namprd11.prod.outlook.com (2603:10b6:610:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Thu, 15 Dec
 2022 17:43:39 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.012; Thu, 15 Dec 2022
 17:43:39 +0000
Message-ID: <57b5dd79-9498-b450-25df-b9496bd46ec5@intel.com>
Date:   Thu, 15 Dec 2022 09:43:24 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 09/13] x86/resctrl: Add sysfs interface to read
 mbm_local_bytes_config
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
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990902305.17806.9650262646704189221.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166990902305.17806.9650262646704189221.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:74::40) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5690:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a80448-e48b-4d6e-9595-08dadec3e66e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QFHVP3cJpqS9gIZTLRPpYl5wQMmN2ONFBkR6bbAYX5Xe+J6WiRzfaISCGejw5mDe45aweIc8rDUk8dKcmVubrOJPyou11/2xlWVvra4ZalpBpVSkcKOhCmEtoJCHg6WZIv5uQY0iEJWe4d+60d4EO1uWHgHDKU8zjlfRT8o+h22lD/ZRritUxfYY20H2PlIeQ5ONJa3aXg6vEt8dOPffGZBpaFrn4VSwmFnol4xoqj9frqJRIaOsYGMLgQ9qHejT7x7rJd8VceOMV70C4eK3VioWu5e64rIsjce0tmlkPBftOt/PvSUpZFEutGaQTCkw274pZReTPUkyo+P70qYzWHt2vRyIsS59hcqHOnUVp5PWSZy9wlCMH6x7KClqq6GvA3tLLIwwKSf5u/0035E00FL9/fD8Ou0yP2mC6ZOpywLNMx+nyWW0Wde0a1O2EgBNdnCBBIPQH38MeHUtsrAbZE0j8q+17PYOBmiQs+hQCe2ZY2lMvytpT3WplACbFMrcQHEGJE+twRar6fP+ffykdPS0eUdbTBvLllkgPkaAPD39/OpzLTLqxNrzo0SZlbOURYHuWvquWHhCMtYH4HQUtSccRqigoIlGI9eIs+L5QaMG1IMoGXso9DdAoLLEnR6GZoyfe/7Ack24TJ4KTy7NAmPu8rPqU2JxZUoVQ6Au29g5C5R1l9xuDOl47VxosEJtbrkkbQt/R6XubaGCXVoPUXZbhibaKEaC65fGDKnzm8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(6666004)(478600001)(6486002)(26005)(6506007)(2906002)(53546011)(31696002)(6512007)(186003)(86362001)(38100700002)(83380400001)(31686004)(44832011)(316002)(7416002)(66556008)(66476007)(7406005)(66946007)(8676002)(82960400001)(2616005)(4326008)(8936002)(36756003)(41300700001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZStEM2kvOFN0NnZNckwwTVJ2NFJSRUNzK2FESjUvMUcrWllKMm5qVC9lWmht?=
 =?utf-8?B?OVZTM1BWUTRNVDgxYXE3c3VzVDdxVmRtZnhmOUJkbjZwR2NwdDhuR0F3RkFB?=
 =?utf-8?B?T25IOWYyMmR1Slh1OGllK0htQUowV1VNY3EvTDhyM1pLajFhOS9McmdrY0Vp?=
 =?utf-8?B?R3Z4aFpKTFVGV2dldEVuS2VWZ3ZkWkJyRHNlbEx1VlY2SnFOU1ltWVprYXky?=
 =?utf-8?B?dG1zNDR1QUJtQ3VXU2xlYnd3NEFvSEhYWGUyQWh4QXY2T2M4Um9SeklJckJS?=
 =?utf-8?B?WlJ0eG9IbjNPSXNTSFJrcVY5VW04bEN1STdiWlplUzJvSVYxN2g4RmJjK0k3?=
 =?utf-8?B?eTRZYW9oMVBkbjhETnE0SXhSK2cyTVlyTC9JVkUrTUo4UVJuVDIrd2lsWDd4?=
 =?utf-8?B?MlQ0MXpmUkgwOEkvYmZNWWhHSFBLQXdxUkNWN1NDanAyRWhiK2ZiN0YzZFg2?=
 =?utf-8?B?eWtsQkRLMDExOUpoU3hCZ1Vrcyt5cDhLdkh6Y1ZHZjZ1aUc1ZW00Y2xUZXI2?=
 =?utf-8?B?MGhpd3JrK09WNTZmSkFNTmRMREZ4UEtsRnl2ckUwYjF0ODZEdkwvb1kvdzRG?=
 =?utf-8?B?R2JTYVlEUGN3eEIxaERRaWxRNms1emN1UTh1UVB2cElmTC9tMUpsd3JYUjBK?=
 =?utf-8?B?Mkg0enhKZjZSZkV4MkZXd1JQMTRRbFlkekkyZy9uM2xPSDJFWHpmaWxUUzdw?=
 =?utf-8?B?Si9MdUlTYXltNEVjVzgzUzVHSnpMWWhhTG1TL29XQmV3Q0JhdEg1T0RMcGxk?=
 =?utf-8?B?YkpjeitPZDZUb3p1dlBlZUltSUZsblR4NXUrWU0vUjN1S1FrL1ZUdUdmUThG?=
 =?utf-8?B?QXpOSzFmZmFvaENVZXFMQmloWkxhTGYvQkdWRThOL0pRdXljTStMbnZxU005?=
 =?utf-8?B?eGJQQS85NkFwUUd2MEI1KzhqS1k2REdydFZZcmc3VFU1ajZHRlRzbGw3N25G?=
 =?utf-8?B?QU1TbXJCYlZoeW45bXhJRVJHZ2VxUDJBT2crR08wRmd4V09pVWZ1ZUs5S2VO?=
 =?utf-8?B?VWt3WTY4VWdNM2tEMWV3ZCtuVmY5U3ZYeHkyNDRnbHJmYkdpTHo3RmU1VU8r?=
 =?utf-8?B?bFkyanNSZWJwQ1VON20yS0FQdkpvYTArT1lUSjFkSE5JVUNxalIrdjVaMFI3?=
 =?utf-8?B?SmpUZjA3d3AvbU5UblYxNjRvQUJ1dFFUVG5pbWx2ZDRMWmtvbW1tSnAzVFZK?=
 =?utf-8?B?Qm9nWnkrK2RCdndmU21Xd1ZaN21UUUpZUGdjNndoTkxRbEx4dXl3YjF2NkMv?=
 =?utf-8?B?Tlk3NnovRm8vQkZzSS8zKzlHRDZKSC9RY0pCSXhyWFFUUFRJbWRUMzFUai9y?=
 =?utf-8?B?MlhoNGVVaFlZbXBDRmRlMHB3dmxneU5PTHhhUDZEN0FmTC9PaEw5dU9DRHpW?=
 =?utf-8?B?Mm9WU09rbXhsTEV6aWhZS0RHa1BKZDN5L2xQc3AzYkIxYURLYXBaZzBjUVNi?=
 =?utf-8?B?aWR0NHRacEJPdEF6N1VOMU9UdTlhOHhueXBGMXJwTzJvVUYzalE4aW51VWxy?=
 =?utf-8?B?NHFvZXNNMXMrK0dZZXYrU1JsR1ZveTdValpwMVRiM1NKQ1c2VkQ5cm9JejlC?=
 =?utf-8?B?amRrNTdSaG1ObjdJcU1lZm1iV2sxL0tmcGE0MnlTZDRzMGFmb3Q5QnlTMVR1?=
 =?utf-8?B?Z2FYSVFNTTVOd1d5QTJybzZLVW9aaDF6MVNwQTZRNGZ5b2dvQ1pEeld0THBZ?=
 =?utf-8?B?ZHlhSHUyTk1WdDhNRnl5citqSEYzZ1dib01IREIrSTRGVTl6YTg5dHdCMU15?=
 =?utf-8?B?UnRGOEUrWmEyQjFiU3hKVU92WHNTd0ZOYlNNMEppRWR1aXU4UlpjRWM4MVky?=
 =?utf-8?B?aWFGSy9EVytRSzNJOUpZQWdTWGhqMVllR2JUdFlYcS9Ddm1WM1pYSjlJZ1ZO?=
 =?utf-8?B?VThOOFRRQXdVbjd0Z1JWN3R0aEhqbmhxQTFweDFzRmkvMDlIdVFCcHgzbGtU?=
 =?utf-8?B?OUgwWTBLeVNHWUhYU2JySmM1aVQzbWF0UkdGRURjNHVSQS8xTHd4aGdGa1Rj?=
 =?utf-8?B?MnlheVhuMG8xVlVBUXdwMjgyVUQ5MHlUV3U2Tk1oUXMyZEo0ckhYTm9yUnZM?=
 =?utf-8?B?ZHZQcjJQWTJpRWR0Q0VwRVl4NFNGMUMyUUZ3T3dkTmd5OFBZcUtZaXE1N2tU?=
 =?utf-8?B?T0MzK3EwbnBrS3RRTGJPUk1PRlYvanVEUy9RQ2xqVmRmd2F1SUI2SjZUaHRQ?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a80448-e48b-4d6e-9595-08dadec3e66e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:43:39.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtE8Tr/xVBR8z5B+gRdHh4/n50aO5S6g+z1LSx29AJuj4nCuCnSJSX8eTS/eH9YsWW+QhSwFnKRM6ENDk80ZAkXl1ZZukAcySAoOyuVWB2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Same as other commits the subject can be shortened:
x86/resctrl: Add interface to read mbm_local_bytes_config

On 12/1/2022 7:37 AM, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading
> the configuration file /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config.
> The event configuration settings are domain specific and will affect
> all the CPUs in the domain.
> 
> Following are the types of events supported:
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> By default, the mbm_local_bytes_config is set to 0x15 to count all the
> local event types.
> 
> For example:
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_local_bytes_config
>     0=0x15;1=0x15;2=0x15;3=0x15
> 
>     In this case, the event mbm_local_bytes is currently configured with
>     0x15 on domains 0 to 3.

"currently" can be removed

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    4 +++-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   16 ++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 2afddebc8636..7c8a3a745041 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -788,8 +788,10 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  			mbm_total_event.configurable = true;
>  			mbm_config_rftype_init("mbm_total_bytes_config");
>  		}
> -		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))
> +		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
>  			mbm_local_event.configurable = true;
> +			mbm_config_rftype_init("mbm_local_bytes_config");
> +		}
>  	}
>  
>  	l3_mon_evt_init(r);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e93b1c206116..580f3cce19e2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1507,6 +1507,16 @@ static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int mbm_local_bytes_config_show(struct kernfs_open_file *of,
> +				       struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	mbm_config_show(seq, r, QOS_L3_MBM_LOCAL_EVENT_ID);
> +
> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1611,6 +1621,12 @@ static struct rftype res_common_files[] = {
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= mbm_total_bytes_config_show,
>  	},
> +	{
> +		.name		= "mbm_local_bytes_config",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= mbm_local_bytes_config_show,
> +	},
>  	{
>  		.name		= "cpus",
>  		.mode		= 0644,
> 
> 

With the subject and changelog changes addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
