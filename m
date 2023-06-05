Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F01721C5A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 05:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjFEDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 23:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjFEDAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 23:00:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB1A1;
        Sun,  4 Jun 2023 20:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBg11iGTQL4zp0R/rmXuQB02qGcw5USu0xV6IDJXxLQOB2tM8G75k/kV4cPJBJNAuRCq5C7ir7YR9speBzth+3Ly9GuMgKHcwveLcTAuawgC8yvh5Lwi8ctugnzX/x7wK7s48UNiTzar7lOjiuJ36BwbngwGXoxmECcz+74XqZvgol51q23jbYDXDmTtm98N4KX1VWOXjXUi1qxYKXTNTRO5tactnL2tLifrddYgmCQre3G2Y0gIBdxSlrvwoRrI43OzpPyAP726xTryw5HUTTLbFXLogg6f6mWj7ttokFjmttgf5JHWJGKBtflKLpWAuRtjvI4HOMq71jkPVlNaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNvw7QJa5380MGZpoUcy0iccLHEi6eUyeZdom0hOd68=;
 b=KV8GCkGrJJCB8yqIv+yhtnHGskrMDt6OsjZq2ss8OMl6e4NQbLa1Dh9KybSA0qmKUd7SByWPz3aUsmO1vxf3PuJwKwr6I9EeTHF3LK214L27cikKZrSw2WxluXEQ2BplU9Pi6w22vp8wx3XVK67XUz4X94qYUkRgP9aYX/1lkV1lGv69xMIihWJyCUGa5uheIhPvsyg7QdCeY5C5MTrTo3KgUjWA+paaT1+1TvuDtAqmH1PV/3VAIsAAif7WqkIyzwj1GeyBFF5cgwXY3v1RPOOBuAGymC8JuXdTFIUIiPg7YHM9ZMGngbCXyutHkQgIrJRS4eEfwFNQxXDmsP2oWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNvw7QJa5380MGZpoUcy0iccLHEi6eUyeZdom0hOd68=;
 b=tECc5bbS7cRz1XdXK8yGe5Kfi/xKqLoQvkqClbDShfBxfc4dPb2dQYZV21dk90y37wz8bIUjz0V/rPtuD+/FauEqa0MvxhHNF+qy5kpzvIzxuQlK4EneSS2EtDJlS2ZeTrgN41O4zos2eH/THLjyL7KE+gChCApN29tqL7QVtdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 03:00:05 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 03:00:04 +0000
