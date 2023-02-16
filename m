Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E4699AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBPQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 11:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjBPQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 11:58:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CB827999
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 08:58:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6213B828EE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE5EC4339B;
        Thu, 16 Feb 2023 16:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676566718;
        bh=IhmvxlJspa2eGobP6VwQOR1zhRUci0/yKcaXi30XFpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yoh5S7VjxGZiFPWWDGbpD3kgiDoOT1KF8plT+rccMtd7rjaCn3rsDD9AgEQruK7nf
         cXUvzIawF2G9h/MVv3khEOis7IVLy+od7YBhD+uS4HQeJX+H8oPHte9aOFipIf41qz
         rG2/+2EHQ29UzzbhKbozqHrW/f3GVHtFWulERCn3xbvadXZVqbqrIhOg2kjbzn0ugd
         Q3porULFPs/NWiswQPn8BkwnhdjcbrIjFgYs/yYK2gwpVB+g693Bbwin4VxcYtH+2l
         hMcZGf+Sb9F3CI0xWpPORe0y9J4aWlKY2IhDEdhN5jhn60ni8MdohItXGdk2pOVIvu
         cLoyBsGTCJmWg==
Date:   Thu, 16 Feb 2023 08:58:36 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/2] x86/entry: Fix unwinding from kprobe on PUSH/POP
 instruction
Message-ID: <20230216165836.wgcgr6n6gmojbqjk@treble>
References: <cover.1676068346.git.jpoimboe@kernel.org>
 <baafcd3cc1abb14cb757fe081fa696012a5265ee.1676068346.git.jpoimboe@kernel.org>
 <20230213234357.1fe194b2767d9bc431202d4c@kernel.org>
 <Y+tx6DZyoQ362lUM@hirez.programming.kicks-ass.net>
 <20230214170552.glhdytvunczyxxao@treble>
 <Y+yzMmL7gUprDru3@hirez.programming.kicks-ass.net>
 <20230215231637.laryjsua5p4wcd57@treble>
 <Y+4JhmEGDR16EVpi@hirez.programming.kicks-ass.net>
 <Y+4T0EV8SBN09KxA@hirez.programming.kicks-ass.net>
 <20230216233519.eacdf4166d4ec20f3046a1e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230216233519.eacdf4166d4ec20f3046a1e2@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:35:19PM +0900, Masami Hiramatsu wrote:
> > It could be I'm just confusing things... when #DB traps it is actually
> > because the instruction is complete, so looking up the ORC based on the
> > next instruction is correct, while when #DB faults, it is because the
> > instruction has not yet completed and again ORC lookup on IP just works.
> > 
> > So while determining if #DB is trap or fault is a giant pain in the
> > arse, it does not actually matter for the unwinder in this case.
> > 
> > And with the INT3 thing the problem is that we've replaced an
> > instruction that was supposed to do a stack op.
> > 
> 
> If the kprobe checks whether the original instruction do a stack op and
> if so, setting a flag on current_kprobe will help unwinder finds that case?
> 
> Of course all INT3 user may need to do this but it should be limited.

No, for INT3, even if the original instruction wasn't a stack op, we can
treat it the same way.  Either way, we know the instruction hasn't
executed so we can still use that address to look up the ORC entry.

-- 
Josh
