Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB6B628A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbiKNUek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiKNUeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:34:36 -0500
Received: from one.firstfloor.org (one.firstfloor.org [193.170.194.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F46BCAC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:34:35 -0800 (PST)
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 539EB87763; Mon, 14 Nov 2022 21:34:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1668458074;
        bh=gn8uNU5CNvFjLeBy8uL4GKVrPt3Je41Z9EuS6ucGU7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dDTFXjZnDUgU8xm1prBX04Aev9JlNhGZ5wk3+ndK+LHSfnneCeVUKJD9Yz06HiURB
         10JNbsaFQME+nCWYn5XBdb6tvJep4Yj77hazWC1T29eW+yyDjWOpHR9Iby1iG/G4f5
         RQfFPkWKyokgljwmyQ97lHwSnJoT/skKBMMB7DHA=
Date:   Mon, 14 Nov 2022 12:34:33 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 08/46] static_call, lto: Mark static keys as __visible
Message-ID: <20221114203433.2pskttlyqjo3gua7@two.firstfloor.org>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-9-jirislaby@kernel.org>
 <Y3Jj67TZ9tA2a6Pf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Jj67TZ9tA2a6Pf@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:51:07PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 14, 2022 at 12:43:06PM +0100, Jiri Slaby (SUSE) wrote:
> > From: Andi Kleen <andi@firstfloor.org>
> > 
> > Symbols referenced from assembler (either directly or e.f. from
> > DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> > they could end up in a different object file than the assembler. This
> > can lead to linker errors without this patch.
> > 
> > So mark static call functions as __visible, namely static keys here.
> 
> Why doesn't llvm-lto need this?

It has an integrated assembler that can feed this information to the LTO
symbol table, while gas cannot do that.

There was some discussion to extend the gcc top level asm syntax to 
express external symbols, but so far it doesn't exist.

> 
> Also, why am I getting a random selection of the patchset?

Me too.

-Andi

