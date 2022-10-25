Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261C060D79C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiJYXCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiJYXB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:01:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687FFA033;
        Tue, 25 Oct 2022 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4xBh6lmQB8ZveERjf1mkFKtSo4J+qiH97xfWC9y5NiU=; b=DmJwtAXeP7qFjgljdUcmMr8Q95
        X3QtXQOPb1jFsgSGxGp3Wf21dJlm64nQXy5vICZgHql1xk1oRvl3cnsl7L7zYkl/Qh8EVga8CTOkV
        OfkC5XGpk2YZDnaDztFHuu+rrWNGyzeI+UewaJ2bSJuOC//BbG4nm06N2fozVEQffyJjYpNXMF8JI
        FKva1/ep9Fl/EIP4lVG0iddTP29cS1Z9b/F+7eaArBDWXXXr+DhdsrNQZFqPbFA/cf6OlnWTvXKgg
        D8YjYUkkH66zxJPneTxTqVE+q6BCwb3FDWHT9Ztr1+X5TkQ373JKXKXwKwmeb/1Mdf2j0/TLFkz8x
        gQRCMDKg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onSvh-007UH1-U9; Tue, 25 Oct 2022 23:01:53 +0000
Date:   Tue, 25 Oct 2022 16:01:53 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     pmladek@suse.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests: kmod: Add tests for merging same-name
 module load requests
Message-ID: <Y1hq4UT5qXROyLka@bombadil.infradead.org>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-5-petr.pavlu@suse.com>
 <Y1giEusr0/sGNrGC@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1giEusr0/sGNrGC@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 10:51:14AM -0700, Luis Chamberlain wrote:
> On Sun, Oct 16, 2022 at 02:30:31PM +0200, Petr Pavlu wrote:
> > diff --git a/tools/testing/selftests/kmod/init_module.c b/tools/testing/selftests/kmod/init_module.c
> > @@ -525,6 +662,8 @@ list_tests()
> >  	echo "0011 x $(get_test_count 0011) - test completely disabling module autoloading"
> >  	echo "0012 x $(get_test_count 0012) - test /proc/modules address visibility under CAP_SYSLOG"
> >  	echo "0013 x $(get_test_count 0013) - test /sys/module/*/sections/* visibility under CAP_SYSLOG"
> > +	echo "0014 x $(get_test_count 0014) - test handling of parallel loads, success case"
> > +	echo "0015 x $(get_test_count 0015) - test handling of parallel loads, init returning error"
> 
> Good stuff!
> 
> So test 0015 mimics the error reported by Prarit Bhargava through
> commit 6e6de3dee51a ("kernel/module.c: Only return -EEXIST for modules
> that have finished loading")? If so it would be good to document that
> here.
> 
> Also, this patch should go first, with the ALL_TESTS variable set to
> disable the tests which are known to fail, so to demonstrate the *new*
> issues as they are failing and then your fix first and then you enable
> that test afterwards.
> 
> If 6e6de3dee51a introduced another regression which is not covered
> by the tests we'd add it, and fix on top of it as a stepping stone
> to prove / send to stable.

On second though, this could also be made into a self-contained C code
test within lib/test_kmod.c:

  * You'd extend kmod_test_case with a new enum, say TEST_KMOD_INIT_RACES
  * You could extend run_request() to run the series of tests required.
  * request_module() does not allow you to specify module parameters,
    but we could have optional support added, and make the existing
    request_module() always pass that empty / NULL.

Kind of like lib/test_vmalloc.c which has an array of tests, you can peg
new tests to the TEST_KMOD_INIT_RACES for it.

Let me know what folks think.

  Luis
