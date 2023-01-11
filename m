Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9438A666268
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjAKSDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjAKSDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:03:16 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B015FC6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:03:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4EC033A99;
        Wed, 11 Jan 2023 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673460180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bbHjv8f4G8yVHoUHU7VHjKcNPXbqT19MIbDP7lW2Ypw=;
        b=AH95UKrzJ1Zliz+zgEejEfNeedAWYpcTW4dL6WRZ4YuKSDpRhdJmRAgphp/BNidqkNZSdS
        n3efqyXjohG1QoWVwbLTiaMNcMXlfZ2q2fSgmImd3a+aspnHBzE78VhzTqh/A/s5Dz0f4s
        gTF0p1am8yTAw6I0wEVbjPDtyvfku3M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98C9C1358A;
        Wed, 11 Jan 2023 18:03:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /ULTJNT5vmMBBgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 18:03:00 +0000
Date:   Wed, 11 Jan 2023 19:02:59 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        "michel@lespinasse.org" <michel@lespinasse.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "leewalsh@google.com" <leewalsh@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "jglisse@google.com" <jglisse@google.com>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        "arjunroy@google.com" <arjunroy@google.com>,
        "minchan@google.com" <minchan@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "gurua@google.com" <gurua@google.com>,
        "laurent.dufour@fr.ibm.com" <laurent.dufour@fr.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "soheil@google.com" <soheil@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "gthelen@google.com" <gthelen@google.com>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "posk@google.com" <posk@google.com>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "peterjung1337@gmail.com" <peterjung1337@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "hughlynch@google.com" <hughlynch@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tatashin@google.com" <tatashin@google.com>
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
Message-ID: <Y7750ym6lztDoRC0@dhcp22.suse.cz>
References: <20230111001331.cxdeh52vvta6ok2p@offworld>
 <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
 <Y75x5fGPcJ63pBIp@dhcp22.suse.cz>
 <Y76HTfIeEt8ZOIH3@gmail.com>
 <6be809f5554a4faaa22c287ba4224bd0@AcuMS.aculab.com>
 <CAJuCfpH_VZq99=vGQGJ+evVg5wMPKGsjyawgHnOeoKhtEiAi6w@mail.gmail.com>
 <Y77ndimzUsVZwjTk@dhcp22.suse.cz>
 <CAJuCfpEEiFNAgb6TNwibUyTJ1J3b-rEGCSw63TiK6FSA=HCdtw@mail.gmail.com>
 <Y77zwYHMfjOL+9EK@dhcp22.suse.cz>
 <CAJuCfpHCRL5B7SxqTgNbpJqhFwzROX4HAOH5KArO1iXNs_3Kcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHCRL5B7SxqTgNbpJqhFwzROX4HAOH5KArO1iXNs_3Kcg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-01-23 09:49:08, Suren Baghdasaryan wrote:
> On Wed, Jan 11, 2023 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 11-01-23 09:04:41, Suren Baghdasaryan wrote:
> > > On Wed, Jan 11, 2023 at 8:44 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 11-01-23 08:28:49, Suren Baghdasaryan wrote:
> > > > [...]
> > > > > Anyhow. Sounds like the overhead of the current design is small enough
> > > > > to remove CONFIG_PER_VMA_LOCK and let it depend only on architecture
> > > > > support?
> > > >
> > > > Yes. Further optimizations can be done on top. Let's not over optimize
> > > > at this stage.
> > >
> > > Sure, I won't optimize any further.
> > > Just to expand on your question. Original design would be problematic
> > > for embedded systems like Android. It notoriously has a high number of
> > > VMAs due to anonymous VMAs being named, which prevents them from
> > > merging.
> >
> > What is the usual number of VMAs in that environment?
> 
> I've seen some games which had over 4000 VMAs but that's on the upper
> side. In my calculations I used 40000 VMAs as a ballpark number and
> rough calculations before size optimization would increase memory
> consumption by ~2M (depending on the lock placement in vm_area_struct
> it would vary a bit). In Android, the performance team flags any
> change that exceeds 500KB, so it would raise questions.

Thanks, that is a useful information! This is just slightly off-topic
but I ak wondering how much memory those vma names consume. Are there
that many unique names or they just happen to be alternating so that
neighboring ones tend to be different.
-- 
Michal Hocko
SUSE Labs
