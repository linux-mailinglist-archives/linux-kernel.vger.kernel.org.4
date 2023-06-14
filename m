Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907BD72F355
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 05:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbjFND6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbjFND6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 23:58:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E96019B1;
        Tue, 13 Jun 2023 20:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Me16jUSA885Jx7N5e5CymHVjz/SeZolcf0ukgZiKZAJz6ZHNU1YFIoVhpvcYTfBHmOavBNg39g/tJa/jnTQlvqJsPwkSRwrOg360cvt7ALheo3chAUmXqhPeTdb2RytWkQz4e2MZ0t1kB9LlMZJ3iYplTQOrDJYXkBjC2JaZDSk8hCDVESieqFMsH7NUmZMgeJ/gSM3ZqJraRXf9JDlcsALWKbkgXNosoIJ1i0XMTqoR6A2/rsQBCus18fFLpnvuApElPBXKisKLuSNDq2Bjl+TyYaeKsisASY9Awt+DBStfKyaI2SEGqLMioB5UWjbEzLsWMOKCbUS9w1uqj+jsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjmYYoQG1KKO/nHMZ4ftzumlIt2QzIKQzXCgPPR5dOw=;
 b=Wggmh70/p0bmrkyuntBOOSSpusfovBPvqd0Zlg8Sj6wNh6RIt4TxeEkjDpQPiUhExipX6PfmYhXh9iLRQcPNa7q5FTUtvuoD+nVjqEvq8FBpvA21ZAYnH136+KIPO1nV92jWvRs5YrBgnj8G9ZdICUlLiA7nKC7+Id7+UHQCxEMHkGzuqaJGphngytwzT94fBvq0q9hh2Sd4oKOKfmQOVTLlmldu8ARU30UniGPkGXjausesfUild3btFgM8dNMVG7u0Zfi2hRChiN0IO8AvhcAYUsDTXnVrKCpCqz6LwlyF035Q6OxVxQfIhXiG0XKG/6zDaH4H+8Jbgif4ffyukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjmYYoQG1KKO/nHMZ4ftzumlIt2QzIKQzXCgPPR5dOw=;
 b=YesnGDZwj36uV4+QwhqBD0ioLe5Ttr99rukM3sR1FR575txw/f+7wFvGswCEjf28W9p2Efq6m7coeNZswSdog9NEmCY5zMyxkZ5K7BEWcRtshahHlfm+Wl2WNXeHhEkY/2IYsX3AesFr3nT0mjEYxGsygsZsb8pLsvDYqzHt5nM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Wed, 14 Jun
 2023 03:58:28 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%4]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 03:58:28 +0000
