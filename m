Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA30665520
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjAKH12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAKH1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:27:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26569103;
        Tue, 10 Jan 2023 23:27:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9364C61A36;
        Wed, 11 Jan 2023 07:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71144C433EF;
        Wed, 11 Jan 2023 07:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673422043;
        bh=UNsE1Sfj5VIoaJ3hwnzx1FJI4j5UgDzN3GkA3q+AUVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxD1oUY/RiJXEOCbw6ek4gNpqHM0mBLH6ylbuGTsQAmrEb31BsclPpX+2w001z2pN
         wUn2V4BtVR/nBTABTB5MnBq06fXVLWWfWRrD0RIISkXhqA5EOFB1nTdr5j5bRpUP3f
         ZxIKCi4iBi5pmrl0OWhPYkSqWrgS8L44gJpC1UDmdu4s/T6YO1bkVqdB2GTAK1Bcod
         VSVPPxRe8wziAVI8YJRZZtr6lhVzI7fDpKtki8x8Swdnsl3VwZimXrvodTZCDZlrM9
         NHE74X7+o/MQvCYmP1ytwFRCo8LJMBdxHdGiwm1G9qPq8jL925wbDD5CKFYMhW4uaX
         0kJUFhw7jl+Qw==
Date:   Tue, 10 Jan 2023 23:27:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        mlichvar@redhat.com
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y75k2KaDz2WdcXLk@sol.localdomain>
References: <20230101162910.710293-1-Jason@zx2c4.com>
 <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <874jt0kndq.fsf@oldenburg.str.redhat.com>
 <CAHk-=wg7vMC2VmSBdVw7EKV+7UDiftQEg3L+3Rc0rcjjfsvs5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg7vMC2VmSBdVw7EKV+7UDiftQEg3L+3Rc0rcjjfsvs5A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 08:28:58AM -0600, Linus Torvalds wrote:
> On Mon, Jan 9, 2023 at 4:34 AM Florian Weimer <fweimer@redhat.com> wrote:
> >
> > We did these changes on the glibc side because Jason sounded very
> > confident that he's able to deliver vDSO acceleration for getrandom.  If
> > that fails to materialize, we'll just have to add back userspace
> > buffering in glibc.
> 
> My whole argument has been that user-space buffering is the sane thing
> to do. Most definitely for something like glibc.
> 
> The number of people who go "oh, no, my buffer or randomness could be
> exposed by insert-odd-situation-here" is approximately zero, and then
> the onus should be on *them* to do something special.
> 
> Because *they* are special. Precious little snowflake special.
> 
>              Linus

How would userspace decide when to reseed its CRNGs, then?

IMO, the main benefit of the VDSO getrandom over a traditional userspace CRNG is
that it makes reseeds of the kernel's CRNG take effect immediately.  See the
cover letter, where Jason explains this.

It's definitely important to make the memory used by userspace CRNGs have
appropriate semantics, but my understanding is that's not the main point.

- Eric
