Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9CF73D97C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjFZISO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFZISM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34395
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bX3GKkivlGqKtau6aT0ZWFoAsoXorNhDrWoD2Qk0BYc=; b=CNybrfXPdEDAxK0BL7QydXiUFk
        hWBkk0vZarcJkiCekkz169F22TLh0Wt1hNDUQFm+2Ra+7euiyfUfxA4dWcZ4qZFM94k/owtyJnysM
        oGonRvTe/rcJt1ls6tpC1r1ycwV59lWma4U8Q/N14KOEriBAHTJNk7AMqgMCHqTUykKa1d83RaM0Z
        gKMRyWyQfh06Te4VZf1oG2bySXHiAXNYCZYN0RHQudPzifH3jhPMxFRwmzQpou+rv9f5A9HOWLRKe
        U5idfy87ZnEDaqL18YsD5GcWTXy0gVWt5Y80uj+9A4WRI4CMdzmOy0/i6W0/wVJ6cGy+tTqS4Hmm2
        XOCaY7/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qDhQ9-001WP2-Fr; Mon, 26 Jun 2023 08:18:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1ED2C3002A9;
        Mon, 26 Jun 2023 10:18:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF25F2024C49A; Mon, 26 Jun 2023 10:17:59 +0200 (CEST)
Date:   Mon, 26 Jun 2023 10:17:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, osandov@fb.com,
        jpoimboe@kernel.org
Subject: Re: [GIT PULL] objtool/urgent for v6.4
Message-ID: <20230626081759.GU83892@hirez.programming.kicks-ass.net>
References: <20230625092842.GBZJgIyqJL/FtKW4nU@fat_crate.local>
 <CAHk-=wgQsAB-5_9vF3Ok26=Wf55ayNJ80eMVVYtgrLZ-if5BVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgQsAB-5_9vF3Ok26=Wf55ayNJ80eMVVYtgrLZ-if5BVg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 10:09:25AM -0700, Linus Torvalds wrote:
> On Sun, 25 Jun 2023 at 02:28, Borislav Petkov <bp@alien8.de> wrote:
> >
> > - Add a ORC format hash to vmlinux and modules in order for other tools
> >   which use it, to detect changes to it and adapt accordingly
> 
> Hmm. That "hash" is pretty horrendous. If I read that awk script
> right, it will change for things like whitespace changes (or comment
> changes) as long as they are around those magic #defines or the
> 'orc_entry' definition.

Yes, if those lines get tail comments or someone mucks about with the
whitespace, the hash changes.

The advantage is that if the thing changes we can't forget to increment
a version number -- and this file hasn't had many changes.

The current output looks like:

$ awk '/^#define ORC_(REG|TYPE)_/ { print }/^struct orc_entry {$/ { p=1 }p { print }/^}/ { p=0 }' < arch/x86/include//asm/orc_types.h
#define ORC_REG_UNDEFINED               0
#define ORC_REG_PREV_SP                 1
#define ORC_REG_DX                      2
#define ORC_REG_DI                      3
#define ORC_REG_BP                      4
#define ORC_REG_SP                      5
#define ORC_REG_R10                     6
#define ORC_REG_R13                     7
#define ORC_REG_BP_INDIRECT             8
#define ORC_REG_SP_INDIRECT             9
#define ORC_REG_MAX                     15
#define ORC_TYPE_UNDEFINED              0
#define ORC_TYPE_END_OF_STACK           1
#define ORC_TYPE_CALL                   2
#define ORC_TYPE_REGS                   3
#define ORC_TYPE_REGS_PARTIAL           4
struct orc_entry {
s16             sp_offset;
s16             bp_offset;
#if defined(__LITTLE_ENDIAN_BITFIELD)
unsigned        sp_reg:4;
unsigned        bp_reg:4;
unsigned        type:3;
unsigned        signal:1;
#elif defined(__BIG_ENDIAN_BITFIELD)
unsigned        bp_reg:4;
unsigned        sp_reg:4;
unsigned        unused:4;
unsigned        signal:1;
unsigned        type:3;
#endif
} __packed;
$

I suppose we could add a lint pass to it to clean it up and make it more
consistent, but I don't expect it would buy us much. In fact, then we
have the build depend on the linter being present, which is a fairly big
down-side.

> I've pulled this, but it all seems pretty random and hacky.

Thanks! So our concern was mostly about not being able to accidentally
change things and not notice the change.

If you want we can add an explicit comment to that file to be careful
about things. Omar's purpose is to detect change, the occasional
harmless change is better than not detecting change.
