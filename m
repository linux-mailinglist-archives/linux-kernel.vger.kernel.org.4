Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441FF5BB09D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiIPPz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 11:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIPPzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 11:55:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD46340547;
        Fri, 16 Sep 2022 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663343746; x=1694879746;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TN3vBz/bxVljJ55KhD7cocC8yBo1Mbqq729kHdAVFX4=;
  b=n5k7pvxoFqRcqsRriXpX5QHGO5Qns/UJoC5/t3bM8DfmwEVlwIJx11Nq
   7ylUjqu7EFS1oXBcLbe29nCysSy58C/eYqeOv+Lwlw3yaxqgKmQJZI6vY
   NxHlPjsfcvMieUxftyXdOnHaiz3gDH7fSE2X0FMd3Cbx2fiDoak1TQlxV
   pd6hUnABjPpfcDCCXkntqDTbIoJYo+pSO+u2VsWq6lgaj2P+U3e6R9Tag
   TmaWN2KGH6/RC5TWKI9lmOMZUGmHmfvKrH9S7vb4Pg/lQV0/7NJn44PdZ
   YxePsAc2D6wyJ5hZ4asHJveX8Z70q+yNydKl4dEowjrh+VijQyC4suE6M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="362981591"
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="362981591"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 08:55:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="568875773"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2022 08:55:38 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:55:38 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 08:55:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 16 Sep 2022 08:55:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 16 Sep 2022 08:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9xRU1xAuTn88LPwc95n8Groc98Ddra7ttLpkGZYuDbZxeD+UqF3YsB6cUdoAxIzgBi0A6rCOtiSNmB/Quwnichvirtj9AcVnXIl7cccfiuMbTi/lN+rGO8ib+s1RVzawFdbjE3wBHckv81Ncdek0NhLztWSFZF2ah5gg8RdU8FZkQ6vxdG4dXZlt+mYukjAdwqIuovKwEWYFo2FOoGvTSqpyai9tpOHpFwVcaE3NG3/JdI/1jxSh+AlR48PdDbfJuMi89I0Z9p8DeS0Z1lcPxCZ3h1sStf0/lOGN4aajBAlqpxLlMZyzkY7XqtjjyLWrxvHkf9wFzRKzUdivIoMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKjQnZyJf/1P/XllvDTBueMp+M00D4RG3/QpV/ZwRj0=;
 b=M2ALZfqDvqKOh11URX280YC9FRp2aEfugeQxjGChUibWF+jor/8kSsUpADHcpprW9rIyIaMBSEHr+Xq1r+njh3UdyqK6Z3no55YF31AvBo41PX1MzKYu/hOQrZ9UTXA7eFwFfEDhz2vc3K26sKimnyYzEAIE87vaR7V/INqMNy59uoeAxEzSo2Ol3uPRn7QE5fBMtRacqu6NGRDgJef74nuDnJPqB2PiYPzff7V4SDJAQvAhL91oVfBK+J+a0ppc1xIBur75uhMLRUbLDQxl37b2sc79BslmtpOD03wIphgQmkryORqPKduPLSajjq+OYFvY2JLDxrM8nBjNSK28gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA0PR11MB4656.namprd11.prod.outlook.com (2603:10b6:806:96::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Fri, 16 Sep
 2022 15:55:33 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5632.016; Fri, 16 Sep 2022
 15:55:33 +0000
Message-ID: <fcb18ac6-ba84-5054-8663-fb1bb8902b9e@intel.com>
Date:   Fri, 16 Sep 2022 08:55:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v4 06/13] x86/resctrl: Include new features in command
 line options
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
 <166257364128.1043018.12636485490608845145.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166257364128.1043018.12636485490608845145.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA0PR11MB4656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1c3709-6e12-48eb-991a-08da97fbe320
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tt1SDMktDiyia4cP+ywpCl8j9RL0lqwyTUS4y5/gvLtxMijkUV5eVUVDiVEI3BmEcflANIbI6IIkg46Lt29zD71E3PFG9/YUrVs2grHgDLQE4hqvFuyK6d4pHu3NzjPLbHOxkVJEv9Gor9s3saZJgYJelZ/yHgDMiGY+n+0NqUsAHb5OcC5H+W6MiBv41QFCTd/rCm6Qvl7kOWm+VLgO2r91hMsEIx8NmJ6ddG4aHv0Js93lk/p+uyecNULUvPFLorcekYrTfQnN6/eQGvOgUrHBXu0jzCBS5nRsbukUikZN9Gee0MeM1c747w/2Udrc+OpNcE2YO9ZuocwgHk6WQskVfQ2jpo4sKwIITT1cC7QURopbCKQWNKc11r68AWzgLZ4pFp2ZbI4ribe3AHqisvuL6RMlYGIy6ptxKa67VY1U+w9ZkZykJ/2b2AwaPXHQO2up8TvZRqECsh9/iAm+9dVso0kz1BRI9YNuQzjlfSL1/xq9YhdpU1oskAPItD7E1lOJk+rsghD3IN3WmIathVgExbi4ZKDtKYJy55vVsU3+v1hAFAMSkZz2eFyvzjpCiFBWtXZTYCLEooI4AE1xeSrOzdjZ0O0WHhEFp89rBvVRtxvIUuYEIa1NpSsfLlIho1YdQ5SQ3ecawWtgLSvT5AiefuzimCLwbrmYQkNSMDH6wsVMcFmXJfUrAv83cibUGU8xYHud9+AeJagUZpVAWHjphqt9EXMLjeto6uKYPAEfpGd2Ibf5+VXoQaxIs48kJxKva6qzT0uMOsa+4ZzSiiBjr/bxha9wbJaDvSRzOPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(44832011)(36756003)(558084003)(82960400001)(38100700002)(7416002)(8676002)(5660300002)(8936002)(316002)(66476007)(4326008)(66946007)(31696002)(86362001)(186003)(26005)(478600001)(2616005)(66556008)(6512007)(6666004)(6486002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNlSlovakQvTGlWMW9DcmVXWXVCM2hoV0lYb2FPd3VRaG5BWnVEZ3BoV3Yr?=
 =?utf-8?B?V2tDamdjVGhSY1pDdVI1NEU0MFhNVk0zaWtya0RrZDQwOVRtU1FkT2xTbnhR?=
 =?utf-8?B?RW1mQXU1NmphUkZ4MndpZWQwdnB6dHF5ckNXT3U0elZzVWx5eVdwaklrMENH?=
 =?utf-8?B?MXhQdUY1N3NvVFdCY2lZbW01NytnS2I0NW56cVN6eU52VmlpQmdjMGVDY3lE?=
 =?utf-8?B?UjJIRWYrWkVWS3NLeW4zZEo2cW5rdzRqSGVnQndkZG9iMVlueDNraHowdlhQ?=
 =?utf-8?B?L2taVGUydEF2c2NnYkQ3TTRhb1hqQ2hmSU91Z0d3eHM5STFJU3MzQ1BReHd1?=
 =?utf-8?B?NXM4UHBoSkV3Vm5IQjJzOFkwaGo4UHg0Nlp6dHYxMC8xUmZxK1FuV3piZEkw?=
 =?utf-8?B?WWF1aCtUcHFjVlhUOG1Ca1dXbmo4OUZpVm9rRlo3Y2RpRDF0dlMyMHVZTjRs?=
 =?utf-8?B?ZFpFTWxCbHFFd2ZxRjdSbHZnTERIc3Z5WVZyZnZVYUlKMnY1QVJJMmlyNmZE?=
 =?utf-8?B?QU1sZjlQRlZkN2NnSXQycEJtR2Q1Vk9oNVo1aGJjZWZuYmF1WW96WGxYM3hN?=
 =?utf-8?B?dEl4MGlNUFV6dUoxNTBOSmRyNlR1WFhQUGNZOVN0VCtHRHQ5SUtPZHppQ25p?=
 =?utf-8?B?TVRjVHUzVjhBK3VKTG11QnJvVE5PSGMwb0t0V2M0MFpzdmx1bWJiY1MwbTA1?=
 =?utf-8?B?aUdJV1RxUnhlQ3VGaHRvVEJMdWJqU0s1WHNvK0VjRWtGeTVUbFZoVzBNdkU4?=
 =?utf-8?B?QXp6dGU3RUdmc1JmOGpkSUhpRWFkaVNva21HNDVta05uVkttWmFST1JKTktL?=
 =?utf-8?B?OWxaZWF4bWZYUE84NllrLzdoa29aNlpOMmlVODNmaUR2aWNHNDV1MUZpQXVo?=
 =?utf-8?B?WVlRZ2VWaXNodkl0bytaSm5OT1JVTmUzRnk3eWI4VWN5L3RmSVRicTBpL0tF?=
 =?utf-8?B?aHN6bFV4ekVDTnhmcHlPWElGN1IwT0dMcTU4MkdaMFREM3BMZ3M3TkdaQ1A0?=
 =?utf-8?B?eVc2MG9mSTBCSlI1ZWYzRVZpK1AyZjBsZzhDSWVlQ3JqaFFYVXZaT1YrbVhF?=
 =?utf-8?B?ajJJZEFlUkFIWWx4N2NwaVNFSW4xd1ZVRVdoT09kWWt4bFZRSWxVNVY0bDdV?=
 =?utf-8?B?Z3JQbFZud1NZbytPdHgyUHYwUHR6OGVRcFF6MnRSTDg0N1QzN2hTMUtwN0lY?=
 =?utf-8?B?NDVHYTgyKzdPZVNsSzkySzhwanZsVytvSkswcGg2bEVZWk9kcElRajR4ckwv?=
 =?utf-8?B?QnJMUjJpRUlIeVRCTDBIUytNc0lwNnpxazZtOFZoWmtCR2NsamRxMWFpQk9R?=
 =?utf-8?B?bUpjeHd5MUFjSXdWd21jUEtaQWJQMlgyZGZKdzZTSG01STlKb0lkOXMvQ1dS?=
 =?utf-8?B?UW85QXZORlpKTlRxWkUwdWxKd1FvSy82MTdNK1hPc1U0STBqVFEzYlZNUTlT?=
 =?utf-8?B?WUp3WTlRZ1c5TUlnbkY5cDJCRkJJWkpsYXQya2tUN2N0TEFVRTgzMzRpZUpX?=
 =?utf-8?B?NHVqL2pFQmZjQUt1dlM5ell4MS9lS3diK0Y4dnNFanBVeG9nK1dnbWcxYk13?=
 =?utf-8?B?VXpmK3grcS8vOUVqSVdoNzBKNmxOdzJnV3phaGFRbFkxMi9XRzhIQTdpNUJM?=
 =?utf-8?B?NXJjQkdwM05HME5INTB4dDBPYVZSa2VjbnRydFhwUUxLTk4rZG5SNWJVbXA1?=
 =?utf-8?B?UGhEQjQrNTZPVVJReXgyZmxKYjA1azdCQjR0Nm80YVh2cTIzSCtxQlA5Qkll?=
 =?utf-8?B?dVB0Rko3M3l1YU5tYi82Y2pkMW1UVDlNaTRaVzYvdWZsYWxuYlQzQndFQlUy?=
 =?utf-8?B?MktUbkV0T2JvTWFkdUwzRW14VXEwcjZucVVIWUhsZXhseU1heUpjamlqNnZq?=
 =?utf-8?B?YUhJSjR4dm05QnFndi9lSmZOaGhhaWhycktZWmtvVXBuMTZlY0ZkUVZUVS9G?=
 =?utf-8?B?cS91YU1hNjVhU2d3OEljaTJ3NUVSdXhISnI1Ukx5V0JYOGtrSVNjQmcyZ0E1?=
 =?utf-8?B?QXphampwbXIyZEdUUjJqSXJ2MHV3Z1VpNEcrUzhyeFZKVFdxNm0rbTVpWVhk?=
 =?utf-8?B?UXkvejNhNk00WnMvSmZiS1ZjeUlmSDJuS1YyMERUOE9RNGFiZ1czTjFkbjVP?=
 =?utf-8?B?RXhhYXgzS3QxVmx3aWRDaENiNnFaTXZML3FPMDc3S2VVbndldmNmR09TditE?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1c3709-6e12-48eb-991a-08da97fbe320
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 15:55:33.1527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBjr7lE52Jk9potwVykZ1BCMUli183xOq0BaxjPtJx6mJUkaq8vfM3j05Gpv1PfAcQJENoPLsYfEhfI+Jfkm+Ftipw9kSzC9LBbGMDTulzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4656
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/7/2022 11:00 AM, Babu Moger wrote:
> Add the command line options to disable the new features.
> smba : Slow Memory Bandwidth Allocation
> mbec : Bandwidth Monitor Event Configuration.

mbec -> bmec ?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reinette
