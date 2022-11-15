Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC0762A19B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKOS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiKOS6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:58:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5FDA46E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:58:43 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7da329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7da:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C5361EC02F2;
        Tue, 15 Nov 2022 19:58:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668538721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T6HeLeehV641J2nE98Nj30oEAQVC3Sf8j+2pJZ96dME=;
        b=el8C5T48KAQZ1rtI5hQsco/OER1kNCyW9AO5D2PN4R4cLTWhxXk5WIPogWfaziDrlvA4pH
        gRLxVzFrhqWwdef8msdNW/BRRFZUm0iynoCpZSGud/UNAhIKqnE+t4UYuAXHKSFAAKPzqb
        vYkJ09t3HrxnqT1FAD1bePEnMiznZe8=
Date:   Tue, 15 Nov 2022 19:58:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH v8 2/5] x86: Add cmdline_prepare() helper
Message-ID: <Y3PhYRx9aAYsdvMQ@zn.tnic>
References: <cover.1668082601.git.baskov@ispras.ru>
 <b81fa524589ff21002a501f0b4cddf41b53f640f.1668082601.git.baskov@ispras.ru>
 <Y3JQpxi6XDkPViBr@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3JQpxi6XDkPViBr@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 03:28:55PM +0100, Borislav Petkov wrote:
> So now it is my turn: I'll do it how I think it should be done and you
> can review it.

Ok, here are two patches as a reply to this message.

I was able to test them as much as I can in a VM here but I'd need more
details/testing in your configuration with earlyprintk as a builtin
cmdline.

cmdline_prepare() has grown a bit hairy in the end but I've tried hard
to comment what happens there so that it is clear for the future. The
main goal being to concentrate all command line strings processing in
that function and not have it spread around the tree. And yes, there are
more cleanups possible.

In the compressed stage I'm using the cmdline which is in boot_params as
source and destination to basically add only the builtin cmdline.

In kernel proper the boot_command_line comes from generic code and that
is a whole another way of crazy in itself when I look at init/main.c

And as previously stated - the goal is to have everything in one place
and documented as good as possible so that trying to figure out how
command line parsing is done doesn't send you on grepping spree around
the tree.

Suggestions how to simplify this even more are always welcome, ofc.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
