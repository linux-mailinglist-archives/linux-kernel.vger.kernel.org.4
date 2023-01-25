Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEA67B218
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjAYL5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbjAYL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:57:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CA983EB;
        Wed, 25 Jan 2023 03:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674647837; x=1706183837;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7XOacHw41IBOBcmor5UaoLhks7m9Yb6vO1d1j2g5SR0=;
  b=aNELM3gkMz6bg9yR7lRammZuo+ipUGXtPBWnj0MM20zyrbkgK1s/xale
   p4J/LX/i7A1/6yM9ywQ2OPqlvAwmRobjSjQ5t7mU1GuD5V9BaUI2n8H9H
   h3dJc400ib7ZM8hsywaHoMzZFHch2dAcrv+aY6o4PQfIdRDuqJrLL02e9
   DNvp7YObpskWD9MP6iv/a90sTjNCEqbGUJL0PbEyZjuafgfu4+Tko78d3
   L6dD2vR22lh9Kcd8KoyLLPnWACIdv40Vb6NNHtpp7fspZgSUMIqPUhZ/8
   VfWgSDKqNtmBZxrAfelblQWUSZ8lMu1N4PzWDjK3+3S8iWUWj42NtBn2e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324236448"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="324236448"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 03:57:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="694713770"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; 
   d="scan'208";a="694713770"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2023 03:57:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 03:57:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 03:57:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 03:57:15 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 03:57:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3dkCOy2hm7gPgBAYYUQ/e9447GxHgsdEtMkGfHp8julZX8E8JDn3VnyX7Ropotng8/Uyq4xPxma+uKGcv28EiTdlMNVNJzdJZDwE1z/12VaplIFKLm3jLaEQqAp70q7Ri3V/OrBU+ueApxeKRR04/MRa0RSIzKywNdMK/rq8MKfPbIXdVu/9+S5UfkccuObPf2RHQLjgxi3MdUKvo3hFTYgZlQ97Ed9pl20dGxUxhYO42VQj9lN+D7rm6dJlWTjQnEIGM1RSkPHmrFS6NGztN8/Hmju5PJVCxaZjmZtbZSTbrHNXs74Zjx559MN3QHEUv54+qj3KKplTGba5nfhnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wadz2Vxz6f4zSdYOI3soxbxbUeYoESFKNaq9Hndr+cc=;
 b=UhOR1m3CQKSAld4501yhl80sdTjfk/KyeJAQaDzE8T9AxHR3DxTMJFLk7/sy1UHNKMjV7IkRSdlKDWewiI4UKdNoI+yTaydVrPPHzUk9fcLfZs8ItjNvZvLG/nTxIoPVjWOdrPwr/oDMnuF1J9h8MB4VEk3twGD2DCVby0LSZgsnA4sP3DhmZ1eJCvUqGkl3KtutdHyE+TfuU12OiIsWNjX8PV+YCVA54+4+Co078ufhxB7RJabLhMwl4CqGJ+cFUj0/9LlBxkymWhqcQdumdQUKRM3hc8s3PfMRjYDZWR93YuUfD4ZMTPjNl3voLb+h8o0MWAzHeasPSbWbwSj9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 11:57:08 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8836:6aeb:e872:30c3%4]) with mapi id 15.20.6002.026; Wed, 25 Jan 2023
 11:57:07 +0000
