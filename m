Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B4E687E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjBBNOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBNOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:14:50 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51D46DB05;
        Thu,  2 Feb 2023 05:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZRkxaXwZthlIajNtAT6DNxw5oQPDSE6Z5MKQQR2gOsnzvZkCMjgbTz9tDe8hJmdFPlIDzvMez+qI2SalzfXJX0Fmx9PQiUKqVGQpwsDw2AcjKHKVVcbIWxOmywOeuUYNkT/q9drD8TQxeYHFqa6CJdQD28QDzyJ9ebxZ3yWmaJhMrso+Ssq6p7Gu5htjHgONs4WMMfR4e417ZJx2+KM1KxXW/1ghARDKhjJQpYLFl6XNrhvUnxTcraSgj1H75WMsSTgmajWH/m90qITrTZJkB/Z0jNcO5s24ozlmytPqg+S6+43F5Rj1luaP2zQIlWpK8KFwuy8Fgk/Pkx6PrTv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XosVZaHe/3uKO8JwfgVaq6sQEfncCsgbgzKbMfFk7NE=;
 b=jYsxJsZJHjt3WvdJYxn1pRjLMfvqqGhygV3VVdSvc7/BiPUYrPObq1g+HYh4uJ04U5UISoJTtHMfGzMP7ouuWp55z1DdwHgRIAkrHzddsrcIfuf94CuPZYU7HiexGsYRX1JXJq/gyPlUB+tkeaK/8Ytck0VJP+JXkKrIqAZRe3DfkdWxUg0xmok9roKTtB8PmfWxh7/5ZCBtswdn5cu1wx3JtKgruZ004HU4WIlBhVd4ytGAipgWCwy5HFCvppz8AfMKqH+KaON2EkvMYwfZmhvQaHfIBeyUTdIvpQL9M8aqGjyRjZeNnfaLSphdNlAHupgXUUnSA19XkxsTru0X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XosVZaHe/3uKO8JwfgVaq6sQEfncCsgbgzKbMfFk7NE=;
 b=OuPO0Yat2lxeNKSnmfzOkrmU2upoqhYs3IH1oHW+qysI0XTAedz8xFeOt9K39zClcmx2BWjon5hpCHS4qsBGaOnh3GlD85vqIkwLCZ+RiX11ycMRPIe5jllb4BMdgVjOd38UN0OAx/e4HRhTSTYdQtUl+WQp0npMtbd40IlD46A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 13:14:48 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::5593:9517:a2e9:1b6b%6]) with mapi id 15.20.6043.038; Thu, 2 Feb 2023
 13:14:47 +0000
Message-ID: <919bc749-52bd-fa10-fcd8-70e1a2b09c21@amd.com>
Date:   Thu, 2 Feb 2023 18:44:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/4] tools perf: Add branch speculation info
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, bp@alien8.de,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, dave.hansen@linux.intel.com,
        james.clark@arm.com, irogers@google.com, eranian@google.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com, tmricht@linux.ibm.com,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
