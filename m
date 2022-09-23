Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A75E8617
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiIWWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiIWWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:54:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455413EE9E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:54:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C59761D9C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D548CC433C1;
        Fri, 23 Sep 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663973654;
        bh=gCJ8DR840inCdFEFB4zVuogQsDTiryXsoN5Cs3aTkmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=raUysYcQlgcKkCEAXtNM5kTHYKgQujoGqIyUz8/cM6rL/oebYKznvjyMEy8KqlQaG
         6+z3oy4Lq1TU9tNsJRyShPGIa4oU45HDrGB7VukzoNL07s2nEAnkFahOAPEfzdW5HP
         rw0ycj+7bxLEb8kMoZ2iMoTNqRRtQZypLVc/tZ8Y=
Date:   Fri, 23 Sep 2022 15:54:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] minmax: clamp more efficiently by avoiding extra
 comparison
Message-Id: <20220923155412.b0132fc62eca18817a023cd2@linux-foundation.org>
In-Reply-To: <20220923154001.4074849-1-Jason@zx2c4.com>
References: <CAHmME9rH47UFp6sXbDU0UZrTosFrDAa+m_FtqMqRFFNzmOzTdA@mail.gmail.com>
        <20220923154001.4074849-1-Jason@zx2c4.com>
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

On Fri, 23 Sep 2022 17:40:01 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> Currently the clamp algorithm does:
> 
> 	if (val > hi)
> 		val = hi;
> 	if (val < lo)
> 		val = lo;
> 
> But since hi > lo by definition, this can be made more efficient with:
> 
> 	if (val > hi)
> 		val = hi;
> 	else if (val < lo)
> 		val = lo;
> 
> So fix up the clamp and clamp_t functions to do this, adding the same
> argument checking as for min and min_t.
> 

The patch adds 140 bytes of text to mm/memblock.o, for example. 
Presumably from the additional branch.  Larger text means larger cache
footprint means slower.

So where's the proof that this change gives us a more efficient kernel?
