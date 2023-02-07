Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B3E68DDFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBGQcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBGQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:32:44 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4230C4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:32:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9zIqUjUOxBXwxXjqetVT6YbO3wv2wSJos5UpnIovpxL2Lqc8QgdAI7exQLLNOyC4uRxCbwWke0qFTiMnMLGm6GXtpOdMODbmo1LDAM2MOHgz5jy8xEB1Zyvs/LlkSiTYz9+66RiQsSmEbk1ZXfalw34y3r2ONNKi1B5rmEr921Fw+6j9ycVXk3D9vbHh1AKEQ78B9UsBWxTocNpAXjKvCWuetc8lZlCNOP8zWt6NXbpT7/xTr4gRzV+jMuJxsgaNLUJ8/g6bvG5GfPH8Fpop33O+2mKMOvii43dkHCle9rakSouLjidkcIQIh8D19HzdKMEBUtaqHT8WbO0rY5muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ96DHChzH5a1Ixemp/BTDj5gkgK8Ho1agFvUIzLgjs=;
 b=d2VhewEB+nDwMSfOi3u5Dkxd4lZCL7xokA9skgr87Xx/V+g+Y564duW3j8fYzOqCkB8mEOvy9+Jl9dzePiXBHr8TWVrRsfY+NdM6gQEgYYdFWW5h5GgLnghDUDJFSy2FDDCPw1iSwRBDw5kXDSSssqO8t7/im1FSggP0UfZoXXytbvTwGEWBv+ydH9PnrLyT828WqtIAtoUkNeaUfgdkOu8+0nQgleDWoqgJdLJEkpDos5I9umh/xlWOQpeGZamV1UaG2J5X6NQuhp0ppCfMPS6u+A9LX2Ned6xCnrM1hiploYUtiKnNaG+Xr2UJzhR2bh9RJo1RK+QHZ7VDANbMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ96DHChzH5a1Ixemp/BTDj5gkgK8Ho1agFvUIzLgjs=;
 b=B/q3ChV6WmDyQG0k+CvVIRmHM7GEpy+AUzQSQtFV5ol7tmHyQrplgM5LxCbR299uoBBdXhRCwJRzo+U2CPCFfcnAx+eoXrfKH1vBQHbBGwGvn24yHr2GFJt5sf71gFu85L2r129CVz1oobsGNFLl9rUshesPNfzTMceVN17TDYuRbog878dP9I9yuHjfMnWrp9IIAo7shi1QHeJDswhM6qBQdJT7XmnW0YEkmx26OytjbUsLYkjxeNLfJ63EHyiISHpjCL7/zLP8urEStRVtkiQADqiUj9Uvl+idVy/W8vBZHDV91fose2bHO9Kt+sFIubLlXjngOH1qE8xpkChuew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7203.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:609::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 16:32:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 16:32:40 +0000
