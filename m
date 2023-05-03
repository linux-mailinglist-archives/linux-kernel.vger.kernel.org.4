Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7E6F532D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjECIdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjECIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:33:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA814C22;
        Wed,  3 May 2023 01:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heRn3cXuKaqASdIf2j45qr2XV2Iqdcx1Xx7/+5mG4jdK64nst6pW71+RSXnlrVxl03zQSYE2yo+dI3TaUhV4ZcS1UuR4jDzVz8KopLUw5KeKaE6O2tfgYwpFtXMy/xDq7d6BIVohA/PsjwN69Qkx9NtLfKCRc8gne3C1lui7B/p2K0slgUXcvsbw7hlz0lk14sNhHQzvftJ04HOa04TtCVyA9pWYKkWPjhDxfKrJK4qqDU7eE0K/Uo7ogBwb+YcnQIB+n20rLmjFOoXx9NCW4PzpdtHkHoQU0I0caFUUdIPrVyGhbiMBKfmZsblzrwHlNGnA8+xuRlIbdoCOr7d2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pnjje/k1M1cmtoJSI6ETYYu0BTqJvuZb+cEU7UhPRk=;
 b=g6cEK7EOT3E2cZh9cFlt1+Rf3eNnoxRK9bGvaImXayJNdUIACeUKA98/vVvy4QUFUco2MUEgFFBvBYGXx1gdxoMi0bQx9qTxBKbWA1EaofV0lsoIqtbpgsZi5jewTZBRNhfIjFQ4VUA0EfnnkiC6z+9fRy4nFYPZhqk2lFGSLE3u2c9/n/9z/8TCYe6joSQh58/CJvBuP/9ZPS2MwWCmYYU+dgCea4FSQLkFL7zKrsZheKdqLHK6gnOi8u+g7qpFuYzoW0Y5Y9jDIw2+yIXJNlFLt+rfsnF12ryPOZCVQ1K4ZSCKSsZuSFmQEb7mJFwspRdZZBkWqcVk0W6n7Q5YyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pnjje/k1M1cmtoJSI6ETYYu0BTqJvuZb+cEU7UhPRk=;
 b=cSRc3LFLI+Zw2JSceWjKsqssou/aHalxPZStDFKxk3LrTWrf6gW5ufuhsy0lUS/zKzzolCldYAWIL8RbJPDw4cKefDGhu65+nbqNe+i4lARUarPRcR6u+fTwbg+PtdaqPm+D0S9pTisaxjOggaA/1ie9re4ZqVKNHIK/Zm48grQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 08:33:33 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::b4a6:94bb:6895:645%7]) with mapi id 15.20.6340.030; Wed, 3 May 2023
 08:33:33 +0000
Message-ID: <77ebe99f-9034-990e-533e-544d75e564b2@amd.com>
Date:   Wed, 3 May 2023 14:02:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH v3 1/3] perf/core: Rework forwarding of {task|cpu}-clock
 events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     namhyung@kernel.org, eranian@google.com, acme@kernel.org,
        mark.rutland@arm.com, jolsa@kernel.org, irogers@google.com,
        bp@alien8.de, kan.liang@linux.intel.com, adrian.hunter@intel.com,
        maddy@linux.ibm.com, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com, Ravi Bangoria <ravi.bangoria@amd.com>
