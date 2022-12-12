Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691C64A4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiLLQZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLLQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:25:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9FB48B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qTolJC9fUfjb3pLzxYSP1dBl1foIc1xzVjzAvOAu5Oo=; b=JSx+G5IEaMaHeabCqfyh2vEwKw
        ftLHw1tCdPxx6RJ4qQV6TEF4qayiik5lnF6rEEpqn0a/P1pZxhwY9vMfbQeulKM8uMX+t18wQiHGM
        Up77a2zYD1uXpqPunkKfpAVVpJXwDnq78QDQ499ll72LH3e2vdCVkwnhC4+hoYFNY0Ep5hKZ+oulA
        kN9DvK3uZPuMpmw5NjY8RMAS/COPov7o3mXCsgOViWg3YfF8Ke5dk3QPw6z8ucouVALOv2YfmGibo
        ULC4uNegvbFzfozPTb4cbtJkFYrRuNDESPg6wkqfOOS6t6/2pS40uDU2O/YJmjyxFixbl2UscW9+f
        SOH0T6fw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p4lbu-00BDpp-Sf; Mon, 12 Dec 2022 16:24:58 +0000
Date:   Mon, 12 Dec 2022 16:24:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        kernel-team@meta.com
Subject: Re: [PATCH v2 3/4] cachestat: implement cachestat syscall
Message-ID: <Y5dV2jrZGMvgIZCx@casper.infradead.org>
References: <20221205175140.1543229-1-nphamcs@gmail.com>
 <20221205175140.1543229-4-nphamcs@gmail.com>
 <Y5UbhBTB2nSMN4UD@ZenIV>
 <CAKEwX=NwUPShF3zud7kn_gyd4BZy8S6xzm6iFuw0eW=o=3A8nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=NwUPShF3zud7kn_gyd4BZy8S6xzm6iFuw0eW=o=3A8nw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 08:23:31AM -0800, Nhat Pham wrote:
> > It would be easier to read if you inverted the condition here.
> 
> Oh I think I tried
> 
> if (!f.file)
>        return -EBADF;
> 
> here, but there are some mixing-code-with-decl warnings.
> If I recall correctly, the problem is with this line:
> 
> XA_STATE(xas, &mapping->i_pages, first_index);
> 
> which is expanded into a declaration:
> 
> #define XA_STATE(name, array, index) \
> struct xa_state name = __XA_STATE(array, index, 0, 0)
> 
> It requires a valid mapping though, which is
> obtained from f.file:
> 
> struct address_space *mapping = f.file->f_mapping;
> 
> so it cannot be moved above the if(!f.file) check either...

Perhaps you're trying to do too much in a single function?
