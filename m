Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCEF710328
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbjEYDBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbjEYDBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:01:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BC5135;
        Wed, 24 May 2023 20:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rid7ySi8yRz04t4i+fbNE5QTjWiOYRVXTQLo5g8xKrGtzSapY1u4k7KsXM4ZL7oHbVipDuVr7QSQVEoOnOrSsrKZiGsk5SXuw2qOcDwD/WrbYeaCYZwXiKGO2rppvJaEJaZee8/2TM00FpE3WicbGSBfWe9kFcXhuAWths31t9W0ZVQH1g3ogQ/vLOztmnqo6I4rzYl1zld/QxcD/JeqjzB9YvZbVh7nnYcOGEQzrYsqUWgJrqNmsmy47kj3wt4AeyccSWsCZf3YW/1KrlBVZ8QCH+KK+QXU00/qHNlp7GkcF1d/oxw+/V9urjj08h/QuZ9WI15R9LynkjZKoyxVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73GfXwqpxKUvu0Kte+RYQgpVzUKgtlerCnpSeyrJTqA=;
 b=I+0fYAUBbuQXJXX5gHLB5CKQjx9hYTaTByaqXib3Mc6Hjy2k6qdFooyj54C9opDORIjkMml4huHiLHQhcwudr8D8HjpwZ8DcaOf78+VzDPCAH32xzrVvU3BiXakpEVBU6/f1OjjNFZk6NZ+1NLAb0flIYq7ixV4ratop6VUgxksYY+vvgwAtzXl6KrBV0kSFHao14Al5UeFhcWUUP4JEG4nJdCQsXihQCJsEB2NShKEFZO2WjVFDtuQOd80sjbW3n4gxDnWFVgbN+E/OA7NpN77u5x5Oh2tnnqyaPI2rSb4AWAIPXOm7QvXqznOm3LgqN80Iva2JdLxbElmXKqHwgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73GfXwqpxKUvu0Kte+RYQgpVzUKgtlerCnpSeyrJTqA=;
 b=vNRVhvumi8CY+P+g7yi9F6A96KpNHjmtX2Kz1LuqitQzDzUB8bzCVIdgYLoS1VePBqAKw4La4ElwYS72wZNStAcI9MCX23gBUVmqi2xEreHanhKnVq0sk5P7hrz0Z1u4HEvOXq3galIl2nT2JJsxa6bQIj9Um8XOH8HaXrpxpIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 03:01:21 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 03:01:21 +0000
