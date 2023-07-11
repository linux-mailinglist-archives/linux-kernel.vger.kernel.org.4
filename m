Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB77E74E731
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGKGXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjGKGXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:23:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08925E57
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689056605; x=1720592605;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wz/I/cfSx7KXdt8IY1G+SUL8ts7vaSGGlSeKrxYU3QU=;
  b=SG/Bw0jZMeMGCylDzf0+Qw8S8E0GipPB19KQ2YGjDqCZxBAK2Cx7vjZR
   e7Zoin2NbqjqoCtdY4EzuAQb6FOGqFMAHTX3o++wWkP53QOjypaNDOcoD
   y/rm96IYBBeCgJ/VZZnFBYHHgSw03S3EudzshogUlNrK1NVDiZSYHmMUA
   xHbm3o6xehEcGG4gi1si1CGscdl+uE6dNROl23+r0zZXUPS4XH7n+g+I9
   knieLPw58MF5PWjCOp3qsmrQpHyGkvYmDf6t+PICpEfndSZgdM7x88VNS
   WFo3ph2eMa9P8V8lbhSYzTPpuwRcj+smfNFjg+MOPHy747FdexPiXLJkc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="363404198"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="363404198"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 23:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="750617003"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="750617003"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 23:23:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 23:23:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 23:23:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 23:23:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 23:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7U/A8QlyUAAhH90eS4lTAnQr6JNFrHoIJ4QUJQH3p8pPryCuPCYLZ/ssD+mDE13v913MNrgSTe3AY5veiJo8uez2sAhbasZbu/dG/W71I9RGnmI1rJXEU98c9Is56D7ocBVUMXJgyckrj+sUVVKIjdPsKzA8KAySloXZEIvEztmsRZaZG2vNXY8ufRpm8UEX8AdmPfq8TJRm/0hZMUzeJckcY7gx8fJPwxJWOe9d1F5+jEKqJXl+cOdULVhbty7kmgPHlt8S+8G/DvIr/SQmPcH5nEKx/smhH6escnXnQhi5qYPNFnF5rya/Jxk8mdYCXA6DMa7bwDi62D+XtY5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PY8eFFpj7qTDEIPwqgyX1O2cN5ndhyVvpJtNK8FnIIM=;
 b=caTrfBCwEFXJ8frNxc5Uv/QmVNFO30r00Kh2gJoyi9EMYXlbJvblCIaqs5dnAFX9IhOD1fNwoV6DZyneSrT9q1hoqeRIzdxARoKKYrNCCx3rGdT9r+1gOM12axV/e06O849Lds4PNMSjecl/xNGyJx5T/dA6q/c2hswBC2qIvrjBDpbPw3/x/b7O+9XwKZELrD5F0l5oiKEcfZ6wjp62ae96TRL1QU2qWWqqu5ZkElDoqhMS9tJS5YzYgdAGdCTqOgwLvrsN2JRzHsf4DP4GJSKzilxkkJ7DXnFFdwPkEAmOb9sVIofM0FN4I+E4TQDbM7VxvKM3/LOjr6gWfPUaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5462.namprd11.prod.outlook.com (2603:10b6:208:31e::5)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.29; Tue, 11 Jul
 2023 06:23:15 +0000
