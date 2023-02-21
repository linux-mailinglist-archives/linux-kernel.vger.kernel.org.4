Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8D69E6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBUSCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBUSCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:02:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3920F94
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1XB4oCS6CHHF0AIEzch0IHKDTwchheWarRHgnJZhslg=; b=e3+WDgziFd2vucgPtJlq9tlxAk
        045GDm/UXJAGGlM2fMgRzWLxRUyowENiA7FUDIJJQi12/IMQBEpHtgQ+5ckTMIbfrJbIzcQXIbB3F
        7OP1k8wASWRGAM0zIMmsCHr7BZhB2B30V7fF/i7hPRVCnhhKPh5OodqwKQxG0MC/pzLl/gUypTsFE
        +B2b4Ce5d/u7mrDc6MFX3m7+iFYuowfG/IEjMOwIFjb5jrFwBqwe9/lgu47QMk6lYu3jHHJT79Nji
        50V30WNu1TLguiGQq1kAkKWf8A6v1gma9mWJazLehIy75R3mfCIFy3gEtY+9DJ3bw0hEhu9yATrKy
        /emGxfjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUWyI-009GfE-31; Tue, 21 Feb 2023 18:02:34 +0000
Date:   Tue, 21 Feb 2023 10:02:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-ID: <Y/UHOohEMg+oyO8j@infradead.org>
References: <20230221165400.1595247-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221165400.1595247-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 08:54:00AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some users of the dmapool need their allocations to happen in ascending
> order. The recent optimizations pushed the blocks in reverse order, so
> restore the previous behavior by linking the next available block from
> low-to-high.

Who are those users?

Also should we document this behavior somewhere so that it isn't
accidentally changed again some time in the future?
