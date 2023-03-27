Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550A6C9951
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjC0BWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0BWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:22:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FA4EFD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 18:22:40 -0700 (PDT)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlFQM2hrXzrXYB;
        Mon, 27 Mar 2023 09:21:31 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 09:22:36 +0800
Subject: Re: [PATCH -next v7 2/4] mm/zswap: skip invalid or unchanged
 parameter
To:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20230325071420.2246461-1-liushixin2@huawei.com>
 <20230325071420.2246461-3-liushixin2@huawei.com>
 <20230326031723.GD3269998@google.com> <20230326045327.GE3269998@google.com>
 <20230326232508.GB19631@lst.de>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <c5dc155f-a53f-dd8c-86a2-c59e0839314b@huawei.com>
Date:   Mon, 27 Mar 2023 09:22:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230326232508.GB19631@lst.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/27 7:25, Christoph Hellwig wrote:
> On Sun, Mar 26, 2023 at 01:53:27PM +0900, Sergey Senozhatsky wrote:
>>>> +	if (kstrtobool(val, &res))
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* no change required */
>>>> +	if (res == *(bool *)kp->arg)
>>>> +		return 0;
>>> Bool kernel param can be any of these letters 'YyTt1NnFf0'. Doing things
>>> to kp->arg outside of kernel/params.c is not going to be easy, let's not
>>> even try.
>> Please disregard my previous email. kp->arg is always true or false
>> at this point. I'd still prefer to not do kp->arg in zswap.
> The whole parameter handling in zswap is a mess and I don't really
> have a good idea how to solve it all.
>
> But for this "paramter not changed" case I think we can helper a lot
> by adding a core moduleparam.h helper to encapsule it.  I.e.:
>
> static inline bool param_bool_unchanged(bool val,
> 		const struct kernel_param *kp)
>
> 	return val == *(bool *)kp->arg);
> }
>
> and at least keep it out of zswap.
Thanks for your advice. I will try this way.
>
> .
>

