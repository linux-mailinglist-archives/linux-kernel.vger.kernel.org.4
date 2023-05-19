Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62CDD709C47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjESQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjESQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A058CC9;
        Fri, 19 May 2023 09:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC396591C;
        Fri, 19 May 2023 16:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48C8C433D2;
        Fri, 19 May 2023 16:21:12 +0000 (UTC)
Date:   Fri, 19 May 2023 17:21:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Qun-wei Lin =?utf-8?B?KOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Kuan-Ying Lee =?utf-8?B?KOadjuWGoOepjik=?= 
        <Kuan-Ying.Lee@mediatek.com>,
        Casper Li =?utf-8?B?KOadjuS4reamrik=?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Message-ID: <ZGeh9SSz9DZpfnhC@arm.com>
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com>
 <ZGJtJobLrBg3PtHm@arm.com>
 <ZGLC0T32sgVkG5kX@google.com>
 <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
 <CAMn1gO79e+v3ceNY0YfwrYTvU1monKWmTedXsYjtucmM7s=MVA@mail.gmail.com>
 <c9f1fc7c-62a2-4768-7992-52e34ec36d0f@redhat.com>
 <CAMn1gO7t0S7CmeU=59Lq10N0WvrKebM=W91W7sa+SQoG13Uppw@mail.gmail.com>
 <80f45fec-3e91-c7b3-7fb4-1aa9355c627a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f45fec-3e91-c7b3-7fb4-1aa9355c627a@redhat.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 11:21:35AM +0200, David Hildenbrand wrote:
> > > Sorry, I meant actual anonymous memory pages, not shmem. Like, anonymous
> > > pages that are COW-shared due to fork() or KSM.
> > > 
> > > How does MTE, in general, interact with that? Assume one process ends up
> > > modifying the tags ... and the page is COW-shared with a different
> > > process that should not observe these tag modifications.
> > 
> > Tag modifications cause write faults if the page is read-only, so for
> > COW shared pages we would end up copying the page in the usual way,
> > which on arm64 would copy the tags as well via the copy_highpage hook
> > (see arch/arm64/mm/copypage.c).
> 
> Oh, that makes sense, thanks for pointing that out!
> 
> ... and I can spot that KSM also checks the tag when de-duplicating:
> pages_identical() ends up calling memcmp_pages(), which knows how to deal
> with tags.
> 
> Interestingly, calc_checksum() does not seem to care about tags. But that
> simply implies that pages with the same content have same checksum,
> independent of the tag. And pages_identical() is the single source of truth.

That was my assumption at the time, there would be a memcmp_pages() in
case of checksum collision.

-- 
Catalin
