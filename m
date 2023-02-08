Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B9C68F441
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjBHRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjBHRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:20:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65964F850
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675876802; x=1707412802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XnyEEPpWyf1i9sdifIDzmz/k6sfhijZ6kcwgHsIla7M=;
  b=Fgnvy2d8daAD0tlMfFjoKwXd+0zf3zJVA6Ct9yTrdgBYqy9rlG2csFaq
   GS/P7njRz5y5finEoA2Sg5vRRa8rP8WGJjojg9KeaqjvCnjCQlUYbG5Vz
   dTW+dquxevZlU86YVMfkU85qq+a2YE2i3A+YDEfpxngQ9M4t06DOeRIWY
   ShGlbVwJR6sWVJWrZ/SDXrTmaZ5qqg2dmUYpBXFPo4tljOrmabhydKzdo
   YQs2/AdTIF9WOVbWzApDfpHiRwNmBTPg/+NAqktto4UILW/LNKdoU7sZG
   OvFcrRDkKQSZ8nmN5fuzRfGatLOztjV+5dPV4gECiSyKd41ly9H7oCIaH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309512670"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="309512670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 09:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776120197"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776120197"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2023 09:18:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 09:18:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 8 Feb 2023 09:18:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 8 Feb 2023 09:18:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 8 Feb 2023 09:18:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCdFQLquq9Ivi6JntB5rmXB2gpH3glozbVcz+7mfhL5K4UnRWU7AODjCeY2Sg+sgxWCItTb6vr334Ekj+4ZdVmHKyNEpDqw5wJC0/D+q7Y5w4FdqraVoQlwaquQs8K13ygG0yQLXQ0ODNcCK440zbIuNtmRe1pMq84q+LULYyF4aNF4jeIscSVoGlEFfc/Aa42qW5STk6LC73IHGqT0qfdRACGDLO9TtgOOGOM98h49uBGmM2Mr60+Mw1jteicluWC2L0dmE2ZRStixVUu7SZiiRXnE23pJPEne+Nn1QIFHmCIvMwsNzUBHZcUUBQYqc8rKqbX5lgBZ/rs+xUGzR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9XpTUPGzB5VA7asaa9mlS+1tL6+loduzM45vt2zlt0=;
 b=oHBTw/XULn0AuXTH9l2MVvMpfpis4i5tPUAPDgM7KWAxbBat8dIlbVTvQOUaizWrusqrCYzHrBFxIMZk/4QxZc77yX8D9D+0oNeESdg1h9klZP7AJZrvGh7tVd+JC5PYGN1R7EVkzFAaAYIHBuXjZQfmFjKQ+ac10cUOjasBO32l3qM4dbnJ/XoHLZHG+CDCsYA9pknb/cOqkfYir3wV+OhCjp7vjWhvAaT0TLdLxoxnW9zUamWCVmzT8qUDnmf/PcIfpCfOE494d6VGr6GGfbteQ/BfeBMANv4P38jAymY0Ljm7H9LyZ+XaDayT2OuWcXqahB/5PoKXjT1d9WO0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB7634.namprd11.prod.outlook.com (2603:10b6:510:28d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 17:18:35 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%11]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 17:18:35 +0000
Message-ID: <4faa4c54-8918-0a86-7cd6-c69b2e49c533@intel.com>
Date:   Wed, 8 Feb 2023 09:18:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v5] x86/resctrl: Clear staged_config[] before and after it
 is used
