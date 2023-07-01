Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F8744BD3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 01:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGAXzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 19:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAXzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 19:55:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6B71738;
        Sat,  1 Jul 2023 16:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EGbpfu+7zj9QDynkv2BuJJyCce8y05I7B9YU353+MuM=; b=ke43e7Emdmpw75iq6GyjCOLhBq
        lbqUFx5ia3hlZ4byhRDIiTiY3cXI/HFBsj7uPv4EL7S4oEp/tBzIHve1uND8bcyzy7ueAKH0yQ1E+
        TeSlZBbXStGlzcrB1HbF2ahyhwAKFimZG3u17XLP4gm16pXonSUQXvW8V697JBHuRiUjzJdmzHI29
        5TvNcQrquOs3VgAQvCsuh9QeNxJJHNOrL2P91RJVMBtS+Hd4mkewOF+B8JXfGYqoPJv7xRlp804yO
        HpusuG3s19sIX7zAMuT/RWYnzACVP5M5X20DYCQtQYPmrf1Xbs9CWqB/hOe/e2soD35VgO9cKhUIa
        YzHO4g3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qFkQC-006xKE-H1; Sat, 01 Jul 2023 23:54:32 +0000
Date:   Sun, 2 Jul 2023 00:54:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deming Wang <wangdeming@inspur.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Collingbourne <pcc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] Documentation/mm: Add information about
 kmap_local_folio()
Message-ID: <ZKC8uE9fE57PuL91@casper.infradead.org>
References: <20230701142041.9992-1-fmdefrancesco@gmail.com>
 <68a9b3aa-d064-ed6a-2bcd-9423eb4f595c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a9b3aa-d064-ed6a-2bcd-9423eb4f595c@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 08:21:20AM -0700, Randy Dunlap wrote:
> > -* kmap_local_page().  This function is used to require short term mappings.
> > -  It can be invoked from any context (including interrupts) but the mappings
> > -  can only be used in the context which acquired them.
> > -
> > -  This function should always be used, whereas kmap_atomic() and kmap() have
> > +* kmap_local_page(), kmap_local_folio() - These functions are used to require
> 
>                                                                          acquire ?

"create" might be better?

> > +  short term mappings. They can be invoked from any context (including
> > +  interrupts) but the mappings can only be used in the context which acquired
> > +  them. The only differences between them consist in the first taking a pointer
> > +  to a struct page and the second taking a pointer to struct folio and the byte
> > +  offset within the folio which identifies the page.
> 
> -- 
> ~Randy