Message-ID: <4ee55996-e294-c1be-a81b-981e62478f2c@amd.com>
Date:   Wed, 14 Jun 2023 09:28:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] perf mem amd: Scan all PMUs instead of just core ones
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
 <20230613095506.547-5-ravi.bangoria@amd.com>
 <CAP-5=fVm4_BhZTx2OpR+FYo4GD3ZTFiiY1NR_4_XnDX6XHuhLQ@mail.gmail.com>
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAP-5=fVm4_BhZTx2OpR+FYo4GD3ZTFiiY1NR_4_XnDX6XHuhLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::6) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a025f0-572e-4712-0320-08db6c8b9c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q2IAXithT2eZ6xDZSnxdQYJTDWTwwwKyK2ql7qkcS+AFPlOl6iiwa6PnbXrubcAdE/pLMcSLHSTQqLONPaSb/5yeQmSDYqbvKMQctXMdnADlfiGDjxqwbTOPqWE85xW06eRqppzzGa2LaPPWCs/3g3r+wXs/qgiyZjVdSO2P5l1IImPanDxRE5jXRV4Dk20va+JsdZXO0gREaumzJlCIpdp3fqzXpqruDDaNpOkquYZUtEi7/SlOI3GwF6xTfaFpcRrN/L0ovVfWKOH7PNYzk37kufDdMEA9duZ0tL2bUGKI8OL1oqRsrQH3R+84Jm56Diqz4dGLlDlXDgXLbETeHHEM/7eRZHCJDcQIMiW/2je6ujCIxM0ohkYgV8ksjhi0H3yxkQGq6iTVQJOlOTq3mrIBlXnI+o3rNMPlNST5UwBQfFo4tYaOyJ9FMlGFEUl3YXtYLvVvbkqjT/TxAoVIG4ww6nZ0aMrHemV83j/AhNi7M84j9WMh590msmuMFoZ2s+Da/iTU2mPtQqjS0AmVQZA8bh9Rz3nlUVBkGbeCubJTgavt0Dha/uQ+vqGCOT78X4gSJ/iNiJlvjbxttxLdeiAlWMeTitoVflvWRMw5MNC6gaxw2QcD7Tz9HAO+1hRe2rtDoiLiC33tq/7I0z0Djw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(41300700001)(316002)(478600001)(6486002)(38100700002)(8936002)(66556008)(66946007)(6916009)(4326008)(66476007)(8676002)(186003)(5660300002)(6666004)(6512007)(26005)(6506007)(31696002)(86362001)(7416002)(2906002)(2616005)(44832011)(36756003)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hIZVRMbnZPaHVYb2R0bEVUS2FVajFvQmhzZGUxSGJRQ0c0NVc3bFlWK0p5?=
 =?utf-8?B?L0hsY1pXUzRSeWZwdUNkQlRCVEZYTi81R21Idm92MnA1NVQ2L3F3bFpPckpT?=
 =?utf-8?B?dW1uNjBEZnA4SDAzU3JCWERNVW4rNUNJNDZnRFc5V0VqRWU1TTIwd0pLdHU1?=
 =?utf-8?B?MkVzV2xLVi8reFVXb2tMb2k2WDVTUWpBYmdZd08zeVY4ZmRNQUV2RWg2M3VR?=
 =?utf-8?B?NHBOZ0xsNjE3a2VXamhKenpWblNEZWsxLzdxNWpoTnQ1RXhiaXhJYXJwTkdY?=
 =?utf-8?B?dzJ0WlZYTDZGdmlwYmtCUHkxL1VHUFhHWjZ0VHh0V1I3S0RMR3ZkMzBXV1hm?=
 =?utf-8?B?emhabzJTRFRZbExOYVNYYVoyTTVscGZicjhieDAxajZRcWJCd0phNS8yZkMv?=
 =?utf-8?B?RUk1UXdSSzR2K1RvRUZxVnlaV0FEMER6cDUxNXhkbmxTbFVodWVDaGVzQzlL?=
 =?utf-8?B?cCttaWlDMHp6NDBMQUVEK3ZuVlBvNU82Zll0VW15bWM3T0ZWVjZvWFdWM21Z?=
 =?utf-8?B?WXNnYzRMZ05qSE5FTSt4d3RpNSs5MVpwOCtUQmc0RThUTnFuMGpnTkZKSk9x?=
 =?utf-8?B?Zmk5NHJKN1BtMGhIWm4zaDBKaTQweXRGYjhLTk5RdGZTTXNta2FEOGhtNndh?=
 =?utf-8?B?SDdhNVFIYmtUUmtIZDRRUVpHaGZwN3BmZ2hBT29Wc2xMT1ZmT0t2dVFRYUNC?=
 =?utf-8?B?WjNXUWRHSTM2SDRmVGs4YVBpMHBvYjFTakJDSEZ2ZnB4K09DUGs4Mkw0NHRK?=
 =?utf-8?B?dkJuL29iL3dycWJkMng0SFU3S3k3Q0JuelVtNVQxN3lyMXRqN29HeVVQWmpD?=
 =?utf-8?B?RUYxVHVINUtmcXFncE5JTEc4aTJOYnM4RDMxVERHYnMrbTBHbFp5VWlKa0s0?=
 =?utf-8?B?T3JLY3BwTEVLcmRrY2dnSkkrMXRPU1BHV0tWS0xrODdEdDNTRjN6L2ZVc2Zk?=
 =?utf-8?B?Qmh1aW9hcmYxZUQ5R3I3eG80V3hJdTZoYWhONHNZQnhRQ0dqNTkwV2VaVkVZ?=
 =?utf-8?B?Wjd6QzhVbVRSOXRzRjBITTY5YkFTL3VlRkx2eXhUMXVqMm5vd0tFMVRqSXk1?=
 =?utf-8?B?cjNZb3JhQS9yUEgxNDRBZGZqZGJ1ZGxEL0NrUCtNdk1WSlJHRlJDWS9LcU1w?=
 =?utf-8?B?MFhFb0RBeHJmZVlsUFFtZlEzaVlUWFRITUthWEgwTklIREFIT1piS2ZZc2tq?=
 =?utf-8?B?bDVPelo1QWs2UUJxd1ptZWthZ2JxYk9SUjk4Y2dMNmsvek5TZWxicldMSnJh?=
 =?utf-8?B?dWlhZ2hMSlF1RCtJd0pLdHI1WFBYTzloRm9ocDB2SndMaGVpdlpENVZTS0tD?=
 =?utf-8?B?Q3ZGQjZKNWh0OEYyRzE5TlptTDdVY2xQb2tTNEFPTzVicU0wdGgyelBtbFNX?=
 =?utf-8?B?QmF6QzI1TkVhU3ZoWFAwMDRBaGJ3Umljb2FBRFBXWTBhZEdibi80eDhrKzRG?=
 =?utf-8?B?UUVYdG4xZVZjeXVmOWRNV0pJZTV6Y2tCRHdOdm5oZkcyNmJmOXpFbko5UGFn?=
 =?utf-8?B?ZEk5aWxFY1c2T2pGU2c1V0V6ZG84V0tkRHJmNmdKZGJNWFE5U2lpYldtUmF4?=
 =?utf-8?B?SDRKK2U0NjN0VHlYWkFGWjQ3Y1d2SXE1OSsyQml2d25lcWFXU2U5Mm1qZGYy?=
 =?utf-8?B?MUdVenI4T1pXdGZRU2JpeDEwQ1FJTFMvcm1vQVpoNlV6Z0svR2J5Sk9oUC81?=
 =?utf-8?B?T0dSZ1BuTVp0WkNuRzQrYmRoNU1HRHE5Mzd2eEdrRyt4dXJrMUtRVm5xdnF6?=
 =?utf-8?B?VUs4Rjh0YTNrekd6SVVpOWI0VjE4L1oxZXVHS2huUFg2c2hSRlZiZnhZMnd4?=
 =?utf-8?B?dVFBcVZpZDBjR2lvSU93bnpONzFlakVzbC85MTdKZnByZUEzUFZjMEdHNS9l?=
 =?utf-8?B?OEp1a1RVUnpZUGpkMXB0cmlWRmE5eE9lNWhOOENvVzRNYmRaZmhyTFhJVXJy?=
 =?utf-8?B?Zm90TkdHZVJrSDRoaXVOeHU4dk1mSm9QMVMyNzlTS1dDVmdIVHE5Tm9xaXps?=
 =?utf-8?B?WGd1UGVwMmw2ajVUQzAwWmM2N21Ja2lkRjNWU2pYOHowNVBKVnNMVXFvMFlN?=
 =?utf-8?B?ODRXUDZKL3pna1pZUkJwN3NncXV6T0NLcDE5R0s3bGJqa2ZJcDNmd2VIQXph?=
 =?utf-8?Q?KHi9aS7Q/GJAI4By7cqsuBxV5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a025f0-572e-4712-0320-08db6c8b9c21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 03:58:28.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7RgzmsbGBL3zsBFqKot5ncDr5qgAJWW3eIU4dZ1DzpLuSzJjP+Sq0652oMcxfLOUQ34LKRXdGswUB3cj6sEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326
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

>> @@ -165,7 +173,7 @@ static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
>>         char sysfs_name[100];
>>         struct perf_pmu *pmu = NULL;
>>
>> -       while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
>> +       while ((pmu = perf_mem_scan_next_pmu(pmu)) != NULL) {
> 
> It was my mistake to optimize this,

Not really. I mean, there was already a bug which just got exacerbated.

> I think we can just go back to:
> perf_pmus__scan(pmu)
> which would remove a lot of the weak/macros etc. here. We can have a
> comment as to why this is scan not scan_core, because of AMD. I plan
> to further improve overhead of PMUs so I'm not worried about losing
> the small performance win from this.

Sure. Let me do that.

Thanks,
Ravi
