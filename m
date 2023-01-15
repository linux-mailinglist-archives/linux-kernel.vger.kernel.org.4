Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06C766B1B3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjAOOzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAOOzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:55:39 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AB6CDF9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:55:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso27073753pjl.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxQBoQ4zwsDYiqotDumPSxrrObK/piv54Nf9p66paMI=;
        b=BwmFLvWusNYl48KgQ2+NqlCI2Z6alcbJhxv0QLXzIvyowbdh7aofFk3vioIi3zSzP/
         jtnF3LI17FlyrI3OPeUAxxRslbiI7L8VnMB1rGnhcYPGeP+mqev2YK2IQdqacrj8KKPx
         7Cehm7uqaPhNClaEirTg21MJgz8gdZ4H6UZis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxQBoQ4zwsDYiqotDumPSxrrObK/piv54Nf9p66paMI=;
        b=zixPu0RLhilhg9Z1PYIEbSzHB2qnlnbtbPh+u6JvvsL2rGkJ16tqy9O0R4cn/a7yua
         jXcRskGpp+PsUc6n5YriSM9Pt2W4/c2lkl3yRzFnw3Owm+dU8ra38CgRuSw06zZo5YNv
         JmPbmei9DuLqTYGMwDxOJqIZiAPnq7vlW7+bOoA3guvYeVAYlqqlElBY8yoCRJb45fDB
         McozFSTHTkBPRRV4/aeZ40pJZrmamuDGhA8lzxx0u/Ka54H6k3Sp+VvzNPiDZfSdXQOY
         wv7zwvwXlcqQVNlqp1MOkUkguO4C0XVwwU9N6kdpw50f6nfejxStSgzdiZyloLvTWEN/
         HwRQ==
X-Gm-Message-State: AFqh2kqh9Hmz3q6C8VWjudv5wxzBzEzDcx9Gqkwd0wrAwdKZ2QxITzsa
        Wz1uGD5XCe3PcZjLY+tBihF24Q==
X-Google-Smtp-Source: AMrXdXunSU7OWCSqkir5WAjEpH9oWdYZa3bVxfv2t+WybCWGEH8h3zGa3Xzk7COxFQja7AbYith8sQ==
X-Received: by 2002:a17:902:e80a:b0:193:38ce:7bb8 with SMTP id u10-20020a170902e80a00b0019338ce7bb8mr25038960plg.37.1673794536919;
        Sun, 15 Jan 2023 06:55:36 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902654c00b00189422a6b8bsm17500374pln.91.2023.01.15.06.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 06:55:36 -0800 (PST)
Date:   Sun, 15 Jan 2023 23:55:32 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2 0/4] zsmalloc: make zspage chain size configurable
Message-ID: <Y8QT5IWy1Gx1bbVi@google.com>
References: <20230109033838.2779902-1-senozhatsky@chromium.org>
 <Y8G3nJ9+k2lB0kas@monkey>
 <Y8JU8iGlu5uLGdDt@google.com>
 <Y8Oo3+9UmZ4ac8sW@google.com>
 <Y8P55Ks8p8SL56VR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8P55Ks8p8SL56VR@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/01/15 13:04), Matthew Wilcox wrote:
> On Sun, Jan 15, 2023 at 04:18:55PM +0900, Sergey Senozhatsky wrote:
> > So this warning is move_to_new_folio() being called on un-isolated
> > src folio. I had DEBUG_VM disabled so VM_BUG_ON_FOLIO(!folio_test_isolated(src))
> > did nothing, however after mops->migrate_page() it would trigger WARN_ON()
> > because it evaluates folio_test_isolated(src) one more time:
> > 
> > [   59.500580] page:0000000097d97a42 refcount:2 mapcount:1665 mapping:0000000000000000 index:0xffffea00185ce940 pfn:0x113dc4
> > [   59.503239] flags: 0x8000000000000001(locked|zone=2)
> > [   59.505060] raw: 8000000000000001 ffffea00044f70c8 ffffc90000ba7c20 ffffffff81c22582
> > [   59.507288] raw: ffffea00185ce940 ffff88809183fdb0 0000000200000680 0000000000000000
> 
> That is quite the messed-up page.  mapcount is positive, but higher than
> refcount.  And not just a little bit; 1665 vs 2.  But mapping is NULL,
> so it's not anon or file memory.  Makes me think it belongs to a driver
> that's using ->mapcount for its own purposes.  It's not PageSlab.
> 
> Given that you're working on zsmalloc, I took a look and:
> 
> static inline void set_first_obj_offset(struct page *page, unsigned int offset)
> {
>         page->page_type = offset;
> }
> 
> (page_type aliases with mapcount).  So I'm pretty sure this is a
> zsmalloc page.  But mapping should point to zsmalloc_mops.  Not
> really sure what's going on here.  Can you bisect?

Thanks.

Let me try bisecting. From what I can tell it seems that
tags/next-20221226 is the last good and tags/next-20230105
is the first bad kernel.

I'll try to narrow it down from here.
