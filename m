Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7C5687038
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjBAU4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjBAU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:56:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E4B61BC;
        Wed,  1 Feb 2023 12:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675284966; x=1706820966;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SlGBiEeYqO1A1J1mnisFOPeQval0ZxIXsT9+/hbojX0=;
  b=HXDOiQx6IK65H921PtPJBcLxr3RY7f5HjR4HY58ag4achHYkwLL8y0+N
   LoOK35sTgE/irXsbk5zN40Ug/+6Q78UwbC2DDaB92FlS8SaA/h3pUhGrA
   lB1m+9is8F+81QuTKO6wx0ALY02vSju0C0Z82/8hAnQE1eze1c9o44/7+
   PzLO6/4GsF+x0MimiW/FL4NU1iqJDdDlfcOSroTlTKbAX7/wKU9HEm5+6
   ByR1PMI4nB8/e1dGp+y8ls1GcOcUlbir96Ih9MKNV1XVCTSKATJHCO9kZ
   +dX0gvZxKWslMvriZ5PdSwSJInTfWCu6KAJ/sKJqLZYrO3wcFl4vdiZ36
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="328282737"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="328282737"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 12:55:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="665030620"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="665030620"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2023 12:55:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 12:55:47 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 12:55:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 12:55:46 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 12:55:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4knqzC7NXMPlq5AunT+si9RMzdD+tDkH6HkZjTOQB8u3SHHE6LihxDwE00Iv7wiwXV2B4YOkTY9CvBFyR2SQ4piyQOOHC7q+RWRZT8npK1SpVAJ1Z/qQB2Q8Hw4MVvnlHkabQO8YaxFGffBQkgGL+PcqBtjSbTSzMuwAiLAEu2C9nlpQ1Ee+/V1GWxodqx2yi5vRaxIN5lRhkU4Wvgje7aMEeVS3mesedCeoBHeocmB+qUbndqYlNaFE7X5RzOwyoIei2rcY8IqL3UCnPTuM7yKnL30Ky4iXBLGBqMHGVqOOkeZR1HzrUFpuLIke9zbbVGaxJBDg5Gy0N7hXAO67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI+h+WUi+p4uXzbCYLRjEDzF4jU3RcTmOW/NOKqTaNU=;
 b=h/fTg6bIRH37kJeVZb+P9bAxqZb+7ecn9Abde/uZKMi3VQ73m02XbYLDfY5NII3jixY+FWGfg787wpzXqCqwUQKanWPl0a2dRwydiwr2soNqCDmyKtjWnNP55wXZIsCmqu/Juq1wil3G+ps5kSuuSlkFGD6c1iqZnFgeJm7BuMigqf9SXLaGl87uPT8SLZvZEDhzxRguMgQ0S6D/4cOVZCV+iVz8T3Qurjwadmb0DozcbFv2voXkmlPF/odmo5lX1Ei9qk2QVs8EVniDnLI1X3YJYzOn5QZtmEjkT/H3bcG5BEzuWGiwosXSTQzLFrCKRHv6vcr0EJVkcWMPhXbgvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 20:55:45 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::b387:57c:7240:8b72%5]) with mapi id 15.20.6064.024; Wed, 1 Feb 2023
 20:55:45 +0000
