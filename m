Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E916006CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJQGsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJQGsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:48:09 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202E55082
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaIiHAZhmJ+Lym9WgIvGLJKVP4IK6pszfQUnWD8vhRw+EYuiegHEihazku5Gqo100J2rj+kabuMLOgrPyENPmYT+UrD9GOo/3MITMLSgF1IfHkBCVL43/zi5FTk2wymZwbBJxjseKdS7yKoxyVrbtjeX8Lz4910DdTMcefgFQZmXTV8RosEtqtmhXt3hMWKcEZ4dRpGVxChFooGPe8SggjQNQw796oBdI3bwghCEJnY4FGck0icvZmL9yarTqrWYz2erXH0t+noyUY43V1OrOoiZ2eYoKoFYtNiTfjzHKb/In7+yiu9SKtA0BGT+lXBZb2unjtZlC8r++AOVrK6K2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wktz8DZ4NryvFTG4lLJ39bnMpNkzo66xnyWUzMtdma0=;
 b=OiDQGIKLKh9eUqX8jZYgm6x+QHu4miV8i+csUBLtncNgBjNf6yVZ8W6HJ+NZJ9VwOdc2RoVO7vaftgz1fDIbEnIjYwxxdm8BYf4JX4/VOc3YZKGIVBn5jGhXJtJrOhSGbySb60vWcTj1jYjykcXdcIQLfwJmj1eOfNsQh1Z9JXR6m7LuSgDN4J2x22f33/diPueSbvT899CvtiqIER4DBqcKL9NsTEkkO/6gxa4hUt3KSlGzgyzkG6WNQWRpw8j+rG61ORTut8eTfh+FGhFasobNZ8l9gLrEp9+KYKBmEkkJZYxKT+YZrOdkjAzBVQhNh5s1WE2WZlkkwQS3Tt1Rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wktz8DZ4NryvFTG4lLJ39bnMpNkzo66xnyWUzMtdma0=;
 b=u6D9FTGoRaO6OhpsqK5T39haa33rT+EvKlWnkZD5a6LkI0exQ/dhG0vyFpOi8jE1t6CuXX+r5RJwHLbKBNVSvAjvI1tLxOn38KeYAX8HjyhAv6IoOWdrcyh5pfppOQdxZTvrpO2LjJ33KOcuvjS1L0HPHr6fM1EUKd/Ci0kB5wc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 06:48:06 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2e7d:cda3:bb38:a1ce]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::2e7d:cda3:bb38:a1ce%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 06:48:05 +0000
