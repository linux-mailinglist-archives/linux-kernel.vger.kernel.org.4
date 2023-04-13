Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732CE6E0C80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjDMLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDMLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:32:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912D9749;
        Thu, 13 Apr 2023 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681385538; x=1712921538;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xvZ7y/ljrPnFbR/+XkkFDSFqjj1uBIl7faBCX8OtNXo=;
  b=neaFCYbmcA6YtWiDmj9e0mXiPCzZqXF3yzvVRH3Tzxqij2mNZ4x6SEk8
   kaxm4pK3uXdqQ01F/n2rSe98USkM1TtHX5DCzFxB5ELBLFAExG8KYt5UO
   GxsYiQFZHxmYKCLwyRYoGgG7OSepu9qFWyVFiRgAByskFGIcOBs56maA6
   UQN1saoB6oVK1pKkMmHsyNX9ohuY57kigIsnLsQugWbNN2kGcnpVwwhAH
   zdjy6Mi9Bt06lgU96P6fPr+iZq7GngGAlOxWOuJ5Oacet8tS/OaI0FEOl
   0zPWV3+bMcP5CvP2WU78Q0K3Y31VCW9pXVQrM60N++I7cfUY8fgCOVi2N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323781993"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="323781993"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 04:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753969079"
X-IronPort-AV: E=Sophos;i="5.99,341,1677571200"; 
   d="scan'208";a="753969079"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2023 04:32:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 04:32:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 04:32:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 04:32:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 04:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyb+6PzDRyJavvr+HEi8dbZRzIaW0AAQcWWKzEFJx0IVY89hc3cr6rTwhMvMcBJA+Pahxu14WM2Q6sAIFZaw3abIWNeJnnsgRUT5q0dd9SiDANEPd46ilRNMHCEq9+HBw7mY6wXZKpYC3pkt/56aIiLcX+FjYKbgrW4+hpmhWisKwf0ZCKtsLeS/GoSZ1T9nCWz7FkQa+L4hqGuq/5Q3A1hGPHFMb8zPO+pgeKj12kr4cGNawEQcIQzeuvZ1A2Z2fNsTY49PxlvCMewFStwiJdgkzPEaKBxors7YCa8WOl+X5FPd1Qh8xQQ9AGBXKjiejwQ0HrBJC6gA0ZkQmusltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdlK5LLtOBOKHXOnPS6dAhNDnALQbk4sC5QporZYRFs=;
 b=JfAEEAezOYRoiBudeI3QWpSkH3nFQWdcD6yWDKU2JaDtFBPckJcGQ0M0Xv4NiMSnAwdWAGrqSkslUV4ut7+UqkuGc45ID0fV25jtfIRhn5NCWGlrwHHD0YBA7/aGHZKcWmASZF3Zb/j2LIRFHCFh4qgj0G23Ib0uPfMrDQupp5xG/ZKHglZ00H0O2qqsS389hnzDS0JAsQRQ+kT29U5gL6c/NhxusxrI4IGiKIeNu8YPDCxiFisNB0tyCZEY1BbmNzyGVCOaIx/UJJ4jo0gHDYfhTSgrlG3YzFgXzzYDOo+10Bqks48ALvg+C4Tx+uDM1pBJJqLqzRZBH/rnWH12xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Thu, 13 Apr
 2023 11:32:12 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2d87:aedd:13d5:3ec9]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2d87:aedd:13d5:3ec9%5]) with mapi id 15.20.6277.038; Thu, 13 Apr 2023
 11:32:11 +0000
Message-ID: <c264a334-5119-4000-61e4-a8d0c89b3508@intel.com>
Date:   Thu, 13 Apr 2023 19:31:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf tests: Fix tests in 'Parse event definition strings'
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Yi, Ammy" <ammy.yi@intel.com>
References: <20230411094330.653965-1-tinghao.zhang@intel.com>
 <CAP-5=fVWx7F9D0MvU=tCJ4nQ3QjaB7fVaCjvD8j4F-1yo5piDA@mail.gmail.com>
 <edd1d807-b28d-f6a3-d6fb-af39e7909744@intel.com>
 <CAP-5=fV20jibAu82Q3U8FnavHp7dxG=5UvKgMBp7YBe5FG+gXw@mail.gmail.com>
 <ebd32500-9baa-425f-8355-d2cdd04a53ae@linux.intel.com>
 <CAP-5=fVMJYrdmvTffZhp-pwYnnL4NOoz1GchMWfO6vUo6OM1kA@mail.gmail.com>
