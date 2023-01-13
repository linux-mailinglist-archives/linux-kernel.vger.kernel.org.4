Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3414866A383
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjAMTlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjAMTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:40:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014D892EA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 11:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673638794; x=1705174794;
  h=message-id:date:subject:from:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=x+gnqCA3X9nmEvcWPPGbjdDM6oQ576Gv2ecxdajYOqc=;
  b=emTKyEP9HgrvuqCCsC1igaJKa6RuTT3KpqgaLEKs/JAzhbgSk31Eoyy7
   3+49y4LvhDvQg/sKwrQrttbe+jBK+ZvDUPeXv/oLGd/IgaOaKTnfOuyo9
   9wRSw/nf8tdbavk+4L49PDx5iR+yS2SyIbxlByyjAnX8AIuOpdAufPWZ9
   7g2rU/0ZDWuZXWztNUy5dYELzYqLaYysurrjxNeR41SItQ2S0yS8ywj53
   S9p3W5bBA6+zLQkBdY4UpowEzcyQk/CwKm7CkkVjyvwd0uOTHOZOVJjSv
   E3/MgoTo0uUNUe3xJ9HwKv/sIbMwr2u4JXLzRs8Z2yvAIznqnc5vbtI+o
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="351315773"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="351315773"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="726814251"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="726814251"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jan 2023 11:39:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 11:39:53 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 11:39:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 11:39:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 11:39:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wqwax0iXwe3QYrKwSikkupH3smeB677pk+8CHRdCls+Vst31iuaoHYUJjrLabGawLxqGh9i7Xt3NETn3yhkyDTKzNql5hvoQaX29pTes7d8D8dmiMo9RBW+mksj7zcpwhVQl8H5x1Xm/cdrKuf+Xxxjbumdhf/tp1RsuMF/mphbWXGaCZHCvqTFBF9Y19gC/CQzmmLXHVW8o0ShlGJDaSVj7hVsM5zRTEE0/2L8cCAUcnF8qD9zyQxZvOvhlV4Ww9eu1/uYIkyvoxI1f4qjmYHbIP8rcXcioOy/rDzODco8r3a82S++7tbUm5K5qP3+ebrz5GNJd9Z9/qDVTg+mCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R3IeKyO6qrYLgtclkl44nZcVrFPuj5K+Ue7BxYXKMs=;
 b=GFbpl+jmnCJ720j8YHA7E1FHiRt3iB4luSzWUK2/oEuYbaKfjJ6C2WnMrc93P8suEh++h0dj4FK748Kh/LQRl6tCirXlQfm4zm0JGDg+57HsohBUoADlehn5y74Rw+xNGMn1g+qHFUJG4BFeBu31sqk1c1Q/urfCwKRYdlTv741WzOU/7frvH/9ICUG4iTgkzZHuDhAvjAB4T9HE4QYgCV8al5gsEg+aLwx5hz8IkzFxNGm4hysMp6endKGjfDNaoSHIHu2U6L0iAfca+CdpjBAuTwG6htWKmgg1EKQyvxoloOrAwmKE7gyYAafuYezrDLljG+mwZbEl2XcUh4xr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 19:39:50 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 19:39:50 +0000
Message-ID: <2f24d157-8e8d-b632-0dc5-e082cf4ba8f4@intel.com>
Date:   Fri, 13 Jan 2023 11:39:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] x86/cpu: Enable LASS (Linear Address Space
 Separation)
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Yian Chen <yian.chen@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Paul Lai <paul.c.lai@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Borislav Petkov <bp@alien8.de>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-6-yian.chen@intel.com>
 <7e859e72-4624-73c7-8195-c252ace0a49d@intel.com>
 <f6d16f82-9cbe-993d-88aa-1644e89c4fe7@intel.com>
