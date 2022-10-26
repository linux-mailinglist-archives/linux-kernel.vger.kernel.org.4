Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C8360E2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiJZNyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiJZNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:53:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA98109D70
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8kUeGYco90gCKnmxfgI2LglOSLig6D30KLj3eWFX6BYsPhohF5hYosEZzqqnofkPOf+0keE3CcuspTIhO/40uNa+ufX2Jl4Q+9gZ4izqmgFLlcplBsuZ7BRSxEP6dmIYDh6JnCccK41O9qFccsmw6I6/+rDOkJQ9cRnSKITmsD3/DQ9KgFMZ0Om1lHyw9Wfd6pMLRkgtpmHmKr1cTNw18ejXTaXzqU/N0n6wAfYvpYnMz1zAqusvlbTILuroQQM2fX8tW+4RKJL+ERormzVcIHhEmI5C96Ua6XjbbuNDWJJhwfeMfWjInJFenud2+Vnz2sIPkeNfUMHkeK+H25Low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJX8KYzKlHU3yzTt9G29AejrOtdOL52wA/44pX+hS5g=;
 b=jZDyjWct+WesxbjifizOBs+ODQg0koKXpntxEOHzJrLK5yAj3Hfzl4oce/lP4fJW7qlZKR0YiR+DdNkAB5nLsZrynsl/98W3B8ab2PLLp+NVr9vHcZPcne1LFlm6zZzQcbeVI/lmfSmRnTxDzbg1IIJ5CrQ7dBfTiiGfjJ+fS7ACnTEeAyTUBnxdwmX5lsp9D38DxRCuwhk50WN3oQ1FGUgUbM1wDE2XIeNdK7T6s6KsDEAIolfcyUrRkS550b0qtUVaMWkRes8T96bAEBFgud+HSeHYaYAzJssclfyA+deAutqpDNcNWg0eCAX6HsnWW0FxhrajsFDA/uRB1QQ7cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJX8KYzKlHU3yzTt9G29AejrOtdOL52wA/44pX+hS5g=;
 b=xcKYVAe/XvJI7mBk6EeMYanIo1C9j42TI/twP3TLyo7PCgsaQonnH7O7gOxP1SwtyiSDtmyTo0UTBt4ZH4tFkakW35saQomYaHLFZccU1Ya6I9MjQBSG5KkI38CoKACkHbLXVWRBSfCJE8qd4JtR9GO0YGn53jofMNDnAWh9aSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 13:52:50 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::fa1e:a29e:2f2c:43d1%9]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 13:52:50 +0000
