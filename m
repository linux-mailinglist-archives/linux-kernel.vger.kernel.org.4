Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC856605E68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJTLEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJTLEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E5339B9D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AD+e24i8Ref8qIYMEpCGeOzUC9xnTOhryaDJIjaHufg=; b=qL6joa2Hh7+V/6vITPUrbfQF7H
        SrsEFcgORMljDqKtQuhqo2Q6zZKCvrP9CMFh/3dV/We7xtRuXVubN8sJ5Dm+C9Ix7EFNKFziQAkBd
        hBcs1EQxxeK591VZeUotVkvPn75F3kAzEnPWY191EOjyb0jcKOdjzfyrQtB5VryCOvwOV657QF1fQ
        akgfpQeSEoILawZ2moP4kcHeZExD03BW56mT8EnwNj0pVDzE6RrkChJBS17wnYOvDnwNitVvhD0WI
        qQxoi6FmZG2i7vjKNtJu/fbyn8MWbpWeZl/jRX6cz1PXYjig2/dg5YcuPaPi5IL7umhjTn8EkjG/I
        QvKgEb+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olTLt-00CJwe-3T; Thu, 20 Oct 2022 11:04:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F85A300110;
        Thu, 20 Oct 2022 13:04:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E70F9266F3CAF; Thu, 20 Oct 2022 13:04:34 +0200 (CEST)
Date:   Thu, 20 Oct 2022 13:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>, x86@kernel.org,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
Message-ID: <Y1ErQo06mIREKudf@hirez.programming.kicks-ass.net>
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook>
 <Y08FhjK3fKsfRAaw@hirez.programming.kicks-ass.net>
 <202210182200.50680AE@keescook>
 <Y0/npwZ3UO9+ZSS4@hirez.programming.kicks-ass.net>
 <CABCJKudc4uS87oxdXyXOyuoT1XqwR4ARrS2N9htGbz1y016AcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudc4uS87oxdXyXOyuoT1XqwR4ARrS2N9htGbz1y016AcQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:22:17AM -0700, Sami Tolvanen wrote:
> On Wed, Oct 19, 2022 at 5:03 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 18, 2022 at 10:05:26PM -0700, Kees Cook wrote:
> > >
> > > The one glitch here is that the resulting hash needs to not contain
> > > an endbr...
> >
> > Oh right,.. duh. How about something like:
> >
> > static u32 cfi_rehash(u32 hash)
> > {
> >         hash ^= cfi_hash;
> >         while (unlikely(is_endbr(hash))) {
> >                 bool lsb = hash & 1;
> >                 hash >>= 1;
> >                 if (lsb)
> >                         hash ^= 0x80200003;
> >         }
> >         return hash;
> > }
> >
> > Which seems properly over-engineered :-)
> 
> Also, -hash can't be endbr with KCFI since we use that in the check itself.

Indeed, updated and pushed out. queue/x86/fineibt should have it
momentarily.
