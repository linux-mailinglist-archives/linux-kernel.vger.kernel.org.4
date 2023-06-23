Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455C73C3DC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjFWWQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjFWWQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:16:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF75526B9;
        Fri, 23 Jun 2023 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687558595; x=1719094595;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CT4nIN2ah6wviQSlHaxW/D195ADb8WaKEbTIPxV5+bQ=;
  b=Fru8+UdrSPQ2mb7BKIZ6B5rDKQ6LrAwc9+J9zl+WrBZaPYiu74/73jZ1
   xR9joO+MVsKsm0sMOlXvb5IGZH1Tq43UnOSQt649mK3lHfCIOgE9NqMAy
   RMt1xiyCAfz1RsYToJ+g+fzPI0jloOWM2RZeE44iSfVx2H37ub4TEW0T/
   SDaLAP7Q/h2diGgP2XWxxEinqTDfezmxqMHocD4kRz/k19H+SylcQmq04
   b/1zBuG8sofG5fE4wyKmVI6K1+dgK500Vl3h/ux9TbjJFPHOjfDo/9OeE
   t+R2+wQXwLn6jXbx3KgjVhBSYPd+ehwYe5yoqWw/Sy1Ma3lfzT3QIvNET
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340466628"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="340466628"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 15:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="718673243"
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200"; 
   d="scan'208";a="718673243"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2023 15:16:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 15:16:30 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 15:16:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 15:16:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 15:16:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha6g2YnmoKTm+bi8qDugBuXRm+0NAlqxm8hXsDkNl9KhgUxFl1wPGtxzGhZZV6T0LriS4NBzUaJ4veE8pz4HUtglX2316ASQa0tSFlDN1uSe5GcJFcTzvmf3LOoUkYvafKvyZLDF7JP0gG/dYpY0LUlbblIeo40cVV2nTd0dOMwUapOfvoE7snNtDc4GTxnoT9Zr8pmK/B/jiKaNq0gx2yvSIcp3/5y1G96wPk4PIIWrwGbn3zjNXhHLCj9TWhe6nF5yiXEyljH0iyfbvJn7niSWm4p+zHKmcxAbX12kyCLZgRFHHIqGgPhL0P75JdZhxJhKpHZPyx9v2EJnTRBEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/KoBvxmAnC0E3yjGR3OoRjoQHSplXAAE7Nmgiy87pw=;
 b=AvklpEPqvgqx79s5P4BYTXfWix+ipJg3ckkZohZANDX1CrEbtUfQLdbKog5GBzWzyeLyDIE6S4DK296hx7rgJDZv3JGiS4/OzEKH11yEICqU2gKUAgDi+iFVlSaN3vkjwD66SdL2dGvLpwvIGmKQ8gkhCf8RWs9Ibt4JCMxS9gyWboq5gSKY8Kn34CfXeA95pXI6ANXWMgvyuFqk2L5AWIUw+dB0HbDkHxlo5OkPFPg96cLzrGlkI3DuZzQXjXBYlitmpO01P0RgpMkrtlZRkp2xB+HZh0Smwfjjw0wVRk1E1PbuoR8o6SueOyqiVFFmWt3XWBMO9HkXjRpS1KzZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 22:16:27 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 22:16:26 +0000
