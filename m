Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03777077E6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjERCNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERCNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:13:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565331BC2;
        Wed, 17 May 2023 19:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjrQrGLCY45nqAIWjd10OoS7rxSvLKH++9awae0ZgM4TAIpvcCSI3udWry+VJ1Rfn5yf/2Xqdc1xCLgqQ0RzoX3+JmxWY2trweIcug7YpnFGnp4seeL3E34IYWLpQg3Zzy5ZdNhFjwiSYFVIp3Aiut4xX6EtrqYeHmCcmGTiFj/+bQNiN999DwYmLrP5FBI22Krb9KbfaQsPit2eIz856MWWeaUhgjCiY3fb3py0LqE5brx7ogK9J280wnCrMhugmL8joY0pnRjaFlydU9Iey0Yg1Qq2EzUS8tkCFcUz3cog8SdUvNbqzKBUyNf8w+4yALy2VnNN5bGxxh4wb8Oauw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd72DYZHkl5JksFTqj22QO5wyAlL4nnwkqPlMg/zPDo=;
 b=V2+QRp6tcabOu0pBYtl31PpyswiGsKkkTGTf8KjptGNJwjOVvItGsTmv6/bKVkpo0iejtyUDY27Ysz5xjmGPCRxLIlPpX/ZFE8Ai/6VEUWHEtFJWXhfC98sgbaoHODJEy6DxprnLSrsbegmBBS/lRUv9EOcro/1pM/BmCZx0P5scfIo/pPeIe491lHGmgE+7yS2KZEvuooxgr+Rhfe7meFmyCT+dNwW372J1E8Lk28Z2hx3dwHDJAKZSWUWt0ws9df6ymzjXnzPMMcEyJkSjhc4gqj9JEPQNaeE950V+UYuYAZAIEpLiUd/q1fDNohMhYLUSbKgvWfNGDl59UxSepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd72DYZHkl5JksFTqj22QO5wyAlL4nnwkqPlMg/zPDo=;
 b=ITUcn0s7R0kRMhgxKdY01cDef/rcf1q1yj6j/C/B4LPMoN5mbIWEPpsi93FTMMe7XZQUgXj3ZNS/dhCYuASC4EDUgbLnO5vOqQpJdvRmOs1S9AL8zwQYIb5dQMOmDFxyrjzdhIO0XfL3FvE04OoPc8uTS5e1VX1NtryMC6lqVx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 02:13:14 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::b197:512:a4ca:6e9c%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 02:13:14 +0000
