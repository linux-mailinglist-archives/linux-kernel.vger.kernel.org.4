Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528406EFEE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbjD0BT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242938AbjD0BTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:19:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C113A92;
        Wed, 26 Apr 2023 18:18:53 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Q6Hqn6g6pzLnkF;
        Thu, 27 Apr 2023 09:16:05 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 09:18:50 +0800
Subject: Re: Bug: "perf record" reporting buffer overflow when writing data
To:     Will Ochowicz <Will.Ochowicz@genusplc.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CWLP265MB497033A5B448268D677F03DD9C649@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM>
 <6c88ac58-a2c8-0b15-a106-9c8b0e26b3ac@huawei.com>
 <CWLP265MB4970C9D9667C9419567243409C659@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <2a7fd858-1639-53a7-bc65-d4f65a9eed2f@huawei.com>
Date:   Thu, 27 Apr 2023 09:18:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CWLP265MB4970C9D9667C9419567243409C659@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/4/26 20:52, Will Ochowicz wrote:
> Hi Yang,
> 
>  1. Displaying notes found in: .note.gnu.build-id
>        Owner                Data size        Description
>        GNU                  0x00000028       NT_GNU_BUILD_ID (unique
>     build ID bitstring)
>          Build ID:
>     6236326637343061343961353463366632643232333465366562353039656634
>     3938656130663039
> 
>  2. That patch did fix the issue.
Thanks for your test to help confirm the problem.
I'll send a fix patch.

> 
> Would you mind giving me a quick explanation of the issue for my own 
> edification?
> 
According to the coredump stack trace, the following code causes the 
out-of-bounds access problem:

#7  0x00005555557e7ddd in memcpy (__len=40, __src=0x555556a28b38, 
__dest=0x7fffffff843c)      at 
/usr/include/x86_64-linux-gnu/bits/string_fortified.h:29
#8  write_buildid (fd=0x7fffffff8590, misc=<optimized out>, pid=-1, 
bid=0x555556a28b38,      name_len=<optimized out>, name=0x555556a28c0c 
"/opt/pylon/lib/libpylonbase-6.1.1.so") at util/build-id.c:312

That is, an error occurred when writing the build_id of the 
"/opt/pylon/lib/libpylonbase-6.1.1.so" file.

The corresponding code is as follows:

write_buildid()
{
   ...
   memcpy(&b.data, bid->data, bid->size);
   ...
}

b.data is an array whose size is Build_ID_SIZE(20), but bid->size is 
greater than this value. Check the perf code and find this problem.

Thanks,
Yang.
