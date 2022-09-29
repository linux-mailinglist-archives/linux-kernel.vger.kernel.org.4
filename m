Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D15EF079
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbiI2Iai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiI2Ia1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:30:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFE2DA96
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:30:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW8h1U9R8BzzX9JSU4q6fIhsM/TsThshD406c+P4UEsCitXlft6ZNAbJEGpYBpVrPKnJCoKQZ3qUJ6ATcqrvT7T0CbPDo82cFenDbj3O02Vz25nDkw7Xo4krEvvujE+PfsYZJFYnJTGCpf5AfOJxwAs92Jqr/8n8fKz9VpWqRpyfNkX7JnB7ndxEvRXh+5iimXCeqi8KY8xrEHCLkIAx6rCGlVNNiB2qHOlhWEjqH4a9QH8TiWEGlFMcxB4zXLh6+Mn92XClnh9xxXpF2FgGzPbyHkITnU0Rol3DWAH3H7O/aKG9vUeKuLKPbKAIiBVP7AXanP3FtKD9KM6VWg9oyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOH2OfCFE/F8nZvKbF0paMuMseLntjKg8S/jIZpUjFM=;
 b=fI2vgxqnZ4URQl5JPS3euF9sqe/oDw0yUbsR6QYtVuw5z+hjwqIAk6HYQMz8zFz82vIBhrjFoThzM0kZwoqR1vtOWefeJwE0e2hYmB/Vau7c6X4z4Sqyzci87pp3+oExj6oJewFsje3/g383M+nnEg7oY5Qz+66Fg71MIkI2kxjliqmjfF/lw9eUxmWdFebifnnLsQp9iAhEWzsRrjjsgtIAtHMK5fBzdfPr7pWnWnEs3WSNTwtQlxMkNYMNXU0T9zU6ueQbIFtk3veE52J6QfjPReeDrx9+qk8VJKRgzPEbh+5xqilnbOHOXxFOH01XXPCqziNVEATpuH8xTv1FAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOH2OfCFE/F8nZvKbF0paMuMseLntjKg8S/jIZpUjFM=;
 b=aAGclCmVkAACVR8uevRjdIFu8BBJTCWlQYSIcxQwlicObzuMmR3ejP8egyPhYFyzZnTLixph74GKPheRWAFDJ2RrnmnvkghCSSXtiS/DV6qyOOjmwmkw44TtT4i7A113J2yFE78GVm2LAgUSfNc3VLmFv0m2kkhMtShWIaX2ydc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Thu, 29 Sep
 2022 08:30:20 +0000
Received: from PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::aff2:40f5:fbfb:5f37]) by PH7PR12MB5712.namprd12.prod.outlook.com
 ([fe80::aff2:40f5:fbfb:5f37%5]) with mapi id 15.20.5654.014; Thu, 29 Sep 2022
 08:30:20 +0000
Message-ID: <388f2491-3b66-50ca-6f65-b5003bf3257a@amd.com>
Date:   Thu, 29 Sep 2022 14:00:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/2] perf/x86/amd/lbr: fix LBR filtering support
To:     Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, ananth.narayan@amd.com,
        ravi.bangoria@amd.com
References: <20220928184043.408364-1-eranian@google.com>
 <YzVT/TQtkoerDPFV@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Sandipan Das <sandipan.das@amd.com>