Content-Language: en-US
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jamie@nuviainc.com" <jamie@nuviainc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnwang@linux.alibaba.com" <shawnwang@linux.alibaba.com>
References: <2fad13f49fbe89687fc40e9a5a61f23a28d1507a.1673988935.git.reinette.chatre@intel.com>
 <IA1PR11MB6097018866A49457E8D6F70A9BC79@IA1PR11MB6097.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <IA1PR11MB6097018866A49457E8D6F70A9BC79@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 208db552-cdbe-4941-3068-08db09f8826b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LScbUIRkkt8uptErV8UrISqAQnWvIvrhgo7cJB6vKpjwWg4VN/JyZ+8FWcnYdWEFSBDEPezlKzzZpixzgLcNlQ8n8Dp/jdBjRH/2hwvbf6GrVrCvQzEXORCdTwcJ7aGHiBw/Kd5Sz0UQU4KRML8g7/CqtrcsfxeqzuGHyRXgDctFwMIybfl5PdIPieeZ81uw6w0PuJRaHHKBo2sOjv51k2+KAFz+JYcOHq/UDPsyCAveHYI+lqhiHmaWaPfRCTRbHB1oGdk5/kugd14W+IhUAKxnUaNWPCrs2eCHqH4l7XKUBx2t3chE/e6B7YNpx9E4holWIgcGiIPhS54qiQVMxa9kuyiam69aGRki/s0lThsrwgOn0ujLv7oZ4VXZxAzdQaEM//ms+cteillsrBehvCZ8TEdGakz+wvg2tf1z7LBJYI0N+s9OmBOLwasP6/QsiNPZRmL7X8P8bfGMOMWPHCgCQdtuO3w03o4ZHposUTdHBirb+tVKlXzPauFrZeCwWtxmVT1mrQjxTrnoNku6JHR/oE6c4gpasSYkUPFMoq1EXdVunkJCfq5pHJRJPsmxNq/G4AA9ly9DtrZS3C1zft7ZaNwAPuOCdRBaUjG0k0r7f5nMrvUW53Y03YN0dZitmHuARl9kLewT6tuZDpSNa/9dxhU7k+kvj7J9IVKQt14cihK9ZWz5Usuwf4pB3Cpcr0ukskn41Xq3Yjb2nD2Al+IUWceHaK6e5Eu/5vvhFjIC8JukoWGVion8z8PoYzfKdqKKeskjDq9tO/4lD+Rapw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199018)(5660300002)(36756003)(2906002)(7416002)(44832011)(83380400001)(2616005)(82960400001)(38100700002)(8676002)(4326008)(66946007)(110136005)(54906003)(66476007)(8936002)(26005)(6666004)(66556008)(41300700001)(186003)(6512007)(31696002)(6506007)(53546011)(316002)(478600001)(86362001)(966005)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDlIYzhtRkFYTURjbmZFMkUrN29hOGZpNFA2M3hHdVpoZFk5R2kvc3M3U25v?=
 =?utf-8?B?cXUvLzZNZkltVXNtSVRwV25WSkVnaWVaV1hubmIySG9uR0E0RjdQUFo3L3V2?=
 =?utf-8?B?Y0FqRDlXMytYMjVtMlVPNEVZT1R4K1NWWUZtYnptZEo3dHhxQ1JBOUd2ZzFy?=
 =?utf-8?B?YlRQMzlzcGpxLzNieEFNc1V6ZEFUbmFQazRxUXdsK1pJYVRIdlJVU1FweGxn?=
 =?utf-8?B?bXBlSEFzd3d5Y0RLcklNYVZQYlB5aGJQMUw0eVEwcnF0bW9pY2FIRmZBZ3Vk?=
 =?utf-8?B?S0JZWk51aktvVDlrM1VJYmdGN1E0Q1VjMHp2RzhxOXhlc0RxRE1WWU9yR21a?=
 =?utf-8?B?dk5ZT0NZbENaQkpEeTRLblAxazVTb3FPSFdUaUhnV2o4b1dXMGpVeGxzZnZl?=
 =?utf-8?B?dHFuZ3ZEWkRVRzVzTzQrNzBaYjViL0NENS85b2dnRUxyZGgxOFhsOXNJZGZF?=
 =?utf-8?B?TE52bWpMeWJLajFvSFJISEMxZEVXQVU1NGRpQ0xrZ2FQcHFVbHlmYk9NamY4?=
 =?utf-8?B?T1RNTWoxaVBsbE5DR296dDBvc2hLMmVqZVNVOWJ2MG5JUUNkUStuL21Na2Jr?=
 =?utf-8?B?T2Z0azZiUTlxU01LZ2g4MDFuM0JYdE1xYXVpbG0wY1ptc0psbk0zN0svU2pj?=
 =?utf-8?B?R0lYUlBaWWk3RGp5aWZZZW14ZGsvb0k5NXhQY2E4MTBnL2pETXV3SER2VWh1?=
 =?utf-8?B?WmtINVpROWNnRkZwc1AzT0V2V2ZOY0tEUmhOWG10Y2MwQ3ZxL0dOZEdqYVBy?=
 =?utf-8?B?bDRPd2FsNmhYVng0U1JJdFV4RUkzQ2s4MUpuVnRna0Z6ZFpPdkJEY3hZVzhv?=
 =?utf-8?B?OUEwbVYzZnVyUWRmT3l6eklWb3lVcFlaTFFjbTJJSkk3cnVxUktva2VGdmFN?=
 =?utf-8?B?NDdLOUQwUWFOZG5Xb09ZckxidTUvMUt2NjNPcnFPbEEvZkZNTDh5Z1kyKzhN?=
 =?utf-8?B?bWdmZEJMOVoxZ0ZYU1F3WCtRajhIUStPb3YwbW4xUEsyWUJrbEFNRmFkK09Z?=
 =?utf-8?B?L1p3RC9mcVZKVHpUMFkwSUFDbnE4SkxGaThDSGRkMDZOaE56cE9KWDN5MTNY?=
 =?utf-8?B?M3ZwbFZEelN3VlJuc0dJU3NnUlFmNldzOExIUyt4ZUtEQ1VKMEsyaXJKbUx6?=
 =?utf-8?B?eGFuU2t1NHI1bmFJQzZrVnZob05KTFB3MU1xeWM2cVhxZFhNQjY1YTBhUDJY?=
 =?utf-8?B?L2xVd2ZQMjVZTGtpRTdIK2RGVldpTi9YWnNkQ1JtY2xDM2dVNVZHUldUQXFj?=
 =?utf-8?B?d3R3bXVUOG0yK2JCRzl0eDhLUS9TbklSUDRQVjdLVXZ3NEZaemtZMXR2U0Vq?=
 =?utf-8?B?TlkwdmdrWStzY0VLMnp3Z21GUGtQMll6M1AxNFltc0FyODZFbmYzZDE5Tkls?=
 =?utf-8?B?QnMxd1RyZXowWTNOTXhWOUNiYTJSa294VHk2K2tWTXBJZ0l4aFdRQzlqaTAz?=
 =?utf-8?B?R1VIWEFKNEZDT3JXS0RaL2VuSUNHRDdNTisyZ29keHpKaG5rcGtkeW9yZDAv?=
 =?utf-8?B?cFQrdXJOQWExNTMzUTFCVWVVQmJsWkZHczgwUEpSRTJRQVFFMmFrdUlkRXY4?=
 =?utf-8?B?WUtiODZHWEo2Mkx3UURxc2RkZ1dKYVZQeUJyUHdkQXkrbVViaWlJYTlQQ2Nq?=
 =?utf-8?B?Zkk1ZnNVZ1lDS2NmdVFaUDJLZ0Z3QTZyOElTVElDUGNZMCttNTNFMVAzelBh?=
 =?utf-8?B?bGtlVEJHTnJVbkxUVXZMUThJNHR0YVVQZFJ4SmJOS2ZHejFUUk1pcU55SWRC?=
 =?utf-8?B?czhsU2dMdFZwaDNWS0V4bmJFQjhWamtuQm9TWWdzVldGSnI3azl3cVlmSUhn?=
 =?utf-8?B?Q01DV1V4VXVrQjVQdDRpMnBKcUh0Ykxmc2pBcEl4NTI3YzMzY2d2Y2MvZy9O?=
 =?utf-8?B?U3B2clhNeWR4MkprYzJFdFRVN0Vud29YUExTV0VRdDJucXhqcHkvdU90K2Iy?=
 =?utf-8?B?Z0pMb2JTT2lxTEZ5WDZpdlZHdUxsVWs5bGNCQUFRcmFsKzFLMklta2w0OVlo?=
 =?utf-8?B?V1oxTkpIUm1RdUVIbVJ3aktNYllPdHdQY20zQXd0Mm95WVVQZW1OakEranpm?=
 =?utf-8?B?T1Rub3A2NFpKQUQ0eHh5WjlVK1ZINkt1OXVVN1JQOHE0TC9xb2x5VHlxcDZw?=
 =?utf-8?B?Nmk0ajNpK1c1d0U4YVAyNnAvYkM5YW1NNnNpMEFaNjhpN2pNK3pWYmJuelpJ?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 208db552-cdbe-4941-3068-08db09f8826b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 17:18:35.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRTkUrfCQDuhdFyoTtxTlZfn8ZaOYMOCitkFrKp09XLFFDtw84lxB51y/3p3F1u2BXwEbYNHfcAIWZ8DQJ5BNLsqP998QkXNTeaczgHrSDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7634
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 Maintainers,

