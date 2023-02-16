Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916AF69A0C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjBPW5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBPW5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:57:47 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D144BEB5;
        Thu, 16 Feb 2023 14:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676588239; x=1708124239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vCjfFXXsh/y/hX2LkfD2jTg+orCRDE7EfnDJgODr3hA=;
  b=kqFze1W06fwBOCoyfZ2E0S2q70C+sp1tuhpDouGVBzaua1dE+d6uEtSm
   n+5/LaRTWYtHF5jcap2dyHUYN6vRih4NRAodzgidGP2KLX4JJrbSf3ZI3
   vhwXPNFwsM3L4pCgqV9vT97j4jZ+zysvu9EpgAYzZ2gUkW+cL/b56s8hT
   YcBkXyOwdqfjHQmtlBS0vj2VlICsmaQQs2Ht9ncfE85fIPkmxssnFSM8S
   lR+IAlT2PTNhWQb8H2dA/F6RgENBRvKsHRfl1GJlDlDzehFhg+MHgu9Dv
   3jMbEwNKYR61jytCO4s3OEVg2lTriSeesUSVp3OCBMsKuDvfa/xo2Yn3Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="333216286"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="333216286"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 14:57:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="702761299"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="702761299"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2023 14:57:18 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:57:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 14:57:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 14:57:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 14:57:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXXw2v/Nl8iJdRsyF75D+73KoU4OSvrbuJDIK6Wn7G3MIzdECtqIkHjQxWuBOatX0Wqu045yX0H/XZu484/htip0CMOnrSICkkl4Rb/7YiD+iF48Vp8OnDpsR/mFP3VD3IJjLxs/gFctEyGrD1qvmduCW+4OTSR1/Lr5/KgRGs8T6T6yFckL6WnoK0EqJ7g+Rj/GhpvIQ2rCzGtoEbAPg5///xk8gSlYlZFApnOc6gCulypeqWavqj6Qmf9iDH17GCK8Z0DIvrK/fqwH5PysVu4DXftNwqwqLJw4lH/bWJFhOGqxddnCGdr8RRLOJvviDhVCXr80jqLw0XNlTwK8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx/YKsQrtiAnPC9/7lQ2TBqPiO0gcRAuPJqscABpeuU=;
 b=Lmr1N30HJmi55pXM/qYzJDc19E0ju/w+7s8aDxhaXOlW69jzqhorlAxH5EDvlhW2Q1Tv4GylvVdkhQinZSvFc0x6Zd1sYAVnnmPOlPjCS4bfIpLef3M+e41Ce57rasXvO98+N65bZtF6cjqdVsscz3X8pD5qi//jQGRiEbUB7CepiMM/n9AVjed81dgRtavyZYWXGV75xTUwYC9kpoaeadENNBEyEnv4X3arFrhlwSXP6Cu+gIdbjfhCrlaGgnVOuSvlGldK3V+YXV+E5rIcKAMlDR3sJQgUN0bHXKCvaNvCOmNZHb0UGCn0dtWi43xT4JD8nbaBuu9mqWshYR3ZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DS0PR11MB6542.namprd11.prod.outlook.com (2603:10b6:8:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 22:57:16 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 22:57:16 +0000
