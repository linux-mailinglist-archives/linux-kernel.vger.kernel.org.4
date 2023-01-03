Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6995765CA34
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjACXHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbjACXHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:07:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC2B1658C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:07:14 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 141so2799854pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo2bAklBVnxxMEbtvi+fTc+Cr0V9B4d6HxkhJ7AFP6c=;
        b=ht5r4zvtTo9RyXz5PRQmGCmisPXyFKqd+VHQN76nZsB2enR1ynk+f54Q051TEI1SC0
         Hj5+4OLAyw+9SNow/KBRODFH+bSz8KBl4GGO1a6EtDNThDCAsSTG0to3pHajQ6jdcQT5
         vNz3N7/NGk50fnjTeGlSl1U59W8Z68QUEgXhg9tzdKAO8oYMK+axXQ/TRRKDknaJUxiu
         +qKBCv3vH33ONzXzm3k6uskeCQ/tJ9092qUJVi6jpty0AcHmKFhSH1w3GSy1p+tV6pfW
         43i+OIrNaThizYdMShNWY7CrCU/B6UVLbH/3Ob7cN+UBtPjRmKU2xSbYdxuYvJYFa483
         tyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo2bAklBVnxxMEbtvi+fTc+Cr0V9B4d6HxkhJ7AFP6c=;
        b=MfDWr66GUPl/3g5X461SvKwrSMZRp6K7Q7lb72ZZ5OjOPBDetydZ20sj9i8aP7IRsY
         carbfTQHKqO+bv6AgfpN2xT5CqlozMPCDMbegq09Ficu0Zdtq5D0iXTWPcq/G51AejeO
         K8rxwmSZR1ZBLy7dhp8haSrUVu3RvCKDzChu8QqUy9qsw8w33+rS4UWXVljp9kZX474c
         0NT8zrnV5tmdz+I97wVIjfmiBZ/moNeSet5QyujYvxA/tAe2KMNFkZsvuG7xvH55Ijfe
         syug/ZsElgpyL9yw2eDe1uZHmbr0sty/gIZVN9PO5Erd+RuKoUSonyD5FXnBQdLjUZrV
         ky/w==
X-Gm-Message-State: AFqh2kqpoGbQC+YolFgfB9JscDCIFHdTn/87h8+TKsXHyZ099TWWaYYJ
        zkSX4eHfGckeW51hD8SHUoCuoA==
X-Google-Smtp-Source: AMrXdXu/Qu2kVslkUyV/UgP0CyqT+iBW5uRGE1fQNTy6+lDLIUmXebapVA5L6EMfjziK+lmTFEcSbA==
X-Received: by 2002:aa7:85c3:0:b0:582:13b5:d735 with SMTP id z3-20020aa785c3000000b0058213b5d735mr1068335pfn.0.1672787233686;
        Tue, 03 Jan 2023 15:07:13 -0800 (PST)
Received: from [2620:15c:29:203:3ac1:84a4:2f59:c43f] ([2620:15c:29:203:3ac1:84a4:2f59:c43f])
        by smtp.gmail.com with ESMTPSA id b20-20020aa79514000000b00581c4b4c15bsm10729867pfp.142.2023.01.03.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 15:07:13 -0800 (PST)
Date:   Tue, 3 Jan 2023 15:07:12 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: A better dump_page()
In-Reply-To: <Y7RKX45mvwkbiMbo@casper.infradead.org>
Message-ID: <c022ddc3-1cbd-8291-68a3-f90ffb93af84@google.com>
References: <202212312021.bc1efe86-oliver.sang@intel.com> <41276905-b8a5-76ae-8a17-a8ec6558e988@suse.cz> <Y7RKX45mvwkbiMbo@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023, Matthew Wilcox wrote:

> On Tue, Jan 03, 2023 at 11:42:11AM +0100, Vlastimil Babka wrote:
> > Separately we should also make the __dump_page() more resilient.
> 
> Right.  It's not ideal when one of our best debugging tools obfuscates
> the problem we're trying to debug.  I've seen probems like this before,
> and the problem is that somebody calls dump_page() on a page that they
> don't own a refcount on.  That lets the page mutate under us in some
> fairly awkward ways (as you've seen here, it seems to be part of several
> different compound allocations at various points during the dump
> process).
> 
> One possibility I thought about was taking our own refcount on the
> page at the start of dump_page().  That would kill off the possibility
> of ever passing in a const struct page, and it would confuse people.
> Also, what if somebody passes in a pointer to something that's not a
> struct page?  Then we've (tried to) modify memory that's not a refcount.
> 
> I think the best we can do is to snapshot the struct page and the folio
> it appears to belong to at the start of dump_page().  It'll take a
> little care (for example, folio_pfn() must be passed the original
> folio, and not the snapshot), but I think it's doable.
> 

By snapshot do you mean memcpy() of the metadata to the stack?  I assume 
this still leaves the opportunity for the underlying mutation of the page 
but makes the window more narrow.