Message-ID: <5df82b97-c317-6dbf-d068-29e39ccdf3bc@intel.com>
Date:   Wed, 1 Feb 2023 12:55:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/5] platform/x86/intel/ifs: Sysfs interface for Array
 BIST
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
 <20230131234302.3997223-4-jithu.joseph@intel.com>
 <Y9nyxNesVHCUXAcH@kroah.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <Y9nyxNesVHCUXAcH@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::22) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 00add4cb-4d2b-4784-ce2d-08db0496afed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vzx/+B2RNEHmkrLRZFVxN2tYhB6tfREkNugBlk+HeF7nUlhtv5NdpFA2+blJ8w9rEqghqtqBVeJN9bYR3H7wCGZNJlzgJfSu6MgufTx9btt3zAjaiJXZ6neDBq0Ht0vQj5m7KX/adZ50BtGXI7MaIU0J9U5m/S9PwKttwaEpUgnpHtlwJwAlQUJ+prrA32fgOhh/Ynf9/36yw3vc8kGMItuFRoc7P4tGdE5VI349imbSLVeIGgh1O7O2ouaiSRL9hSy/E4GDGSdTPUluD3F14HRJSbJ5BsUPFV3klZrAfU184RaP3SDar2tBsR8oOgRKDlPlrVlKH+efGyurrSFTjQWr+HrC38WM0qtn9rgXohta9dBluXU3gJbwZafxy0GIP4Su4ZbLa7NL9I4zSfCIJWE0Mkozb+r+W9/Lkdxt9uY8rO240r1Wf4JntU6ZWGaLGp6NuhIoODQ6ej6AYOKcTkqcHiV5FQJGaa1CmcXT6slOx8N239eWqc2CsqYrooyLkdGSeO4hamDM4Rjj8LnYan9/pgGpiGXYJ5V3/ss0lg5oAih55nDfu1ymYgD4RXV/QytOf3EOWRw7RzcX7UUU+BJNsz1iUqcOCjWWpuJh4yi+3yqJ6/KCabE1JB45nw4ddIqrwelEgZY748Lfrs9Mk0qijbo8lkBdFuFo52G66wIuE5USavqajSc9Ja5ALVbp1HrhUo89XgfjuAjvpP61sFvXfGDhxBFtSMjGRZKszTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(2906002)(36756003)(316002)(2616005)(83380400001)(6666004)(26005)(6486002)(6512007)(186003)(66476007)(6506007)(66946007)(478600001)(4326008)(53546011)(66556008)(8676002)(5660300002)(8936002)(7416002)(41300700001)(31696002)(6916009)(86362001)(82960400001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVB1YjZUeUtZaGwyY0JNRkpvdkE1STB2bG9GN2lLU3RXeC94cmNZajIrbDUr?=
 =?utf-8?B?SWlWNlhCVkVkVHN0VktrN1Uwa0Rsa3pZVzZTQWU4dmY2VWNUWWNRelcxOGJ5?=
 =?utf-8?B?dEloTS9JeGxjNVVtaUdKTFZuR2l1RUxPemtsRTM3YkxBWHlOT1ltaGtoWEhz?=
 =?utf-8?B?RGdiaDBQVkRRK0VOUG93aU9OTjNNTEQ2MlFUZXU0bmt1UVJ6d3RuV0ozdFI0?=
 =?utf-8?B?WUcrb3kxNkhkM3ZUTlRMbkFZajFhdmdWRy9oR2tEK01QUzU0N2ltc2gvbFIv?=
 =?utf-8?B?SmtvL2VkSTREUDJFRnFFdG5Sci84dGtqWTZTWjNHR0t2YUpOQjRQbWR5V0JY?=
 =?utf-8?B?eTZQR3cyZkFnZmFTanlTZnZSc3JobE5jai9VMHBENUNEemI1REJad1A5U1dZ?=
 =?utf-8?B?OW5MaGlqZTU5Z3F5TWRLL2F4K2V5b3FXemJHS2ZJYmUzM3Z4a1JZd08wZXFa?=
 =?utf-8?B?OU1FSFVMWDlIVkFWWkN0Vm43WC9MUHBIbEZmVFhKdk9SYW1qdWk4TEVLTmpS?=
 =?utf-8?B?ZC9TYWt6YVI0ZGE3VWM4RGl3b3FGOUZ3YjltaGltS21CRGxpU3VjenpXdG44?=
 =?utf-8?B?S3VmKzEvbU50Qks5VWhraVJRTDBFaS8rNzJVSG5hU0xmUUVhRXdZRmxjdG5S?=
 =?utf-8?B?L243cU1rTHovZDlNVjV2eXdqclJQcVZ6YWZ2U24wVGluZmpYZFZ4TU8zU1pa?=
 =?utf-8?B?R0pwSVhMQnZ5L3dtL1VZY2kwQXI3YWtqcjVPQ3F5MUttN0poQW94Y2Z3SG5W?=
 =?utf-8?B?V2Y1RDNkeUJaK0xRS3ptaGNIQ3hZeFlIekJQRjdSV2xleEJKTnJGb0F5eTBM?=
 =?utf-8?B?aFZXa1dGYXFod3p3OUNlQndpOFZCdGZTRmUwaVFSR3BBTXRjV2VIbHJxMXNs?=
 =?utf-8?B?T1VHdHhCTHZlUGN1Um10ejlSZU9QcVFvSU9KZ3NGOVo3bWZPalRnSVJ6Njk4?=
 =?utf-8?B?LzEwR2dhSjlKTmV5Q05PdjlLZG80SlVKSEZaK2pZdm1UUU1DRE1mV1IrSlBU?=
 =?utf-8?B?L3hnUnZaZlBSNm9CZXExYkVyTDUrbjBrcFRjeS85RW1UMlRqU2FSMU9LckUv?=
 =?utf-8?B?Sy9BUXJuZlo2MU42VUkvTFhPK2dkL0Nwanp1K2tnREZ1ZzltMjU2eEJROFg0?=
 =?utf-8?B?RUUyVGZ4aWhMbjZQVVNvN0c3bTVKQWdQeE9Gd0dJNmZjY1RvRGRGRm84U21M?=
 =?utf-8?B?OVQ2S25nRFFjTWRCY2ZWTnN2MW1QekRib1k4K3QvMitDS3BUbjRvaU9pc1VP?=
 =?utf-8?B?SVZLSXduSkFKWUJBWERDMlovN1BLblh2ekllQmJiajFQSjZUa3E2c2NkSU5T?=
 =?utf-8?B?blREMlFCVkZ4L0IxOFJrMFVMK09IamFHcUdiNytkU2J4bUIwTmU4RDBQMEwz?=
 =?utf-8?B?VHhHdmRrTlZzQStubmI4dU0wUkcwRCsreHR5a0VPWWN2eFJaeHJnSDdNT2dk?=
 =?utf-8?B?dDBxZVJIWUplV09lYjBrRUx1OUVjUWI1YVZ1cDJrazNEQzVZTnNPWFhRL3RF?=
 =?utf-8?B?c2c1RU85UTVxUVJWSlRMUlpzRjZYZVFpU2k5aEM2M01YOFF2ZjhGYXE0dXRs?=
 =?utf-8?B?S3UyLzFJRVhEZ1lLa0xKc3ZjT3V3cFd4UnZhUEdHN3NuM0w2blQzUk1lWXYr?=
 =?utf-8?B?dVFhTlNGdTlNNmpJN0FkbWw0Um5FVFhsQjJsZG1HQ05RaERhNC9abnR5UmZi?=
 =?utf-8?B?VzB5ZGd1TGFGMWxPdm9xUTliYmdVVkh2UmRnVkE1cythaDJyWjVaamtCaXZt?=
 =?utf-8?B?OXR3ditZd3BtdkxrM3Z2TGhUV2NranB5d3hLcWt1YTlzMWtUYkszRFg3b2hF?=
 =?utf-8?B?cHFjMlFLMnVZeENvdnNSRDhYSERjNk5ZV2U4ZzFlNEtha291ejVLUDFIOHlj?=
 =?utf-8?B?TUtTZmNXZ3NPNitKbW9sMzVTRTMrOFhua3piNUQzTGxSVHFHOHhMNk1XNm1W?=
 =?utf-8?B?WFFSL05pd1g2NzhwTWllell1ZTlkRHpma0V0eFBZOTdnUkJGSjJ0VzdoaE41?=
 =?utf-8?B?N2dxSldqeWZqWFMrLzI2RVZPWVR0bUNKeW82eXlaVHQvTWRMQktZZTZtNEVm?=
 =?utf-8?B?U2lEaW5ISVRDNHp6RVgxR0pxR1JtRjRlMGRHNU5nM20rNFVpOXprWjVITCtE?=
 =?utf-8?B?Z21uK2V0THhaSXBmZVc2K0JRRTQ5MS9tb1VsNkxXZ3FnOHJXd1R0Y1M4M2Jk?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00add4cb-4d2b-4784-ce2d-08db0496afed
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 20:55:44.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: md14vRMQ026J7CAgn3aue4kDPQLhy958+HHYbhFrPqN6pkHzV8inPkhGoGw9R5H8dKLOjhDHTbNmhEuvu3SoIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
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



On 1/31/2023 9:04 PM, Greg KH wrote:
> On Tue, Jan 31, 2023 at 03:43:00PM -0800, Jithu Joseph wrote:
>> The interface to trigger Array BIST test and obtain its result
>> is similar to the existing scan test. The only notable
>> difference is that, Array BIST doesn't require any test content
>> to be loaded. So binary load related options are not needed for
>> this test.
>>
>> Add sysfs interface array BIST test, the testing support will
>> be added by subsequent patch.
> 
> What is "sysfs interface array" exactly?

Pardon the typo ... meant to write "sysfs interface for array BIST test ..."
sysfs entries for this new test will appear under "/sys/devices/virtual/misc/intel_ifs_1/"
(whereas the existing scan test entries will be under "/sys/devices/virtual/misc/intel_ifs_0/")

> 
> Where is the new Documentation/ABI/ entries for these new sysfs files
> you added?
> 

Current documentation and ABI entries are somewhat generalized (we mention intel_ifs_<n>). 
Pasting a small snippet below for reference from Documentation/ABI/testing/sysfs-platform-intel-ifs

<snip>
What:		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
Date:		Nov 16 2022
KernelVersion:	6.2
Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
Description:	Write <cpu#> to trigger IFS test for one online core.
		Note that the test is per core. The cpu# can be
                ...
</snip>

I can take another pass through both, to call out the differences wherever applicable
(like test image loading is not applicable for array BIST test)
...

>> @@ -156,3 +156,18 @@ const struct attribute_group **ifs_get_groups(void)
>>  {
>>  	return plat_ifs_groups;
>>  }
>> +
>> +/* global array sysfs attributes */
>> +static struct attribute *plat_ifs_array_attrs[] = {
>> +	&dev_attr_details.attr,
>> +	&dev_attr_status.attr,
>> +	&dev_attr_run_test.attr,
>> +	NULL
>> +};
>> +
>> +ATTRIBUTE_GROUPS(plat_ifs_array);
>> +
>> +const struct attribute_group **ifs_get_array_groups(void)
>> +{
>> +	return plat_ifs_array_groups;
>> +}
> 
> Why do you need a function to get access to a static variable?  Just
> make the variable not static.

The above was in-line with the existing driver style for the first test 
But if it is more appropriate, I can move "ATTRIBUTE_GROUPS(plat_ifs_array)" to core.c (where it is consumed) and drop the function

Jithu
