Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5167C54D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjAZIAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbjAZIAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:00:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FC169B2C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:59:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 702451FEC1;
        Thu, 26 Jan 2023 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674719984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8phw8z9lSY7iQJCq6VYkn4UUEHCEZ7ZXKi1c7gTwrM4=;
        b=qTWifsp9kR6tUF5RbmZkPrFSDZSuoNzYFU4i42xM+2e0bl32CICy762Ehn1A7cN9EuqmJ0
        AZkmevMfJIwKOy1HC8U/GL4eP9OHTN67Q3TI95rlLJfzptW0842juEEEyO6mRIlygvAJd6
        Y1BtkkMiEmx1HmgPqlW1Wt0jsVYn2mI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42F671358A;
        Thu, 26 Jan 2023 07:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rFjmD/Ay0mMFJwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 07:59:44 +0000
Date:   Thu, 26 Jan 2023 08:59:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
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
Subject: Re: [PATCH v3 2/7] mm: introduce vma->vm_flags wrapper functions
Message-ID: <Y9Iy7zhJsaHCzdF/@dhcp22.suse.cz>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-3-surenb@google.com>
 <20230125162810.ec222773d13cd26c55991fde@linux-foundation.org>
 <CAJuCfpFWTNpz7LB+931Gc+yYwBq3-y+_doH2WdtjhTGnxLxvig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFWTNpz7LB+931Gc+yYwBq3-y+_doH2WdtjhTGnxLxvig@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-01-23 16:56:17, Suren Baghdasaryan wrote:
> On Wed, Jan 25, 2023 at 4:28 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 25 Jan 2023 15:35:49 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -491,7 +491,15 @@ struct vm_area_struct {
> > >        * See vmf_insert_mixed_prot() for discussion.
> > >        */
> > >       pgprot_t vm_page_prot;
> > > -     unsigned long vm_flags;         /* Flags, see mm.h. */
> > > +
> > > +     /*
> > > +      * Flags, see mm.h.
> > > +      * To modify use {init|reset|set|clear|mod}_vm_flags() functions.
> > > +      */
> > > +     union {
> > > +             const vm_flags_t vm_flags;
> > > +             vm_flags_t __private __vm_flags;
> > > +     };
> >
> > Typically when making a change like this we'll rename the affected
> > field/variable/function/etc.  This will reliably and deliberately break
> > unconverted usage sites.
> >
> > This const trick will get us partway there, by breaking setters.  But
> > renaming it will break both setters and getters.
> 
> My intent here is to break setters but to allow getters to keep
> reading vma->vm_flags directly. We could provide get_vm_flags() and
> convert all getters as well but it would introduce a huge additional
> churn (800+ hits) with no obvious benefits, I think. Does that clarify
> the intent of this trick?

I think that makes sense at this stage. The conversion patch is quite
large already. Maybe the final renaming could be done on top of
everything and patch generated by coccinele. The const union is a neat
trick but a potential lockdep assert is a nice plus as well. I wouldn't
see it as a top priority though.
-- 
Michal Hocko
SUSE Labs
