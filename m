Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369A76BDB73
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 23:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCPWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjCPWSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 18:18:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD01727
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679005092; x=1710541092;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EmtoKAYOxUUcgouiEJaY9yTlDxlKdFR3bPHHzrBi9PQ=;
  b=YKoT3vY0qp09CThxOuPOo5UGZ7I97trSb7JUmEcgvAPnYZOzw30vnzHN
   57v4J2/6uVt0fmFRvYmS1dNTV6FXDLzghqmQc6+J4LsYmMImVW0eAB36L
   e9HfeCMrtOnrSDMrTTPohcPGvL93wtUlyMr4kpQhsEIrKRhsWWk9HmGS+
   MyQA1AZI4ppxLwCQutL30yGl5QaXPjkwUM1S0WqbZ8XRGtU1hlbPXhqPA
   hBJ9dwlilPo59I5PuDaSQpdUwKx+jDwyQUly0t11e5dkkzMMa7ICQD7hn
   t8lJoS9NGvo358RbH4W3I6c0cYKoFT4a4FODWI03HoOK1wdv90Gtcxdag
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339667769"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339667769"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 15:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="749030669"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="749030669"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2023 15:18:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 15:18:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 16 Mar 2023 15:18:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 16 Mar 2023 15:18:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 16 Mar 2023 15:18:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH3Ze2RJVvAhZhpRydTEzXB0SG3x1PlY4wlC3ANfYZynTmgzG/9H4gbLxOqheQnWBLZDWHEMhPkAow98N2DJva0P4K8hWlHoDUTySOvbJc3QmBFLnLoPUytJJ2Z6z7J07lZHejcFihBJfSw7ieLSW0FsbMM9adkxP/55C6/51Ehxx1vcyGJKP3GyvPEpJNiAwg/ewcFW4DGY4zBj60QcfG/oMH5iBdjQno1TTsiXaXpdFk3PeVeLz8uTqMpIkiw+5aos/u8zoshpQ6kPxBdtD4mFg9fiw9KK9bRoHPXBze5pT71oNDXvfX+d07NC0wzeO8CZfJ+wBCxggKH/wHkWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIvA0Ix6Fl6hYKS/5o9Ir2H3a1sroXpGxOIauaF0lYI=;
 b=niE+mzk/YPzJnluFW/gpWq3IQ26SkNPTJ8jKibcS3jHNSSSGquKLdRbfUIt5ofXnEuVWjKt4y/Dl+yybKueqctAth+6vOflBfKz80jL9yiUiFhCvIaPOGX7w9umbeN2MuHyHtZqkUZ0l7bBHeD1GMujI+Ymq0BYNb7ef8S34Fannrp/Y0Jl6/R+9T1yH8cbAokgsJQ5RKJG0ym7YAjFf9QeOSDV4Tzod010U9Uh7D+LDNCbI9z2aGh3V9xuv0N07CovBjcbgIP5rJ4fmFXm2QkjbQITtB+MmaNr+VE2hkRHPIgbplRyP3YeWkWrXKUMjmHRNbEEa8mvtThiKalA+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 22:18:09 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 22:18:09 +0000
Message-ID: <231fe310-31bf-f514-e43e-e77ac017f217@intel.com>
Date:   Thu, 16 Mar 2023 15:18:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH] x86/resctrl: Only show tasks' pids in current pid
 namespace
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     Shawn Wang <shawnwang@linux.alibaba.com>, <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <james.morse@arm.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20230116071246.97717-1-shawnwang@linux.alibaba.com>
 <95fca7d1-d473-e9e2-b6c8-c4ae3d44d2df@intel.com>
 <7b331383-e6b7-f94b-6af8-72d5d8d688bf@linux.alibaba.com>
 <63f1cf0d-28d5-b648-be22-caf7bdb96fdf@intel.com>
