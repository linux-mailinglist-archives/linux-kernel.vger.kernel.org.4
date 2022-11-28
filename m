Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F2463AE40
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiK1RAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiK1Q75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:59:57 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A80E558E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:59:54 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id r15so7305204qvm.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXdDTBqVegaar+pLWmnzFVWbntmDwb7qj9MvTJ7r5tA=;
        b=SpduupwX9+hgKbJAt1uBrr8GR8cVFBKX0qw5ONERsYzdWfB/N9QQYj9qCTlogNAj9M
         kEK1FZaNNPnXmtE+uVPtkinRgEpJ1JoknUQoYwGF0Q32h29zIr9jgsAs8IBYPk+9JHOn
         Su5WwW7J6E51pqICAcNNXMFqDgpDkcudvpSBi+GuH7OKHiHtB7StrdVPvzjyKor5dNKH
         qSYxxiWRzhj/yNfWFvtLA5Lw0fHWShpuoKz07eFZ+qSags11ZrQ6yOn7HI7EsRUagcth
         y3wAQAJjBGqBze7yEFUSoIPh0PUs+jQdGn2yb51ZjJ1Qw/2m/kffiVI1MZUrJWniHcRb
         5pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXdDTBqVegaar+pLWmnzFVWbntmDwb7qj9MvTJ7r5tA=;
        b=YwYzD9qsjPmvV+fpoQoGNfKCpV3pUc6APDu2V5Af7XsG++EhEkSwhoam2CUz44xGfY
         hcXHVyO5T/TAgetEoT9JcnDPPqk9fkjCsnkLc6rU/ExA28AxY2Jkd/+nksC82TcdZbZR
         oGPwyusL/L/FojyU+1WcSn2d0cLrsd/OF+7aIIyV2VxZU+X1oXi50O94gt9O42vYrtlg
         jGcskZkcwVDde6b1ov1jj5w9fqz4S7m9AthJmcSb4/mCgg705+TQlcvNBH0DCfAtRKEN
         U937yGHbBjlBNjjf+7COKlRTIaqDDH9X2mvc9Yp0mmp7mgGaPHwg7e64MqwU5RwLN7g6
         q0Aw==
X-Gm-Message-State: ANoB5pnLQQkqVBtBhkba0loP+tgx3anJ7oCennLmVC9zUTJQ2HKprIiw
        298Px4k5qIZ2YZ2WSx2OMCFIox8emLLKwA==
X-Google-Smtp-Source: AA0mqf6YL2EMCu1emEAeBljTAyGqg+e4upqSkexn0n7tt8PvbvgqT5YQUqibJtyHYwze4hQcv1N9Yg==
X-Received: by 2002:a05:6214:328f:b0:4c6:82cd:92d1 with SMTP id mu15-20020a056214328f00b004c682cd92d1mr32083981qvb.82.1669654793427;
        Mon, 28 Nov 2022 08:59:53 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-9175-2920-760a-79fa.res6.spectrum.com. [2603:7000:c01:2716:9175:2920:760a:79fa])
        by smtp.gmail.com with ESMTPSA id s23-20020ac85297000000b003a5430ee366sm7141054qtn.60.2022.11.28.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:59:53 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:59:52 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: remove lock_page_memcg() from rmap
Message-ID: <Y4TpCJ+5uCvWE6co@cmpxchg.org>
References: <20221123181838.1373440-1-hannes@cmpxchg.org>
 <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16dd09c-bb6c-6058-2b3-7559b5aefe9@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:03:00PM -0800, Hugh Dickins wrote:
> On Wed, 23 Nov 2022, Johannes Weiner wrote:
> > rmap changes (mapping and unmapping) of a page currently take
> > lock_page_memcg() to serialize 1) update of the mapcount and the
> > cgroup mapped counter with 2) cgroup moving the page and updating the
> > old cgroup and the new cgroup counters based on page_mapped().
> > 
> > Before b2052564e66d ("mm: memcontrol: continue cache reclaim from
> > offlined groups"), we used to reassign all pages that could be found
> > on a cgroup's LRU list on deletion - something that rmap didn't
> > naturally serialize against. Since that commit, however, the only
> > pages that get moved are those mapped into page tables of a task
> > that's being migrated. In that case, the pte lock is always held (and
> > we know the page is mapped), which keeps rmap changes at bay already.
> > 
> > The additional lock_page_memcg() by rmap is redundant. Remove it.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Thank you, I love it: but with sorrow and shame, NAK to this version.
> 
> I was gearing up to rush in the crash fix at the bottom, when testing
> showed that the new VM_WARN_ON_ONCE(!folio_mapped(folio)) actually hits.
> 
> So I've asked Stephen to drop this mm-unstable commit from -next for
> tonight, while we think about what more is needed.
> 
> I was disbelieving when I saw the warning, couldn't understand at all.
> But a look at get_mctgt_type() shatters my illusion: it's doesn't just
> return a page for pte_present(ptent), it goes off looking up swap
> cache and page cache; plus I've no idea whether an MC_TARGET_DEVICE
> page would appear as folio_mapped() or not.

Thanks for catching this.

A device_private pte always has a matching mapcount in the fake page
it points to, so we should be good here. Those pages migrate back and
forth between system and device memory, relying on the migration
code's unmap and restore bits. Hence they participate in regular rmap.

The swapcache/pagecache bit was a brainfart. We acquire the folio lock
in move_account(), which would lock out concurrent faults. If it's not
mapped, I don't see how it could become mapped behind our backs. But
we do need to be prepared for it to be unmapped.

> Does that mean that we just have to reinstate the folio_mapped() checks
> in mm/memcontrol.c i.e. revert all mm/memcontrol.c changes from the
> commit?  Or does it invalidate the whole project to remove
> lock_page_memcg() from mm/rmap.c?

I think we have to bring back the folio_mapped() conditional and
update the comments. But it shouldn't invalidate the whole project.

I'll triple check this, however.

Thanks
