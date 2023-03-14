Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652D16BA343
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 00:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCNXAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 19:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCNXAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 19:00:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFF5CC20;
        Tue, 14 Mar 2023 16:00:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1317B819C4;
        Tue, 14 Mar 2023 23:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1FFC433D2;
        Tue, 14 Mar 2023 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678834842;
        bh=k7dCrxTFioFlmhd3pSkn4+iIIbmSdXDvCzI6LDaxT3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A0yRbXnMyNBzqdtNex8pvZa5BXCEjOJVDVCgsTVVpZnKeL+1s7QZgnwP42X4GKfJ6
         O3s6sPCYRb1jt8tZxwoOYe2la3JFIxp6BY4JSjSx+ES7jYrn04Q4TUaQj54RKQwEnt
         o8yMFXJpMwfXM4spRqvPXkgUyukRthQq7l+hFEv0=
Date:   Tue, 14 Mar 2023 16:00:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v11 0/3] cachestat: a new syscall for page cache state
 of files
Message-Id: <20230314160041.960ede03d5f5ff3dbb3e3fd0@linux-foundation.org>
In-Reply-To: <20230308032748.609510-1-nphamcs@gmail.com>
References: <20230308032748.609510-1-nphamcs@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Mar 2023 19:27:45 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> There is currently no good way to query the page cache state of large
> file sets and directory trees. There is mincore(), but it scales poorly:
> the kernel writes out a lot of bitmap data that userspace has to
> aggregate, when the user really doesn not care about per-page information
> in that case. The user also needs to mmap and unmap each file as it goes
> along, which can be quite slow as well.

A while ago I asked about the security implications - could cachestat()
be used to figure out what parts of a file another user is reading. 
This also applies to mincore(), but cachestat() newly permits user A to
work out which parts of a file user B has *written* to.

I don't recall seeing a response to this, and there is no discussion in
the changelogs.


Secondly, I'm not seeing description of any use cases.  OK, it's faster
and better than mincore(), but who cares?  In other words, what
end-user value compels us to add this feature to Linux?


>    struct cachestat {
>	        __u64 nr_cache;
>	        __u64 nr_dirty;
>	        __u64 nr_writeback;
>	        __u64 nr_evicted;
>	        __u64 nr_recently_evicted;
>    };

And these fields are really getting into the weedy details of internal
kernel implementation.  Bear in mind that we must support this API for
ever.

Particularly the "evicted" things.  The workingset code was implemented
eight years ago, which is actually relatively recent.  It could be that
eight years from now it will have been removed and possibly replaced
workingset with something else.  Then what do we do?

For these reasons, and because of the lack of enthusiasm I have seen
from others, I don't think a case has yet been made for the addition of
this new syscall.
