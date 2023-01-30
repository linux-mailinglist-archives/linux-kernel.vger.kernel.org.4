Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F049681D93
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjA3WA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA3WA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:00:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F07EE5;
        Mon, 30 Jan 2023 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675116056; x=1706652056;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nY5T9BHzA8zlXHPpVNmfycxHZ5u6YkpqDCwhx0sIKtg=;
  b=GA5opaLEymtzducg/XGt3903lSl1w6kt44dLZVxqVHMT1dq1g2RFYeno
   hFm6uF8y9lT9rYL5ZBvYfEe3AEJtD7Ev2f0RvEoud8IAI5dZv6dJ7j8ic
   3lSkJSl03dpkVQNsj/wolJYzHMcJAlKf6i/oscGXViCakagU9E6ubODOp
   jKZpl2T8wux2N9yxhkGA+X6aSpjsib6+W5kCsFA1G7eTPCdnLWI0Hweja
   BMzKVjAGo/Ce9KvKiRzGZwC6an72Xd3EVcJAfQmNuwwNq0078K0sBgtJi
   VeeLgS3XJuUgQhR8unKWoP6NKZzfnuUMeF0RaJVIgLTF9ungk8IMA3+sR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315646206"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315646206"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 14:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="838109832"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="838109832"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 30 Jan 2023 14:00:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 14:00:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 30 Jan 2023 14:00:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 30 Jan 2023 14:00:54 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 30 Jan 2023 14:00:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASkgfqqgkgEPhV9tqvKMJr37ERfLKNgg5ty9UYeQHbVm6SJHqW7EnE2JmHkPK0O+y9w+QqM7NARMDYu3ohICIAWgH6+VDxE6rcAopouH7f7SGBEqCgLAVFYl5FHKrTtlXKkaCq2h4DVtoYidTwp32OI9oGONPrfT00bGhBkmVmCE4MOkX9Xv52gw59VMc0+gABs8WepcYejb8LoX42IMM8SMJuNvo9+H+0korFxxdguNvZzIVhCrh8G1wJ4x/PtDP49jmu79B1i+IDnmX/RC4K/dE6qG6cVaAPykBy6OUw//fgl4yeROlQyq4gF8KogTNnIAY2LkpR8fIu6cxxwSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPJ19wZK7GukSMNhcO3lpZyYeUiByDWXUu5WRztUJqM=;
 b=IiUd9uTAtY2lH2JH/ip4BucOBiZmX2iVms4O6Ft7uiHzhXayhHhVmOhiXh2ahVYRBGij53gr2UrlA/2cnNZamr/h5rvKECIE0rJnretvE2KoO9p5tyEk2zrp/f6A7TcmPLo+70oIhHkA5jSRz12++YlyXRw0R026s3qInJ50CWpfIDWSW8s9nuZmvDc56syQeqoV5gTPAvPPY09koU+pLSlp7KnNhqtT5diST7GRB0c1KpOjqPQuPRHpzWSmEEfzhmRp+utSA/NllrBgKiZ2+ek88UXGCFt2mZ6vST9ZsYgVdDPlaEp8c/7UwSnwvsm935oOLlwOaVGPWwiVSm9ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5022.namprd11.prod.outlook.com (2603:10b6:a03:2d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 22:00:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Mon, 30 Jan 2023
 22:00:50 +0000
Date:   Mon, 30 Jan 2023 14:00:47 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Shesha Sreenivasamurthy <sheshas@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: Hot ADD using CXL1.1 host
Message-ID: <63d83e0f9378_3a36e529468@dwillia2-xfh.jf.intel.com.notmuch>
References: <DM6PR18MB28441B6B542B2A59CF39BF6DAFCE9@DM6PR18MB2844.namprd18.prod.outlook.com>
 <DM6PR18MB2844505042F7EDCF69CE08DBAFD39@DM6PR18MB2844.namprd18.prod.outlook.com>
 <63d8292f70918_ea22229465@dwillia2-xfh.jf.intel.com.notmuch>
 <CABL7MgHENj0FcT+whjdskOmqPfNa0zo8gQobpZ0mrW3a3NY_pA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABL7MgHENj0FcT+whjdskOmqPfNa0zo8gQobpZ0mrW3a3NY_pA@mail.gmail.com>
X-ClientProxiedBy: BY3PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5022:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0296df-cd4c-4b67-8a62-08db030d72dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKr2u2eeF0/cGGaQixJa6m0/Fig7kBuay5VrkjfW0U6FcYXljAzjv63XLCvAEfjkmphuOzBXmgRpo17cA0FkI2vcN2CDRiumhiHAQKpgHBJTHeQsGiEhZWm+FTCNRanxWsqVq8NXC3+Dn1lgYbjUwLGeWTslOOuJOgw70qlrb+es9s7kdgKp3mxwqLzFNOjQ5a4n8MhHpSscbl5rHwl54obgMnjcmygboy8kDJfaXecWzEiCmjAMo3WwUkAElNVH932CZ9kkgpFQ2dc19w2kzj0h/YZQ2k2l3QH20w7HSHDZKts8WG7mQx0MvuT85cMC9BaAr30f0JEsUy56StqXIhGw/yOw2cn1xkzrZ1fGsRvDFO/W3C8C+VgYinfF37L2T/OtrarjteQc+rUUqpGJLZs/rKAch32MglCiY/ai/WxzQj7h5tkH/q3KkGhOVdgLQJnvt4T7mGKs8fQtoneQjXL3f4lZojeFLZ5w+ZIOimwxQ6a+goaXZdxKMEnbwhUJ3UIMalDTZlIb+ykeYY6xb8nP0rGYi3G+eIMU7Vnu0n6lnVNQO0ok2oWCiSP/iDgYQEhB/myoq1OJwTCLSYH1wTrn0PLNVdCOmiRyhRPMfQGqaclZlGvm307LDj/I5VxJuX+1NarCbra5lOVuRL8xcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(4326008)(66946007)(41300700001)(66476007)(66556008)(8676002)(6666004)(8936002)(316002)(5660300002)(110136005)(6486002)(83380400001)(2906002)(6512007)(186003)(9686003)(26005)(478600001)(6506007)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TktqbzlpOUN4MDlJL1pUc0JVNmh3SWRVbXBYOHF3UktiTm8rZDhmRjl5dEFz?=
 =?utf-8?B?UjRjOXBnd212ZUpyTVBvVmszQ1NCcE1hWnRIMk9ybTJpd1o5eWJnK00yMWlL?=
 =?utf-8?B?Q1hsVDlpNXBldDk2aG4zZzZ1Tnd6NTFuajdwQnhQZGNZWXlLczlhSmt2THpt?=
 =?utf-8?B?ekNBNHp2Y3BObWV1SWJEeHVVZ29OVlhTTDh2SHVjUHFldTBxalBFaGhwTS92?=
 =?utf-8?B?WjJFc1V1TUpQK3VqdWtBOU5LYkk3dUhwdHF1bGQwRXkyLzJtcHlRYkRsbkhp?=
 =?utf-8?B?V2MvT2pXUEV0dkU5Q2ZuSmdEVTRBbC93RkJ3azRicUFJUGU5aXNjTS9FM0Qy?=
 =?utf-8?B?UlVQYVA2dlQ3SWtmd3hIVjlJVnVLQjVvN3BXS04rQ1hhWThnalh4SnhsS0Jx?=
 =?utf-8?B?YmtFaFBKeG5sajMzNE9ETmxSMTdRSzlweVoxWnFTSWlYblBXeDFwbURlOVlS?=
 =?utf-8?B?RjZ2dDdvdXRvaStOYVhmVlNpQ0NzOHhJWGE1SDJjcnZPOVBJL2FKVlVtRVRF?=
 =?utf-8?B?a0QxeW9rOHkxRE5QS2lna2E3WGxnenFuTDRHcGU2UGR5TlJwOEFqVUZ3cTdP?=
 =?utf-8?B?RkZCV3I5N29wRkoxNDRJUjhSRjNaMis0U2V2VlBFUmhueHJ4S3pnelk2WEha?=
 =?utf-8?B?MG5UQ01yTFFvekR3R3B3TDVhRnQxcHpIaVA2K1M2b0JsS1hiRWpadVZjNmlN?=
 =?utf-8?B?eWVHMnNna1p1bjBWeWh4RnNIV0FqaFhzbzhVeEtUK0Q3NlhOMjgzQ2dZa0FR?=
 =?utf-8?B?Zmd2WW9qSE5PME8xaWV4N0hqNFhTTllFWDhKb0tFWGRVcS83eStBd1R2TWxn?=
 =?utf-8?B?eGVrT1RZQkc1OW5FL2FkZnMzNmJ6QTl6UDMvT0d2SzF2bm9wMEtXR3hQeHVj?=
 =?utf-8?B?UTRUOEYzUmQ2ZTlzem5rM0JRRFJTZ3YzcG80Q0lzRUdVWlJONlZQZlcvRDBW?=
 =?utf-8?B?QzdlMjFBWTlwblNaQlkxb2tnTTRMaVdLZzFkUFdycmZNWWxpNjYzblBwNlBU?=
 =?utf-8?B?dDlmMjJLWnBvbTZQSjM5ajY2QVRRVkRBdk1WTlc1K1FZRTFKYjV0Zkdsa2Z1?=
 =?utf-8?B?SmpBWlNUYTF4OGpld0U4bmRwb01iMFI3Y1V3Q0toTjBHQXAxR3R0Vlg4NkZq?=
 =?utf-8?B?ZFcrdmNUT0hQQlFoNnRidTJ3cDl0bDZwWVRuaXJuL2w4aGM4bWh3bHhzb1Aw?=
 =?utf-8?B?ZGR5TDRiazJYMFlVN2NFSjk4T0lHdXRJQXIyai80QWI4bTVlb0x4VndkVVUx?=
 =?utf-8?B?VENVNjhiREdRNzZYNWVQeUkybUxBSE1yRVdBR1BVNTNyaGJmdDYzcElYa3lm?=
 =?utf-8?B?R1dsOHF4MFYvNkV5OW43ZmVlSFYwaGJuK1I1Y25CSDQxem5PMG1QeHhVK2Q3?=
 =?utf-8?B?QkFTTHJhQ1Vta0x1M2pncFcvdUJCWHgwWUpNZFBiU0Yvczd5UHVLRnpDdVlT?=
 =?utf-8?B?UEdrbFR0MDNXU3VYaENxOGVNODN4enMzWCtEdlhPS2ZjakI0ZmhSRXBoWE5t?=
 =?utf-8?B?R1I4RG92czYxTG9rbVhaelJNUUJPR3AyaUlCVFRLZVRLY3k0aDFEOFNxZDRp?=
 =?utf-8?B?Q2wwOGdMcHg2MUxWc2Fvd2RRTSsvM1kzcnhJT1lDMWRNRjh2UGgyeHY2dVJ1?=
 =?utf-8?B?YnFyaVZNd2xWejhLUDNFNHJ3VVFwNmh6bG9YQjQrSy9CMHord1NwRXk1anFC?=
 =?utf-8?B?QlovbGF5aXNvY0duVWhzNTZ6cWZTcWNvODhrOVpWcFRKRTVpakZKTnF2T0c4?=
 =?utf-8?B?am5IaVdZa1N2aHpiaFplVG9EdktXeDFIc2RiQ0VoQ0xrdFIzajRBTy9WOThV?=
 =?utf-8?B?Zm1aRllrNnJOdytpaFowdFNGY0krb01BeTdwditFQjlCZ3JRT1Q3czdSY0I4?=
 =?utf-8?B?TXg5Z2xIdmxaL2ZUL0kyRkM5bEI2Z3FWaGJtaklhRk5BeWJzbk5ITXNVSTlq?=
 =?utf-8?B?Tjhmemd5SUJ4dWsySGNraG5yWU1Galc4Smo5QWFjZ0diV24zaVk5TEFMSFpq?=
 =?utf-8?B?UEVrd1BMakpBaVo1Sm5odE5zSVZqRVdFbDVON0pEZWpacnFQRmJFVDdDL3dR?=
 =?utf-8?B?Z0EzMFpzL3UybDZETHZ1Zi9XaUJVWTJwejJwWGRJWHlPOFZaQVYyZVBoa0tn?=
 =?utf-8?B?OHdvalVhYlBEUjV0b2RqblVNMDY0dVdUTmRQQXVwelI2RlpocWo0WEtiaWRx?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0296df-cd4c-4b67-8a62-08db030d72dd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 22:00:50.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dveYVl3PjZTBPZfCbntzkzd3BKm/K6Y32pTlvT3s/uxww/AySTPXnmJoa+GP5NPDADpSMyDQbQpa2HHJVLrb6FGQBF/cmJORB+ibR+YxItI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5022
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shesha, Linux email expectations are to not top post, i.e. respond
inline, like below:

Shesha Sreenivasamurthy wrote:
> The re-configuration does not reset the device. It does re-program the PCIe
> DVSEC for CXL Device register (Section 8.1.3 CXL 2.0 spec Pg 258), register
> (DVSEC vendor ID 0x1E98, DCSEC ID 0x0).
> 
> 
> 
> “So you need to dynamically recreate the region, especially if your step 10
> above resets the device.”
> 
> 
> 
> Do you mean the DAX region ?

No, I mean the CXL region.

> If so, I can if the system stays up. After a few seconds the system
> crashes. Can the crash be because of a mismatch between DVSEC
> information with what kernel was informed by BIOS during boot (Some
> ACPI tables ?)

My concern is that the platform memory decode configuration is not
prepared for the CXL device to claim more than what was originally
programmed in the CXL DVSEC range registers. One of the platform
firmware updates for CXL 2.0 was the creation of the CFMWS (CXL Fixed
Memory Window Structure) in the ACPI CEDT (CXL Early Discovery Table).
That structure indicates which platform address ranges decode to which
CXL host bridges. Those windows are defined in platform specific
registersi (not enumerated to the OS). If the window is only 8GB then
the endpoint device can not decode more. You would need to reboot to get
the BIOS to allocate more host address space for CXL.

The expectation for newer platforms is that platform firmware define
CFMWS such that there is spare capacity in the address map for the OS to
dynmaically map more CXL.
