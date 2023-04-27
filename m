Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5257C6F01BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243032AbjD0H2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbjD0H2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:28:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C094EFE;
        Thu, 27 Apr 2023 00:27:35 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q6Rzm4bbtz18KXF;
        Thu, 27 Apr 2023 15:23:32 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 15:27:25 +0800
Subject: Re: [PATCH] perf symbols: Fix return incorrect build_id size in
 elf_read_build_id()
To:     Adrian Hunter <adrian.hunter@intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>, <leo.yan@linaro.org>,
        <eranian@google.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230427012841.231729-1-yangjihong1@huawei.com>
 <f149f4ce-bd2e-b192-920f-1e2599e5b16f@intel.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <d92c26e5-0311-21ce-c52e-6fb81054c100@huawei.com>
Date:   Thu, 27 Apr 2023 15:27:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <f149f4ce-bd2e-b192-920f-1e2599e5b16f@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.205]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023/4/27 14:02, Adrian Hunter wrote:
> On 27/04/23 04:28, Yang Jihong wrote:
>> In elf_read_build_id(), if gnu build_id is found, should return the size of
>> the actually copied data. If descsz is greater thanBuild_ID_SIZE,
>> write_buildid data access may occur.
>>
>> Fixes: be96ea8ffa78 ("perf symbols: Fix issue with binaries using 16-bytes buildids (v2)")
>> Reported-by: Will Ochowicz <Will.Ochowicz@genusplc.com>
>> Link: https://lore.kernel.org/lkml/CWLP265MB49702F7BA3D6D8F13E4B1A719C649@CWLP265MB4970.GBRP265.PROD.OUTLOOK.COM/T/
>> Tested-by: Will Ochowicz <Will.Ochowicz@genusplc.com>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> As an aside, note that the build ID on the ELF file triggering the bug was
> 62363266373430613439613534633666326432323334653665623530396566343938656130663039
> which is 80 ASCII characters, which would have been a 20 byte binary number i.e.
> 
> $ echo -en "0000: 62363266373430613439613534633666\n0010: 32643232333465366562353039656634\n0020: 3938656130663039" | xxd -r | od -c -A d
> 0000000   b   6   2   f   7   4   0   a   4   9   a   5   4   c   6   f
> 0000016   2   d   2   2   3   4   e   6   e   b   5   0   9   e   f   4
> 0000032   9   8   e   a   0   f   0   9
> 0000040
> 
> So perhaps a mistake in the creation of the build ID on that ELF file.
> 
Yes, it may be an error, or it may be that the build-id was specified 
when the elf file was created.

I tried ld can specify a build-id larger than 160-bit hexadecimal digits:

   $ ld -o test test.o 
--build-id=0x62363266373430613439613534633666326432323334653665623530396566343938656130663039
   $ readelf -n test

   Displaying notes found in: .note.gnu.build-id
     Owner                 Data size       Description
     GNU                  0x00000028       NT_GNU_BUILD_ID (unique build 
ID bitstring)
       Build ID: 
62363266373430613439613534633666326432323334653665623530396566343938656130663039

All in all, it feels like a rare scene :)

> In any case, for the fix:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
Thanks for the acked-by.

Thanks,
Yang

