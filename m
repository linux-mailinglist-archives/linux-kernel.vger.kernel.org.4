Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647CE745E96
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjGCOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGCOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:37:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D394
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688395037; x=1719931037;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hhC+yDxrzOLlLOtP58zu//X5IF0C2SI1Qlp2WUuQcQc=;
  b=XkjJ0Uvt3W+WTwubpW0UhGNgryfCnlzCTJqkF9KVTPgLt33Mnze/B+uW
   11enz/KJ4ea9HR3YivRMhr/lqGusz1w0XCpExhxEgjklY3HjOn/DhzVAV
   B0Mnh8IW5fIA+qQ5HA0ngN01bbBxcMN5KnChNBlKUTmzHS+/WCWFS07PN
   wvzjVMqCJp4a91/CYdPGj1nCxNjXImI3CuZLHOOfaX0NzG0enGotu8jbX
   w08D07hLgBt/+QOi7ecCdtr/aNbz1kWkrEwzANWA978bGDv5WleoDA9o+
   65bPGoG2XzPLHxuSibZ8DWE7RzWgHz8o0FABOLg1pvVx96gMNsI2v1gQ3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="361755995"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="361755995"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 07:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="695832769"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="695832769"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2023 07:37:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 07:37:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 3 Jul 2023 07:37:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 3 Jul 2023 07:37:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 3 Jul 2023 07:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lw73f/Lplnd16TnI1FceaKX1PqALOoAlTxIaYQEzPPs8sctRiWCuhi5iyCj14mE4lkzQT+ikTL1MqTpLy3ubg2CePIY1UCmVfveMFclWLQ/SXzF2RfMJGxtK2DaI0HLEeauRULBIOXe3mlC2/AQWLNw37NDFEJ1pI//RJh381auulL85oK/OplkXOSECgAqQVt0JJjzIzTAlpLrxbIAg6bmdB5a7zjognFkCVzpM3qIyZfRmLbHrHMqRltRc11iLd2gqAyIyfc8XBTEbfX8aLHmKiFwuUob4qk4hL0lUjShsSKYVFBDpiugk9xLoTrrnzbI0eFEY8JCmjoj2ESXDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giq/h2g1bxpkkqUJrHG35e9V1HqmJYflA9bqmAVaYJQ=;
 b=SdhI33T6/RhpyBHj4WpQL7po0g8M9TLp61ANfJzwa+yOMeZFO3oZn0z0HGWzkumn53l34s8moACS4ptcKnJp5AGC0FDU4HILxfhQCVuhh2eeaeJV3ZJDEp3YHmbORvrUctIzW8YZTbxIbM+JCMQSy6VepsxsBkBBFIohC69Yi5vtzYRP68T0K4CFtV/++7g10P9QEM1UULMNtSx/dsxEVgtdnKtYMDkgJNCPhPI3VY5vBBy+CryyCSV/U9l3Lv4jL2Yzx6QWI98RT1nHmqjxHQP0ntQILG22ZNoJh/VWPaQH78+2wCwVkB9gBUgXsiHcxf8+oooU35uKooqatpnDhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 14:37:13 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::1439:6bf2:b876:cec5]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::1439:6bf2:b876:cec5%3]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 14:37:13 +0000
