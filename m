Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE373A603
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFVQXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 12:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFVQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:23:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF911BD8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 09:23:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nt8AkbTeoJeCSgDIQqnInOAywXYk08Wx48wYItLyWXJn5Eiha0vwY7gxG+FVEKaLrwKiV4vXB3qULmVI7zXfEJd4dTzvwRfUs7omepoldcaxfoitTBMB1FSC3EwpaJkynUINh+XPKSOUrk9EUPyI78dHErQRShZHN+mIeTvAUy4eRRCOXrpn55HxUblwDgeXoBvlfre+LItCtVB7J/SJI6tdP8q6TjXNQIHuqegiPFiVj7ncsT6M0mHGUwVA1c0GJdIsHX+3im2hb7Wc6wdu6xadgmJDXkEu1S/CSf/0Y4Cqa4FXEfo/lkfvo4roQ7Pvu4+BXJI09AGhCm/gMjgMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYd8MKdclwzB5SA+i4PFLAUWrca+ThCH4vytg4pGaes=;
 b=PBzpIp+TQq9bWqFDdlhpaHOYlFO80DsLU7Ur7zuGIMwxzO1AmiVJ4VOR7CZwHu0BDQMwS1d3VSvSsZv/VWnvYtwcjYqli3XSDH7wElD64PqdWXONvp0jEzXJZGkfcjW0X3mfG7jzhJcIXGES8MSHvR0PhlV1VRfUPHeiYwZJQm+qB2+hbbRvnJ6DBileO63WMSlvdpt73yk2hHfm6OTyg1i973Wx2xhj4mVrc0Wml3LhuCi+g9J2sJJn2Pmf3ZUnfqQ7FVxZ6Fqm7QBSocv+XqTJCM7q/MAbs08F0janClxEShcq/lKd4Ixj9vd6xyoYY5X2ImdeuYlRhDTTyQ3T7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYd8MKdclwzB5SA+i4PFLAUWrca+ThCH4vytg4pGaes=;
 b=oSKAHi767g3vq10aAus+TgM/N1Pjg/uiEugtsycVelvCEf9cYCpitreDbqMPH3XX47LO9VXW4p3X1O8lJa3lNsEGhVEIcIylDgyRoVeNv3+AkhZmyP0HZI9kgSm6bRkKCJZ9Ix9ASwNF8HKT3XleZBZrKR98mra0UUIyNkWz6LE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
 by TYZPR02MB4989.apcprd02.prod.outlook.com (2603:1096:400:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:23:43 +0000
Received: from TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb]) by TY2PR02MB4479.apcprd02.prod.outlook.com
 ([fe80::bc4a:4d7a:4c73:76eb%4]) with mapi id 15.20.6521.020; Thu, 22 Jun 2023
 16:23:43 +0000
Message-ID: <c39ce088-d775-dffe-7927-41518926b084@oppo.com>
Date:   Fri, 23 Jun 2023 00:23:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [f2fs-dev][PATCH 1/2 v2] f2fs: update mtime and ctime in move
 file range method
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230621094359.3827832-1-heyunlei@oppo.com>
 <9f3a5518-1de5-17b9-5aec-9820fe79c223@kernel.org>
