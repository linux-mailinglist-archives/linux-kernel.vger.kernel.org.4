Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F796C2A74
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCUGdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCUGdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:33:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52823F959
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:33:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VV7x2i8w/0yDdArpo4J8f0IprD/15O2PnE9IAPLYOTWCxGuG5AR73XVxiOFBfG2dRv/fS5oV407LP/feAfN0+TbRhDwe0uW+az/T5pzTrAPoks7nChsmzl9PYtH6DMa4LZ8Hgj1jxCpcmjm9Rbp6KG6w+u8EYKN8K45QsuUHVCxjxt15UbOqoxgwU7BGagi0f/QqwJQnYZ8DooJp2p1Gr9FjSaXHtcsWgudStQlTt5aRBMaG5/VrlJTOf2852IndhM6SM0aJ79E9JJTB4gG9vjtL+5sFKw0ijrE8l5NbFveyDO+3t+KTZnjq4aXYvZNVmQHiYcz5rRZKyeck/3LqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZ1A09g7HdbbsFh5LEJf9EbbblXOfY/lrOBfGzWy98s=;
 b=MDGYGY7Sy6Mu+GTr4B8fY5ccdxQD2o4R5Y3bmQ156bLv19wz4OktGG51XQbMMj35p776h+XVb9obH9tmDaF3ZP4ztu9nY/WABnfNMJiG2zv0dXZI/fvoFcA8ctWv5lNpmy9ZRqBzX8CB4+iIxKNDrY+4dJ7sQY+19KtxyAW1KpiV35DfUsqaeRDYjRCTSIzm9WFn1cwEGVBQiJbCfxdcGw1cis87bp2M2kvhcbMtxonfYDgm3DpbxoEoeuA3ZrdiXHYlv631jC/AvWNFJIsF649kKkF7ugnDi4JgcZ1i8uk5B5fPSn0HNupmuhJpDs7Ebd30iGVKlESKGdkf2KIeVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZ1A09g7HdbbsFh5LEJf9EbbblXOfY/lrOBfGzWy98s=;
 b=eEW8QlipeprG8ezzOKSPvgYLuies29DxENeFS4L4K7B2xURzyjWYSbFHOe3aWIJX6E/F1tz1riFFGJXGqd//dxuMelgaN5tO6++pfsoNe7yFkF62n7JPf8gzLHNwT0d5GCKUePSAnhU0F3q2eSZ3iV9vnTvdYNGOf0uY/Ddk85Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 06:33:25 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::d8e6:76b5:2c23:1247%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 06:33:24 +0000
