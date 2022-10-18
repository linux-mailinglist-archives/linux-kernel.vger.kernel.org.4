Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82026602EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJROjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJROjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:39:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE94BF5E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z6yxKpH3CxfuQtgoIMIZtd4wXwIYmAepPnY2ExrBrmY=; b=S7s0BHcTB5Z6UOFQKXnl4dWQtt
        hKdrTVnxrWlrHoFp5Jwt+u3vHG0QLX79hcQQVKX4VaqBaUja9r+dav153uB/VcSdwVxWQlBTOHgpX
        9OvjBDsZSyX43tkrBWlWrDkjqACCC6EQ5RINuFwbQh2qgSzGrQyP/6EkUVJDF2mCuru6fI4fxy1NR
        6Igp+kUuFgGkazUhiLJdHfstC1cGjdQNfYuiZrY114mM0cADm5wDRIQqym6TqeKSA/pi0DWen4qfl
        a6OFtosAWLHu5g/D9n3FZRMti5sSJ1B109isb03KVXGv0H/DW+CaxAuz6EKLR6GSnGgQV5rar3/5G
        yS5kaGnA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oknkp-00Ao5S-3Z; Tue, 18 Oct 2022 14:39:39 +0000
Date:   Tue, 18 Oct 2022 15:39:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tuo Cao <91tuocao@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: folio-compat: fix bug for pagecache_get_page
Message-ID: <Y066q/QNrBSRjPux@casper.infradead.org>
References: <20221018143639.5099-1-91tuocao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018143639.5099-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:36:39PM +0800, Tuo Cao wrote:
> The folio returned from __filemap_get_folio may be a NULL, it will
> causes the kernel crash when access folio->page.

This is not a bug.  &folio->page does not dereference folio but performs
pointer arithmetic.
