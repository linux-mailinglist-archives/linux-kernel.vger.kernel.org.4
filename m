Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECD60D827
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiJYXrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJYXrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:47:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C9779A4D;
        Tue, 25 Oct 2022 16:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666741660; x=1698277660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DJP/l4+ZeEEu/U6D/uDcHaaU673p4zNAdeCQZm+ac28=;
  b=H6cOUIWjrSf/tNnusaGLFfMzEcXBI2kfng87vFs7TVlCZ4Db2nrZdRRL
   4AVlxnQuShErHT5zb+DDm30qTqCgAT99MDKHOMgYIx5UDkbDNVlxSQf6c
   fklHljOWhDMmzHJdGRAvnOclFKXmmNP+ksPA1kHLTPNNmXuhDqZj5BgvJ
   AtfVvBtO3g/VS0CuWykG6VdqHjCbeVeuAL3RouxMdUrKwaE5EfzdV7pgj
   wI7cycU5/JCw6DEAfw3f9fFhXg+cD2xheyS3KwUvcLdc4zD2ge29gTXHC
   8tstcHxMODzL5UIw5PlZXIyMBTvEaRXwFGyWbknwyO+bdWi6KTFJ3D3sL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="287535732"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="287535732"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="774385604"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="774385604"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 16:47:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:47:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:47:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 16:47:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 16:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af7eLAHbR9U43Z4wVxOuS6C2m1n9pzXMFXl2J2GvTWtTj96y2TbmBUA4rVuji0pUVkZOhqhIRn1JR2Dqbedq0aZpTMtt2Au8Ctl61mQqc53w4A1d3WTNz55+qceFHdPL2tTzt1aKYpEPkVxQHIbHB/cp1+Q8nSwiaH7cdgIDcUNqNAyKv/YdELli9Q7sowOVUnD2uP02CyqKPPKfquA4xMlYSLf6kcAgPwgdVEAa4gwQxJfTpd2SsuQcyT7h6gitvEmYnajA2eSe/mLQpicXPnHKFKCDDqaJ0OP0XbxazzsBs4N4zvgFJn1PM0gtfTs0i2q1AZPDIZKRah17gDaoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzCyzf2YLMkyX7Y1SSvc0Mor+qDUZJ9kiFRrsReLiSQ=;
 b=lXSlupHWh4y4qTnQ/+01Lc984uxEmUDDjDKBwhVXCk5TBRzfjQbRVB5x1icsxmClU5zMUMkufxDRQ9w7E9jBvk+Ed4YskeVEEm/X3+NjTG9jWUNBsXfaSwGFT1eAy6fDS8Rzht53rPG9BUu8/yIgSyDcsGKlRoWrwItDrReznC5qGFiY+btNdhXBfbNHAux4lXb6LMULk6wbzoCVOFIOeAg5DazJbngYYquLtn1mYCXHf4207EU5ZYrWov4W+CnGfW0p6mnQBSs3S0/Lu34OtHvNhsBakCqtyigGAeubJoJXCZVA7rjlpve5n/RNgx7sY/I80KWFMafp8CV3aLLgpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 23:47:27 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Tue, 25 Oct
 2022 23:47:27 +0000