Message-ID: <d06cac04-00b5-651d-14af-378fc25f37c4@amd.com>
Date:   Thu, 25 May 2023 08:31:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] perf test: Fix perf stat JSON output test
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230524210600.3095830-1-namhyung@kernel.org>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230524210600.3095830-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 83868ab6-4ba6-4b1f-0919-08db5ccc50c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDc7BLNO+WedrtPKAnofwlnzUOFMWZyTNtlhfsV5lxvl3uV6sUDwGFRpI1TKsg4e8ZENpA1xsqlelg/5dH34qarZ2eBx0EEG3t8uZEvKPzQH8MOWIgxFMyU1Vj10eSULkNKCnL1G/zItDbQBH3e9R3+0fEwpBUd4TJTjtNBUF3p6ynAUToqs6D4dbxYCHvXkzQZyuK8nP8oWZZ1oLLRQEmlbstYN9A6kizSa/T8KUsqaxYuv+Fc3ypnOtZl78O1tLfpkqjwAezPY8PB15DtWmU2UHy8JdAReYkjvZYZ7wh8YU7ap/z4LQo1n26em62cbh4LukTkSK9LGC6Xn5YFo6BkJO1e/g99U8Dx2HbSjq8GJJOQndm/DIpdfrv2obRsP3edzyM5ZeOnIlm0SX6eD4+AODPCjnWg3Fi7SVhLS5iqNTNDPA0MAgE1Vhb3Pwb6et5O0zxKBV/Jcu3Aw51nIlZEDo+SqinpSyO1Iz7CIfgT6p9GnzEAxNdpreVtJgD4CTsyP/bdNKPt2q+sDvmwnFT6v3fNFTdDw7UtHliafB0tdBv6SwZ7LWfL+1Mdj09sHFn2dTvYWZHKG8L8yhi3P4SPc05IdHh4N0ba/6GoPA0fvVnrFqEaSjcaWzqO6e2cpPiwiXRHtqwG4qwesaah03w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(451199021)(53546011)(2616005)(8676002)(8936002)(6512007)(83380400001)(86362001)(31696002)(38100700002)(36756003)(6506007)(2906002)(41300700001)(66946007)(66556008)(66476007)(31686004)(6666004)(6486002)(316002)(26005)(4326008)(5660300002)(110136005)(54906003)(186003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBRUUlVb2dQaGdVSlpXdWpWWndwelV5QXJ6T1ZESFBqVVZQb0hQNWRiNzhR?=
 =?utf-8?B?Tit6MWp5ZHZEcTZPUWM4eE5SbCtWczdmY1dQZExPa1VHZFM0eGZsaXpuKzBv?=
 =?utf-8?B?Vm9oc2ZQYmtVVXFOVE1qUDh6QkgzZ1E5aUtjTWRldldyRWtoL2svTzhLZThZ?=
 =?utf-8?B?c0swU3hmQlhYaEdxdWw2RFFnNi8wbU1FOE5qMVhoa2ZDdStUYzNkM1FYbTRV?=
 =?utf-8?B?RFM4SlBrdXZiNkRoWTRYVmlmTEZLa0tDNWJHamJORnRHeVlMc0ZoMHhBZ3Jx?=
 =?utf-8?B?WlV3Wk5yY1RRK3pyMHFnSENnaGFkUGVUem5nQnJxYzd5cW5CblQ3bWViek9B?=
 =?utf-8?B?V1RSa00wNTExUnk2R1AwbnQ0aUZ3dkFhZmRYOWZhYjNKeE9KTFdSSjB5R0M2?=
 =?utf-8?B?VzgxdmNEclI1aS9nVmxjOFdsZ2g1aElnbllxNGs5K1dRdWY4ZHJ5NXNDSnIz?=
 =?utf-8?B?V0VGMzNaTUZSUDhLajR6MllMUEVWdEVrMGMzTXFwcDRKL041MnRLVUNSRisx?=
 =?utf-8?B?SHJyWDZDOWtlRnlKU3RWL3FLMGZ2WGF6MHFkNXgyMXpldkNFcEZkRm1aci9Y?=
 =?utf-8?B?T0YxT0d5Y3IySGRlaVAwdis0OTM0R0ZkSHJ3dVFtKzdpMVVLMXh4OFZOcmZ5?=
 =?utf-8?B?T0pJdHJGQk1hSWVVeDBoUWUxa2Z1WmxxRTFjalR2K3V2Smc5aGJXUkJCdS90?=
 =?utf-8?B?NFNVNWVJQ2NaTzBZdmR1R3laNjlIakdmYXlvNEJ2L25xeGt4MW1zK2VVQmFx?=
 =?utf-8?B?Qno2WWdIeTFRTFdhaVd3UVVmdmt5bEMzYzQveG1pSW9OWFVWR2FkaFlJOVQy?=
 =?utf-8?B?N1BSMThCRTk1VWFkNXZndC9XMDdDeDFCcTFnclovSzVsclE3VlpNNHM4dXFJ?=
 =?utf-8?B?VlN3QVF5TE1UVXV5Z0pmaHhxWWFXYjdvaWpVTkVWSHhIdHZvVXY3TDVBUEJX?=
 =?utf-8?B?bEVDYVI2MCtSamc0Rm92ekFFYW1aKy9yczZ1MFFRbldRZFdmRUdTM3ZHUmg0?=
 =?utf-8?B?K1BMaE11emxoZFc3d0FnVnoxbXptcGF0SWY3YlJkUjFrMjBUNkVKejIvVkJ1?=
 =?utf-8?B?dUVxNXpMSVpDdUZWZFNXcC9RNTlIc29HRWZVQzVqRXIzNlNZZ3Q4a1h0VXpZ?=
 =?utf-8?B?RWNFdDk1QlJIN0Y4UWJWLzgwQVFTUXppMUlzSEhrS295NVQyQUhyTTd3bEhC?=
 =?utf-8?B?bDNQWEthSXo3a2NGY2srN3Z0Q3Q2dFl1QzhOZGNnMTZVT1ZoZzI4TVBkcTBK?=
 =?utf-8?B?UnNTZWVKd082WEpmVEVPMTUvaGRscFNDdXBDZGw5V3BhMXhTLy80R0dNQkpQ?=
 =?utf-8?B?WnRXTDliRzhVMkhHazRVQzluQTZCb25FVXVnblhVU0Y3REtteklGSkQwQkoy?=
 =?utf-8?B?UEN1c2NXWGJqcGo5MEdDYlovMUxNZk92RVRiaXc4b2dwQjVtb0ZHNExYV21p?=
 =?utf-8?B?VmFBbzg3WnVwMW9TWFR5czZ0RTFSb2NpYkIrR2tTaEp0T09iK28yVEIrSTI2?=
 =?utf-8?B?WGQ4MmdQOUxBTklJTEliYkdjUnNrN0ZHT1NWLzdOY2VmOWU4V1FGZlNRTnR3?=
 =?utf-8?B?Tkw2NXhkRTNaYjMveFc3ZVZDbGY3QnhVTFg2eW53OHBOK0ZlcmlENlc0RDB5?=
 =?utf-8?B?YW93Ty9IWFduWlhLWWpKR0ZwZWVSbkxGRnlrSDBQS3dTUUVFN1BnYThRT2RX?=
 =?utf-8?B?eFJpNWRiWFBudjdudVBUSkNIcmJvWkRwMEwrQ2tXd0RaRGYvVlo5cmdmWElV?=
 =?utf-8?B?THJySlRjckFCdUY5S0dzSEJtVXpyaDZGeENzV1BzZVJZeThtTlRSUzI5YkFv?=
 =?utf-8?B?SmdHWlZuTjYwRDhuRG9iSFFlYUV4UjhUaXJKS1UrbjdXUTY4UTBwM2Y1N1Vz?=
 =?utf-8?B?WXZXbmFLTG9zOXlYUi9MZTZYTTZmTmxMZ3NBcDQ2NlJpNTZhbFh6dGNZRklm?=
 =?utf-8?B?YVRQbnFGdEVEcVJOc0VXLzNDRWl3VityVkNCWWJyTVRudkp4UXFUR1NpK3Q2?=
 =?utf-8?B?aEVCL0tTTU93MWVFNXQzWGJVSXFFRitzNWw5RTFkUnpZK0d4RXg5SzRBcEds?=
 =?utf-8?B?OUlWc0ZpOStOM3YyVDl3UjV5Uzl1RE9SZU4rNXI1VVlML0FmK3BhUlk5L3hO?=
 =?utf-8?Q?FBaztBzMtJ+6M4WVsqYxTlnRU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83868ab6-4ba6-4b1f-0919-08db5ccc50c1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 03:01:20.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uspsgQ0AmyJkXlOF1O0W6h2mLve1PKfIfB3hyrISjpIMdFv4ACyXEbK5+AKKy6wPmFyrO6wywVliVHQN/HNn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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

Hello Namhyung,

On 5/25/2023 2:36 AM, Namhyung Kim wrote:
> The recent --per-cache option test caused a problem.  According to
> the option name, I think it should check args.per_cache instead of
> args.per_cache_instance.
> 
>   $ sudo ./perf test -v 99
>    99: perf stat JSON output linter                                    :
>   --- start ---
>   test child forked, pid 3086101
>   Checking json output: no args [Success]
>   Checking json output: system wide [Success]
>   Checking json output: interval [Success]
>   Checking json output: event [Success]
>   Checking json output: per thread [Success]
>   Checking json output: per node [Success]
>   Checking json output: system wide no aggregation [Success]
>   Checking json output: per core [Success]
>   Checking json output: per cache_instance Test failed for input:
>   ...
>   Traceback (most recent call last):
>     File "linux/tools/perf/tests/shell/lib/perf_json_output_lint.py", line 88, in <module>
>       elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
>   AttributeError: 'Namespace' object has no attribute 'per_cache_instance'
>   test child finished with -1
>   ---- end ----
>   perf stat JSON output linter: FAILED!
> 
> Fixes: bfce728db317 ("pert tests: Add tests for new "perf stat --per-cache" aggregation option")

Another oversight on my part. Thank you for fixing this :)

   $ sudo perf test -v 99
   99: perf stat JSON output linter                                    :
   --- start ---
   test child forked, pid 25046
   Checking json output: no args [Success]
   Checking json output: system wide [Success]
   Checking json output: interval [Success]
   Checking json output: event [Success]
   Checking json output: per thread [Success]
   Checking json output: per node [Success]
   Checking json output: system wide no aggregation [Success]
   Checking json output: per core [Success]
   Checking json output: per cache_instance [Success]
   Checking json output: per die [Success]
   Checking json output: per socket [Success]
   test child finished with 0
   ---- end ----
   perf stat JSON output linter: Ok

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/lib/perf_json_output_lint.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> index 4acaaed5560d..b81582a89d36 100644
> --- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
> +++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
> @@ -85,7 +85,7 @@ Lines = args.file.readlines()
>      expected_items = 7
>    elif args.interval or args.per_thread or args.system_wide_no_aggr:
>      expected_items = 8
> -  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache_instance:
> +  elif args.per_core or args.per_socket or args.per_node or args.per_die or args.per_cache:
>      expected_items = 9
>    else:
>      # If no option is specified, don't check the number of items.

--
Thanks and Regards,
Prateek