Message-ID: <6b732afc-cc46-97df-9aac-af20292228c4@intel.com>
Date:   Wed, 25 Jan 2023 12:57:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
References: <20230125094503.5066c70f@canb.auug.org.au>
Content-Language: en-US
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230125094503.5066c70f@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::9) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DM4PR11MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb22e74-8301-4058-4a35-08dafecb4843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+ZkKd+v+/hEE2ZaF2S6AvmvXW4B8N9ygGSACjGCM2wo7trxSe0qUoe6cVCLkvxgHMYXfoHNa4nrEZR7GqkVzw7A8MUCMn4U+S7MmSQepangdRAafIYMg/nEbUaFa0fwAtvNNyIzOLuM3lfIMh426nT/x1cOXxj81N9xu6khR/QHfG+dvb8k5f9HNH5tQGzTzHl2To89NlQLj9c/DMWq0wx8D6FPDZSII6+cybqABKKbjbEOa0l/1Yd+VQH5VPeTzrMIr91Ao5i3gcrlHR4l1C1xfiae0dTEBR/XqhUBxdHnw0ycLo3yirj4Y+y9wWChwmLSyG/WjJQcrJXojFAWK73VnS/5goK931gwNOSse92Y5JBU1xyqqWUaccPsLBeQAdni8sYt06vmS82HxPWZm4QSnM5Mf7Mg4em6E6dbq08JVhQ4+nvqe1BHmtNcqk7s5jNoTui2pLrp2gsGXaokZCVw4R4RYXRVpdIqqJDcqm4frmLRvV1Pjp83rUjvPEslPhRTOsW52KFFdsxnpwSusG3YW6zjgkMxpX29bQ81oQwn47qykq0s9MNjTHkS4hm/Zj0LQVgSGvwLHWcP+EsOAFy17qLMAsfHhcwWammWKFK2ZJS3VzahlijFDbyAS/Y1zPy8yv+RMVUndOpq/0/eyy0HJIM62CA9QC9kJxnI7Aw/FMG0Dr8lvNpIVPqXZWKHMuwEMPPKmjcuGJX7OU/lBgmf4LtY9h1g4tbjfJNAzDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199018)(86362001)(38100700002)(82960400001)(36756003)(2906002)(8936002)(5660300002)(41300700001)(186003)(26005)(6512007)(31686004)(8676002)(66556008)(54906003)(2616005)(6666004)(6506007)(4744005)(316002)(83380400001)(53546011)(66946007)(110136005)(66476007)(4326008)(6486002)(478600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlVOdW45L1ZqVDZLTDNMaDE2NkpjbGIrTVF5RFN2OU9MWFFMWmJiS3ZibHBQ?=
 =?utf-8?B?UmdKWm9RUE5ockwvNEEvcWJPZHcvUnV3b0RCTTRERUNTWmtJWlB3MDFJenRy?=
 =?utf-8?B?TWx3QTJVSVZ3dkpubitmenZkTDVtWm1xRitvZjJFVFlyY3BXSHVsMTV6THZx?=
 =?utf-8?B?RFBSQVBqYzJHZDVGSVBrZXVoVlNLMEJJUWtRYmhrZG93VTRLTlpLdUpaYWs2?=
 =?utf-8?B?QWhRNWxMVTcxWHlYd3IydWdTZnA0T2kxZ0svRVhKdzZyeTdrM3VqbXVuV0U0?=
 =?utf-8?B?czBRWmJxRU4xMDBVL05pbjF3ZWxmWi9vdlBuMTBhR29GUzhTMmo2ekZSL0J6?=
 =?utf-8?B?SE5yakhaaHJXaUdzQ0lKUmN3SmxhSUtkNmVMa1hBSkkxSVBSekNSdldKZ2sr?=
 =?utf-8?B?eE9IR2JVdE9WOVprNVBGM3A0aEpuWHRnNWUvMmRobDViYytZU3N5Rlc0NDJn?=
 =?utf-8?B?VlNPRm1IRm41cGpWMkV6YnlyOGdpdmRhS1NNSVRGZU1XZzFLanF5bStPSU5p?=
 =?utf-8?B?ampodVlaaFk0Ukdxd3Vpd1JGOHB2blpXZXc4TldIMnhXcDE5c1Q4QTJ0OXNu?=
 =?utf-8?B?eVFITTBvMk9jNk9uSlg5alJWTk85RFREdlExMHdkMEd1VjYyaHd2MnZFdzNv?=
 =?utf-8?B?TkNrYy9nQ3FDU0NZc3hrUXVQMitJWm9SUyt1NDBuZnZyOE9FNmJKYi9hVEFM?=
 =?utf-8?B?STRRMEN4SWN4NTc1d3FhMmppbjNyNjJyUGFBb3dYQksxL2FSbzMycUQwOGg0?=
 =?utf-8?B?aGxNQm8vdDdLZVRBbmVydGtRd0JvdWdGUzZmVGFNdlN6VkpVdnE1TFRabXJm?=
 =?utf-8?B?dlZyR0pjT1BNU1llWDQzeVgrZ3ZTcGUydStacE95bUFSdEZMWCswUHZBUXZh?=
 =?utf-8?B?Qnh1Y0pqZWdXdkZqTjE2SUtCNVVGK2RtS2NkeVAwS2ZTRzlTQzdJMWcybUk1?=
 =?utf-8?B?T2g3NVYvNHlWcDE0cm15bURXL0dFcWlSQUFFTzZqeGo5L0t6MFRoVmk3dC9Q?=
 =?utf-8?B?bFo2bjFGVUphZkFpVmV1dGJHdk8vTzdoMDNzcXhCTTE2TmFPTktkem1QRm4r?=
 =?utf-8?B?OGZTVFZUaWwzV20vdldLTDVjVjZySHh0WHB4SlNCU051ZTMwTXA3N1pRUTFT?=
 =?utf-8?B?SElCTXFGRERaTmRLM01BMGNSc3JtZEM5NW9reU1ySEhJdkZhTjdYUkkxQXdV?=
 =?utf-8?B?Zm5DMXlWUVIxb0xlMXdlbkI3YW91YlR0L1pQdWdjdVdYU3ZjU0NnYkZkL3pR?=
 =?utf-8?B?bHJLY0hXVUpnSEg3S296YU1sSXJBcVV2YlNzdUdmNjBYYitiMHd3U3pzcmJL?=
 =?utf-8?B?dmFFMk0wVXZOWmczeVJrdk9QMzVxOGlaMzdwNE4zKzhXR0t0bjZaVnR1ckR2?=
 =?utf-8?B?SFdLLzFuOUZJUVEzWEZQdkV4VTlCZFloVnV0aE9Fbm9YMTBHZ3l5eDNKWVNh?=
 =?utf-8?B?Zys3QUFvL2dycXZpR2I4OEo2ZU5VUk1xR2w3L3FXMHZyeXd5dmpPYkZ3Ylo5?=
 =?utf-8?B?RE14d2QrR29Rbk85L0xRbS9aRVZHQlJOK0hYQ2N0VGxWV0dmeDIwRmduYmxY?=
 =?utf-8?B?QVplV3o3YzdsUVFzTmtLYUxBdkVHcTc2MFVkQUlPM3MvaUV0dVoyV1g1elUx?=
 =?utf-8?B?Zm1MOUNpUXlhQTZmSUJqRUdHOFQ5STYvZG93K25ZbVNXT2o2N0J2T2pzK001?=
 =?utf-8?B?UFdHdk9ORDRXancyWHpreFl0Yktxb1hKTS9La0E5OTJLaDc3Rk9qQ3pNYktR?=
 =?utf-8?B?SnJpMWF6MWdZM3U0b0NqK0hLUE1wcVN5aVR5NTRjMW5UYkR2MXBQYlNIRTNJ?=
 =?utf-8?B?c0ZWOHN0a1VMMjREWC9BR3BjWURBa2dlQlc4M2MwYXpWSkxJeDV0RGJUaFYz?=
 =?utf-8?B?WUJrZHJ3c0lHa1loSGhLWjl1bTNuUXJtNHRDWXo5ZUJKamNPdy9zZ01rQWFi?=
 =?utf-8?B?L3kxZXhnZzVpNkZGaW1YSFRIVXBaSVdWVTc1R3o0Z01WQWtwYWtWMlhPN2ls?=
 =?utf-8?B?aDdRVWdEYk9ORy9tYjJyRnNLb3ZVVVgrdmRka3dKcUxwdUgzYmhyUWlYUURU?=
 =?utf-8?B?amppUzk4M3V1UTRvU29NRy9tZERGVDA5SER3Rmw0Z1VvUlNYdG9YWEZnc21Y?=
 =?utf-8?B?TnFldXhXb2FHUnFQUyt1cWNFM0FZK2xkd3ZQR3FXNzNlQkw3YkxYaEx2d1lt?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb22e74-8301-4058-4a35-08dafecb4843
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 11:57:07.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXq8KjT9RTdjqP+Rh0BPgsnuk5aXAG9dFR13yI5ebSR0ItGLE2LjNpjuLFk1wv9m0CrfShTgpyKrvwuDJrTGxxydlF05FhiLiuKqJNBDnaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/2023 11:45 PM, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the thermal tree got a conflict in:
>
>    drivers/thermal/thermal_acpi.c
>
> between commit:
>
>    7a0e39748861 ("thermal: ACPI: Add ACPI trip point routines")
>
> from the pm tree and commit:
>
>    4bb6439371e9 ("thermal/acpi: Add ACPI trip point routines")
>
> from the thermal tree.
>
> These commits are very similar, and I just used the former (as it
> is newer).

Thank you, this is correct.

The linux-next branch in the thermal tree needs to be updated.

Cheers,

Rafael


