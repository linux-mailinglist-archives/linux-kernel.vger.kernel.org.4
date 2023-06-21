Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C832C7379B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFUD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFUD17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:27:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B1E2;
        Tue, 20 Jun 2023 20:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF7EJ2XBx/zUjz3xCRwncg/2VTTctQ7glvEWUdgq/5IP50V4K5P5w38Xxkki2IqZv/CAbrdxQqLg4WUaYRHbB5dd1ELHPAt8s/u0vJrGqmW1fdRoF0Btbg9+lnCuZmwIPxDL4y+rZvNaaHY1/tPJyf7T8ZKD5vkJDDQWVTxe5usvDpdRi8R96FfU3OUmNQsHimj2cfCqVPsfzAi7W3XKiJzYPmsHLvsuXiP5ZiSRy5O6iKOTiPnkb6viLySF5XvEMAHF/PWBiqYV0eDHeiNmvfRWvfZrtyAihGtPy1BsRaaMs0AdmlvYHJwbm/nyBpmJ3VJwdlwBZcfoL45GVcRopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93JzRU7h40yVcscxnx7AZa3UkokfcajfYwyJv01haiM=;
 b=KTrYjm1BNY4nF9J/GfAAf05pnJO7n4J+HeN0zzIOn2PBsH1+XIZPRxi+QUidlbbzuSglBFIq+t0+7h7VI5VOYgFvjUO3w1mDD1i07HbDLvU9rZFRwC+7GAt+DD/MnkCF7+fIdmzp12kA7WLeOkhwcriynMylsaKNrY5/m69qgj30vzI2eJHWqiYbF0ZBc4Rhyg4w+jTJ3KvFyebsvHWiTfDQ4wcinRaHqI+UUcIxo/pE0V9kM4NJrLkp30mPkAmIVnR6WPb5rz3QsThMlrZDz/Dsl89dFFULLbVVU5aCU0bRzWKyvexWBCxrr+/CzxIe/nk1VzEjd/MYvM8ouJY6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93JzRU7h40yVcscxnx7AZa3UkokfcajfYwyJv01haiM=;
 b=Kd6ZbrsXCyyoa2HSJjLKHET89HBSsza8UaOPoEro3D59zPa/SJWYYim5x8AVmiZgVtKMZH/Vf8hMBc9y+LcxyCcvi+W2TB8QvynqdOlFRXfkHuH9w+3gQPHe6hd8AxT6o5JAt14ifjNpmdp4W3R1yo5YlmOH1SHTbfobEQcNz5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 03:27:55 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 03:27:55 +0000
