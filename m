Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02D6708990
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjERUdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjERUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:33:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CEA10D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684442018; x=1715978018;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g1XiFBfq4AqwPqi0Aqj+IayLhH3fRTg9t0O87SYzxaM=;
  b=DxRg8nwsAvuu9jRByDbzjToRRTuHVvl9u6LvK7XorU2CuofQYuFMBvdy
   3A8Elh7OossvVlGFThUcsahDhn1babA7j1n+MZ4avk1YcEWpdv9DKl/aW
   dp2syhWxZM2U22rlx/zxtWuV/U/WioGuPt8nK/hL2crFISUdYmV4RqsF5
   XpHTtg0DrAuJW8tBBrIoEVr1WhZwLteX8mqjbxBjtGNMvja+7WhYOl8d1
   uSPQRZB9574lUJhHxfsx0ACay6CdCzCT48MQMXOmUEwPf6JalbhFD/GwR
   HKDJc2K2lGGUNKbhlVyqUTGh8B5WyWaYwSFVbl0PGQKjO7dNvBYL8Vp5u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="417870871"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="417870871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 13:33:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="735233414"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="735233414"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 18 May 2023 13:33:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 13:33:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 13:33:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 13:33:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 13:33:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mibY5zASgUhuWyei4VcRElFzDeiuh0X233J77cZnzn2fZUA1sELIVziP40nDNGszqCNzThUuUJAoHslTq7jAHNWsr6YQdoi3pKTumwNacLiqgYNECpveV0vsP7fqJH8NoUP73lLMAN7WQ33lQ/cAyH3clLCSdRnfjMVtIEfMzXfE++zlxd6UVwSYNv8L1gx337sRz5yeuqMIdVKqB1avHaKi7ocqQ6Q7WON5E3TlZSXjdTUdM2/01Q27XacbXo4llLhVzcUGavTcycAe0kLMNntO/Y2OlkF4oVm+VDtg5p2PSTQ8HuJJSsmNbPZaGR34z/X6KSriDERSpoXdCQHwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcY+3JhC4H2h6vqtz7gIJaw714FB24Sszm8iDHGctJw=;
 b=J63elbv2fEOijOmqRHqaXjs7RJfHNH9Xj64Gd+oWY4llnoALxxbO46G5zbPfMbhOU6pQdNtei3TBY2UW/D55LCvHn9bLfIJG8m3EQklEsAfexP2Lmu0caoMFm/93Jm8/nf6fbBr0P2cJksxzZyNw+hCNcWF7uvUfBcXerWGq3ZAtKlkpg1EMdkppy5WSo7tnA1nYX/Zg1LCUzyNJWkKOdD44+dbyTa++kjRXOBfOC9efTKYF2uiVnYuz+TDcR///2aB5hixuqZfL06D1RiIUIaAeYptpYouDWxO6RpJLOQESsV7F1sQ8ib0ZWnNpesPXSe48lGt9BZFQ//mJArkA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by CH3PR11MB7276.namprd11.prod.outlook.com (2603:10b6:610:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 20:33:34 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::57f1:e14c:754d:bb00]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::57f1:e14c:754d:bb00%5]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 20:33:34 +0000
