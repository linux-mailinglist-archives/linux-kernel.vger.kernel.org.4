Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5916660D82C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiJYXuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiJYXuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:50:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3D57DFA;
        Tue, 25 Oct 2022 16:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666741819; x=1698277819;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24iD03+71E10IGaF4JuLPuA/oCzRqSfWAdr81Hw8SJw=;
  b=VIFh0agCBKclWN5SOTMg2D3yXvdU8xcnUUJomeC98OCCbgXk5d8xWsYI
   7VhiDc/ddgDlX7+piuPJf2/cmL//nPO4lN5UT7bmtUD4klC2o8RNo0g9q
   sEdudc4Wal27+DMQBwr6DS1XDiUB2PahMVzKUJRYvYlxty8HJiujXgRZS
   Xqtuk0gj+ESMoOBF873fldVULVvIMxOubLt3DxUYSF6ggl+J++AhOH+kE
   qAdni3u8SuVAbLGZOq4+3o+1AjOXINxv9vJJihqTWV3R43/Zy3iEyVAEa
   ZvR0OeooK0BS2tWLvJMVys3/+iRc0ndykMsH68ZbCKkucogle3VXjdB7F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="334429550"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="334429550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="626604322"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="626604322"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2022 16:50:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:50:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:50:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 16:50:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 16:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ2MfJvu+xDL4BLzmSkSAkCkidiF+l0aHMLZb9Ax6NwNmAxLmLIOJGs5T8WNR6B7GgwD/dyN0scBo61wOpTQCErO6mkULH+M17oNE/I4LxgfF3DFrfJe2N4jAMBSqZfOYvt/b087TXfEV2DbfGRZYkPwHCedrHSBCc0HZRGck1FZaKsayqaIo4jNbRr3VcvAY+sm9hFD+cVeLkbdwiQ+XykxZw1rTumSOjS+BUfgT8GtMWF8DuavGFoyH8E7zBLC/alI/48it3IuiY8OvbdlM+8vFpAx3nXLinmlPZ4TdLUTVVpNNib8xi5y8M9bKIt9zGx5mgO7hhB1uwauEOD9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyDWLWurIugAQNnAFSaZAn+MchU+n5xIs7I2RtsLomU=;
 b=ExSt0JsCR/QTXMglaRwjIg2945Zm3VgPUrODjQNUrW0BZLWGdZiUYq/fkVr5/5CmrCQw8aXf3flp66hGTBqH2LiUa8Cd7inA67aRbXIF9A+HZE/aucoDLv7DKIrct5InuBk65iMjX2rlOaO/IpJGbbme7ElNt1Yi0vGkS1OBFzEiqC1pXw4WD/BkjP40yY+6lu5jvwGAPHf16fru5e5ptHP07AluehB5IY0FY3gs3sah+G5U3ziHa+X0FCCcIqf65NZ02Bg9AQhzpgt0wthU0E1nnUn4obbHQ9jjd0cQ3x6hRMy2d47PwYoXbUIahyySxeBZ8CmWxrNzPSSFarfRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 23:50:12 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Tue, 25 Oct
 2022 23:50:12 +0000
