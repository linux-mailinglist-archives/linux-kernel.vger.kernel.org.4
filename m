Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D702B6ED78D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjDXWIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjDXWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AAF5FE4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C110162987
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 22:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB48C4339B;
        Mon, 24 Apr 2023 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1682374047;
        bh=HByyQifs96c18FNN/v288o+8EnsWfHwi6zdKQPZ0gd8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cZ6Jq8E6rRBrz16vl3O1vh+ktQtbQJchzfkGEkCOIS4TMOJH3tJ93KA8feGoPJ41l
         0IdDHnI1Oru8/8uWqrzYLZ+GpJ9BMZ5/QcORfOoYwmPhoVcT6yCYGjWBLG9LT5dKpa
         X040AEif+tnRisK/OlZiPisgI3iX8F6wUVFXPvVs=
Date:   Mon, 24 Apr 2023 15:07:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        David Stevens <stevensd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] mm/khugepaged: fix conflicting mods to
 collapse_file()
Message-Id: <20230424150726.a53d3ebe47ad84e55e16d4a6@linux-foundation.org>
In-Reply-To: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com>
References: <b6c881-c352-bb91-85a8-febeb09dfd71@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Apr 2023 21:47:20 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> Inserting Ivan Orlov's syzbot fix commit 2ce0bdfebc74
> ("mm: khugepaged: fix kernel BUG in hpage_collapse_scan_file()")
> ahead of Jiaqi Yan's and David Stevens's commits
> 12904d953364 ("mm/khugepaged: recover from poisoned file-backed memory")
> cae106dd67b9 ("mm/khugepaged: refactor collapse_file control flow")
> ac492b9c70ca ("mm/khugepaged: skip shmem with userfaultfd")
> (all of which restructure collapse_file()) did not work out well.
> 
> xfstests generic/086 on huge tmpfs (with accelerated khugepaged) freezes
> (if not on the first attempt, then the 2nd or 3rd) in find_lock_entries()
> while doing drop_caches: the file's xarray seems to have been corrupted,
> with find_get_entry() returning nonsense which makes no progress.
> 
> Bisection led to ac492b9c70ca; and diff against earlier working linux-next
> suggested that it's probably down to an errant xas_store(), which does not
> belong with the later changes (and nor does the positioning of warnings).
> The later changes look as if they fix the syzbot issue independently.
> 
> Remove most of what's left of 2ce0bdfebc74: just leave one WARN_ON_ONCE
> (xas_error) after the final xas_store() of the multi-index entry.
> 

Sigh.  Thanks.  I thought I'd successfully sorted that mess out.
