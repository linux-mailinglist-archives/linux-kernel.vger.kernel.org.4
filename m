Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3F5F13A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiI3UaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiI3UaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:30:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B517DF62;
        Fri, 30 Sep 2022 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GJcHGfGVCmktBV+LdVjLjV4qA2kilpmpBXZeIc/9ch0=; b=MGpB9o6QlKmJMZVXYY8TvYeEVc
        I3bdvalSwDMM3NfVDsGbWF9Tq0fMC1ddMhysrewEUkkY27tIk9TuS0Q9NqTKy+aPxrV3V+BfMnKA0
        NsJeLAqL9O5ShJ8UbcuwmTmhK99Kk1CcdNqIHA+0OYZ4oZHZgcxqA9/mq/y8rff9BWVkjFKMMRUdY
        eLfu3FGMcSRQKwJMl4sDnokfVyQ4MiovexHBpOxFXDPK5tywGximpws7sZq9mss+HMnVF4SQJyPBW
        zC07nMnxRp/Ih2TkOkm48O9+XSj/A66VmgcMzQupSipZYBJUSQEy/2ZKnHc/RWx3iMwNXzvWdHyHU
        70c0GF1A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oeMeA-00BQ0O-6x; Fri, 30 Sep 2022 20:30:10 +0000
Date:   Fri, 30 Sep 2022 13:30:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] module: Merge same-name module load requests
Message-ID: <YzdR0gRNQI2BGnJ9@bombadil.infradead.org>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919123233.8538-3-petr.pavlu@suse.com>
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

On Mon, Sep 19, 2022 at 02:32:33PM +0200, Petr Pavlu wrote:
> During a system boot, it can happen that the kernel receives a burst of
> requests to insert the same module but loading it eventually fails
> during its init call. 

Please take a look at kmod selftest lib/test_kmod.c and the respective shell
selftest tools/testing/selftests/kmod/kmod.sh. Can you modify it to add
support to reproduce this issue?

> For instance, udev can make a request to insert
> a frequency module for each individual CPU 

That seems stupid indeed, it would seem we should be able for sure to prevent
such cases, it can't just be happening for frequency modules.

> when another frequency module
> is already loaded which causes the init function of the new module to
> return an error.

Holy smokes.

> The module loader currently serializes all such requests, with the
> barrier in add_unformed_module(). This creates a lot of unnecessary work
> and delays the boot.

Sure..

> This patch improves the behavior as follows:
> * A check whether a module load matches an already loaded module is
>   moved right after a module name is determined. -EEXIST continues to be
>   returned if the module exists and is live, -EBUSY is returned if
>   a same-name module is going.

OK nice.

> * A new reference-counted shared_load_info structure is introduced to
>   keep track of duplicate load requests. Two loads are considered
>   equivalent if their module name matches. In case a load duplicates
>   another running insert, the code waits for its completion and then
>   returns -EEXIST or -EBUSY depending on whether it succeeded.

Groovy.

> Note that prior to 6e6de3dee51a ("kernel/module.c: Only return -EEXIST
> for modules that have finished loading"), the kernel already did merge
> some of same load requests but it was more by accident and relied on
> specific timing. The patch brings this behavior back in a more explicit
> form.

I'm having a hard time with this, because it is not clear if you are
suggesting this is a regression introduced by 6e6de3dee51a or not. I'd
like you to evaluate the impact of *not* merging a fix to older kernels.
In practice I think we'd end up with delays on boot, but is that all?
Would boot ever fail? The commit log does not make that clear.

The commit log should make it clear if this a regression or not and the
impact of not having these fixes merged. Please not that bots will try
to scrape for fixes and I suspect bots will pour their heart out on this
commit log and identify and assume this if a fix already as-is.

If this *is* a regression, we should try to see how perhaps we can split
this up into a part which is mergable to stable and then a secondary
part which  does some new fancy optimizations.

  Luis