Message-ID: <2154046a-2081-606d-a1ea-33fd2d48cce7@amd.com>
Date:   Tue, 21 Mar 2023 12:03:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] perf/x86/ibs: Set data_src.mem_lvl_num as well
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230311000642.1270971-1-namhyung@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20230311000642.1270971-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::13) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: a3b9ab60-8a2a-409f-0a2d-08db29d62c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtTVl3g6C7VXDQ8Z5gaRQ54+BgBvndKwqBHp1ZL7J4QLVe6pV+LQemA8q7gsS8AaKXs4UE929OiaIjfDNw6YmvyShm/EBCQK6yyjJ1T/jun3GtRYkgG2WTE7FPN16nX8taPOQZFeOJRv90CoKiUpV92VQOtWbTxvtwH/flQarByTqkK6CB0eznRsKyq/SObzbCrBfQFe6QCYzOyEt9dUL+vbO3leUBXe347TMLu33Rv+GD94JmYn5zfIJyBxylK9Y6gQLSRgHNaAs8quODfcjxXzrbcJPQNzgetPK5TMbrkdHZvd+ezCRqhtbH/Fex+e/E0EJLJcJGgfrFQP2CHuBW8wneDA4gQVn0Kv489m311VsXfySvHW1cM8kJzonW7cQ+1wdSjhNeb1gpfKzLL4CindgQi3bZ/QKVvD2yfDwx+VuyO6FhWuCxCrCsD//Ae2rEgcS+AzM3lZP3LQG3BuxYSFYQ96Ee5ZmC2Hx1PxKdEVJwT8UmCfG0NV1T0XbNawBje4nSyONuE4nN2DIw8vNJGPR4V3tIz40tUBcEUw4SeoLh+RXhMgLE4OAYtVO56ZkPmiRm9tepdJ1snl8rJu3YLoVQSnvc0pYLgrozzTI5apa8BYGAZgtRs8vvFh/sHZuq5BKMWWtCuQMKrdbMJw5cCwMhjHro4g4PyjwxyGOdP3DV8T/+Co/AqGgQ4cUDh8yPEf6lOa2paS7G52VzLDZlre7sIeEi7l2xfuHkslMDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199018)(38100700002)(86362001)(36756003)(31696002)(6506007)(4326008)(6916009)(5660300002)(2906002)(66476007)(66556008)(8936002)(44832011)(66946007)(41300700001)(26005)(2616005)(186003)(6486002)(316002)(54906003)(6512007)(6666004)(478600001)(83380400001)(31686004)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elFlZEZka2hXUmZjUmpNZFQyT1dteGFwSzN6NHNwcE15L2dLczQ2ejMwUkVK?=
 =?utf-8?B?UWFKTXVaeFBBTjVLUUwxamx1KzFMamJwdkRnNkJrNk8vNTdPaUxPYm0zS2VU?=
 =?utf-8?B?dWUxaXhHTDhkR0k3UDFwUk9NZDVRZEFmUDVsTkU0QS9tN3ZVWnAzYTU5aGxS?=
 =?utf-8?B?YXJDVGF0TnZIZzMycHBJNmpQUkdTRVB4NGVpMHV1WS9jMngvMDRsRzVjSXJY?=
 =?utf-8?B?MTRrVWVSVmdEKzc2WVJkaUgzaGhFdHQrL29ScGtScU1seXgxWnZDdUhHWHN6?=
 =?utf-8?B?ajB1MWpDN2lzRWJoZFhuZFpiaS9NYklRTE0yanlDNkYrSGxLLzRuUnpMd0FR?=
 =?utf-8?B?MDBSQmErMlE0bDBYVVArQ0NjTGtLMmJkOHNscUw5aUVPeE1odHhCQXcyQWhF?=
 =?utf-8?B?c25xdisrenNqcFBodXpZUklwMnVnMEpDdVBoUFV1cHo2MG94amtrd3REcVBj?=
 =?utf-8?B?M0xSbjZvRzZFWVp3V2oweDFETmxSSmdnRHJTaXk3UVlWRGluUTZEMURRZGdV?=
 =?utf-8?B?K2F0TnJQQjRpN2s3MnVHSzlqODk1b1N1cnZMRjJxWE9lVVNRRENFVitaVUtL?=
 =?utf-8?B?ek9WRnVwNDNia1RSMEtyNnl2bFp2TmMxTkJWVlBvcUdVN1hjNlk0MWJ1ejBL?=
 =?utf-8?B?Smw2VlA1RktVYkVaNjc1a3ZFYXhLT2N4R1A1bDVFbXEraURXWCsya1hWNU1h?=
 =?utf-8?B?RWlwQTA5cXNqMlQrbitpNzlvcHJaK09HN1hFVlo5Um9WK0haSGNwN1FQZG1y?=
 =?utf-8?B?SWRpVXRqdStETmFtU0V2aHp2SkZzbytDdU81TVFmcVJmSlVnWFNvZUNGY0lG?=
 =?utf-8?B?Y2U2MmhDelJ4cUhqOTBjMzBURmxnVGVIUGszUExCbllJc1BkRFh2OFRpRkd2?=
 =?utf-8?B?ZlVhM0d3dyszMEhDMlB1djBORThpWHVLbXFYZzlQWFh4SWtVV2MzWEhNQ0tQ?=
 =?utf-8?B?V29HSDRqcjBLVzUwdzRrTDhYRlhFU2lZMHJlSVJLQjBPVDdvaGluTy8rYkRr?=
 =?utf-8?B?T2ZCVEpHQThtaHd0Qmw1ZVlxSmhOK0VlS1lscTZEY3ZNa09GK25DTm9OUVVL?=
 =?utf-8?B?aTNxbUVFekVLNjNQdFhDNWJxYlp2SWZWNXdHbDZUcm1MMURubjR6WDB4dTQw?=
 =?utf-8?B?RlN3WC9WcWJHMEdhb0E0WFVWN2hMRWRzK1RMalNCSCtDNmEvSFFkTHRNVDNT?=
 =?utf-8?B?dEcxeTkrNnhZbWxpdHVHelZqVkJXU2pjak5weENoOGs4Wm43bEhhTUZqZ0N0?=
 =?utf-8?B?a2NaRW1EM1cxejIzNU93aGpmbEZtMDZ3Zm8wdTczd1ZFeDExR0NmN2NMNEZr?=
 =?utf-8?B?N3lQcjRHQVl1UUYrR0VWSjhoVzlSdTZmNjNhMm16bWFJRnZBanVlVmN1MjVj?=
 =?utf-8?B?OTRWWVBCT2djUTBZTm1tK2lFTGVCbWg5dnhKY2ZSbVBhMGNWUlVJMG1tb0VF?=
 =?utf-8?B?aWZsWVcrRmt5SWthWVVnSEZzUUh2d2xIcE0yZ0c2ZmxwMWFWTnFSeFdJM1JJ?=
 =?utf-8?B?UHU5Tzdmb1ZiWktTTlN4TjVMNGpURE9IL21SUktCdlVUeEcyT2hQMjZZQ1N2?=
 =?utf-8?B?SzRYMmg3WXJ2dzluU2pIeWNwNUdNWXlVOWRGMm4xY1JtYTlkYTB4bjRQMUd1?=
 =?utf-8?B?M3J4TXRjYzBZQ2lodFJ2YkUzTURGVExWSHEwaXZ4SFZmMXh3Y29pQ1YrbmRS?=
 =?utf-8?B?ZUc1VnVxSFpCWnpwVVVBQWo3eUFFVUtEMmJzMzdMQ3B5MmtxZjd6cWVlT0lh?=
 =?utf-8?B?MTVtckN0RWpIdXBqeURxSFNnVUlrcnM4bUlaZ29vOWRlYW1xUTZTWnl2N29P?=
 =?utf-8?B?MGVITnhvZXlxQTNlTWlHODZUbGV0N0xUQ0lFaExyY3YyL2NJMUFQeld5UGRx?=
 =?utf-8?B?cjFNSWpYQXhFNnZCazRjWjBGUEhKU3N0TTNUc1JKZWplcmRhaHpjOUVaSUps?=
 =?utf-8?B?YWZ1Y2ZkRGh5dTE2aDVuNlBidDNrVEppZ0tuQmFKSUZkamx2cmZXWnkzUktK?=
 =?utf-8?B?SDFka1MzSHlxeFVlcHd4TjMvYnFuZjcxUU9nOEtyc2NGT1l4MVRKOHZ2TlVi?=
 =?utf-8?B?NHhrRG81ZzdQbWd1ZFl2YjluR21XWmpudVFXYldUZC9LY3ZMbWxQUFYyQXRK?=
 =?utf-8?Q?clfcVaE4mk0Bu+r55j/P3Tzn9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b9ab60-8a2a-409f-0a2d-08db29d62c16
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 06:33:24.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x57sx27R8tidJPNVZVgmC6ioNwEw6+MCngwV7U6A6xIXBcp+LHC/YESF4fXsbSgvM0UE4egE+gY+5ER+y9Xm6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