Message-ID: <75059026-f5fb-59de-8f68-bb71597d55e6@intel.com>
Date:   Tue, 25 Oct 2022 16:50:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 12/12] Documentation/x86: Update resctrl.rst for new
 features
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
 <166604565437.5345.14867510739122394750.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166604565437.5345.14867510739122394750.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: a22d83f8-eeb6-42ee-5b59-08dab6e3a806
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIsG2dM0g4VQcCiHCinvRKXY3lzhufj7+vFcUwicla64Km6QwJbRpMX4pxvSgBt5gLFj+URZMpWmpb4/+bJIlHVEyySsvKe0up+g1NnGISMqgoBzPwCxSbfxHCf0GZ60u09Tq9XOoqMEuyoZk3AtwNntU3ah6pa5Cs72jO9Jnujz3DeebCfRK+7UHWraN76n4ZlS0LDhhN/Uqk5FT0wQs9iaibSxV4/1OCZos0xZ7hvb8CMkwvXTbhxPKhH8p8LoumLL53wlTC+B8VeI0IxVDha5v/8s9zsZD+mE4KSc5hnC7nZ58ANu9CMDLhwtPSLw7H8OJ5efGzLcIwXI3+8/BJipF/4rRwnXZBBiEdTrLY86kHFjOoNevM0Fm12JYLignoLI3MwJRkR7Rq+50OIdLLag0snTq0JXM8fzJu5/ZdAunho2+0RvaTstZw7XwPh9H1AhEbOcPz9QgOcHDzEsH4JYnmhBpcKtiDdROQp1H1Wa83oWj23nOHxUBCA5GolKK+BaTuXd+Y8gZ1vB2KknKIgtKnswPKdB501UlJ83O05Kphgjs1ObsrDwDJDf82Dp6X2ezFoTLUSgYwTNfNuAqPCZ4o8yrjMSQtfG0S7rHrDAz5h30QJYqI4+8but5Q0FZZkOks70YVFj7j+hlvXX7TsPvjYFBT+P5hYchAxluk/wkCpc2t6XXVHWTKnV+mg51p1V1t290EHzx/8l/Ra/MuXQJyN9XheDUHB2kqzY+gx7vRkRFB5xhlJfHDZ9HDj8IhFLhuPjJOrJ9gYBGqASy6e2GZIS7WlDDiRgElzI7hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(8676002)(82960400001)(478600001)(6666004)(4326008)(36756003)(6486002)(44832011)(41300700001)(316002)(26005)(6512007)(86362001)(8936002)(38100700002)(31696002)(2906002)(31686004)(2616005)(7416002)(186003)(5660300002)(53546011)(6506007)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BXbzNGQTlyeXRFS0xNbUVUdElJWDI5YUNma3V0dzJ4cFRtK3Z3VU1ERnVh?=
 =?utf-8?B?czR5bVZvR0ZxdEFoTEJiYTQxWmU3cVhwQU1TY1ZvQjRWUlhYeEprOW5FcTI4?=
 =?utf-8?B?YW5vOE9kcWNUUUp1UW1RRTVlTGdYb1dUdHljT21jZllHKy8vbEtOdVFnMU9t?=
 =?utf-8?B?a2htY2tabC83bFA3YklFeXh1OXJXTDFXTWt2ekh2ZDlOTEF1WW9lNS9jUWwy?=
 =?utf-8?B?d1lpcTR2UDUwK2NYVzRybGhqQkVQa2lIUmVPQi9qYWJYQVorWlJQbUxLcTlq?=
 =?utf-8?B?WERJUGJpQkgxcXY5cEQ0UnRPKzArNmwxZHFIYXZaKzIxU0p2SklwckwwYkh3?=
 =?utf-8?B?R1Nxem9XbjlFSFd3d2pQVktZcVFJTkFqY1lPNlRMYWV6Zkx4WW02MS9LZmZz?=
 =?utf-8?B?SkxQYnNLUEU2OWZpVTVGTWYyZmR1bHAyYzJKRTFxUkYzcjlnVURyNFJtWnho?=
 =?utf-8?B?OFU3emw1aThDSmg0aVExUk5pRU9TRzRQcWxiNXd2a0lodEdJZVhIRjlvclNh?=
 =?utf-8?B?NDhiU1o3ME5GODBOd20vdlJjbUV0bmZxNmJ1bUNxWFI5UUNnVG11KzVFNVY3?=
 =?utf-8?B?Z3RlNjlHZXlxMDd3V2Z0dkhFTGRZY0c3MWo1NjVZeVMvcEhlNnk4VXZWUjRt?=
 =?utf-8?B?MWdUc0dnZ0JrOS9QbnplY1FxMExRcVF3MTJsa0FIQ1hVOUo3cTJReFRlNENH?=
 =?utf-8?B?bGtyV3YxTUl0UjlXQVo0bzlCMlAvNjQ1ckI1N3YraFU5YjRSTDRUREpuQVFO?=
 =?utf-8?B?M0pnWXhPc1RnUGlDQWF3NUJxY01aaUloaUxmRW4xTHd6eElEQ05NZUplcHQ3?=
 =?utf-8?B?Z203ZmQwQ0l2dkFtanhSRVhkNlg0b21PYWNMM0d6UWNDcWIyaFZyRU44RTZh?=
 =?utf-8?B?NFo5aW1XM0grL3BQMzE2bUtNS29LUmJ2RVcvTnV3WUZERHNYbkJZdzVHYjFk?=
 =?utf-8?B?WFpiU3hLbUJZeFFkSklKYzlvcmhFWHY5c2RrVEdCSHVWOVRRZkVtUEpKZGhE?=
 =?utf-8?B?c0ZPWkJvdEhMYmgzcVhoTElyUmErWUhtcHl3TWQ4V2o2dU1DMUlZVnhhQTZk?=
 =?utf-8?B?TVNLZnc2VEpTUXJaZVVMZ0dEYmJ1N2xGMXZNT1JNcWlIeGlXTGRDeXpzb0oy?=
 =?utf-8?B?VGFCWi9QUEVVRGF1OHJEbDNVOFNCdXprQmQyS2xYMFBzdTRsc2QybFNpbnlE?=
 =?utf-8?B?WXUwRlJsSlY1QkFNU2dsLzRVUXJOdldmRzJGV3lqcVVGc2JBSjR4eGluVisy?=
 =?utf-8?B?bitxRHZpREUxRjMyWUpQNlM3WG9KZDNkVUQrVDlKaWp1c21kZDVDa2NVY3Zq?=
 =?utf-8?B?NkJWYlBTL096cHQrRWc5V240Q1c1VXMzQTMvYlNXdzJyRHhNL1J3cTAyMmxL?=
 =?utf-8?B?amJBTWRFdHQ1cFNSVEw1ZzJsVzg5NG4vSXBkY1FhK25SMzBPaTlKcm1tTXll?=
 =?utf-8?B?Ri91M0tUVWJySnB3N2hrSTBNd3RlZkJ6WnptWXU4ZHNCbFk1ZXM0SW55UXly?=
 =?utf-8?B?TWV2Ykdoc1VOdWVZcFBtRnZxUG5rUHN2aENrdTlpTSt0emVBRlJFZTh2anM5?=
 =?utf-8?B?QnR1bHZwOVh2S2RVWnZycytpMG1ZblgzWEZ2VTNFWW13UkkyRFB5aTZyYTQv?=
 =?utf-8?B?MVAwM0JVZm42MWc5MnFOVGJnVTJrZUo4ZzRiRUdSRm9TM0hobjlPT1ZXN2sx?=
 =?utf-8?B?U1FOclNxUXR1bHJHOUp2R0J5WmZyS2YrK3VTSzV3akxvRUJPMS9kbm0vSWsx?=
 =?utf-8?B?RGVQS3MvTzB5L0poQzhiZUlraVZMcjVjajMxZ2Y4aHJLM1YydERYVnYwZjFE?=
 =?utf-8?B?MEQ0L2dPUXdzTjl0UE5iZ09KT0IwdkVzU1J5T2RSNDJtd3hDc1Y0K2JwM2N0?=
 =?utf-8?B?Qm9sU0s0VWdtcC9ieENkeEVLaWFraDBDSnRWOVVKempINGRPUUhQK3pBRjBF?=
 =?utf-8?B?eWpmY2pWUzFscnl2RGhuSFJ1UysyMjNyaCtnR3lhWUY2UkRPLzY3U29tcllQ?=
 =?utf-8?B?N1lLQm90dVR3d0xremZtUFpwcVVPUFhjcVE5YWpDTWM0Z2RINCtmdHorM2kx?=
 =?utf-8?B?WHlFOU5TRzhRVDBQb2xtTEpzNWYxS29UQ0xLRGhFdjhEbzJRdWNKWmhQSU55?=
 =?utf-8?B?Z1E5b1FSamxxQ3J0c3ozM3VFWDZjU2pHQXlWT0lkUTJzb3lRd1NzK0VnSFdR?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a22d83f8-eeb6-42ee-5b59-08dab6e3a806
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:50:12.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPSX/C5Aie0gjKLhyhRZG1Deg2sh2TfOfVlS9HbUjF1ZAGxnMvl9pOQIJ63SRAiVHde3qII/Ol5DhpfzSPiU9e5vLYAZo6Mj/o3fuAdpRi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/17/2022 3:27 PM, Babu Moger wrote:

