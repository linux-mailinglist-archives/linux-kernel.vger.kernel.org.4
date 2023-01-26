Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC15667D847
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjAZWWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjAZWWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:22:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE4A26B
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:22:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C5D0B81F2E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 22:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74658C433EF;
        Thu, 26 Jan 2023 22:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674771730;
        bh=3/AiSICW5vNFWqX6LG5+8wag9HTQwnSvnQLqRX3oDy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1RGUsvCQUSbGenUgzNa1gqs3GhID/oxuPvRFN2or8fx+8opOxd7FE8z6p7hdV3hLX
         fRphbf8tqXhY+5xsfyRBrb+oSnmeer56OZNE9utejjdLERs7GHL15x1HjjKdR/rPoP
         5Fw8L0OSyNX4LX8e55zd5kTx7Ay5TBNw2AGcNBG8=
Date:   Thu, 26 Jan 2023 14:22:09 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>, <hch@lst.de>, <tonyb@cybernetics.com>,
        <kernel-team@meta.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 00/12] dmapool enhancements
Message-Id: <20230126142209.b3546fc52f3f13ddcda67bac@linux-foundation.org>
In-Reply-To: <20230126215125.4069751-1-kbusch@meta.com>
References: <20230126215125.4069751-1-kbusch@meta.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Thu, 26 Jan 2023 13:51:13 -0800 Keith Busch <kbusch@meta.com> wrote:

> Time spent in dma_pool alloc/free increases linearly with the number of
> pages backing the pool. We can reduce this to constant time with minor
> changes to how free pages are tracked.

Do we have any performance testing results for realistic workloads?