Message-ID: <669ac082-0652-6947-81e1-0f99de0521b5@amd.com>
Date:   Thu, 18 May 2023 07:43:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 0/5] perf stat: Add option to aggregate data based on
 the cache topology
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, ravi.bangoria@amd.com,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        gautham.shenoy@amd.com, eranian@google.com, puwen@hygon.cn
References: <20230517172745.5833-1-kprateek.nayak@amd.com>
 <CAP-5=fUCvQNsW0Tnj7Q8sjFTqTEC9YUbFxAedRFtA=5zUe7BVA@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAP-5=fUCvQNsW0Tnj7Q8sjFTqTEC9YUbFxAedRFtA=5zUe7BVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0197.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::6) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 5827ac09-dfce-47e8-6c07-08db57456f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iOKN8pLTx7QwaWtEQS8QOvdM14q0vcQyOX8pEjCb11e01TGzEmNnMmBqF0zMFv5DN/u4zBtCO1ll3xExdx84dyNcWXNZ/Vuh8lpZd+h8Nt6GJSaxgf62l8ylyxxWPhlES6jlYdQi91t0B5QmxarxpoLwFKEGWUWHr85xnpjv5susnu6LQP2JqDWauanIl+cioONAUw6OxUjaV5Y3SUhor0NsHzS/+zpSbc6jXN6zAQerf0Mn2nTWBxxbX+qgp/fO5l+m6xbhPDHgVqXzmSZh7yfaq6FY+xryb48XAT65yEbrL7ycrkWsqCqUScm42XCz7BoJOiXbYSmvJXJlnR/2l7fAhxiigpSoy5ds+Huc2E/8hBdmygindEmvr+AXsK2UcB+uG2FsAsbzlVqUBucK/0QuX9RD/MHxENBicdvaDxSjkXOTlcCynaclRZPZIMOQwjiNBz1QC4pRDnSpTvfBdsggQdgLMtXpdPg83jAyBWfJM0pdHIM6YGmW2rNWNLsYkgB5nNYm3xxhuXMj8dn25tETBEObvJczQ9/BtFC6LkgoPy+f2W2O/l7OxUysNGImupkeNYE/6cFtFjePeU+IghkCOH/50UohMA+tC4Ox0vi2szCDL3zUKHEMS12ePQNXdubCim9oPTCrkNjUpCjGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199021)(86362001)(31686004)(41300700001)(6916009)(36756003)(5660300002)(8676002)(7416002)(38100700002)(31696002)(316002)(66476007)(4326008)(66556008)(2906002)(66946007)(186003)(6506007)(107886003)(6512007)(26005)(8936002)(53546011)(2616005)(6486002)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVRCVTNMRlVuVks0TldSalo3Rk5yNWJQWkt3WXBQVDdFVlRYYnRRclgzdFNj?=
 =?utf-8?B?Rk9HNUFzeHE2MnA5cFRWM0RNKzFsMzZFQVl5SmxybWpLcEFGV3V0Mmp6OUUw?=
 =?utf-8?B?TGZNM29pbDRnYmVHeW5ZdG15aHEvb0dBcmhKN3R0NXVKL1lLVE90WGFFL0hx?=
 =?utf-8?B?cVBSMCtmZDNIbktYUmErUmI1UU9vTi9nSjZIMGxrRXhpMm93L3FnS2g2bjRu?=
 =?utf-8?B?NnhPdXFqN2JrYTdRSkx6Y1pnQWJVWFZGZnBFTWVicXBhRDY2V2REQzA2TGhr?=
 =?utf-8?B?YnI4NW11VVZ5ZC9EQXFMSy9kTUE5clM2aWhyaGpTSWdoU0ZVVVIreHpmb3E0?=
 =?utf-8?B?eWhTdXRUQXdyM2RUV3lCaElVcGdBRGVrMmVSaDZ4V2ZUaDRNN3YyQlV2T0Jh?=
 =?utf-8?B?U3VLSjlodnFKR1dSRjFCWEVXVkIzOWp4MDJuaklydUs5eVl6cTBVNlVpYkIy?=
 =?utf-8?B?cTRRL2lLamlveWs3OWNmb0U1MjJWNm5ZY1FnSTRWdE9nRWkvdm5JbmxXVTlk?=
 =?utf-8?B?REJ4czc1V3VhVmNpd1pRdEJsL0dIL2lER0I5N01NZWhsMnlKOU5MM09jSThk?=
 =?utf-8?B?QTlMN3dFT0tzUkNjR3dEU3NBWlhBditJellMcVlXanhJZGh4Vm1OaTAxd05B?=
 =?utf-8?B?Sis3alYzRjJlaVcybzZXR29scXY5dW4ybWx1SFM5TWpzSXpRMWFXTklVRklQ?=
 =?utf-8?B?czRsSVVxbWJqWmtJSEdiZVFmNG1zMWlLYUZWQWh3ZVJFTFlXNUdlbGZobUl5?=
 =?utf-8?B?UFJpak1NTkVQVXZSK3ZsRmZ6OEdFRjhvMVF3OWlrTkRES29TVlNpemRQU2Jo?=
 =?utf-8?B?Q09JMEdFUWNQcHg2UWpGa1hNT3NRMTdXUTlIbWRuU0FmZ25tU3MzS1pONjNS?=
 =?utf-8?B?eWYyRnJhaTIvbnVRRUl4blgzRzNGVmkvK2xZbTN5SHJVK2Z5WjM1ZE5LM3Iy?=
 =?utf-8?B?ZUZDR1NjK1g4R29iMWxrTDJaMVQvVTJHWEZNVnFvRFNBMmF2VTNQQXE3ZjZi?=
 =?utf-8?B?WVRNd2ZaRExjbWxOTWlDbDdSS0xtY0JUeU1GV0paVnBVcENKVTdyOFFzVDJ0?=
 =?utf-8?B?b0FpVDhPbURZNytFMjRxb0RTbm96ZENGN1ZObGpuYWhhTldmV2hpLzlsR2J5?=
 =?utf-8?B?ZHk0OXhkUHJyNm9pMFBtVUQvNlUwVEwwYVBWN1BidHFwN0FSWXNHNVFkNnhl?=
 =?utf-8?B?SkdzSUhGRjY3V3Y4WWh1bHk3U1Z5YmNQUVN3VXRyZXFrYWxHZHZ5QlBKcks4?=
 =?utf-8?B?MjFSdVROSWxGK3dCQWRkcUNtN2FVLzhSNm1GNkladTVqSE96b0M3SHVkd25u?=
 =?utf-8?B?d0ZrVW1CcXJyanRpV3p0cm93QS85bzlEWkZUK0FZbFR1ZzVKNlVHd085TGNp?=
 =?utf-8?B?RzI3WUNVU2h1MFpuT2E4TEhVY1pYZlJxbTJlcml3T2QxZE1YVFZKOXQrOU5P?=
 =?utf-8?B?ZDd2MjV0Z2RUOWhtUVd2UmoxTElDNGdTNXMxWHM3YUVpYkFYRW9vNngyY0c0?=
 =?utf-8?B?cDRJMmFOWW1vb25FbUFPbXREVWlNbXZ1S29iakVrdUlwMFdRYmJFd3lWSFhN?=
 =?utf-8?B?aWthTXNzNkRQbldTOWV3N3NFNUE4NkFLdWNtekxnNEE3YlJ5Q3JNWjZzZjlE?=
 =?utf-8?B?MFpUeGREN00zV2c2dHloMmp0WEdSbDZNNmo2QURJaXFjNDNqZ3M5NlhjWmY5?=
 =?utf-8?B?RTlxL3dCQVN4Uk15ajJVeTlEUzRRMnhNMFM2bVBqQ1lvMUxiOWZ1YjhHWnZY?=
 =?utf-8?B?Y0F1dXlkNFpEbkNqZXJzeXRmTlIyWWp0cGJQSmFuYjB1ejJ4OUNPNWxTdHdl?=
 =?utf-8?B?VjV3WERPN2lpamVoWFlwMHNsL2dtaWlxRER6V0xPTjRwMnZxUUdpM2tUQ1pq?=
 =?utf-8?B?eDVycWpDc1A1Q3Z5TlViQklOUGV5VEI0clJPcjFiczdlUWRuMjhSMVE4YUNI?=
 =?utf-8?B?NlpkQ1JvcFdERlcyc3NFMUptc1dld1pCTFlGSWh6VWY4WU1jMnlDaTRMbDJR?=
 =?utf-8?B?Y3l5Tm9xMjdMNzluVFVHakZ2ZDJPTnRmNmFqNXhQdlRDVEZaenhwcHdFVkZl?=
 =?utf-8?B?a2RLT1FtbTFhYzQzM0xTRUp3VmhpYXFHckxUbjkyV0x4MmlvTnZFMjVkVmtT?=
 =?utf-8?Q?SCqb57ncFSXHiQPaeUBuxOb+E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5827ac09-dfce-47e8-6c07-08db57456f5f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 02:13:13.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYCECwm8JdNtaXLuBVTjbuDqbNrQjSGrasntsHsKjLKJ2LRTyHJjtUNB0/upnnEeXBESDtOnNMKDNdWkMdiADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ian,

