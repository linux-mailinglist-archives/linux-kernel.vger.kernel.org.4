Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE67606150
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJTNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiJTNQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:16:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD6513A7F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:16:06 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtSZj3tW9zmVCV;
        Thu, 20 Oct 2022 21:08:13 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:12:59 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 21:12:58 +0800
Message-ID: <dadd98ef-c2d8-fe9b-5aca-00c31d7a65c7@huawei.com>
Date:   Thu, 20 Oct 2022 21:12:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/1] vsprintf: check non-canonical pointer by
 kern_addr_valid()
Content-Language: en-US
To:     Jane Chu <jane.chu@oracle.com>, <pmladek@suse.com>,
        <rostedt@goodmis.org>, <senozhatsky@chromium.org>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <konrad.wilk@oracle.com>, <haakon.bugge@oracle.com>,
        <john.haxby@oracle.com>
References: <20221019193431.2923462-1-jane.chu@oracle.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221019193431.2923462-1-jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/20 3:34, Jane Chu wrote:
> Changes since v2 [1]:
>   - revised commit comment for clarification;
>   - cc linux-mm for expert's review on the kern_addr_valid() usage as suggested by Petr;

but this won't fix issue on archs which don't have correct 
kern_addr_valid(), right?

could we call copy_from_kernel_nofault() when it could works well, and 
skip it on early boot?

other options, call some functions in include/asm-generic/sections.h  or 
include/linux/kallsyms.h?


>   - cc Kefeng Wang in light of his recent patch [2]
>
> [1]: https://lore.kernel.org/lkml/288a7aba-c647-b51f-bdb3-99a62449dbb3@oracle.com/T/
> [2]: https://lore.kernel.org/lkml/20221018074014.185687-1-wangkefeng.wang@huawei.com/
>
> Jane Chu (1):
>    vsprintf: protect kernel from panic due to non-canonical pointer
>      dereference
>
>   lib/vsprintf.c | 3 +++
>   1 file changed, 3 insertions(+)
>