References: <cover.1675333809.git.sandipan.das@amd.com>
 <Y9u0zJA05JNHpB+i@kernel.org> <Y9u2SKUYL5RgC0Cb@kernel.org>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <Y9u2SKUYL5RgC0Cb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::34) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: a15c3dc4-eb1e-42bf-6c0c-08db051f756a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rcj+gh8r9Pdq4IyDROB7g+oexJp6qbedoOgyt2B76rJ/lPAx7VRhLPvxC3mvlI8dsOlfC9B3kDjQAyHM6VenIXsAeuUhwRruBDbxqK+r1Ab25TMaEeYk0Gfi4hvS0YRm99MyB0pu49qGvoPxvbJx3EhQiXhXxZ2XMOnKliNfKFVnZF/rj5afQ6rx+hiL98vuqNUi7H4TKJoPD7m4zbynemltPYAz/8hnkNbKpPHgRwconNnAM2g0SDsGk1WoJlgnokqUfKOFzsCHzulN3+RhBbCYHCMshYcQyLJyXEHDXPNYa46HL1siVijQYaWFiA3hBUgRmTODhyO7NqmcWGlx80QDAKnFrK17gczrXdGPCBujQO7ySbb52AHIYuEp21wiO/UbVJo9DeNjJMkOgw/PGlv/v/JMQEEN6am12NBtu5wLL3T9o4bK59xs3CE4VFTaIIzSaaQOtnBgZ5/TywcgHAZskg0ves9Gn9FPU0lr72sScdJAZTY0vVV3U7RjsbWAUVsFTzkuA/y9EwHPSZefxlHPO213USjdXovxl7kR2Izp1KF+o1okr8UmDoDcD/F5rhMxUFUTkBRgZZQWYiItsHxAr4CYGtd3FCAC/idj0Sx4lCiODW+PwuDDHgzUTJzDejId7qbVnWNSsBs4Y3cOPCN57AfJhXosqGVGwiOQRJYQoRA/puVTuezkzkpdQyISKWmGqu9ovVz/RB1GCwqW6pbOFN3IJHCECV+HWzrb9zQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199018)(44832011)(36756003)(2906002)(7416002)(83380400001)(26005)(6512007)(186003)(53546011)(38100700002)(6506007)(2616005)(86362001)(66946007)(31696002)(5660300002)(316002)(6916009)(66476007)(41300700001)(8936002)(4326008)(8676002)(66556008)(6666004)(6486002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU1JdE9TaDAzOWMyUndqRHZHQjlwbHNBYTFNWTNzdlBCcHRrb1FVaE9uRUUw?=
 =?utf-8?B?V1NyaGhEbVNpY01EejZ3dVB4Y1V2Tlp4S2N6bW9ObnpJUGwrZVdOekdRQmpL?=
 =?utf-8?B?WisyYkVnMG5LMzJmVnB0TStKajFpZ2FPdnRmM1p6ZURXMXEwdmRTZ1o1aWpj?=
 =?utf-8?B?aDBQRGhQeDMvTG9na0hUaXBNUkhqWTY0QlhvY0x3SDdkV0JtYVNEUGw1Vlps?=
 =?utf-8?B?clhrbVpFODhBbzVuNDdkQ09tQWNWY01Oc29BWlpRM1ZwSVFhQ0JCd3QycHgw?=
 =?utf-8?B?UThBZFd6bklkWkNxZFF1RnJNd3FDRGF5YmFSWkdmTHh4blM5K0J6bzZ2ZE15?=
 =?utf-8?B?VlRxSk9pSEdSdk9yT0o1MTJWcjFpSzJkbTl1YVRrNU5PYnp3SWdhbitUQUg3?=
 =?utf-8?B?NENPTVB0VHpEaElpMnVpckRSUXd6bk0yZ1Z6SUFmaElJRXZwQWFKb3NBWW14?=
 =?utf-8?B?Y2FDVlZQZDNnd2R5bVN3VGRhTWk2RndOS3hUalJkR2tGa1RUZWZRZFJDSk5t?=
 =?utf-8?B?aE1UempLWXhZTlpCWFR0cGxzY2tHSHdMUStOMFJZaHNLMkpXTzdqRnRWNWVI?=
 =?utf-8?B?R2lSbGNReUd3ZFlweC9qUmNrZDBVZENqazlvMFEvMXJXTDFoVThZQkRWaGFs?=
 =?utf-8?B?TkJEd1pTRWFhUDdGNk8xc3FGTGlSTU5aMHUwalNDNm9Ca3RjRFdteGErTVEz?=
 =?utf-8?B?WjVqZ2IzS1o1TVM4SUt4YjZqUWNzc1p4RExYc0hFSzdEdVRibWJmMWdSNkh4?=
 =?utf-8?B?a0MyeUd5ME9KRGZESTFRWHdxT0toL2M3VzJEdmZyc3BFOXBPeFFneDhmd25U?=
 =?utf-8?B?NmZ3aTNFVU9RTFFHeDJ6alUwRHltTjJYM1dhcXcvY3BPUjhrNmpJOW1Xek5x?=
 =?utf-8?B?SkVEajFNRWQrQStCQ1EzL0dxTVhUOVg3dVlkdWlLLzZsa20zMnNpemJ0bU9z?=
 =?utf-8?B?VTNEUUhMNmdZbzN4YkYrdWpGTWkraTRCbzJvckErcjAwSTJONjFkRk9IVjdO?=
 =?utf-8?B?NGd3djRobmlvSFJmZVVrcEYyeVZ4YWpkRFdRUjRWRmxWS01yZzZrWnBpZVUv?=
 =?utf-8?B?WU82VlJRYVVMbDRuYVQxbWI2ZWpSVXNLRENEWU10emwreW9mOG9uelY2VDd1?=
 =?utf-8?B?ZWYxbERzSy9hR3NTVnU0VjJ2VWw3OFZjRUpIYmtIZVBvZThXS1YvRjNBaVNa?=
 =?utf-8?B?RFpMYjNha2gvbU1zZy82Y3ZncDNMM3h2cjlvcTlqTDkwWEc3UXZwWFJJZWRy?=
 =?utf-8?B?UnBCRlA0bU1yMG8xM2QrcXllVmU3YWZLaU5VRStZSytDN2ZEa2tHeS8ySDZ5?=
 =?utf-8?B?cWNFT2UyMjV5SkpZQ1RaRWVHdmJaMitOQW9WbE5ackhJOGFocXhDb1ZQeExr?=
 =?utf-8?B?NHBLNG9JbjdRc0xyeGgrQ0lXblRFd3N4aXdKVG5oa0w2amlsWUlkY0ZQODJC?=
 =?utf-8?B?bmxhdlBjOHpQOG5hMVJ5cElibWx1QnpXUG5tRDdmUDYwWEFMTmViWkd5RjR0?=
 =?utf-8?B?b0FPMFh4SnR3c1UrVVVwVWNaTzZzVWRWcXViSzZwSHBKWFp6RnljZXFHTjNl?=
 =?utf-8?B?akNNd3ZMZllVSStydnEzM1B2cGFKUzk4QnkzWFEyUm5MWXVaaTFIOWR6bEZm?=
 =?utf-8?B?UmZ0b2Y5bzNhY21UcWcvSEFEVWd6dnZKN1dGOFpYb2VaeGJ5R25Kd0poYTFC?=
 =?utf-8?B?UWRveGJ2SkxQNTNLSS9JQUdrT1VqT2l1UXNaVW5qY21vKzJMOFFrRHI0Uyts?=
 =?utf-8?B?eGRPLzZ4UmszMWVXME1NRGNEN2Z4MFc4QnY2bEs5dzJtYncxcUlHdnFHS3pZ?=
 =?utf-8?B?Z2tJWGFqcG9aNVNVWisxcWp0WEJiRWpaL3RJd0gzbk9QVkRSdDFmaGhiM3JT?=
 =?utf-8?B?RjRXWjJkcTI0bVgvdnlzU2c3QzR5NkIxd0NDMGF3Z29hMGpKTkFCaHRKMmM0?=
 =?utf-8?B?cGJFeGpZLzVNQVZzZllqSmpCQW1pb3dEcHZvZFZGMEdJc0MxaWFxcndyVVpj?=
 =?utf-8?B?WE1MVzQ4M2ZWNGtaeVBYUGZSbktqOFFJVTdjaWJ0WE9wVXJzUVAxWkQyL2tB?=
 =?utf-8?B?TlNLWHl0aklWd21XY1JHT3kxRnlwU1htblowOEduUW1weG1vT3VneG9ZTkhX?=
 =?utf-8?Q?UdXXdF0dyyEQtq8+IJL6xrUwR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15c3dc4-eb1e-42bf-6c0c-08db051f756a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 13:14:47.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2IS2pDtJ8GNU/3Yuk5QXe8U6t+iZPhA0CXy8iH+RkXv+hMCyhfjdKG41Wtf424Uvw7+NnEmNA1IHzMZp4p+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2023 6:40 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Feb 02, 2023 at 10:04:12AM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Feb 02, 2023 at 05:56:13PM +0530, Sandipan Das escreveu:
>>> AMD Last Branch Record Extension Version 2 (LbrExtV2) provides branch
>>> speculation information and the perf UAPI is extended to provide this in
>>> a generic way. Make perf tool show this additional information.
>>>
>>> The UAPI changes can be found in commit 93315e46b000 ("perf/core: Add
>>> speculation info to branch entries").
>>>
>>> Requesting help from folks having access to big-endian systems to test
>>> changes in the sample parsing test as I was only able to test these in
>>> a ppc64 simulator.
>>
>> I'll try folding some of these patches as 'perf test' must pass after
>> each of them, so that we keep the codebase bisectable.
>>
>> Right now, after appling the first patch on this v4 series:
>>
>> ⬢[acme@toolbox perf]$ perf test 27
>>  27: Sample parsing                                                  : FAILED!
>> ⬢[acme@toolbox perf]$
> 
> So this is what I did:
> 
> $ git rebase -i HEAD~4
> pick 266d6702711d299c perf script: Show branch speculation info
> squash d2fa279aba8d2863 perf test sample-parsing: Update expected branch flags
> pick b335ad966cadcbfa perf session: Show branch speculation info in raw dump
> squash 272ce62f64e60fc7 perf test brstack: Update regex to include spec field
> 
> And then combined the commit messages. Please have bisectability in
> mind, running 'perf test', and if it fails, add the fix to to 'perf
> test' on the patch that introduced the problem.
> 

Sure. Thanks for the cleanup.

- Sandipan