In-Reply-To: <63f1cf0d-28d5-b648-be22-caf7bdb96fdf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bbe452-601c-4418-a5f3-08db266c52bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iK/HvAYCrEXCO9oR7vWj42eGthxOXidBYfbp8q8zDxwRFL2tZUFj7ygm25lheHRa9zTs+69zo9waoCkss9rdtOeGqf/DeY/Lj/r47a7JkkfWSVq2NXKcIeW5H/SKmPEr1ouKAh2HohKrufrkZvWgscbpCHkuEpKq0Kudbuer+F3Xy74a0zNEEyyuGCJFgPqIFI30IZfIdrl5K/RlFaRXnjokrcouqMO/LP5ziXT1w/ztjtBk/P+RhXbqmyy2RK0QyM9ZKYINg7b09xXMLw/TzAJ389Kq73jIB4g1o6bmpy1kN1kEak6P5uL8hfyjXTm59EO8uiNBhNF+xi8fbpOdSGdADIEeMsq0kJJyWi6JsP1GlgPlplh4Qfn8GA/2Y9wcotlj1qMNvHowHaofrhNs0wJUBMBCkFnF4G+yzJVsDDzEaQe3vvhaEf9F6hFFH4xCO3g0PMti0AcdT2v+NxvST5L2EweQycuWsBCtp65fMUBGyvX6CRJzulYqWGBSHmR8xBIF+YzTXE0HpIXe0SbwRSp3klQ9nF/K5zgEHHE059e1In38d9g20lq6+Om4DJk0WWS2O9llaRdCHO1blAbh5UdjfCsdvphhMrYsp1qpjPpq9F30puRIrIC8ASg/gYMhFP0pnTpZenpvdWy6g7l1WJrsVfAeR0iQore9wZqOfolKm2cusynRyprqKgC3zz0i8asU7HMKFX3+IjaCbq98ZfKCzerArD2/dN+7abHllw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199018)(31696002)(558084003)(86362001)(38100700002)(36756003)(82960400001)(4326008)(2906002)(41300700001)(5660300002)(44832011)(8936002)(2616005)(186003)(6512007)(6506007)(26005)(316002)(6636002)(66556008)(478600001)(6666004)(6486002)(8676002)(66476007)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzdqaWgrOW9BY2RqWXZKZVpvV3p1Q1h1U0w0c3J2MVNjSFViWjZNR2ZhUU5n?=
 =?utf-8?B?aUJZVHJmelFiZVdIdUlkenVOM3lDWFRGejNLQmVmQkc4VkxIMDVqMlNXRGYz?=
 =?utf-8?B?QnBvQ1NtNVNVRzZ1UTZsdjhBU2wrTUwxdTBQay9aT3NHd1F6a3Q3MVJYVVZE?=
 =?utf-8?B?ZXRWMFh6Wnp3UnRCSzhRaXJNeFhuZFZpSks2ZjlHbFpwU05GeTRYODdtdndF?=
 =?utf-8?B?Y2gyNUgvYXpTT2xyYnlrcGlKekk3bVlrUzFubUd6OWpmYTk3TnR1Vlo5K2g2?=
 =?utf-8?B?UThIdGF3UU1kUHJ1SC8zaUg5SDlvR1h1cUp0Q3NSRHhiRFZ4bU1TMFMySHFG?=
 =?utf-8?B?TUFGR2JZKzNyQ2tHdTVsVWI5V3F4azhoQXhYZ3hNaThRNHZpWGdTOTBPL3ph?=
 =?utf-8?B?bUNJVUxvNm9VT3dOSmpsbERsbVZwVWkvSmtzUmFMZExPcjB6dm9TU08vOUVy?=
 =?utf-8?B?ZTd4dG5QcVNUMWlxL3ZHVnZtaG12WG1FR0o1MDJEL2tGR3RUN1NTUmNURFNo?=
 =?utf-8?B?bXNNS21zbUpEM3dRb3FNdnZQVU1BMGxkNzJLajA4UU1uMmJqWW92SG9yb1dO?=
 =?utf-8?B?VkxIdTVJV2IyT1Z4eUY3Szh6QnJhdzg1Sy9Tb1BwWU56RWIyeHZYWlBzdmp3?=
 =?utf-8?B?UnZBWEt3MG03VlZnT1p4UmRtUGcxUGQxRzdQYmlMRGM2Vk1VazYwLzdaZFQ1?=
 =?utf-8?B?dWtFUWNVWFBnMGRQMnRqVUlzUHdrM1JheDhXZTdXaHZpSDBNRXhqaUx1SGJx?=
 =?utf-8?B?R0dEN0tOdUF1R1Q2OEZmc2xPdjVQTUF6Tk9URkVuOVJxMnlWRjNYVHlMS1hL?=
 =?utf-8?B?eEJvTUhpTHVRbGtZeXJaa1dtdkxJd2dEZ3ByNDRXdGZqZGdHMFJyMWJVd1dG?=
 =?utf-8?B?Rm1kT2JVaEt4eE55VzZlYXpWb25KdXl2ZTdLNFJrT29JVVJjTlk3Y0RwZG0r?=
 =?utf-8?B?UzYwWjJ2Q2ErdFlnZnRQRWYzM3hFb0pzSHpWbTRtSzNsOU9EaTRDZ0hEc2pY?=
 =?utf-8?B?K0hNWldhMTVYN0I4TUpHK251aEdGdm51dTlyMHFHVWFPdGdZTThqUWttSFlS?=
 =?utf-8?B?VGN6OXZmRXYrQ283K01EWUQ0bzgrMGxjRGNXazlNRm9reUF2b3BXaTNPWEE3?=
 =?utf-8?B?d1dCbERwa2FBYlRyYmV3UTczRWpNbXRMbEp1dzFVUy9HakJWblFuNHhPRGxT?=
 =?utf-8?B?cHhxcE1RbUhJZGhSVWZ6ZFA5akRubGNRV2xpaUEvWVVEanU3UzFkQ0N2MGh2?=
 =?utf-8?B?dDZDR1NZa3NLd3NUR2JncitNMk9yR0xJaDU0a3VNY1RXOWtBcVlKZm5lTlI1?=
 =?utf-8?B?SjF4c2N6V3lkQm0vKzJka2ZqcFhqVDlDc1FmTWZzK2txSC85MWVza3JuQ3Mz?=
 =?utf-8?B?QU9VcmlGWmlIclF5L01majVpOWpCZm9vdW0wTmhIZGRudTRrcUtHNVFHaVQr?=
 =?utf-8?B?cjJmRVdaOXQwQU9EZUdITUcxMzhZb3lZWlFTRTV1am9FdUNqdCsvRm5tMjVm?=
 =?utf-8?B?TEdxaHJHMUM3RzB1NmpHaEsya0txTUllRkN2U3Zmb3VhL2hyaSs1YWxJUitR?=
 =?utf-8?B?MHZ3VmxreVFRelZEWVZ5UWVUbndJU2l2dVIyRVNBaG52YllEaXdZTndSOWly?=
 =?utf-8?B?YjQ1VUpsTmZEUUJ1ZW9iNDNyWXJLN2ZSSDFCMTRZc2FIWUp0dkYyWTM2dTFL?=
 =?utf-8?B?UlB6cDRGSWhpc1NVMlVBVUc5WEppK1MwRjFud3NOcVJGdkQyMzU5TkxWblla?=
 =?utf-8?B?T0k2MjhkeWlmdDNaWWhtdDRjNTA3WUxSL2diOStYaHFwUnN6QXd5NkxWUXkr?=
 =?utf-8?B?SzRrSndzaCtlS2JRUENqY3JwaUZKVkhCQ0pkdHFBNUdPaVdmZFdJaUZKdDRS?=
 =?utf-8?B?UWk2Sy9kTFhLMU5oRnNOYVROVmVCV083VzZzQmRWQkkxMkVodWlHRTZxWjlI?=
 =?utf-8?B?V2N1bkF3QUdubStiWmpEamVuaGt6UGl1VkVrV0V2Y1FVeW14VVMxdUJ2TDIy?=
 =?utf-8?B?WUdvMTlWamI3WllmZm5QY3BPeEpYRmJSdVR2R3BRQ2ZLcFdxUXgyMzc1Qm11?=
 =?utf-8?B?SjlRdWMwZ3ZHbjRGejhPWmQwLzdhYjB1QnVjdmJid3Ezd0Q1b0JSQkgxRytu?=
 =?utf-8?B?dDE0RWN1Nnk5K0ozbEg0Ui80dXhhN0FPMWRJR01ReTgzL2FhNW1PR25Zd1J5?=
 =?utf-8?B?Vnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bbe452-601c-4418-a5f3-08db266c52bc
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 22:18:09.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mC5/3jif8LBzVkLl4KheEf/mMlBGfIMaBOfirIpUdTz7aOwyCfYhwldv6iehvF8rXT5zfl1NxfjVXRxjMoflf74JqEMadNPxeYmbX1v8nqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
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

Hi Shawn,

Thinking about this more, this could probably also do
with a:
Fixes: e02737d5b826 ("x86/intel_rdt: Add tasks files") 

Reinette