References: <20230425142205.762-1-ravi.bangoria@amd.com>
 <20230425142205.762-2-ravi.bangoria@amd.com>
 <20230502153422.GE1597538@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20230502153422.GE1597538@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0181.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::7) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|BY5PR12MB4308:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc512e5-1bca-4cf0-858d-08db4bb1149a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SMBwQcKlko+LHa2Dq2ODyt8A8dpsaGvAa5iSltQ6zsmg1WC1JrRAIOJCwHBTQbfAbsNdDrpsTvb5+YCj4/UO8oUJHICS0mmXX71c5t9ZN3CzJHNdyVgz/b7luD4mjIIigP3yD+H2UhPfcnS+H3+bCCHNiOFcNBrXpGOeUlVhCdDV9qO6R16eThs7CBI0elVjDuUv1kuq8Ew4kFJQ3TzqR/orBxwCXb63f4nb6HBpiLP5lmGFZBCG2dfj2rCS47GiIJHxar7206Wcc6oqccP4Jls0hZKiMSNVBjDKhiL2Af18GvoXg85NXIq2MTbcFF528v0A/V6aEUvBJV/R2he1c1qWnWve4snH65yLrKD2femRvLkxRi+qMvPZGyvnCfG+Jr01qorP3bdHjVjDOKVtGcNghUteVovN7Kg0J6mpK9cEbL+RxXuqibM7shno/zrl6lerMbKWko/TdaPO5E6KwLexySFk5ih7hejvw1VmD5ByrcN6TMHaSgRKZxxlsqxHbmyQc++NoYSPJaDrm0kKnuVNUWJuD8OFTJIlOCnaQZiS6253zEz4XAfRLFnhu1hanHTrnF8AcxUGyM48qG2b3vTxoo8Hbqlv1WGm9WIGIKm3wXcplH6RWdMT/AoQ9p6/2WnCu2bUTPZjg6i7Nx+/bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(2906002)(4744005)(38100700002)(2616005)(26005)(6506007)(6512007)(186003)(36756003)(8676002)(8936002)(5660300002)(44832011)(7416002)(86362001)(31696002)(478600001)(6666004)(6486002)(316002)(4326008)(6916009)(41300700001)(66476007)(66556008)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFwZVl0R2NwZTVsaXI2OTNtUVhJbDY1S3Y4NEd1VmNZNFo2SmxFL216UlBQ?=
 =?utf-8?B?VTg2cmlIS2FQRERyTUFjZ3JLWXpGdW54elFDTnNxbFhwTUhKQU1KZzVDUVJt?=
 =?utf-8?B?VzQ2V1JOUnBoUWo2NTVtM0svSHJEeFQ2UkR2QUo5NE1ubjMvWHlEQUN0ZWov?=
 =?utf-8?B?TXYyTGhzS0YzUFMvNko4WjdWemowbGtRcjEyUlVoOVNQSGd6cVpCT1BJK3FD?=
 =?utf-8?B?R3J1cEhOR242QUZNUzdwUlJDazNUOGRmSkhmdU9TYWNvellFTTdCN2Z4Ym1m?=
 =?utf-8?B?TFE4a3c0Um9GT2NFL0hFbDhvVlMvUHB4eEtjcmdDNWc5dHExVUNCZ0RKN2Vw?=
 =?utf-8?B?RUV6eEUyR2duTExGdnNiSjFVdVVqRzZGZEZXRjZvZU50Qk9rZFhyVVhNY1Nu?=
 =?utf-8?B?WStDTVFRS29ScUdJQUFFblBnZGFtWTRqRW1EUjZPM3NlalRWbHZTVEUyY1J3?=
 =?utf-8?B?S0Uxa25td21penN4T1lYUW5oQ3l0L3YxSjFjY0tDa0UrVzV4OERVM2xzckpZ?=
 =?utf-8?B?UDkrZ0ZSc1JzQko3cTFLb0dBQmxWMHVjdkxmTXBwZ3lIc0hNWVVSTy9vaW1N?=
 =?utf-8?B?K29Xc0llUVExN3RDOHpCQzRWNHk0UDZtbGxEd1gvRWc1UW40cU9lc3lDeHI4?=
 =?utf-8?B?UU9zeDBmNm9lY29nY2ZVL3ZvODBtRzUzN3BTYlQ0YlI3UHpwbHFMb1UycU9V?=
 =?utf-8?B?NnNtMng1NExzVExJYTJrT3M0L2pjQXloYkc5YXZ5d2hEZGszR3FlT09HalZW?=
 =?utf-8?B?QjlRaGxPb3hsdUdUZDg3MCtDcnNqZnVFOHVhcUNYOHZMWDBLYURPTDNKTCtP?=
 =?utf-8?B?NjZMU2xjUTBRVmxaanpUU3dKeTBodzg3cWpETHJWcWk4TDdma3FWajB1U1R5?=
 =?utf-8?B?NHZpUDNQb2g3dXdYVUViZnFsb1phTkhZYlN1Z2RmQ3lyZG0vWTNIUWRHdUgv?=
 =?utf-8?B?bmlOQ1JlME1yVVppbzRxQU1CTlJhbDBLOGFIWHFsOVUvVWZvMCthTlNlVUdk?=
 =?utf-8?B?MTJCVzVqWkxDRHY0OWtRRVluNTZqdDNZRGs0RDJpOTNoeWpzU0tySmU5MytI?=
 =?utf-8?B?YU0xRUluOVFFUHBGYXFlbHh0SkZvQnphYjJVakN2eGZKQTlqdG81NlBaV0Js?=
 =?utf-8?B?ZnMvaE1jZytNNFRrall0Q3FuM2VXVFJvK2Rna1pnd0N1R05ISkZ2SkV6RVF1?=
 =?utf-8?B?cXlzejBSNzcxeWZ6S3BVdExTS2QvSExYR0RJTkcxSGZCY2tzeG9tSkhVZFJx?=
 =?utf-8?B?V2VFdzNtcmE4S2hjMHZXbGwyamI2L2RYZjVwUHRkMnpYWE02a3hpeDNtS1dK?=
 =?utf-8?B?emhjditERzRmSFRNKy95eW10cHVINXZhV09TamhzbmwwVFZVb0kwVVllVGxD?=
 =?utf-8?B?bUZ1U0xJMTkwWERoZklEWTQ1UTV4Rno2YVNuOUtNU0sxTEN0MlhRWXRuU1VU?=
 =?utf-8?B?UGdQZ3VaTXFPUXo0cTQ1VnhQcUN4ZFA2Q0tlbmpiTE9kNFNDTWRyZ08rY2Zt?=
 =?utf-8?B?R2dwdG5xZHB4dWFWdHJEcmxGSE9jRDZKTjZ2aml3b0FyS0tITXd5NU5SamJU?=
 =?utf-8?B?b2VCODZiOGNWa3RHZHpvOSt3MjJRb3YwbU5KRWExTHgxcmVwR0pjYzkyVnlL?=
 =?utf-8?B?bkhDTU5GUkQzcjZzRWt5M280aXhoellydllUYUVLYTFiODVobWpLR1pCcS85?=
 =?utf-8?B?Wk5kMGFyNDIwczk5SGlKeFhBSE1CcUVIeU9rTlNxSXlCUVZLZUVYcXgzOERB?=
 =?utf-8?B?aFhTc0JLZk1yYUo0Si9ibnVqbnlWNCtPNW1KYzdJdHJVd21scklKVWxiSXdI?=
 =?utf-8?B?NEROMUNoZlVSV1lFOEU5WHgwT0VNU1hjdDhML1h5YnRrN0xjekd3VXdHYmtD?=
 =?utf-8?B?bVZNR0k0bS9TK3lLNWF5QXl0REVFTlNXdk9UbVoxMnFSOVJVbm9INlpRQjJx?=
 =?utf-8?B?b2hWbU5JNHhmYW5ZRklLZUV0OFc3Um9HMzZLbm5TQUE5VHArdGg0YXRDZjUr?=
 =?utf-8?B?eUdHY0JzNFVXWDhldEEvRWlRODMwWGZBTThqRWtIRVg5eHNUWSszeFZnR2U4?=
 =?utf-8?B?Y3hxbHFrdk0vQ3hHYkwxelFvblM0bUNESC82YkpwQVcxYzhjUE9OVE5EdnR5?=
 =?utf-8?Q?gqcjIr5KGPRIcApJyMrhB6Y7Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc512e5-1bca-4cf0-858d-08db4bb1149a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 08:33:33.3402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvLag7e4E/mDJW7Ts5oqedWCDtVE/FPyjQ9NQfsUNBomztP7B0kjaBQuNvigaIwZdhYTP+NEFetvvCANCkWNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -322,6 +322,9 @@ struct pmu {
>>  	/* number of address filters this PMU can do */
>>  	unsigned int			nr_addr_filters;
>>  
>> +	/* Skip creating pmu device and sysfs interface. */
>> +	bool				skip_sysfs_dev;
>> +
>>  	/*
>>  	 * Fully disable/enable this PMU, can be used to protect from the PMI
>>  	 * as well as for lazy/batch writing of the MSRs.
> 
> Does this make sense?

Yes! Will respin with this included.

Thanks,
Ravi