> @@ -748,12 +750,14 @@ static void perf_ibs_get_mem_lvl(union ibs_op_data2 *op_data2,
>  	if (ibs_caps & IBS_CAPS_ZEN4) {
>  		if (ibs_data_src == IBS_DATA_SRC_EXT_LOC_CACHE) {
>  			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +			data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
>  			return;
>  		}
>  	} else {
>  		if (ibs_data_src == IBS_DATA_SRC_LOC_CACHE) {
>  			data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_REM_CCE1 |
>  					    PERF_MEM_LVL_HIT;
> +			data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;

mem_lvl_num does not have option to set multiple sources. Setting just
PERF_MEM_LVLNUM_L3 is bit misleading here. Documentation (PPR 55898 Rev
0.70 - Oct 14, 2022) says:

 "data returned from shared L3, other L2 on same CCX or other core's
  cache trough same node."

As per my knowledge, "shared L3" and "other L2 on same CCX" has similar
latency. But request need to go through DF for "other core's cache trough
same node" which incurs higher latency. Thus, setting both is important.
This was one of the reason to not use mem_lvl_num in IBS code.

2nd reason was, perf c2c (c2c_decode_stats()) does not use mem_lvl_num.

3rd reason was, perf mem sorting logic (sort__lvl_cmp()) does not consider
mem_lvl_num.

4th one was, if I set both mem_lvl and mem_lvl_num, like what other archs
do, `perf mem report` prints both, which is kind of ugly:

          464029  N/A
          340728  L1 or L1 hit
            8312  LFB/MAB or LFB/MAB hit
            7901  L2 or L2 hit
             123  L3 or Remote Cache (1 hop) or L3 hit

Without mem_lvl_num it's much cleaner:

          330057  N/A
          229646  L1 hit
            5842  L2 hit
            5726  LFB/MAB hit
              78  L3 or Remote Cache (1 hop) hit

I think we should clean this before applying this patch? Other option is
to add bpf filter support for mem_lvl. What do you think?

Thanks,
Ravi
