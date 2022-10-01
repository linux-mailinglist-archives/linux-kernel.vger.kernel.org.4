Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776525F19FC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 07:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJAFN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 01:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJAFNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 01:13:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF111471F;
        Fri, 30 Sep 2022 22:13:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUuP+Eot8B1jAgHeXPl2x+Y1whPxGC12VjoG3emD+y8G3qcvIzRw+1qsv8y3MfGu2OTDnsBnab0PRK0Jyyhmk5m+Shx9I7RXuzlA7suOr6vOpdXWCnE/n4dlVV3xT++3JJYDmbDHPuowdDCKgxgggkwe3GDB9b8yZ7uIdymUwCGQ/tW8svWdfLfmouiX2/nYTeCFh5aliXOsHPeAGV9QWUP7snzGZkkfC4TTCFxj6XRqsIt0IU0yrn3yA9aT4bgl60rssKOAi3+uVsLTPXfBfTTGlwZ3rgdzhhpbJ1csaTlhRcKBW4H6EhAUP7CJpyPwcz7EsECTtYAFwVEj4nEBiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVwR59crsgKk4Kkugf3LwdSO0u9Fk/c75jAP/TERLqk=;
 b=K35hv2jsE9+d4gO7luAD3350JhgeI5qw3XEog3IHiHyt3sttc1KA12+S1J5W8yyKyc+oG4cDYJbhc4vtWo3q6jeUE1UXxAznFookv0hNGlRO3NDUvk7ICGyOTf1vAG0rme8/zm4cTBp2zremfjFP9jbgFRpnrcAt13ZrGsDLCyfl/d36vUgHO9xn/GJDfaiRFSXbdnPTGVekmsy6mFqdtmbajUCnIjgZ/7rSIvDzo4Qsz1d4AQxtHQs5lZ7NZvD2Q+boGDYu5pRV8LPOArL6yWPsXBo+7E43JfgO2osSybsWLlsdOIRfFhjgNYa7OLjXLSX2CmbaWEpXuMlg+98jTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVwR59crsgKk4Kkugf3LwdSO0u9Fk/c75jAP/TERLqk=;
 b=rBsyf3bkQUfsHDYSffsVn8kG4z4iGxHy3xnovj3d9/EjpDM9ofNR08KVeto7zK46dWhgNqzNdfjKonxosMkSciaUf/qXpbXeLa0K3jqAV1VJwUh09TncyJ9BHkPAh5BvOedDEhJGCBJoMKgaUiutBkavm4/3lxGE07yOEXZfzuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Sat, 1 Oct
 2022 05:13:22 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::2eac:da0d:9d7c:e20e]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::2eac:da0d:9d7c:e20e%7]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 05:13:22 +0000
