Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9949A734B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjFSEV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFSEVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:21:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75DCE44;
        Sun, 18 Jun 2023 21:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyXJOjqMMxYgs68m0SFuxYnhHIlM7dFnTYhipGlyutl7CNOPRFqept8bXUBPr4hf2Gn3FCppdBF79vzHs7xYdTGAXNHKqBlG1K8YL8kA/Knu9dh/KbMBtwBr9WfObJ6MR0JUCDsfXPyz8BAQN7bGjnIjA0sk7wwj0qUCh89/IKL0E6mnXIxLBOuVN9AoOm06y0bPvB15kw9k6AhCBKsJEl/KYdpoSlkQwXXpxVlKepvXV9bb3kuIB7Hj4LCff+Z0Z82mCN7D+tqib1UtFj6ypTlbnHq25MWWBwT2hlKPYp5Y2MkD+mTH9rZ4Wy0As/xZeIKfWYLKsg90rHl9OZvxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0G2FLEMzicQ0h85pfBe8+RyuGn/v1utywPffaqOyUg=;
 b=YquQfAucEFqr/1QQ9Arfud7gxwL/IqJjAfY4Vx6dd04w3X9LRvSDKDsoB4V33Q+EF5QZNDfDxAGcjDqcaCcU8IJo9wN24d7dN6Gsn0M3pqLJuaWAOM7jxxyM6dRy5loGCa4xOPe/J2K/k0t9JGJ9og7kaKQPfa/4o5SBX/VWvePlGKIEXvUdEC89OYUluNsrUz4WZIZG/bTZ4fwAhfFyLsiZz/fgqk7k9sP0/qcYhVhImM7y5vZvc0WBq7yQIewTaKM4oVFKSyV+4lVxW+ZTr0ZytRpcLE4bbHiza1mcv+Iea7MoD7AWg+agkX+zxJEMfaUZ70Ikno0zIuwWWDJgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0G2FLEMzicQ0h85pfBe8+RyuGn/v1utywPffaqOyUg=;
 b=H/nFDlSA7k11ZIGNZP1vG2CfGdkrjA1RJ69td9TkeIwYRgG8oR5rV3Ij+nPBS6xzw2Du3croadVev3AMddwfh7ojj3FtVT7rPQAhjcapyzBzotpOdpyOE94EccrnIKyEU+G8GoUPpCNSrT1QJ55JTtPkkBoBndxbqEhfG3GORoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 04:21:49 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 04:21:49 +0000
