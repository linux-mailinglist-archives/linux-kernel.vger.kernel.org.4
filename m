Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B616453C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 06:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiLGF5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 00:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiLGF51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:57:27 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239F5C0C2;
        Tue,  6 Dec 2022 21:55:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWbiPcJQv53Io/+0BgL498V/8NylVZuP17tNOkBwe5Xdsj/gNRcwL1jiITequo7ZQyTLgSZ9jq5iCcZ75SBN84g3tEelqHsEd3q5a9KDvgER0RXWJFwqh5yM3+01C/WUVxoEp1er9DGckbnB9IPk/bMcUOD1gFMgEq1NFkrieWBbyW7J1YUJ1o++PTAk7DT4NSE20CNW7p28IJAjWNWrbUFZ66NdASvrMw9nNWuMITzs5GUNHPBuiKZWK5iRjB+JrHz9VXL0R9NAE4B9MuYLIaUwyxqcLHMta48ZoC6pqQ/bqRtKVYiXTn2lTPiVEseBPs10dR9DzDyBmYOeOZ8C0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVpyRhXpGfj2hOJeuNflRT0tuqbYb8AVy4T41qZHm+w=;
 b=STELbFkuLbaXrbx8yxo76lN8jl8YragNRvoP3nqU2zT/121L2+yJFJ5RNmYgH9ElDokRQhP0ZOT+PbLWI4rQPh6HYoB9/guOKCO+fqN94coDDKY117aONFFrlA7GWcgT/qxtWlcmbpye7jXWmnvvQLAqrj7Lr08OkXA4jBVCyLpLHXxzFZv96yCGHKBrXarOFuam31yQ0v8wOA3dxd0WUfAr23ryQNiWRpVreI9SnPYypTHkOyrysgMMRdToVWY1VoH4kWhd9JKGESNRDcVDxJoIgjpwC6iu3GBWDHoLdwPnXQfEKsAEO4cwhcU8PAcTC9tlcNaYPejH3E//AtsZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVpyRhXpGfj2hOJeuNflRT0tuqbYb8AVy4T41qZHm+w=;
 b=GyZlhDlT2H8/SEhltRuSzXfO+sDjlE6JacyM6TeT+MF4gTANodAh/hTVbSbN0m2BMHkuWUcABPii45O4UCyg49v/po9IsKKi7G/0W+17aZabjjMc0MXwLiynmJwv6Xi5y8K90G3uPbrSYPVciK+9mD8rXs4eBCgz+O1BBI1RAgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 05:55:10 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::aa5f:5f2c:4143:f981%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 05:55:10 +0000