Received: from BL1PR11MB5462.namprd11.prod.outlook.com
 ([fe80::58c7:f89e:e561:de63]) by BL1PR11MB5462.namprd11.prod.outlook.com
 ([fe80::58c7:f89e:e561:de63%5]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 06:23:15 +0000
Message-ID: <0c17e548-cca2-2f6b-b9c5-a534f5886e03@intel.com>
Date:   Tue, 11 Jul 2023 14:23:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/5] iommu/vt-d: debugfs: Enhancements to IOMMU debugfs
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230625150442.42197-1-Jingqi.liu@intel.com>
 <BN9PR11MB5276885D6A142BC94D80C2618C29A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4f18a7ca-3a57-0097-51f0-490f876831dc@intel.com>
 <BN9PR11MB5276ECF766C4F89F5083992F8C2EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <f2f23ca1-0881-4601-7ea5-c5e42ab83f62@intel.com>
 <e3146447-6af8-9049-e951-915e2770988b@linux.intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <e3146447-6af8-9049-e951-915e2770988b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To BL1PR11MB5462.namprd11.prod.outlook.com
 (2603:10b6:208:31e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5462:EE_|BL3PR11MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 6511984e-93c7-462c-f9a7-08db81d74f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fj4l2DssmET5Ip+Xf7ScFoBuATwwBCK8XI4jscECu7UWs9VBzkDSH1XKrmF7zS8iHcPwOrOBn8JqG27FqFvqYZQXFFMfE4f+MjuGEswlhU6pjwjZcrRFfn4Ug+KVyviORLoJxEkDxBw093PZkQnZxOC02PzqTytUKkgKoxlc3LBEkAX8hn6iE6uCOsYNDw+dc0HtP+U9CTXpfmiJ9wamjqgdRGZUqBg06kEAf1iSQFndTbcp59OGaLovnLOKKk07Uzh4Y4N234HyP+/PtPmhXk8wcYFClsJ4ZfbnxcHVrkLlSb1sW7TJ0T6sQ/f97cPNMtQTRL3y9Y+/XvXllV71uFghKEc+YGsp4zV5ZCtEqlq70iSi9KP/sQo+G7m9FVo2/hzTYWoKkubMOzE4+AumA+tFHYb+odVEo7tuYIZFL0eum2ihi6SmIfiq0zYDpbRsVChGZqTN316JH7rciFkChfDZN8uiVO5aI7jo7PeGfH7IYmf45jiWt05Gb5VxDRtYAwYDxsN/4co/H+qL0M4RwcaAFuIIFHKfw95q9PArPkcTSk6wCj9zghuqhMHm6i5X+plptbIHQBQJrpNLzW2W5D71inSem2Fw9FubwNcpkYLhxjkrYT2GibqrvM/YfvfavZru9U2Hbtx2chc17zmq5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(5660300002)(31686004)(8936002)(8676002)(38100700002)(2906002)(2616005)(186003)(110136005)(53546011)(478600001)(26005)(41300700001)(6512007)(6506007)(82960400001)(86362001)(6486002)(6666004)(316002)(4326008)(36756003)(31696002)(66556008)(66476007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzFMdnVHd3EvM0FxekU4dHlEbW04NldqRTdqaldMYjV5Mnp6MGRVdStTd1Nt?=
 =?utf-8?B?alc0ZVdLM3NKUkloSkY5UHUvUmVxcytWRmwxdmF6aWVGb3NyN2RGSCtlTDJu?=
 =?utf-8?B?RHdiOStEM1krZDQvUitZZHpObHZlWkNuTzB4a28zWEs4WG96ZG81eWxPYVNv?=
 =?utf-8?B?K1lXelR2TDNaQXM2Q2c0VDB2bXNKQjVFVVl1bVRmeDR4d0pMV2k5dTVVZlpE?=
 =?utf-8?B?YURpby9pWFRrcHF1TjdQTk5KOEVtSlBkNWN2T0c2OTVlQ0prN2tRbVJYZS9E?=
 =?utf-8?B?L0FVUHVzNyt2bDhtVCsrT0V1Unc2bHJPVjhpOUc2UHpqb2xaZnJ2aHdhcGdU?=
 =?utf-8?B?VUFsTFB5eW0vWmpNOHhWTS8relJhZGxMOTd6VTBaWURUSEZJNzljcFdEcGxN?=
 =?utf-8?B?Wm0zOUN4b3dIcGZWaE1UcnBGNXZwMUVaaHFXN0plcFpYOXJNVVpLVWIrZndQ?=
 =?utf-8?B?V1hpYkJWWFFSYzdxdktTMVdadm55U0psZHRVTTZaY3l5R3VBUVZ1TXo0UWNZ?=
 =?utf-8?B?djhoUGlZUWFBMGRZcnArbUtaUnh2d1cwMEpEd0c5QzZITFlIdU5GYitmSGlI?=
 =?utf-8?B?RloyR3NVV050Z0ZGT1l6STBHbGlCd1NZdkJXMFlUWE5DN3FhbTNucTF6c1dp?=
 =?utf-8?B?c0hTQnBqbGtQY2pvb0dpaWp0Z0xNcXg2U1E0NU9tSGE3aHh4MUhhc2hlNklD?=
 =?utf-8?B?am1IekUxL3FyQUR6Z3IzUHpNWnloL3dzcHFvZXBHQlRJV3pqQlNPUnBCdDRJ?=
 =?utf-8?B?TXM0L2F6WGQ2UWFHVUxpWm5qelBMWFVkZjRhWE0xTkJnN0oxT0tEaGY3YXFy?=
 =?utf-8?B?aWVSemx0RFJOOEh6aU9WWElSN3VRUmpFZzN5VGdRU3lFWW9zOWE3QlhYc3hK?=
 =?utf-8?B?djFldytsNWNiTkpsU1dnWE00Y3EvQmVraG9mSXJiVDlZSTZnZjVFaUxMSldI?=
 =?utf-8?B?VHJ6cVk4WHQ4Y3R0NGRWeENiK1BIbXI4enF1eStpN1dxQ2tpZUErWVRkTTlo?=
 =?utf-8?B?N09VR3o0VXFNU0pwVU9NTEFBOGZBZlVnK1lDUUtDZ2IzWkdib1RGaDcyc3ph?=
 =?utf-8?B?eHVvS0dsaE1yOWJDa2lUTVllWTkyY2hNVXBuNUpySWdEYXJBY09KYmxHUWNn?=
 =?utf-8?B?U2dGQmUvYUtYWWZqN09mM21YQUUvOWpwYk1FWVBtUCsrOHNDdkdGSzREbkRh?=
 =?utf-8?B?blF3Z0ZTaTFIM3pQVUVHdDZWNkE1TGx5aWE4OU9Ib1QvMy83UllhNkNuSWlG?=
 =?utf-8?B?YjZMK3NqUWgrT0UrUGsrUHd2NEpDUmE4WHFaYjRENktRU0t4ZzdVL2FvV29t?=
 =?utf-8?B?QlFrbEVibG9SRWFaci82ZkltMjg2ZDFIQVc2bmZGUHFyT056ZElPd0htUjBo?=
 =?utf-8?B?SHo1TjhhSW9oaVRQUDFqUmJNR1Z6L2ttUUluVjZmTzM0TGUwOEl3WFZ5aHUr?=
 =?utf-8?B?aG1TRWxWTXFPa3hrSE5DQkJkcnhVRnFvY0I0QXVQOW5Pbm55aUVreThhMVRM?=
 =?utf-8?B?dWFXQlhibGJBSldXNElhMHpkeG9hUnZFbGY2OVNobmhBTkg4a0pzZEdVV3FG?=
 =?utf-8?B?RHR0c2xKRzZ2Tis2WmZqMzNSUmlZZ29yNmZ4eGpYZGZTODcvUWR1NTc0R3F3?=
 =?utf-8?B?bk55Vjdsc2NuWFFveGQxMXpGQzRuMElTR1A4VldhMGQyeXF4NEtVcEdkUTE2?=
 =?utf-8?B?QXJQMStKdXkzU0dRNVBwOUVFTHNqeDdVOVFLZUpZWksyYkRGc0hnTHFhK0dq?=
 =?utf-8?B?cjB2ZStaa1NLd2VUWlE4MHVWdWpzUVFkU1c4QUtyMGR1UWVqZ3lvWFQwTEpB?=
 =?utf-8?B?MTRMVnRRb3Q3U2h6RDUyQldJTmZIR2lCcC8xbDVJSTNLZkptb0p2YTVZWjZz?=
 =?utf-8?B?bE5maEhQYkpoY2tFZWJ2VU5MQ1I2UWErbnhERjQ4Rk9WZkFrZDFFWEtHN0o4?=
 =?utf-8?B?bzhNaEpaRm1jWTRhNVVobGR2ZDY2UG0xVmdvTWMrWFM0UHFFK2ZXeGhrUThv?=
 =?utf-8?B?MDNUZXpsc3RZWi9wY3hia2I0MmxISkZIanVVdEpiL2djM2swTUJ1OUMyRmFy?=
 =?utf-8?B?cjFIM2p0d0d2eWhIVnBySjRwdWEvYU5IZUQyQXROaDRpMEpzci96MWJmeHhq?=
 =?utf-8?Q?rlJtaBuoQmzSfaSTXQTCY0khL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6511984e-93c7-462c-f9a7-08db81d74f51
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 06:23:15.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xG1N/IHbfdCQYlZzQU/rNzjswDgJEcoPzfxLOTYkD6DtQb+4IOMk1WMRXIB50h0gh4eb0pVKd0a8v+NpKZquyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2023 10:52 AM, Baolu Lu wrote:
> On 2023/7/11 9:40, Liu, Jingqi wrote:
>> On 7/4/2023 3:54 PM, Tian, Kevin wrote:
>>>> From: Liu, Jingqi <jingqi.liu@intel.com>
>>>> Sent: Monday, July 3, 2023 10:37 PM
>>>>
>>>> On 7/3/2023 3:15 PM, Tian, Kevin wrote:
>>>>>> From: Liu, Jingqi <jingqi.liu@intel.com>
>>>>>> Sent: Sunday, June 25, 2023 11:05 PM
>>>>>>
>>>>>> The original debugfs only dumps all IOMMU page tables without pasid
>>>>>> supported. It traverses all devices on the pci bus, then dumps 
>>>>>> all page
>>>>>> tables based on device domains. This traversal is from software
>>>>>> perspective.
>>>>>>
>>>>>> This series dumps page tables by traversing root tables, context 
>>>>>> tables,
>>>>>> pasid directories and pasid tables from hardware perspective. By
>>>>>> specifying source identifier and PASID, it supports dumping 
>>>>>> specified
>>>>>> page table or all page tables in legacy mode or scalable mode.
>>>>>>
>>>>>> For a device that only supports legacy mode, specify the source
>>>>>> identifier, and search the root table and context table to dump its
>>>>>> page table. It does not support to specify PASID.
>>>>>>
>>>>>> For a device that supports scalable mode, specify a
>>>>>> {source identifier, PASID} pair and search the root table, 
>>>>>> context table
>>>>>> and pasid table to dump its page table.  If the pasid is not 
>>>>>> specified,
>>>>>> it is set to RID_PASID.
>>>>>>
>>>>>> Switch to dump all page tables by specifying "auto".
>>>>>>
>>>>>> Examples are as follows:
>>>>>> 1) Dump the page table of device "00:1f.0" that only supports legacy
>>>>>> mode.
>>>>>>
>>>>>> $ sudo echo 00:1f.0 >
>>>>>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>>> Device 0000:00:1f.0 @0x105407000
>>>>>> IOVA_PFN                PML5E                   PML4E
>>>>>> 0x0000000000000 |       0x0000000000000000 0x0000000105408003
>>>>>> 0x0000000000001 |       0x0000000000000000 0x0000000105408003
>>>>>> 0x0000000000002 |       0x0000000000000000 0x0000000105408003
>>>>>> 0x0000000000003 |       0x0000000000000000 0x0000000105408003
>>>>>>
>>>>>> PDPE                    PDE                     PTE
>>>>>> 0x0000000105409003      0x000000010540a003 0x0000000000000003
>>>>>> 0x0000000105409003      0x000000010540a003 0x0000000000001003
>>>>>> 0x0000000105409003      0x000000010540a003 0x0000000000002003
>>>>>> 0x0000000105409003      0x000000010540a003 0x0000000000003003
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>> 2) Dump the page table of device "00:0a.0" with pasid "2".
>>>>>>
>>>>>> $ sudo echo 00:0a.0,2 >
>>>>>> /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>>> $ sudo cat /sys/kernel/debug/iommu/intel/domain_translation_struct
>>>>> What about creating a directory layout per {dev, pasid} so the 
>>>>> user can
>>>>> easily figure out and dump?
>>>>>
>>>>> e.g.
>>>>>
>>>>> /sys/kernel/debug/iommu/intel/00:0a.0/0/domain_translation_struct
>>>>> /sys/kernel/debug/iommu/intel/00:0a.0/2/domain_translation_struct
>>>> Thanks.
>>>>
>>>> Do you mean create a directory for each device, whether it supports
>>>> PASID or not ?
>>> every device has PASID#0 valid, i.e. RID2PASID.
>> Sorry for the late response.
>> Got it. Thanks.
>>>> Seems the PASID can be assigned at runtime.
>>>> So it needs to support creating debugfs file at runtime in IOMMU 
>>>> driver.
>>>> Looks like this requires modifying IOMMU driver.
>>>>
>>> Isn't this patch trying to modify the driver?
>> I just tried not to modify the driver except debugfs.
>> I'll try this implementation. [
>
> I'd second Kevin's suggestion.
>
> If you check how usb xhci dumps its contexts for devices, you can see
> the similar scheme.
>
> # ls /sys/kernel/debug/usb/xhci/0000:00:14.0/devices
> 01  02  03  04  05
>
> In our case, pasid 0 is special which denotes the domain attached to the
> RID.
Thanks for your info.
This implementation is more friendly for user.
I'll implement it as such.

BR,
Jingqi

