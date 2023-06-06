Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8420724096
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjFFLNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFFLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:13:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2105.outbound.protection.outlook.com [40.107.215.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470DF9E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BywCx29V3xn8eR/1hfeIr/5C90CEBNDwIz9NtPP1VCZZYArlIP/q6q3yh/5PTyTP8L9GUY4lJJaER3dKyDjGgGRtfWLHZQBX3pb3WYfMM0pjfftykHhfmXFpVzLsoOqqbDHTgvwKRMuLE1M8oJoBNaLcTK2ZUJyhwOlZfjK45JChrB+YlY0ZQ9IAa2z1l7+quED2PDO4L8enjLVawd67ZX9+P5d7e+45hTnoFtihu5HNzuQ+dtXG9yLIVHukU64YNpxHAOK/02bBbOnIkgXPSibJ23Pd66kc0brRJc5IsHk4oL6135rNlppCjZyfo/EI41VFkiiJiHhvO3iMSJiN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kIkaNxr0xnn7AeQS6rpB5CqvHbVnqM7WKYxRo+ix0w=;
 b=LuXhi4BQr6z/YqtxOqsd5Wl+AXOpJ+5goIkIZ/xwsTmbuY+46/Mb7WQiS87mSVy8odogpTV7AdRUVU3shT9xZzBQlFDQFOy9b78r3te3cujg+AikW6YCbvwJq8jwQ1VOqzBsN7i5p5cg8b4FmErIZXsXXNJWKgxZxKUSo6ds8p52PKsQyluI8GZGz8ZO8gdyTC6208NPiY7W6Qs5mYPi5aunKrmWwywwnmYlNTgqfKskg02fZ9EWOdzhY9ZtpVQZNGktrzWoqHNGy+NIJdB9umTiZelSyicNacm3yzDNpiGYUsxjAD0Ne39XafwSOZown3c0cpM5s6dlw1ccXKbbdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kIkaNxr0xnn7AeQS6rpB5CqvHbVnqM7WKYxRo+ix0w=;
 b=op63Jr1IwqRZ7fjiLj5lRJteIpNy5gSTvIU8fLW9395m/Ivkb+BbrxdJ1G6TfE780UWPo4FMoNPjqfA/dW3GBq99RxEfS2wo930FUjQLT6VCZih4oioOi/3nIkfpK1HeLFNMjsysyb7MkQ9JJ29ffjW1K0GMgN+2l8b0lBFU7r2Bosn+o1hDwPjWzmgEJdexfPf2BuzDciDm7L8PffZ0mUssign56WMRoBLOqN7bHdlYCHEu1/g7MwzMKgK47LXASnplriYrnJrYGZr5FQZkUDT0sCj2DuAqdA/sdbyB9TLCWbRrusCuuTwgrHY7irmjbc5Yo5ACSlxj9bOP/nsxYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PSAPR06MB3912.apcprd06.prod.outlook.com (2603:1096:301:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:13:23 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::76d6:4828:7e80:2965%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:13:22 +0000
Message-ID: <29bea47b-9085-05e7-d254-a40007e6c7f3@vivo.com>
Date:   Tue, 6 Jun 2023 19:13:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] f2fs: enable nowait async buffered writes
To:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Lu Hongfei <luhongfei@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230531144006.7307-1-frank.li@vivo.com>
 <e8e4758f-5895-acd7-27d2-4b72b69722b3@kernel.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <e8e4758f-5895-acd7-27d2-4b72b69722b3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PSAPR06MB3912:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fdd4d5-da3e-4d26-8d83-08db667f08f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +S9vCxee+1W7ytMNy1Iy6pZj1W0g+aOch5Nw06zFW+DSJnr3P50M/cYw+kt+lQzWbSXLTCGGWndjPlH9drE+S08hEvskYdgW+snPfCbVCxUftLX5q6ws3Wup3RIVNGGWNwHwWZb3BICJqRdWmQo6yUTq/k4QB5Er9ISk6ijWNY6QiqAjNZGUUfjmJ8xEaMmLIK0oWZwGLk6hieWOeVzxU6KTBxBIFMJ/j31EY1ukc0JB8gFxAB4pLXRpbhiG7K5FqtgIxrhWBhAfYrK97FRvGnBiMF0Iyr8rGXu3RgS0OpQQH2VltQG5VhvcSWrvTYyz65hrF4dL9AorBznboPpm/MUljWt6BDnPTqfIg/x6O/X86vDgTozqby8Mi1l8IldC5u/d+cSRD8fHNBBZ+0vGVXAWT1EDaDWOyyTlxKK4FnH55w6gcvqInXvhWq3yZSd7ZWGhxduxqM9BC+6t9/u/pVOU5rcFxNLaFXF1K5TLr7I8uPqOQmO8yq0QW+DYZwkLJwV0hzIH/xkIm0Hm/TmFqAZ0hxBYxvu2VF2urVNR6GRatUu6lSAcFX5C93ZkMUgLjf3tMvXwloOk3tvq+h3p5k18HeNP2zYgo9Pre77qsuSzEwkJxQQuqMRZ7gyrLV/2cBzs6svQoCs5NHkZdu/roNbgfLPVddP8ZhIQy4NFf4GIHyB8QVlgexn9SuXd9giI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39850400004)(396003)(376002)(366004)(136003)(451199021)(110136005)(478600001)(5660300002)(8676002)(36756003)(86362001)(8936002)(2906002)(31696002)(4326008)(66476007)(66556008)(316002)(66946007)(38100700002)(31686004)(41300700001)(38350700002)(83380400001)(26005)(6512007)(6506007)(2616005)(53546011)(186003)(52116002)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTFSZE43T1pQMVM0YlhTVlZLMUtkVTR4T1N3b29pRVliNmFyWXEreC9XZ09E?=
 =?utf-8?B?SWxHcThpdmw3YzcyaVUvcEpzWGVCenZKT25Wak5wZ04rVFUzdktpMEthZ2w2?=
 =?utf-8?B?cWVIaXZsNDNiRS9DeFdORzdTakVhbVhVTkpKcG9YYi9KYXNyZGNlN2ZlLytk?=
 =?utf-8?B?YlhOYjRRLytEN21xZ2pkNFE5eXF3Vi9xanlDWlF6NURTbHorUC9ZSi9rcHpo?=
 =?utf-8?B?UlJoS1hvTjRqTm9xNGVvdElMNDZySDIxRzhsaUQwSGZzbVcrRkxoUGhtU1Zs?=
 =?utf-8?B?MFlNVEtTNGZLNCt1WGhiS1MyWnJRYzMzb3orbWhURktDNHBoTERpREZMWXow?=
 =?utf-8?B?VXVqSHpPZ2NRMi9hNUplNmUvVXBNaXBFWmgwUmhtWEZVekJBOEEwWVdXQWdM?=
 =?utf-8?B?T0FuZ2xzTjZFTWdTbHpQQ0F1OXk4VnhMSzlka0JRcVcwbEE0cjNGc3dvNmZx?=
 =?utf-8?B?T3phd2E4ckh6QldpRHhwSmhuUzZTRnhBTE5UTFhTRHpib25raTFaY1luYzkw?=
 =?utf-8?B?VW1BVnNsbFpiekdqNnU0Z2trMTZ6RHFLeElGM0JBWHY3VXR2U2daaG1iYUNZ?=
 =?utf-8?B?QmlOeVp0Rk5SSjQ0Qk9iRXJTWTY1a0hWUElaTDg3NC9iZFFvSXVlcTZwZlJU?=
 =?utf-8?B?b0RmaFIxYzRhY1kyNlF6RGJFTDU1NFVkSE1oeDNqbmNJb3ZWcWRMa0hud0kw?=
 =?utf-8?B?bDNXTFFnZG5JU3J2SVRqbVMwaDh1dEFsdVM2ZUVOYy9aTTQyWnlkcjVzcm5W?=
 =?utf-8?B?L09Bb2Z4cUZrbXd0UE44VytvS3pmcE5zWDY0MEhhOXpLWVdramhjcDBqZStD?=
 =?utf-8?B?MkJrdWVNVkVVcE5aTG5LdFVtdm5rNXduZ3BLb3dxNUt2UmJpTEhzQVpZWXlQ?=
 =?utf-8?B?SG5ySGJweGhhcDBCejdRWWFlNmdPY2NtbnlldVIwMUdob0UxYWNJRElkbmd2?=
 =?utf-8?B?cmlRbnB5RERFVkRYcHRUTzZId1ZxY2dsa3plRzZUS3pBWTlsSGt4eFFoalZV?=
 =?utf-8?B?czNuRk1YSXlHdVpQMVZVcUxWVk9HWHpQNC9sTjNCVURDaTdzOTBNbTBTQWtZ?=
 =?utf-8?B?bUJKYmthOEQ4WDVPZENIRFhyeDBGZ1h0Mnk4ejZpaERVVlF6dllOVHhlTFpR?=
 =?utf-8?B?ZjBhSmJtMG9Xc3hDRjd5QnR5VnlBeWoxSXRWcFQ1bTlEaUJSSC9zWjZpVG1X?=
 =?utf-8?B?UUF3RlVZSis4RzNzL043SmI3QXJNaGd2Z09NZDAvYk5SUEVPWFZhWllsQ0I5?=
 =?utf-8?B?YitYZ3UreWw3T2ttY1hJd2NXZE54UWU1QVFNcDJwUisvZExla3VaMVl4RzBH?=
 =?utf-8?B?eGhhL1hibVEvYXFpWG9hdjlmbmFvTDkxRnkwZkNlY2RmdHNlREorUU1MRTlB?=
 =?utf-8?B?YktiMVRuN2pJOGIzZmw5K3RxazlzWE9VZlhiZzYwZHNGTjIzK3RyVFlzMDQy?=
 =?utf-8?B?WmdVd3RNS0ZuTkZ1MHR2dFlrWmI1Nll0dWpocUQybjhhTGJLd0NRQTBuNkNR?=
 =?utf-8?B?VkR1cTZieUltcThLMEZmUWUybWtWd1hrY3B1bWpsOHpLK3JOa1Izc3QxcVU1?=
 =?utf-8?B?aDVhWVhyaThNS0RQQ0lybEM3RWJ2YlhsdWZsRXBiclE4L0V6RUFxTWxvTjZt?=
 =?utf-8?B?Q2MvTUJrWkg3dmNnYUowazVUUGE0a2sxdnQ1UkdzT0pHeEFIQkxvN3hKQ2xK?=
 =?utf-8?B?NFVNSnlHNCs3WnlEYnZOYkVrL0RieC9GV1MxSlRjR3Y3OS9QZ0ozUW9SRENS?=
 =?utf-8?B?L0tjQ0NFUVIwUFlYcTNkUW9takhrMEtBM0VPNitBYy9rRHkwODR6OW9mQWk1?=
 =?utf-8?B?cEtMM3JBTjkvRmQyUXlFUWlyQThiY0J4N3VmOU5sRXlobGd6MThyVTlLenQx?=
 =?utf-8?B?UVE2NnZmNjNwWSs3VEFwb3dONFJRQjgzajUxZnh4dEFZbXFCSUdqTEZsNld3?=
 =?utf-8?B?TzByayt4SDdDdXM5cHdUM3ExRHJrYkJhUHFoVWxCRi8vQjN0OG9uaEc4T2cr?=
 =?utf-8?B?MWtiWGtkb1Q4VVIrOVE0OXVtWDBoK0xMeGNRQ2lYKzJtUDFCZG5KS1d4bU1h?=
 =?utf-8?B?elhqWWNoNkpKaGFDOThjMlF5aG1QeTZVaU9TS0hwbDB5U3pWZ2s1SHl0ZnJ6?=
 =?utf-8?Q?eFQ1YAts6gWrrxfVDmJ5NuQ5A?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fdd4d5-da3e-4d26-8d83-08db667f08f1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 11:13:20.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sN2O7O3bdz3vykTdrGbIJN8+he+i3Fdg+Mx+dkbLBZhyGcKSpBPo7MFbmIh91OO1jpK9p/iC/YmN3PA870A5rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB3912
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/6 14:43, Chao Yu wrote:

