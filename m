Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81209723922
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbjFFHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFFHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:37:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93177118;
        Tue,  6 Jun 2023 00:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpoeoGXtDYscRrqAYDMjsAj4LJrRWFSkewWYdseX5aGWn12hmRSpZusjEylLbAR23eWDBXLoicjgA2TyBbfmdW8ANL0Y7YszWpejva9oKXHPWeSb7ABOWaZzPul6huDDuCqaKIqeMg1Uvd+XxumOZftLoiKwmdjnXvNrc7nmkdj9MM9xXsMLP/vjVGJlLxmxpW0gtq1gvFAoMXNERHIlRqXRaU7Cb39l8HdkZ9CSBa9N3rxW7VWgYxA2mv7IjBcsFcl5KUXJ6/uzzK8bTD5o8ilCXFIz5c50sJIlwBOWXAGASzbOMk5ZhGihMxFIHLG9SAMZa7ubzceleHO0yxjlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZAocU/kbcT+u4sJYs2D9vcBdZmZGmxocz++RhO7pnU=;
 b=DlBdoXwVjhmcrgXYCSRM4S3gSmqTWeEPPiwKcznVFkkwMikJ46O9heg17DVfaTnGhoVK4gcNoV4jSx3BONTeTqHEn6M7tSe5w52Ewo4piIS2WHqBYGPSRTzSEirF22pGSNQoBZObTUl4hUHmpYLE9Y6dUCFV6bFXsnMQQ4pQEckZAQQ3K+WBjpWW7yNzwXVOnnUooEzExforrft8ZzB5rwF4x6DkNEjy0V0z/ptM6MWjNN6d7jzq2do4wnhO2OjrRRngF32kLPg3jNAZQY35zNPrLjGNAgUTnPe7es0XwsSTOFG73QFu/HNSkFMRC6d2CmkTfhTRvQXCXAB2kxdoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZAocU/kbcT+u4sJYs2D9vcBdZmZGmxocz++RhO7pnU=;
 b=ffv6RpTnvz/ZcQcsdtIPcI8iayDvhoyxJpFbeUUT0OvYAqO666fEyaHa2pgqM1TSapD25OXNpJJvH5Ol6KX4MgOYZ9nl5ZQGJ47ia06gLDyG+6Yqp6uJ+k7TtO4MxqT6i+146w8X8Xo39NOic6wl4Fo8OxwSxKo836/uZmKdslc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:37:40 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:37:40 +0000
