Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814796294A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbiKOJoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbiKOJoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:44:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06038DF50
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IIRgRI+bxt8OEeRTxuNDOeSmAP0DvJvJJClTurwboCg=; b=KzZcOBG5iOC5icV64AefVB14bh
        jpqGi0bpsb1EfjmzzK95cOcYe4jbvGPGO1yVfxukxSclFYf3lqDxJ0quWiwll+YLQp9UcEZUsH4of
        JiUKeV9wINjda6lg4Ex6ATc7Sw+zxOQgEYyJupu2Ko2DY2E14z26/qT/gRK/Ct46tkuWyIHDh7xur
        KlCa4o8dBQaPwSIZgoco9COTryb1Jqp/tEoMOeFuwpm/7RNl+WqHdhVlBLBin36rbyN2aDClYS21J
        4R+uZOGP4LYXoTvw53HsFkFo0bJQDPQ09bvBThNDAM3k2+aT91IJ4Zu61B042ugeRo+zW9QbVSS6g
        44FRLmfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ousUA-00GOUu-FA; Tue, 15 Nov 2022 09:44:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3E5A300392;
        Tue, 15 Nov 2022 10:43:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBAB62C24A924; Tue, 15 Nov 2022 10:43:59 +0100 (CET)
Date:   Tue, 15 Nov 2022 10:43:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: CET shadow stack app compatibility
Message-ID: <Y3NfX0zXDIZztwKL@hirez.programming.kicks-ass.net>
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Let me hijack this and go off on a tangent..

On Mon, Nov 14, 2022 at 11:15:44PM +0000, Edgecombe, Rick P wrote:

> The breakage derives from how the decision is made on whether to enable
> shadow stack enforcement. Glibc will do this by checking a bit in the
> elf header of the binary. It then tells the kernel to turn CET on via a
> separate kernel API. But instead of this elf bit being selected by
> application developers, it was mostly applied in various automated ways
> (mostly default on) by distro builds for years. This huge amount of
> untested enablement has not generated any visible issues for users yet,
> because without kernel support the presence of this bit has not
> generated any actual CET enforcement.

CET is two things, ideally we're fully eradicate the term CET, never
again mention CET, ever. Whoever at Intel decided to push that term has
created so much confusion it's not funny :/

The feature at hand here is backward edge control flow -- or shadow
stacks (the means to implement this). Be explicit about this, do *NOT*
use CET ever again.

The other thing CET has is forward edge control flow -- or indirect
branch tracking, this is a completely different and independent feature
and not advertised or implemented here.

These things are obviously related, but since they're two independent
features there's the endless confusion as to which is actually meant.

(go (re)watch the last plumbers conf talks on the subject -- there's
always someone who gets is wrong)

The only things that should have CET in their name are the CR4 bit and
the two MSRs, nothing more.

ELF bits should not, must not, be called CET. API, not CET, Compiler
features, also not CET.

(and I know it's too late to eradicate some of it, but please, at least
make sure the kernel doesn't propagate this nonsense).
