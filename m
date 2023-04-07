Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ED36DA897
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 07:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjDGFuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 01:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjDGFuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 01:50:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6879768
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 22:50:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88ECE67373; Fri,  7 Apr 2023 07:50:16 +0200 (CEST)
Date:   Fri, 7 Apr 2023 07:50:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        decui@microsoft.com, tiala@microsoft.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] swiotlb: Track and report io_tlb_used high
 water mark in debugfs
Message-ID: <20230407055016.GA6803@lst.de>
References: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1680324300-124563-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 09:45:00PM -0700, Michael Kelley wrote:
> Changes in v3:
> * Do high water mark accounting only when CONFIG_DEBUG_FS=y. As
>   as a result, add back the mem_used() function for the "swiotlb
>   buffer is full" error message. [Christoph -- I didn't hear back
>   whether this approach addresses your concern about one additional
>   atomic operation when slots are allocated and again when freed. I've
>   gone ahead with this new version, and we can obviously have further
>   discussion.]

Still not too happy, but at least debugfs is an interfact we could
remove at any time.

But can you please factor the used_hiwater accounting into two
separate helpers that are udner CONFIG_DEBUG_FS and otherwise
stubbed out, instead of adding the logic directly into
swiotlb_do_find_slots and swiotlb_release_slots?