In-Reply-To: <YzVT/TQtkoerDPFV@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To PH7PR12MB5712.namprd12.prod.outlook.com
 (2603:10b6:510:1e3::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5712:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: db00e779-0d7c-4dad-9e3a-08daa1f4d808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWXNNro4VjM9Ro3HvICkGGXHwtBFjLbeThHJcKsDwZCdkx4f7Z4Kym36lbh0BLQCZZRY2j8PyATwd7xfAZfqOQAfRf2OPL0G/bKIWp/8HjSUnr75VhTdwdTArGA+4RrfpLeT1Zu9rnvFYuaYd+XNoUqc4VZ344BUOFNerho4c6iuGfJ149++hwDCrVHxU3MwPWAGHz6iGUWF55R5/HIZRg7MH6wtI5SVX/xHbe+u/f2uxAcpZ3BIFBjtqIVEdQKl9vgwFeYZcJdDS39PCo1/Qefz8GYg3sSzOgTgYqEHYQSJsBcaIngXTSPj0LZz+q+q1Bdl1YyKa2ZWuiGxGq7eyhfCOPqbn6U8qZCKSOmYL3seW8Vw73bacUqmTicPHPU0U0mSeGSeIVlsbx7vx4jjAb3x5IYu5suu4S6ZFU0fN/WfWYpCGAXgrcc3LYPBpSyHZyCMKGK/Vs2pHBpQNI3hVNV8nWEh65CELu3+pDCDjz68IOeqVbQvD3KhUNOXHnCE+VXC0SVTMYholjPeHhh3V5j2rjnfmfV7YXcrZsdnVkUPlHiv70Zcn/sIo/XoPzBVFfx3nKCFCSa9cM0zV1SYUzjNqVzCeREPeL1dQfWmnGBzS5SGDJM0GUEiKnI7CmYlRhXhKtVYOPWJ7aphor4RAoYAvHXY4+r6LusFbCoPiWsi4IyDstwBJ66AVeYMIhRb0B+HBsvYaDZbbQ+/7p4WVbP+aaprAZooz0yNFmNLxqQmFen8i5SdpVUQP8bYsvFzHJKKvhBjpEtSyYYJBpd+6AiQGYb1/Lajsnp4VujJBvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5712.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(451199015)(4326008)(66946007)(8676002)(66476007)(83380400001)(31686004)(186003)(66556008)(26005)(31696002)(316002)(6506007)(2616005)(36756003)(38100700002)(6512007)(86362001)(110136005)(44832011)(8936002)(478600001)(6666004)(6486002)(4744005)(2906002)(41300700001)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUt2SlFId24yUUVhMHJhT2JtSHFHNCsyWHViOUlRT21nRWNBL2Qxa1BrUXNK?=
 =?utf-8?B?S0w3cCtCY0lmbktsWnNvdXVOVURPWXlQakZrdVdMVmNjVE01bDQyRld0OTlI?=
 =?utf-8?B?L2pXWDBwd0ZsWTVIWG9ydk5RTnp1azk0dUgwbXZzN3E3MmVrUGRMVEpEZWJC?=
 =?utf-8?B?OFRxMVg4Vnc2UU9TY054OWUvczNSUlZ0UnZFd21oaWFzWkRpRVhDdVBXQkx4?=
 =?utf-8?B?SjBhOVZXVkk0YnByOHV1MlhSTzRGYWgydFNqWm01MGpkdnlRRWhzWnk2Tmk4?=
 =?utf-8?B?cHNTMzFLMUhtMjBxRWZXL2RHWitlak1wTW85STEvcDA5VWk4aGhGaXhmeUgz?=
 =?utf-8?B?U0k1cnQrejJvWngyblRsZHdsRFBDZjk1SjFhUXpINHdOamhzODk0Z3JxOTNN?=
 =?utf-8?B?a2pRYXcrQ0dVVHZMd2JWUjVjcElIQWZHSVdGbmVLYzJWa1lwRTdBdXdqVmpo?=
 =?utf-8?B?dDlFZk9UMjA0dmZseCsvZ3J5WmV2aTBCMmF2R2FtRjNiaHNpV1NyaHZ5Uk9I?=
 =?utf-8?B?dlpVZWMwWmlSTUphTVp1ZG5DdWwveEhPc0dLYW1RMUIzUmNYSVQ3SnBHUW9Z?=
 =?utf-8?B?OUx5ZDJPdXVKcjFTOUM0NFVBSXdHVXh4di9aRkVrdEtubk0xVGZ0by95bUg0?=
 =?utf-8?B?R25kSGVTbUpYb1dSNnpCVjFGS1dQMG9pUHB0eDVnYWNpZnJrKytKNTNrb3hm?=
 =?utf-8?B?MWZpbTk2YnhiMVNoREt4UkxUS0RXeDdEdDlwL0ZONS9kZlJhYmRaRVFOQWRK?=
 =?utf-8?B?VUpwRm83VExJWTcxem15cURZbVZ5UGJ1c0NQZElJZUJqLy9RV3A0SlVUT0RE?=
 =?utf-8?B?cUsyRDduS3RsMi91bGNNY3pSemFxMXZKZTBPMzdvVFE1NXlFdjhQcHdsOFY4?=
 =?utf-8?B?dmVLRFM5TmM4aTdjT0ErVDE4MGZqUTU3R3h0TFBQVENKT3JmdnNZaW9KRkU1?=
 =?utf-8?B?VTgzN0FMYmJFcEFzQWhhZ05zN2x1VW9sSnJDNEIyUlpLYlIwbU1XUXNnZEYr?=
 =?utf-8?B?VW1rZTlWMjZHTmtxRkx6RjBiL0pHWnNMWXpjT09Ydi9zOHhpRU5ZdGYveGdC?=
 =?utf-8?B?QW51STQ2OUVHUWJoOUlqbDIwbXY1MG56TzUyUml6TjZyY2QzRkRWVWtiNnBN?=
 =?utf-8?B?RXJCZnR0TGJrbTI2bDhKRWZlTlRsR0k1WlQxQUUvL0t6SEJPZ0QzN05tejBk?=
 =?utf-8?B?UWNVWVlQc1k5a2NBaXFZVlFuK0ZEMVRLZFJZRXVZTUxxYlJ0eTJ0aUo2RVRN?=
 =?utf-8?B?dTcvNUdIbEZ5WklNU21qbENKcjYwNnZDMXgva1pLWUxJckcySWVtWkJaMUxW?=
 =?utf-8?B?WDJYZFFUTzlmNlJRdHErdkxTSjBZMlAwNTBvd0pRdjdwS2FrOGh2YVV6RHlk?=
 =?utf-8?B?ZmxKdHVEK25JdEVpMENuU0NibVRxcDVzRkxwV2pCemIrQnFFdzlFaUhDY09C?=
 =?utf-8?B?WTFsdWovdUorV3o4ZUpSNklMRlBrSDlNS0ZMQmtvdFlIK0VGcG9keHJiYnRZ?=
 =?utf-8?B?ZlVHUHpJNTRHN1pNSzdPMzh4bWs5bTVWSTNUVDNMMldVWVpnaTdQTVlkeUp4?=
 =?utf-8?B?eXZOT05GeE1SN2JQVzBnZC9VNkEwNStZc0IxbEJ0RFdTK0FsMWJlckRpVlE1?=
 =?utf-8?B?QmtlZnpCOHh4Y2gyV1ZqNXNQdHRQOVdtV21sRWZiTnJoL0lOMnRtYnJXdzhV?=
 =?utf-8?B?Uys2N25rQ21UdUtFTzE5OHV0T2ZqTU9heHhuRnMxSFdYVm5KcjZpYzlRVVlZ?=
 =?utf-8?B?MlloOGVUVjdUbEN4S29PUWFtaEdJOWRsZmxHTFlydUFzMjBYbnZlamlCbGpK?=
 =?utf-8?B?bmpKZDZhTkdjTlJsUzBJc2VBdHdRTVNpemU4SWMvUlo2QW1DUzlxK2NkUmMr?=
 =?utf-8?B?ZlBKOHkwTnh1dnIwSmJNaDRHVTZBQ0tTL2JxYzJyeUhsTjBRK3dxeGlmZGZy?=
 =?utf-8?B?bDFIOWhWOXNDVTFiYjhSUy9neTJ3K3p5QnUzclNHT0RVWHd5Z0pYRTFFZ1Jx?=
 =?utf-8?B?dUNKR0NlZ3lkU3pQbDNUSGhhMytib1k1dWxxeE95RTh3NHhubkJoNkVHeUFQ?=
 =?utf-8?B?Qnh1blcvTTltSm1aMUttaGZFYXRadk91NjkwZXdjMDd6UXE5Q2JDZjcxTzlJ?=
 =?utf-8?Q?SsMQ4UlOSpxPcE3ighvRwpdzs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db00e779-0d7c-4dad-9e3a-08daa1f4d808
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5712.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 08:30:19.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4G5WzZIHteYXfXwS/U0ixVwcSTuICMzUJoQ6Vox5gsOcqqetmTyJoCk6W+PGyWis/m9DKxwn7SEe3ZpS/nzDUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2022 1:44 PM, Peter Zijlstra wrote:
> On Wed, Sep 28, 2022 at 11:40:41AM -0700, Stephane Eranian wrote:
>> Short patch series to address some kernel issues with the AMD LBrv2
>> enablement which were introduced in Linux 6.0.
>>
>> Stephane Eranian (2):
>>   perf/x86/utils: fix uninitialized var in get_branch_type()
>>   perf/x86/amd/lbr: adjust LBR regardless of filtering
>>
>>  arch/x86/events/amd/lbr.c | 8 ++++++--
>>  arch/x86/events/utils.c   | 4 ++++
>>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> If you want this in perf/urgent you're missing Fixes tags.

That would be:

Fixes: df3e9612f758 ("perf/x86: Make branch classifier fusion-aware")

and 

Fixes: 245268c19f70 ("perf/x86/amd/lbr: Use fusion-aware branch classifier")

for the 1st and 2nd patch respectively.


- Sandipan