Message-ID: <4e5cebd0-815e-e3ca-7068-4d665d337bf2@intel.com>
Date:   Thu, 16 Feb 2023 14:57:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 2/7] platform/x86/intel/ifs: Introduce Array Scan test
 to IFS
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>, <sohil.mehta@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230214234426.344960-3-jithu.joseph@intel.com> <Y+4kQOtrHt5pdsSO@kroah.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y+4kQOtrHt5pdsSO@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DS0PR11MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: b86e0be2-d5a9-4b12-c08a-08db107125ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qigSZWuT0Ff0wyEHGZ5PIIXkdZtRnKHgYey295s5hOzITUbiz4fJEI2IZgZ0zGn/aVol0+ODAhhCTHa16wrx2Qx9gvCtF5JVCBeL4l7okTUB/jmDNKGs8CRpPy2mJ/WZpV/kemFsxrSlYFCcPcFjnTqSkEySXeSWkWRs0XlAthf8oPOdNCEKT6W+ZeXjWU65Vu/2PSKcmeQ7a1kpLWvGSHIiDs037R3yCB6fX8+t+ETJhcbQ5d1wjLebYnXmvw1DKthFDs0oAV+skaI7Zwt4ZPKoI5SnSFmYoz4B/ztknieEtrg56ON+QIy4s6F4mmNyrT1+RjGaBn/lt07OyCa0n/uict9MzbeliKUNrraN1Y92nKpppm0Ny08Jibf+U36VP/2FnjaoP9r8TAMVX8k+R20QHDVgYrUqNLgxPyvyv1mT+AYOgmBvEwi4iSYLW5PEaQaFPCg3h5nFT6377depVe+zHLTaEuLrk4VjIVt3PIlY17uuYxAT3Yo//DhbQnFN4iDG36faF84cBxRNosrI+/KQiD2X54zdfOzGl7YgjDZxw+XJI2wID19ona4NYchO8vc0PFfqHo7YB9CpR374FlvtezE8t9Ujo7Y/mLja4N0FrsHI1nz7TKSdsUGrhbUPeApUaVmaXGzR9YR4b7hMv62TfKEiGbgEDh0gPpTG3U4cGN/Xwor/hZPWoBUTdHtsW53JRv+XAXtGZVqUVirR0tgxFKaH/DoQxtiOQowXyS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199018)(36756003)(2906002)(31696002)(83380400001)(86362001)(2616005)(38100700002)(82960400001)(66476007)(66556008)(8676002)(316002)(5660300002)(66946007)(8936002)(6916009)(7416002)(4326008)(41300700001)(6506007)(6512007)(6666004)(186003)(53546011)(26005)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlNoNGR5Zlg2eFVxSHBOTVhOK1FnL29xYW54RHRheTMvdUMzSUJQZUFpd2hV?=
 =?utf-8?B?SFhnYTVDV1lQbnpwVVFUODMrQS85dVVHQVFFcWNhMUJMUTYyeUpDcUJmODJU?=
 =?utf-8?B?ZkZpcnl4Z29FdWlwWGdOc0NqWEVMUklFMktsVHlVVjFKd09LNjFUeTRvRjVC?=
 =?utf-8?B?UGV1RGVUSldFaGVKYkZnclJqREV6aEg3aUJVMjRXZ1hxdmxJb3B5U3pjRm95?=
 =?utf-8?B?ZGtTbDVUQnRTaHBYL0Y1K2lvQ0pkQXZRZm1pS3o2Kzh3d05qL1NZQldZc3Vq?=
 =?utf-8?B?SDlNL0ZsSWtMQkJwV1JCSHFQdExZc0pYRDA4b0huTFlnNTM4RXhwdGM5VmNR?=
 =?utf-8?B?dzkxRmtwTHVUemdpbHNma0RTSlF1MmphZkVWWXRacGdWNCtKQis0ZTV6bDRJ?=
 =?utf-8?B?OXpueHFORkFvOFZUQ0xLbXhIcmJOWFV4dHROazBqSGJxN2xCbURTRFhCLzEv?=
 =?utf-8?B?TU10ZGtWR3lwRFNkbnRsVnJtaHlSb2EwYVYyWmRKVjZnVlV5L3FKVE5xM016?=
 =?utf-8?B?WjRqbm5Lb2tzTTliUFFNQUtUMmpIRXhEbUFUUXJVSzcwd1QwNXo5TXU4cWY0?=
 =?utf-8?B?Q0JmWkRDaFQ2OUU3TlYzRHVLaWF5T3hlU1Q1c2l0Q21Da3pDc2Fwcy83aFNN?=
 =?utf-8?B?dlU2S1RvcVZmMHVGZElDWDVFZmF2dmMzL1BsbHlaNUVMSlpiek1ZVHhUeDQz?=
 =?utf-8?B?aVVZZGp4Uk9IZWl3MEdYcFZ0and6SGk1dDhXVnV5MEtsWDBqbUVNd2VYNEN1?=
 =?utf-8?B?RFZROHNNRk5pb1NEQ0QvRjNIK0tBVTJObGYyNXBpbURhQ2srRkdPRlpqMGt2?=
 =?utf-8?B?NE9oNVcxcGR2K2xPNzZVaFFqRjNzREdpeE42UnVGeGwxNi85anBhb2NrSm1m?=
 =?utf-8?B?blh1aGtyc0xsa2VCTGVqbzkvZGlXL1Fib1FKZGxHSGZnb2dUK29YTitPZjFp?=
 =?utf-8?B?NjJTWUhWS0hoRTB2cWRocWhFODZLQWh1K0lKNzE1QTdGZnV1V3RWWjcrZDZF?=
 =?utf-8?B?bHg0aWZlNWdSdTJIT0o0Skc2T2o0eDhFMUZnelpRZnNqb0pFUEFlaERrdnhG?=
 =?utf-8?B?SEF1NzNnQ2g4YlROM3pRZjdoZkxzdEh3RTVNMjJ6ZUhSRTlvcjdkL2JPQnor?=
 =?utf-8?B?WXZBcHJJU1NhMjJja3VzbVVqTDRIdFdpWjJ0RWN1SGUvK3VhbTVTWDVCVnY5?=
 =?utf-8?B?aGJrbzhSUDR4WW5KUVpDYytkcStEdlVKR25RR2hSZDNyaWtUZ1FsVzQrSTNX?=
 =?utf-8?B?WWlWbGhrVVdJT01WVXV0MGZqSnZmZTlFV2o5M253Y25YT2luNEtLYWtNZlp2?=
 =?utf-8?B?ZVRQWURqQXBFSjY4SkdnVmhVRmJBS2w5V1BOaDBLUFlJbTdtT2xpV1hrZ0pS?=
 =?utf-8?B?RlFTeklGS01FalE2eXdZMkNqQ3oyQ1RCNjVnYjBtMzdMOXJPK08wU1hBK1g4?=
 =?utf-8?B?ZVJFWDdFcDAvZUVLQmJaNlJCUlh1THp4Qy9yRVQ4Tys1TmhXSXY1UDZob0pC?=
 =?utf-8?B?RklEQVdiUWxYTElyRjl2amhYSXY5cDR2bmxZS2RqWkkwaVBYL3hxZUNnVllV?=
 =?utf-8?B?bjBFU3YzamZVL0c4K3Zid2JVeG5rVCtkYm5GNHhwMDJ3aE1HblZZNkZTNlE5?=
 =?utf-8?B?ekJBb0J0dHpyazNoZjFGOW5uKy85YTFlaGwyWi9BTHJ3WVFZeUlsYURublFU?=
 =?utf-8?B?S20zN0JyMHpmR2dNU3g4VEdYNkloRmxOOW9NejRjWDBaN3NKUUZRQS9qM1c1?=
 =?utf-8?B?dFlNdGQ2ekFkbHNvMmtYYUtFWnNEb1BURDZhY1pvVDBjMTdEZDZKTzJuam8y?=
 =?utf-8?B?NFdFN3Zqc1dLTENWY0JDdml6UGhDeVJQY01tdTZRdmtrQm9EUGFORCs2eHlH?=
 =?utf-8?B?dmhZTHUza3JpbVFaM2FWcUFIbHNRenA4eW9nUEpja2lZRzhhR3BGWnNGSWFy?=
 =?utf-8?B?cHA5dG1VN3JNTmw5ZFp4Q09ZUGlISzl5SHIwQlhBbXd6d1BYZ2I3ejlJckFp?=
 =?utf-8?B?UjR2UjhoQlNHbVVJQ1RDS3h4Vk80VjlKN3oxSmcySUNYQ0tKQkNlTjZHRnpY?=
 =?utf-8?B?U3Q4MS8ySWJlcnMxRndNTzRvZ2F1dE10NDhIM2FPWVB1RzZCcWVRbm5uK0JL?=
 =?utf-8?B?cnZ0bkw5MnNsVEd3cHFlY0VnY1pTOU51aGNxV205QjZjVVJBTmNqVU5KaFA5?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b86e0be2-d5a9-4b12-c08a-08db107125ce
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 22:57:15.6900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/pA70mJZTmaiYrZwXmcXi3we8BqyKYhB/MrJt+zeGLb1Z+zSWtlig1gtP/rgd8vjTGukP1/JzBjqcaVdXx9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6542
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 4:40 AM, Greg KH wrote:
> On Tue, Feb 14, 2023 at 03:44:21PM -0800, Jithu Joseph wrote:

> But note, that's a horrid name of an enumerated type that is in a .h
> file, either put it only in the .c file, or give it a name that makes
> more sense that it belongs only to this driver.
> 
> Yes, naming is hard.

Even for a driver local header, I agree that "enum ifs_test_type" would have been
more appropriate than "enum test_types

> 
> Wait, you don't even use the enumerated type anywhere in this patch
> series only the value, did you mean for this to happen?  Why name it
> anything?
> 

Since I am only using the values as you said, I will remove the type and
use #defines


>> +static struct ifs_device ifs_devices[] = {
>> +	[IFS_SAF] = {
>> +		.data = {
>> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
>> +			.test_num = IFS_SAF,
>> +		},
>> +		.misc = {
>> +			.name = "intel_ifs_0",
>> +			.nodename = "intel_ifs/0",
> 
> I just noticed this, a device node called "0" is not good, why do you
> need this in a subdir at all?

There is no need for the device nodename in /dev to have a distinct ".nodename" from the sysfs "name"
I will remove the separate .nodename line so that /dev entries are created with the same name as
the sysfs directories.

> 
>> +			.minor = MISC_DYNAMIC_MINOR,
>> +		},
>>  	},
>> -	.misc = {
>> -		.name = "intel_ifs_0",
>> -		.nodename = "intel_ifs/0",
>> -		.minor = MISC_DYNAMIC_MINOR,
>> +	[IFS_ARRAY] = {
>> +		.data = {
>> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
>> +			.test_num = IFS_ARRAY,
>> +		},
>> +		.misc = {
>> +			.name = "intel_ifs_1",
>> +			.nodename = "intel_ifs/1",
> 
> Again, a device node called "1"?

Will remove this distinct "nodename" too


> 
>> +
>>  static int __init ifs_init(void)
>>  {
>>  	const struct x86_cpu_id *m;
>> +	int ndevices = 0;
>>  	u64 msrval;
>> -	int ret;
>> +	int i;
>>  
>>  	m = x86_match_cpu(ifs_cpu_ids);
>>  	if (!m)
>> @@ -51,28 +68,35 @@ static int __init ifs_init(void)
>>  	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
>>  		return -ENODEV;
>>  
>> -	ifs_device.misc.groups = ifs_get_groups();
>> -
>> -	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
>> -		return -ENODEV;
>> +	for (i = 0; i < IFS_NUMTESTS; i++) {
>> +		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
>> +			continue;
>>  
>> -	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
>> -	if (!ifs_device.data.pkg_auth)
>> -		return -ENOMEM;
>> +		ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
>> +							     sizeof(bool), GFP_KERNEL);
>> +		if (!ifs_devices[i].data.pkg_auth)
>> +			continue;
> 
> You have a static array of a structure that contains both things that
> describe the devices being used, as well as dynamic data with no real
> lifespan rules.  Please don't perputate this common design pattern
> mistake.
> 
> Always try to make static data constant and make dynamic data dynamic
> with proper reference counted lifetime rules.  People converting this
> code into rust in the future will thank you :)

I may not have fully understood your comment. So pardon me if the following description
on the lifecycle of the dynamic allocated memory is not to the point.

The lifetime of this allocation matches the load time of the driver (allocated on init, freed on exit).
There are no further / allocations or freeing anywhere within the driver.
There is only a single place where this memory is used, whose access is serialized via a semaphore.

Given the above, does moving this one and only allocation to use a global pointer instead of one embedded in the structure is what is needed. ?

Jithu
