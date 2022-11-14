Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468FD627424
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 02:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiKNBZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 20:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKNBZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 20:25:47 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B610067;
        Sun, 13 Nov 2022 17:25:46 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N9WpG41Jkz15Mbf;
        Mon, 14 Nov 2022 09:25:26 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 09:25:44 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 09:25:44 +0800
Subject: Re: [PATCH v8 0/9] kallsyms: Optimizes the performance of lookup
 symbols
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>, <rostedt@goodmis.org>
CC:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-modules@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        David Laight <David.Laight@aculab.com>
References: <20221102084921.1615-1-thunder.leizhen@huawei.com>
 <Y3BaCii5iz2TiUx7@bombadil.infradead.org>
 <Y3Bcs5sT17IcyQZD@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <61daf7e0-049c-0338-03a6-472694def181@huawei.com>
Date:   Mon, 14 Nov 2022 09:25:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3Bcs5sT17IcyQZD@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/13 10:55, Luis Chamberlain wrote:
> On Sat, Nov 12, 2022 at 06:44:26PM -0800, Luis Chamberlain wrote:
>> On Wed, Nov 02, 2022 at 04:49:12PM +0800, Zhen Lei wrote:
>>> v7 --> v8:
>>> Sort the symbols by name and implement kallsyms_lookup_name() using a binary
>>> search. The performance is more than 20 times higher than that of v7. Of course,
>>> the memory overhead is also extended to (3 * kallsyms_num_syms) bytes. Discard
>>> all implementations of compression and then comparison in v7.
>>>
>>> In addition, all sparse warnings about kallsyms_selftest.c are cleared.
>>
>> Awesome work, I can't find a single thing I hate about this, but my
>> biggest conern is the lack of testing so I'm going to merge this to
> 
> Sorry finished the email too fast, I just wanted to add Nick to the
> thread as his work does tons of changes on scripts/kallsyms.c.
> 
> I was saying -- I'm just concern with the lack of testing so I have merged
> this to modules-next and see what explodes over the next few weeks.
> I'm also happy to drop this from modules-next and have it go through
> the livepatching tree instead, but given Nick's work is dedicated
> towards modules and it also touches on scripts/kallsyms.c a lot, to
> avoid conflicts it felt best to merge that to modules for now in case
> his changes get merged during the next merge window.
> 
> Let me know what folks prefer.
> 
> Obviously, if testing blows up we can drop the series.
> 
> Zhen, wouldn't ftrace benefit from the same
> s/kallsyms_on_each_symbol/kallsyms_on_each_match_symbol ?

ftrace uses regular matching, so it cannot be replaced.

> 
>   Luis
> .
> 

-- 
Regards,
  Zhen Lei
