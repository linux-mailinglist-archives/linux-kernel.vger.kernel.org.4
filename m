Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD96B6BBC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjCOSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCOSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:33:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FC8C83A;
        Wed, 15 Mar 2023 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678905176; x=1710441176;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dadk0sF9NrTPuD/F9JOzvaideuxK+5FnNyCHkqiJwJc=;
  b=WQ7jjiwW31Wg57V9KT/cZHcWxeqQoEw7CuT8cna+l7C1p0SWHZuZ85Mr
   GHDH5meh5ADGsFvxtLGP0RMEGnjLG80g2IyvM+ekqwrS+OcLZ0/zoWWIT
   ySNqDGj/v6IZUFzytWsJ/SaHSWLTjRCtxLZtj12/OL0PRgNlDZRYF2gep
   fV04NcmGNi1YU/vY7H6Ggj69uPScbybnz2KN/T2q+lrmbGWaBg8fYzcyc
   d/I3gXN1I3CfaYcN3PFrCwfTm/gvyx2/ii83RFYNOpnlebwhZO6La/ITm
   CaZjKwfIp+4HFx2iYRio3E8oRpobeTRpjj4H0CeyKG4YRMIw/QDXxQory
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="402663623"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="402663623"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 11:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="672840381"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="672840381"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 15 Mar 2023 11:32:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:32:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 11:32:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 11:32:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 11:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7/PTIx7wwoD5kWbxXJ6EoSUgrurLjI6e1YV3Qox8mW8puxZTZexp2eXpojwhnQN4MGIqIxwA3bOrDStPIhU8LXxkQwHRhJ+1MWeEpYuYYtF56SOx4Eu6V3v6v/S9VuYCWRuryZnFWFYYArqomm9dfBSxX2L4IlZ9l2WGv21DpPhZ1Bi8tZrBrQVj+c2Y4bed0aw5aiLVsJ70ODWKEM0r3mglkH9nKX0ICHvoVtdjHi0LDNJtdf33hIilzc5XRO5eKpGOvCaGhymNGbxRchonacNFaaxR1UcY853uQZbESILn6qQ9lZDZSYuVcFQYXdFwokz749Psf8hPsgbW0G29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guqpYeNGy9OlLqbIca/5MK2UGsqUedtLl7CB8LKu5AE=;
 b=W2DQJsv8/ozAe/J6gJQI786cS85UgPEb6Ynw0nlvDgZoINJ0mcpEsXi3pRPvUtc5uU6TurxQXDiAuXD5hrpPpSEECHQaYNoavF2Tb5Rs678/JLSX4lrRv3N7MKYpKgkx88sWJu98/3Cuce4pqQGc22aXfKDowH1BafB45c73X26365KbuYlIhachyDadJRTGhGAhGVr5htSYHIAoSJTWWTbqQPF1p+KoCiTWZbz+PrD9MotHgBREEklv/P+/wlHH/OHX0edMhf3wYNOXaVva/a4MEgAoLdSpOO/dIZJAeJW4zfVX2ywEJqV9epPSGM9K90gx0LolWTZY3TGdFeIEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by IA0PR11MB7814.namprd11.prod.outlook.com (2603:10b6:208:408::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 18:32:50 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Wed, 15 Mar
 2023 18:32:50 +0000
Message-ID: <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
Date:   Wed, 15 Mar 2023 11:32:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
Content-Language: en-US
In-Reply-To: <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0280.namprd04.prod.outlook.com
 (2603:10b6:303:89::15) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|IA0PR11MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6b4ed2-603e-4452-ba95-08db2583ae19
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EP2dc3Hjkq/Y98XjpuxkX37O+lhzCm0wqgilSA27NCDwQQ4mDABkG+hCpo5sOC5J5VMQX8Fzlk2XnNeIbBWdbDXkUO7Ukj2yvEDtNphPs2QQTqY8UurjiXp2lMGbhnneweK7F+sJL/Wlc/lQy++2GZ8ZUKcdqtC41hMMDDeSCFoO1Ky7cwERPKKOFuF+pJSwf6j52+MLWFjLTCcZfC66AIOlLbJJxOjMwL62aIQzLoVlFOMmB37W8MnhusH17FLFkw4U9rlMLP/3kWHQ6IqZhFue+tV2fz8rR7BTP6eI1/F7d7FgyzNma4yJphCWkl7hA5d3mK1bLvVU5rum+HO5WbDJTl6GwPBwmkIZwesEGASGqNnmxdKvxjIDnoDG/8J6I5YpwiOLM+cgPbquprgl4gIa+1RRkcPa2nPtwoqx3xV4VmJGtbnG9eNK7uZTJDRPeV+XyiIsAXVIDKo7GCYLhZ3pwDhX89dRrOiXrBvxqx9lpF+V/w/LOED2WoKOTrQzuHBYY3Do8AJrfUAVRIdjb+ogpXqI9zaRRwpPM9wjUVLQchtTobVa1jaGHqIYZjsD4Ek4VAIgg7tkzhoyIIl8YM1r2rIdqmvl/AH+WtTNyXUTDHTUww7eFUjauBHX/ADnsTLc59GXmCY7il9100UmdA3n/zxX0nhx1A1xI5nhjEOxoE0glrxWU30FcR5ZJf/91L4Tuifv3uu8u+j+eJRuyqBDhRzZeUcEehMIEgCDaa0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(66899018)(31686004)(36756003)(41300700001)(7416002)(7406005)(8936002)(4326008)(5660300002)(44832011)(2906002)(38100700002)(31696002)(86362001)(82960400001)(478600001)(6486002)(6666004)(8676002)(66946007)(66556008)(26005)(66476007)(6506007)(316002)(186003)(6512007)(2616005)(83380400001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhwbUZuY1JvamR4L0tFK2oyMnlocmFNOGlqVHJQSnNkVUhYTEtDN1EwMWIv?=
 =?utf-8?B?WlBxUnVXQXlFa1ZUUUhISDFNSVhFQUIvdFJ4Q2l5R2hMcDZGWDB1b2tvcDFL?=
 =?utf-8?B?Q1ljWEpaRUxZVnJaU1U0NlBlVWZqcS9STzJkb3pKTDlkcFJLSTNsaTQvR20v?=
 =?utf-8?B?ZGgyeE43OWJaejZBZWxHY01nWUJsUklIUmN1RWxlSUQ3TWowaFpySVVqS2Zx?=
 =?utf-8?B?VXovdTl1T3BHWk5FNG8xZUdQUXRwVHpnVklpTFlFaWhpK0U0dytzNEl1N0Vq?=
 =?utf-8?B?enFPVFFZYTRLNWxENlVDRHJKa0RjVUt2Kys5Nzl2MmdFOFk4M3BOVFVQdE4w?=
 =?utf-8?B?Z3lTcWQzZXdlbU9ZUzhrai96Zng1K2VUekhwdWMyeVBiTVB1aHNickU4a0Rk?=
 =?utf-8?B?WmJ1Q3kwaU04K2ZRYVhaaDdZYk9lU1Z6dWRkSk42Z0VFekhEYVRPWkp0WVhL?=
 =?utf-8?B?NnduMUxNMHdwM2JPRGJ0endKd3lKWnJlR3VJN3o1TDFCaURwVHpmU3BBZ00z?=
 =?utf-8?B?OVJhZWhTMXRRRkFodnhVcGdEbThFb1lUVHJPQU9qelduWGZQVW8vKzdzRDB6?=
 =?utf-8?B?UGV2ODcwWDkvWHNsVURJaHpSL0FTV3VTTmgyWjJtbmx5T1R4a0swbVY5cGdX?=
 =?utf-8?B?NnV0ZnZmTXBzZXc1NVpKSXJ1dWJ5cHkxWCtDY3oxQzkzeCtuU2FYanE3b2lW?=
 =?utf-8?B?YmQ3Rm91OHdHVkFIYnEybkxrcVRSV0Rxa1NHcmFLNERxZHRGVGFFbnZPYXM5?=
 =?utf-8?B?SHEvVnlab0RQSlVybGpTQmwwWEF2bmJzem1qOVdnMXpiQ3IwY01rVHF0T1lt?=
 =?utf-8?B?MmlDZWtUSzJILzdkTi9JYjVZR0ExMmE0ZVlLZUNFNVpZdGVycGxkWlliMnlX?=
 =?utf-8?B?YUN5d2F6VEZERzNPZlFvMFU1Z2FYdWxxQit0UDBnQmoyZ3BNczR4R1JLWnFD?=
 =?utf-8?B?TytOSjVSbFlSRGFYdThFa1g0TmJuZDBKb3dMNGdSZkVFblliNGpYUEJySmRz?=
 =?utf-8?B?eFNCOUhXcmtBVE5BdWMyNE1aUWR6d1ovSGpHNHBoZDRSOHRUVEVVMmRQNUNw?=
 =?utf-8?B?am51eXNxVW43aHh2N0NtMnFUaHEwbjk1UkUvTEd5NXR6MDVPN3VtV3NlZXdz?=
 =?utf-8?B?a0MzRFFBS1hZWWZZK0RUcFhGSVA4TjMwb2VTY3B0cTg5cS9IS0lQODU2Qlor?=
 =?utf-8?B?RTBHMXFYNE9pQkdmbFVuWkRrRXp3OXZGZUtxbXBlM28yczhOQkdSNWFCM1dI?=
 =?utf-8?B?MkpCcnBZazRIdFNQekhFTjFzNGs5S2diMGRtbm1pK1NaRngzL3A3NVhPclNV?=
 =?utf-8?B?ejd5NU83VFZmaE9TeVhCRUFjZmFjTnUrNDQxSytXejFCM21VVUh2UTkxU1lK?=
 =?utf-8?B?VjI2R1pQR2R3THhlVi8wS0NGbzYvN1FmQ0xWREpxQXlpNWxPcC9BQ251Zy9x?=
 =?utf-8?B?ak51V1pJaTRiRXArUFhTc0EvY2hDcE45anpzVXdkN0JxaUxxNmxad2Z4Z2JB?=
 =?utf-8?B?SVZ0enZ0SFpzdjR6eHIyRGIvaHE4d3VLYlRJQngwRytJTS93UGwzbmphREZr?=
 =?utf-8?B?YmVLV3VoaGpqVlN0LzBFQ0VVekhuNmplME1TaXQrcURIbldhdEFvc09pKzdL?=
 =?utf-8?B?aEJ1ZktPUlhkV3g4QmU4WjJoajQzRTVmclB4V1ZGVFRQSlNLUURYYXZKV2JY?=
 =?utf-8?B?YmlIRGlVeGh3UWZpN3NLR1F1SjhuMStxMVcrZUZUSFNVaXVoeFlpN0pacWJU?=
 =?utf-8?B?UUxQdU83NjZRZFFMTExUS1lsSWtqQzl0NkRlZGtlU2pIWXZtZFhoM1VKdXps?=
 =?utf-8?B?bW54aWhxdGxzSFczYmN0dVdzSjgwcVFIV2VlZng4OUpxWTRkYnZNSkJNMXkv?=
 =?utf-8?B?SmxMa29wZVNTM2o2ZFpRTGhYeHU0bS9oUCtyaVpGTnVJY250TFpLcVBtQ0lp?=
 =?utf-8?B?TytIODlHY244SzFjLzc1aEZSdnBXWlRsc3cyNEh4QVdTVjE0N3d4bXdUZW0w?=
 =?utf-8?B?eWxQZTFoSkJoWXVEaXJ2SGN5enRsdW1scjY3bEU1R0UvSitQUCt6eC9GZXMy?=
 =?utf-8?B?Qk9SWGp0L1RIa3daNnBUQjhBZGYyMjJNN0pVL1BxZkNxdldDTjUxdkVyaUc5?=
 =?utf-8?B?bFR1N0RRQVdleEh1WERHajZrWmVwOFVPbHdOSENnOUl0S3R4VjNMd0MwY3o0?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6b4ed2-603e-4452-ba95-08db2583ae19
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 18:32:50.0390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P2Y0y2DsWc2cM1ckeBrUC92rE5dRRTby28v1Reg97C92csZ0inBGEcrVzLj297KL+0zsD6VC6cn1zoaefygEfEJJTK5gQt37QDS9NQG3jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7814
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 3/2/2023 12:24 PM, Babu Moger wrote:
> The resctrl task assignment for MONITOR or CONTROL group needs to be
> done one at a time. For example:
> 
>   $mount -t resctrl resctrl /sys/fs/resctrl/
>   $mkdir /sys/fs/resctrl/clos1
>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>   $echo 789 > /sys/fs/resctrl/clos1/tasks
> 
> This is not user-friendly when dealing with hundreds of tasks. Also,
> there is a syscall overhead for each command executed from user space.

To support this change it may also be helpful to add that
moving tasks take the mutex so attempting to move tasks in
parallel will not achieve a significant performance gain.

> 
> It can be improved by supporting the multiple task assignment in one
> command with the tasks separated by commas. For example:
> 
>   $echo 123,456,789 > /sys/fs/resctrl/clos1/tasks
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/x86/resctrl.rst          |   11 +++++++++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   24 +++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 058257dc56c8..25203f20002d 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -292,13 +292,20 @@ All groups contain the following files:
>  "tasks":
>  	Reading this file shows the list of all tasks that belong to
>  	this group. Writing a task id to the file will add a task to the
> -	group. If the group is a CTRL_MON group the task is removed from
> +	group. Multiple tasks can be assigned together in one command by
> +	inputting the tasks separated by commas. Tasks will be assigned

How about "tasks separated" -> "task ids separated" or "by inputting the tasks
separated by commas" -> "by separating the task ids with commas"

> +	sequentially in the order it is provided. Failure while assigning
> +	the tasks will be aborted immediately. The tasks before the failure
> +	will be assigned and the tasks next in the sequence will not be
> +	assigned. Users may need to retry them again. The failure details
> +	will be logged in resctrl/info/last_cmd_status file.

Please use full path as is done in rest of doc.

> +
> +	If the group is a CTRL_MON group the task is removed from
>  	whichever previous CTRL_MON group owned the task and also from
>  	any MON group that owned the task. If the group is a MON group,
>  	then the task must already belong to the CTRL_MON parent of this
>  	group. The task is removed from any previous MON group.
>  
> -

Why is this line removal needed?

>  "cpus":
>  	Reading this file shows a bitmask of the logical CPUs owned by
>  	this group. Writing a mask to this file will add and remove
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e2c1599d1b37..15ea5b550fe9 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -683,16 +683,34 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  				    char *buf, size_t nbytes, loff_t off)
>  {
>  	struct rdtgroup *rdtgrp;
> +	char *pid_str;
>  	int ret = 0;
>  	pid_t pid;
>  
> -	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
>  		return -EINVAL;

The resctrl files should be seen as user space API. With the above change
you take an interface that did not require a newline and dictate that it
should have a trailing newline. How convinced are you that this does not
break any current user space scripts or applications? Why does this
feature require a trailing newline?

> +
> +	buf[nbytes - 1] = '\0';
> +
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
>  		rdtgroup_kn_unlock(of->kn);
>  		return -ENOENT;
>  	}
> +
> +next:
> +	if (!buf || buf[0] == '\0')
> +		goto unlock;
> +
> +	pid_str = strim(strsep(&buf, ","));
> +

Could lib/cmdline.c:get_option() be useful?

> +	if (kstrtoint(pid_str, 0, &pid) || pid < 0) {
> +		rdt_last_cmd_printf("Invalid pid %d value\n", pid);

This is risky. What will pid be if kstrtoint() failed? 

> +		ret = -EINVAL;
> +		goto unlock;
> +	}
> +
>  	rdt_last_cmd_clear();
>  
>  	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
> @@ -703,6 +721,10 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
>  	}
>  
>  	ret = rdtgroup_move_task(pid, rdtgrp, of);
> +	if (ret)
> +		goto unlock;
> +	else
> +		goto next;
>  

The documentation states "The failure details will be logged
in resctrl/info/last_cmd_status file." but I do not see how
this is happening here. From what I can tell this implementation
does not do anything beyond what last_cmd_status already does
so any special mention in the docs is not clear to me. The
cover letter stated "Added pid in last_cmd_status when
applicable." - it sounded as though last_cmd_status would
contain the error with the pid that encountered the error but
I do not see this happening here.

>  unlock:
>  	rdtgroup_kn_unlock(of->kn);
> 
> 

Reinette