Message-ID: <ec7d3022-9cf3-7c3b-6f9a-6b2ee598d1a3@amd.com>
Date:   Mon, 17 Oct 2022 12:17:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 0/7] Add latency priority for CFS class
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <cd48ebbb-9724-985f-28e3-e558dea07827@amd.com>
 <CAKfTPtC-yMUNfnGa8a4HrT-Onf4SZfRHDKyQcDZYnzhpPOk=Xw@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtC-yMUNfnGa8a4HrT-Onf4SZfRHDKyQcDZYnzhpPOk=Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::12) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: add0d99a-fb03-48f6-0623-08dab00b8b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+pbQA4chMVRcbTpWNWR9VvYgO/Mw6PbctiIV2b8tOAwvCL41jn2J8diV1dzDzH2LcrEn2vwOC9vnP+9aESq4NKrgmY8VJ1jVZ5hFk1/Z+brY7PpvU2k19CH29GggzqIB0Tp2K8PiZiWkPYYRJmD0ulgWrauSsp8J9j7NQ4qauOp4YXcveMDHCcHTC3WGiTZOf4UM3pjGCwnhvcCy6osNKIH7KdYc44QK5JHdVCCYaY5+uzvjUm+PJCd+GyspFd/+4gXsyFb1rZLm1N0MmBgs4CtPJESSKxK2hWY2LGIlSG13FbDKcQFIrEcE5GaBoX/W7jvABEpo2fyXYr/48h8C761ec57/g1iUt1T3eK/6Xnmk0kkCMlGbQYfTqfNbcMItT3MQrgDX9mlueXPrBuHf1VtAEB03PCOO1KmbyD0ahNxfvEIfymNZsRBnl0U3dmD8gfDzP6Dx9dTi7mWn/MrZfVx133XHIbq9jzY1a0X6cOHE+XUO2TBHnQDV7Ynd9aw6R5vHcnIxmgJC9g+bFbm5/BCfFRcTNHrTezdZYWYx/T4dh+YJaoAxiZI4GCRlXZHf1RJ92gmHq02so0ALfWrOt+IGEsnheLjEdEVyhxXUoZKzjSZ4eGQ40zMQoXhmHuQYUQpGGW5gQzcVXRlvIRIorndypNawB9mbvblZu8Xj+pr4MbxIyhJTVzafxrFkPx+owum+S94HJrobyjZ8PSHB0mlJjdkwo2mYoWFyUfwAXeCncKQvi9pJ2rgK8oobH83CMRwwhk6U2UJOHpK4LV5wtE2zYM1F6lOou/UMDCCUJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(36756003)(31696002)(86362001)(4326008)(41300700001)(53546011)(40140700001)(6512007)(26005)(6506007)(8676002)(6916009)(7416002)(5660300002)(8936002)(66556008)(66946007)(6486002)(6666004)(478600001)(316002)(38100700002)(66476007)(2616005)(186003)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnJ4V3p2YVpmQ2dGRk1KRUJFb2VEaFhiakk3ZnNZS01MblR4K01JcWdzOVVv?=
 =?utf-8?B?UVNQTUxHcmdZaFM2SzdPYlVBdmJYVWkrbjQxN2dTcFZ1dFVteFZ6eWltMUZr?=
 =?utf-8?B?azZPRXVQaTdob05mamF0Nm1Ec09kWUtwa1V6MWxCY044S1lFQnlaRmF5azN1?=
 =?utf-8?B?S1BlSE1BKzcrRll2b1RLUHVQUWVWNTRKUkt2bVBXUnlYcFlGYjd6TXdaekZM?=
 =?utf-8?B?bVUwM1ZrUmhmL09sOVpzdCswMEd0SVNYYytPY2JXVzBBcFN1TDVCa1A1MFBa?=
 =?utf-8?B?RmFVRitQbGhyTENkUitmM1FvUVpSS1hSblhaeTRXTjBMTitNeW9DeGVWUk9y?=
 =?utf-8?B?V0ovMGZEODgvRDBuWlVCQW1QenhudWxWbk1OdDQ4UnpzaWZBVG1RK0thOVkr?=
 =?utf-8?B?elQxcHh1YUZGSzZ3Qm93TE1Hb29ZcXFyRjVPbnN4R1dOU1J3Q2V0L2Vlejlk?=
 =?utf-8?B?ZHF1OE5pRlF0ZURLaUR0QUlGNHRmSHhaYk5LcUV6Z1JpZTlGd0RxbEZsdmZL?=
 =?utf-8?B?ZnRkT05oR3pOT0FEeTM0b2U2MER3Mnd3SFNwV0tJdkFuTGlYSXhxRktKTWhi?=
 =?utf-8?B?bGUyVDJIR25SZkFEc3pQUUJMcDRFTGVoTEdDSEQvSFdmeUhQVEpOc2tBSjB2?=
 =?utf-8?B?RFAwWHpjV01KRFJGa1VmcXpmS0ROZWhiS3REZk1LU1lUR1BYZE81OGVVTEFj?=
 =?utf-8?B?TmpONjZXWmU1U0tWU2dsaVBOdlgyTzdGaGt3WnlML1B3OTh3UzZlRUNKUGdo?=
 =?utf-8?B?OGc1Y1hzYzNIMlNLQTdKSWliNmVEdkNDTmVEbjFjYVBhN1BKSG05bWxvWlZW?=
 =?utf-8?B?UTFBQ0xEdFFnUXgzaEswR3RKMHMyL3NVeFUxN1h6d1JmMlFCWnhHTFVJa3J3?=
 =?utf-8?B?RGtBeGFyM3l3dnc5SUp0YnUzUk5XaDlTTmQ5dEh0TmQyNXdqQUh1aGg1NVNI?=
 =?utf-8?B?NmU4ODdyajdKR1NlMTZTWm1SVkpiclFXUHFaL0NDM1A2Sm1RTWlPaWRMZm1T?=
 =?utf-8?B?Q241VjNzT240K0JaS1JPTDlXSmxXWTc3OWJhZGRsaHoxSVdidmxUbTkwdXdJ?=
 =?utf-8?B?ZUNuM1JZd2cxbTJKaGlBWm9TZHlEWVdPd2tWMFJZNnVBbnFHeFpuUm1ZUWNk?=
 =?utf-8?B?YWFaWDBkemlsZG80VEZtVUE3bkYxWW5NcVZmTFE0dUFSTDJPbndaODJ2RUlw?=
 =?utf-8?B?Q2wwVElxOFRTczd1VUxBMjdyU2RibmxBcHJVMTVGSGtwV2szd3NtcGFEeFVo?=
 =?utf-8?B?VXNRWmtkNFNCeVBIbkRDVXZSOGtxbEZxMk9CQm8ySURRM3I3MkVKT1hWUERp?=
 =?utf-8?B?RkVrMEx4cjlyQjk1TnMyS21BZU9keGFOVTMxdU5tdVpKMTE1dnM4YUlSUnov?=
 =?utf-8?B?Kzk1VkJmL2dUOFRWSEZJQW9qcEozdlFuc2dNeTJoMElhZ2xSODg0Y2tNczUr?=
 =?utf-8?B?VlZ1QzA5VFZHQW1KTkd4dnVXWHF0eUFpemZBeThKenhOWlpTNm9LbzVEZDdu?=
 =?utf-8?B?L0tCM2w2VWlEb2hKa3lKQkdDUmpHcG9yRjR6cmFvVTZHMWxBdUtYZGtEQ1d1?=
 =?utf-8?B?NERzNldkSFIzREo1a0Q2eW1yeXZ5RENTL0hoSFl1YzZuM2pMU28zS3R5cm5S?=
 =?utf-8?B?NUZVamdYc3U5WG1GbU0ya1hEejlXa2dYSmxjQk1oeVYvU3UyN3plenVsQ3cv?=
 =?utf-8?B?Z3QrdFhSQVFnWS84a24yYVhHd01DSnkwVUF5d0JjL2ZwbFZOMXdNN2p5cVhD?=
 =?utf-8?B?MVlrZGl3ZWY2S3NOTGIzczkrOTRwUzgySC9MTTN0cjBjbFUrd3hRbUx0TFBa?=
 =?utf-8?B?OEdKalBRMlM3Q200NUFyaFUwUnc1bHFJR1F3dkNaL1RIb1NDQ3cvYzlrdFpv?=
 =?utf-8?B?ek80R3VyYkNycXFaR1NTUWNkWUdISTlreWhoRCtYWGl0aWg3T2poRG1MamVx?=
 =?utf-8?B?TjZBRVlIWC95ZTdla1VFaExQaHpFR3RpelZyT1BqQ0p5WWpFbm1rTVM4dUxu?=
 =?utf-8?B?dThJWjA3WndtUzZUS2tqWkQvV3BMd1FmWGxFeG1nVVF0MDNkN1d6QmtwWkZO?=
 =?utf-8?B?ZXBkWWdmKzdIbnFod1BUdnUxRm9nWHdOY2V4Y3huZ0oyN2kyTldERHlxRy9X?=
 =?utf-8?Q?AC6v0ouq5u7mpsU/77v3iV6Di?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add0d99a-fb03-48f6-0623-08dab00b8b20
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 06:48:05.7700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNItoTwiUgI31YxfEdUFpPkM/SNZES3mC0fpaz4c/rHMzWFtCb22/3xfJMvwyVQ3I7dJ4VZD0nUahge5prgDFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent,