Message-ID: <93574312-f467-04af-92af-5b5476043977@amd.com>
Date:   Mon, 19 Jun 2023 09:50:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/3] perf test: Add metric value validation test
To:     "Wang, Weilin" <weilin.wang@intel.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Alt, Samantha" <samantha.alt@intel.com>,
        "Taylor, Perry" <perry.taylor@intel.com>,
        "Biggers, Caleb" <caleb.biggers@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <CAP-5=fVixzBLLiWnim8x6qcDOKH7uVfEWojTCP_H531Fhy7j-g@mail.gmail.com>
 <20230614203824.2895333-1-weilin.wang@intel.com>
 <20230614203824.2895333-2-weilin.wang@intel.com>
 <bc18bc42-3df8-30c9-10ff-8a4ba3d3d9f6@amd.com>
 <CO6PR11MB56353207BBD7BDA6C530EBDEEE5EA@CO6PR11MB5635.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CO6PR11MB56353207BBD7BDA6C530EBDEEE5EA@CO6PR11MB5635.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: f28ee2e4-08d4-4121-933e-08db707cb341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6OxX5LBLXZdr9Bk56bQbIF/wfklr8fqbdvP6tdgckS5tDCvB/1oONEe/n6yLap1yRmAqg71xAOvXkxqq7zkAj1YmJ0CES19RMap9V1VniTWxWVzwQNgMTLEYj0vxAwRYcSOpKL7qEC8bxbL1A24ocGtOYMqS9tPLzLg7R6rVaW1DJ0S/whDhWG7GVvYQWW5zT7hoVNaolE65xcawBZEo/09iQp1dLsM6BS9smCZkl61K4aHNSJDnRXgiHzF4u+euTeU2IH6ZFVHH/oXAwBAvFEIOTbpflZnie/hdtXL886UDthAqyyUrBJ3kpL6xlJY7+b6DTVYm5iH3QY9LkcxCPD9Tcs6s3cBBKA1yRvpHgsV/HWwrckstJ5UajoZHdaNH0GjLX0l9Mm15j6nDaaU5HHEh7gctnOb1Gf11rGqdFCuSxl0uwb5uRBWDUNobxb9qfWb2UKdmM9AmkQ9BMnnHsjhf37v6LCBSnGb7ugwLWZ7d+GqbMRYvHY7HlObfLzUP6QQJmNFgU0s8oz45k1AR4NN46QH0PhbzYn3cSFH5oz08NQsSo9MyNKRbWqstZsY7xICE6U7x7MeNrZKEJlYRlnFiOSYZhQFaa/RH7X2GaorUwjw90nPND66g8YYSgwQKiNeQRahoyfFrNw4OueMHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199021)(186003)(8676002)(8936002)(66946007)(66556008)(66476007)(5660300002)(54906003)(4326008)(6666004)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(26005)(6512007)(6506007)(6916009)(7416002)(86362001)(31696002)(83380400001)(31686004)(44832011)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5rOWkrVnBMM2lURHZ0Y0p6UVh2b212dDB3cUU3RFBkY1Z1YmpHb1BrUGpu?=
 =?utf-8?B?MHFaRVlzRkRrL3lZQ3dEdlByaVZVK0FTWE1LWFpkQ2wrYVl6THRoYkVUL01o?=
 =?utf-8?B?NWYwRnJRQmlIdmc4V2M1aUpPbnVyTEVDTzhUODhwbjBMcVI1RW8zTzJkS1BD?=
 =?utf-8?B?TXdtNEtQUnkyV2pmajdCTTdLc0xrMjUweHdGaFZ0bE1RNUdXKy9iUGJBcXVN?=
 =?utf-8?B?Q29XU0pyS2pUdnYzMXRUMklNV1dsUDZzalJPdEhGbEJaTkh2UkRxd2hralpz?=
 =?utf-8?B?WVExU241enZneFg5VkpZR3NOa0hJcUZZcFNOSDJJRFlFZWxscUIrcUZpOThn?=
 =?utf-8?B?TkJSWmRKYi90b0lFN2xqaXFRZ3ZmRi9FOUhIWWFSek5LU255YjBQbWFyYnVK?=
 =?utf-8?B?aHJUYW5UZG53RkwyMmMzbG5zaEsrdi9sQXlvQ1FST2tubkJvUkNTRndDSmRD?=
 =?utf-8?B?UnFoamRLS3Y0UGgvcHB5dnljNlN0R0dwYWFCNVFMWXJ1TjlqODdlSTZYc3Yw?=
 =?utf-8?B?SGJzTkk2NEFNVWdkUlE5NkNldC9iVUlpTmxRWmVqSkRES3lObHl6NHJKdzc2?=
 =?utf-8?B?TTA1c1ViQWYzVlJrVWZDdy8rR1BlRDJ5blFRM0xYZVJtdlQ4bWJ5b1dnRmpQ?=
 =?utf-8?B?YWQrUjExR3JLaUVhMTJ1b0UzL1pkSCtFRUE0aUtjdk4rVVo2UWtJTlQ4RWpx?=
 =?utf-8?B?TWZMZU1MWmRyQmltWDBZY3I1WWRYMStBMEFvSGpXcDhZTXFFZTlsVXZJUmFO?=
 =?utf-8?B?TVpweTY1K0lmWkJYNjVCeVo0eXppNzZhRWkyLzNhVVU0SlJKQnlYNmVmQ25E?=
 =?utf-8?B?UFIzYmd0MHVMR2JqOFNQdEd4Nmxxb2hhbUQvMkdZazZNZHYyR3UyL0dmV1RD?=
 =?utf-8?B?emxEMWljWTIzSFBENkZWbUxOaEc1Zm9LelE4L1NSYmFhYURvOUYyWXhZSWFa?=
 =?utf-8?B?anlIdjdJWlp6MklsM3lkM0xOWHRTUGRVT1d2QmpGak8rU0UweTIrZmh3RlVy?=
 =?utf-8?B?RG10SEowdzFTbEM3ZnNMQzRTdnBQZzdhSXorOFJ2SXF6ZDM5UnRQcVEwZlFU?=
 =?utf-8?B?SmpxZXJCY1Q0U3hqNVk3T3ozamJLdThudUhvOVNXTW1CYU5BclZTWm1RaFVD?=
 =?utf-8?B?TTMvZHEzYmpuR3hRSzJEMTVUSjBvM0VYM0xZcEREeDhoc1lNRDR1VkNZZlhx?=
 =?utf-8?B?MjVzRU9UV0JBZWhIYTZqcVVpRXI5Q2p3azlnQkVveEx3c1RHVGdYS2tXTUZk?=
 =?utf-8?B?ODQ2b09vVElqRUdwc3lyS2JBbms0RFk1UWhjTGphSU84cWU3QnA2QmtLTGFL?=
 =?utf-8?B?eW9TalB6UWp5SThsRFAxR25lbHFHODhqN0NpNHZ6OVlOVldSUmhtMmxxOUs5?=
 =?utf-8?B?NDZvTXplR2dSalZjVjJqK1NGejNPVysybXFob095T1FkdDdxdHZMc09uYXNJ?=
 =?utf-8?B?UThqcVBLVjExb29xR2U1Z3g1SzFvalprajVWZTZJZng0M1UwVTI2Y1AzVTNQ?=
 =?utf-8?B?cFp5WjRyQnhyZmQrQS85bGEvS3NxTDMzL1RUcmpaK0xmeTZlZ3lnWkFqaHFV?=
 =?utf-8?B?c3BUYXZWcWdzU01rZW9meVFNeTV6bkttYW5HckJyVWdvL2ZOQWFxb1JhQ1hw?=
 =?utf-8?B?Wld4Z3psYVRRS3VycnR3YWM2THVtem5mV1Nsb3JVTlI5N2o3aitnZVNyTnZm?=
 =?utf-8?B?dTZQbnpod091bE0wTlU1c3RhcE1qVHp4ZE9tWTA3MzhhdzVabHpTL1ZRYkRP?=
 =?utf-8?B?akUrbkJPbWFEWkNtTHBBMnR5WnpncVpmd1J5UEp6Tktaejl4SUY4bmUvVjFH?=
 =?utf-8?B?a2oyaE96UGNpbkdGbE9tTFFoTElXV0NuWkY4M0g2aDVEUHQ1c21JTDZsZlI4?=
 =?utf-8?B?MWpVSjBRODNWME0xeFIyM1YrOGN4eGIrdDRLdndRSllCc3dWK2xTSEhXUWMy?=
 =?utf-8?B?ZGh5ZG15YnhwbkpBVVRyandKQUFLZm9RN1hZMjl4eWYrcTlWYVpaZEkyZU90?=
 =?utf-8?B?MFNCb2JENENrcmgrSmM2RmZ1aktFc1d0R05zcTNldjFxQ25BWnkwcWwvdS9O?=
 =?utf-8?B?cmlnakxBMTZLVWZiQW5rQ3dsMm5YTmc1em51K2p4WTBEYjl1a3pZSXduR3dS?=
 =?utf-8?Q?Yns++M6Ot5m/9HqH63PHedmx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28ee2e4-08d4-4121-933e-08db707cb341
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 04:21:49.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGwckIyxfoWbczu+mmy9f3/sutdbi56y59NBPWtqSOZ0melqjylBaRNDizyZcROxnfaIsTAH7N3bscCW/41Q7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> +grep -q Intel /proc/cpuinfo || (echo Skipping non-Intel; exit 2)
>>
>> This check doesn't seem to be working. On my Zen3 AMD machine:
> 
> Thanks for reporting this! I've update this search to "GenuineIntel" in v4 to help solve this issue. 
> Please check it out. 

I'm sorry. I should have been more elaborative.

What I mean was () in bash creates a sub shell and thus exits from
the sub shell. I think what you need is {}. Ex:

  grep -q Intel /proc/cpuinfo || { echo Skipping non-Intel; exit 2; }


>>   test child finished with 0
>>   ---- end ----
>>   perf metrics value validation: Ok
>>
>> I haven't yet investigated whether it's genuine or false positive.
>>
> Base on this final report, it validated some basic rules like the 12 metrics for positive value test and 2 metrics for single metric value checks. 
> The test script grabs metrics supported on the platform and generates validation rules that only include metrics in the supported list. 
> Therefore, it is not surprising that the check passes on your system. 

Got it.

Thanks,
Ravi