Message-ID: <0065fe9d-80d4-2e8a-afbb-d150df2ee78b@intel.com>
Date:   Tue, 25 Oct 2022 16:47:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 07/12] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes event configuration
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
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604561380.5345.17668177010598977321.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166604561380.5345.17668177010598977321.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edba403-84df-4868-107e-08dab6e345cc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgG7RAWA6WyQU6/SXJAfyhIPNBVc+vArTQQpuK1EpSgndyyzUrCQ5ldJ8mW4e8Ch1o88tZljRRicYoBBHXIkrkEO/zsFFqyGZ5f/oGT++ot0bfWCLyhZIW38l+3Ws33BiGiD3Lli2/DNEdQwuH5MgbLm0F3jEDbYbyrNEDG/xQdmfIt2tA1DcmKhbrTjaomLvk4iKXkZvJbw7Rp8OM0p3up9UAVl9v064fh3W0ILyPyCyIqDmoAgNI7V5SYfS840Y2YrNhj92SzCbk7y+QussdzHcasf38ONEagu17ibwS+xcwIL0Ny5Q+RHFA7K9K9bKhLhDt2Bs5Z2lasIQUSkodB2KQ9h4RU9DJRGImhw5NP4bzMP6Y+tcLNPK8Ga1+6lBARxkkg0Z+S7iqeY5LbkzL+IdiN9XM6oiPrpOGK3Yc61shm4/1Zk/atrXpd6dXRPxZzUOhi4Ncb7+q0afX5LWDrXV7oT58Q6nQu+qiZVxp9EB06vxYfkHqRD9xN80CplXVWym5p7iMo4NABd8/yKagBnlxfTn646P2Jgs+AFjKeSZJ+bqBQfVlTXheBrwbbC3GrCATQiCK5KC38aNfsajhRwWG57zJOrnKo+H7K8Mll1fInZmaezNV6pI1k58fXYwp9qr11NHIGES/88X1ddE0bdYD6iQF6NWJTd4ksnrXZ3v6x9uKBmDotpTcu6dIucgE2SJtgpSFj1x56rGUhr9pDYjqU/lanWbmx2xYuGEPFWmsO82FG1n4pG8TtXOmJUSF69sjYTuxrKDHVxaQg24HJkPc8D3Xm01gROE3LKR7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(8676002)(82960400001)(83380400001)(478600001)(6666004)(4326008)(36756003)(6486002)(44832011)(41300700001)(316002)(26005)(6512007)(86362001)(8936002)(38100700002)(31696002)(2906002)(31686004)(2616005)(7416002)(186003)(5660300002)(53546011)(6506007)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHg3NDJ3akZ6M0E0L1E1NTRxcHhXZ0VvSEt2RFcvTWZnbGpiSFJRRmtkMTB4?=
 =?utf-8?B?WnA4a2ZZL1JEME9uY0hsS3lsN3Q3Rm80RFp3Qm9mYTZyYUh0bHpNTWIxcnRm?=
 =?utf-8?B?U0xoQ0Z5ZHYzZlgwUTlNaGRzbjBMcUE4WUpEeStZWjhXWkpQTWUwRjlPbjk4?=
 =?utf-8?B?bnNvb0VEbVFkeGVrdmlzY1MzVFVjb0VmNm9Ta3dRcTArMnNUVi9iTmxSeWJz?=
 =?utf-8?B?eUF1dHU3dTlaL0IyQ3B4aUlkcktzVFBINlpmRDhDd243aHdCaXMwVlUxV2tn?=
 =?utf-8?B?bDZ2SWVXcDI4Z0hMTC8wQ1cyVjRSQjNTeWxFZDArZS9oZFNpN0YrT2dDbXU4?=
 =?utf-8?B?UU96Nk1ubzBadCtVMkRjSmdhNGsrdGRrSVVtUllJWWxEV1dEYVMvQ1NDelhp?=
 =?utf-8?B?NG83NlBqbTJkTlJKWEtSdU9kRit0NnN3NHM1ZnR2V0N5UmhEOFhRemdlam9W?=
 =?utf-8?B?RURBd2cwSjZjL2pSci9aZ0FQSmJFbEh4dm0rMHpuU3FCOWduM3FaaHo0Sldk?=
 =?utf-8?B?eDdJcHN2SVgxdy9BcXJvN0M5bWt3UGhRS0Q1MEg1MTEvWkpPZGFqSVN0bXlH?=
 =?utf-8?B?R3htbFVsSS80QkQrMy82QThDVE9LbDR6MDFEcUh6cFQvbk1SYUJFaVA1NFlC?=
 =?utf-8?B?VzlIaVN0K0lkTjgzRERYUXlIS0thS2g4eVkzVEdGNFBWZWJkMWZmbFBXelA5?=
 =?utf-8?B?VDFERjNqdWlpbUpxV2ZsbmhrZEJndGdOM2FoOEhGTmdqMlMzaWErcGJRWWs5?=
 =?utf-8?B?aXRnck1pTUl1Q0VYa2laTm1DdFVMSG1DQzJkOTJtY2YxcUM0R3pxT3phMW10?=
 =?utf-8?B?QVJVVnVaYUIvR1REWk1HakE4bzJqTm1zYXh2Vll1OW9oZndwU3lpRHh0aUky?=
 =?utf-8?B?R2VVelhEaUl3NW9xMkJWbzUza2hjR2NFRTFwdktVeWh4SXA3V01ONEZkVCtw?=
 =?utf-8?B?UnIrajJ1MWVJYjB4Z1NHdnBJczd2TmxhanA4MmNzUmJKZFczVGMrWUpKUUNq?=
 =?utf-8?B?ellydnRVeFRvYStCd3BQaEROclFiSjJFZVhWMmxNUUhGR3J3OFZ0SzIyWk5P?=
 =?utf-8?B?TDlUMng3YVZOMnBQSzlCUmxYamd0WkgxM0Z5N2ZreHlzRDJrZ2U1OXNYNGR2?=
 =?utf-8?B?THExS3lGMnFFZmN0N0J3UmNobmFBL2hMaS9nS3gvbDEzTGJ1SlJNNmNsdWRm?=
 =?utf-8?B?MVV1elZBYXJxdkxPOXkxdnVzeGhYWEtDWVZuclF5UnBQb0hFYzZPakQ5VjR0?=
 =?utf-8?B?c2NpMlpiTVJEcmxxM3V5VnVWT2IxRm1CMlJGaklWcklqRHVoTExtU2ZmV3hM?=
 =?utf-8?B?VkYyZ1pJcmE1MUhHQ3RMQVZBYXhSSlBHMklTSVRuc3RWZURzc04yUEtGSkZX?=
 =?utf-8?B?cjJXQ0psK1IrUTQ1VjFsVWdRWlMxa2JPOGcyRWRZaTlqRXh1N0kxb0tsVktQ?=
 =?utf-8?B?Qk85cE51OXFVSFJrcndXdm5tbXg1NlJrQ2FROW9hTW1iemJjay9qTmEyN3NJ?=
 =?utf-8?B?d21Vb2YyZW5MQzJaTTNUcXhiVjJTZnNEaXIzdE1FdW01SkRDeXBLbS84NE9K?=
 =?utf-8?B?WVlSR1ErK1oySGVPU1ptdytrMVRwR1BEWXBucnJjcWYxZG9SMURYQkIrMy8z?=
 =?utf-8?B?Lzl4cGlmL2lKem1KTkRpMjhYaWtLYWFTK0MzdzYza2pwR2puV2RGcHZhd1Vk?=
 =?utf-8?B?TmdtL3krcm5FVFBzemRObkhEU01zSnhLenFFekNuR3hZSHFXdWxNUkFrRnNn?=
 =?utf-8?B?M3BOQW54K3dVbENtVDZjL09oZWtpNXRhS1hxTlFkeHRQZEFDNGg4T3dLbDU5?=
 =?utf-8?B?WWpiWFlGTVZnd1p4SFp4MlNsR011R0JSQ3k2aHdWRGxrcUtRQmljbDNEdWRx?=
 =?utf-8?B?T2M5aTRGS1BUVDBzM0VSSi9COU5zbGI4dVRWSEViMlo3QmNyWnJiNU1nRHJu?=
 =?utf-8?B?OGtPL044OGlvdzl6M3ZBVE5pbm5NWFVhOWMyTDRhTjBEdXNhMFR4N25lbjFL?=
 =?utf-8?B?RHhtRFd4UzFVU25Qd2VkTjhySysyMXFEVXIraHM4UFhTSGgvTmZQUUk1M0h2?=
 =?utf-8?B?V0VxNHJtNmNBbUJzNHdhdU1jdm9obEFOQWdMMnBMV1pqM0t3UnkzbGhOYmhq?=
 =?utf-8?B?UHo1d1NEZ1RicThBNVhkNzcwSFZkWFJzR0lFQ0FtMFRBZ0hpeXFnYUcxVGcx?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edba403-84df-4868-107e-08dab6e345cc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:47:27.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI1ESGm2DoZRs8PIZ++Jg/uLwmDVfiGa9Jga8Q8CVRpdu3Px/MJiDj/SBnh1Jz6PQLaHcI3NW8xrSehIqiVdO7Ial+Cfb1STdCq17ras6wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/17/2022 3:26 PM, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading
> the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_config.
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
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
> By default, the mbm_total_bytes configuration is set to 0x7f to count
> all the event types.
> 
> For example:
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
> 
>     In this case, the event mbm_total_bytes is currently configured
>     with 0x7f on domains 0 to 3.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |    3 +
>  arch/x86/kernel/cpu/resctrl/internal.h |    2 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   76 ++++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 46813b1c50c2..758c5d7553a4 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -826,6 +826,9 @@ static __init bool get_rdt_mon_resources(void)
>  	if (!rdt_mon_features)
>  		return false;
>  
> +	if (mon_configurable)
> +		mbm_config_rftype_init();
> +

Please move this to be within rdt_get_mon_l3_config().

>  	return !rdt_get_mon_l3_config(r, mon_configurable);
>  }
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index b458f768f30c..326a1b582f38 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -15,6 +15,7 @@
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>  
>  #define MSR_IA32_QM_CTR			0x0c8e
>  #define MSR_IA32_QM_EVTSEL		0x0c8d
> @@ -541,5 +542,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init thread_throttle_mode_init(void);
> +void __init mbm_config_rftype_init(void);
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5f0ef1bf4c78..0982845594d0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1423,6 +1423,67 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +struct mon_config_info {
> +	u32 evtid;
> +	u32 mon_config;
> +};
> +
> +static void mon_event_config_read(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 h, msr_index;
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		msr_index = 0;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		msr_index = 1;
> +		break;
> +	default:
> +		/* Not expected to come here */
> +		return;
> +	}
> +
> +	rdmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, h);
> +}
> +
> +static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> +{
> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> +}
> +
> +static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> +{
> +	struct mon_config_info mon_info = {0};
> +	struct rdt_domain *dom;
> +	bool sep = false;
> +
> +	list_for_each_entry(dom, &r->domains, list) {

This is done with no protection ... I do not see anything preventing last CPU of
a domain going offline around this time taking this domain with it while this code
still tries to access its members.

I think all of this needs protection with rdtgroup_mutex.

> +		if (sep)
> +			seq_puts(s, ";");
> +
> +		mon_info.evtid = evtid;
> +		mondata_config_read(dom, &mon_info);
> +
> +		seq_printf(s, "%d=0x%02x", dom->id, mon_info.mon_config);

It does not seem robust to me to use printf field width to manage the data
returned from hardware. At this time bits 0 - 6 are supported by hardware ...
what happens if hardware starts using bit 7 for something? 
It seems to me that the mask introduced later needs to be pulled here to
ensure that only the valid bits are handled.

> +		sep = true;
> +	}
> +	seq_puts(s, "\n");
> +
> +	return 0;
> +}
> +
> +static int mbm_total_config_show(struct kernfs_open_file *of,
> +				 struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1521,6 +1582,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= max_threshold_occ_show,
>  		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
>  	},
> +	{
> +		.name		= "mbm_total_config",
> +		.mode		= 0644,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= mbm_total_config_show,
> +	},

Please only make mode writable when there is support for it.

>  	{
>  		.name		= "cpus",
>  		.mode		= 0644,
> @@ -1627,6 +1694,15 @@ void __init thread_throttle_mode_init(void)
>  	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
>  }
>  
> +void __init mbm_config_rftype_init(void)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_get_rftype_by_name("mbm_total_config");
> +	if (rft)
> +		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
> +}
> +
>  /**
>   * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
>   * @r: The resource group with which the file is associated.
> 
> 


Reinette
