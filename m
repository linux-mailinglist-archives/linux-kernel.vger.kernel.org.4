Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288E16608E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjAFVnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFVnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:43:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B3C82F43;
        Fri,  6 Jan 2023 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JIVcLmmyA6/m+YiOwB7DFkkX+oWdAkbzFPPqwaVy8WY=; b=j0bkeeFMEsRakLw1tzZ97Qcjr2
        fMJY7Fxe4ZF7tc0SURp8dpL2Ow9Uu2YBygIcZIxjQeB5m7w8GE8zW7QCBrNV179lXrtQaP4ePRATi
        1TJEzTkljdgsz7FUDMDF8WjfnVP361xy6iaMRxYmy+b829Fh7lzodyMlv8pM4Mk5DXxt93EjvnyFV
        KIezkNoLiLhVhGAQxFxwjvToJb7GqXE1tIBWKlUlEA/Tq6IUNO+LukGPZkpOQCDL2gV0VQogwW6Nk
        NUIsOqd7JzRCX2Hu433a4Ym6WbpYd69/uwECIk+3wbLNWNr5B/keRf1ZTC6K13p0SxqIWl4sUhbDu
        3VpY5E5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDuUC-00HWiP-0T; Fri, 06 Jan 2023 21:42:48 +0000
Date:   Fri, 6 Jan 2023 21:42:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yann Droneaud <ydroneaud@opteya.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Y7iV18CqKAa4gO9r@casper.infradead.org>
References: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
 <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com>
 <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 06:08:28PM -0800, Linus Torvalds wrote:
> Side note: making the 32-bit issue go away is likely trivial. We can
> make 'vm_flags' be 64-bit, and a patch for that has been floating
> around for over a decade:
> 
>    https://lore.kernel.org/all/20110412151116.B50D.A69D9226@jp.fujitsu.com/
> 
> but there was enough push-back on that patch that I didn't want to
> take it, and some of the arguments for it were not that convincing (at
> the time).
> 
> But see commit ca16d140af91 ("mm: don't access vm_flags as 'int'"),
> which happened as a result, and which I (obviously very naively)
> believed would be a way to get the conversion to happen in a more
> controlled manner. Sadly, it never actually took off, and we have very
> few "vm_flags_t" users in the kernel, and a lot of "unsigned long
> flags". We even started out with a "__nocast" annotation to try to
> make sparse trigger on people who didn't use vm_flags_t properly. That
> was removed due to it just never happening.
> 
> But converting things to vm_flags_t with a coccinelle script
> (hand-wave: look for variables of of "unsigned long" that use the
> VM_xyz constants), and then just making vm_flags_t be a "u64" instead
> sounds like a way forward.

I'd be more inclined to do:

typedef unsigned int vm_flags_t[2];

and deal with all the fallout.  That'll find all the problems (although
leave us vulnerable to people forgetting which half of the flags they
want to be looking at).

Hm.  We never actually converted vma->vm_flags to be vm_flags_t.  Only
vm_region, which aiui is only used on nommu.
