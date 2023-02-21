Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4469E6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjBUSID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjBUSH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:07:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B0030292
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:07:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE538B80FA7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 18:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE90C433D2;
        Tue, 21 Feb 2023 18:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677002855;
        bh=inZczsHsYNaB8VKdgJwc3kO+Gw7OxcbGlqiKZIegzf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgT9u5AsvrvQUMJGcCHyMcQV1lZHxpzuCak/p36lArw5KxSKkV7KRrw2x7+30NoTI
         qJqOILMqrZnuwLysM2/BOEq4ArVad09Rh/Pn/sO/iTNEwAefTYJh3F5vvM/cZm/KFI
         YvFj/0MSG0w5kJ8HPYjYBg0BjqRu3U/fhuJr19/lFsYcJLCsWIICa6YF4nM41oT+Jg
         72n3gv1hRI7yQB8kAgByQlH2U0wMe8qzlQNKOVm1KeOHkfBDRkHZTnBVh0yuSH7jcU
         adu48etsnWkEfy9kTGEPPmCpSqjQryhyLwCs8H36LaUWN+h14n8pb7l1FpWwKmkhlG
         cJPwmbGbm5X2A==
Date:   Tue, 21 Feb 2023 11:07:32 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@meta.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
Message-ID: <Y/UIZC+plt9Y0nr1@kbusch-mbp>
References: <20230221165400.1595247-1-kbusch@meta.com>
 <Y/UHOohEMg+oyO8j@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UHOohEMg+oyO8j@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 10:02:34AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 21, 2023 at 08:54:00AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Some users of the dmapool need their allocations to happen in ascending
> > order. The recent optimizations pushed the blocks in reverse order, so
> > restore the previous behavior by linking the next available block from
> > low-to-high.
> 
> Who are those users?
> 
> Also should we document this behavior somewhere so that it isn't
> accidentally changed again some time in the future?

usb/chipidea/udc.c qh_pool called "ci_hw_qh". My initial thought was dmapool
isn't the right API if you need a specific order when allocating from it, but I
can't readily test any changes to that driver. Restoring the previous behavior
is easy enough.
