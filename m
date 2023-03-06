Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9036AD023
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCFVZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCFVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:25:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE126588
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 13:25:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8176B81116
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 21:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EEEC433EF;
        Mon,  6 Mar 2023 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678137921;
        bh=YdNWw9rYjBG/9fiukR+YyvyAwV7szxHfjCSkWIwiBRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TdOprbhibYOD+CfZdD+VfbtEy0gvykT4dMUU3luivE50KsLD53hRPK+uA/+rdwdbt
         hvwtmp9UaChyKgr65ZL4rDy/nul5P06DAAgEQ65tYTwzWjMEBh6IhzOBwjV+xk4vD4
         D4rD8rWLY/sktA+G1qmA0fH5oODGZaPmkGkrU70o=
Date:   Mon, 6 Mar 2023 13:25:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Stevens <stevensd@chromium.org>
Cc:     "jiaqiyan@google.com" <jiaqiyan@google.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Zach O'Keefe" <zokeefe@google.com>
Subject: Re: [PATCH v4 0/3] mm/khugepaged: fix khugepaged+shmem races
Message-Id: <20230306132520.d7af9143c7cbed6eb08a251a@linux-foundation.org>
In-Reply-To: <CAD=HUj5Ygjyi9pNryH=VSKOUFCvvCcMFtRRAYM0Vdr9LP4mtaA@mail.gmail.com>
References: <20230217085439.2826375-1-stevensd@google.com>
        <ZAIT2YI4WrzZK5NK@x1n>
        <20230303145258.866b985b21b3ccd9bc41bc4b@linux-foundation.org>
        <CAD=HUj5Ygjyi9pNryH=VSKOUFCvvCcMFtRRAYM0Vdr9LP4mtaA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 6 Mar 2023 11:44:59 +0900 David Stevens <stevensd@chromium.org> wrote:

> > Yes please.  Lets gather the acks thus far, rebase on
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm's mm-unstable
> > branch and resend?
> 
> This conflicts pretty heavily with the "Memory poison recovery in
> khugepaged collapsing" series. This series was written on top of v9 of
> that series, but it looks like v9 of that series was dropped and is
> being replaced with v10. Which series should go in first? If we're
> confident that v10 of that series won't also be dropped, then rebasing
> this series onto v10 of that series should be pretty easy. Otherwise
> we could try reworking things to minimize conflicts between the two
> series (create a 0th refactoring series?). Andrew, what course would
> you prefer?

I've merged v10 of "Memory poison recovery in khugepaged collapsing" so
let's base on that please?

"Memory poison recovery in khugepaged collapsing" shows no sign of
review, which is worrisome for a series at version 10.  Hopefully
people will step up soon.  So there's presently a risk that "Memory
poison recovery in khugepaged collapsing" will go away again, so don't
lose the pre-rebase series :(