Message-ID: <4f18a7ca-3a57-0097-51f0-490f876831dc@intel.com>
Date:   Mon, 3 Jul 2023 22:37:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Content-Language: en-US
To:     Tian Kevin <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
 <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: f4af74be-114c-450b-2a4b-08db7bd2fd93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0utgKGkgujfumha96mSIi0cYL0EEjRd2Qb0U+GTYN1iC3iv0EQsjYRx9U5m2xWkW3FBUMoX6nQSAEzLH0Ze+dTWmvL1elNV8A7apn4pZGAYEsBWfI7pUrKKri1CT+LQinmCoX1gJk78VgFaVAX39nykG8PqdNwO+Edmi5wtpWGLJJakMSo/EEQPId31LhinVhrz8ePPVid5fh0uKx4l+v6CtlSraKTzyFs9QN8ToZ6rzN9Pfr4BOWz1beQIhDdvQYIzsLuaiSUEuS9XBy69lzXQPcW/p3L2TqSCMszJhJA0tUFuCR7ImFTQjsrPDaHTO5MF1Ht8i7zq8h1Jk13gtV0824GFNmKH+CXcSKMtuw7DoRORAzEUx6YCr6Jbq0pu+j/T8xK4uNx6RhJyY6+vydhy98cqi5PxZYjXMHQYWz1OLbYbvSqz80qHalIOaLGfRKwW/f9eT8hFI0tp1onuRohTT+OdK8IASdOaAvKCbnMKIb6Q0klGqxjUVGgIw2SphMEN6fmiGhQ9EB97a5kzt+MwcECAcUEGJgDkEnwip/SBhRwJoldfjBq7dZq0t0GuaMTriSs2oimfpeGXT5wM4dBs4LPAIQeAMHAjXPpeGxbV7EVwawBnu/AnDv7cBPiNSYepe3vwTkOA/kjIo7v93g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(26005)(31686004)(82960400001)(478600001)(6666004)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(110136005)(53546011)(6486002)(316002)(5660300002)(8676002)(8936002)(41300700001)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVZbURpOUZRZ3hxeDRmaUU0MWV4M3poSXhIdmw2UE1LVTdtZm1YcitLQ0h3?=
 =?utf-8?B?czdjaFlROHppZDI3bXprZ2tOT3F2bVpHMUpIOXBqL3B5WkYvNVZJSnhZMVdx?=
 =?utf-8?B?U20zbzNSUm1aUTZHREQzdTV2UXRWRldPck5jZGQxcU1yQjJScVNITDFGVWdD?=
 =?utf-8?B?ZE4ycEgrV2Ewb3l3ZU1WMFZqRjJWSktJZDIwWFJxc2U4K3QvNkkzVzJjOFpK?=
 =?utf-8?B?d2xuUnJuWDlmdjVXN3RqVTA3eWZ4bTdVR0ZUWmZCNjJ2OXFoMTBNSU1kTjRQ?=
 =?utf-8?B?WmlFcEEwUFRrN1RHUkJtdWZlWWo5Y2NPc2diMmhKcFUvVUt6QlNKRlRaMWw4?=
 =?utf-8?B?VzBJeXdMUG9IUEp5SUc2emxSUFhFYnFLbWlJKzMyTDRiOVVIUjRnQXhzQmta?=
 =?utf-8?B?b0ljTGxCYmFyZTQ0aFgvUHdaWHVrcTFzc1RqSGdCdHBOMWRLT1c0Tmw5Mmxy?=
 =?utf-8?B?NTZIS0N2Q2N6bzdFcnhaR1ZKQWxoRUMrQmtLV3FVNENTWkRocGdxNUNxei9W?=
 =?utf-8?B?aHMzSWJ4WTlIMC9nU0dYUjF2VDY1aHZDbVVjNFlKNVBVNkdkR21oL0tYS2dm?=
 =?utf-8?B?WWljUDZYVEVvRllVYnREdnhqQ0dTVndtb1Vub1VMUzJySXpXb2tVTzFDRVEw?=
 =?utf-8?B?bFY5aG9PSC83azdqNTJlTlh1Z3BvWHpvTjFGeUo3VGQ1TkhzSkxydFdCcGZE?=
 =?utf-8?B?ZVlhY2JVRXh4TmVYTFJlTFpuVGJlWk45UGcxMDFCYzN0OFExUzFSMCsxbWJD?=
 =?utf-8?B?UHFlbW5TMHJaQnpqMC81d1VXU2xHeEZaOVQ2a2tENm9EWmpVOGZKTElRUU9M?=
 =?utf-8?B?KzY5RnVqbWVHV1VwWkc1RGJOQSt4eFVZdWFJSkE4TDRUUmhWSUlsYnBDS29z?=
 =?utf-8?B?MW8vcGFURyszNEN6eE5FaVd2aCtGa2hkeEpXSEpQMyt5VXRRL1d3bHU5Q1cw?=
 =?utf-8?B?TndLazRjczNackRhUHZwSFd1MVBCWnZ4VTlMM2hiNXhZenU5dFZjdTNrV1Mx?=
 =?utf-8?B?ZUpUdW5EVllhQkRldmpZekNoZnBLRnNnNVBZZ1JqK3NSNVh0ZFN3S1dPZmRK?=
 =?utf-8?B?Rm5xdmZpWUpsVWV4R2tJREhXbVBkYVZCcHhFdHRiaDYzOWd2bVVVUmtGYlZ3?=
 =?utf-8?B?R1llQ2ZsL2orZVNiUlBFbjdMbXZneHhHenEzM0hHenVYRURMcEErV1lsUEta?=
 =?utf-8?B?UDBCUHF4Vm56cVFqSVpKaGFXY2FhZlh6UFJZNlhoKzI2QnNPSVoxYmhtWDg2?=
 =?utf-8?B?L0k2QllVd3loNjVhSWlqTTR1N2NiNHFoc0hoY1Z5MkJiVmtEZzNlZERyQ2lq?=
 =?utf-8?B?S1VTUTNIWk53ZmFYNDE4TkdUalZHVVhOc05jZW00ZHVpNkEwWkphZC8rOXFq?=
 =?utf-8?B?NnRYbmVJSldwSTZqSC9MWWxGSzZpWmJqcTM2alJBYnFhY05tYU95TjVWT3NF?=
 =?utf-8?B?ODRqdzkxWXpCQWo4RXVhUVNzdnhFWFRpWm42cU85cFkrRlc4V0hXZlllUjRV?=
 =?utf-8?B?Q0had2lpMWtlVlRqc2NSZ2RIYjNVRzRRRVRqbHdONDVpdC9haTV5b1I5YlYv?=
 =?utf-8?B?TzE2dU5xSkpsWFZlSlNQRUtJNUc3dXZEL3NJeDExQis2cW9pZ3Awb3NaRHU1?=
 =?utf-8?B?aFVaV21SODBNN08zSmk4RElwQlZqY1hxR214SlUvWk9haUlJRVFFWE9zaHRH?=
 =?utf-8?B?SVNZbzBzNjFubDVvZHlBOUNhdTB3bS83Y0x3N0J1QThyVDhHdXdETHpvWjN2?=
 =?utf-8?B?MDBJSjZ6UTB5U2wxQWw1Yy9FMlFiWFRaTytqdUVDWWhZemRWd1pVT2YvVVhP?=
 =?utf-8?B?SWkzM0RCTDFTb2M3bUh4SUFtRFUwWlYvOEZER0pYTlRYOTFhdnBPQzI2TG1O?=
 =?utf-8?B?TW1tWmJZeUVhdFprWkRRRTVEQjZFeUNOU0J1b3JBU2JNaUo4TWFBWm5TNTBB?=
 =?utf-8?B?NkdqdFR3Rit6bWhrdXFzN2xZMHVvYWtTdG95UzAxRXNYaks5SGVpdUJ4YVBV?=
 =?utf-8?B?U3p6WUh1MHA1bkgzaFFXUUt2QVVOWjFvM3gxdkt0Yk12TkpVaHNRNzVvbEQ0?=
 =?utf-8?B?RWlESlRnVFFjQzFHNjM3Q2llVksySVZXT25aTmVsMGZuTTlScVJPYXgvYk5k?=
 =?utf-8?Q?3d4Kn4o2ZCOMQqKFqWeRIxgwW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4af74be-114c-450b-2a4b-08db7bd2fd93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 14:37:13.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55Fn+ZXLIAaN6QT5hRy9q3zE2nOcB4oXxoKuRG9XRI6F/ZvF4Yzzm+55o6qrSp/IgOI7kOGyRGzT4g1Qb6JQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/2023 3:15 PM, Tian, Kevin wrote:
>> From: Liu, Jingqi <jingqi.liu@intel.com>
>> Sent: Sunday, June 25, 2023 11:05 PM
>>
>> The original debugfs only dumps all IOMMU page tables without pasid
>> supported. It traverses all devices on the pci bus, then dumps all page
>> tables based on device domains. This traversal is from software
>> perspective.
>>
>> This series dumps page tables by traversing root tables, context tables,
>> pasid directories and pasid tables from hardware perspective. By
>> specifying source identifier and PASID, it supports dumping specified
>> page table or all page tables in legacy mode or scalable mode.
>>
>> For a device that only supports legacy mode, specify the source
>> identifier, and search the root table and context table to dump its
>> page table. It does not support to specify PASID.
>>
>> For a device that supports scalable mode, specify a
>> {source identifier, PASID} pair and search the root table, context table
>> and pasid table to dump its page table.  If the pasid is not specified,
>> it is set to RID_PASID.
>>
>> Switch to dump all page tables by specifying "auto".
>>
>> Examples are as follows:
>> 1) Dump the page table of device "00:1f.0" that only supports legacy
>> mode.
>>
>> $ sudo echo 00:1f.0 >
>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>> Device 0000:00:1f.0 @0x105407000
>> IOVA_PFN                PML5E                   PML4E
>> 0x0000000000000 |       0x0000000000000000      0x0000000105408003
>> 0x0000000000001 |       0x0000000000000000      0x0000000105408003
>> 0x0000000000002 |       0x0000000000000000      0x0000000105408003
>> 0x0000000000003 |       0x0000000000000000      0x0000000105408003
>>
>> PDPE                    PDE                     PTE
>> 0x0000000105409003      0x000000010540a003      0x0000000000000003
>> 0x0000000105409003      0x000000010540a003      0x0000000000001003
>> 0x0000000105409003      0x000000010540a003      0x0000000000002003
>> 0x0000000105409003      0x000000010540a003      0x0000000000003003
>>
>> [...]
>>
>> 2) Dump the page table of device "00:0a.0" with pasid "2".
>>
>> $ sudo echo 00:0a.0,2 >
>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
> What about creating a directory layout per {dev, pasid} so the user can
> easily figure out and dump?
>
> e.g.
>
> /sys/kernel/debug/iommu/intel/00:0a.0/0/domain_translation_struct
> /sys/kernel/debug/iommu/intel/00:0a.0/2/domain_translation_struct
Thanks.

Do you mean create a directory for each device, whether it supports 
PASID or not ?
Seems the PASID can be assigned at runtime.
So it needs to support creating debugfs file at runtime in IOMMU driver.
Looks like this requires modifying IOMMU driver.

BR,
Jingqi
