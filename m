Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A800A74D8A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGJOKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjGJOKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:10:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2278DF;
        Mon, 10 Jul 2023 07:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688998232; x=1720534232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x6o9UAGkaBsCkr2p7GUqYAiFG/DPHyJZgl1K5/oJXGY=;
  b=hOr9ES9Wvv/dKapgGSuXN2amnWdhXt2lU/jOoXrsZZ8M6OGmNz78Jucb
   zWX3yIG82d+FX1NOr8OA1hz4leu6PwPi4XHLcQ0pDShP3+ySM7thRo6Yg
   2fwsxBMbPZVx4PvrmHwqTYM3uhNJJtahD+f3IgFMJNOYtEDMGD6NLU91D
   ZNuKWjjzPR+ITxjwtKbvNI45BNYkXCQgSN18TUjJN2duLcV+8/dPFpLcG
   Y/EagNorq97L3GqIMe6WPOiW9fvaReVLRrbUNgl53HDoqriVv6I8mCYVA
   gz+vBUPuTP6EcLovVqnAVP+Ube4GARrtJElJ3SO4XSGxGnThCEVNbbQJp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364389273"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364389273"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="724019050"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="724019050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2023 07:08:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:08:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:08:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 07:08:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 07:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK3BhdMG6N7B+aFodcKnF+rZ6HD1BEd37Xu2yeK/L/bVT4Ykj9uXDxtaVEa+2nOmDR+UsNxgXe9ZkKx6hemQlykyHk+3CQinHdq8/zk+xtow1hF+syoIywuSvI0BvuQenFtWSkzDOA+9phSBFbA4CMvKwMsjlXKEa2danOwWnjEWebHoNvuvp3Pmw8a10OqBjDthhS8WN/aI6li58SUrtpcit3hCxCF9cZd5CuLX4lK/SomAq2LHunhHgs+2vf3gKffaIN+W6g1mapK+MVg3j/Gfl2C58U8VE5nXJqolmS9QWaHU1z4uNw0/5ziZ9ovT8vjKO4E2DdhBHlNPEBeUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deHvWnF0bDtskMKxxguWADRhJwfY8kr5fiSARpGKBjM=;
 b=B6svulaJooa42s7zfawsb/36bH/EudPPkYrOVCC13Mbik/Caff9ae85hJ925ubolqjJPshrc/ohXeZsRdmK5XuRyTtfkYnuoXVOOW4jlKV1DyJXNyabJ1Bv3KwP111PmioeWZP57bO9/xbzlEG+xBvKzW6loDHHE3bgiYdaQ9aMD4E6LJ8lTBsAul9qx1PSTVbLsw6lzZwHSC2kkqDm4X/EhlWJP8FblhTO4mF23vLgDnNYannXxZSF373veauJsdK1MY0BWAKj+3uZZJ5dyo3BHKsv8xFRakoh+90hjFs25ZGaf/Nfyaq8SIH+BHB4ILXWDEz5olwxeKaEr+/zeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 14:07:55 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:07:55 +0000
