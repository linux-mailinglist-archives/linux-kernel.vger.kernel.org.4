Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C533663D60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjAJJ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjAJJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:57:24 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411123FA37;
        Tue, 10 Jan 2023 01:57:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CE2FE68047;
        Tue, 10 Jan 2023 09:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673344641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYiFsvOd9DaUW/Bik6oFtS/5QMzJseiokzUiGsM94OQ=;
        b=ssRLogHVhAdCHzN1aK3/yjpHN9pfoDRPdRDqYcBNW/cHkuHGUq4RsOlmWfKt+II6mvw7xF
        nbfKBo8oRGcsFh49/QqcHt0anzLmId9TVl0Fe4ATCU3O6w3uWWztOId6asaZaWExq/ZkWL
        7oPT5zBkzdfYKggaOM8AXpv3JbcXGq4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B2E0B2C141;
        Tue, 10 Jan 2023 09:57:21 +0000 (UTC)
Date:   Tue, 10 Jan 2023 10:57:21 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y702gW+5P5EepCkG@alley>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
 <Y7wZSxw+Ys5MNf8g@alley>
 <Y7ythXxlzsJkFQcd@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7ythXxlzsJkFQcd@bombadil.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-01-09 16:12:53, Luis Chamberlain wrote:
> On Mon, Jan 09, 2023 at 02:40:27PM +0100, Petr Mladek wrote:
> > Why are try hardly comparable?
> > 
> > 1. The speed depends on the number of loaded modules
> >    and number of symbols. It highly depends on the configuration
> >    that was used to build the kernel.
> > 
> > 2. The test runs only once. As a result it is hard to judge
> >    how big is the noise.
> > 
> > 3. The noise might depend on the size and state of CPU caches.
> > 
> > 
> > I personally vote for removing this selftest!
> 
> Even so, just as with testing a filesystem with different types of
> configurations, at least testing a few configs helps and it's what
> we do. Then, if anyone ever wanted to try to increase performance
> on symbol lookup today they have no easy way to measure things. How
> would they go about comparing things performance without this selftest?

How many people cares about kallsyms performance, please?
Is it worth spending time one implementing and maintaining such a
selftest?

Yes, Zhen wanted to make it faster. But how likely will anyone else
try to make it even better? Do we need to spend time on this
in the meantime?


> This selftests helps generically with that *and* helps peg on to it any sanity
> checks you may wish to add to those APIs which we just don't want to do
> upstream.

From my POV, it would be much more important to check if the API
works as expected. I mean that it gives the right results.

I am not sure that performance is that important to spend more time
on this one.

Also I am not sure if selftests are the right location for performance
tests. My understanding is that it is a framework for functional
testing. It is showing if the tests passed or not. But performance
tests do not give "pass or not" results.

Best Regards,
Petr
