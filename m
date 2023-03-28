Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE996CB333
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjC1BeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1BeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:34:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49611BE3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zQ9VeEDyCA7TnGkpi51WEjNMAth9a21cJDmTyCBeKrY=; b=FdRXTEhP4fiKtOfl2MvCCVteNH
        Fo3U7UTA2yZgYD3H14feKB3/xobaCEz5ViNsJPFbiOUjpOpNNt6UMx+03KbQ5u4DOJ6llKB6OZEGY
        0Svg2J/UQEc+8lpJAOnZxiBr9qEffDpC/6sPwPMhM+vc7G+Fc3w4P/DP9cq/jk2QnUsBEygyY1WKu
        gsDk25xVJ/RohDGD0qIZRkq8X3L8P9dZFdwgHvofx4yehBGbUWmeyLefExGnX40ki3kgD9GcQKv0n
        jbkYkXmp5ouMUxqMJnteRWABe85ItB8HzfZPnxKh/dzeWL17oxzjzJYtY6jF+tYiegdSVjzdy0aYe
        LSghjNPA==;
Received: from [2001:67c:370:128:c3d7:7f40:ffee:c8b6] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgyDl-00Cmz6-2P;
        Tue, 28 Mar 2023 01:33:57 +0000
Date:   Tue, 28 Mar 2023 10:33:55 +0900
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] swiotlb: Track and report io_tlb_used high water
 mark in debugfs
Message-ID: <ZCJEAx/G0x6zokPF@infradead.org>
References: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679766790-24629-1-git-send-email-mikelley@microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:53:10AM -0700, Michael Kelley wrote:
> @@ -659,6 +663,14 @@ static int swiotlb_do_find_slots(struct device *dev, int area_index,
>  	area->index = wrap_area_index(mem, index + nslots);
>  	area->used += nslots;
>  	spin_unlock_irqrestore(&area->lock, flags);
> +
> +	new_used = atomic_long_add_return(nslots, &total_used);
> +	old_hiwater = atomic_long_read(&used_hiwater);
> +	do {
> +		if (new_used <= old_hiwater)
> +			break;
> +	} while (!atomic_long_try_cmpxchg(&used_hiwater, &old_hiwater, new_used));
> +
>  	return slot_index;

Hmm, so we're right in the swiotlb hot path here and add two new global
atomics?

>  static int io_tlb_used_get(void *data, u64 *val)
>  {
> -	*val = mem_used(&io_tlb_default_mem);
> +	*val = (u64)atomic_long_read(&total_used);
>  	return 0;
>  }
> +
> +static int io_tlb_hiwater_get(void *data, u64 *val)
> +{
> +	*val = (u64)atomic_long_read(&used_hiwater);

I can't see how these casts would be needed.
