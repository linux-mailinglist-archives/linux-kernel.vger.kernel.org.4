Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD16F8CBF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 01:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjEEXU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjEEXU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 19:20:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397F165A8
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 16:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683328823; x=1714864823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZsjdUT78Eap4+UFprGvm1gppmznIdZQAk5yPglh5j0Q=;
  b=b1jqEc6eY9xz1If7IPMw3BICkEemLeNMuR4vVOuhpwAbd4LgAKGMimUz
   vWmii4+EO4z1G5AfsCf0vLt0jQavfoMnWi9K/iR1wsKcFfDOZiFQ/Ml7e
   yqdZUA1Bqf5vQbXtH46KbzHwHm0H3cZXIjpaI7THL+k6Ims2mBxJh17Xv
   qlxFB6EdG5RyQT5zflZGCgJ26DKPmEo6xjFux/9pvkiGtMXwUzT9ykXLi
   RGc2G1C7EvJroPkDdoqdKivhuMx1NubBn4SQcK8Zu5KyVDYt19zSXVX/g
   Q5gzlUX1BpggmXs3OJR67p3z+MhkpyQjuiZdYXgP23t7FstihRH2siDqw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="349354923"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="349354923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 16:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="767301597"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="767301597"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 05 May 2023 16:20:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:20:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 16:20:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 5 May 2023 16:20:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 5 May 2023 16:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddf1ffzzuESWzx5QgPDSTIlUPrOK+M+A5cOh7xwpOalVFTIffHXWQhjBGqNWA9cu94VbSL9IpWrjIHniStQyJARnZjK0QV1CTflQMMZ50QK9VGahYXZvzzcKrQXNwigP4PNwdRraClKghZFFa3zY3DVRUiJxjZhfFXcXkC095eHCmFnnuiNC7YaZPa/kUONnTHPHmPLEIBdNmqeM+eFOCb/K24MfByQ1m4Y2rwmZFpfeq1mZ0LEqHaF9uTbiLTQuT1ZAmoH+l6V+gEtCu+zCv8p4NqMu6Iq6UVxAeXn1/m4teROMU5jCE6Q6tCnoPwIjk8mRPXfdlpfi0StKFioX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsjdUT78Eap4+UFprGvm1gppmznIdZQAk5yPglh5j0Q=;
 b=lWpoxxPLXrJ1ARmNrLWApnPjVXbutAu0212maVaR4ND4D746/pBUUFdn95X3YC6bkyF0L5XzTcB7nJmlkK3XbFC2pGdBUkuykF5jmvjmz1kxI+eoJL7c2RhU1qtsCc6xb7sYqb/EdYVUzFnaO6VQumktJVgx9lOaUAj8cVNsqs6ircFwwRMXN5Z+bgAOyff1x7PsHZP91qBzscwrkK8nDebqXTmMg0Bx5GEy6tKOHbuivnH3PpWErfirUulqTIAqlF8bGt+5v8Xa/QJmhP7ut9KFg/xd30ZrLxcxMQbbfxYNN4LfG8aNC4TcuuCOM8WM6Qy5df9CId4Fdq5WfXQzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5953.namprd11.prod.outlook.com (2603:10b6:208:384::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 23:20:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 23:20:19 +0000
Message-ID: <27fa0193-e379-6471-96a0-faf2afca5f11@intel.com>
Date:   Fri, 5 May 2023 16:20:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 4/7] x86/resctrl: Add capability to driver
 registration to create control files
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        James Morse <james.morse@arm.com>,
        "Babu Moger" <babu.moger@amd.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230420220636.53527-1-tony.luck@intel.com>
 <20230420220636.53527-5-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230420220636.53527-5-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 549267ca-f017-4803-ddb5-08db4dbf4b15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3xY5H4BKZ50etmn08Ho8Bw7l5FBe6ob0V4dgoXMvKzX66dwp6AFz/PRzl6ELrUkkgxQHVlE88oxD5izOzuvubDo/4cVK3YzdumVssIeBnKXYEoJN64YL7VZIbh1krp+m5ZTmSmo2zJq/7XDKgSfN26UJSNqCMe/3SLkw15ZSTaU7lvcnkR0NNJOFtevNeq96HsHhHdhTkU5iKzn5k0PjQXCxrO/+jZENTGE7kou0gzsKlALO4pGfIAONgJ+ZA572lzC6k3ocmch4UMoKrMfvcHiJvRpGCZHqBxTRNs8atr+GXeV5nJnAXQlf/K7GoMXRAN7nUX4kXWJEEPcLjJhiLDzDJr44+BXy37iPnjxBL2NO7emSB4nsyvrrVQCHoHUrqNQKd7+Fq0CxCtXL2BlHA1mWRBaQCbtIcnMNEfFAkyCIhvjxyUBrGggMTdjmka79SwRUTKhfODKcMmFXAMnfxapqhLPpm5Ep4FVHHltFUk8m0POZ6qTfPyi8mN/Otf9OGnyMXr6lrLfwtOta9p94IlvqT82iZCHW+3oIlC64Ri9Tm9nmt39lhGkIRWmNDeTrb+h515zummizTfXXsiu+tpXZNrExPY9hiGPgXMfYsyYDVQS4skPYook/O6OAlmEB6UEnuM0ulaOK3AFmAXoaGjXPaou8BzSpv7ALWh+Zqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(6512007)(53546011)(6506007)(26005)(31696002)(186003)(2616005)(31686004)(110136005)(36756003)(6486002)(2906002)(82960400001)(316002)(8936002)(5660300002)(478600001)(4744005)(4326008)(38100700002)(7416002)(86362001)(8676002)(44832011)(66476007)(41300700001)(66556008)(921005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVBWjc0b0RSajFleFZLeXJPSGkvWEVUbGxjcjA1ckk1cWlxdWk1Q1NNNHFI?=
 =?utf-8?B?N0dpd0RiMXFZSVZEN1p5Um8zSm1oTCtZUVNGV2Urd09RMXJmc0JicTNHb3dF?=
 =?utf-8?B?dFRSS3VxRjlwK0JWZnN2cDJRd1RxV0NPY1QzY3M4VGtkRFFmcFQ2ditmNjM0?=
 =?utf-8?B?bnFiQmFNV0s3a2JPbTN0ZHNqU2hLMjEvbll2TExUWXhyMmxKWE1iU0lucDJv?=
 =?utf-8?B?WW4vaWFDa2dQcDZjclNBM0NEdWpXandYNEVoKzJ4VEt5VEloWmFEdHRqS1pk?=
 =?utf-8?B?UEpCcFBod0VXMmFmY1ppYWo5d29BbVNOU3pZb3hBZ2QvZzhLYmNOS1liSjA2?=
 =?utf-8?B?UWRUWXBoRjE0V0x0L0t2NTIyODIxTHBNanRoemVybktsd1BmWXV3aDRzZnRP?=
 =?utf-8?B?Nm5UTG5aZlFNY0p1TjNMTmJiRWxkSnpUWURHc0FOS0lUa2dKZzBFRVhUSXVz?=
 =?utf-8?B?MGRxOFFHMTF4eFZPKzZOUlRCMUZqMWF3Q1N4blN0bUEvbzN0MDhibmFaZVd6?=
 =?utf-8?B?U2hXZFp0VkRjYWpmdWVsNTBsb1ZUVkh3emxCcVk2TGJodGdVNzQyWXBkMmx5?=
 =?utf-8?B?cmZCOWduemg0bGl5dzd0a0tTeUFCWXRCWUt4bmFWWUhoZEpnbW4zNmZKL1pq?=
 =?utf-8?B?cmdqQmFNUHIyMjZVajVsbGEyODZxK1JvTGtjZHpDOCtkd0FHbXNDdmdqek91?=
 =?utf-8?B?amtMNWlYTDR0TGFtRzJsZmI0dENkOUJVbE02bU5MZ2ZKc3N6U0ZPSFFJSXdT?=
 =?utf-8?B?QURmWkJrZjlIODZJeW5DUkZSRDhDbDhKdUVvdnBJeUxONndtWElrV1lpRGRN?=
 =?utf-8?B?OFhzdWltUktGRldpUFQzWE5MM3VxbVVzWFpnS25LQWxaZk4xRDN0LzF0bFVX?=
 =?utf-8?B?SG45WTRxbDI4YjBDbmFuYWw2QncwVVVjYXVuU2daNW5XcGlxZVoyZUxHcFlL?=
 =?utf-8?B?dzdMVC9uZ1RiSDZRaWF3U0RCMXEvVXQwUnBUM2U5eE9aMnE1bjVyV0tIQ3Fz?=
 =?utf-8?B?d0JPeHNxZWI0Wm1WdllSQnNtQU9LTXlUOTlkcVptalBkQUpHaldVRE5jbVBa?=
 =?utf-8?B?WVlMdzZNYnY1Q0h5MHNGa3F4NE1QMzZPdkdUMENteURaOHh5WDRoRlpkSHJ2?=
 =?utf-8?B?cFB5NXlMU245QmJHNDVSblRCcURqQ1l1UGlxdzZOSGdmbHJtL3Q3Z0dBRHdT?=
 =?utf-8?B?bWF5UmJaR0MweGg5bHk5OERFSzRLZHc2UkdDamNocmRwemRtSU52VkFFc3c2?=
 =?utf-8?B?MGM5aVNKRUw2S0YyYVFGeW90VnpycnJiYWh4OEVTcXhuSGxNTG1oRzJkNlRl?=
 =?utf-8?B?UjN4ZGdJaThyZlpiVGEvV2RsYU8vN2ZTUk9QaGhHQzZKNmhldTBNdVpqUFJa?=
 =?utf-8?B?RE5KQ1F6bHRXRWUyTHp0c2wwYmdReHVScU5JcTk1R2M1NSttV3NVZVo5YWc3?=
 =?utf-8?B?QStCTUZBWkRrSkQ4SW1OekVwakloZGQ3T3VHamFQNVlXaGFrYXBQcUl5Z1l4?=
 =?utf-8?B?UExmcDhUdXloRU9lVS83d1JGdXUzbVNDK2lLZC9yWHpnYTZvUFRabHFLckxP?=
 =?utf-8?B?bkZUTkYrYkVzUGhtUXl0QXFOMzBKS1hkU1V3MHppakVIeFhENkNTU3F6d1g1?=
 =?utf-8?B?M3g3cFNvcUxKNkQwWjdUaGxYYVdRS2JzZ2ttaVhTd1RhV1hYZWZsQnIvUU5D?=
 =?utf-8?B?ZUkyUGFBdG1Ya1ZjKzBVQkNDdzRLTEp2Nkw5aUxyanFaQXJiZzU3bXlqc0JT?=
 =?utf-8?B?MWFleXUrTlN5a05LNytsWE90WEVKd1RlNjlDckNmWVA3eTNYVVNnSWVqVWli?=
 =?utf-8?B?bUtIZVFJdU42b2ZnY2w1TVlWQ09Bak82R2pnR2g1aUhycmd0cDlmUEM1aDFq?=
 =?utf-8?B?TXg3N2tDNzd2Sk1IZ29JQmJydk4xbXhDNFBmVWp0RERsVGkreFRYeDFoMXhk?=
 =?utf-8?B?ODRnWkt5b01keGx6ZFBhYWMwRFZHSUYrRmZsaWtLYldSdHRRQVJzR2U1WkRC?=
 =?utf-8?B?RkVXeUwyMzFCNWJ2ckdxMHpWTGVUOVM5eUl0MW8zMHFGQzVWUlg5VElFb0tB?=
 =?utf-8?B?R1BFRXhQMkI2V0crN3VnQlZ6WFYvMTBNMTA3WEhMcVNxRmp3TVYrZU9GTkNQ?=
 =?utf-8?B?UEMrLzg4dkNFd3JYVHVOYy9MWmlLR0RaZnduWGd5ZWFWYlIrM1d1M3hxUnFj?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 549267ca-f017-4803-ddb5-08db4dbf4b15
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 23:20:19.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JofVOO4hT1RRfej5PBRzOwuXx6OK/DKfLdQv78gfoJn3+cXVSMI2tqyvzyTRpDnBBYeJ7zEeTqOQZJ88P0OFHiyPZCtbYxwkBIpUIDuqcbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 4/20/2023 3:06 PM, Tony Luck wrote:
> Add a control file to each ctrlmon directory. Hook into the mkdir()
> functions to add the control file to any new directories that are
> created.

I assume you mean CTRL_MON as defined in the docs. If this is correct
the then the implementation appears to be behave different in that it
adds files to CTRL_MON as well as MON groups. It adds the files
irrespective of the group type. Is this intended? Please do correct
me where I am wrong.

Reinette
