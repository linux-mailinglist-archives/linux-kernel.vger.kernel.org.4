Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F869FE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjBVWHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBVWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:07:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17D42BCB;
        Wed, 22 Feb 2023 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677103662; x=1708639662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WyERvAl09Qsenvgg4DF5BJYWcb4U80F204CFqgPJN5M=;
  b=injUEHVkfbI6cNwLT9kkiGGvj0hwKCfc78QV4KtLBC6hVGZJJXmo2b05
   uC1vDcsvfqSZfYmrdm1E6fyOnbN46GGGixKFbGE2mJtNlP5qAryR3mXju
   OWnmAixevwn0eZq3xOQP+zfjForh7ioDUIev8lgPAk4V18bZ0PUohib2v
   HRLt/kq4nRP2wGXn2B8T+Tp7PbKLnqJ4QSaY2SIve8uLy+rFcpYqOClu1
   o97lDzHei5Nrm/vR3hNSb287HXxdeE0ipVw+RBpsYgQqd5SJyJPq+WVcP
   7lMt/c3E7jYhxaMPl27YLY0AhuaDSo5bhmQ51u6UBEvuQlpdvq9ap+X3C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="330777355"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="330777355"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 14:07:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="674261620"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="674261620"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2023 14:07:41 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 14:07:41 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 14:07:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 14:07:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 14:07:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1mThly6Qg2tDz5JVns8Ij8ZAs3Z2Z5wT0ZLkM9ScFGMSJPL0b+P98+ecXtVH28okWC4Ux5b5cy2108YJLDx6SftiLjg2bwxPV/GMzytSlwhAwwTGjRu5UraLu6bWa00WsIuSuDLKqHJkgpur5CTjbxfd2zzbksWVjj1gDaVkKua8vMgEVDvKNcOZI6hfcbdCwsipPQ+qxsdHeFNQVmQPCsE+rp9D9lohgfUa8rMAMZGZtOdL33SqhksM+ChhIpzshOQxZimSwDQisPPoARg1YFUN1JYoSh942ScxK6WIj8qAOgmqNMjfytO6AoKFdhJ5g1TWBVDcFbdISWn1JY/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7kEuVua9oy4MHeXNNcyukxfb9cqV62AZsAKbOVrmLg=;
 b=ivr+LaI34vYgWkeReOaYTYn85m/6l0u3sX/znOOpJDA7JbpW0mwtul4XQRg3tbG871Wbt3WU6AULH8/d59oAXBhj+cuzewWiSIl0Sq0SX4/YzbyIaJxfg6zB8+VJYKfhpAJki9wvudCSA67IrikIGvrMmEhSk7aymVw5qILHMOlAvLgblkoa/ww/Fh81M+jL2LTXwaDhQJfhlmgYX+TISqpe1uQ6cSJAE9JuP8fBGS7VuMYWovAhZwNL+6Hq69ys+JImcMJXyThHJcX9cGwtGW00vcGIu2edc7knL2a3H9Qt9nCRHe1s4LqSeKY9n7HHceF3zIqw+YiOxlzxLAZDeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MW3PR11MB4601.namprd11.prod.outlook.com (2603:10b6:303:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 22:07:38 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6111.019; Wed, 22 Feb 2023
 22:07:38 +0000
Message-ID: <42ac85ea-0ffe-55fc-57c2-6f4555e8dc5b@intel.com>
Date:   Wed, 22 Feb 2023 14:07:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/7] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>,
        <ashok.raj@intel.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-5-jithu.joseph@intel.com>
 <a24c65f8-978d-8968-7874-6b83e14b01ba@intel.com>
 <d9d18954-8434-4c85-88b8-8e1d99cd6a4b@intel.com>
 <dd501d6a-e7e9-be82-24fb-33b18fb6192b@intel.com>
 <b67d2125-4075-4eac-4cad-8e315b866144@intel.com>
 <5d57f42a-1bfc-5e6a-bb49-556ecb7402af@intel.com>
 <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <9c55a34b-c17e-2a62-9989-902ce940dde5@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::29) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|MW3PR11MB4601:EE_