Could you please consider this fix for inclusion?

Thank you very much

Reinette

On 1/18/2023 1:22 PM, Yu, Fenghua wrote:
>> Chatre, Reinette <reinette.chatre@intel.com> writes
>> Sent: Tuesday, January 17, 2023 1:15 PM
>> To: Yu, Fenghua <fenghua.yu@intel.com>; bp@alien8.de;
>> dave.hansen@linux.intel.com; tglx@linutronix.de; mingo@redhat.com;
>> x86@kernel.org
>> Cc: hpa@zytor.com; james.morse@arm.com; jamie@nuviainc.com; linux-
>> kernel@vger.kernel.org; shawnwang@linux.alibaba.com; Chatre, Reinette
>> <reinette.chatre@intel.com>
>> Subject: [PATCH v5] x86/resctrl: Clear staged_config[] before and after it is used
>>
>> From: Shawn Wang <shawnwang@linux.alibaba.com>
>>
>> As a temporary storage, staged_config[] in rdt_domain should be cleared before
>> and after it is used. The stale value in staged_config[] could cause an MSR
>> access error.
>>
>> Here is a reproducer on a system with 16 usable CLOSIDs for a 15-way L3 Cache
>> (MBA should be disabled if the number of CLOSIDs for MB is less than
>> 16.) :
>> 	mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>> 	mkdir /sys/fs/resctrl/p{1..7}
>> 	umount /sys/fs/resctrl/
>> 	mount -t resctrl resctrl /sys/fs/resctrl
>> 	mkdir /sys/fs/resctrl/p{1..8}
>>
>> An error occurs when creating resource group named p8:
>>     unchecked MSR access error: WRMSR to 0xca0 (tried to write
>> 0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
>>     Call Trace:
>>      <IRQ>
>>      __flush_smp_call_function_queue+0x11d/0x170
>>      __sysvec_call_function+0x24/0xd0
>>      sysvec_call_function+0x89/0xc0
>>      </IRQ>
>>      <TASK>
>>      asm_sysvec_call_function+0x16/0x20
>>
>> When creating a new resource control group, hardware will be configured by
>> the following process:
>>     rdtgroup_mkdir()
>>       rdtgroup_mkdir_ctrl_mon()
>>         rdtgroup_init_alloc()
>>           resctrl_arch_update_domains()
>>
>> resctrl_arch_update_domains() iterates and updates all resctrl_conf_type whose
>> have_new_ctrl is true. Since staged_config[] holds the same values as when CDP
>> was enabled, it will continue to update the CDP_CODE and CDP_DATA
>> configurations. When group p8 is created, get_config_index() called in
>> resctrl_arch_update_domains() will return 16 and 17 as the CLOSIDs for
>> CDP_CODE and CDP_DATA, which will be translated to an invalid register -
>> 0xca0 in this scenario.
>>
>> Fix it by clearing staged_config[] before and after it is used.
>>
>> [reinette: re-order commit tags]
>>
>> Fixes: 75408e43509e ("x86/resctrl: Allow different CODE/DATA configurations
>> to be staged")
>> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
>> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>> Changes since v4:
>> - Essentially a resubmit of v4, changes limited to commit tags.
>> - v4: https://lore.kernel.org/lkml/20221209024436.22170-1-
>> shawnwang@linux.alibaba.com/
>> - No changes to patch.
>> - Only change in changelog is re-ordering of commit tags.
>> - Add Reinette's Tested-by, but change the Reviewed-by to Signed-off-by
>>   because of the change in hands of this submission.
>>
>> Changes since v3:
>> - Update the commit message suggested by Reiniette Chatre.
>> - Rename resctrl_staged_configs_clear() to rdt_staged_configs_clear().
>> - Move rdt_staged_configs_clear() to arch/x86/kernel/cpu/resctrl/internal.h.
>>
>> Changes since v2:
>> - Update the commit message suggested by Reiniette Chatre.
>> - Make the clearing work more robust.
>>
>> Changes since v1:
>> - Move the clearing from schemata_list_destroy() to
>> resctrl_arch_update_domains().
>> - Update the commit message suggested by Reiniette Chatre.
>> - Add stable tag suggested by James Morse.
>>
>>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  7 ++-----
>>  arch/x86/kernel/cpu/resctrl/internal.h    |  1 +
>>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 25 +++++++++++++++++++----
>>  3 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index 1df0e3262bca..bcdc679dad4e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -373,7 +373,6 @@ ssize_t rdtgroup_schemata_write(struct
>> kernfs_open_file *of,  {
>>  	struct resctrl_schema *s;
>>  	struct rdtgroup *rdtgrp;
>> -	struct rdt_domain *dom;
>>  	struct rdt_resource *r;
>>  	char *tok, *resname;
>>  	int ret = 0;
>> @@ -402,10 +401,7 @@ ssize_t rdtgroup_schemata_write(struct
>> kernfs_open_file *of,
>>  		goto out;
>>  	}
>>
>> -	list_for_each_entry(s, &resctrl_schema_all, list) {
>> -		list_for_each_entry(dom, &s->res->domains, list)
>> -			memset(dom->staged_config, 0, sizeof(dom-
>>> staged_config));
>> -	}
>> +	rdt_staged_configs_clear();
>>
>>  	while ((tok = strsep(&buf, "\n")) != NULL) {
>>  		resname = strim(strsep(&tok, ":"));
>> @@ -450,6 +446,7 @@ ssize_t rdtgroup_schemata_write(struct
>> kernfs_open_file *of,
>>  	}
>>
>>  out:
>> +	rdt_staged_configs_clear();
>>  	rdtgroup_kn_unlock(of->kn);
>>  	cpus_read_unlock();
>>  	return ret ?: nbytes;
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 5ebd28e6aa0c..f43eb7340ca5 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -527,5 +527,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct
>> rdt_domain *d);  void __check_limbo(struct rdt_domain *d, bool force_free);
>> void rdt_domain_reconfigure_cdp(struct rdt_resource *r);  void __init
>> thread_throttle_mode_init(void);
>> +void rdt_staged_configs_clear(void);
>>
>>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */ diff --git
>> a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 5993da21d822..41e89fc49d77 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -78,6 +78,19 @@ void rdt_last_cmd_printf(const char *fmt, ...)
>>  	va_end(ap);
>>  }
>>
>> +void rdt_staged_configs_clear(void)
>> +{
>> +	struct rdt_resource *r;
>> +	struct rdt_domain *dom;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	for_each_alloc_capable_rdt_resource(r) {
>> +		list_for_each_entry(dom, &r->domains, list)
>> +			memset(dom->staged_config, 0, sizeof(dom-
>>> staged_config));
>> +	}
>> +}
>> +
>>  /*
>>   * Trivial allocator for CLOSIDs. Since h/w only supports a small number,
>>   * we can keep a bitmap of free CLOSIDs in a single integer.
>> @@ -2851,7 +2864,9 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
>> {
>>  	struct resctrl_schema *s;
>>  	struct rdt_resource *r;
>> -	int ret;
>> +	int ret = 0;
>> +
>> +	rdt_staged_configs_clear();
>>
>>  	list_for_each_entry(s, &resctrl_schema_all, list) {
>>  		r = s->res;
>> @@ -2862,20 +2877,22 @@ static int rdtgroup_init_alloc(struct rdtgroup
>> *rdtgrp)
>>  		} else {
>>  			ret = rdtgroup_init_cat(s, rdtgrp->closid);
>>  			if (ret < 0)
>> -				return ret;
>> +				goto out;
>>  		}
>>
>>  		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
>>  		if (ret < 0) {
>>  			rdt_last_cmd_puts("Failed to initialize allocations\n");
>> -			return ret;
>> +			goto out;
>>  		}
>>
>>  	}
>>
>>  	rdtgrp->mode = RDT_MODE_SHAREABLE;
>>
>> -	return 0;
>> +out:
>> +	rdt_staged_configs_clear();
>> +	return ret;
>>  }
>>
>>  static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>> --
>> 2.34.1
> 
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> 
> Thanks.
> 
> -Fenghua
