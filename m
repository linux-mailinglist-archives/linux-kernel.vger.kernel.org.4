Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC3D7492BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjGFAoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGFAoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:44:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAB19A9;
        Wed,  5 Jul 2023 17:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2101E617D8;
        Thu,  6 Jul 2023 00:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC35C433C7;
        Thu,  6 Jul 2023 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1688604282;
        bh=aEC6PCPk3DBXeBBrvw5oME0/w9hJPSVa0CwOwDzK5eA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZHoiWE6ijdvrCAMom8HCoWZK5cb2gf0Tfw/24RivBzOPbokC20IXa0XpVfmEjlESo
         v1S4ZyPbcfhogeLVhTwMpVtIQxmEJRAzCVhwtL8qsIG17d9MqyIVNVzoc6D6HIxjeL
         EKQw1TOIKypxdrpKc9vqsOhVRC6DXGsMZBo0Hba0=
Date:   Wed, 5 Jul 2023 17:44:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        jirislaby@kernel.org, jacobly.alt@gmail.com,
        holger@applied-asynchrony.com, hdegoede@redhat.com,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com, paulmck@kernel.org,
        mingo@redhat.com, will@kernel.org, luto@kernel.org,
        songliubraving@fb.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: disable CONFIG_PER_VMA_LOCK until its fixed
Message-Id: <20230705174440.9adb53f2e362056867135b84@linux-foundation.org>
In-Reply-To: <CAJuCfpGWW7wsrtqi4rZUz4vxW-N0CaUEeUqY4e7iX1hzgRsT2g@mail.gmail.com>
References: <20230705171213.2843068-1-surenb@google.com>
        <20230705171213.2843068-3-surenb@google.com>
        <3cdaa7d4-1293-3806-05ce-6b7fc4382458@redhat.com>
        <CAJuCfpGTNF9BWBxZoqYKSDrtq=iJoN1n8oTc=Yu0pPzW8cs8rQ@mail.gmail.com>
        <ZKXRsQC8ufiebDGu@x1n>
        <CAJuCfpGHRfK1ZC3YmF1caKHiR7hD73goOXLKQubFLuOgzCr0dg@mail.gmail.com>
        <20230705172424.e505f5013bfdf44543d9c6be@linux-foundation.org>
        <CAJuCfpFLRePeOsrSg--5GtWbC1M5y21Sq7gzrs1vVEUE7C+30A@mail.gmail.com>
        <CAJuCfpGWW7wsrtqi4rZUz4vxW-N0CaUEeUqY4e7iX1hzgRsT2g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 17:32:09 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> On Wed, Jul 5, 2023 at 5:30 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Wed, Jul 5, 2023 at 5:24 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 5 Jul 2023 13:33:26 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > > I was hoping we could re-enable VMA locks in 6.4 once we get more
> > > > confirmations that the problem is gone. Is that not possible once the
> > > > BROKEN dependency is merged?
> > >
> > > I think "no".  By doing this we're effectively backporting a minor
> > > performance optimization, which isn't a thing we'd normally do.
> >
> > In that case, maybe for 6.4 we send the fix and only disable it by
> > default without marking BROKEN? That way we still have a way to enable
> > it if desired?
> 
> I'm preparing the next version with Liam's corrections. If the above
> option I suggested is acceptable I can send a modified second patch
> which would not have BROKEN dependency.

I think just mark it broken and move on.  At some later time we can
consider backporting the fixes into 6.4.x and reenabling, but I don't
think it's likely that we'll do this.