Message-ID: <2ba741c1-ad66-c3a8-3c73-ad3819da3a27@amd.com>
Date:   Wed, 26 Oct 2022 19:22:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: perf amd: PERF_MEM_LVLNUM_CXL -> PERF_MEM_LVLNUM_EXTN_MEM
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <Y1g/H2/ljZ1rGmM9@kernel.org>
 <678160a9-49e4-76ec-f002-8c19521a4ef5@amd.com> <Y1k44x5PkAFNRnWo@kernel.org>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <Y1k44x5PkAFNRnWo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::18) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbb9dcd-2d2e-4bd3-764b-08dab7595f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1Ufdmoy++YtQQvBCS79cQOY3kPaTcDmHo10E2EZky4JprrCblSgPm+7KWVm4DWHhdO/85iHTKKCD/5FevNDHgfAq9o+BQLwrW/JVDDsaHgC9Hybc5cDuWDcg6z8qqGG9SAoQBXP8CUFwi4w2P8LqxYK+1moto4yCcH2YySBHolMp3ZdO4UeOh7tvrBta5H60TDF/6OQwB0KleRUFFCp5kKtlLO9dVXkBCagjUVSoHqq/nXvI9i75oH3xeFO6wVc5LVrBEd1A34jkVfiY6cY6I36kDo+9xo+iP4OCIkBebzWSk9QOQ5FmeF2zBOal0V+yByVDUOVDsDumig+frXBzs9UTL+r+4mlwan8vAuzvEL+O9v5XaBYyB3ycn7UCNP5w7YFQTzXf3Ji5mn3dQs5nFRzqbjOdGu/GRgu5ARhHm46lyLX4dsxCsKBzxd7EJCwkCPNjQTlPKfcDhCVBbr3Ba6EWQ0dbmdsLxPrl74BNCY4ls1o2IaRbXEVdgA7QHCek6ZyWnTq2lkcsyKSh9YNXbg0i2Fz3t1y1bzPTasGwtdfJIY7gJQdkY5UoCbSPfRr5rCl/YgwLVTbD7/w1lLWYUNhOI3m1jn7sJODzTmAcV0rHdG6fRoc6+QXFV5yQk0jR8IJRyCYkv1Ph2KbHdiZg8BVA1fs0vcfbXmmsMAkDIJHTYK2tK0ccw53y+QfFNjGZl9sT/xGXHT8xvsXZBvzxY3j5W6iCEqJjj9zr4Bm786sLVFls9W1ZVXAo2tUss98GqUnEzLV+f2RPTccHBAkmxfpR4QoAdkOjRjLRS8w4tqFogmzj5c5Cn7r8XUi4YRM2xUFt+nwG7+FKGCla5vFiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(31696002)(478600001)(966005)(86362001)(6486002)(83380400001)(36756003)(38100700002)(31686004)(2616005)(186003)(6512007)(6506007)(8936002)(53546011)(5660300002)(44832011)(6666004)(2906002)(41300700001)(66946007)(54906003)(6916009)(26005)(8676002)(4744005)(66476007)(66556008)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2FnVFlSWUU2Y0ZJbU44VEt1OHc5bEhOSFNOVUtPbTVNQlJpR3QvUUdiay9D?=
 =?utf-8?B?ZmpWNDRpM2orQlpEbkVXM1FGYzR6ZFNtdW5JcEd6Q2JsSTV2ZVdoZ253ODVS?=
 =?utf-8?B?RE45c3BaK3h6L0d5dmhoR1pHcGhWaG9zVS9rZ1B3Zkh6MmI3TXhENXNMSVNh?=
 =?utf-8?B?WFF1cUZGOXA4ZUFSUEhKWTdtczdTOGdibjMyRGg2TDNwMS9pMytSSTZjaERk?=
 =?utf-8?B?dHdVOUsxVS83Vmw0elI4Qndta0t1bENPK3Nka3k0K0dzdDJJV2RzSnZjb0s0?=
 =?utf-8?B?QURjY3dVVTFpbWpjZjMwdUxCc2Y1QkhNYlpsQUNwL3lZdjFkYlN6K3VUL25W?=
 =?utf-8?B?bkN4cGVXbit1VGhPSmFVOGZYMjNzNHkzKzJmbzAvYmxheXNLQlNRRExoZWI2?=
 =?utf-8?B?bGpoc2ptbXNsVFhaVkN0cEpHcFFWVGRidHQ1N044MG90Q05OVDdLSVBaZUNz?=
 =?utf-8?B?WWcyek5TaTBZaGFKaWxmZFMyM2x0ZnkrZER3V3ZzS1Rld3d6MmNLdnJNK29O?=
 =?utf-8?B?MFZPQlRZRkJnRmhNbkRoU2RYTEJGUytmQWxlVHgreDBnYVdoZTFIUVNWRG1T?=
 =?utf-8?B?RmoyNmhqMVhNZU5SWFhKWmk1WUhvQzhOT2ZUQk5Lc2JHcWhzSDlIcitnR05C?=
 =?utf-8?B?bHJYdnUyY3hIaHpwUXREdVFvdlh4ZkNMM1JGT2JoeWZYNHlXbC9xSE5kbUFZ?=
 =?utf-8?B?bnVwYThEdUwzY0o3a29DVjdOMHp3WTk0S3IxTVBicGovay80Y2kzZ2hrYm1B?=
 =?utf-8?B?RHJhdlBUMzFLZVZicEE2aXlWV09GRzJRT0hUZngvOGgvQ2EwcmdYUHVSakNu?=
 =?utf-8?B?QlNFWWxLVVdONnRqNWR6Zmw5UE4rQ21zSWlXSUxEaEtTZzR0VnVldEpEWmJI?=
 =?utf-8?B?NHFZZWVNbk9TdzZIQUtrWHZpVlV1Umtma1NlbkgyMWJiNG5zcExHZk9qR0Vz?=
 =?utf-8?B?NkFjQ0xqSTFuT2MreHJOS2JWN2hEbTBmMTlteVRsV0ZSQ2JGVThkSVBaMFFY?=
 =?utf-8?B?elJtN3lxVHF3WThSQytwLzhiRnd5d3NtNkJGRXRQcUgxUnJLSDFQa1BwOWlL?=
 =?utf-8?B?SXIxak0ranJTMjJXVWFjc2FCMGlReTRaRDZjUG5sT3FPZTd0ZnFnN05KeDVH?=
 =?utf-8?B?bmNIOUROSTFvTStETTQ3WXBpVmZXWGovTzdBekVBK0dGMWxlSG1tUWhaYlhX?=
 =?utf-8?B?Sk1jR0I5NmRMT0xUVDhvTkFZZ1UrSkJLajQzRXprM0lZY244bGs1MzZWZUpP?=
 =?utf-8?B?ZkNZb3YvYXV5M25YZXJIVURLamkzZzQ5R3Nra3FGN1R5L3JwYzMvVkhqaFlI?=
 =?utf-8?B?T1hoMk5TM1ZvL2ZSN09YbGNwRWlEb1ppbC9aNzdpbnN3N09VMFNodWtzNVBz?=
 =?utf-8?B?T0NBYWhoT0tlVm5oenpsb1dvSENLVk1yQ29GYnY2UU1GcjBxYk1HOUJnRTJI?=
 =?utf-8?B?d1ZqYVZkYlhXb25YRTRDUUlsNGRFUGlLNXZXMUdlU1FyL0xzMnFWL0szb05a?=
 =?utf-8?B?ems1bVByWVhEU1REUDFCYVNSMGc1dEdmamYxWnFSVzhBVURjZDIxVUU0ZzBh?=
 =?utf-8?B?ZTFNam4wSEFhdzQxRDlZRy9rZ05MbUhQNXVURmZVS3ZkQktkMzRJaEhwSStn?=
 =?utf-8?B?RlVUWWNUWDRhUjlUeWJXMTI4ZTc4eC9JblZIV0dlM1dZQUJ1cm42MG90VVpu?=
 =?utf-8?B?eGZ5UWRVcDFBaTRtdWxpQnUrejM5Y3FoWGhIYWRkMS9NVkgrSGlmdkNvMTha?=
 =?utf-8?B?a3RUNW9xdmJpZmVNVVpJWmM5RjhUcENqSnovMGxUQ01tL2VOUlord0hQV3Rk?=
 =?utf-8?B?SDBWbFRZUGpVK3dObmxROHNRam43MEhlWlBZZnp4N3hkM2ZVNjBUNmtHNGZE?=
 =?utf-8?B?R1k0OW5tdFMzRXdZMUxLTGxCYS91QzFKN2lEL09sdjNONUlpK0lkSklITUdI?=
 =?utf-8?B?ME9ibTBCUjgvSFM1cXFoaXNqa3JnazFhWVA5NWgyVllNTWdBc1pxeHp6UFFG?=
 =?utf-8?B?VjRHTlpMcVc5YUwrRnpDeGUzUDZNYmdTby9adUNrUHc0UXZLQVlWcWhpM3hB?=
 =?utf-8?B?WG85cktIM01BaWdINVQweDNKMDRCenA1anRlTS85VmhvUlRXZ0hPNkVqbjBZ?=
 =?utf-8?Q?dlTdGF/mRpXxo0rtfebOujJiS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbb9dcd-2d2e-4bd3-764b-08dab7595f03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 13:52:50.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1VsMiw2zxhZyvaRw/Hic8hn9HjqMdaZo00M3A8QgIKRor9gif7HpOLQQAlotMKoRgPFpTjyfkejfup9if0RFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-Oct-22 7:10 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Oct 26, 2022 at 11:16:24AM +0530, Ravi Bangoria escreveu:
>> Arnaldo,
>>
>> On 26-Oct-22 1:25 AM, Arnaldo Carvalho de Melo wrote:
>>> Ravi,
>>>
>>> 	I'm updating the tools header copies and noticed that a previous
>>> sync brought PERF_MEM_LVLNUM_CXL but now this got renamed to
>>> PERF_MEM_LVLNUM_EXTN_MEM, so I had to add this change to the sync of
>>> tools/uapi/linux/perf_event.h, please ack.
>>
>> Kernel header needs to be fixed as discussed here:
>> https://lore.kernel.org/lkml/f6268268-b4e9-9ed6-0453-65792644d953@amd.com

Peter, can you please pick up this patch.

> 
> Gotcha, will leave the tools/ copy with CXL then.
> 
> - Arnaldo