X-MS-Office365-Filtering-Correlation-Id: 465838f2-a779-476c-e031-08db15213575
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5tVbcmRHoaCKlRcMz9p0DG6iXd3SDFkt7FUIQ3T+HRawGMLPijMVotREeaU/1xS0XTz2cRygyL+cLMItJq8KnGb+5dRyMLJofSGjZeb+iO2nuMILwHQy7JJLyjOZMq7ZSWmDhW98gaqNfWfVaYM7alVzfDFMHyaakKYEFHczhtvk26+8rqVdz+I2K/2xPwFQDAoeBWKeVkEYfUdH3InbhQw/wCdz8FX/y7xeZ2Qt1z3IRVtBX1Z/3LCc+eJp9Eb6M0q9QHBqxguvRaxOEqOmUx8EG8IZkbc6s8jMKfNoEusnAIFQX1dZ/SxYgJe/1AgwgS2QH/yAdBF5uQA1hoIeBS6vGCsR166ikzu3YfHccTLZo1r1mqJPLIKxDRbvlxtDZ5Ho6Vm7DjHrlBeBoJaK5e2/VSFFAk29rLDzkuvUBxcjawSv/Y5LHVzL8iyVxiQWRguZdm+GPNgrtkVxoY0RB0HWZRXtBTVKY9d0g9wLEN929dwp9Yaa+T507hfQ1cKi73uoKlXS1rV+sdH9PPMrjIME9GB+9YCtZpL34XLSSuPMIZRE6rKSM5Ptx8rgXypMTURm4xPRuvlawiwVHflol3fPizZMPOKskj1JSlbYjuKfyT2UUjo0mkNEUGnyXO0crinhisu05qMJakLCVkATLAQmSFb0lZWu7KNON80jUQUVKwNhyYG0KlXif8uhpyxncog5m/CW2BpOKJhtRmv6GJxrbheRVSYIkWTqfhAbiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199018)(36756003)(83380400001)(6506007)(6512007)(186003)(26005)(6486002)(53546011)(478600001)(31696002)(4326008)(8676002)(2616005)(86362001)(66476007)(66946007)(66556008)(7416002)(2906002)(5660300002)(8936002)(41300700001)(82960400001)(38100700002)(316002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTNYdDdsY2FVVnZ4N0NSSnVPQUMzV1dxTmhudzNyL2pVRzgvVlFYOGI4Tzhh?=
 =?utf-8?B?UExta0JMdDRhV3JMRWVGQnQ5SG11bFFnZEZleVk2cW1Sc0RZNk5oU05BRHdC?=
 =?utf-8?B?QWZNaENRUDA4RjJmMTNqR0tHamlTS1hUZFhTRmNFaWJIRnM1cldGTzJaUFFH?=
 =?utf-8?B?c3RVSlJ1TWV6L3FMdlVmNkNBaS9zMWY3WGdPMTV0UDNGbWtzOU5XUVBYeWJj?=
 =?utf-8?B?a0svd1gvcW4wR280TWdjODIrQjdoNU1BemdBS09MTUZ1YWNWZm52bTV1S3ZV?=
 =?utf-8?B?OUdEbXNLcGQzM0lOZSthZFFvMklyaFJZalZDcW91dithaU5leXc2U2h2U1Rw?=
 =?utf-8?B?OGJXWmdkaG85Qk1LdWUwWFdWMXl6UHF2TXExY1RZK0lBYUIxZHFlTkRjZnBu?=
 =?utf-8?B?RHczMnM1RjF5cXNyQjUyRzNNbHl3VU1BK3J4bGlQMHVhWkhDdzZmT1FzSkxU?=
 =?utf-8?B?clhpSkpXUmtoSm0zeW1zb1A0cHFJQUVmS0oyNkNMelE4WXE2aDczbHZ5cjMy?=
 =?utf-8?B?OGJaVjFsSnRUaHovWUtkeTNqaEFMWGltSGhjdVZUbzR1bDB2bUwvY09rTjJK?=
 =?utf-8?B?cVRsc3pSZVdsZjdKTGJsdGJMNURsK2pTRFZEYlJMQW9maGpmVWpaeFJnWTI5?=
 =?utf-8?B?SVRJejlMbFdHVS9SQU92T2d5Sjl1NmgwN2htTENpcm9aaTk0Q0dscUJiRjR5?=
 =?utf-8?B?bGdmemhQSEdDSVVIeWl5RW9uOTZPRzUwb1lQbTN6SWtCZUpqS2JHM0ljWGxW?=
 =?utf-8?B?YlpwSVMxMVhuOHNNN3E0KzNneGh5dlRkRTdRa2tBb01kR0xicVM3YVk3THho?=
 =?utf-8?B?aEpQOE9ONlJoV000UDF5WHU3bGZNRmRzUHczcjhXWU9nQ1VjZkhlVmdZL0Z5?=
 =?utf-8?B?NS93NWk0WTROSGpMdDhDZFdGenJvOU1IUDFGVzdBU1hwdE1EcEIyRWZDMEl1?=
 =?utf-8?B?WHBIUUpPdHN0a3hFS1RaUTJPNFRockhLUDNTMHlHa3krdWRHbVh0N09EK1RT?=
 =?utf-8?B?bU5qMURvaXk0SDVqc1FGUG9VNm51d0tOazZ1Q2ZZWGsyYlk0NnhIc2ZZalg3?=
 =?utf-8?B?SkFXaXRFRUNyNExSMy9ROGF0SVB6YlA1eEF6RUdPNnJHRFE1eWdPRFMzcklh?=
 =?utf-8?B?VEpLTWdvUklJZ2JZOHp5c0VkekxjaHd3dDU4bktEKzdMN0lscktxTDlyNEhy?=
 =?utf-8?B?Q1Qrdklkc0pEM1FSTGQrS2doRzM3VEdodG4wYU8wNDkyYUllY1YwYUc5c3lS?=
 =?utf-8?B?MjFwNzJ4cy9QTmQrN3YvcSt5cXdaRzJQNStJYlh4L3VidDBienlQWFZ3d3pz?=
 =?utf-8?B?bE5PSVc3L0Fta2laWGVWSzRKWkR1c091cDRoRDFpa2svNXVKcGZPUEtqZzNl?=
 =?utf-8?B?WFNabE50cUdITjhQMU96WjRrcHFhdkRxY2UxUHB3OExodEpIVmJJOWRYUDJR?=
 =?utf-8?B?RmVYc2NxV3NtR20yQ0tacFBWY0lJcTNMMmJtb1BuNzIyUnVOYjdhSnl1RVpV?=
 =?utf-8?B?TjZJd2VTeVRRc0VxRUF3YkRvd0F5c0JZbjRsbDUrYWlOQ3lwSDl4ZDhsUFJX?=
 =?utf-8?B?V293ZU1HWXFWY3d0alFRL2ZXZUgvVTFYSFJSRU9YaS9pTzY1MXZGU2NXbEhG?=
 =?utf-8?B?MWMwTFU1blJ2YnhtRkF6S1pwUHlQRGN0aCs3VGh0ejMyVEVnbmpEUlRkcmZ4?=
 =?utf-8?B?TTRKZ2FxQ3p2ZjY4MW5VeVVrVGc5Q09ZLzhmTFR6Y21DVFVvSGNBRzFxRHN0?=
 =?utf-8?B?SzVaTHNkcnE2dDcxWVhDa1FYckJuNjREUEZsQ2NoblVtZS82VGZvUTB1aDg2?=
 =?utf-8?B?TEMxS3JvakJuVTYvWTgweGMxUUdvR09HOWdPc3dqRUphUCtRcWc3NTgvRHlQ?=
 =?utf-8?B?MDRhNkZpVStTOFdMSU56a2pXaDhpS3VNNHdKOXplSk5TandMWW5xTE5FaWFY?=
 =?utf-8?B?c1JFUGtNMko4eEJBMm5qd1NVTUVHQy9WYXV5aUZpamZ5aEpDd0RqU1VuZ0Zy?=
 =?utf-8?B?VDIzcklqUzczaEJRZmpNamVwa1ZGOUp5NDhPcm9OMk14WE5ncHVnUkhHa2to?=
 =?utf-8?B?UzZ2djNzUVBDVzlqQXdWeHh4QnMxOUFCekx6MTc4Nk5CdURrbEZMSFdBU2NL?=
 =?utf-8?B?c2xrZzkyanN5azgyNFVQMHVvVHJGRVJBT2lNVnkwOTJSS201bUovaDZVVGsr?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 465838f2-a779-476c-e031-08db15213575
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 22:07:38.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC5IUVs82fPDMTIhLxyxohGkBw8clkrbwReiYFqNB7YrDeESroWJtjmqX3+jKVe+bQq+cWoJ9eH7HrfB5IxFDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4601
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/2023 12:12 PM, Dave Hansen wrote:
> 
> I actually really think this tracing should go away, *ESPECIALLY* if you
> insist on dumping out raw, non-human-readable MSR values.
> 
> I say NAK on the tracing.  You haven't convinced me that it's necessary
> on top of what we have today (MSR tracing).


Thanks for the pointer on MSR trace. I agree that setting the appropriate filter ("msr == 0x105") would generate the read and write values (snip2 below).

The primary value addition for the custom trace added by this driver was readability / convenience (snip1 below).  The format it is dumping today is most convenient for tracking  the progress of this test  from start to completion. (Two formatted input fields (wrmsr) and one output field (rdmsr) on the same line ).
Another convenience is that, by enabling the high-level intel_ifs trace,  we can see all  activity related to all IFS tests (and not having to explicitly remember and enable the MSRs corresponding to each of the IFS tests)

Since the trace has to be explicitly enabled (I thought it is okay to add a more convenient custom one only to be enabled for detailed analysis when required).

<Snip 1 added by driver>
     bash-9411    [123] ..... 423555.355664: ifs_array: cpu: 10, array_list: ffffffff, array_bank: 0000, status: 0000010000007ff2
     bash-9411    [123] ..... 423555.355858: ifs_array: cpu: 10, array_list: 00007ff2, array_bank: 0100, status: 0000000000007fe0
     bash-9411    [123] ..... 423555.355891: ifs_array: cpu: 10, array_list: 00007fe0, array_bank: 0000, status: 0000010000007fe0
     bash-9411    [123] ..... 423555.355923: ifs_array: cpu: 10, array_list: 00007fe0, array_bank: 0100, status: 0000000100007fe0
</snip1>


<snip2 using msr trace>
   migration/10-76      [010] d..1. 423672.955522: write_msr: 105, value ffffffff
   migration/10-76      [010] d..1. 423672.955525: read_msr: 105, value 10000007ff2
   migration/10-76      [010] d..1. 423672.955733: write_msr: 105, value 10000007ff2
   migration/10-76      [010] d..1. 423672.955736: read_msr: 105, value 7fe0
   migration/10-76      [010] d..1. 423672.955783: write_msr: 105, value 7fe0
   migration/10-76      [010] d..1. 423672.955786: read_msr: 105, value 10000007fe0
   migration/10-76      [010] d..1. 423672.955819: write_msr: 105, value 10000007fe0
   migration/10-76      [010] d..1. 423672.955822: read_msr: 105, value 100007fe0
</snip2 msr trace>


Jithu