From:   =?UTF-8?B?5L2V5LqR6JW+KFl1bmxlaSBoZSk=?= <heyunlei@oppo.com>
In-Reply-To: <9f3a5518-1de5-17b9-5aec-9820fe79c223@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To TY2PR02MB4479.apcprd02.prod.outlook.com (2603:1096:404:800e::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR02MB4479:EE_|TYZPR02MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: 934fbae2-ff19-4047-9a79-08db733d0ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTlAGpzG4ixp6JuosYCHXDiqje9eIOnKNtKDy7f7guMOqPC3QX220gsUNx9Ph9BoCM5RWpucC/+yfglrCNO9DK6aic11X1rnH6b6jgHOHugrRMU0WLjuTUrqmd/UWtrJf9XyefzFhbVKJY+rvvlZarXL58ifRkjK+NJG8mij9HzL9G0DbmhHdkxpO7jHorBdbx81KwPMLfw5wM8t1FCT5GSQ6JDQ0rLl85DHm+mV7S25zv8lj03bVQXAz0VVz1O7LlN4AWrhU9NEvEylYpIV5SaG9MHg7l7og5S8N3JaJ8EPMCb2W/6DLlW4tSNKumEaNZeuyjnZYhDA/Ia3CXVPrN0FIAebmmzR0D1twM+R0/7QoLJAaPkKb/4uTCyACdp/eJ4bttQXFDmtf5DJjrV+/5IJgVcO/Che0Yk5O11uPE4GTlnBVBAxE7MDnOPCxyliEKYmYAaPOOP4hjzdtSDfbUOD8xT7jOoM6C7bc1wT7WnJ1HJABzEZRCG9RcBm+uSEYydg0gzKdQm3swZvRVQBLlqX8WSv4bLCL1iTu11mCj2s5TAuuTpMZna7x04D4Pq4Dq6h1G8WSW8Ig+oX8CY/i4gcSGGpJK5qBnOuYDsRXfTaGLtw3Kea2ltpT3NsruNpekvFB7b7LXSykxpxDhatQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4479.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(85182001)(36756003)(38100700002)(31696002)(86362001)(31686004)(6486002)(41300700001)(8676002)(478600001)(26005)(53546011)(6506007)(8936002)(5660300002)(186003)(15650500001)(2616005)(83380400001)(2906002)(4326008)(316002)(66946007)(6666004)(6512007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTQ3TFN5MVQxVmZtTGRYenpLSmJPTGxjNDJ5QUYvTjROSFpqN0h6RG93Q1lo?=
 =?utf-8?B?S3lBc0lUQnVUR3VxdVNnQXFlNE44L0RLaUswaTNjeFpqd29Ib0NCNEVYVjVi?=
 =?utf-8?B?aWNHbWxnaVFybFcvSi95d0dmU3c4UVVjZW0rdDFYNU9nbWxBWk9oSjNmOGxQ?=
 =?utf-8?B?N0swM1B2V0x3TmM1OFBKZnp6R1RrQlRiYnRXajRRN3JiUXJpWUF3Z201L3ox?=
 =?utf-8?B?c0hRdFZOeFZ2aVBIVEt4RmJWZjdSOFZzOEt0QW54OVJhci82ZVFwUzRyd1FS?=
 =?utf-8?B?cnZ5Y2xJbG85bTgvOFpXRUhsZXIxZXUwcUJIR3NUR3pIeDR0YmV4eE1OTDFU?=
 =?utf-8?B?S1JodUpYa3RuL3pySnFBT1UvTlhtMUoycFNZcmZYOTV0SzVlU2VQNU1YbnFH?=
 =?utf-8?B?VFA3emF0eVYwKzl1S1o4d2doUDN2a0hFbCttV25qcXhLcFM1ZjIzWnZQdmdv?=
 =?utf-8?B?Unh4UU5oQURZVWVaV1hpVG10TFo3YlhDVis2V2h5NGZ1VmRwKytGUDQ4VEMr?=
 =?utf-8?B?ak93VXdlRHVkTlF4WE12WjdhVTFhMFdCeDBiV045RTlOQVZtMzN1Ukw3d3d3?=
 =?utf-8?B?OEhSeW5pMHhSeno0NkExNGxoN1g2RG9WM1M0ejU0N0YwRC9QeUZ0VENTbHQx?=
 =?utf-8?B?cDZwYUJ2SGlSNjU3U0p3elEvbDU5eE94R05XbCtoNnphN21QZVVUYWNGV3c1?=
 =?utf-8?B?SVBjcVZJR2Q0RFpwbWttVXZrZ2hENGVza3J2NTRwNGx0QTJ3ZDNSY3JZc2k2?=
 =?utf-8?B?QTJGNDVoc3Byc0tlMFY2dmIxVGI1QW5rbk45MUZ4ZklEWXB0UVZtbzJEUTNN?=
 =?utf-8?B?d3pjbnR6V2E5STBseXYxdERXUFVEUXp5Z0l3NTRLU09GQU8zYkZXU1BuaEhT?=
 =?utf-8?B?d2cvVkREMW1NaEFLK0ZQTXg4LzZVVllOSkhsZ3ZSV01YS0NvSWJCcTg5c0My?=
 =?utf-8?B?YTM3UUVJalJ3TEV4Z1V1QkVCZTBORElsa2t1RDFZQng3eVgzUXNNME9lS1pv?=
 =?utf-8?B?eWZiSmNHSDVQRVdqK2sraW15V1dSVnp3RStIVW1PMmRFSXVRZGt5L0xNcmkw?=
 =?utf-8?B?cWREZkxwdHZKZTNUaFVDbjgwUHJQb3NqcXNwUFJGRC8zZTNYWVlYZjB4L3dC?=
 =?utf-8?B?YmthTER2Z3VVeVpxOFBxZk9GV2NWMlBRdGZ3MHJ2RURDTVhKcVl5dTFnWkNB?=
 =?utf-8?B?VnQzQzA4cVpuZVUrNDJHVERBZHRSK09vQmk1ZXMvWmRLc2xPUEpDYTNKc3dz?=
 =?utf-8?B?ay9tWEhNb0pvQXArQzdCNitORlVtcVJwa2FRT0h2NDlqZEgrMXFSRkJJUkUv?=
 =?utf-8?B?dnJ1K1ZqbW9Lb0poQTcyVWttKzEyTGk1S3l5OVpYOElWRm0xdGg4NkNpMHI1?=
 =?utf-8?B?bWh0dkNmT3FiSitBTXVkZVRBUWVWNVJ2UERzUEtMSUlBQTVUZUNFY2EyMXov?=
 =?utf-8?B?WEFYQ1UrSGxqVG13b1JCKy9NQlArVXdZQThtTnhVeHIrSHBTN29CdmlHWXJB?=
 =?utf-8?B?eGQ1d3UrSWNwYTFlUmZGNDR6YWVmaWJGREJzVGpPRXp5VXVXc0FjZ0ZRWFdN?=
 =?utf-8?B?dDgzNXJkMkJmWVdiZ0EzUVErMWFGV1RGS1NRTFRRVi9sMGpYcWkwRXBleU84?=
 =?utf-8?B?L3QyYi9XNDNDemV4UzcxUmdGeHNCOHZiTXprWjQzR2NpSnBrMm4yR2FhZFJw?=
 =?utf-8?B?aG02eWxWSTViajFJSElGSXljVXAwSG1la21HZlhmQm45M2Z3Y0xRdnV0WUxr?=
 =?utf-8?B?MjRKTlZhSHhKSUNjVlZBZjlpTzI4ckdQQ2p2djZHMDQxeGpYMFdBZ0crZVJr?=
 =?utf-8?B?RmxXT1cyZzhVYkFzWVB3RmU2K0ZWZFlGdHFJd2c2WlZNQ1ZqZWtram80UUF5?=
 =?utf-8?B?UHpBaUxOUkxKanhKSURVRSttZGFZa25xZWI5ZTJrUmZVZ2YvdGdtZFE3WTMr?=
 =?utf-8?B?L1RTclUyOTFJbjVMd1hleVVpdjVXV2lseXM3VVdLOVQ0VFVyOTJaanVrM0N5?=
 =?utf-8?B?czVvc2FsQnpFbnArcHJCUXZ4c2VZUzhzU2xWYXJDYmdaa05SUW5lU2ZONXll?=
 =?utf-8?B?VTRGK1Y1T09kRUVZbjhoVVRvZG1RTHNPQjRtYmFCSEdrb3VicEkwRXFjd2do?=
 =?utf-8?Q?a0LRUqWEvF/e/Wi0EevpdB4P9?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934fbae2-ff19-4047-9a79-08db733d0ba8
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4479.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:23:43.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCtPa6C/hxMSjSmQRSHcG73Q3LoyItW5OIoloMdrqr4SHfJdG3Z6isX+VCTnWAk+qxEdIF7wiCbBQoIGz1ANCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB4989
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/21 21:39, Chao Yu wrote:
> On 2023/6/21 17:43, Yunlei He wrote:
>> Mtime and ctime stay old value without update after move
>> file range ioctl. This patch add time update.
>>
>> Signed-off-by: Yunlei He <heyunlei@oppo.com>
>> ---
>> v2:
>> -update both src and dst inode
>>   fs/f2fs/file.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index cb42d8464ad9..4adcf62e2665 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -2884,8 +2884,22 @@ static int f2fs_move_file_range(struct file 
>> *file_in, loff_t pos_in,
>>         if (src != dst)
>>           f2fs_up_write(&F2FS_I(dst)->i_gc_rwsem[WRITE]);
>> +
>
> Unneeded blank line.
>
>>   out_src:
>>       f2fs_up_write(&F2FS_I(src)->i_gc_rwsem[WRITE]);
>> +
>> +    if (!ret) {
>> +        src->i_mtime = src->i_ctime = current_time(src);
>> +        f2fs_mark_inode_dirty_sync(src, false);
>> +
>> +        if (src != dst) {
>> +            dst->i_mtime = dst->i_ctime = current_time(dst);
>> +            f2fs_mark_inode_dirty_sync(dst, false);
>> +        }
>> +
>> +        f2fs_update_time(F2FS_I_SB(src), REQ_TIME);
>
> f2fs_update_time(sbi, REQ_TIME);
Hi Chao,

     Thanks for your review, I have resend this patch set.

Thanks,

>
> Thanks,
>
>> +    }
>> +
>>   out_unlock:
>>       if (src != dst)
>>           inode_unlock(dst);
