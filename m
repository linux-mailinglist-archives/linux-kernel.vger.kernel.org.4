Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64A72F33D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbjFNDu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjFNDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:50:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319F171A;
        Tue, 13 Jun 2023 20:50:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrdMusVWbONnHcgc60eYT2KoaXVeWQOIpElUHnfAsFvCtz6m/+D0QteP2NC9+1gYUuScTI4XMq8U63mfcePUhfTFR4KyhOJpR7YOIa0QU3J5p/FaygxAmmFxePK5h0C/CZJnqrJe9aagFL2PioO7l9Vwf6cChxzkq7fKDoadkmb7BJzWUF3r2pze1FWsimW76Lg9XXwnmAdeJAsyuadWewbu/EkSPlMSwcUodSl97FEJqCkHUUPGkDY8sbPrTpuNnMxED4srXR13trfBZERFlMk1ndoGIkE3cERdpmbUQTLBW39tujaAV+9wfufkWLwfjFGaN9xJJ13v4IEC9q4EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU+o5Gjl8uZiHMLqCnQPP6y48J3x6085XwQOGje0MMc=;
 b=OFQCjyHEndhxo15lExwjyIh21kzJQzuOFu+PWDboUHbPfF2vWps+BHLUlS+gjTxu+GBHTmdgVOkma7HVXBZz0wQ+PAn+BA3wYNlxvLrfVaAQIMU/mQrIftrTtRNyljRlttooAM5H1ko4d9++pIeS5ZKSIVpJRcyGy+pEjA+P5wN22yuEr6yY/sIcxb97ywRoj4XU9CtXv1qCzfGTfsVavE7dx/3C5WckGYkcwkkRbvXaqLUXzEREdP8akXa35EANK9DImqTyNFX26KDNTH+6ILSjhaanRihPjFWgzZzfKWMAsMyq45/9Xk28njO3AXWmbcpyIoweCe5AE57/Rx5UOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU+o5Gjl8uZiHMLqCnQPP6y48J3x6085XwQOGje0MMc=;
 b=u9kRQkTlupspI4U8d5G+9zCPOGrK9bxDB9CI97IXJSNdmCSnOVvbzbfi3ECAsS9eA7Hbga5ln9775EyS8S+pUveqW5BLuVtjKeKf2iXbnH4cEFUlsaOvQ0OSVleDdXf2/WTgSMG+KLKXUIgwzvfzpfz4iVqLIo1OBPwYy4Mjnjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 03:50:17 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 03:50:17 +0000
