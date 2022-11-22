Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E45633173
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiKVAkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKVAkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:40:01 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859A558C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:40:00 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0DC7AC009; Tue, 22 Nov 2022 01:40:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669077606; bh=9l/g5nGKmHoVQD3sP3ATWDzrkJw/YMvwin9+tmbeCWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibridr2Abjc+DUDTqgFQssfAnC98MdjZCGpuuZSUXwp1jE8I+1GJiEows+8PnBjsJ
         s//9AyY+jRNv4JOCiSxMGEqeGtU5E0nP7OKmcB1LolxeHkWXXEsCPINVZ64dG4Hi5K
         yHXQL4u1lhzU9BarndfoM2BG+pAhk2nC0GrdkeftNce8wp+0q8bxa4O5HOU/CCy/OQ
         9FYgMLrVO8hWwAJ9anIF6SixYfa8Nmaj2hXDKI7mnQJOeVTgKx/yQlsazohI4X6m7z
         j3HRjbFoQowzDAB6uKrTCmSdL/ZTXNtmK0WOYhmvI66g9CoMeXIkDoDJVFxaqir8eC
         dP0xjT9ujoz+Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D7750C009;
        Tue, 22 Nov 2022 01:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669077605; bh=9l/g5nGKmHoVQD3sP3ATWDzrkJw/YMvwin9+tmbeCWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHQcKg4RdUfiBkoJhLylLdBVGiQbzTNGfW0S2EHCvCjLXXc3rRZwaADl/7GhVImwZ
         Y2Ehq9MDE5SJoKyajJPpga0Fn472iU7QhGFlRbk11xGkyP61ZtvAQfUlqWnoXUQOiQ
         BRFSKUbV4KwGibvHnpS9fE7hB1yuG+4gRgLKBi7Tzxf6mx7sAlBoAqpRcqiPjCTKTV
         l0bEDPoU55R3YXrgpCOBaFj+qf1qiNQ/5MnD1UwS4IPHQrB8URscHQ6O1ZQu7d3xOq
         s8LXIEbJ0Kwj1KVrIpkWvQNcn9eDT7LMkpT00keTbfse9KxbhVky0xVnbwz7HXOIIt
         ZJUiP+HxFyuug==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 8d364fb6;
        Tue, 22 Nov 2022 00:39:54 +0000 (UTC)
Date:   Tue, 22 Nov 2022 09:39:39 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        GUO Zihua <guozihua@huawei.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
Message-ID: <Y3waS1oq4BmitGLT@codewreck.org>
References: <20221118135542.63400-1-asmadeus@codewreck.org>
 <37091478.n1eaNAWdo1@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37091478.n1eaNAWdo1@silver>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Mon, Nov 21, 2022 at 05:35:56PM +0100:
> Looks good (except of s/rreq/req/ mentioned by Stefano already).

Thanks for the review (I've taken this as a 'reviewed-by' under the
assumption of that fix, sorry for being a bit aggressive at collecting
these -- I'd rather overcredit work being done than the other way around)

I'll send this and the three other commits in my 9p-next branch to Linus
tomorrow around this time:
https://github.com/martinetd/linux/commits/9p-next


> >  		memcpy(&req->rc, &h, sizeof(h));
> 
> Is that really OK?
> 
> 1. `h` is of type xen_9pfs_header and declared as packed, whereas `rc` is of 
>    type p9_fcall not declared as packed.
> 
> 2. Probably a bit dangerous to assume the layout of xen_9pfs_header being in
>    sync with the starting layout of p9_fcall without any compile-time 
>    assertion?

I've done this in a follow up that will be sent to Linus later as per
Stefano's suggestion.

-- 
Dominique
