Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1C36C52A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCVRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCVRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:37:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7264B3E;
        Wed, 22 Mar 2023 10:37:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGCf+kcCQ3VM5t8S9Gc1qfMkNbcG8ByrWG+NpHlPQulMGGhbUTcDnnKFGC4obTw3frZPxEyvxKRxt7mDUMaULy0Ukd1rRq+K/JyJNYb2W/+oY0bREapoakjKGKqNif3nNOvc0EHXhxxe1SsvrSbHsQVUfzhT6MKJoYvQa3nqSjZA9dm/TQ8cA2TOE3C9z8jF1oYZF+RD5um0yA6iry5MmmoDP/rx9DzqmAAzY9tnA7lmqNzE5KclgOoKa99rnyoWdpiI+9Zf+GM7gs+DfLFMeN6lIk/Bj7NtrfhhKO9ruukQAv+7ZzC/auh336HDXjqd2Kls4itvQC60k8YBxdv8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUiFzr1tpJlWq0nKmHW32TeLr8B/SMfqE1FBFQf/BSc=;
 b=Vy+Dfcf+bOviFG9hdOy8NJXs/qkXRpRsGZMiufqbLyKwtTpMF/USbaMtVuGYZWBJXuJXsZTNWSPj0A8ensQNSq6w4mdZ/KB9NbuOWv3Eq85uv2KJInMyQ5sCnzbPZZPImHld6qpjVzyWF0/IddEUsunEdO9GkRrJS2ncqpceVLrIBk4kI1ltoXAR11Hkx4xYfu6JMHces/7w7BaHNGUM599CdM0GL9w1BiFS7DItwjxIuUOp/CbLLB/e3jVa1H4FvnhCE9svRbXEwUTpbdkSClvAYgtUoK2z2nphikkP6F9visdHepNXPE9AfMTRY4GXaevrD9QxY29OaGEDL/JI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUiFzr1tpJlWq0nKmHW32TeLr8B/SMfqE1FBFQf/BSc=;
 b=F0rgZ8+FQqzlf28QjHieMfeEP9bTon2DqeWAEnay1bmQOZhgqR1DlFoU/fV7ADLJUPZzojjqTsM6ldKnVQXfZfStlKDOGCL1qvr5Ml/Rcetyi7BfT6uRz2jo6yt1FLhL9r2ErXtQLGoEnuMR/1tE7aqkeG6IsAvHwxdfVIn8oPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:37:18 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::d214:f856:e057:f856%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:37:18 +0000
Message-ID: <d77a3ca0-0e84-45ca-274d-5d1229d34e6c@amd.com>
Date:   Wed, 22 Mar 2023 10:37:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:111.0)
 Gecko/20100101 Thunderbird/111.0
