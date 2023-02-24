Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413DA6A2162
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 19:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBXSY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 13:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBXSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 13:24:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0781213517
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 10:24:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0108B81CF4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 18:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDF3C433EF;
        Fri, 24 Feb 2023 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677263064;
        bh=KLpV/GVEKy/KsLgMBV7FJaRlFv3lDlFyBPwS+ACw4tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnL9HUjRVk8FtjOuZ1eXSphGfEI3qvqB2Ly2w16Evw/6x8SHLxOD8UQMzIJElEgGs
         Elf9DpEzxSl7ktVM0jlxNklE4CYkmglHdiv68pZk0sfLvTxeHj9seZ91v8naOFR9aU
         httDovbWy2gBQmpxEc9FPDYAHLmPJq1HzIvRxW3/AsAPy0U40mn8JtVrnlJO3pclCt
         wZRIql98Zn8F5hnBzivzxWtTJW93fbj5U3qzDP0NtFKTfuWj7V6yNnllj72vMyGPLG
         ksERvJRvpXEVLcz2U+FRmGC8zT9GPgnrk02C+hNq/5bt+QyrpwjWrvpCoyYsoFbJ0Q
         hxXn3F60w9j1g==
Date:   Fri, 24 Feb 2023 11:24:21 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-ID: <Y/kA1Tp5wIZSiY4q@kbusch-mbp.dhcp.thefacebook.com>
References: <20230221165400.1595247-1-kbusch@meta.com>
 <Y/UHOohEMg+oyO8j@infradead.org>
 <Y/UIZC+plt9Y0nr1@kbusch-mbp>
 <20230223124137.e6fe921659e6f6f1c10668b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223124137.e6fe921659e6f6f1c10668b6@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:41:37PM -0800, Andrew Morton wrote:
> On Tue, 21 Feb 2023 11:07:32 -0700 Keith Busch <kbusch@kernel.org> wrote:
> 
> > On Tue, Feb 21, 2023 at 10:02:34AM -0800, Christoph Hellwig wrote:
> > > On Tue, Feb 21, 2023 at 08:54:00AM -0800, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Some users of the dmapool need their allocations to happen in ascending
> > > > order. The recent optimizations pushed the blocks in reverse order, so
> > > > restore the previous behavior by linking the next available block from
> > > > low-to-high.
> > > 
> > > Who are those users?
> > > 
> > > Also should we document this behavior somewhere so that it isn't
> > > accidentally changed again some time in the future?
> > 
> > usb/chipidea/udc.c qh_pool called "ci_hw_qh".
> 
> It would be helpful to know why these users need this side-effect.  Did
> the drivers break?   Or just get slower?

The affected driver was reported to be unusable without this behavior.
 
> Are those drivers misbehaving by assuming this behavior?   Should we

I do think they're using the wrong API. You you shouldn't use the dmapool if
your blocks need to be arranged in a contiguous address order. They should just
directly use dma_alloc_coherent() instead.

> require that they be altered instead of forever constraining the dmapool
> implementation in this fashion?

This change isn't really constraining dmapool where it matters. It's just an
unexpected one-time initialization thing.

As far as altering those drivers, I'll reach out to someone on that side for
comment (I'm currently not familiar with the affected subsystem).