Message-ID: <acb79609-ca85-dab4-c4f8-6f37ec279d13@siemens.com>
Date:   Tue, 7 Feb 2023 17:32:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] scripts/gdb: fix 'lx-current' for x86
Content-Language: en-US
To:     Jeff Xie <xiehuan09@gmail.com>, kbingham@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230204090139.1789264-1-xiehuan09@gmail.com>
 <CAEr6+EA7L68kGPW43YwDOhpBVMQhJ0WNbMEreNFpz=8Q=C_S+A@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAEr6+EA7L68kGPW43YwDOhpBVMQhJ0WNbMEreNFpz=8Q=C_S+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c00673-54d0-46eb-e7c7-08db0928ee20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: do3GpjSi/w0QRKGx0xIkDD5bRtBoHuhWJPaYbc/koL6kHxGXnBvrsCvg86IxCkiW6bzxYJZZZz5yP9Fr+L/k7EHrqE+JLKOJa1yWZsBaf4wjNso74JIcCHW/peZZfBGKEQhrUVU+8OZTPAmw0GNhmc/Xqgy1Q2W0QL2hcVS2YZievhoDLfaOgERXNfByEWQfBPy8nBr6f50iNvHsfqvqJjXlJ55sjWg/gGMRiPN1vWQ/WdJPi3O3tVdEe6xhFILf/tWc2nstKm6zKTpYOPrh3xRN1BmEwGiogQvm/yySa6S2RP0aBnndoKUz1HbG+MQ4R4Ko1CrLEga4NxY58hTmTg8DU+p18zFi27vZ+HcqykcznFxwkit0LBa0zePUY0yt2bjVS87chkXPyIOPPHUg5t4nun9Rf7WNpbCDDXZU1KGodQgLJszxrdcf7osXd7nu0X/9kqj2bEVN2d+4x74z+dqy3qM5hwni0tJaLu8xKhy+2kUD/LQDLJpSBpF5HIJrOZYMzj0tPci5EywEz8tZVCYucqRL3pvIpmHf3KisDs4sb1QvSxxQsa2s2xYjOTAGoWswQbZJE7bNEcVaYJG/8gPMk+ymde3zKMLytbjC7NX2CteEm1p0jzBAxvZkU9cMTHkpWPkpD59BYWaom1eqtLhPcG4Uy9vrCP2e4V77c3EM5se1qkCPfdAJLNDkOAZpEx0gjuSyOtpO7i/lshq9oQJD9QJZgPg9Xn/ZpdcrIxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199018)(53546011)(6666004)(6506007)(41300700001)(86362001)(8936002)(66946007)(8676002)(66556008)(66476007)(4326008)(2906002)(31696002)(38100700002)(5660300002)(82960400001)(44832011)(478600001)(36756003)(6486002)(31686004)(316002)(110136005)(2616005)(26005)(83380400001)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHlBUGdNS2xIbXU1SWtsUEU5YU5meXRudWZGSUZMeDE1bGhoMFp0MmxnUEox?=
 =?utf-8?B?YlBvVVZyeHA5T0VxTzZCVWU3aGJEdFRlb2F5TEw3aVhSMVVJeEtiRWtUeVh5?=
 =?utf-8?B?RUlSODVqNmJsR3dOclVMY29jNUs4V2xxZFpaQWZ3T2ZhRTlxaHZrSXZrZEJK?=
 =?utf-8?B?Qjk5UjVMdHFCRDlyMkwxSk9HQXJRcVVjMUVXK1RmckpOTFdXOUNkRWtlWnN0?=
 =?utf-8?B?M1M1NG5KWDJ5RVhsUlJHVW1pRFNuMDB1ZTdwdkY4Z1F4VjZRaEg3V2tKaFhE?=
 =?utf-8?B?aVRPVzVOb1BLcUJqWjZSNGFHVEpQNS9FZGVsMDZnWENIWDlrSFB1U2FYUEhj?=
 =?utf-8?B?M0V5WmhQOE9lclg3bXRGbE1neVdVc3RoRCtNaldYc1RGMTg1NGdETDdwVVM2?=
 =?utf-8?B?czB4VkpDWW0xalh2dUtOTS9pRWZjWm95bjlqVEd5SkZveVJzYUU1WHptVEpx?=
 =?utf-8?B?NDdwOHY1emhJeFp6alVNZlJ2Y1R4dUZEcXBVRHR4V3VkaHY1WnBnRlA4bUMv?=
 =?utf-8?B?ZTZTM2RXUGZOdVdsWE5kV1FacTJqZm9wZlNtOUdkQmtWTG8zekJNQmVJTlFa?=
 =?utf-8?B?ODlWYW5GaTkyTGZHZ20xOS9BK3N5WTJwOFpiVzJFcExOUlU0UXkvUXlmVUZS?=
 =?utf-8?B?RTFiZTZscXBnYzBPZi9vK0VxTTlpM1Urc21DSDR5L0tHZHJDWVN3bHhQWXlm?=
 =?utf-8?B?dXhkMDh0Njc3cE1rbTF1a1BGL0hFU3FMM3NQTjdKUzJZZmlYN05IL0NNMlBW?=
 =?utf-8?B?NFJyNGprR3Z6WERHTEdmWUljc2NNUDh0ajlYcWRxM0lLbEU3eUhxNjJTTnZE?=
 =?utf-8?B?ajZpMVp2ZFdrUzBOcDRnL1M4dEhUa1p2UVNpTVhXWmFkRXRTSlBUR1Z2ZGRm?=
 =?utf-8?B?N3BmeGRMMHA0SlpVeXAxZVBVb1FvODJHWHJrVFladUNyL0pQY0x1dGNBS00z?=
 =?utf-8?B?cDRBVGhaRk5Gb2h6Y3ZheXFoQytDVCtVV2tWT2FFT21zQ1FhejJ5dDhzMUMw?=
 =?utf-8?B?Y3l4MlFRdk4rSGVtMldIeVhyazF0SllkYllmU1VmaTV5RjZtays0UFZ2dHdy?=
 =?utf-8?B?Ry9WTWtCVHh4bnkzNmcwdFlXSHl3Z0ZjdmZ0NXllUlRkNGExMzVrenRSd0xq?=
 =?utf-8?B?RllZSEZKNHFMaU4yaHhWczcrNlFwNUNrOURmUGdrK2EzSUw4cTZZQWZ4UVl3?=
 =?utf-8?B?SFJ0U1pVZ2Ftc2EwWVg3L3ZkeXNuQXlRNHNGY21ja2h1RkJUYW5KSFhndWdG?=
 =?utf-8?B?TitZZU8vTnkycXIwTEllbUlCQ3Q2MHQ5cFNKQ29EK2duMWFvclpKZHpmWm5X?=
 =?utf-8?B?ZlBYNTRJVGVPT0ZzVDF0T3pEMXI4YVBpQzNtdWFhMDZoUUdHWGhmajNrRW15?=
 =?utf-8?B?NkR2VHJpbTdGT3lkNDVyZUlXSEIxbktVM2VPYU40aHQ0ak5NaW4yTHU0M3ZN?=
 =?utf-8?B?QUJVMjcxekxadmhWQ2hjVmFDRU41eU1IWFplTFhoMHNCamVJN2FsdCtyc25E?=
 =?utf-8?B?aXdSK0ZHelp2Q056SEx3KzVaeWdvT2gxcDZndzRTRUJJOFhtdm9BN0lnTHd1?=
 =?utf-8?B?dHlpenJTVzkyVldHQXBxZit2bzEzY0pVK3ZnazVLRWhaSy9HeDZXTGNTSkdk?=
 =?utf-8?B?bjVSUEdJOUxWTW9rWVVxN2VPU205aFRTTEtwL0NwYWhqVkwwSGhmdnFMYWhM?=
 =?utf-8?B?N1Nwd2cyMXliNzVab2hrWEFoMzlBVjYrOXdZa0YvS0E0RUVhNVRXbUltTGdy?=
 =?utf-8?B?bkpBTnVvZDdMSjdNZVhKOGIzMWhUbDJaSzAzdVFZT1JlVXRrKy8yTHFOQXBi?=
 =?utf-8?B?Ym05ZnNCaEpqb3FPcFBpVDRMY3QveDljZmN4bjdwci9RTFlzZnAyd1lPN200?=
 =?utf-8?B?dTJYM0dVSEtTZWFIOVhPUWpseitqYWVMZXE0YWN4REtvZjE1Qm9OWFVaRDFV?=
 =?utf-8?B?YXd2c0RlRHhxaXVhaDFtWHkzYTdtNXBtRHVFSjdnenZoRlJ2ZTBBQlJTVFBk?=
 =?utf-8?B?cGIzaTJlc3VkYnk2azd2Z3VYaTVpdkVyNW5zYWtWdytMcHd6Qm1ZVnVzTVZm?=
 =?utf-8?B?TFh0dmduN0tCUDRUeWtnbGdFR211cTVHWnpINE1laG8rVCs0ZzRqU0g1Q1Nt?=
 =?utf-8?B?dklWS3BnYUFaUGM1NGRTMi92WmdITlEwaGNyRVd2WC9OcEdqbEhFcGxsSWlu?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c00673-54d0-46eb-e7c7-08db0928ee20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 16:32:40.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywPn8hhXDWBW8y5sTIjpuYOAr9lo+QiiPZ0tPo17+TTnGA0WU27xV0QwR1godBKpOqZ9WbPA2kd3CHm7lhGs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7203
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.23 16:48, Jeff Xie wrote:
> Andrew was added.
> 
> Hi Andrew,
> 
> I found the patches for the ./scripts/gdb/*  were merged by you before,
> but the "./scripts/get_maintainer.pl ./scripts/gdb/linux/cpus.py"
> can't find your name,  so added you.
> 

Yes, Andrew is merging scripts/gdb stuff.

> Can you review this patch ;-)
> 
> On Sat, Feb 4, 2023 at 5:02 PM Jeff Xie <xiehuan09@gmail.com> wrote:
>>
>> When printing the name of the current process, it will report an error:
>> (gdb) p $lx_current().comm
>> Python Exception <class 'gdb.error'> No symbol "current_task" in current context.:
>> Error occurred in Python: No symbol "current_task" in current context.
>>
>> Because the commit <e57ef2ed97c1> ("x86: Put hot per CPU variables into a struct")
>> changed it.
>>
>> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
>> ---
>>  scripts/gdb/linux/cpus.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
>> index 15fc4626d236..9ee99f9fae8d 100644
>> --- a/scripts/gdb/linux/cpus.py
>> +++ b/scripts/gdb/linux/cpus.py
>> @@ -163,7 +163,7 @@ def get_current_task(cpu):
>>      task_ptr_type = task_type.get_type().pointer()
>>
>>      if utils.is_target_arch("x86"):
>> -         var_ptr = gdb.parse_and_eval("&current_task")
>> +         var_ptr = gdb.parse_and_eval("&pcpu_hot.current_task")
>>           return per_cpu(var_ptr, cpu).dereference()
>>      elif utils.is_target_arch("aarch64"):
>>           current_task_addr = gdb.parse_and_eval("$SP_EL0")
>> --
>> 2.25.1
>>
> 

FWIW:

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Should go into 6.2 if possible.

Thanks
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

