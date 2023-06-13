Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120272E848
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243023AbjFMQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbjFMQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:19:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80513E6;
        Tue, 13 Jun 2023 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686673193; x=1718209193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2YJbf+meZL0LAidrhAXBb8Q6jkTyL+HzTKM+oYd3uNw=;
  b=NUp136byKvqxMQ+VmdjPojdIjSBZ4D+XwubqeN0SqoOfCYlPOkOyyDRY
   7YYw0Cntu3ZnOJXSV9MUZ1h+vyy3PUqJD7Y53REue+sAKrIEY9gZ73SeT
   2WcADDO0IYjsqo5nRUZ44jndCqWwD/N7yghllzMdehOFaQoPmHGnGJFzv
   8Ydqa0MMXPIz65bZ5Y8gNmd8GlMhTasthvzm8f6GrpiH2i7qMhpi3TQ+y
   9v9Q7xpjtYc6uEdql59p9+jogt0z/PxuvMfqxsXjDpnvx4kCn5qIzzuqy
   aD44pYy5FhB/oIOOg5SNseaDBKGBNpAtbXApTaMpkKA+8kdzbWtw2rwrq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="444756115"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="444756115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 09:19:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="824466516"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="824466516"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jun 2023 09:19:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:19:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:19:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 09:19:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 09:19:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk4qEruVTac+84KPv24/fGP29EIcGz4otstR+johGSAhKKTXZSvGcfFIafxb9YoMV4iXJYTp3Hrl4fB+HL4nzLAGkP+5eD1CzrcAYjtgwnf342wXPvDw5AU0n138Uc0v7fyHCUDhYBqHEl08yLTt7eDGodvKnSS/zb4nEKJTSLQ7Fh8P7iwjjrcYjFAt6HAUDDozSKNNhfd0B4zUy8RP95ZybKNBpnr1mnID9so6o5dfjRj5xfGHVdJm1RJXBEjMfUE9dzcYftIwv6uEp5PHpk0nMrw9sAoZEKE5jl5tbz7ioUCivPiv44wZMrFAqRp8So+GDu4xcScTP4ryzO4o0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDqzylaqTnnu//nr9TA6Ohnhz9Vr1Sn4k1tJQUBpQSA=;
 b=CFR4mv23CQWLQjRMukv9sKMyug3qWr1eeCqhWnuy+RvTVxVaaEGu9BW11sG64gjHruHmr8RlJsMwHoDSirafEmo1lSsAUv9Qs/kHgqMyMRIj64jTNuCXrtiMSfkS3sKzAa2RE6K0oI6KKZPz3kh8b7R7fhdcUyfTwfanrA7TI0fTlKExKT42fNSRuRkft3kmwTWNL2DQAnnWSu8NWX8NDIKg6qkja/hU/NmOIPoMcTeNzoqls1Go9YowOjozTTKboZM+BMHdS/qRYRJQFDK+A/jBOuYagrRU0O3mJYAwde6j4zlDyAPgAscIha+cfWIseNXXzLA5B3BtN88aXpj4eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 16:19:12 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 16:19:12 +0000
