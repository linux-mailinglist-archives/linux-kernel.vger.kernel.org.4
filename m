Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8BF740FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjF1LGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:06:30 -0400
Received: from out-29.mta0.migadu.com ([91.218.175.29]:10881 "EHLO
        out-29.mta0.migadu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjF1LG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:06:27 -0400
Date:   Wed, 28 Jun 2023 20:06:18 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687950385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jc0/jL+hYp/3hJv3ILK0z0s0gv31nbCXGARkyWsaWLc=;
        b=L6LUItETXqY8PfyYcU02Fy+BNporGYYQpyhwjgGQ8NCrcQuUWyyIonqg0KRp6/ADWnrIJP
        FMLkHKgqaRZaZ5YVz/05PDvFBgMswj8pAgeSCyrcFnsTDguB5rwe2uMDRyVA2eH0Qqdj0F
        QLk4Thdr7IHkBbdlhE0BvK2FQ4d2DLc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memory-failure: fix unexpected return value in
 soft_offline_page()
Message-ID: <20230628110618.GA1248243@ik1-406-35019.vs.sakura.ne.jp>
References: <20230627112808.1275241-1-linmiaohe@huawei.com>
 <20230627123046.ef7e791208214bbfecd71e42@linux-foundation.org>
 <dc6f687f-926f-effd-338f-32edc7508479@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc6f687f-926f-effd-338f-32edc7508479@huawei.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 09:56:38AM +0800, Miaohe Lin wrote:
> On 2023/6/28 3:30, Andrew Morton wrote:
> > On Tue, 27 Jun 2023 19:28:08 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >> When page_handle_poison() fails to handle the hugepage or free page in
> >> retry path, soft_offline_page() will return 0 while -EBUSY is expected
> >> in this case.
> > 
> > What are the user visible effects of the bug?
> 
> The user will think soft_offline_page succeeds while it failed in fact. So user
> will not try again later in this case.

I think that it's helpful to put this in patch descrition so that maintainers can
easily guess the impact of this patch.

Anyway, the patch looks good to me, thank you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

> 
> > 
> >> Fixes: b94e02822deb ("mm,hwpoison: try to narrow window race for free pages")
> >>
> >> ...
> >>
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -2737,10 +2737,13 @@ int soft_offline_page(unsigned long pfn, int flags)
> >>  	if (ret > 0) {
> >>  		ret = soft_offline_in_use_page(page);
> >>  	} else if (ret == 0) {
> >> -		if (!page_handle_poison(page, true, false) && try_again) {
> >> -			try_again = false;
> >> -			flags &= ~MF_COUNT_INCREASED;
> >> -			goto retry;
> >> +		if (!page_handle_poison(page, true, false)) {
> >> +			if (try_again) {
> >> +				try_again = false;
> >> +				flags &= ~MF_COUNT_INCREASED;
> >> +				goto retry;
> >> +			}
> >> +			ret = -EBUSY;
> >>  		}
> >>  	}
> > .
> > 
> 
> 
> 
