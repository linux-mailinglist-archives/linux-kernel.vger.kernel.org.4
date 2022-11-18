Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C015B62F5A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiKRNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbiKRNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:13:32 -0500
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Nov 2022 05:13:27 PST
Received: from forward502o.mail.yandex.net (forward502o.mail.yandex.net [37.140.190.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE911D86;
        Fri, 18 Nov 2022 05:13:27 -0800 (PST)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [IPv6:2a02:6b8:c08:1612:0:640:37da:210])
        by forward502o.mail.yandex.net (Yandex) with ESMTP id C0A5425D50C0;
        Fri, 18 Nov 2022 16:05:53 +0300 (MSK)
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id eOks44V6nS-5pVmNm92;
        Fri, 18 Nov 2022 16:05:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clicknet.pro; s=mail; t=1668776752;
        bh=/wHdhb6bOR6sr6GxP7nToVvgKT4uV8iQ9aNeJQuYTyc=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=PnxOE3On7J7+RxaOegVmOD9Cjmq8zBQgeNI4H+6xOoRyil6MRagvAHjkaudPAWb7P
         Nqeh2yBpd6j1CYWT66JdB6fGmEz23W4qwTJB9nBTn5BmGsWcEI3W1eVSMdoVYzNGRZ
         jV/kfqMyeoywwn6lL7US2uIkqrxzWQDrodXWQ108=
Authentication-Results: sas1-37da021029ee.qloud-c.yandex.net; dkim=pass header.i=@clicknet.pro
Message-ID: <74337ebd-0222-2e78-9149-8fa40b0c815e@clicknet.pro>
Date:   Fri, 18 Nov 2022 16:05:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Coverity: zblock_alloc(): Memory - illegal accesses
To:     coverity-bot <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
References: <202211171419.FCDC8EE@keescook>
Content-Language: en-US
From:   Ananda Badmaev <a.badmaev@clicknet.pro>
In-Reply-To: <202211171419.FCDC8EE@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_PDS_PRO_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.11.2022 01:20, coverity-bot пишет:
> Coverity reported the following:
> 
> *** CID 1527352:  Memory - illegal accesses  (OVERRUN)
> mm/zblock.c:320 in zblock_alloc()
> 314     	}
> 315     	list = &(pool->block_lists[block_type]);
> 316
> 317     check:
> 318     	spin_lock(&list->lock);
> 319     	/* check if there are free slots in cache */
> vvv     CID 1527352:  Memory - illegal accesses  (OVERRUN)
> vvv     Overrunning array of 10208 bytes at byte offset 10208 by dereferencing pointer "list".
> 320     	block = cache_find_block(list);
> 321     	if (block)
> 322     		goto found;
> 323     	spin_unlock(&list->lock);
> 324
> 325     	/* not found block with free slots try to allocate new empty block */
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527352 ("Memory - illegal accesses")
> Fixes: 9097e28c25c8 ("mm: add zblock - new allocator for use via zpool API")
> 
> It looks like block_type is not checked to be < ARRAY_SIZE(block_desc)
> after exiting the earlier loop, so the access through "list" may be past
> the end of pool->block_lists.
>

There is no need for this check because it is guaranteed that this code 
will be executed only if size <= PAGE_SIZE. Since slot_size for the last 
list even exceeds PAGE_SIZE, block_type will be always valid.