Thank you for taking a look at the report.

On 10/13/2022 8:54 PM, Vincent Guittot wrote:
> Hi Prateek,
> 
> Thanks for testing the patchset on AMD and the test report below.
> 
> On Wed, 12 Oct 2022 at 16:54, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>>
>> [..snip..]
>>
>> - Socket (Process)
>>
>> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>>  1-groups:         6.44 (0.00 pct)         5.50 (14.59 pct)  ^     6.43 (0.15 pct)
>>  2-groups:         6.55 (0.00 pct)         5.56 (15.11 pct)  ^     6.36 (2.90 pct)
>>  4-groups:         6.74 (0.00 pct)         6.19 (8.16 pct)   ^     6.69 (0.74 pct)
>>  8-groups:         8.03 (0.00 pct)         8.29 (-3.23 pct)        8.02 (0.12 pct)
>> 16-groups:        12.25 (0.00 pct)        14.11 (-15.18 pct)      12.41 (-1.30 pct)
> 
> I don't see any improvement with LN:-20 but only for LN:19
> 
> How many iterations do you run ? Could it be that the results vary
> between iterations ? For some configuration I have a stddev of 10-20%
> for LN:0 and LN:-20
> 

Yes I do see a lot of run to run variation for the above runs:

For 1-group:

LN:           :    0             -20              19
Min           : 6.26            4.97            6.28
Max           : 6.54            6.71            6.55
Median        : 6.45            5.28            6.43
AMean         : 6.44            5.50            6.43
GMean         : 6.44            5.47            6.43
HMean         : 6.44            5.44            6.43
AMean Stddev  : 0.08            0.60            0.08
AMean CoefVar : 1.18 pct       10.89 pct        1.28 pct