Message-ID: <72e58cc7-acde-600d-b9a1-b89d9d8a168b@amd.com>
Date:   Wed, 14 Jun 2023 09:19:59 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] perf mem amd: Fix perf_pmus__num_mem_pmus()
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org,
        adrian.hunter@intel.com, kan.liang@linux.intel.com,
        james.clark@arm.com, alisaidi@amazon.com, leo.yan@linaro.org,
        maddy@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230613095506.547-1-ravi.bangoria@amd.com>
 <20230613095506.547-4-ravi.bangoria@amd.com>
 <CAP-5=fW0R2Dkwvw0twdzL5GrLy6jy0CXmFHYCsZtC8UQnZ4mVQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fW0R2Dkwvw0twdzL5GrLy6jy0CXmFHYCsZtC8UQnZ4mVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5ec6cb-8aa0-4f76-3e65-08db6c8a779c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iScVS+6uswLGzeuGXymn+kCSNifBwyB5Wr6IhZ2YjBduSAkRIwTc7Xu1Hbs0O4gvu6K1FB27N3+xnSzTJe7TKaXLFGreMx4A53AquPCHm/ZDgJH0+fAo0crYuDj5vxzExTs9xfrdiko0N0VvH9m+DT6bxy4Me8CZOULayHiud+KqcOvS9/1H+hpdF16fmrh03QREc4/ytSQKliyUrMYgOkX/4Pw+astiHdsYCckNPexbGWpZd+dbOsITLber8RAPhZbmBBDMdlINgeuf0u3zZMXNB1KZYULV/GI7eVfNatVyYLeS1XHwzxYopYSf5i33BAHnrCNRfRwV/yJZGP41RGpfCKk0Pr2pFO/B3ucAZGmuGxJtl6tlUk91SZR3Xj/rs7kCbIQCNGbRUrCfogw3pUAEuZCQr/g7lKQ0j7RqQgBh80HcCt5vvk7G7Lgm8ffNfv5pt7s0lP/1bsCbBwN3W5p1P/Vp70iAx+ImsDSaBuPTN9XeQnmfG9s21KTxye7HyVY9upPWcrYiudrtBESMDwy5ONwM5TDkWC6kv2nDqt3cVBo/+kIAf4cGr/bTrGqRkO01GKiSHPUDswT9NSJOsSh1Ig5L0jlV6D/ss4Z8x9l8Vn4+Za0TFKMMFmlEeCS90hhWDzafVc7eikGjCFYsfrQSxYxSNDcT0I6LBOShRbNL5GZhid85YgoiR0qQwXDK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(66946007)(66556008)(6916009)(8676002)(8936002)(36756003)(5660300002)(31686004)(478600001)(66476007)(4326008)(6666004)(316002)(6486002)(41300700001)(38100700002)(7416002)(26005)(186003)(6512007)(2616005)(31696002)(86362001)(44832011)(6506007)(2906002)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lmSHVvUERjNGoyTUZWTGloMjFiMXpNT2pKL1B2QjlQQ09IbU1KN0I1blFn?=
 =?utf-8?B?bFpaK253Mm5PRFRxTGxpbTk5SXc1elpxRjhjK3dnVzZaRGhpYkFIcnRpN3J1?=
 =?utf-8?B?RmRmY2FPM3FGaUU3Qlg3dW81RTJuZXQrK2RhTEtkZHgySEw0Vy9jK0pSVnFQ?=
 =?utf-8?B?dm83aHdpZjFaMG1hVTRCTmFDZHM2VG12MjM0alBpY0ZMaFMzTC9BUjVqQUdt?=
 =?utf-8?B?RzlyWHQ0ZUJyaHBVYlUzUnFYVzhKZXFKZG55STBtWm9RNmZCU1RGdGphK09Q?=
 =?utf-8?B?THdTc1FGblF1OCtoUm9EWWRXNVMrU2hybGl6WGFvS3NGK2xQcHB5M05kUnhS?=
 =?utf-8?B?S015dE1UQjlkMGZHUTNzNzRQTUxtK0hweHhKZWo4UzJBVjhDOWFWUlM4dFZH?=
 =?utf-8?B?TndTZDkwcHhnYitHUjB6V0NSMDhLMnUrU1Vla01oRjBJdi9jQXJoa1piTXF1?=
 =?utf-8?B?M3R2VHBjNmZwbjlWYVRmN0F4TUVQSTFFL1FaV3lYUTVPVGhRYU9USWIxa2lY?=
 =?utf-8?B?cUljRkFtNEpoanJIVnRZSUlqbUl6VTVBNEgyQ1E5ZkJ3MkdSTGpEYnlsaStn?=
 =?utf-8?B?c2hYMERKcldTSjVzQWE2YkpESjR5RUxNeFZtT3NkNndwb3VxWjZMbE1vYzJt?=
 =?utf-8?B?c1I4enZtbUhVU1IyenBFMlJvV3ZiVFZjKzdyV3J4Ri95ZjBGR2NxQjE4TThS?=
 =?utf-8?B?TXBDN0ZMMFV0WVYyU2ZrTHBnYXgwWTZpRGJYb1g3SzhCYTdwQStleU5Za0ho?=
 =?utf-8?B?eXNzV01HSnh3U3NYUy9idjBlaW1iK2hzUktIUWs4NkUvM2ducmJnMDk3ODNX?=
 =?utf-8?B?dmx0dXgyZkJWTjBvaDJZak8vZmFYRzlCNmIwQUEvdmVHeUdXY1ErckEyaTA4?=
 =?utf-8?B?eDhtZUZMcitQcE1KaHRQN0sxTi9oUUhqMzR0RC9WeTJheC9FN3FYMElQUzlD?=
 =?utf-8?B?bVhUaGplNGtEMlNkd1ozdHZTTmZSV0MzYmY4MUpoTEd2NVNTRC8vc3l0Nkh0?=
 =?utf-8?B?cWR3M1JwNCtIcE5pT1dxS0FNQitXTXZ1WVQ3OEFRdXVjUFFZZk4zUmtNYnhJ?=
 =?utf-8?B?ckQ4UGdTZEp5dzJNMDdUWWllbnFKc0xjck9acXVQT2Z3bEpuNVZOMjVSQldH?=
 =?utf-8?B?eW5rb1RCR05SL3B4YkNFeDYxRVVrTHY4SHNQZFRqVStHaW9BUjdveTdBUUwv?=
 =?utf-8?B?Mll0eHNEclN6RmlWdDFGQWpiUXVaS1BQZkpXS0RGeDIrbFNUTHdjWUEwZkNn?=
 =?utf-8?B?dXlVSUg2VjYzNEhsa1N3YllFUGh2elhGd2dBYU1ma0hMVzZMOHIyaTBpQ3dB?=
 =?utf-8?B?RXhKaFhxME1FY1k4N3lXRnVMcUZsdGNLRnRDN0d2WFJKbWYvY0tJcHBiN3Rt?=
 =?utf-8?B?UHh5MU1RcTdQQWdZUWw0N2lGTUNzZ1VEb09wLy91cW8xK0Y0WWEweWVnWnds?=
 =?utf-8?B?UjYrTWZxcGhkU0ZyN0FScGVOd1RQK3RUWSsyRXllMGlXa1dDaDBhR0I1Yk13?=
 =?utf-8?B?c2dMUGtNUHNCM2hPWnBoWVl5dzBPZGJYeU92RnlMaUVxZTRUWWpLeWFXeUc0?=
 =?utf-8?B?alRyVEorclgrcEd4R005clJRRmFTbVdvNmVmdU94dU4vcVJ2Tk5HU2l2ajNo?=
 =?utf-8?B?eEt6UG04N2dzV2lJK1NsaitmbkorSzJrSXV2dmhRSVUxOUNUTEU3QlRiZStr?=
 =?utf-8?B?WFNMa3BQVW54SDRRM0k4L1VyMW9IVkVjV29xSW5IUDJ4N0IvOGs5V2VoUmNs?=
 =?utf-8?B?elpqZmdldWptSkNoVEprUm1SNDg2aW5DOFdGclNZYnRtSVFRWTVhRU5FbVJj?=
 =?utf-8?B?OUx1eDVJdk5IYndzUnZXUXZIOGtCWTJxMDRzWlNFQnp1QnJQMTMwdTk3cHVn?=
 =?utf-8?B?TENQbnAwM3JEZURlbnRJVGx1Wk92TXBkdUoraXJUVklSZDFrbWtvNVRqVWcv?=
 =?utf-8?B?ek12MmIxYTErZGdMaWYya0hTRWo1RWZZTVRNNy9QMzA4Mm42Ylk2clVOaWt1?=
 =?utf-8?B?TGltMjBwcy82MXlVSThvd3hBQVhpNHlOWmR5QzJjRGpKQWZpamppWDl5T2NW?=
 =?utf-8?B?WUFLU1lKcHlkU3hiMXBkOG9KOTcxcjFnWDVCVjJjYnVFYTVrbjZQR1N1T0s2?=
 =?utf-8?Q?sGM/iyztK2ByE9+IgdC/wFCEv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5ec6cb-8aa0-4f76-3e65-08db6c8a779c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 03:50:17.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GwiwAe362dTge3WBRqkO7np50VWVHH67EoGRl8Hf0L3L9gQnv5DCmRrxPT+Ilem7VE/DR4hmPkMpNuK8Qc5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
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

