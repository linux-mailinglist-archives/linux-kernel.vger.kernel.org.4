Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F686FC369
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjEIKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjEIKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D94246BD
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED14E62296
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BDFC433D2;
        Tue,  9 May 2023 10:04:21 +0000 (UTC)
Date:   Tue, 9 May 2023 11:04:18 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, izbyshev@ispras.ru, nd@arm.com,
        broonie@kernel.org, szabolcs.nagy@arm.com, lennart@poettering.net
Subject: Re: [PATCH 0/4] MDWE without inheritance
Message-ID: <ZFoaorv+aJDRdyqf@arm.com>
References: <20230504170942.822147-1-revest@chromium.org>
 <ZFQQSKijXQHWlYaI@x1n>
 <CABRcYmJFcUs=3QYXz8iq7qvu2orJ4HL-cHdBKg9o7=Ma=nfPLw@mail.gmail.com>
 <ZFhQcwDBFWcRCC4N@x1n>
 <CABRcYm+RquNGYUyfCEmLrcaoMSKagzwXgto-24ZCaLAdFUKUjg@mail.gmail.com>
 <ZFkCugTkQmZh3sJo@arm.com>
 <ccc1a37b-f0f4-82da-22e8-d7b2a88afb0c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccc1a37b-f0f4-82da-22e8-d7b2a88afb0c@gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2023 at 08:21:16PM +0300, Topi Miettinen wrote:
> On 8.5.2023 17.10, Catalin Marinas wrote:
> > I think we should keep the original behaviour of systemd here, otherwise
> > they won't transition to the new interface and keep using the SECCOMP
> > BPF approach (which, in addition, prevents glibc from setting PROT_BTI
> > on an already executable mapping).
> 
> Systemd has transitioned to prctl(PR_SET_MDWE) method since release of v253,
> so the original behaviour definitely should be kept.

That's great. So yes, no ABI changes allowed anymore.

> > x86 has protection keys and arm64 will soon have permission overlays
> > that allow user-space to toggle between RX and RW (Joey is looking at
> > the arm64 support). I'm not sure how we'll end up implemented this on
> > arm64 (and haven't looked at x86) but I have a suspicion MDWE will get
> > in the way as the base page table permission will probably need
> > PROT_WRITE|PROT_EXEC.
> 
> Wouldn't those features defeat any gains from MDWE? The features probably
> should be forbidden with MemoryDenyWriteExecute=yes.

The permission overlays (controlled by the user) can only further
restrict the mmap() permissions. So MDWE would still work as expected.
If one wants to toggle between RW and RX with overlays, the overall
mmap() needs to be RWX and it won't work if MDWE=yes. No need to
explicitly disable the overlays feature.

On arm64 at least, with the introduction of permission overlays we also
have the notion of "Read, Execute if not Write". This permission
automatically disables Exec if the mapping becomes writable (overlays
can disable writable, allowing exec). We could have a new MDWE policy
which allows this, though I'm not that keen on using it in Linux since
background permission changes done by the kernel can lead to an
unexpected executable permission (e.g. marking a page read-only for
clean/dirty tracking or in preparation for CoW after fork()).

-- 
Catalin