Message-ID: <c75ba6c3-938d-14a5-2fc8-3e846eeba23f@amd.com>
Date:   Sat, 1 Oct 2022 10:43:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] perf test: Introduce script for data symbol testing
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220930120939.353315-1-leo.yan@linaro.org>
 <CAM9d7cibbdOb04qhKkfyRmwtHvttb6-bOu_uAN6D8ke-EJUWZw@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAM9d7cibbdOb04qhKkfyRmwtHvttb6-bOu_uAN6D8ke-EJUWZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa1f517-16fb-498b-0a6f-08daa36ba930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRm4v2p64s97NVKHayPUxhNUCLRNurLL8dInT+vAdmRieGk1Ecb/9aaH9dRTob31HzRqWGnYk/HtQJm0tQorLt5gOZQcZELJvrOPlegdgWE34aG+QQ9GLU9DBG7bIzNrMMSk6fNpdpKFfwEYUtGbNEnXQADgHOjZEGOJAsIjGX+YoKA684bMjtWvGnzvZTLllRGj2SUmpiXb6J+4a7y2cRHLddpWIKxPBSA74uSat27BJ4SocedugX+LyGeGJ7j0L+RXWFNpsFZ0t8yjqY/c9853qNN/SSE47leh4WhJ79/l0i4FXaAMLgQuuEM54QYYUIVZYlQLv4EHTzjruBU17na9AiZiTqX7yevju0hZA25C7yVZXPsgslho06+abtTLdoDsXt7Iqv0h2GXZC1bxl7wwxw0QGsEp7mEc98WbNxj384iU30qBFP1aP+CZR8BHFFWXy1/HlXUyixNW7T9u2rVyfJ/Rcz692F4dbXchkz5OE+lEeNmOyFWY288WfENny0/MyTkJDixlF9d2rSBk05GbbejO3L+je9lVMdnB/4iSiD4G+EE08Rl6m1AE4IxWzNEms/n3K4vKNWC2QM2/r55bTDwDkpB1K3accdN3UbZa4kHDInXIX5sMWn6L61pdKwYrLQziFB56SzndPaEHYvUupi70oUhqNS5bfKHN41sRxTDrEl5lk7biN1q2resuJDYacNjLT3FCW5wZF5C90GLtsJ/hJNNBKcVV3O/0JgKJcMpxE7eQbK01vzAcNuL8OkCRlMhi+p4ifzbRVru+Y78KZa3xLg4JNQsdz4kuEW4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(110136005)(86362001)(316002)(54906003)(6486002)(66476007)(478600001)(36756003)(66946007)(8676002)(4326008)(66556008)(6666004)(38100700002)(44832011)(41300700001)(6506007)(6512007)(31696002)(5660300002)(7416002)(26005)(8936002)(2906002)(2616005)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWlFb094NTQ4Y3V5dHZLVW81cmtTSzRiZ0FBYlBKM25Mc1dCZExmUHRSZnlO?=
 =?utf-8?B?WVI2Z0VDMzNGZzA3NzBPR0JkN3dVWlB2OTlhblVPb2xNcWJ3Ty9EUmVPT2ps?=
 =?utf-8?B?WXUvaGJQWnI1UDRuUDgvSmU4ZGk1V0lRZGx1U0RkVWRLdXJ1SmdOR2dxeTF0?=
 =?utf-8?B?R2djWW5jbUF1ZFgrOUhzaytNZ2RiR3lKU3dwWkl6Vm15ZTJ0QkxtZGE4dCtC?=
 =?utf-8?B?c0txM2NrVGx6YVdjZVRTTmFYUTlBRVQ0Yjlob0JJWDYwSGxiZzVORGJ6Q0cx?=
 =?utf-8?B?Qm9IQXZpS1VUR2o0dFNsSEV2dFRXWEsraVQxTWs1Vzdkbis3ekxjSmhMeHly?=
 =?utf-8?B?bkRvd0NzZzk1WEpGN1lEQXdETERoTlQ5SXlHL1NOaWhxWi9JTmcrR0FtRThw?=
 =?utf-8?B?ZCtMTXNRWkJuSmpqS0ZQTEcxRE1QYWh3L2dwY3NldVA5U2VEbm8rVmh1Zlgy?=
 =?utf-8?B?WDE1YkZnT2xaSkFsdnAwMWkxTWRvam1yTUg5RnBQVXJ2Vm1oYzg2STE0Rk55?=
 =?utf-8?B?dk9hWUsxNmtkYXZnT0NCT1JaRnhJbjFGT1FhaXVNR2w4U2tybjVlYWlZNjR3?=
 =?utf-8?B?UGZJMmU4d1hHeFV0VzNQeWZOMTBNL1VuL0xQQ2Q5NjhUNmJZWnZFMEJwM2pF?=
 =?utf-8?B?Tlpwa1FMZE4zUmJQOEFxVWRCUCtTNWdlM2Z5TWg2Z095Y0pLVFFYMmFmS0Vh?=
 =?utf-8?B?WUhiTEtVR2lKcG1uL0NRSEhSK1BCZ0ZjbnBocnRQa0JyNjVCbmkzRy80VWs4?=
 =?utf-8?B?Z3dSS2RnM2hjQ1JsR04yRmJBMlBiUGJPMDBUUHdtR1FVNkVtclAyS1AyK1Z0?=
 =?utf-8?B?Skd3Q0RaVk9kdzRrMjdwQ3RKRmIzZ2xHQ0lMd3JvQmFKeCt0Y25KQzBqZHJt?=
 =?utf-8?B?TWw3Z3ZydmVDUmowQy9GYVpJa0x1ay9mM1M5YmdqNFJ5VFFuSjZGQTZDNDBM?=
 =?utf-8?B?OU9aT1hzd1JZTncrRXh6dm9hamg1eHhScitXOGtLUHNJRUg0NHBMck1lcnY1?=
 =?utf-8?B?NVYrRVFYRWY5Nlc1ZkJLRzB4bzY1M0JWOTlrQnVLUzdXSWpBa09WeHNieUZr?=
 =?utf-8?B?ejZCaVRIZ2RaK0RMekg5WkdNb3lBOXIxRVhJTzUrLytZVlJDTFZFSkdZTE9E?=
 =?utf-8?B?dUxYOUJZS1VuenJPcHRXNEhGYVNJMGE0ZW5jeXpPa3FYejNWZ1JERk5LNkl5?=
 =?utf-8?B?L214US9raEo2RlJhRHl0dzNJaXRsNkhCZWR4bng2UHgxRkczMVpLc25iMXVH?=
 =?utf-8?B?d3BXZFBhZ0VyaSsrbVJONWkvWElZbnVObldQRHpoTGNSSG1TaEdwSG5Xcy9v?=
 =?utf-8?B?dW1GbnBTUmNlSUErcmg5Qy9BSmRmY0dyTzMwNmdNQm5CR2c5QU5pNGg3SkZG?=
 =?utf-8?B?cjlsb1I0U1dhVnQyR2hJN0NMTWNkQWpYRG12WnhkUWh3ek53YXV0NkIvRVlV?=
 =?utf-8?B?WkNqTEtKUC9LN2ZuSGc1d0pibm8rdU5wY1gzZ1I1alJqQ01tQyt0TDFoNnQr?=
 =?utf-8?B?OUhXb0FMSUx3TUpST3ZVNmoxaHdoNE56MDhVSUNFZGQvajJLMFQ3U2hQQ21G?=
 =?utf-8?B?Y213RU5lQ3gzYWRHV1ovOCs3Z0VJb3I2UXhKNEl0S2ZxK0dCUVc2ZHZXeEt0?=
 =?utf-8?B?dlFGSy9RaGFvVTBMZ0Q5TVY5QUNVTmRmb2JWYmk3OVdueVlMZTB4Wi8xRm9Z?=
 =?utf-8?B?dHJ6cjhoZ1ZXNEp6NUlOUFRNNWRyL3hmTmJPVnd6Zm5WVGRWRHpPbmhpOXNJ?=
 =?utf-8?B?cXV1ck01UG9RTkFzNy9rWWM0ekU5V3E0cmFjQ3ovbGxZRGZZUk1lSjhFWGph?=
 =?utf-8?B?U1RESDFLWFJESmQ1NmNDWlBoSHREVjVEY0NwejVBY2hGdzZmTzN2clJCTDE2?=
 =?utf-8?B?aXNCSVFlTjNEQnN6TWs1bFNwMVpNRlR3SElXUWhtMUVRbkorWk5wMVZ3TGJC?=
 =?utf-8?B?N1p1VmN0VHRzVWdlTGdOUGw5U3cyU25yZnJ5cmd4QlhNVURRZWw0czJRT0hi?=
 =?utf-8?B?aGJaemlRb0pPOTEyYmE1MjdaSHhManlMM3lJY05wdHdNbGhSMXB1d01RbUdP?=
 =?utf-8?B?R3dhSldyOXc1QysxK1B5WXVBMTVjd0NDSzhNWi9nUkh3bUcyL25Lbk45U0xt?=
 =?utf-8?Q?Z0gX55hWKx7lE1lHsTaSIFHll?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa1f517-16fb-498b-0a6f-08daa36ba930
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 05:13:22.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFkmf7DPz66BNiqF/A7icmfeDvYe7Y9SW/jHM+1RXww45MMHPy4RHqEw+CgAjjdbNbXYuGTtevBXuvjb/P5cDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +# perf mem/c2c internally uses IBS PMU on AMD CPU which doesn't support
>> +# user/kernel filtering and per-process monitoring, spin program on
>> +# specific CPU and test in per-CPU mode.
>> +is_amd=$(egrep -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
>> +if (($is_amd >= 1)); then
>> +       perf mem record -o ${PERF_DATA} -- -C 0 -- taskset -c 0 $TEST_PROGRAM &
> 
> I'm curious why it has "--" before "-C 0"..

IIRC, any command line options placed after -- will be carry forwarded
as is to perf record.

perf mem record [options] does not support -C option. Which means -C 0
will be ignored if user run `perf mem record -C 0`. Ex:

  $ sudo ./perf --debug perf-event-open mem record -C 0
  [...]
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 5
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 6
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0 = 7
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0 = 8

OTOH, if I place -C 0 after -- then perf opens event only on cpu0:

  $ sudo ./perf --debug perf-event-open mem record -- -C 0
  [...]
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 7

Now, perf mem [options] supports -C options but I don't know why
it's not working for me:

  $ sudo ./perf --debug perf-event-open mem -C 0 record
  [...]
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0 = 5
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0 = 6
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0 = 7
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0 = 8

Thanks,
Ravi
