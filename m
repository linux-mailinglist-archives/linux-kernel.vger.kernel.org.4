Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFA670DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjAQXr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAQXrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:47:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5133E4A1C6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 14:55:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E34A661518
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159F0C433D2;
        Tue, 17 Jan 2023 22:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673996133;
        bh=ruz2A/4YTpx7OPy42aBIYAuAK+3AVNnrNmXTqZhAjSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=y/ZuQQ+p4hfhGFe69OrMaDXIxXOokePloiIt8MOIBxTvN/X+vyXL5rhQec1Pzm04+
         gcdtWeEbgYuzL8dWjHGim2Y0ieXi8BTCLiW1odv162eAAjFcLBfLHRL7mXCbQ9w9mF
         yXOz2S3kJUauib96LWDIOZtj1rULvC2hyVwYNOA4=
Date:   Tue, 17 Jan 2023 14:55:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Zach O'Keefe" <zokeefe@google.com>, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/khugepaged: Fix ->anon_vma race
Message-Id: <20230117145532.94132510f8bc538d5465fd43@linux-foundation.org>
In-Reply-To: <CAG48ez36Nio9GzU_m168AEJMXxtcNtdgq6YpAhLq-aKNQA_9fg@mail.gmail.com>
References: <20230111133351.807024-1-jannh@google.com>
        <CAG48ez36Nio9GzU_m168AEJMXxtcNtdgq6YpAhLq-aKNQA_9fg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 20:12:49 +0100 Jann Horn <jannh@google.com> wrote:

> On Wed, Jan 11, 2023 at 2:33 PM Jann Horn <jannh@google.com> wrote:
> > If an ->anon_vma is attached to the VMA, collapse_and_free_pmd() requires
> > it to be locked. retract_page_tables() bails out if an ->anon_vma is
> > attached, but does this check before holding the mmap lock (as the comment
> > above the check explains).
> 
> @akpm please replace the commit message with the following, and maybe
> also add a "Link:" entry pointing to
> https://lore.kernel.org/linux-mm/CAG48ez3434wZBKFFbdx4M9j6eUwSUVPd4dxhzW_k_POneSDF+A@mail.gmail.com/
> for the reproducer.

Done, thanks.