Message-ID: <b0d9b8ee-d1ac-4580-da97-4d0dcfc10388@intel.com>
Date:   Tue, 13 Jun 2023 09:19:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v2] base/node / acpi: Change 'node_hmem_attrs' to
 'access_coordinates'
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>
References: <168660916231.1965241.248859226126456131.stgit@djiang5-mobl3>
 <2023061331-napkin-disburse-915d@gregkh>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2023061331-napkin-disburse-915d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::13) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4171b236-0831-4902-cfaf-08db6c29ecb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjYn9MypVJAIlX+ZrKcFHB67J3cw5PmwMpWU7DvZQdFyGW83ULb3t3sfqes6flt7dO0dKBiYlRxG6lZDeg5c1/W3B/itr5qq8D2Ncrar6aBwdx1CZ2O5nGlPZ0hbv6zEW6bM+/osfVyRnOV1CTdz+ANY82D/erG3cwLP2wFXMDIaBhlVKxA0MUhmfvDy+UWFNkURCQRJVHgh5HpcE1azoYEkiMD3wldi6aLSN6GM6huoLXHukSacLA1dECwDP96/6owxQMgW7L5YNNlxBphYhNKb5x0JW8fzYOGELhW/T9PzYUKLBBnqXu2Q55vBTt7Ug0eJfgSerbuB6L96p8mBLsjjhQESUdlmKtYzf+PZaSmlNGcADjAhyyWrTgqDAm02eT+S85ckp4MxXv9+cn0MOHeeUuMn4SEO71068IR/vA3XdwhptiEUSx4qmYvIZBzYr+zxLY2lzZj3I0R4VChzy5fkgDmnctN1tpTm3YbAkbIrDHBlkwsaYLptO3pPaL8/ricnIUY5WhflvZfPE5PQQHFo9Wp84i7CAqL4agE7hfmNr/yvjWzvtSiuJOagb6zjprS77BfxUQPhbzKBk0ZuzsQZjp/B1T2QegOFsyiIUTvGOmkpRMdyS1rdlMMUDRR9hGDj99TSmeiTpBdTM4+2Ppk6HorAyV5Y1fYTjqOG93fFDHMYzvdj2rCQXg145biW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(82960400001)(966005)(6666004)(6486002)(478600001)(186003)(83380400001)(6512007)(36756003)(31696002)(38100700002)(86362001)(6506007)(2616005)(26005)(53546011)(66556008)(66476007)(6916009)(4326008)(66946007)(316002)(8676002)(8936002)(44832011)(31686004)(5660300002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHY0eU9HeUZOT0RuUUE4OFpBVmxEZDlUT0puei9RNW9FdEpuZStzbGNOeDRi?=
 =?utf-8?B?T0V2dm04cGthRFhRN1Z6aE01NmtvakxXUTdFN2V2OGkyUWZtaU4rWlJWbC9J?=
 =?utf-8?B?akc2eXQ2d0lVWU8vRGVlSytESUw5YjZaTmt1QWJhK0w2ZGE5MHBWNjNGc214?=
 =?utf-8?B?bUVBT093YzVxUjNIV1ZIa2pIUGRVZHkwYUpnWWcyVjVDcHNpdEFRVHA1blFG?=
 =?utf-8?B?dEd0SnMyZ1VMUWcxL0t5TkVXOE5YS3YySlNVSWpvV3B6dHdab0ovcVBPSjZS?=
 =?utf-8?B?NTAvQWJEWHUyNmlJL21hRnFQUHJ3OC84ZHE2cktyYmdUMkpIYUxkU0NSTXBK?=
 =?utf-8?B?bjMwYjN3Q0JqbW1Kc1pwdFBWbmdWYXBobFp2TExJaDdZS0FTYVJOazZkUjQy?=
 =?utf-8?B?d2VGUlcrWkhhejkyWk1HTGdOSnVmUnV2QkdtUktqRUdOaHo2YVlWZnBUWkpK?=
 =?utf-8?B?RFMrZVN2YVNRNWlpelFKSXZxTFdDMjd6cXJRTG4xT1NxWFY1RVlPdGx0bXJN?=
 =?utf-8?B?d2JxQ3NCd1RUOHJuSnJ5RzlldXVqYmhyTzFSVnB0eDlKa1hFaWdNa2hlTFQ3?=
 =?utf-8?B?Vk5rMGRRbGZTVmgrN2N3ZDZWMnhaVmg5aHBmOHRZdmM5NWJKM29SYzEwaXFu?=
 =?utf-8?B?M3R3VVltVDNjUjRTSXZSQ0l3ZVRodEx1dkltc3JnRVRoQ29IVkVHSEI0U0xq?=
 =?utf-8?B?NlZHbWFkQWxEeVNYK2dobEx5NzFmbEVXbVB2WE90eS82RExBQzdJbXZRUkxv?=
 =?utf-8?B?dlFScXZyTEV6SUxNcS9WaTdrdE9UbVdMamVkQ0U1SmpWUUw2S2dMb1pyaHRR?=
 =?utf-8?B?RXlOaFlMZ3JSR3kxSms4QWl2NEZXWVRuRGhjM21CcnFnb3FRTHFEVFNmak9Q?=
 =?utf-8?B?ZmtTS2JZSVVUYnQvVGZ1a1pBdU1Ec2RaSG5oczI2QjkzL1AwaFkyakhnWVAw?=
 =?utf-8?B?ZWFPOSs2a3RDelFOOHNWT2c0WUwxb1RXTGZKMjlmZ1JWSXV6UTZIUmFMdW1U?=
 =?utf-8?B?ZEhnbUFqbjZzeGF6MkplRDJyelV3QzVmOU1LR21aT1lCK0dXd1dacEEyalo4?=
 =?utf-8?B?VTdZd3p1WDBWWEdIbkE3aTZxemRva2VLNzVlbWdaRDJiZzFoYTN6aHo1L3lH?=
 =?utf-8?B?OTcxZFl5L09heW9PZHVsWG1VeVJacEl3Nk9KeFF1aDdjdURmSTVWQmpxM2RC?=
 =?utf-8?B?c0ZRSG5xck9UR3ExMVdBNjVRRmdFWmxiSTNBWHZCVFJsYmNDSnlkS1BhT040?=
 =?utf-8?B?WTMrVk5nRXlMYm1tQkZBQ0p4alJ2YzRlQnVmb1B6S0Y2RHF4ZThMb2RLSi9M?=
 =?utf-8?B?YXRzNmxBMWpITW5HS2VsenpGc3QydFlQNVhLbDhnMG5wTlpCOFhSd0krV2tK?=
 =?utf-8?B?WFJoYUhNT0dodGRGbnh4Ly9uRjVSU1pCYkw3M0lrbUlodEdtUTNSVFVwQUxm?=
 =?utf-8?B?TmpLcUp4RVJzSUppQ3FXTEpKOFV3NDdzMHFWNFNTN21nYWF3Z3djWFRNYVFy?=
 =?utf-8?B?aW9QeHU3WDdNYURzeVlYekhLbmVES0Q1MHByeUZUMzZrSUdJUHhRL3dMZEg5?=
 =?utf-8?B?UWowZmZOMDY5UGhCa0k0L29QMDc0WUsxZS83MnI5WTdxZXhFVmlLQk5MdWln?=
 =?utf-8?B?SjFpSFhHRTZNbkRTbWQxeVlxbytQL0lOY3ZVT2FaTVgvSnVJbkRiNTB4RzJJ?=
 =?utf-8?B?MVZ6aCt0d3FOa1EvWDNZMTYvTXc3VlNxMWVZUHhzU2FWNERhaEpNcHRSb2Jj?=
 =?utf-8?B?eEtpL1cveXZETTMreFpVNngvd0MyVlVuSWxsSGg5R0ZzOTNPeG1PSkpYRlhR?=
 =?utf-8?B?d0cwWTNFNTZLdUp6RCtYL2NHUkVRdTdjNU9TN1BJYk1COStQVmxCWTkrekxT?=
 =?utf-8?B?MURWMW84QlZuMEVIb2RINjlOTHV3ZkRMWVplbG04QjdxcUF6cHA4aWMxckxB?=
 =?utf-8?B?T3VIT2VNbVRlM1BXOXYveHMxdGk4N0VPVmZZWkFZMkpmcmxBVHVkOTVORDIw?=
 =?utf-8?B?TDVrNTFWaDFkVFVJczkwWFZTT1ZLMDh4VnQ0TFZ0am5YdlAzNlF0YkdnaTRN?=
 =?utf-8?B?S0dYM3g0Tzgxak5uUVlTZ01mRXVHbDNxcnBvR0tmY0VJVGtIaUwvcktBSjFt?=
 =?utf-8?Q?owMsLEbWMRFIhkWNyIhGN7VNd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4171b236-0831-4902-cfaf-08db6c29ecb0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:19:12.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4evmXgaSNOUyOxIZJWNQEz5YuzRC/jfhHj3WMV3nhaN1v0TzflxwZYUyUAQ5QBdnqFvkWThPsG4BWBzg5J7siQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8039
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/13/23 00:57, Greg KH wrote:
> On Mon, Jun 12, 2023 at 03:32:42PM -0700, Dave Jiang wrote:
>> Dan Williams suggested changing the struct 'node_hmem_attrs' to
>> 'access_coordinates' [1]. The struct is a container of r/w-latency and
>> r/w-bandwidth numbers. Moving forward, this container will also be used by
>> CXL to store the performance characteristics of each link hop in
>> the PCIE/CXL topology. So, where node_hmem_attrs is just the access
>> parameters of a memory-node, access_coordinates applies more broadly
>> to hardware topology characteristics. The observation is that seemed like
>> an excercise in having the application identify "where" it falls on a
>> spectrum of bandwidth and latency needs. For the tuple of read/write-latency
>> and read/write-bandwidth, "coordinates" is not a perfect fit. Sometimes it
>> is just conveying values in isolation and not a "location" relative to
>> other performance points, but in the end this data is used to identify the
>> performance operation point of a given memory-node. [2]
>>
>> Link: http://lore.kernel.org/r/64471313421f7_1b66294d5@dwillia2-xfh.jf.intel.com.notmuch/
>> Link: https://lore.kernel.org/linux-cxl/645e6215ee0de_1e6f2945e@dwillia2-xfh.jf.intel.com.notmuch/
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> ---
>>
>> Hi Greg and Rafael,
>> please consider ACK this patch and Dan can take it through the
>> CXL upstream tree. The remaining ACPI [1] and CXL [2] patches for enabling
>> CXL QoS class data have dependency on this patch. Thank you!
>>
>> [1]: https://lore.kernel.org/linux-cxl/168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3/T/#t
>> [2]: https://lore.kernel.org/linux-cxl/168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3/T/#t
> Isn't this going to conflict with the version that I have in the
> driver-core-next tree as commit 7810f4dc8795 ("base/node: Use 'property'
> to identify an access parameter")?
>
> Or was that a different thing?

Yes this is a different thing and should not conflict. But a small 
dependency on the mentioned commit above however:

@@ -168,7 +168,7 @@ static ssize_t property##_show(struct device *dev,			\
  			   char *buf)					\
  {									\
  	return sysfs_emit(buf, "%u\n",					\
-			  to_access_nodes(dev)->hmem_attrs.property);	\
+			  to_access_nodes(dev)->coord.property);	\
  }									\
  static DEVICE_ATTR_RO(property)
  


>
> thanks,
>
> greg k-h