On 5/17/2023 11:28 PM, Ian Rogers wrote:
> On Wed, May 17, 2023 at 10:22 AM K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> Motivation behind this feature is to aggregate the data at the LLC level
>> for chiplet based processors which currently do not expose the chiplet
>> details in sysfs cpu topology information.
>>
>> For the completeness of the feature, the series adds ability to
>> aggregate data at any cache level. Following is the example of the
>> output on a dual socket Zen3 processor with 2 x 64C/128T containing 8
>> chiplet per socket.
>>
>>   $ sudo perf stat --per-cache -a -e ls_dmnd_fills_from_sys.ext_cache_remote --\
>>     taskset -c 0-15,64-79,128-143,192-207\
>>     perf bench sched messaging -p -t -l 100000 -g 8
>>
>>     # Running 'sched/messaging' benchmark:
>>     # 20 sender and receiver threads per group
>>     # 8 groups == 320 threads run
>>
>>     Total time: 7.648 [sec]
>>
>>     Performance counter stats for 'system wide':
>>
>>     S0-D0-L3-ID0             16         17,145,912      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID8             16         14,977,628      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID16            16            262,539      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID24            16              3,140      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID32            16             27,403      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID40            16             17,026      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID48            16              7,292      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S0-D0-L3-ID56            16              2,464      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID64            16         22,489,306      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID72            16         21,455,257      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID80            16             11,619      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID88            16             30,978      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID96            16             37,628      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID104           16             13,594      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID112           16             10,164      ls_dmnd_fills_from_sys.ext_cache_remote
>>     S1-D1-L3-ID120           16             11,259      ls_dmnd_fills_from_sys.ext_cache_remote
>>
>>           7.779171484 seconds time elapsed
>>
>> [..snip..]
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thank you for taking a look at the series and for the ack :)

> 
> Thanks,
> Ian
> 
>>  [..snip..]
>>
 
--
Thanks and Regards,
Prateek