For 2-group:

LN:           :    0             -20              19
Min           : 5.80            5.38            5.28
Max           : 6.80            6.70            6.32
Median        : 6.66            6.53            5.48
AMean         : 6.55            6.36            5.56
GMean         : 6.55            6.35            5.55
HMean         : 6.54            6.33            5.54
AMean Stddev  : 0.29            0.41            0.33
AMean CoefVar : 4.38 pct        6.48 pct        5.99 pct

I've rerun this data point and following are the results:

- Socket (Process) (Loop: 100000)

Test:                   LN:0                    LN:-20                  LN:19
 1-groups:         6.81 (0.00 pct)         6.62 (2.79 pct)         6.62 (2.79 pct)
 2-groups:         6.76 (0.00 pct)         6.69 (1.03 pct)         6.65 (1.62 pct)
 4-groups:         6.62 (0.00 pct)         6.65 (-0.45 pct)        6.63 (-0.15 pct)
 8-groups:         7.84 (0.00 pct)         7.81 (0.38 pct)         7.78 (0.76 pct)
16-groups:        12.87 (0.00 pct)        12.40 (3.65 pct)        12.35 (4.04 pct)

Results are more stable in these runs but runs with LN: -20,
have comparatively larger Stddev compared to LN: 0 and LN: 19

>>
>>> Loops: 2160 (Same as in testing)
>>
>> - Pipe (Thread)
>>
>> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>>  1-groups:         0.10 (0.00 pct)         0.12 (-20.00 pct)       0.10 (0.00 pct)
>>  2-groups:         0.12 (0.00 pct)         0.15 (-25.00 pct)       0.11 (8.33 pct)
>>  4-groups:         0.14 (0.00 pct)         0.18 (-28.57 pct)       0.15 (-7.14 pct)
>>  8-groups:         0.17 (0.00 pct)         0.24 (-41.17 pct)       0.17 (0.00 pct)
>> 16-groups:         0.26 (0.00 pct)         0.33 (-26.92 pct)       0.21 (19.23 pct)
>>
>> - Pipe (Process)
>>
>> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>>  1-groups:         0.10 (0.00 pct)         0.12 (-20.00 pct)       0.10 (0.00 pct)
>>  2-groups:         0.12 (0.00 pct)         0.16 (-33.33 pct)       0.12 (0.00 pct)
>>  4-groups:         0.14 (0.00 pct)         0.17 (-21.42 pct)       0.13 (7.14 pct)
>>  8-groups:         0.16 (0.00 pct)         0.24 (-50.00 pct)       0.16 (0.00 pct)
>> 16-groups:         0.23 (0.00 pct)         0.33 (-43.47 pct)       0.19 (17.39 pct)
>>
>> - Socket (Thread)
>>
>> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>>  1-groups:         0.19 (0.00 pct)         0.18 (5.26 pct)         0.18 (5.26 pct)
>>  2-groups:         0.21 (0.00 pct)         0.21 (0.00 pct)         0.20 (4.76 pct)
>>  4-groups:         0.22 (0.00 pct)         0.25 (-13.63 pct)       0.22 (0.00 pct)
>>  8-groups:         0.27 (0.00 pct)         0.36 (-33.33 pct)       0.27 (0.00 pct)
>> 16-groups:         0.42 (0.00 pct)         0.55 (-30.95 pct)       0.40 (4.76 pct)
>>
>> - Socket (Process)
>>
>> Test:              Latency Nice: 0         Latency Nice: -20       Latency Nice: 19
>>  1-groups:         0.17 (0.00 pct)         0.17 (0.00 pct)         0.17 (0.00 pct)
>>  2-groups:         0.19 (0.00 pct)         0.20 (-5.26 pct)        0.19 (0.00 pct)
>>  4-groups:         0.20 (0.00 pct)         0.22 (-10.00 pct)       0.20 (0.00 pct)
>>  8-groups:         0.25 (0.00 pct)         0.32 (-28.00 pct)       0.25 (0.00 pct)
>> 16-groups:         0.40 (0.00 pct)         0.51 (-27.50 pct)       0.39 (2.50 pct)
>>
>> o Hackbench and Cyclictest in NPS1 configuration
>>
>> perf bench sched messaging -p -t -l 100000 -g 16&
>> cyclictest --policy other -D 5 -q -n -H 20000
>>
>> -----------------------------------------------------------------------------------------------------------------
>> |Hackbench     |      Cyclictest LN = 19        |         Cyclictest LN = 0       |      Cyclictest LN = -20    |
>> |LN            |--------------------------------|---------------------------------|-----------------------------|
>> |v             |   Min  |   Avg   |  Max        |     Min  |   Avg   |  Max       |     Min  |   Avg   |  Max   |
>> |--------------|--------|---------|-------------|----------|---------|------------|----------|---------|--------|
>> |0             |  54.00 |  117.00 | 3021.67     |    53.67 |  65.33  | 133.00     |    53.67 |  65.00  | 201.33 |  ^
>> |19            |  50.00 |  100.67 | 3099.33     |    41.00 |  64.33  | 1014.33    |    54.00 |  63.67  | 213.33 |
>> |-20           |  53.00 |  169.00 | 11661.67    |    53.67 |  217.33 | 14313.67   |    46.00 |  61.33  | 236.00 |  ^
>> -----------------------------------------------------------------------------------------------------------------
> 
> The latency results look good with Cyclictest LN:0 and hackbench LN:0.
> 133us max latency. This suggests that your system is not overloaded
> and cyclictest doesn't really compete with others to run.