Message-ID: <4123f47a-a1d6-5723-cfc9-67f5f371ae2a@intel.com>
Date:   Mon, 10 Jul 2023 16:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next][resend v1 2/2] netlink: Make use of
 __assign_bit() API
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
 <20230710100830.89936-2-andriy.shevchenko@linux.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230710100830.89936-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB9PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::20) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 563a84e5-2b7d-45a4-0662-08db814f0eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RhLVircTNGmuOChds8XDgkTos6YMmQO5vsqKBZQxYlGrBiBCQIQWzRsQ7AbznMvGyteYIptuyInRrcMOsI9T5T2kfzXbGVFPX9fNbPhvrtArc5lTzB8Ka3WZ7s2UcoRj7qzdKmgZpXZnqtUdEOaWt8aD4xjFOHzTZHGLK14cEpI2MGkX+gmjPtTHsB6FybOe7Z7am3b6yKbAN8M0iy3JmLDe2Nirt75ub/dw6iWeoKAHmN23RmFQVzMMi36PsbGbdXr/Tj2psZTm37/j4BOVYhtWPiQri0RWZBuSNtCOCsYWs97nu8L622xessrKsqhEUUHDnrFE/w8k4nB1Q5Baqp1A78a1Tp9sKVET4+2nrJl+CyDVUdlVXVaB+p3CGMgUxZr2zewGQY2vF/u8IH7ZX7sAVrs6zEbuZoWS4BkM88zYRXXagb7mPwBYwVHNPWs6kndtQzPCSVDGlG57toew1UZSd8+fZxponZz/6CwZUxk87cE8S15BC7Mdrucd3PsFQnTvWSVeNICnmpZQ8mIctImBx/hvt7U5UsY+IglANT1VFH0ls7tSlSl/pywqAfXbIQtbJnowZi9kBUpONW4Rs6XF5tkJIurX5JnJf5lzOnzmsuT6kZPygqTA9Wsi3MlwODwZPvxiotSbAJ9u6sVnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(31686004)(6486002)(478600001)(54906003)(36756003)(31696002)(86362001)(2616005)(2906002)(4744005)(66946007)(26005)(6506007)(186003)(6512007)(38100700002)(82960400001)(8676002)(4326008)(5660300002)(316002)(6916009)(66556008)(66476007)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdaVWN3alVCVkFVUGtsVlRsZmNSMm9Yd3Q1MGtLeEloVnYweThWaE5PdFRm?=
 =?utf-8?B?blU3Mm1IT0pycnFCUk9hTE5laDRLQ09EdjhYNHdxSnB3OWNLeDVWWVNkRlhI?=
 =?utf-8?B?OXRaYkwrZFQ3bWZmdG5pYmUrUVpwUms0ZGJUNEIydy9hZjFJbXorR3d1S29z?=
 =?utf-8?B?NGo2MzFoaXlxcGV0RGxqUmF3enUvUGdRSzNTZmxKOEJWODF4bDFBNTBDN1Yw?=
 =?utf-8?B?VmVkZTFCWFZHaVdiVlo0dEJJWU1yb1RuOTdwRCt5eFdEN3lMMnYrOXZ6aWtI?=
 =?utf-8?B?RlQwWWYwREhqbG55cXlYUG16MlRVY1VBczkzMG1pM2xwd2k2ZnhmSndUR0JV?=
 =?utf-8?B?aWlYMTdkckdZNkVLRTlRN1paUDFTM1dIcU42VFRpMEx3cm43OENEZlNFQWlG?=
 =?utf-8?B?U2lGUEs2ZEhrRWJYaGVReTZ0aW5za0Y1dkV2WUJ5YUVxQmpUTjdsVnQra3Z4?=
 =?utf-8?B?TWhuNmZWN040ZklERlErZDEvbWFoV3pRR3pZaE16QVpCa3ByMytGZjJyWWF2?=
 =?utf-8?B?Ky84M2JTYTBteEZtdEFsSUVNMXVxRWxvR0VPRzV5a2xwTlI3NXdEL2hiTjF3?=
 =?utf-8?B?U3phTnVLbHdBOWZrMWVmamI3Y1Z6V1hFUVQ3QURucGZmZ0ZncGNDbWR4Wko5?=
 =?utf-8?B?WmhzM3hGZG9tUXVySkNNaTZaRWd1cDcxdkluakNQVzQ1SlBkMzlxVVpTaWVS?=
 =?utf-8?B?MkFHZUpWdTNnWFBnbVZTd0tkbXBsOC9YN1JNc2RJamVuWDM5enZJYUZJMkND?=
 =?utf-8?B?d1JQeWZTMXJwTU5IQWpqVmlRd2pMb0VybWdPcG5IWncxTHRqR25iOGM1cm9G?=
 =?utf-8?B?bnQ0Tmw5NHlGbHZ1eUxTQlVUV0o2YnZxbTJScG4wRS9wdlZleEJsSS9UOEF2?=
 =?utf-8?B?d2ZiYzk2b0p5VUpvSDlLb2VMcG9BZCt4MGhra0lYNERvV3JGUTZZQWgvOUd1?=
 =?utf-8?B?Y1dWVXFWY1JseW1NYzRLY1lHTUV4Mkx5dUpmQnQwOXlyZTV4UHlUSmpHTGl6?=
 =?utf-8?B?b3NYc3BxcSt4S2hMeVVkZzJ2RXJXN3dmWGpqUm9WS0REaSthVUhKYXV1VGQ5?=
 =?utf-8?B?MVBaaFhNSmJXeS9HeTRyQ0JxcmJKVmFPUVpCY2gwdGNLZ1pkOVU2NW1FeXZP?=
 =?utf-8?B?dTV6aVl2RzhYK0l5OGVQSGlmMDBJNlNuR1NzdVVLNmhPWk1udVVidXZpOEha?=
 =?utf-8?B?aGVtZDFLVHlLSjlnVmJyRmp5V3pRQVMxNVY5U3ZIUTYvZTFmVEJvc2dBTDZx?=
 =?utf-8?B?S2pkV25lNkR3SjdkN3R6MGMyWGlISlM2cWVJc0tCdmkyQ2JwYXhSNm80dkRX?=
 =?utf-8?B?cFJKZDh4bzRldUgzSWVGRmdMemdhejI5TGZ5ZXRiTmNDSUlCZ2t6dFkxM0pp?=
 =?utf-8?B?c1FRYmt4WnJuN3NicWNHTE5rSENNUWJsdldQbXFBclFjajdqekRFQWJZRG5O?=
 =?utf-8?B?SWkwaldIdStHblNGRHlXa0w1MHhzTXBudzNLYnl3dXdwNTZlVEtnTnBEajF1?=
 =?utf-8?B?UHd5VGZqbUtWUHViRlZrRnR4NUkxbUFhVUVIcEVZMWZrQmErL0Z3cnIwQUVL?=
 =?utf-8?B?ZkR5NGRCSEtIbUtaUnlFQU50NlJNdUhtRjh1OHRONmxybGZLZnppdUZFakJl?=
 =?utf-8?B?T3NRTG8ySUM0cEtubklsK1ZOQ3dLcHVLQnZuTitYZlpIUWM4RDZvc3JsWXVH?=
 =?utf-8?B?RlI4ZklGYjFRcmpZQUxya05VTkhsNFl1N2t2cFVwelhPWFZDT0cxVGJ0Qzc2?=
 =?utf-8?B?U3JsT01IM1gwZmR4d3FKZTNZcCt3enV5Z3VPYVJaQ3d1NG8yUjZjajIwMFZi?=
 =?utf-8?B?Y2lFUW1ObWRrTVNsejhWR0ZCVWxNRmlVWEZlb2hOcFVSMkRRanM4eFJGMFYw?=
 =?utf-8?B?bUZHcFNFTHpueUhtRGFMNjd3ZGQ5dnFQSEdDQ1ZqazVsMVQ1U3hHTTdJbTgy?=
 =?utf-8?B?K1hRcHlneCtYUk5XN1RzVHRUUkt5WlNmaHZvUjliQmhwR2drSWR2TjJURGZG?=
 =?utf-8?B?TWNyTmVCRWxiNkExbVdwdWFSc0QyUGdQcmlqaXpMS0R6eXdzS1B1QzdkTFhY?=
 =?utf-8?B?VkJjcUYvejRWa3VGTmtCb3lMTXE3bTRDOStqSjJUVnE1MFZCdGwwdkRiSU5U?=
 =?utf-8?B?UjJSRUdoWnp2b0JjVkd3VGpycTB4d1dLT1RPVjhZbDNqSDFya3FWOFROdG50?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 563a84e5-2b7d-45a4-0662-08db814f0eee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:07:55.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAovwBuSimLPptueiIdGGa8DiiUNmZp7OvYJP5iS8VGC4FznwHEfgYhHuE5x0pc7FdTZ89uuErYrHBSpeLw9FatWi+uk4WTtO8J9xLBikt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 10 Jul 2023 13:08:30 +0300

> We have for some time the __assign_bit() API to replace open coded
> 
> 	if (foo)
> 		__set_bit(n, bar);
> 	else
> 		__clear_bit(n, bar);
> 
> Use this API in the code. No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

 

