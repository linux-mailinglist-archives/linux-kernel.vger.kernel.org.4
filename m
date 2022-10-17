Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DA601C44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJQWYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJQWY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:24:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08A81B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 15:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E38CB81B34
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A2DC433C1;
        Mon, 17 Oct 2022 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666045465;
        bh=+x+l8r2NKIHANVqCIxgQ1cv0f2hMruT2QoeXCGRiBT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hzzRItBdMigq+W7Qu9bd22P1K+6XDTA0aQdVxHAelY9GiIwHaYU1X4gBCW7DeYNhk
         wlPKRGh0vhBz7oyYmF4sT6DcSS4bLmpKyovMoC5Z9KTJPDzdh+le277juOz51DjMOL
         myIp96Tjhq4G+Wsk965p2FAOWp6dKO5V+NeZOHmM=
Date:   Mon, 17 Oct 2022 15:24:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: Panic/lockup in z3fold_zpool_free
Message-Id: <20221017152423.37a126325b4330e71cf8f869@linux-foundation.org>
In-Reply-To: <4433520.LvFx2qVVIh@natalenko.name>
References: <6f834faddf927b6fa5a8edd8adfde63c@natalenko.name>
        <2650550.mvXUDI8C0e@natalenko.name>
        <Y01/DOMdAJQPDaxZ@bfoster>
        <4433520.LvFx2qVVIh@natalenko.name>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Oct 2022 18:34:50 +0200 Oleksandr Natalenko <oleksandr@natalenko.name> wrote:

> > > > I'll give it a try. The only problem is that for me the issue is not reproducible at will, it can take 1 day, or it can take 2 weeks before the panic is hit.
> > > > 
> > > > > [1] https://lore.kernel.org/linux-mm/YxDyZLfBdFHK1Y1P@bfoster/
> > > > > [2] https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/
> > > 
> > > So far, I haven't reproduced this issue with your patch. I haven't run the machine sufficiently long, just under a week, so this is rather to let you know that I haven't abandoned testing.
> > > 
> > 
> > Thanks for the update. Is this still going well, or reached a point
> > where you typically see the problem? I can still reproduce the original
> > problem so I may have to ping the patch again..
> 
> So far, no issue observed with your patch.

Thanks.

It's actually unclear (to me) why Matthew's b653db77350c73 ("mm: Clear
page->private when splitting or migrating a page") was considered
necessary.  What problem did it solve?

https://lore.kernel.org/linux-mm/20220906190602.1626037-1-bfoster@redhat.com/
is a partial undoing of that change, but should we simply revert
b653db77350c73?