>> +int perf_pmus__num_mem_pmus(void)
>> +{
>> +       /*
>> +        * AMD does not have hybrid cores and also uses IBS OP
>> +        * pmu for perf mem/c2c.
>> +        */
>> +       if (x86__is_amd_cpu())
>> +               return 1;
> 
> The code and comment seem out of sync here. For the hybrid part
> perf_pmus__num_core_pmus() will yield 1 if there is no hybrid, so we
> can just use perf_pmus__num_core_pmus(). For the IBS OP part, does
> that mean that AMD should have 2 mem pmus? Or is IBS OP a core PMU?

Sure. Let me remove hybrid part from the comment.

There are two IBS pmus: ibs_fetch// and ibs_op//. Both of them are
independent of the core pmu (cpu//). An instance of all 3 pmus is
present in each hw SMT thread. And, perf mem/c2c internally uses
ibs_op// pmu on AMD. See tools/perf/arch/x86/util/mem-events.c

  static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
          E(NULL,         NULL,           NULL),
          E(NULL,         NULL,           NULL),
          E("mem-ldst",   "ibs_op//",     "ibs_op"),
  };

Hope this clarifies.

> Can we add this as an example in the core/other documentation in patch
> 1, as you've done for ARM, for clarity.

Sure. Let me also add IBS example in the patch #1 comment.

Thanks,
Ravi