Message-ID: <98a0e78c-5b78-136e-f955-0d8680c3c6b0@intel.com>
Date:   Fri, 23 Jun 2023 15:16:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v7 25/27] PCI/AER: Forward RCH downstream port-detected
 errors to the CXL.mem dev handler
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <rrichter@amd.com>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
 <20230622205523.85375-26-terry.bowman@amd.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230622205523.85375-26-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a248d3-2f99-4fca-e384-08db74377c87
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWnLtKf2NlCM6kC1t6k4iO8NH2hWqJdlQXsUzc/9gWahUDFFxpW8GHBDOFgIPQ98LgydMYFR2Tz/pXbbFfeIJ2HTbgf7yJSmzonwrmATqtyJZ6zQDqQAEmsz47i3xptQIsJkOWZzKAmoBNfpL6Nx+Y99p551P+21honME6Vq2vX/YR6pGWx2/fr6h0J3t/lT699gP0x4uZLMwUU/cfDylez5i6RDnOxTZg3foeT8Ep+EUIvFmo3P54HrKqHpwo6iystlyQaajEr1wpXfe/tQs4PlGOJuDYnPNKxuWBuDz/YpMH3TZAy69szsGGhenYoHkj9j2e+wnzGhNfPdajzxWTe4sGL7z6ND4yH+nSO+3hAe+Sc/dDDg/letWV7iMNTdF0DKKZEIN9wU1jSUkRynMq0ovsCM10JVjr3Pi0T49pGhzOUhmWT3L424FErg/morNOa0eKTeDN6hvBzEs3Vcx8nuQKBH/pmjrUhC0CXlVmLgrs6bvSqDllFUYZGQEMND2Ln6FraWiImT33+eDE9drYclUmuR74ihskFJqIQmnMWAFrgF5JnkEoGNYnf4TRwZdT6quCvwuwXCjWsTEhiWriQT/szM8OQQ1zYOiYXPppN/tCK8KKjW5UgtHy4WgJBzQ3ad0JNETPgyF/R/irlcnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199021)(41300700001)(66946007)(4326008)(66476007)(8676002)(6512007)(26005)(316002)(186003)(53546011)(6506007)(8936002)(2616005)(966005)(66556008)(6486002)(478600001)(6666004)(5660300002)(2906002)(44832011)(82960400001)(38100700002)(36756003)(86362001)(31696002)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzhkKy9HWTBuOENJZmVJZ1BnNVVCTTh3cURaZTIwKzFhcHBRR2d6bGFGQjAr?=
 =?utf-8?B?VGs2Vkd4cml5SW9PejdIWWVwYXFYUllFNGMwVTRrb2c0NXFhVDVEV3daRE5T?=
 =?utf-8?B?OWxmUkJXNTc2dkhFMDJ0cUhKWjBVOVA4Rko4azd1Z2E1RFl3Zk9NS0U4TndN?=
 =?utf-8?B?cEYyZS81bU1PWVBVYm9LelJzK2s1NmlJQkhsNXhMOTRJYlFGTXY5Q0dDWElQ?=
 =?utf-8?B?a0hGdnIrNis4eEt4S1hLMnF2b1l1VGVLZWtXekwvRmJrSkNaU2pXTlpCTjll?=
 =?utf-8?B?bG04QjRQKy8rNjQ4UUNFU3huM0tydUtORnN5RW9OMXhVSVRrQmNLUTlZQ0Rh?=
 =?utf-8?B?U2xha3gzZWd1Ym55OEJBa3NHb2xTY1Z4SW44Wis3VHZmSytCa0UrbVlRQU1Y?=
 =?utf-8?B?SVY3cmJXSnk3MTVJNDVvZEFnb3EvV21pUTNhMmdUQzZyVEdXSUM4V1M4QVpv?=
 =?utf-8?B?dFNwMTZ5OTQ1dElINVF6K2xTTUdEU2tjNHk3ajc5VE9ybWF3QUVOejl6ZmNo?=
 =?utf-8?B?Vmowa1JBVWY0ZWNYMWQ1MU9iekkwNXJER05pd2s0dlp0Kzl4OEpMeHRVbVNB?=
 =?utf-8?B?aTJ1bklTZ3VraEpoT1dCSlpmUGdQeFduWUordmRNaGt5SXlRdWVIS09HYitI?=
 =?utf-8?B?SkxseW4xMGNzOGNpREdiUGVnb0ZjTGNlemNBWlZYeFpWaGUzbkdNT2xGUVZi?=
 =?utf-8?B?Ymg0SEZWcDJrZDl1alRybTBIeWNjUjlET1Y3UlZPWHArTGFka0tEMTdab21P?=
 =?utf-8?B?SS8vV3RwL0ZZQVBKWTZlSWREVG9FQW5CL0hKRVhLRWY4UzlqWGZReHdvWWZ5?=
 =?utf-8?B?REFMamd3MlRoNzlUM1VvY1FLZFlJR1NUUERBbHN3a0tUMWNveFp6Y2dDaEhB?=
 =?utf-8?B?Zy9mRzhGWHg2eUFMZXlJU2J0V2I2MWVjdU1TMkI0Q2NUUng3czhGcFY0Uyt5?=
 =?utf-8?B?N21nejFYblNlTm1sMTY2MU9SNG5wekxIYzMrTUtQNUs3bTZFWVlUWTFwUGlm?=
 =?utf-8?B?NTNKOGxoRndQT29HWmJrZmNUT2piaFJuMldTSnVSbTlsQkRyNUtFazMyNXdJ?=
 =?utf-8?B?ZzFUanlHNkUxeW1uN1dEb1FOa2RrTnRrY1h3UWg5b1hmSnE1c2FDL3BSSkV6?=
 =?utf-8?B?MGlyYkdUc0Rsb1FUVWNPbHpQcEZsWWtPVG1ERmo2V2dCTFc2UUVzL2J4SERa?=
 =?utf-8?B?N1hEcXNvcTlGKzJURnZEcVBxODRDV1JxcVFMQ0c5UHJUTHpnUWVVQUZOQkE5?=
 =?utf-8?B?ZFdMY3VzRE5qME9FQnVQNVkxSTNJT1RkWDdUOStDcGRvc2wzYnppcUdiczNG?=
 =?utf-8?B?dkI4Q3JzWkZ5dW95ckRFTGp0SGJibE96VHdVR2liMzlMV2s3cGVOUTZwYU5m?=
 =?utf-8?B?MFJqMHBpemsvaDJndDEweWUwV2xNcE1KOFUzTkJObzhkQk9rejJnRFBZTWFH?=
 =?utf-8?B?c252R3l3ZXhva21RY0xhZ1JZV0grbFNaV3VKVnJNREk3d1k4Q0tCczlmM09t?=
 =?utf-8?B?U004UU5RZEczSG9vVUduZndDU1FQZ3pUSlhoUDJ4OTNGWTRaWUZvcmJlK0pQ?=
 =?utf-8?B?UDJlRVIyYnlKeHZWV0pSaTR6c3dnL2FKV3laTjRlYXd0VzhWTldZQXpMTHJ1?=
 =?utf-8?B?RlRsdWZGek9EL0NtUnNDd3VRVFVmbUtxQlIreXorUkgwT0VuTFhqUHg2WWNr?=
 =?utf-8?B?MWZHeUwzWXhCZjVBaDloMUt1YlV3ZTBLRlBvRGtwSXhJU3FqNlJUSWFsdmlr?=
 =?utf-8?B?em1ZWDRzSk1VdldVcmVoc2N4Nitkc0d5d3JuZmhOM3ZWM1dQb3RRdUk4YmZn?=
 =?utf-8?B?MlgyYkdGNmwxdDJqY2poNUlCSGZvcy9OYVVWSGU3Ti9VNEl1TWxmcGwraG40?=
 =?utf-8?B?R3Z2aXB2MjVTNWxYY3FnUEpGN2xTanJYNlJEaSthdXVVQ2haNTdDa05IMGV6?=
 =?utf-8?B?UTIzTEN4bDZ3SUFsbDlkN2E1QXlJb0d0bkwvMWh1aUJLdGxJQ3ZhZzd4aWFl?=
 =?utf-8?B?QWlkYmk2UDc0UGk5bkh1bVI5Zzg0MWxyYXFPVFUxRTFsYmRldnB4K3RNdUJr?=
 =?utf-8?B?V2FtSUx4NEdnRW9iQXphUlI4RkJsODhtK2JDVEJjRytuUm11Q1JzUHJyalYr?=
 =?utf-8?Q?/NPKQGI7ks6LMCKJVhtrg0+y7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a248d3-2f99-4fca-e384-08db74377c87
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:16:26.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/+QOcUyHLInpRHO48Z22ONB5rcS9QItVt0PSmqwvWEGgmGVx2PPAw7q8gMeXMSQr1+SPtPWTNWnpq++mY1ghg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/23 13:55, Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> In Restricted CXL Device (RCD) mode a CXL device is exposed as an
> RCiEP, but CXL downstream and upstream ports are not enumerated and
> not visible in the PCIe hierarchy. [1] Protocol and link errors from
> these non-enumerated ports are signaled as internal AER errors, either
> Uncorrectable Internal Error (UIE) or Corrected Internal Errors (CIE)
> via an RCEC.
> 
> Restricted CXL host (RCH) downstream port-detected errors have the
> Requster ID of the RCEC set in the RCEC's AER Error Source ID