Message-ID: <1f4b2477-722d-0ffe-20a2-eba0661da613@amd.com>
Date:   Wed, 7 Dec 2022 11:24:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 2/2] perf test: Add event group test
Content-Language: en-US
To:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        carsten.haitzler@arm.com, Leo Yan <leo.yan@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20221206043237.12159-1-ravi.bangoria@amd.com>
 <20221206043237.12159-3-ravi.bangoria@amd.com>
 <C7F7A9B0-421E-40AB-987C-6D250B9633D3@linux.vnet.ibm.com>
 <2e45a93d-56fd-b18e-de61-51ceccfee8a3@amd.com>
 <2f0f83f3-91a9-a719-c36e-ca1ff5c9b6f8@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <2f0f83f3-91a9-a719-c36e-ca1ff5c9b6f8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd5308-8943-4c99-2b9b-08dad8179981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15s8zu8imLjQqctHKjTDRAcRXVAZUIUap1xRRCNI9f3n7Di2xr8WIXv6TyqtHomulci+djTdGnfneC/K0JWmteMmL6/eB5UvjZ+1yw93vk9QKLuOncZytw7rNsqg4IoB69/0/gZIPz32x017IOTvYgb56LvAYS9TV8cHWjwoz37ee5+B50X3IzDF3/966f42iEzx73ivcb0FX8xvTRrkBjLUoq+IwSt+gHbgmGAq56prE9X6VmfKxN8pIb4bRyAXGokOHwYvLdK1iEdZAdAn8xrJU/2G0hZCjZV/9UN4Bbu1vS1KIiWEr9jGyG30fkjS0Nn3S2UlmAa++Kj7mOwF6XZZQ4ODW+HbkMo2xMVQKtagIUa1J3UYYErYF4zBsuHN6+SJE2Y/qaUGQP2mEUwutbmw+9aEgvZHV73JxTThfduYA6p71NUfbL6JhkLdWsAvLV0hNHSYYgPGC7vZFlG4dGo+FmiUAwAtWaJHXEQfY08SYTu3J8BHh5AAyBObfgB8C2VsMLJg+EWFN/QlJHfHGFzcGTtQ/YBfzrge5yBTYTv1yVheU0+Iczb1kxHbdnv7STppzxF6aTe/aRiTOceCywmlqh2X8GnfDM75W1hUYtG50r3AvFj1bpLSfhxP3FN3Bx/DtTKa+IkubNeqkKiFm/De+PLOjwN7gHuo1MdiMmxowy2xbeaqB4lvgXVuRUzWxDMK+4rscwEHyBPhllysehvJTIb5mfvAz1IUbU47rhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(86362001)(83380400001)(4744005)(8936002)(7416002)(2906002)(44832011)(4326008)(5660300002)(6512007)(8676002)(26005)(6506007)(66556008)(6666004)(186003)(41300700001)(2616005)(110136005)(66946007)(6486002)(66476007)(38100700002)(478600001)(54906003)(316002)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVTSGdoS0NRMnJxMDMyYlJmOTlqY1JLdUVJampwV0V6V0tGMXg3UmFTbU1I?=
 =?utf-8?B?RVZqd2xxNUxFYlJXQmRQQlNNL2hWS2FweGtiQW9EYW1hcWZFNEZoSWovSHYx?=
 =?utf-8?B?MEp2QmlLbHZTUENMMFJ5OXFtbUVDRGd1NkRkYnpNMTJrRm43VXRORy9hMlRQ?=
 =?utf-8?B?WnNvUGxCL3g0UFN4Mk5WOE9OcXMrdWsrbldyRGUya2VpV2hTL25VZWZMWW1Q?=
 =?utf-8?B?TWlJSnJrY1MvYXpRbVUySldGVjBMQzNLTkE1TUMvbzJvc3JRNXJmSmVVeS9o?=
 =?utf-8?B?bkhPUXZZQWhiUW1GSTc1ekFKZ3JUM3FzMUZWaDRMYmVJSEJMV0ZOVkxqWUxL?=
 =?utf-8?B?M1VyaHRsZHQ1TFMyWWZYcmsvbXNYUHJxamQwN29EUUdwZGJhcFlxanlKQ1JJ?=
 =?utf-8?B?RUloM014b3k2R3V4R0hwTWNJZHBOK0hVeGk2dXJCVDc3UHdlUjZIVTRJRGdi?=
 =?utf-8?B?MXVUbHk1MExMSk5ydzhpTjh5eTNiNE1NVkVnNzRPNEh2YzhqYjZCNzlEYzY2?=
 =?utf-8?B?MVVzY1FuTnpaSEZPaC9TMUlONVoyeEZyckpBYWlRVjdZOTVpWXdtZkE2UXlq?=
 =?utf-8?B?dXEydmxHRmxiaERkOFhrSVhSaC9ZUTdsL0t1R0JNbW9VUkxzbWlvYk5HZnlu?=
 =?utf-8?B?WTU3OFc1R1M1L2NzZTMvekgxMDBoelNTem9uWFlreTVTanN6UFlnTXVodkVB?=
 =?utf-8?B?dERSbk9LaTFXNml2dEdCQzBNdTFKRTJjL3FrRzBlSjI4V3ZqQ2M3UmIxcTAx?=
 =?utf-8?B?RmxSNGJXRGhXcmwvZmUvS3FRaDJlT05FaGE1bG9LbTc5QnVCRTkyU3ltbC9p?=
 =?utf-8?B?SWJNY0pXNWdQMzREdFZZRXZZcGtGRm5WY3cyRk45Q0U5NHFqTlIyNjIzMEl1?=
 =?utf-8?B?Nm5IZkREOEg5b1lETnhpd3BCM05ZOEJEaFpLSTdkOWdkRjRKYnhlWHlBRDhh?=
 =?utf-8?B?Y0dJSzVNWWl1RmFkM1lVMjBTaStMd3NNb2k1MHBJK2drSUE5V2hOMlE5bjJK?=
 =?utf-8?B?MGw3Rk56Y28vRU15Zy9hdzZ5dnREYlJJU3ZtU01adVBYMnh5MjRZUUUzWHZ2?=
 =?utf-8?B?bjh4VG1VaDg0Y1hMTUtPWWNTYjJDTzFhOFlQNGJuOTQ0bElSRHg3aHFNTGZL?=
 =?utf-8?B?OSthQkllcWRiMHo1cGtjR0wwODRkK29zNG95YWhGN0xZNUVRMkNid0VaWEF0?=
 =?utf-8?B?NVdWOW9uRkl3WVpRTWtVYmZnVHUrSkpGWitMejczRzYwTlJ6UktXVWovblJS?=
 =?utf-8?B?dU85dGh0ZEZxTkQwQnkzbG1JUkNlSEFiOGxUZHNidUFtVmpHTnZiL1ROWDFi?=
 =?utf-8?B?ZmxPNTcvSkV6U0hFWHpmay9nUFBtN1dUenAveXBUN2c3VHZid010bkh1ZWx1?=
 =?utf-8?B?V2tFWkJFN3oralcyTXZjQ3Iva1U2SjZCWmtNNm51dDBhbUFzRGJqYTZra2s3?=
 =?utf-8?B?bUMvdk1vQmpVbklkQ0VlYUkwaFNPTHFVdmNUZjVvcFJmYjM3eFpYSFRsbG5J?=
 =?utf-8?B?Z0txbUlZbE5VYkpNOXd1emNQMlE2a2szeCtpeDk0dzNpbWJGenFXMkRFaG5y?=
 =?utf-8?B?VTJLcTkrdkhwMW5iWEd6YzVNdVVGZmRUZEtpeFVHZERVbjdyUTBuL1VyNFdv?=
 =?utf-8?B?amh2ampDdkxzQ0xIakEyaDdYNHdrK1JIbzFIMG15K3JmMlVKc2VIc21DUHY5?=
 =?utf-8?B?KzAyN3IzTXNqcWZ5cVVJM1ozdFlBcDkxNDFWTng1Y1M5UnpES0M0NDZWYmFp?=
 =?utf-8?B?NnFUa2IvbGp2RENMcFlrcFRwYlIyQVM5OWdvM2JPZDluUzA0ekkxdXkyQ3RL?=
 =?utf-8?B?S21Vc1VMRDhickRtNFZ0bytVNHZNTDJvMitkVFBOSGw2emZhWHkwNWJVeEJO?=
 =?utf-8?B?b3Vvd09VNHZBbEUxZWpJS2dJUm5ya0pmYlFGRFpVbUpoMmE3aCtqUGtIS0E3?=
 =?utf-8?B?ZWJ3bHFYaUxIWGpScUo3a1VpbWpwcXlnSEIwU3BHdmdqeG5VbXJCM0dWN2p0?=
 =?utf-8?B?Zm85WHprT1BDQi9lK1hTTThEUVFHNThDL3VqWitMNGJTS2ZORlRCaC83WlJF?=
 =?utf-8?B?cnBSZzIwMVBMT1dwU0NacTFBNmU0dGhmb25Pcm8vUmtKc2VvYURjYkN5V2hn?=
 =?utf-8?Q?cC2hjRnFJVbhIA0U7ErMw5E3t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd5308-8943-4c99-2b9b-08dad8179981
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 05:55:10.1010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miR1suJz0yDxAHG2boIAV3OXU6NSz8+JeFbj0qboVSa9JooBvmizDX04E1FvidbyezlVCqY5hWe/3SdSUlil0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Event group test checks group creation for combinations of
>>> hw, sw and uncore PMU events. Some of the uncore pmu event
>>> requires performance enablement explicitly.
>> You need to open an event to activate hv_24x7 pmu?
> 
> hv_24x7 pmu supports events which can also provide system-wide resource data
> and partition should have permissions to access those, hence the check.

Ah ok. Got it.

Thanks,
Ravi
