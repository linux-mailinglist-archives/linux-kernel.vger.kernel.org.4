Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F003718870
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjEaR06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEaR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:26:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB86B3;
        Wed, 31 May 2023 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZlYXTvMPPoyNkYCzDSbnHuIBA8+r7I6kL4vk9lXh4mw=; b=MSc5Ledswh5eEpBqUjCJ6iCehO
        6p/lAC1Q0ut6WKN3LIXw/70+c/hbCtlk7Qgl3Oy0Kb9JJumepV0Gxkpk6vKhrWjEpTr5Rr8gzcD+X
        OgA4EPZGqI/V5pMS/2ax7VvDu1Tqnp8hPEiABjhIb9zrQejz1l1d021q2vsz4rTqvNPW3wcEget7T
        XZVWSfRexEnbtF7Pl9GW07o1t5rfpZ9KZ6Np5aLf4iBXKMy1DOPUH65ZGMsKhBGjpP8kAdjrxUvjg
        9wSc8Tau+jxKVqoDVDz5p2X9CHxB3ItYiYs8AJscp5UJakKbx+iYc9SPlNl8FO7MYlWhUvRx1QjMq
        Z90gUM7Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Pas-000ctW-1h;
        Wed, 31 May 2023 17:26:42 +0000
Date:   Wed, 31 May 2023 10:26:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, thunder.leizhen@huawei.com, boqun.feng@gmail.com,
        vincenzopalazzodev@gmail.com, ojeda@kernel.org, jgross@suse.com,
        brauner@kernel.org, michael.christie@oracle.com,
        samitolvanen@google.com, glider@google.com, peterz@infradead.org,
        keescook@chromium.org, stephen.s.brennan@oracle.com,
        alan.maguire@oracle.com, pmladek@suse.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH v2 2/2] kallsyms: add kallsyms_show_value defination in
 all cases
Message-ID: <ZHeDUgHZcA1eiEaA@bombadil.infradead.org>
References: <20230531084745.877337-1-maninder1.s@samsung.com>
 <CGME20230531084808epcas5p4a782bf6bb5655f2d320c246057e7bb63@epcas5p4.samsung.com>
 <20230531084745.877337-2-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531084745.877337-2-maninder1.s@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 02:17:45PM +0530, Maninder Singh wrote:
>  include/linux/kallsyms.h | 10 +++-----
>  kernel/Makefile          |  2 +-
>  kernel/kallsyms.c        | 35 ---------------------------
>  kernel/knosyms.c         | 52 ++++++++++++++++++++++++++++++++++++++++

You missed my point of the value of doing a move to a new file and
making it easier for folks to review. For instance I am giving up on
reviewing this patch alone because you made all these changes to a new
file *and* also included a functional change in it. Think about it from
a reviewer perspective, you want to make their life easier, not harder.

So, to do that you first move all the stuff into a new file with 0
functional changes. Then, you make a functional change as a separate
commit. So this becomes 3 commits then.

Sit back and then think after you have done this: does it make sense
then afterwards to re-arrange the order of the patches so to make it
easier for folks to review this patchset? If so what order should
I put those changes in? I don't know the answer to this question but
just think about it once you have done that.

For instance, confirming there was 0 functional changes to your first
patch actually took me about 3 minutes or so, how can you reduce the
time to review to a few seconds for a non-functional change? Work on
your commit logs and your changes in light of this so to make patch
review easier.

  Luis