Message-ID: <131145d8-4334-eb73-15c1-a830266a936b@intel.com>
Date:   Thu, 18 May 2023 13:33:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1] MAINTAINERS: add entry for auxiliary bus
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <dan.j.williams@intel.com>
References: <20230511164501.3859674-1-jesse.brandeburg@intel.com>
Content-Language: en-US
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230511164501.3859674-1-jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0001.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::14) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|CH3PR11MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: aba69527-6ea8-4cd3-ede5-08db57df26f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vu2P3Kr/fGgpIwv+zjHKToKDlUXTYyAc3F2/rztMg4zTXrLGO9JI0bqxAdG2MM3n9es5yiCclq6OfG9fmRWqHlCLBTLxgfXW2+O70861YKDd0BLswLqSIXQonf36kf1EpLTxpI1kdDh8PvINscGCZyFE0R9DEN0XVgj/JKycaqwRJ+shjX3+oYmtPQBL82m7FYC9Oc0eTCNCwEvCDXgeX0u6MAnHSCgPhv2J2jznRcPAxkCZ6nik6KhxKukaU8t1dtQqSIJRGIfGV7he9hXR9lVspj5sIs8sohmQ2TdQIGIo0AwSlv+LOBkJ79k9fHh/fUPdEKZPJsYzQ1IBu1Ys9jQqJvzuQ3RSdYzT5d6XoGZE3Z5Ev7ySQHMbWeEOgiZBCBpo5QbdfZAe1rjLD4BrtF/LdwAgvcNO+XIT20s+m5uM+hHnpNcV2MVNrWH9TDSWBO2OrysePM8SYZ/P3uqsqX4CX+rdimIo94rX0ICja18EwlR3LBdTiPX8IyU+8Lj/Ub5Je39PpN63T5YvOCwV9Vj2boeoxiJ514O6o7/v/Zwvq5xmTXxhekb/WtlvDflBSgMYELh49UaFOkgVJEfhMA0Latn00GABZHwr6KIuVbiY2sx9IaRCXtFd+gN3uNvEUqakQbPSp1b+H7cbi1NQcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(396003)(346002)(136003)(451199021)(107886003)(6512007)(53546011)(26005)(6506007)(36756003)(83380400001)(2616005)(38100700002)(31696002)(86362001)(186003)(82960400001)(54906003)(44832011)(8936002)(478600001)(4744005)(2906002)(8676002)(316002)(31686004)(41300700001)(5660300002)(66476007)(6916009)(66556008)(66946007)(4326008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0U4TkJURlV0RGJtSnBaOWwvcStqREZmZzlxN2l6V3lkckdqSHpHSHRRdnRh?=
 =?utf-8?B?VCtpRUF2QWQ1eFZVUXZlRTUrNSswclBBeW1FT0pFKzB6Y1d4ZWRTSk1BczFQ?=
 =?utf-8?B?YmFDcTZNN05qaFdXTmd3ZjQ4ZlI1VFFxMDVOV1lYeTVqSXNrb1JzdTl6a0t4?=
 =?utf-8?B?RDJXZlY1T1B6RWhReGYwVFZnYnI5ZWpVQ0VTYXpSSS8vZk1Vc3VKVHRhZVRR?=
 =?utf-8?B?Y3hTYnJoVE13Q0VWd2t2UGpZOEtzK2MvT0VGY1NZcENNbHVpTUdzTFZwcCt6?=
 =?utf-8?B?RStpTjlzcUVGNW9URmU0WG5tQVV1eXZoZ1EzckZMRnJHMUNaK2VwU09jd3NV?=
 =?utf-8?B?K2gzN0NFQnpIbmVSZGF0Q2EyZ1BvUy9Dcml5UGhtR1l2a3pXcVFsUXhnZUpN?=
 =?utf-8?B?VkYwdnUwVVpxUlNyZjRnVTR2ZkxpWTNOMmFOWEhzQ2x1NTc5QUY1UHZEMFJj?=
 =?utf-8?B?YnB1a0FYNGk4YXlvS1BXSjZXd21uZ1dTempKMWIvLzJJMjJoTzNkMXpxYnp1?=
 =?utf-8?B?TTJSTE9HRFU0ZGVMUURTNVZ4Z1ZwUEpJMVBGV1dtYTMrU3RTdkJuUkVFUlMy?=
 =?utf-8?B?SGlsNXpwTmVueGEvUTFhNngvbC9kTGJMaVFEVjhoVkN1YWxHMHJtbU9EcVcr?=
 =?utf-8?B?WElSSzFycWk2eW9zRlVTc051NEFFQnhMRFBCLy9nU01UdGNYZjhpcGpGM2pF?=
 =?utf-8?B?UWM0UUhTUUcvSmVEOTc2cXNRT3lhenhoNjBFTlhjQ0k4a2tOTUlMa1VSbDgz?=
 =?utf-8?B?Tnp3S21aM1kyT3YwZk43Q0FJV29VV0RCRmp1VUhsRExDZjIyOHJySVh3VWto?=
 =?utf-8?B?Z0NMWmRQdnE5M2JoVUx2ZjltWDNmMm0vcjVIMVdiZ0tZMlI2dkhvVE05c0Q2?=
 =?utf-8?B?MXIwZGl0Q2E0UlNySzdZelRheDd4OWg3YjVkVi9uWDhzejN0ZkhKb0JocElG?=
 =?utf-8?B?RE9OczhzNlpNUnJLd2c3TlE3SjRlSGxMZWMrK3d5NjRIZVRWeGtNNFpvd0RS?=
 =?utf-8?B?bFhtT1FGSitVbUhlSXp6ZFhwTkhLb2tzb0h6bTBDcTRFN21QQXZuN3RXODVX?=
 =?utf-8?B?MDBwanZtR0Z1WTVuZjNTL254ekRQS2dVSENIVis4QmFYOTFEREljOCsrT2d1?=
 =?utf-8?B?c2kxVjcwNzZZVzROeVF0dUpxb1dFL1dZUXd0eDVQekcwaHhENnVaYldid3ZY?=
 =?utf-8?B?VWRIZmUzZkRFeU8wN1dNYmpZR01ZZkN6QkZ2dDJ0b0Iza1cvN1R5T3J1em50?=
 =?utf-8?B?Y3dDelAwTExPUzRJa3NhQUIrSE1VclFwcEpBN210N2UrU0FycVA5SVFvSjJH?=
 =?utf-8?B?c016RENrYVRCU0J0bnNieDRMZUFYdWRhdGhXdnVGTzZkQ3h3Z3E0ek1scWVm?=
 =?utf-8?B?WTMwOWljUXNObStmSVFmWjRvMW9sUFdKQWpHc3pWR25NazVicStDYzVraThz?=
 =?utf-8?B?RkduMjhmcXJpN29DRjJMMzE5ZzhzWDRXbjVlUjRFL3dXSVh6ZjhTbVdSQ2N2?=
 =?utf-8?B?SEw3YWQ4b2lZOW5IaHRKSVlJcHdqQkk3eWdLOFhrdzZxOCtvTEphNVh4K0RZ?=
 =?utf-8?B?bFB5RTZyaENyS2hSUXE0L28zRkp0aitzRnJ0bXRFclkrai9RaEhZa1R3N01l?=
 =?utf-8?B?ak1kWStWaks2UW1aVEZDS045SUJPT24vbVA4dko5K2ZtVDAzTFZQYlUzNmlz?=
 =?utf-8?B?UkhDVllPRHgwY2NINkptMnZEaFVTekRCU3RYeWFsMWlHVnEvbkFjbEJRbW9t?=
 =?utf-8?B?czY4QUZ5bHRQS2wrM2QwS0R3NThpd1BnUlZya2VaTEkzYTdqanpNa0plS2wz?=
 =?utf-8?B?dmM1MTNCa0c5WkN0MlJBdnBLelYxeUt6c0MwMTMxWHEwcVZTelI0UkxweXFt?=
 =?utf-8?B?VHJ4MDJrTHNxcDl4bk10NWRRSkp5YWVsQ2orYnZ2R0FGTkJaL3FSN2tneU44?=
 =?utf-8?B?L3IyQy9HMFliT0dRNzZWZ0kwaWU0QUVXY2pyTkl0ZEFvajhKUGdRNUQ3ZlRI?=
 =?utf-8?B?ckt6cjF3WW41MlZNV2Q0T0J1eU9xL0oydHc4cHFzRzYyRTlYb29ULytrRHFk?=
 =?utf-8?B?UGxpWTZIQnYzZEJJWkV4emZDWGhjd3FTWTdOUllWd3FpRjhNUEhMTit1UkV4?=
 =?utf-8?B?UHBHbS9IbHlseWdFaTFDUjQzZDVCTWVpVkxTb1NFZzJFVnpYc3BOSmFGOGZB?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aba69527-6ea8-4cd3-ede5-08db57df26f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:33:34.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4Q39emOAGFJKiUHDEHza67X3VVoNSPsPFPNi9svcXbY/XfP9vY5M+daK5uDaOtg1hkfwxe2M5gh/jYAwiziSg9FL5xcfaOyTGlb4ZwftLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7276
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2023 9:45 AM, Jesse Brandeburg wrote:
> When auxiliary bus was added to the kernel the MAINTAINERS file wasn't
> updated with a mention of the files, contributors and reviewers. Fix
> that oversight by adding Dave and Ira, with GregKH as (same as current)
> owner.
> 
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Acked-by: Dave Ertman <david.m.ertman@intel.com>
> Acked-by: Ira Weiny <ira.weiny@intel.com>

Hi Greg, any comments or guidance here? Wasn't sure to add you as the
directly mentioned maintainer or just let the fallback select you via
the directory. Overall the goal was to get get_maintainers to suggest
Dave and Ira as reviewers of any auxiliary changes.

Thank you in advance,
Jesse