s/Requster/Requester/

> register. A CXL handler must then inspect the error status in various
> CXL registers residing in the dport's component register space (CXL
> RAS capability) or the dport's RCRB (PCIe AER extended
> capability). [2]
> 
> Errors showing up in the RCEC's error handler must be handled and
> connected to the CXL subsystem. Implement this by forwarding the error
> to all CXL devices below the RCEC. Since the entire CXL device is
> controlled only using PCIe Configuration Space of device 0, function
> 0, only pass it there [3]. The error handling is limited to currently
> supported devices with the Memory Device class code set (CXL Type 3
> Device, PCI_CLASS_MEMORY_CXL, 502h), handle downstream port errors in
> the device's cxl_pci driver. Support for other CXL Device Types
> (e.g. a CXL.cache Device) can be added later.
> 
> To handle downstream port errors in addition to errors directed to the
> CXL endpoint device, a handler must also inspect the CXL RAS and PCIe
> AER capabilities of the CXL downstream port the device is connected
> to.
> 
> Since CXL downstream port errors are signaled using internal errors,
> the handler requires those errors to be unmasked. This is subject of a
> follow-on patch.
> 
> The reason for choosing this implementation is that the AER service
> driver claims the RCEC device, but does not allow it to register a
> custom specific handler to support CXL. Connecting the RCEC hard-wired
> with a CXL handler does not work, as the CXL subsystem might not be
> present all the time. The alternative to add an implementation to the
> portdrv to allow the registration of a custom RCEC error handler isn't
> worth doing it as CXL would be its only user. Instead, just check for
> an CXL RCEC and pass it down to the connected CXL device's error
> handler. With this approach the code can entirely be implemented in
> the PCIe AER driver and is independent of the CXL subsystem. The CXL
> driver only provides the handler.
> 
> [1] CXL 3.0 spec: 9.11.8 CXL Devices Attached to an RCH
> [2] CXL 3.0 spec, 12.2.1.1 RCH Downstream Port-detected Errors
> [3] CXL 3.0 spec, 8.1.3 PCIe DVSEC for CXL Devices
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/pci/pcie/Kconfig | 12 +++++
>   drivers/pci/pcie/aer.c   | 96 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 106 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 228652a59f27..4f0e70fafe2d 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -49,6 +49,18 @@ config PCIEAER_INJECT
>   	  gotten from:
>   	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
>   
> +config PCIEAER_CXL
> +	bool "PCI Express CXL RAS support for Restricted Hosts (RCH)"
> +	default y
> +	depends on PCIEAER && CXL_PCI
> +	help
> +	  Enables error handling of downstream ports of a CXL host
> +	  that is operating in RCD mode (Restricted CXL Host, RCH).
> +	  The downstream port reports AER errors to a given RCEC.
> +	  Errors are handled by the CXL memory device driver.
> +
> +	  If unsure, say Y.
> +
>   #
>   # PCI Express ECRC
>   #
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d3344fcf1f79..c354ca5e8f2b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -946,14 +946,100 @@ static bool find_source_device(struct pci_dev *parent,
>   	return true;
>   }
>   
> +#ifdef CONFIG_PCIEAER_CXL
> +
> +static bool is_cxl_mem_dev(struct pci_dev *dev)
> +{
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.0, 8.1.3).
> +	 */
> +	if (dev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.0, 8.1.12.1).
> +	 */
> +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool cxl_error_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	if (pcie_ports_native)
> +		return true;
> +
> +	return host->native_aer && host->native_cxl_error;
> +}
> +
> +static bool is_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +{
> +	struct aer_err_info *info = (struct aer_err_info *)data;
> +	const struct pci_error_handlers *err_handler;
> +
> +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +		return 0;
> +
> +	/* protect dev->driver */
> +	device_lock(&dev->dev);
> +
> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> +	if (!err_handler)
> +		goto out;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		if (err_handler->cor_error_detected)
> +			err_handler->cor_error_detected(dev);
> +	} else if (err_handler->error_detected) {
> +		if (info->severity == AER_NONFATAL)
> +			err_handler->error_detected(dev, pci_channel_io_normal);
> +		else if (info->severity == AER_FATAL)
> +			err_handler->error_detected(dev, pci_channel_io_frozen);
> +	}
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> +	    is_internal_error(info))
> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +}
> +
> +#else
> +static inline void cxl_rch_handle_error(struct pci_dev *dev,
> +					struct aer_err_info *info) { }
> +#endif
> +
>   /**
> - * handle_error_source - handle logging error into an event log
> + * pci_aer_handle_error - handle logging error into an event log
>    * @dev: pointer to pci_dev data structure of error source device
>    * @info: comprehensive error information
>    *
>    * Invoked when an error being detected by Root Port.
>    */
> -static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> +static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	int aer = dev->aer_cap;
>   
> @@ -977,6 +1063,12 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>   		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>   	else if (info->severity == AER_FATAL)
>   		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
> +}
> +
> +static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	cxl_rch_handle_error(dev, info);
> +	pci_aer_handle_error(dev, info);
>   	pci_dev_put(dev);
>   }
>   
