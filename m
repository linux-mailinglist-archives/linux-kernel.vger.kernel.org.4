Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1425FBB5D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJKT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiJKT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:29:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB857915E2;
        Tue, 11 Oct 2022 12:29:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1197E1F889;
        Tue, 11 Oct 2022 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665516549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nEMUDkYRdfE4vY5mjXK1cb1A3J1MmMksjA+ax0To5uY=;
        b=DDbvC0NQr4SrpJ4gKZjfv1Ri2c5ylwKBQAvdqzYhtAGEl6S4BUR9V7YCc2JNaHMuke8yva
        XslR/rbpoZxGKLhSJJ716TTWzhjSVro49rieJx22SEd+uV+Dz9rq5jVrl1p15ls6BuVHoD
        tYD9YFVmz88Lhtejb5/pR7WGaHHqNSo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 167F4139ED;
        Tue, 11 Oct 2022 19:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zgCVLgPERWNzSAAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 11 Oct 2022 19:29:07 +0000
Date:   Tue, 11 Oct 2022 21:29:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Frank van der Linden <fvdl@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
Message-ID: <Y0XEAUD9Ujcu/j8y@dhcp22.suse.cz>
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com>
 <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz>
 <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-10-22 10:22:23, Frank van der Linden wrote:
> On Tue, Oct 11, 2022 at 8:00 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 10-10-22 09:22:13, Frank van der Linden wrote:
> > > For consistency with process_madvise(), I would suggest calling it
> > > process_set_mempolicy.
> >
> > This operation has per-thread rather than per-process semantic so I do
> > not think your proposed naming is better.
> 
> True. I suppose you could argue that it should have been
> pidfd_madvise() then for consistency, but that ship has sailed.

madvise commands have per mm semantic. It is set_mempolicy which is
kinda special and it allows to have per task_struct semantic even when
the actual allocation is in the same address space. To be honest I am
not really sure why that is this way because threads aim to share memory
so why should they have different memory policies?

I suspect that the original thinking was that some portions that are
private to the process want to have different affinities (e.g. stacks
and dedicated per cpu heap arenas). E.g. worker pools which want to be
per-cpu local with their own allocations but operate on shared data that
requires different policies.

> > > Other than that, this makes sense. To complete
> > > the set, perhaps a process_mbind() should be added as well. What do
> > > you think?
> >
> > Is there any real usecase for this interface? How is the caller supposed
> > to make per-range decisions without a very involved coordination with
> > the target process?
> 
> The use case for a potential pidfd_mbind() is basically a combination
> of what is described for in the process_madvise proposal (
> https://lore.kernel.org/lkml/20200901000633.1920247-1-minchan@kernel.org/
> ), and what this proposal describes: system management software acting
> as an orchestrator that has a better overview of the system as a whole
> (NUMA nodes, memory tiering), and has knowledge of the layout of the
> processes involved.

Well, per address range operation is a completely different beast I
would say. External tool would need to a) understand what that range is
used for (e.g. stack/heap ranges, mmaped shared files like libraries or
private mappings) and b) by in sync with memory layout modifications
done by applications (e.g. that an mmap has been issued to back malloc
request). Quite a lot of understanding about the specific process. I
would say that with that intimate knowledge it is quite better to be
part of the process and do those changes from within of the process
itself.
-- 
Michal Hocko
SUSE Labs