> On 2023/5/31 22:40, Yangtao Li wrote:
>> This adds the async buffered write support to f2fs,
>> the following is the relevant test data.
>
> Yangtao,
>
> Could you please provide detailed test command?


Use fio to test, the following is the configuration:

# io_uring
[global]
ioengine=io_uring
sqthread_poll=1
threads=1
iodepth=32
hipri=0
direct=0
fixedbufs=0
uncached=0
nowait=0
force_async=0
randrepeat=0
time_based=0
size=256M
filename=/data/test/local/io_uring_test
group_reporting
[read256B-rand]
bs=4096
rw=randwrite
numjobs=1


>
> Thanks,
>
>>
>> iodepth      | 1    | 2    | 4    | 8    | 16   |
>> before(M/s)  | 1012 | 1133 | 894  | 981  | 866  |
>> after(M/s)   | 1488 | 1896 | 2081 | 2188 | 2207 |
>>
>> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/f2fs/file.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 23c68ee946e5..4faf2c04e325 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -546,7 +546,7 @@ static int f2fs_file_open(struct inode *inode, 
>> struct file *filp)
>>       if (err)
>>           return err;
>>   -    filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
>> +    filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
>>         return dquot_file_open(inode, filp);
>>   }
>> @@ -4515,9 +4515,6 @@ static ssize_t f2fs_buffered_write_iter(struct 
>> kiocb *iocb,
>>       struct inode *inode = file_inode(file);
>>       ssize_t ret;
>>   -    if (iocb->ki_flags & IOCB_NOWAIT)
>> -        return -EOPNOTSUPP;
>> -
>>       current->backing_dev_info = inode_to_bdi(inode);
>>       ret = generic_perform_write(iocb, from);
>>       current->backing_dev_info = NULL;