From:   "Zhang, Tinghao" <tinghao.zhang@intel.com>
In-Reply-To: <CAP-5=fVMJYrdmvTffZhp-pwYnnL4NOoz1GchMWfO6vUo6OM1kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To PH7PR11MB6722.namprd11.prod.outlook.com
 (2603:10b6:510:1ae::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6722:EE_|SA2PR11MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: f55dafcb-f951-4770-9466-08db3c12b90c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3QbVLRumtBHT64TcWbdkjpW9Bn3BnZS0H8Bcr8NVxSGxyMXul8sZwzLrt6py2KhXh2ZQ9cAyIFLSdGqoRKfTfpNvZTralgs+2EX86CMkfF+pUVTk+qsgE5HlSdRPMJMBIg60gfflII6J4ujh8b0VSSZHpiYiXvqU84c3HrpHswH01h2qSLPOc8ZmkbCBCDo3H6Bu0jjwCmLHlyJf822m6TF6ZklAnvXh9LuQ/c66AOJA2yEdXh3aJir8yzIpLVvIVfLxojp3NlfeictwducMWtM9eOuSYFNoGfaLMnEJdqVqvVyUFnh7JaQBdH9u+y0b5PHpfHnHxACR3av67wFIDZ3IUfnw4GrY8L/WHX6sdJOWVRPWumuWVfU/mIJatcPBYqVahMzQplF8jmHIJztYgJgp1mE02shxwZ41AxEm7MV65hQqMVL7mnIG78u0/WKTpgNQoKSumCDgjCN1LLfhorPDkJf7LfeTS4WV660ORxSP7MemtfXHcOFuiMsrv9+s3ugDWfXDKH141xeRjZz8LVknJkKzP+hrcD9u85qzgYciOGXgp4kP604PYDAy2NlqFF5WoUfgQMLrUfT8Mfou8Qi49qz+W6c9HXGMBPR4RWAWUMdd8rowPSay5k5Xvy2lw5p938+V43WCIEngO/EXGwA92sZjtctRz1VjCE8n54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6722.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(31686004)(66899021)(478600001)(36756003)(31696002)(83380400001)(82960400001)(38100700002)(86362001)(2616005)(19627235002)(2906002)(966005)(316002)(26005)(5660300002)(6512007)(110136005)(6506007)(53546011)(186003)(66556008)(6486002)(30864003)(66476007)(7416002)(41300700001)(8676002)(8936002)(6666004)(4326008)(54906003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZKMFNsb1FxczRGZjY2R0ErQWRZQWpyVy9yeGV5K0lVZ2xoV2RZMHRjRTU1?=
 =?utf-8?B?dnlrZ01ieHBoSWg5LzEvU3JmSGJHQnBhdHNSNGI2TUdvYWFXNGNvQ2FLNnZB?=
 =?utf-8?B?LzhQd044eFZ4S3NmNVNHT3VZMzRDUkZHaVFPL0hDNFVQVHVUb0RvVkVnWG8x?=
 =?utf-8?B?WlRFTEJiWUdacnNkTWtua0h3LzI4aWp0N3gyaGEvakhiRlJTaWV1VS8yeVkv?=
 =?utf-8?B?clhnQWZ5cmdxNC92aHJOdTA3bEI5YzdnY2s0Z05zbk10SCt3VGgwUUgxRlRU?=
 =?utf-8?B?OUd2bjBwRWJpOEpEK1Y5aHJHSS9EN2p2MytQWU1lQkNKdngvZnlWOHBBUFBE?=
 =?utf-8?B?OGFxQTBDZ0wxQVo3QUdoUTVOOElBTVE1ZGNRbXd3alNnbW5FMnVrdWpISXdW?=
 =?utf-8?B?ekRvelVZMG1kU0VnV2R5RU51bEt4Q2t1UGlXK1VRTk1Hd0FpdmRTQjZPbUhK?=
 =?utf-8?B?YlpaSzNOdi9oWDhGR3hTNEJuZU9sM0k5SjA2ZWM2UzVRRkJsS0QwcUlwMnZB?=
 =?utf-8?B?SXEvbjFNQVZMQmZzNUFNTXUwY0xBZ3lEUmdqbjVoRHFvc3NSRXRNUVlCaUhy?=
 =?utf-8?B?bFpWQTNjWEpWTUE2NWRxcVZSRjV4d1J0R2dxS0oySWtaKzNNa2puNzl6a01O?=
 =?utf-8?B?dm5wSlMrRVdvS1R2WnEwUit1cC9lSlBMNHoxTEpOZTg0VzhKZVBham9GRkN5?=
 =?utf-8?B?YnBBeURYOU8zbi82ZmlpNC9WZ0tSN0tEb1o0MEpsWVJEZXhpb1U4VmlLdUNm?=
 =?utf-8?B?eTIxRlVIU25jK1JyUEJBbytRQWJ2RTA2d1NwVUJwZVFlWGI3Zzc2aDF2eGJP?=
 =?utf-8?B?ZjZlVjVmMVlwQTc2U3ZnZllMcVZaTGVhb1RzcW5QZDg1WjhZUUxOcnpMTzNa?=
 =?utf-8?B?SjlJcml4WGtJMzNNYWs3djAyQzgrRjBuYjNRcm9DRkNSTFFGVTh2OHpvQXgy?=
 =?utf-8?B?MVFib25sKzRBaW1ZREM0SGN6SWZHemNMWml6TWtzY3haSGE4SmtENzR1Q094?=
 =?utf-8?B?OElvL1R0NXRmdElDYkRuZkxORkpITnFrTlQ2dVdwVzRRdkV1bW1Hb0ZzcWNJ?=
 =?utf-8?B?UmQ3ejdTM1phVG5KNWFTTEczZ3N5cEdVdXdyYldpdHJmUVdiaWxoOTdpTVhx?=
 =?utf-8?B?VS83UHVNVGJFbGU1cWpGT1NMa2lqMWQrK3A4Tm5OTmFEeXJEYjFQamhvQVYy?=
 =?utf-8?B?MXdaOGsyVmtWbU1tY3NBaUhtMzNHSFNXM3I5ZzNLZ2tCa1ZpeEJFZUo4RVFC?=
 =?utf-8?B?VWxUYUF5UlA0WjJYQ2VTZzRUS3J3ZE5ZSytDdmRpUWdwNDJJL0NicjFlR2lw?=
 =?utf-8?B?M2dkWWVXeDJnc0pJR25aWFZwV09sYytOZUFzT2dXWmdkelN2YlBCSUIzT1dX?=
 =?utf-8?B?T2xrZXVQcnAxRlFVRVZxZm84MVAxK1ZWV3ZHR2NDN3NlamNlOXdYcVREREpj?=
 =?utf-8?B?Zi9qaUx5a1ZLVmhLejZpZEo4NndaYXFuLzNVcjhNVkVYRmExb1JWNmlabFhw?=
 =?utf-8?B?V281TzlLY28rV3JIQmc0ZkJhMUJCYk1vUjVTZ1hvbnlSanc5RTVTSWg1WWpn?=
 =?utf-8?B?S2JLNVZsQ0p4MHFCMlFHdysrYmdDSENDMHYzN3VUeTJRck5Hc1NsT0dkVC82?=
 =?utf-8?B?eThhQWs2a2tuTFdFTm04U0gwVDk0RGl6MWF5bUxHckJWQVYzMlVXbzlwOVl5?=
 =?utf-8?B?TnBqQVZUbjNKTjhYb05yanJjanBDNVBlTjlnRm9WeXRhOXlqNGZMT3FTQVFW?=
 =?utf-8?B?MS8xUXYwNk9ocUhpWGQ4WUozZEtPdUFXWHFjOCtaSkM4OEM2aElsMk84eVd1?=
 =?utf-8?B?QnlFRVNlRjc0ZUNJSi9pYVc4MTdhQms5MjloL1dheFB6UXBxVGt3aFo5cXJs?=
 =?utf-8?B?OWFxSEpTOXYvd0xEWVVHcE9lOEhwMFVhSWpvNFBmK1NSSWdYWGdvUTZ2dzZn?=
 =?utf-8?B?cGpubjIyK3VjVVhDREs1UDUzUVJUejhoZXp3R1kxWldZbjJ3aXB6d3NqdmVG?=
 =?utf-8?B?cGhGQm5YclNzNDZoNkZtMURxdXluUXNJNUdIS1JsVVNyQTJOWHdNbVlQK0t4?=
 =?utf-8?B?blBJS1RYejZub3pEY0UzV3BWNDU4d3NUd3JENC9ZNnRrUFZ6a3RveWdvMnZI?=
 =?utf-8?B?dk5WSXBYYkdkeHJLbHJTcCs0ZGI0d04rWS9JUnJ4WEVQUERIVW1tMGxNVDZv?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f55dafcb-f951-4770-9466-08db3c12b90c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 11:32:11.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MapUaJyZfc5PYsUP6bxPThrCez8CuSyhJuXT8AMoT9QraF2RqElERwKPxcE5zUar+Kxhfg6cdRU8+hD/fPyuQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/2023 5:36 AM, Ian Rogers wrote:
> On Wed, Apr 12, 2023 at 1:39 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>> On 2023-04-12 12:35 p.m., Ian Rogers wrote:
>>> On Wed, Apr 12, 2023 at 3:16 AM Zhang, Tinghao <tinghao.zhang@intel.com> wrote:
>>>>
>>>> On 4/11/2023 9:50 PM, Ian Rogers wrote:
>>>>
>>>> On Tue, Apr 11, 2023, 2:49 AM <tinghao.zhang@intel.com> wrote:
>>>>> From: Tinghao Zhang <tinghao.zhang@intel.com>
>>>>>
>>>>> The 'Test event parsing' test set under 'Parse event definion strings'
>>>>> does not apply to hybrid events. Since hybrid events have a dedicated
>>>>> test set 'Test parsing of hybrid CPU events', skip these tests on hybrid
>>>>> platforms.
>>>>>
>>>>> Fixes: 7741e03e808a ("perf test: Parse events break apart tests")
>>>>> Reported-by: Yi Ammy <ammy.yi@intel.com>
>>>>> Signed-off-by: Tinghao Zhang <tinghao.zhang@intel.com>
>>>>
>>>> This feels wrong and could make a different problem. Could you send the failure you are seeing? There is a verbose flag (-vv) that you can pass to perf test.
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>> Hi Ian,
>>>>
>>>> I think these test cases are not designed for hybrid platforms.  As the current implementation, if one general event type is used on hybrid platform,
>>>> perf tool would generate seperate event for each pmu. But tests in 'Test event parsing' asserts only one evlist entry per event type. Another problem is that for
>>>
>>> Hi Tinghao,
>>>
>>> So you are right that the tests weren't designed for hybrid platforms
>>> because they didn't exist when the tests were created, but the bigger
>>> issue is what should perf be doing in these cases. On ARM's BIG.little
>>> version of "hybrid" there is a single PMU and generic events that work
>>> on both kind of core.
>> But we have different PMUs for Intel hybrid. The event list is quite
>> different between e-core and p-core. There are some features which only
>> available for one type of core. I don't think we can have a single PMU
>> for Intel hybrid.
> So we make the test and the expectation match.
>
>>> But even with a single core we can get into
>>> issues that an event can be defined for more than one PMU. For
>>> example, a GPU may have an instructions-retired count. In sysfs we'd
>>> have /sys/devices/my-gpu and /sys/devices/cpu. If the user asks for
>>> instructions-retired and has suitable permission, should the perf tool
>>> display instructions-retired for the GPU or just the cpu? My belief is
>>> that we should display my-gpu/instructions-retired/ and
>>> cpu/instructions-retired/. If the user wants to then limit to the CPU
>>> one, they can use the full PMU and event name
>>> cpu/instructions-retired/.
>>>> Why does this matter? Well if we have a common plan for how to deal
>>> with events that match on more than 1 PMU then hybrid can just follow
>>> the plan and we can remove all of the hybrid code from the perf tool.
>>> Yes, the tests made an assumption there'd only be 1 of a kind of PMU
>>> for an event, so we need to change the test to assume that there will
>>> be at least 1, or that the number should match the number of PMUs or
>>> core PMUs.
>> How about the group? Using weak group?
> No need, just make sure to call parse_events__sort_events_and_fix_groups:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2167
>
>>>> PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE, attr.config has a different format for hybrid events, so we see attr.config errors. Also, it is not applicable
>>>> to put events from different PMUs to one group, but here some tests put general events in one group. As for the patch that first introduces hybrid test cases
>>>> 2541cb63ac0c ("perf tests: Add hybrid cases for 'Parse event definition strings' test") , this test set is skipped. I think it's better if we skip this test set for hybrid pmus.
>>> So I think:
>>> 2541cb63ac0c ("perf tests: Add hybrid cases for 'Parse event
>>> definition strings' test")
>>> was added quickly in order that nothing be blocked, but with hindsight
>>> it regrettably didn't make a generic solution that could be used for a
>>> range of PMUs. You may be interested to see that the problem of being
>>> too CPU centric for perf is something reported by Intel's GPU team:
>>> https://www.kernel.org/doc/html/next/gpu/i915.html#issues-hit-with-first-prototype-based-on-core-perf
>>> I'd rather that the code were not hybrid or CPU specific, but
>>> everything was based off the PMU abstraction. For the attributes we'll
>>> need to improve the test to make it more generic to handle matching on
>>> multiple PMUs.
>> The current "test__events" doesn't generic enough. There is
>> L1-dcache-load-miss which apparently CPU specific. Also ARCH specific
>> events, e.g., kvm-s390, intel_pt. And groups.
>>
>> How should we make it generic? Any suggestions?
> s390 uses #ifdefs, intel_pt uses the intel_pt_valid call to enable the
> test - this returns false if the intel_pt PMU isn't detected. I have a
> fix for legacy events like L1-dcache-load-miss, the hybrid hack of
> having the parser run the parser inside itself is gross, we should
> just fix the parser. But given use of these legacy events is
> marginal/deprecated it isn't clear we need to support them on hybrid.
> Fwiw, I want to refactor the parsing code into a generic event to
> perf_event_attr library that is more permissible than GPLv2, so I need
> to find some time to make it happen.

Yeah I think we need to refactor these test cases to base on the generic 
PMU abstractions.

And for test cases that are not generic, maybe we could create and move 
these to arch

specific test cases?

For the parser change Ian you suggest, don't know what's the impact on 
the current design?


Thanks,

Tinghao

> Thanks,
> Ian
>
>> Thanks,
>> Kan
>>
>>>> Below is the perf test result on one Intel Meteor Lake platform
>>>>
>>>>    6: Parse event definition strings                                  :
>>>>    6.1: Test event parsing                                            :
>>>> --- start ---
>>>> test child forked, pid 44965
>>>> running test 0 'syscalls:sys_enter_openat'
>>>> Using CPUID GenuineIntel-6-AA-2
>>>> intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
>>>> running test 1 'syscalls:*'
>>>> running test 2 'r1a'
>>>> FAILED tests/parse-events.c:87 wrong number of entries
>>>> Event test failure: test 2 'r1a'running test 3 '1:1'
>>>> running test 4 'instructions'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 4 'instructions'running test 5 'cycles/period=100000,config2/'
>>>> FAILED tests/parse-events.c:118 wrong number of entries
>>>> Event test failure: test 5 'cycles/period=100000,config2/'running test 6 'faults'
>>>> running test 7 'L1-dcache-load-miss'
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>    type                             3
>>>>    config                           0x400010000
>>>>    disabled                         1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 3
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>    type                             3
>>>>    config                           0x800010000
>>>>    disabled                         1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>>>> sys_perf_event_open failed, error -2
>>>> FAILED tests/parse-events.c:152 wrong config
>>>> Event test failure: test 7 'L1-dcache-load-miss'running test 8 'mem:0'
>>>> running test 9 'mem:0:x'
>>>> running test 10 'mem:0:r'
>>>> running test 11 'mem:0:w'
>>>> running test 12 'syscalls:sys_enter_openat:k'
>>>> running test 13 'syscalls:*:u'
>>>> running test 14 'r1a:kp'
>>>> FAILED tests/parse-events.c:87 wrong number of entries
>>>> Event test failure: test 14 'r1a:kp'running test 15 '1:1:hp'
>>>> running test 16 'instructions:h'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 16 'instructions:h'running test 17 'faults:u'
>>>> running test 18 'L1-dcache-load-miss:kp'
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>    type                             3
>>>>    config                           0x400010000
>>>>    disabled                         1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 39
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>    type                             3
>>>>    config                           0x800010000
>>>>    disabled                         1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>>>> sys_perf_event_open failed, error -2
>>>> FAILED tests/parse-events.c:152 wrong config
>>>> Event test failure: test 18 'L1-dcache-load-miss:kp'running test 19 'mem:0:u'
>>>> running test 20 'mem:0:x:k'
>>>> running test 21 'mem:0:r:hp'
>>>> running test 22 'mem:0:w:up'
>>>> running test 23 'r1,syscalls:sys_enter_openat:k,1:1:hp'
>>>> FAILED tests/parse-events.c:466 wrong number of entries
>>>> Event test failure: test 23 'r1,syscalls:sys_enter_openat:k,1:1:hp'running test 24 'instructions:G'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 24 'instructions:G'running test 25 'instructions:H'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 25 'instructions:H'running test 26 'mem:0:rw'
>>>> running test 27 'mem:0:rw:kp'
>>>> running test 28 '{instructions:k,cycles:upp}'
>>>> FAILED tests/parse-events.c:679 wrong number of entries
>>>> Event test failure: test 28 '{instructions:k,cycles:upp}'running test 29 '{faults:k,cache-references}:u,cycles:k'
>>>> FAILED tests/parse-events.c:721 wrong number of entries
>>>> Event test failure: test 29 '{faults:k,cache-references}:u,cycles:k'running test 30 'group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u'
>>>> FAILED tests/parse-events.c:777 wrong number of entries
>>>> Event test failure: test 30 'group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u'running test 31 '{cycles:u,instructions:kp}:p'
>>>> FAILED tests/parse-events.c:870 wrong number of entries
>>>> Event test failure: test 31 '{cycles:u,instructions:kp}:p'running test 32 '{cycles,instructions}:G,{cycles:G,instructions:G},cycles'
>>>> FAILED tests/parse-events.c:914 wrong number of entries
>>>> Event test failure: test 32 '{cycles,instructions}:G,{cycles:G,instructions:G},cycles'running test 33 '*:*'
>>>> running test 34 '{cycles,cache-misses:G}:H'
>>>> FAILED tests/parse-events.c:1000 wrong number of entries
>>>> Event test failure: test 34 '{cycles,cache-misses:G}:H'running test 35 '{cycles,cache-misses:H}:G'
>>>> FAILED tests/parse-events.c:1040 wrong number of entries
>>>> Event test failure: test 35 '{cycles,cache-misses:H}:G'running test 36 '{cycles:G,cache-misses:H}:u'
>>>> FAILED tests/parse-events.c:1080 wrong number of entries
>>>> Event test failure: test 36 '{cycles:G,cache-misses:H}:u'running test 37 '{cycles:G,cache-misses:H}:uG'
>>>> FAILED tests/parse-events.c:1120 wrong number of entries
>>>> Event test failure: test 37 '{cycles:G,cache-misses:H}:uG'running test 38 '{cycles,cache-misses,branch-misses}:S'
>>>> FAILED tests/parse-events.c:1160 wrong number of entries
>>>> Event test failure: test 38 '{cycles,cache-misses,branch-misses}:S'running test 39 '{instructions,branch-misses}:Su'
>>>> FAILED tests/parse-events.c:1213 wrong number of entries
>>>> Event test failure: test 39 '{instructions,branch-misses}:Su'running test 40 'instructions:uDp'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 40 'instructions:uDp'running test 41 '{cycles,cache-misses,branch-misses}:D'
>>>> FAILED tests/parse-events.c:1265 wrong number of entries
>>>> Event test failure: test 41 '{cycles,cache-misses,branch-misses}:D'running test 42 'mem:0/1'
>>>> running test 43 'mem:0/2:w'
>>>> running test 44 'mem:0/4:rw:u'
>>>> running test 45 'instructions:I'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 45 'instructions:I'running test 46 'instructions:kIG'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 46 'instructions:kIG'running test 47 'task-clock:P,cycles'
>>>> FAILED tests/parse-events.c:1382 wrong number of entries
>>>> Event test failure: test 47 'task-clock:P,cycles'running test 48 'instructions/name=insn/'
>>>> running test 49 'r1234/name=rawpmu/'
>>>> running test 50 '4:0x6530160/name=numpmu/'
>>>> WARNING: event 'numpmu' not valid (bits 16-17,20,22 of config '6530160' not supported by kernel)!
>>>> running test 51 'L1-dcache-misses/name=cachepmu/'
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>    type                             3
>>>>    config                           0x400010000
>>>>    disabled                         1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8 = 40
>>>> ------------------------------------------------------------
>>>> perf_event_attr:
>>>>    type                             3
>>>>    config                           0x800010000
>>>>    disabled                         1
>>>> ------------------------------------------------------------
>>>> sys_perf_event_open: pid 0  cpu -1  group_fd -1  flags 0x8
>>>> sys_perf_event_open failed, error -2
>>>> running test 52 'intel_pt//u'
>>>> running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
>>>> running test 54 'cycles//u'
>>>> FAILED tests/parse-events.c:1457 wrong config
>>>> Event test failure: test 54 'cycles//u'running test 55 'cycles:k'
>>>> FAILED tests/parse-events.c:1467 wrong config
>>>> Event test failure: test 55 'cycles:k'running test 56 'instructions:uep'
>>>> FAILED tests/parse-events.c:107 wrong number of entries
>>>> Event test failure: test 56 'instructions:uep'running test 57 '{cycles,cache-misses,branch-misses}:e'
>>>> FAILED tests/parse-events.c:1309 wrong number of entries
>>>> Event test failure: test 57 '{cycles,cache-misses,branch-misses}:e'test child finished with -1
>>>> ---- end ----
>>>>
>>>> Parse event definition strings subtest 1: FAILED!
>>> Thanks! So "wrong number of entries" is the dominant failure and
>>> should be straightforward to make more PMU agnostic. Tests that are
>>> tied to a PMU like:
>>>
>>> running test 52 'intel_pt//u'
>>>
>>> succeed and it seems sad to lose coverage of them with this change.
>>> Overall, I think we should work to remove the hybrid test and make
>>> sure we get coverage in the general test. That means just skipping the
>>> test is the wrong thing to do.
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Thanks,
>>>>
>>>> Tinghao
>>>>> ---
>>>>>   tools/perf/tests/parse-events.c | 5 ++++-
>>>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
>>>>> index 71a5cb343311..c6949e458e61 100644
>>>>> --- a/tools/perf/tests/parse-events.c
>>>>> +++ b/tools/perf/tests/parse-events.c
>>>>> @@ -2146,6 +2146,9 @@ static int test_events(const struct evlist_test *events, int cnt)
>>>>>
>>>>>   static int test__events2(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
>>>>>   {
>>>>> +       if (perf_pmu__has_hybrid())
>>>>> +               return TEST_SKIP;
>>>>> +
>>>>>          return test_events(test__events, ARRAY_SIZE(test__events));
>>>>>   }
>>>>>
>>>>> @@ -2421,7 +2424,7 @@ static int test__pmu_events_alias2(struct test_suite *test __maybe_unused,
>>>>>   static struct test_case tests__parse_events[] = {
>>>>>          TEST_CASE_REASON("Test event parsing",
>>>>>                           events2,
>>>>> -                        "permissions"),
>>>>> +                        "permissions or hybrid"),
>>>>>          TEST_CASE_REASON("Test parsing of \"hybrid\" CPU events",
>>>>>                           hybrid,
>>>>>                          "not hybrid"),
>>>>> --
>>>>> 2.34.1
>>>>>