I'll get data while running hanckbench with larger number
of groups. I'll look out for larger latency in LN: (0, 0)
case to check for CPU contention.

> 
>>
>> o Hackbench and schbench in NPS1 configuration
>>
>> perf bench sched messaging -p -t -l 1000000 -g 16&
>> schebcnh -m 1 -t 64 -s 30s
>>
>> ------------------------------------------------------------------------------------------------------------
>> |Hackbench     |   schbench LN = 19         |        schbench LN = 0         |       schbench LN = -20     |
>> |LN            |----------------------------|--------------------------------|-----------------------------|
>> |v             |  90th  |  95th  |  99th    |   90th  |  95th   |  99th      |   90th  |   95th   | 99th   |
>> |--------------|--------|--------|----------|---------|---------|------------|---------|----------|--------|
>> |0             |  4264  |  6744  |  15664   |   17952 |  32672  |  55488     |   15088 |   25312  | 50112  |
>> |19            |  288   |  613   |  2332    |   274   |  1015   |  3628      |   374   |   1394   | 4424   |
>> |-20           |  35904 |  47680 |  79744   |   87168 |  113536 |  176896    |   13008 |   21216  | 42560  |   ^
>> ------------------------------------------------------------------------------------------------------------
> 
> For the schbench, your test is 30 seconds long which is longer than
> the duration of perf bench sched messaging -p -t -l 1000000 -g 16&

With loop size 1 million, I see the schbench complete before
hackbench in all the cases. I'll rerun this with larger group
size too to get more data and make sure hackbench runs longer
than schbench in all cases.

> 
> The duration of the latter varies depending of latency nice value so
> schbench is disturb more time in some cases
>>
>> o SpecJBB Multi-JVM
>>
>> ---------------------------------------------
>> | Latency Nice  |         0  |           19 |
>> ---------------------------------------------
>> | max-jOPS      |      100%  |      109.92% |
>> | critical-jOPS |      100%  |      153.70% |
>> ---------------------------------------------
>>
>> In most cases, latency nice delivers what it promises.
>> Some cases marked with "^" have shown anomalies or non-linear behavior
>> that is yet to be root caused. If you've seen something similar during
>> your testing, I would love to know what could lead to such a behavior.
> 
> I haven't seen anything like the results that you tagged with ^. As a
> side note, the numbers of groups (g1 g4 g8 g1) that I used with
> hackbench, have been chosen according to my 8 cores system. Your
> system is much larger and hackbench may not overload it with such a
> small number of groups. Maybe you could try with g32 g64 g128 g256 ?
> 

I agree. I'll get the data for cyclictest and schbench with hackbench
running larger number of groups alongside.

> 
>>
>> If you would like more details on the benchmarks results reported above
>> or if there is any specific workload you would like me to test on the
>> Zen3 machine, please do let me know.
>>
>>>
>>> [..snip..]
>>> 
--
Thanks and Regards,
Prateek
