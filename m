Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B6663613
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 01:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjAJANG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 19:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjAJANA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:13:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD71403A;
        Mon,  9 Jan 2023 16:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XRn1/eBrDRdzxgypnfDfA6rwyYrJeizsdUmAgoml6qw=; b=CDbk4K3lvFgP+7qgriAr+tTZOx
        nzR6WaGQ0Pffu2IeQcueGVtZjQWEQNbFBsvyuOGvqBgEiIJPYLWpxwWEmWBGlA2KsTKkbRQr30A3R
        aIh9fWL0zedSZj884ghWH3SfLXlganfLkbQInaTTYdZIbrLDfBiOsLQFxPZLwneb+puu4cjtW99O6
        PjC1xmPShJKM1E45z0WpMKAhBO8ZDfuiizE38qq7d7UdVLzI7yfaK2uPG6KBb/r5XGPXSf2QupEGC
        jRCCIGH9mbxYkKIz+8suhDB/NbG9FTK/lJ0YbzNkGZPt/CNCg2DV0cSBSXKoHqt2+SqyHdsBl/p7W
        l3wMJiqg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pF2G5-004ikM-QG; Tue, 10 Jan 2023 00:12:53 +0000
Date:   Mon, 9 Jan 2023 16:12:53 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y7ythXxlzsJkFQcd@bombadil.infradead.org>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
 <Y7wZSxw+Ys5MNf8g@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7wZSxw+Ys5MNf8g@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 02:40:27PM +0100, Petr Mladek wrote:
> Why are try hardly comparable?
> 
> 1. The speed depends on the number of loaded modules
>    and number of symbols. It highly depends on the configuration
>    that was used to build the kernel.
> 
> 2. The test runs only once. As a result it is hard to judge
>    how big is the noise.
> 
> 3. The noise might depend on the size and state of CPU caches.
> 
> 
> I personally vote for removing this selftest!

Even so, just as with testing a filesystem with different types of
configurations, at least testing a few configs helps and it's what
we do. Then, if anyone ever wanted to try to increase performance
on symbol lookup today they have no easy way to measure things. How
would they go about comparing things performance without this selftest?

This selftests helps generically with that *and* helps peg on to it any sanity
checks you may wish to add to those APIs which we just don't want to do
upstream.

That was the rationale behind it, just as with any other selftest.

However, if measuring the time is not possible that's separate topic.
But to say that measuring time on some config is not valuable I think
is not a fair statement. Yes, the noise things are good points, but
the test can be enhanced for that too. And any patch which anyone
in the future would try to propose for new enhancements would likely
be looking at obvious gains beyond any type of noise.

  Luis