Message-ID: <512e8b06-3ef4-66ae-5ca3-5a863a10c51f@amd.com>
Date:   Mon, 5 Jun 2023 08:29:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [REGRESSION][BISECT] perf/core: Remove pmu linear searching code
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
Content-Language: en-US
In-Reply-To: <3abd3693-ad87-9abf-a762-337076638fcc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::30) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d587b48-669a-4a18-122a-08db6570f617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qr2iYDebxadt7QMcLECrUX500Rek2ZjREeNwcklJw5m1VH7sAZpBxT+iDFCuKNDj0+RS8B8u94C3uUbK23cIZfV9BJeVJJ9M2tSKZkw+2Pl105sZJU4/fyJXuQTNTLI7TwFljxKdwm5BOizw6EQOT1CWKSTGw6t9A0OQrDD4H7PktIKIiwMenk8vALuEkhJcEwtQROtenIFZx0nnZdvTgx+nTl1hOWTEGPnupgPtbmqcg5yduob04Qt7rEwVBQ+zWrsGOWsAmArN3kIfW9XRXtt/BfMA4cKznOgP8f07ZjqVtm/FVPe0td/uVIZ7R9D6Ius/w/0KGaj7Pz3HAGQwwFguGizQznbGtzsE67OHcq2ub7k4LtvfYRNE4Z5nsM+0XDaKGSoqPEz6KSzWSo8S2qNrdSW8+QWmtZ++mS65p6uyH9h7EzzEv53XK3KybgdNzD4awIb6l5NqzoXbQp+n6MHd1peJfMlS03eegpfvko0CXLcT71T/JGErUSxfmzcqsh0IqFQU+1t6/qLKr1lvM51o2tGfhJ1SjDBkmOUeLkAJKyOvpHIXPvs39YrFKZYiP8hKDEaAOB+VzEe7FrqzTkNlmuxhL6+tB3WYSSN8dWhWnXNiD6tuW3hBZ3SiKLFnxOeq2hvUC7PSEqDUg7HA7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(66476007)(66946007)(2906002)(4744005)(478600001)(31686004)(316002)(6916009)(4326008)(8936002)(8676002)(41300700001)(54906003)(44832011)(66556008)(6666004)(5660300002)(7416002)(6486002)(6512007)(53546011)(55236004)(6506007)(26005)(966005)(38100700002)(2616005)(186003)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdLQ1BjUmZqQVl6MURsbjFCbGtGZjJsOVFqSGNORDJRYzA3dGRwU0xkaGg3?=
 =?utf-8?B?UHM0RjFXMXFOc2xLN1BSc1poWnhNbTZYRE5NY0RHampiSVhUTGx2eE5SWDY3?=
 =?utf-8?B?ZW9YNjY1Qnh1aDNrUmRTTUlJUlVVeTF0clpZZlNGbjU3SkQyZUhLWG5oaHE4?=
 =?utf-8?B?ckZHRGhpczFvUXZwU21xS0RFK2xMeWEvdFRRcitqWUw4QUVDOVZzOCtCWi9Y?=
 =?utf-8?B?M25IV2tVYjkwSVhaWGtkeW1LUDRya1dHbWVsbFZJVTc1N2wxNEFBTnJUcit5?=
 =?utf-8?B?TkRwUmx1T0REYnRINndCakJPUlYvOTJFOXZvdlRoQVYydnhuSllWTnB0VXQx?=
 =?utf-8?B?MCs4SWFyL2VnMElrTDlqY2xOOVFaUWlPZ2VNbFhRUlpQZzJJb3BkaDVTeTlq?=
 =?utf-8?B?R0ErSUlQQ0JVVmZibkhtZHhRODhsZEI4OFc5Y1JPMjd1RDd5TWVhV1FreStn?=
 =?utf-8?B?dkZxTGkrUk5FSXhZOTNrNVdRM2IzT0srZVd2OVF4NGJwUHlHR1RjV0hlUjR1?=
 =?utf-8?B?WlcySHV6elFmeVZEMXRMaEFaODVHdmJPWGRhMmNzZURHdVNtbjRDeUdZSVNS?=
 =?utf-8?B?R2RHQ3g4a1Z0eTR0SVkxODFWS1JWM3FjWGk4OUVrQUdsN3ZsUDh2elVKN2cy?=
 =?utf-8?B?SkJrd0tFcnplcG9zMEhrcVloa29id205MUZ3Y2Fqc0FnN3BxN3U2Uys0WUgw?=
 =?utf-8?B?aWdvcFEzNm9aSHZiMzh0STg4ZHdNa0VtdHJRY09OK0JhQ2dxUlRaWHZBSkFo?=
 =?utf-8?B?MTg0TnRxZHJQRUFhQ1U1cmo3NTVPR2p1WCt6eHNMUEt2b0VFTWJsaHJySkxy?=
 =?utf-8?B?dnVRYTkveFY3ZGppMlAzQ1RJeVk0Y2JkeXJYQXJ4aW1zSGdjWWh2clJtaTZO?=
 =?utf-8?B?VC9Pbi9aWVlBTnE0REVjS0tJSlhhMU5jZDZ0dkd1ZGppTS9rc2VJY1JNQTZD?=
 =?utf-8?B?L1FEM0FRWGx6QlhSRFhxUW5ob3Q2VXhpZWVUSkROa1lqRWdLQjVFd3pZKzdX?=
 =?utf-8?B?K1ZJYjVuRGk3Uys1TG9BSHBYNDVaM2FpV2Y4TlpOcS9vRTMrWi9LVzVNL1FM?=
 =?utf-8?B?N3FVeXUxOTBFMVcyMi9VOUZjWUFoeXhxZkc2eUpncUlkTndvaDNtYkhsS1ln?=
 =?utf-8?B?S0VDaFJ0eEwxRmlJL3ZlM0k5Y2VCQjc4OTdZc2M5bzVMcGU1UmI4RjVRMTFY?=
 =?utf-8?B?cTNGUTJJZGttNSs1Q0YvWmZpZEtKTHJSVDVXREtWdkw5eUZ0UkZhOE9xbmh2?=
 =?utf-8?B?MThqZUV5ZXcyUWxKUmtsc1diM0N4d0VNd1VQRzFTQVlXZmhWRXNrblBrZDJ5?=
 =?utf-8?B?SDNpdWFwNGN4SFN3YXh5aFFDSHFtTUZOUXVaM05Ea3B2SXRhNW5sdGJyK3gv?=
 =?utf-8?B?ODh3ejVQY0ZCazVYMVRWVmtjNVg2RVZWd09TVEJ6aGpsUWxQRW5Ca2xnY1Fw?=
 =?utf-8?B?bFhUbVNTVkgvdHlIaEx5RGp0TXFVTHZqLzhYZU16MkNiMkxKcWY0MndjUGVw?=
 =?utf-8?B?MEg3TjlFZTNaNXpkeHowNElMR2x6Mm9za0FSOEZQSXlHLzJpRUoyWmhxZDBW?=
 =?utf-8?B?dmh6SlJFRjdSVEEwdlVYUzdMaHNMVzRwOVVFZWQvdy9oK3NEcUUxTDVUYUxY?=
 =?utf-8?B?eUZwMnYyVjM3bHlldzdQWUZWMFRzZ2R2Sjk4V3Z2bExadHRaNUtjeXpsei9q?=
 =?utf-8?B?S2oxL0YrS3o3Q1BpazVXalpzMzJRNGhBSmlvd1hsVUpqbTJkWHRkS2RuZEYz?=
 =?utf-8?B?WXZkR1R2V1ZrK0p5ODVKNDBkR3dIUUhJYW4xK05MRnJYV3BCeU1xM0pWRHha?=
 =?utf-8?B?TUJJU1d2R01XSHBBRGp2bEtmem5mQnNTRTB0UjhqOFNCbUZzMFJTRmdoOUtT?=
 =?utf-8?B?ZkxCY0xkZTNjZDRPa2JpUFUrM2V2ZUl5cTRmVzY1RWNoV01vcFhoUTc5c2p2?=
 =?utf-8?B?TFI3aXVhQ0MxV0FOamovSmpMeEo2RjErKzc0Z2w0VXVoZVFJcG9UOEFObTRV?=
 =?utf-8?B?UmJ6aElUS3NFVHZ0ejFKM1E4eGNINU5pRmNBRW0yLzlJdGROdWdZMnlGVnZE?=
 =?utf-8?B?VEdOeUlaYWJkRytVREhPamUzWUdKd0FMSDhsc0VUeFNOeVhTWTZzK0ZSQmM1?=
 =?utf-8?Q?T+5GJLlVlwvWlhgv1TfQ+RZPf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d587b48-669a-4a18-122a-08db6570f617
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 03:00:04.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kceMnWHlcY8z2aL2Y2Zl6mpENqGukSuTeD3vdYgUlLUthZsLZ7rYOzWZAXSoYI/IKWqMoi5iRYWUv6xtfG/nLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-Jun-23 5:08 PM, Krzysztof Kozlowski wrote:
> Hi,
> 
> #regzbot introduced: 9551fbb64d09
> 
> Bisect pointed to commit 9551fbb64d09 ("perf/core: Remove pmu linear
> searching code") as first one where all hardware events are gone from
> perf for ARMv7 Exynos5422 board.

Is this inside KVM guest? Does this help:
https://lore.kernel.org/all/20230525212723.3361524-1-oliver.upton@linux.dev

Thanks,
Ravi
