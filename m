Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28AF74D88E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjGJOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjGJOHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:07:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB21B2;
        Mon, 10 Jul 2023 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688998029; x=1720534029;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PnFKcp4ysLWgFNm+kYAfLt+yaZ438cMfR7T5sbGbvvE=;
  b=F+o8ddKQTZkfyB1hrSyfkUm9r+ZRaiDNbsv0bMbV3fhdgoldAu60jdtt
   sUwS60OjveErBCCGesHzDI3j6/Nu79frk7rZ4SDB9/uVvnt3cJJPqDox7
   uXnibSNlmSRDEb0Gt/tOM2JGGiT82Ys6N61ZqiUkIpM0CSJLrls/mY/HW
   RSHcbH/2obibTNUrAo1OM1X0thm7dAvg2deIX/+TvHvSALHaz/pas8jRv
   WcJJaL6WlFvM+364mKV8Rtdd3K1t9bm5ca7KNyXWv+toF30c29/8KhkD7
   nKKvljpgGW4vUI4lKhUYG8H2lQEUxb8uhPhYiRAuEXwCalMqCDpwuvt4Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344677165"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="344677165"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 07:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="865374244"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865374244"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 07:07:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:07:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 07:07:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 07:07:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 07:07:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtcQ9/i8nb0kJOBX0UNwIXdPjnJ/9p5TnWB3lhI4XNPvYfVFTeUl8mswjeTknK5XyY8g8+PaKD60uqGA7ez7P460cl3wmyT3Pgc2feX2sMzVA1w9/+l5MP47FXtd+4J0tKqLNpIdiSzPe5zGC3mEHfzExurXF5QMv6ukcSaZfYt1kJOvJPsckhTWOGFyxXOqg7TMjJ4MlYjrpgfuSXo+QdDJvrZyopSPctHq8kc6rNhjrM04ZeP2GfoN3UwVdHIaVxGXQmOnQ+Ftb7Iz3pdViuSr1uMWr3jdxKSTSZVgiBDdxkhGYP5aAs+bCk/VbLbgonl9eNzzX+JKDNmV58TI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW2MYN5kP+Njews4qXIte9sAZtn9Bc/fg9/wjAnXV5k=;
 b=nuPvHmkrk64XqM49SdUpEb+s7dSL37JqUrIXvXJryQML44Wlx8SKk7zg0x2oMVYucsUiN4bKHQGCWXhvqI9j/iRBsT1iuFbcHqvwQaZ53AnZ3WF/RTIfu6l9Xc4UO4FvB9t62IBTe/McK85+Zs0ijz4HVSHg1Rb5Z7vl69j+5BLcFbv5MSJ8wQyc5hI0Mm8qFPXtlG52CXsPL2TF9wSoLVC4IdH3vLb24l/HoA0/SixKIF22KlQmuLt/MI0mFljeUClEV0Z+j4WZx3WvluC4KJvt7ASvn8ZNDh1O1YZ7yNancwW1qRqU+bJUnKUKkmLvm6pehaREQhXV4+LWz5L25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB7522.namprd11.prod.outlook.com (2603:10b6:510:289::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 14:07:03 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:07:03 +0000
Message-ID: <9533cd04-c9fb-4802-e855-3079bdb5d136@intel.com>
Date:   Mon, 10 Jul 2023 16:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next][resend v1 1/2] net/core: Make use of
 assign_bit() API
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>
References: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230710100830.89936-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0025.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::30) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: d954850a-b478-4ac1-f99d-08db814eef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7D1FbiXtjcWG33Kaxy0fy8+ETBoseruCAfSpRv6+RkISZvGHSJzlGlPs+wgS7H8j8IyuLrp6ukAbF2ZcfnRW8L5nxsk30rg1hBcIG2K2UEV4SiOXMijW3IJzL8Z45XvgO80gvKQ+EIsw4lD2NZRs5Y8Uh25yHmhb6hKcZsES6N5uswQIP4JFgWU4pRM7JQpaD/fD6FfHGFHRssU+MJfXWUFzZUISbJWJsDzvQ9arbLbOpzTI1ClxirSKkd7xG9kLHKM/bYyI70/VsNXE2KeATIOj50VKAbhqY+xhRHNwxQ6n+xRGJA7GFkeamAXu+vZChwdEMStyMsiRJBATYDEHZyu4UHLbe06bukUjy4nLt2ErzEFbPw0W/kY79arGmPItA6rqcCcrbrmg2OYZHX4EW4HUdw+KpyULk6jAlKFp38XpKrCUzWqSm1rnhPZ/V7aHM1/v6RS/cRkGdUNufFVOLLDuzD8RX/CPL0MWkxDp2TN2W4XRrXMsVajSoRooOQdAIFA/R1zpHvyseWQLY5WAS6YUS7T2vris0tukwu1sLVbxJ1y3EQ5Li+kAT/dkPMuc87BtcDjRTUaFbTgFRSHOitDSMOJ5uZvpIy6poj0dfPjtirFhABCvU3E+/f+ZA6AUozg97NOCWMNU9q6beWQhtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(478600001)(6486002)(54906003)(6506007)(26005)(6512007)(186003)(4744005)(41300700001)(316002)(66476007)(8936002)(2906002)(6916009)(66946007)(86362001)(5660300002)(8676002)(4326008)(38100700002)(66556008)(82960400001)(2616005)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGx6cnR6SktmeGtJQTV4WHAwVkpXbVhZU0tSOExMbmMwcURpdjhqZUhwZzlK?=
 =?utf-8?B?L0JEOGhxd2wzRHd0OUU0NVRHTzhSRWtEMktkTkpoNndtQW1rUWFiRGdHS2Zn?=
 =?utf-8?B?eVh4K2R3eHZpZG4wa09mQitET1ptbDc4R3Z2VWVHT1BVOXN0Q25DRE01VTNs?=
 =?utf-8?B?MlgyeW9RVS9ZMTJ2K2VDU3JHRXM4Qzlid3MvTkJNdi9aZkZDYnBoUlpGRjE5?=
 =?utf-8?B?ZzhoWG1VbEM1VCtBb2E1OWlvYlh5ZThlaFgweUlKdTN6NkFraUVDcUNPYkQ1?=
 =?utf-8?B?Yy9FbEVZV2t1L1RiQys3ZEE2TW5rTysyck1Xa25TcjZyK3VQWWVKbHlxZWJp?=
 =?utf-8?B?bjd6dHVLZFRVTHMrN29QVk9EWFdtM0wwYWVXbmFFbFR1TFRqakhTaEdIS2NB?=
 =?utf-8?B?elVmbGh0WlYwdnVlZG4yenovSm5jMkRmbWpuSzlSVGxub0ExTjJqL0F3d1BI?=
 =?utf-8?B?SG9HbGJOU210eWFHR3J2Ung4bTZ0Z3lBL1pOeGRUZ09wUHRlTllVdnplak5W?=
 =?utf-8?B?aW9WWk0zM1FXYmFxeEE3YzBIaFpZQThUVjdwdVJDMFl1dkN5bzZVOEFnTHpp?=
 =?utf-8?B?ZDVPQ1RQQjI0YzQ5RFAvSEwwR1R0aTdCQUp4aFh6SkdLTkNvKys1ZGRlbnFL?=
 =?utf-8?B?aHp0UFlPUVBWVnF0aUZpVmFIZnJxWlEvcXgza0J3aXZSTG5DTVpOV2tKQU5H?=
 =?utf-8?B?SlE3ZzhYVGRQb3ladmFhd29QamoyMFJXaFJjbXJzbE9pM0U2RWVKRjF0VXVk?=
 =?utf-8?B?N3BUQlJWTUwzQ2prVWVoeGthVm8vMEo2a0dZc1E3K3J3TkgxN01PbnU0b0w2?=
 =?utf-8?B?cHJuNFNRV2Z5d2Vhci80TGNCWU5MV3R1aVRxME9UZ2ZxWUszTkdzSFo3cFR2?=
 =?utf-8?B?eWdTSkg3Q0dqN2pmdnFaTGwzMU9SQmhwTWxFVkl6Z1MwMndKMDAyTm1KeEhS?=
 =?utf-8?B?TzlmMW92VDRKMDdaemxnUDRUVHIvQWl0NGhxMjFoSVRpYkJQYVI1SHFwRXpS?=
 =?utf-8?B?RWlZVWJXbS92ZW5OeWY1VDdhWjFISElZakRqVTZyU0ttNEtwdDRUYmhEaXNt?=
 =?utf-8?B?N3k1RVZmUldwejE1WjUyTEtCU1BPR08rblUzKzUyalN0UWNVVUtvTG1peHV5?=
 =?utf-8?B?em1FTzlvOERCNVV1cHJVU0lQbG90bnV6blMxY2MrTlg3Z2UrcG4vUGg2aE5I?=
 =?utf-8?B?Zlp5NFdoRDJhZXNtQUZtWnFUbGFnSzZ4dFdtTm1ybDBDKzNUdkQ5ZFk0UFV2?=
 =?utf-8?B?NzhuWTlsV1RTdGpyYnFsTTQwWStrc2lrQklFc2libkVoa2ppcmpPS1hoWmI2?=
 =?utf-8?B?UzZ6NzFFYVMzcHVDalk4bnFNdW1HWkFncExLTjUxTU9qem5PMEE2WlVEcFBG?=
 =?utf-8?B?TGF4NEhEQWdKMFdVb1ZXSEtQWENFM04wWUJFeGFvVmVob0ZyQ3FDZG5oL1g1?=
 =?utf-8?B?TUxtWlk3dFQ3VXVOd3l5UUhCTmFvSTg2OUhFZE9MUXNKSDlDaUFIVEdoWGl2?=
 =?utf-8?B?ZmJiMU1lNVNIbTJjR3BuMlBLempVSzRHYldUajh2RXY0YTY4aUhJbHBGZkRD?=
 =?utf-8?B?QU5NU0FkTk0vQzlQbmF1cVlBWXNhSUMwRVU5eEJoK3NxVWJqU29vYWZ1Y0Nr?=
 =?utf-8?B?TFdOSHB1TzlvUFdmTXFkV0p1UWNSZnFNLzhmSGwybnNwTG52bENYS3JXZmg3?=
 =?utf-8?B?SjVBaGFHTXRzNXZ5WWZNNHQ5VjJ1UFJNQ29WbXFpQ2VpZTJvT3orNE1TSXVJ?=
 =?utf-8?B?YnI3bnVjV0RGL1B0L2JVb1JyOVZxNWNWYkMvK3IxWVh0TFFXS1M0dzFjbEQy?=
 =?utf-8?B?ekRvUkZYOVJXSzdHOTlzYS82dytxOXhWMU5mOTBqT0xXdGRGVTBLemhhdGN6?=
 =?utf-8?B?elFoMWcyZDgrdUczNmZmRS9xb2tNek9ObzExazgyZ1FObzRGUnFpQkpQdStN?=
 =?utf-8?B?TkFoejBrQnNPNXlBbnRZeVU0MzRIQVlVOVZzdGF2bmd0SzhTeWg0Y1gxWFoz?=
 =?utf-8?B?WTZ0UTRWMElHYTAvUnRhU0Y1V0JWbi9iSGFXN1psREFVeDU3a1hnV2hJUnVV?=
 =?utf-8?B?Y29oZVRjZXZZYW1UbkNQV2ZFNGU0QkVXa2tMUzNIOVZiWU1qUk9LSHlsVkJG?=
 =?utf-8?B?aVRvbFNYckc2MkFQem51cnlNYjNQdmtsSzA3QmNqMlYranhJNXp3U2NyKzNJ?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d954850a-b478-4ac1-f99d-08db814eef7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 14:07:03.1068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDQ2x2yLmcVYT+VBWYMxo44cVrgp4WdwBmtQLI9XIBTcQ5QGz8+xPSqmtLk/CzVgHv3DBfkp/ZX5aUL7P8AnsBQBR7TvK9q5q3W4oYwzG48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7522
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
Date: Mon, 10 Jul 2023 13:08:29 +0300

> We have for some time the assign_bit() API to replace open coded
> 
> 	if (foo)
> 		set_bit(n, bar);
> 	else
> 		clear_bit(n, bar);
> 
> Use this API in the code. No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
