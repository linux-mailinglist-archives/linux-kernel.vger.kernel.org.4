Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEB6587F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 00:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiL1XrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 18:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiL1XrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 18:47:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DCF12762
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 15:47:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 354406164B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 23:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DF1C433EF;
        Wed, 28 Dec 2022 23:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672271229;
        bh=3/RTtSFicmpdJMcYPX+czHQEKMLtoB/Mk0OgRKU9BjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nvt2kaYjYnb3eYuWaail9QKZ+IPZ6IwTquvLqXiTymXSGEj8+qfjT9fzMvjyJmsPW
         MRTr2UmHVPiGc3fZsrwKvRthjxycvDQNHFN3EggKCRGqW7wt9rbacu5+yWqiD9HW05
         sX02ejatj7kd/owmXRIzPUaYU/qQ7sjgPJGv0Z4k=
Date:   Wed, 28 Dec 2022 15:47:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 2/3] mm: vmalloc: Switch to find_unlink_vmap_area()
 in vm_unmap_ram()
Message-Id: <20221228154707.432e8900855122712f98037c@linux-foundation.org>
In-Reply-To: <Y6XaTM+xSlGNjo0e@pc636>
References: <20221222190022.134380-1-urezki@gmail.com>
        <20221222190022.134380-2-urezki@gmail.com>
        <Y6VlA8Mbbv7Ug6tW@infradead.org>
        <Y6XaTM+xSlGNjo0e@pc636>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 17:41:48 +0100 Uladzislau Rezki <urezki@gmail.com> wrote:

> > Don't we also need to remove the manual unlink that was done
> > here previously?   Actually it seems like that manual unlink is missing
> > after patch 1, creating a bisection hazard.  So either add it there,
> > or just fold this patch into the previous one.
> >
> Right. In terms of bisection it is not so good. I think folding is the
> best.
> 
> Andrew, could you please fold this patch into the:

which patch ;)

> [PATCH v3 1/3] mm: vmalloc: Avoid calling __find_vmap_area() twice in __vunmap() ?
> 
> or should i send a v4 instead?

Yes please.