Subject: Re: [PATCH v2 0/2] remoteproc: get rproc devices for clusters
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322040933.924813-1-tanmay.shah@amd.com>
 <20230322141215.ygicmrppqaawlgeb@ripper>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20230322141215.ygicmrppqaawlgeb@ripper>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0005.prod.exchangelabs.com (2603:10b6:a02:80::18)
 To BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d4ef61-9368-4730-689b-08db2afc1545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDqxHpuo7iyRnjZSCjP56NSwZTLBFYz+8VGL6WM9W7mz8wB9/io0UCAmYbjM2Q0FcVEyw43giuj/kG/eqsb4/9tDeGm8ZTidcfpQVC6fYX4WOYD24WuQi9ojlA7HpTX4XgHqamxIXPmHe49U4Fpc/CvMIp0/kmwLfziPT616fRle2MfsEYU2cjk/dC0Zi+Xy5/Ek+zpa5ABACrO1+zGc7n0IRiTgd5O7WQxJa6nLR3w316L0eLcFrNf4jFodAvgqOlojXLFOFR8Z9vY/sK3jG9xfUB697h7/PSr+FvTIpEABZfn8mNQAGDO03XLBD+kJJttM+MU9CsgEKvom6UMxpKdOnjCnuRnNmhZbj/84pxIAM/6UpEMbFgv84qbtDFQbTSvncfcNYWUr7xrr0Ct2RoQ6ShfLyY47YGnHgXOuTyuVN2nRw7WeNQMUGBUUGRC+tplOHBxFligACBI6NDtSUbTm67U8MvrWhnA1G+Id1Bu/Tpl5B2R99jEOWOOqW4m5yMpBylqeLjmhai1QQNjJNEnwI9aoGMHS8+i4DRlW2n16b9bImDLAH+9nS/TBr0f2xxGuRkaMU6jdg1n8m406Ynjy+2TyFiNuu42DhevSPq2TrnXU6B04dszlh5dk684Q6rXHF3lK91PqLOgK3t2z+OlMswf5Otjia5d3QKkPprWQnceUbmn1glVz0LQ/BiUXUlEmocwzMlhhJEvhjAqi1ZgCgXfdw8RPEdjWaN9A+OA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(8936002)(44832011)(5660300002)(4744005)(31696002)(86362001)(2906002)(38100700002)(36756003)(4326008)(966005)(478600001)(83380400001)(2616005)(41300700001)(6512007)(186003)(6486002)(26005)(6506007)(31686004)(53546011)(316002)(8676002)(66556008)(66476007)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FOWk55N0xJK1J4bHlkTUVLbjh5eFJpKzR6bE1jUHhFaG1TTTh4Tk0rbGtN?=
 =?utf-8?B?eHY1ekVTVURaQit1WnV6Um5OMXQwRkh2dlJob1lNMFp3VWRQU1NwdWsxOTFO?=
 =?utf-8?B?Uk0vS3Iyek5WbVU0RkJmdkV2VERCeTdUd1NzbStnNlVlc2RGOUxPY0VrOVJU?=
 =?utf-8?B?dmlreFBOQ2ZhbGRYYUJ1b0R1RDVmVTQxUEVJMDJtSG5YMkNaY20ybFNXYnFE?=
 =?utf-8?B?Tm91cGdnZHNNNFpEQUk4THFVQXlFNGwxSm5PT0RTcTZBclBUREFWWnFVN3pn?=
 =?utf-8?B?Y0d2QVIyeDJOaW1jWDM1SEpqdVU2V3gwTW13aVZIbGJkcldIRUtYYXdnQlVS?=
 =?utf-8?B?WFhDSm5LUFBYTlpTeHlaZE00UW1qQjRvSi9iN0tSQS9lOUpVYjNXVVdvN0lm?=
 =?utf-8?B?QnQzZzFURklFY3pIMVdDUDVPOFUvZzZUTWNzQWZEa0tzbGZYcW9OUzNOMVJU?=
 =?utf-8?B?Zk1nQ3Z2UnhyTzN1amY5U2dIbzBQb0YzSWdyQnZzOWdPMXBQbWV1VkZFUWJa?=
 =?utf-8?B?MVloSm1pb1VDQjJiVER0RzdqZ0FQWnIzU0FwRnpCeU9YSUF6S1NxdU4xR3Bz?=
 =?utf-8?B?Z0JrektWdjN6bXp5dE04WDROQXdvQTRhRXVNdGxFMHlLQ3RQd1ViM1k4elpm?=
 =?utf-8?B?VDR6YlFmejE4c0hBU09YaTNZS0RnTW81YzF4NWkxbEYvdkZCTmhRSUw3U09v?=
 =?utf-8?B?TUZ5dU13Z1BmTGs3UC81Y1J6cTBhTjhHcktNLzMrQzRsRVZ6ZVRzTEREY0tH?=
 =?utf-8?B?eG1OVDcyYXNOSnByVCtpZzZNeFQzQWhZNWVhS2JLb1JhbFZaWUpnbjRyWFhH?=
 =?utf-8?B?SjNOdkpvWkdKajBjQ1RpNk5uMzk0elVyaHhwMEpETDNCUkNxY0I1S3BWK3o0?=
 =?utf-8?B?a0pWNS9tbFhybStOaWRuamU1UnMyMFdzSktLS3o4NW9GbEJRejNLbGpBVi9Q?=
 =?utf-8?B?TkNMUHJvMHZZQUtPdlR1MDVmZ2NZSitUcEF0SkxVRTBMZGwxR21sRElMUVJm?=
 =?utf-8?B?OGpZcUljSVMwMzYzVHdtdVAzT2Mvek1wYnpUa1g5L0EzaE9QcDJZeElET1Zh?=
 =?utf-8?B?YTl3ZnVjTUxQc2IwZnFwSnBERVY1eHU3VnByaThDZkVyMDdtL0J5bnhGZkFY?=
 =?utf-8?B?aTlseTFCMUpFalUvYkczaEUxdDQvYXJFYUQ3VnppYm9QNnJmV1ZnS2hYWHEr?=
 =?utf-8?B?TUF0MW9QZVNJdjhiU0Q1VjVXcVBsL1BnZFlQUXE1WFhjZkt6eDZtM2pITVJ0?=
 =?utf-8?B?S2Rjb3NqNW5USytPb1J0R0NZeUZvN1RwdEZBZnF1Q2xYMzZJL0Q4YnVQWUFz?=
 =?utf-8?B?REdVSjJZR3pIRllYU01CaDVBeXJxYXczVHF5ejE5blBHTTFDem9MTHhBRFc1?=
 =?utf-8?B?Ujg0M2oxREtFdHFPclc5L1E3QTNEdGlOZURXbHIxZUMxa1AyV1ZFQ1ZnWVpI?=
 =?utf-8?B?S2N6cHllcVJyRm41ZTYvd2NERU9wWGU3WVI5OG43VGk4NEZ4WEpZOUlvQmpq?=
 =?utf-8?B?UmQ1Y3FWTXgvTzRDMHAwMWZYa2dxUEtZL0tKbVNScVVLZDZEajlCVzk1V21k?=
 =?utf-8?B?d3lPL2twQUhGcXRJd3g3YjdudS9QamhvZVRpTDg1TE1lRk9wYVdHUEYySkFN?=
 =?utf-8?B?MHMrSVAwem9ZTmhlLzhLV0pDWjRkdlhnYngydGVmZk1VZzQ1cW4xNzl1Mjk2?=
 =?utf-8?B?amZ3N05aM2dSYTAxdytPZ3BXQlhYOHZjQi9NRjltd0pkTGZGTW5KY2pSTm0x?=
 =?utf-8?B?eW04MDVMMzNsYXRtTXlCa3NtYStlNCtNeHRJbTV4dk9QYlhkbkdnQlR3SlJi?=
 =?utf-8?B?TitWSWFPaUZ1T1IvOVBFcGNZQWpaL28rSlljM3lUWmhLOFdTZ3VvUFR0LzZy?=
 =?utf-8?B?cElTRGpUVXp3ejBJWTYvUzUxMTdwNjNoWHp2YnZxSWRDdElZbTNYK1dxU3ND?=
 =?utf-8?B?TmlIWnBob0trTVBWUHJtajlrSWV5Smg3bjlrZTFVbm5mTzlQcmFXMlk2eUdp?=
 =?utf-8?B?RDlrdlZOQjAzMmMrV3hsak9FdENpS2N5REcvU1ZBU2xrVldjbUZJNGcyNW1M?=
 =?utf-8?B?eXBmUzBxaHd4TCswd2hWLzF6RENRNDhIaXdyRHZmeUxpK1VEVUYrNFJjY042?=
 =?utf-8?Q?IGOT3O57jdJpOpSiVG76nr/ey?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d4ef61-9368-4730-689b-08db2afc1545
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:37:18.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d03Va7NQqTNpXf6Zc7xNTur+Y8RSBPludKiYN0aJVOmUGV0V5zzeNKYzyfgqRgpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/22/23 7:12 AM, Bjorn Andersson wrote:
> On Tue, Mar 21, 2023 at 09:09:32PM -0700, Tanmay Shah wrote:
>> This series extends original patch and makes rproc_put() work
>> for clusters along with rprog_get_by_phandle().
>>
>> v1 is here: https://lore.kernel.org/all/20221214221643.1286585-1-mathieu.poirier@linaro.org/
>>
> What changed since v1?


Hello Bjorn,

Thanks for reviews.

rproc_put() is fixed in v2. I will add proper change-log in cover-letter 
in next revision.


Thanks,


> Thanks,
> Bjorn
>
>> Mathieu Poirier (1):
>>    remoteproc: Make rproc_get_by_phandle() work for clusters
>>
>> Tanmay Shah (1):
>>    remoteproc: enhance rproc_put() for clusters
>>
>>   drivers/remoteproc/remoteproc_core.c | 41 +++++++++++++++++++++++++++-
>>   1 file changed, 40 insertions(+), 1 deletion(-)
>>
>>
>> base-commit: e19967994d342a5986d950a1bfddf19d7e1191b7
>> -- 
>> 2.25.1
>>
