Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB89470CCEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjEVVwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEVVwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:52:23 -0400
Received: from out-16.mta0.migadu.com (out-16.mta0.migadu.com [91.218.175.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9FF4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:52:21 -0700 (PDT)
Date:   Mon, 22 May 2023 17:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684792339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QAvJ/iGAbjIjEqSRGRTpOEUvtc5je7nuG2/VHxeajg=;
        b=GMQNOnt/tNnvMQcLA0Upi3kPKexsfbDfLa5CVBPx1OMBMtpCahn5sC97sd7FdGoTJ87WEF
        iCDNXt/YNJyDtPAEaruyIEXua/Xh2eUDec5lCt9MGhO65WR6UFFUC6oA9//0Rrv5bkCX9z
        yUdE9lxX6Yle+bfRaNMnPPeJyzZmVao=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH v2] locking: SIX locks (shared/intent/exclusive)
Message-ID: <ZGvkEFjNJSQHopAT@moria.home.lan>
References: <20230522171314.1953699-1-kent.overstreet@linux.dev>
 <CAHk-=wi3vkmsiEDF=kYSAV2f1e1B6J6L-oikmdik6p_kBq_dhg@mail.gmail.com>
 <ZGvM2nqmft0IbB2U@moria.home.lan>
 <CAHk-=wgxN65O-F3R5detmma2MDjDRn4S_qkeKVCCp95c5+gYmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgxN65O-F3R5detmma2MDjDRn4S_qkeKVCCp95c5+gYmA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:53:36PM -0700, Linus Torvalds wrote:
> On Mon, May 22, 2023 at 1:13 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > Uh, I think you're wrong on this one - structs with designated
> > initializers have unspecified fields initialized to 0
> 
> That's definitely true for unspecified fields.
> 
> But there *are* no fields. Only padding.
> 
> That said, gcc does seem to always initialize the whole thing. We even
> rely on it when it comes to structures, but I'm not sure it's strictly
> standardized - and I'm particularly not sure about unions.
> 
> But there are counter-examples, like this:
> 
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104607
> 
> so maybe even structures aren't always initialized fully?

Yeah, I have to concede - if we can't rely on struct padding being
initialized we can't rely on union padding either.

> No, Because of *alignment* issues.
> 
> An u32 is 4-byte aligned. But "set_bit()" requires "long" alignmnent,.

Ah - right...