Message-ID: <a147f06d-aa47-764f-07e1-43fc60313ac7@amd.com>
Date:   Tue, 6 Jun 2023 13:07:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: perf: arch/x86/tests/amd-ibs-via-core-pmu.c:47:25: error: 'pmus'
 undeclared
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-perf-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <CA+G9fYtVYhyCtD-ExKj7tOJbj9nykxkBs7dxHKo5v_H+kqG1Gg@mail.gmail.com>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CA+G9fYtVYhyCtD-ExKj7tOJbj9nykxkBs7dxHKo5v_H+kqG1Gg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::17) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 598dd88a-fe1d-48e1-af48-08db6660e83a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GMy6bjwCnkLQS3SIMinvDZHi53zXh/t/UrINohO2ZvXXVQchPgT48xnn2/5RGjQUMAUFzaWndbVdy64Swy4ZaHbyAoRixgOpEuHg+NHRXGx2rTXUUjvCy3gj+5Lh02vXx6Ac8SxdGLUQ2DDBho68my2MZONNveiZ4KJFc1SAgOrveGMs2BuYSwJJ4TMqOnYKZM0zgOZQ+v/NfDIxV/B1lTprUs/MVkHYkzj6JujTmw6HmjR+Uw/fp6quYGfwr5sdw9sk9hAHTAmt1r3SmQlsykb/tWOKyAkE9eF3X9AsyMIajM+ADYWu/vplXPaCNwkJNyK6hssexq0Ah3FGXrnKWmFnwjs8IGDJdl8yF0k8EylxQAo1n+l9vRnDEjPpuQWiAGWTZkS1vxihmOMpCE7QiklJP87f00ZqPmWwjzVleO+07MXL5kKeU1ncB5LQpIiqWVPQNvg+7O93vCFUY5/ai9qzScH7v+RP6gcHvA+nHjc28+xDxQOabfbJxp6puU254PiF/gTOs51CI/NprFLvzYhH4tndWaXyQUjvz29DWmWreV2RkFoBNbe6wPmrcVa8sJ9eisP3XVkyQwYmE2AXrVBhWAUVhqI1MAZT2WvWaS7wbOcJ8oGzKesKZTo0an1s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(66476007)(66946007)(478600001)(4326008)(31686004)(2906002)(316002)(8936002)(41300700001)(8676002)(44832011)(110136005)(54906003)(66556008)(6666004)(5660300002)(6486002)(6512007)(53546011)(6506007)(26005)(966005)(38100700002)(2616005)(186003)(83380400001)(36756003)(86362001)(558084003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1RUeVc4bk1NTS82dHFSd3JIaktCcE1DZE9FNzVkckQ1dzNxVHRrVWZhWlpS?=
 =?utf-8?B?K3l4ZHh3bGswM1RzcytnbkZuN3Y2WjFVK2lWOEM5Q2lZVytNa2RTb3NWK1NW?=
 =?utf-8?B?dXRnWHpwRWNSeWt0NklKMzhwVU9XbEYzV2R6dTVydVlIUE5rTkgzU0xlczFN?=
 =?utf-8?B?NkM4NUhvS01ZczlsSUFwTkNETjhGZ3V3VllFbVR3RzF2OHcrTzl0bnd4UTRG?=
 =?utf-8?B?Vk9CT2JiU1JnYUNyb1d3eEdoOURJbWx6WThLK1J5cWVlMnJGOTZMMGlhSnhS?=
 =?utf-8?B?d2VqVVR5dnI5WnlWdGltNFQ0akM2TmM1VUxOSWRiemFSZGlmWWN1NGZQcUph?=
 =?utf-8?B?OWlDYnA1eFZ1Vnh0WFhLRy9wWEY4NjdDSCtYUEFtNDBIQWpwcUdtdVNSR3kw?=
 =?utf-8?B?Zk5ZdHVsVXhoMk9JTE1BMGZLY3VJUlpPeUFPWmpNc1dWTHcrNEpBQ2c0NzFQ?=
 =?utf-8?B?aTFzZjgzdThScGY3RGtLeE5Ka0pPazhjUjBKblZHM3pUY1hQOVlDU2hsTmFs?=
 =?utf-8?B?VFJEZ0lheUFWOEF2TksweXE0SlUrVUx0ZTJxTW1iUjY2QmZER1Y1VU5QWnNP?=
 =?utf-8?B?RE5kclZsSGZNWUJFYXNKMkR4Kys5OWxISmxLcjVOdUIxOGFnamt6OG5KcXZ2?=
 =?utf-8?B?WXNuQUdTTTVjam5GbVZuL1dBR1FBN296Vzd1Z0NYTG12NjJtQjRBaG14SjZU?=
 =?utf-8?B?TCs4RVVLNllGUy9BaGlIRVJia3FSU2lGV2x3TUpGUFJWbXdGS2FVbTB3ZkpN?=
 =?utf-8?B?UlpUMVJjK1VaWEdBSUE1V1ZteUVEQnlNa3BUTGJ0cWg5WkhTdGpYN2ZidWFZ?=
 =?utf-8?B?UjZUYS9hQVJ6cTVlVSt6SzFDdC81VjVTWVB5Z1F1RXRKZkV5enhjZzE4b3V5?=
 =?utf-8?B?M2JYNVkrU2dpd3BPemV2R1FrRldvTzNnQlNRNVM2UFVCTjQwKzBmbXUzYWdj?=
 =?utf-8?B?d1RmVGM3S2hLUnBibUQxOHRjYWVFOVk1TzhWUGNoeTh2cGswenk0U3hKQmdN?=
 =?utf-8?B?NUlhTy9CZC9DMXlrWEMzYW9oelJDRUNqQ2g1blFqOFRUaXNHeGNHS29UZWJQ?=
 =?utf-8?B?dGN1ZXlkem04alBSeFY1aXgvcWdtMUFnUkh4bnJRdklpQzZoMHhDdENBY2Jp?=
 =?utf-8?B?R0p1eG13RERVTU5ZcUozdk9vQWlhd0RySENGZkpQbnM4M1NnWnNQb0VIZlFz?=
 =?utf-8?B?Z1k0WjdEcy9Eb2VsbUFIQnFuSnpsZnRhcjhQaWd2dWhPOFVjSW5Yamt6WXB4?=
 =?utf-8?B?ZktNZWYyY0gxUmI2YkhsTmFpd2JucVgzQkxyQjlncTZmTURRN0luNzhNQ1Rt?=
 =?utf-8?B?aHkrNzgrUUhzYUU2RXZYWkxmR2E4Ukt0K0JvMFp0YmNDZ3hlV3pjZlBYRWxD?=
 =?utf-8?B?a2hzdmtrOEJERXVRaS9zVEFhakZseFowbEp4SGU2Yi9iNEN5d3ovWmtkVExE?=
 =?utf-8?B?RGEreHR6TlM3RG1ISmpDOWdibGZyeXJhclhUTWZsY3dMUUdaOUxNcHF5cHBq?=
 =?utf-8?B?SzFtaHZScDVmZk1rdE9zUzV3a3NUYTJKd0xkTGU4T1R5aUNDR2pkeGYwekNY?=
 =?utf-8?B?akV4Q0xGMzNNWmlZYncwaENIZURNV1lMU1Bsd2JWNnVyTHJZYUxETGEzR2FN?=
 =?utf-8?B?Ri9kSHNBaTg4Q3ZvZGE1QjNkRnkzMGxQTW9hWCtzcDRzMUJPYjAzZUtGY3pC?=
 =?utf-8?B?bDdGOG9iaERoSUE0Mk9Nd1hPYWRSa3ZuQ2h0cXhKWm8vdkltekFpNGhNUml3?=
 =?utf-8?B?WlU4Uk4rYXhCN0lDV0xsNjcwN2pLSzExR3N1UUpFMm5USUJQNnlWcUZ4OW5j?=
 =?utf-8?B?enNFVmx1bTJ6YU5CcWZ5SG5EdmhBOHcxQzdFdEpjMWpzOXFvWVZyd0NQYzN1?=
 =?utf-8?B?alovZXhWK1BGMFk4dW9CZDMyKzgvMUtuUjc1VE9tTWsycFREUGRBZGswL3BU?=
 =?utf-8?B?Vmt1WXVPUUdLeE9UbFpCNDZiWWtEWnQ1NkJNbG1DT0RmekFYbHNDKzByQjVS?=
 =?utf-8?B?M3JOWFRTM2tZdUdYdGxiS3BEeEg3NTRrMjhaeTA2eHBHOVhLNWlYdjRyK3VG?=
 =?utf-8?B?Kzh1MnB1NnlXTHYyb2JRTFBaOXBEbUJNcS92VTlUV0RCaEpOWnA4bmt5a1dP?=
 =?utf-8?Q?PsHpA+irgdKjQqrkEyBgixhVc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598dd88a-fe1d-48e1-af48-08db6660e83a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:37:40.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+PtD9FimlRgWvQICcHHYiqOf4bkfYWXuUsw/S2q3jLkUtm3UwU48JjiZRrAai9rh5CODh6j1pCzh4Wa76Di0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546
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

On 06-Jun-23 12:19 PM, Naresh Kamboju wrote:
> Following warnings and errors noticed while building perf x86_64,
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thanks. Here is the fix:

https://lore.kernel.org/lkml/20230603044650.286-1-ravi.bangoria@amd.com
