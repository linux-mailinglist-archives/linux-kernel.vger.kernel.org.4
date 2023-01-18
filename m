Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A249672A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjARVdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjARVdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:33:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2A35D7FC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:33:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 43D8D5C373;
        Wed, 18 Jan 2023 21:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674077620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7pZDwwkHXBi6TQs0bTATnlfLJxHePp59pNH6+hjByaY=;
        b=aqxWcXoZK36abrfVw7/RkaFoV9G5OwXVTbqZF7541hZRkh7wmcDUyaoUWMfXpa+rggoIxC
        dRlAnEppanHYrid8nc5falTWzW0Gs2cXsJVfhMTekptUZAvCgqM51Iw8aO90Z6AjGMVYGw
        DhRk/TYvEFKgz8v3Mm2mvdGScingIXA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A054139D2;
        Wed, 18 Jan 2023 21:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ByrZBbRlyGN5OgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 18 Jan 2023 21:33:40 +0000
Date:   Wed, 18 Jan 2023 22:33:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
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
Subject: Re: [PATCH 17/41] mm/mmap: move VMA locking before
 anon_vma_lock_write call
Message-ID: <Y8hls4MH353ZnlQu@dhcp22.suse.cz>
References: <20230109205336.3665937-1-surenb@google.com>
 <20230109205336.3665937-18-surenb@google.com>
 <Y8a734ufLZjPHgtT@dhcp22.suse.cz>
 <CAJuCfpGoYaF2-z7FCiN4X8gEGD6nAwnQC+=n3tUHuMWZa7zx8Q@mail.gmail.com>
 <Y8e6lm76fIoT0603@dhcp22.suse.cz>
 <CAJuCfpHtV5xEo97X62uR=LXjK6wQMJXhhV2OxXexTfyudGOptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHtV5xEo97X62uR=LXjK6wQMJXhhV2OxXexTfyudGOptw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-01-23 10:09:29, Suren Baghdasaryan wrote:
> On Wed, Jan 18, 2023 at 1:23 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 17-01-23 18:01:01, Suren Baghdasaryan wrote:
> > > On Tue, Jan 17, 2023 at 7:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 09-01-23 12:53:12, Suren Baghdasaryan wrote:
> > > > > Move VMA flag modification (which now implies VMA locking) before
> > > > > anon_vma_lock_write to match the locking order of page fault handler.
> > > >
> > > > Does this changelog assumes per vma locking in the #PF?
> > >
> > > Hmm, you are right. Page fault handlers do not use per-vma locks yet
> > > but the changelog already talks about that. Maybe I should change it
> > > to simply:
> > > ```
> > > Move VMA flag modification (which now implies VMA locking) before
> > > vma_adjust_trans_huge() to ensure the modifications are done after VMA
> > > has been locked.
> >
> > Because ....
> 
> because vma_adjust_trans_huge() modifies the VMA and such
> modifications should be done under VMA write-lock protection.

So it will become:
Move VMA flag modification (which now implies VMA locking) before
vma_adjust_trans_huge() to ensure the modifications are done after VMA
has been locked. Because vma_adjust_trans_huge() modifies the VMA and such
modifications should be done under VMA write-lock protection.

which is effectivelly saying
vma_adjust_trans_huge() modifies the VMA and such modifications should
be done under VMA write-lock protection so move VMA flag modifications
before so all of them are covered by the same write protection.

right?
-- 
Michal Hocko
SUSE Labs
