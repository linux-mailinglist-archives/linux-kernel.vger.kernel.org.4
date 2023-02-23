Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56C6A1158
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBWUlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBWUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:41:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCB3B0E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:41:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AFAEB801B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754D9C433EF;
        Thu, 23 Feb 2023 20:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677184898;
        bh=TkXUXLA5gBCZu3aLudamBdXUQkmB7SrL7qYmG/yX4YU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fpA/zVq26DSk1Xn0u6GHkpwL7TNHAzwg1Brm4v94vivxGsmOx+qmTraUAMuHJXKVt
         DD8hIazyVdt8PUJLFVXcZe0HojBur1YUBqMpbJ4ZnzGvRNcwUXRFMYxp7KQCTKkiv4
         IJkpVoBUYZpvWcCohBlQe2JJ+jgHv30VGuee35CM=
Date:   Thu, 23 Feb 2023 12:41:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-Id: <20230223124137.e6fe921659e6f6f1c10668b6@linux-foundation.org>
In-Reply-To: <Y/UIZC+plt9Y0nr1@kbusch-mbp>
References: <20230221165400.1595247-1-kbusch@meta.com>
        <Y/UHOohEMg+oyO8j@infradead.org>
        <Y/UIZC+plt9Y0nr1@kbusch-mbp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 11:07:32 -0700 Keith Busch <kbusch@kernel.org> wrote:

> On Tue, Feb 21, 2023 at 10:02:34AM -0800, Christoph Hellwig wrote:
> > On Tue, Feb 21, 2023 at 08:54:00AM -0800, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Some users of the dmapool need their allocations to happen in ascending
> > > order. The recent optimizations pushed the blocks in reverse order, so
> > > restore the previous behavior by linking the next available block from
> > > low-to-high.
> > 
> > Who are those users?
> > 
> > Also should we document this behavior somewhere so that it isn't
> > accidentally changed again some time in the future?
> 
> usb/chipidea/udc.c qh_pool called "ci_hw_qh".

It would be helpful to know why these users need this side-effect.  Did
the drivers break?   Or just get slower?

Are those drivers misbehaving by assuming this behavior?   Should we
require that they be altered instead of forever constraining the dmapool
implementation in this fashion?