...

> +"mbm_total_config", "mbm_local_config":
> +        These files contain the current event configuration for the events
> +        mbm_total_bytes and mbm_local_bytes, respectively, when the
> +        Bandwidth Monitoring Event Configuration (BMEC) feature is supported.
> +        The event configuration settings are domain specific and will affect
> +        all the CPUs in the domain.
> +
> +        Following are the types of events supported:
> +
> +        ====    ========================================================
> +        Bits    Description
> +        ====    ========================================================
> +        6       Dirty Victims from the QOS domain to all types of memory
> +        5       Reads to slow memory in the non-local NUMA domain
> +        4       Reads to slow memory in the local NUMA domain
> +        3       Non-temporal writes to non-local NUMA domain
> +        2       Non-temporal writes to local NUMA domain
> +        1       Reads to memory in the non-local NUMA domain
> +        0       Reads to memory in the local NUMA domain
> +        ====    ========================================================
> +
> +        By default, the mbm_total_bytes configuration is set to 0x7f to count
> +        all the event types and the mbm_local_bytes configuration is set to
> +        0x15 to count all the local memory events.
> +
> +        Examples:
> +
> +        * To view the current configuration::
> +          ::
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +            0=0x7f;1=0x7f;2=0x7f;3=0x7f
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +            0=0x15;1=0x15;3=0x15;4=0x15
> +
> +        * To change the mbm_total_bytes to count only reads on domain 0,
> +          the bits 0, 1, 4 and 5 needs to be set, which is 110011b in binary
> +          (in hexadecimal 0x33):
> +          ::
> +
> +            # echo  "0=0x33" > /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_total_config
> +            0=0x33;1=0x7f;2=0x7f;3=0x7f
> +
> +        * To change the mbm_local_bytes to count all the slow memory reads
> +          on domain 1, the bits 4 and 5 needs to be set, which is 110000b
> +          in binary (in hexadecimal 0x30):
> +          ::
> +
> +            # echo  "1=0x30" > /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +
> +            # cat /sys/fs/resctrl/info/L3_MON/mbm_local_config
> +            0=0x15;1=0x30;3=0x15;4=0x15
>  

The code supports modifying multiple domains with one write. To help users
understand this it may be useful to have one of these examples do so to show
that and how it can be done.

>  "max_threshold_occupancy":
>  		Read/write file provides the largest value (in
> @@ -464,6 +539,26 @@ Memory bandwidth domain is L3 cache.
>  
>  	MB:<cache_id0>=bw_MBps0;<cache_id1>=bw_MBps1;...
>  
> +Slow Memory bandwidth Allocation (SMBA)

bandwidth -> Bandwidth?

> +---------------------------------------
> +AMD hardwares support Slow Memory bandwidth Allocation (SMBA) feature.

hardware -> hardware?
bandwidth -> Bandwidth?

Reinette
