Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CE16655F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 09:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjAKIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 03:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjAKIXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 03:23:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96962738
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 00:23:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 497FA16EFE;
        Wed, 11 Jan 2023 08:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673425382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EfwiP2dC1eDqP+D8JpK5Kyw3QfggSfn8KfyWpOLYNw8=;
        b=Y1DVgH1VkYVUd/qgGeY7SSd5DUn1ebzNMhQ32O2WBJ0H2JlsmHRmT+tBkerjErOyobL92s
        6Ii1Lh3Zi0B/UVP0axrNxOmSNPAcLOSv4PIWvBT/PZkNQTPGs8ATon8ga5K3HkK3ZdTfpE
        iqPWwga9fQWZnl5Cofn+JACQBZ2dDWE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E85613591;
        Wed, 11 Jan 2023 08:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZcAEB+ZxvmMSQgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 08:23:02 +0000
Date:   Wed, 11 Jan 2023 09:23:01 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
Message-ID: <Y75x5fGPcJ63pBIp@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld>
 <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-01-23 16:44:42, Suren Baghdasaryan wrote:
> On Tue, Jan 10, 2023 at 4:39 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> > On Mon, 09 Jan 2023, Suren Baghdasaryan wrote:
> >
> > >This configuration variable will be used to build the support for VMA
> > >locking during page fault handling.
> > >
> > >This is enabled by default on supported architectures with SMP and MMU
> > >set.
> > >
> > >The architecture support is needed since the page fault handler is called
> > >from the architecture's page faulting code which needs modifications to
> > >handle faults under VMA lock.
> >
> > I don't think that per-vma locking should be something that is user-configurable.
> > It should just be depdendant on the arch. So maybe just remove CONFIG_PER_VMA_LOCK?
> 
> Thanks for the suggestion! I would be happy to make that change if
> there are no objections. I think the only pushback might have been the
> vma size increase but with the latest optimization in the last patch
> maybe that's less of an issue?

Has vma size ever been a real problem? Sure there might be a lot of
those but your patch increases it by rwsem (without the last patch)
which is something like 40B on top of 136B vma so we are talking about
400B in total which even with wild mapcount limits shouldn't really be
prohibitive. With a default map count limit we are talking about 2M
increase at most (per address space).

Or are you aware of any specific usecases where vma size is a real
problem?

-- 
Michal Hocko
SUSE Labs
