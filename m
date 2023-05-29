Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C489714C07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjE2O0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjE2O0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:26:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8067D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JwR+VvEo7klsGIAN09oZ3+x143GWG+P2Mr6+8jvTA/c=; b=CpORWdNkf2JUeaRqYnYiCYBYl3
        0U4mN6Aa7JLEiOKmbvdEXFj4ZrOzADYZVfHvLYVyAyxdgPzPWJuBg79sJj3SBm9uzxPsZNhwwaWts
        P/3UowknltxnqrlZHhwyzaPNfgZje2lXeNFLtwLPNAP9Z7z51uBc90xT2w1R4Za46B4DN3IjK56WX
        cL++p7C4OTxkQcjFYnmSqjOWZMW9XFvZZhpKlt8tUqYvfITlJJNAP9C8wiY94/mvEl6w68GrV5va8
        nQOp4aWLlC9G/f1O7fIb4lDu2LHkRteWQznQS79utEufNISqlge4QADmcsU5dEMqLkXFTwie6sTZp
        vB8Vi9CQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3dp4-005TMF-OG; Mon, 29 May 2023 14:26:10 +0000
Date:   Mon, 29 May 2023 15:26:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH -next] mm: page_alloc: simplify has_managed_dma()
Message-ID: <ZHS2AgVvrT3n/hlM@casper.infradead.org>
References: <20230529144022.42927-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529144022.42927-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 10:40:22PM +0800, Kefeng Wang wrote:
> The ZONE_DMA should only exists on Node 0, only check NODE_DATA(0)
> is enough, so simplify has_managed_dma() and make it inline.

That's true on x86, but is it true on all architectures?