Message-ID: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
Date:   Wed, 21 Jun 2023 08:57:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
To:     Ian Rogers <irogers@google.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230620091603.269-1-ravi.bangoria@amd.com>
 <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: bb55c8d7-c879-4a4a-74c8-08db72078056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgDDK+no+eu891FMal7z0KJn5g7pVPxLOBoHZSeAIrlSM+CXUwJpFA1tEbrzOhfjRkzTnMoFdE1shC5AccDGXPdFSnj8ZEDtd9HZ7i69yMwQnhUdjxtXgfFcBBkNSqeGnt3bdbP1a/6bDC+rQPBZqLLJ67RAHJznHtTYayobs5OfJEZPTFw+fVtNRIY29Jn+LztHCvlobjeJq0HQGtpWl2LzNIWY2StUc7oM093sWT8m77JSryxI2sJJkuVWlY/N99YKnAKzxmbp8nyLCsqyzHb1upZWybywsD6Z5YjkcM6A54lfEwT3KofrfIn97DIaFXv49OUNkws6M6H/u+EspAw5PLZVcHs5Ob/y2+Fty2A01v5aXimxLjfBDEgwNTz+W1f5+SFMq6zM+0sUyErxCpklb7/5ovwmYrzsUX9WiGVLlWpbYjwBFZ0KPaWpEfiNNvDt2OPzf3seM2rQR7SoaBppp3SjWIsgmAsh9PDs8MokGlSA5hY3pmRcevtjjsRZOCokuopd8ATVeyCTqXyBJpqO4Y06ZvvsNknNtrfb3XLjXHjMQifZVSIZNwbV5M2+3U4+Prex03cqzkT+tHZmFElADjI/2FLtdMnfU90zrb30LoEzo8dtfknBC/W5qV4Pyz9uioYAIqPjYCV8A/Ay9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(478600001)(6486002)(6666004)(83380400001)(2616005)(6506007)(6512007)(4744005)(26005)(2906002)(186003)(36756003)(53546011)(5660300002)(44832011)(66476007)(316002)(38100700002)(31696002)(4326008)(66946007)(41300700001)(8676002)(8936002)(6916009)(66556008)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNhUEU4cnJtRTZoRXlTVWQ2SFQ4SkcxRFZOYnduZXVvVG4yRFhTa2tvN0h1?=
 =?utf-8?B?cVQxcitoVWc4R3BSK3RMRllDbE14WWQwL0luQjBuUE05UFcxY0VuYk9wQUNm?=
 =?utf-8?B?Mk9qZFN1MEtEZmUvSk1nZFFNTVhqMkNOY1VBWW5vUjE3QzF3aGRrQjN3QklP?=
 =?utf-8?B?LzhVV21POCtldDJXcWFURmpSQ3hPZ0NiLzVUQWVIaDN4TXIrckpXRXY4MHdB?=
 =?utf-8?B?b3RRb2hSN09HYlEvTjl5T3JQdDVIQUtXckFtOHdEMlh2OVo2WmVOVDJEVDY5?=
 =?utf-8?B?dWhoalUwRWduaG00ckY5aDNrZnJRS1hvQU9nV0RCaWltYThFNUMrWS9DcTdl?=
 =?utf-8?B?SkJyNmQ3bWlMczlIN08wek5wT2tDaTRSMHpBeTNsdVNKazFLc0Z2emhsekZ2?=
 =?utf-8?B?M0hpUVk0bWtIbHJVeTlzMkgwMmFPYXpacXNpbTIyUlB6N1JuZGUrbUNvZzZs?=
 =?utf-8?B?UlFmYytzTFhQK1NTdFhUM002dDQvcVBVcUR1NXErQXFmQTZIZFpqRDNvQnhT?=
 =?utf-8?B?Z005OUJUeE45U2l0L3ArWHkzOG9HWGVpVGVtcmdZK0ZhS0hKQjB0Qno0Sncy?=
 =?utf-8?B?Qk1ucUZ0cWMrU2tGOHhLeUxFK1orSlpSWWRHV0lEdE5JQmJEUlRZeDQwaEF5?=
 =?utf-8?B?SWU1VDNtZEhwQ0lVejlzcU1QY3BIN0pydVJqeFNTTWNBYjhjZjRWMmtCYjNo?=
 =?utf-8?B?dFpQZkFsZEswdkJvM1FobHdpbHpSaVVtS0g0bDdkY3NKTHVLWE5rNytvWDBu?=
 =?utf-8?B?Qk1HSU1yS09DZXZiaTVydFo4bkpwNmJSdHZqM3gzM04yTFpRbVlTZUVkMjZS?=
 =?utf-8?B?aUFhYzZWVDZLUzgwSk1TTE11Q3VyQnhwR1RkLzBaU2FMWHdGMDM3ZWRFZlhm?=
 =?utf-8?B?ZGQweEVSamRNU25JMm1SYm0xRjlTNVoxWllpN2dmRllkVDh3TmVpUjBjWDRr?=
 =?utf-8?B?TVlhWGlQTWlVZVlTS21OTzJFTVByQmNObEhhMmdERktnTTB2SVVaYzVEU2R2?=
 =?utf-8?B?akMybm1YWlN5UVI0MktIcDZ3d1Fwd2JaTkxxMzg3Sm83SDBFSCs1N0wwZTht?=
 =?utf-8?B?WWhRenBIVWJWV2VzU1VScmoxeUlGM3E4Qk1BU0ZnSUZ1VytTczFvTmtwTkRB?=
 =?utf-8?B?TjlBcmFFNEpCVVdtOUhtaXBrclJUQnFoc0tWR3ByOS9GKzVOaURONkdlZ3BX?=
 =?utf-8?B?dFE0V0Yrb2ovT0JzQ1o1bVlyM3M5NDI5azNkSlhNOWh1c1dwTDJZVFFzOTJx?=
 =?utf-8?B?ZTdTQzRwaHlWWGhXU0FnUGFJMW5vL2NHZzlPbjVRakRVNTlNS25FbEJqbDRS?=
 =?utf-8?B?OVFQSmUvVTJjZ3F4bVR5OFVKVm1xaDYwRGFCMVpFSUNNU1hmRDVyRDI0MGR0?=
 =?utf-8?B?R2YxQS8zUTBRUDVscVp5NlNZUnFTNkYzSWpySEVZK3hxR0ZSRmtjUTZGdjRy?=
 =?utf-8?B?Qm1INnVTYjVaYm5jMWdOdnBTU3BtZE5OQ3dDWFNudW5qcUh2ZG92WkZWL2NT?=
 =?utf-8?B?Ymg4SnVhNjB2V3JlcVZXSFY2VnE0d2J5cmg0Z1F4ZFZ2VWI2VzBaank2eGNX?=
 =?utf-8?B?SFFtR3kyNzQyS0hNUUIvU0FLMkxpZDNFQXVYYVU2R2N0aUl0OTJ1WGZ4Z1ND?=
 =?utf-8?B?QVAvdWt2VXI5MVZzcW0xc0VVVGN2UDRCdnd3S2NvR29NTCs0aXRaV1NiWGtY?=
 =?utf-8?B?WDRmeTJQaDZyYTlZWXNSeHphMEwzTFFtNUdtYWpQVzdJbGk1WWpqOEU0WUkv?=
 =?utf-8?B?ejFsbWFoNTQ0STVyTG16Y2VtaFRwd0N3b3M4N3lEa09BVGREWEFYV0M3UEtP?=
 =?utf-8?B?M0tKayt5VG5VRHJPcFhRVC8zbkJHZlFzTGRuQ1hYWGFBL2FYNFQrK0Q0eCsz?=
 =?utf-8?B?TnJqd0Y4bVl4M0tWYnBtQ2hlZXdiUzR4NXRURGhqR1BiUVhqdXR3Szl3TVRk?=
 =?utf-8?B?TEZ0Q2RpeGZsbWI0OWxWazJnRVR2L3ZnUEF1UkpPSENKYXlQaHdubnNqMkFa?=
 =?utf-8?B?UHFnWWUrQ3pTSTlsd3ZBR1QxNzdMaHdhUWpKb2xhL3N6Y3B0azhINlprTjVi?=
 =?utf-8?B?NmdSYVd6SU1SaHVpMVNNVlVUaUQvUlNTMm94LzBUMFJuQmkrWS90Vm5GdEVk?=
 =?utf-8?Q?Mu0/gF6Mul+t3N18xYd1pCzAP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb55c8d7-c879-4a4a-74c8-08db72078056
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:27:54.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC1ppnMO9Yid+eqdkhTAI7mhPn9M8BRgkI9lK0v469auBBZZk9LbdQBmOU6csOJnfbmVpP12fqpFl8AkLg536A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On 20-Jun-23 10:14 PM, Ian Rogers wrote:
> On Tue, Jun 20, 2023 at 2:16 AM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> IBS PMUs can have only one event active at any point in time. Restrict
>> grouping of multiple IBS events.
> 
> Thanks Ravi,
> 
> can you provide an example/test for this? Should this be a weak group issue?

Before:
  $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.540 MB perf.data (531 samples) ]

After:
  $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
  Error:
  AMD IBS may only be available in system-wide/per-cpu mode.
  Try using -a, or -C and workload affinity

The error message is stale and misleading. I have a patch to fix it.
I'll post it separately.

Thanks,
Ravi