In-Reply-To: <f6d16f82-9cbe-993d-88aa-1644e89c4fe7@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0031.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::44) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SA3PR11MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: e148e68a-633b-4c53-c231-08daf59def89
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLPLBGTjuxS3Svh9qW0YCsijRHx8/3BhHK5Vsys2omXUyAL2FF5AwnYTYxHZs/1R4wV681rypsm3MpW9nE6oc0iN7FoGNM5ZqtZsethA72kim77AtIN5gj0z/Pnh2LEsRZwmuUAC6GvYGmL2mkVNojdVkn/G4naH1jeI2cwOkjnfnEO/SujpJUkVaCOMx21JO0fXO7rpONFvnHBsVtTAYjdR+3jM1O8flkrKJAgATMvCS3duSyh+5o4ZFytwNdkW4MSQVjUqB1e9tsQbMWxi5tJikrLc+cozdEdg0Km5qQCLEZpryZ6Tl20c1/bWdttZ6Slywx2ZEHH4dmebBEBcqAMo5qm5rM1FSWSnnYOA3qZQEtXtKQQd+Aas5l8qU0CaPUZFSuCKS8lObxRYB3+2RjhIv7rx+FnhGhQqPV/0RrEJQIMd5KcPiyfsNDXNdIsYG0fnZljCcGdWhec6A2iQtAq+di6iZ3rQ7jhSzV9l1GuzTWkpK4iyWEoBxSB54cz4A1DJYkXwDju5kSBkEhwNC83laUWHT1fwleDn7RqnlmrF2iKnwC7VcTAZnjqVyljRXTtA+H4w1mnxYekGNG/3w9bi56lae/9ZC9aW3EI+fdxlDIxkNvxrMazAwWs2qSXJ3n1lZZRmNkrxWcORUoWsqANWVT/arxO1aSQcW219zjex/9hU2Z9BpnTgkwfxypcontbaVxCxKnqFBUJFAQnSGenFRj0wEv2Kg2auOhpsuSBAGwrbq5LuxsbLYYAl/sBTd65MOZUkZpYE9F5bWz84MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(38100700002)(86362001)(31696002)(83380400001)(66476007)(44832011)(66946007)(5660300002)(8936002)(921005)(4744005)(2906002)(66556008)(2616005)(8676002)(26005)(41300700001)(6506007)(186003)(6512007)(53546011)(110136005)(966005)(316002)(82960400001)(478600001)(6486002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZFeGxteHArQkJibGxjZ3BMbDZSbWRJY1hSK1BIa1ViRmhyRVdvNTB4MGl2?=
 =?utf-8?B?TVl5d2M2MUJoRkpWMmJ4UUJmT3FneUprSTg4TkZ5dStuQVRNWHlsa2s1aDcx?=
 =?utf-8?B?NEV0UnlrMEtsVExWTFpNNFNUWXFJYlNLMDFiaUc3KzFLaFE0eWN0dGZPYldp?=
 =?utf-8?B?c1NrYjdLZmZSQnlCQWt2cXhXV3NRQngwR2lkYjVXQ1NpTnliWUdqNkN3YUJP?=
 =?utf-8?B?Lytab3BVN3RlMnd0T0FDcnA2VENybUNDM2hybWY3VUF3SGc5UCs3U3U0OTIz?=
 =?utf-8?B?ZnNLeEdLd2plZUhweDJnZWhqb3VvREErQklyVTJnQ1kvdWhVck1tTmdWTjNi?=
 =?utf-8?B?ajh3aXd1Uy9qOUZyWjRnaXEyTmw4bmsrNytzS1M2dnZ0bThPSFlBM1JpS1dn?=
 =?utf-8?B?enVLY3loNlh0Ri9hd2pWZXdiMXpoRWltTjlBZVlDeGF6V2ZZWkNNdVA0UUpO?=
 =?utf-8?B?cnJwT2ZiWmk5aXRpUkczcERnZjRtQUZyZ2RaYlBWVHk4cmZ3ekxjQklNMnds?=
 =?utf-8?B?N0o4Z0o3TUE1SnBMcVE1KytKK2ZkeVlwTmNDNFM3VktqYzd3cUJmWjZCUlhP?=
 =?utf-8?B?YnpBSWtJK1ZQSW5TS0ZVV2Z6c0ZjWXBTM1E3MjJHWGJhL2VOdXkwaW1VZmlM?=
 =?utf-8?B?ck1NTlo1RGVLb2wxeWtueWNURlBDMU82SGpSa1M1VjhtdmRWc29JOXRZb3Aw?=
 =?utf-8?B?dHJyZkxCR2toNzF0bVI4UGJvT2YraHFla3ZCYmFEYWFjRWVscDNqSkNTMEpk?=
 =?utf-8?B?SFFGZHFzenRnZE0vdkEyZDR2ekltRE1Ycmc5UlZoQ09HTGhNVkdyMWM1ZjlJ?=
 =?utf-8?B?cmtKSWdxQVhwUGhwcnU1ck1lRWcyRG9EUjNsdHVCZW83OWx5UTdxdHJHenBH?=
 =?utf-8?B?QUpkVnZhWkZuMC90TWJkZzNUS3RvaXlucXEzWHkxVDNKbEZqOG5pQkxPVXdz?=
 =?utf-8?B?RjdHd084YkJHeGRhT0xTaHA3NmY3SzVPZlVBV253Nk1FUm1MZFFGN1FBWmlS?=
 =?utf-8?B?RVU5alhRNExBdTZ1djUvR0lHU2hjQVlZZWhNcmVNRlhEd0dBRkxLL1Y2bDNm?=
 =?utf-8?B?TlVHeHJWZnl2cFFyd3oyaDBNL3M0M3FZOXFoRG5BRExkNjd0N2lNc2RBRkFD?=
 =?utf-8?B?bEFLbE11RXY2T2F5Q1g5ZzkwVnRZbFZUOFNKK0tkUXE2T2tYblpNTi9HQm1t?=
 =?utf-8?B?TG1kK0JwcUZ0Y3lJWmpnN09qTXhzamVCd1hpMXpJMmlLcEE3VlY5RFdnR25E?=
 =?utf-8?B?N1dqdXhJbmxtRm1GNldLRFJaYUlzak5iRWEvOExSb1EzOUJnUzdRa0lIR014?=
 =?utf-8?B?Ujg3Q01lMFB1bHNPekxSOHAwU1dQOHFMSzZWR3hZelNBbzJLZmVRQmxvRW5W?=
 =?utf-8?B?UURDWE4wK09tTm9oMVc3YTJBcjluVXM4RjIyUWF4cHZ6WS9MSEY3TCtJWUly?=
 =?utf-8?B?M0xKTGlJT0dUSTFOWUV0VGtRMFpZUTRzMDBhSGN0bWhFS2xyUWNGb0sxMDFM?=
 =?utf-8?B?Mkgwcnh3MVpzZXlhOUw2U0pXL21CZzZQWU1SaDZpdlo1L0xQY0lMNjMrbkFi?=
 =?utf-8?B?Uk5aNjlPOFY3MHJITUhZekFzRVNVU003a0ZzM3JEUnlxVTdVTTB6VW8wNzBH?=
 =?utf-8?B?NUYwNWx5NVJWMFluWUFUS2JDYWVsTVhvVHA1Vm1QZHNBUXJXb0RhUTJvM0E4?=
 =?utf-8?B?QXkxcDNJbDYvbWNNM3RSWGh5dUxLNDV5VlVodUxPR1c4d3c3Yzl1UjJIMWtP?=
 =?utf-8?B?eTZ6VVJWUTI4VWxyVE1DSXJUS1FoRkRyc3ZHMjBlaVpBdm9ZcnlXdUgyODNK?=
 =?utf-8?B?cks1bFhFcnhONVZRcUczZHdJbVBYNC8xeWZwb1p1U1ViZ0JxbEZuNVlUcnpP?=
 =?utf-8?B?S3ZySTJnc1lvRXJLSW4wSHAyaUZLQ09nTGYvVkF5OUN1M0gxQXdDS0s2dkl1?=
 =?utf-8?B?RUh0dy8veVl1WE1ETDlkOXRjTEkvdHlzenVaK2lmVGgzM1VxYVVtZzRwNWZj?=
 =?utf-8?B?ejZzZURCcnpYZFdGWUFxOUN1VXk4S3NKNUU5TWx2S3puWk1WVWdZdWtONWMr?=
 =?utf-8?B?STdsZVZtamN0YmlwY3FMY3NDSVVpbnhBb3VWN3QwOXVNNExOdUk5NnFUdWtl?=
 =?utf-8?Q?PS748CEY4EP9DI5Uq/9m3Ad8P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e148e68a-633b-4c53-c231-08daf59def89
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 19:39:50.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgFWFhxTE+Nl6JhKYC10ADlsbHrMzYB8XM78PyVBQBteFCNxb0VL7/YNBijwgZbSyDGXg7rMU5cuhsXF+sRQpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding folks from the previous discussion when a similar suggestion was
made by Kees. There didn't seem to be any major objection that time.

https://lore.kernel.org/lkml/202205111424.DEB0E3418@keescook/

On 1/12/2023 5:17 PM, Sohil Mehta wrote:
> We can make CONFIG_LEGACY_VSYSCALL_NONE as the default instead of the
> current CONFIG_LEGACY_VSYSCALL_XONLY. The kernel can disable LASS at
> boot time if a user/admin has shown explicit preference by selecting
> CONFIG_LEGACY_VSYSCALL_XONLY or by providing command line parameter
> vsyscall=xonly/emulate.
> 
> Thoughts?

