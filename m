Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128356AB62E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCFGCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCFGCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:02:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891B1B551;
        Sun,  5 Mar 2023 22:02:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D987660BEB;
        Mon,  6 Mar 2023 06:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9D1C433D2;
        Mon,  6 Mar 2023 06:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678082537;
        bh=UMGmArJhwi4kk5eVQL7RgTy9y4MNvsA9JMiR+NEkmyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DLLtuu836aWzw7nitnP/UQ94PGEmwRhZsz0kUTJCTLpN3Nxt5EAK9cLQwdjsTHFdG
         YkEeQm+kKWuMTVBsdylac3ORP+CNj0TWlgdc/WexZefU5TgiKAS0uPdmKQldlez3i9
         U8ARmrfKZf42jUidEjgaAIlK6EFs/Jv9Wtw+OCRE=
Date:   Mon, 6 Mar 2023 07:02:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 0/7] Documentation/security-bugs: overhaul
Message-ID: <ZAWB5kwcG9IpWvE/@kroah.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305220010.20895-1-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 11:00:03PM +0100, Vegard Nossum wrote:
> Hi,
> 
> This is v3 of clarifying our documentation for reporting security
> issues.
> 
> The current document is not clear enough, in particular the process of
> disclosure and requesting CVEs, and what the roles of the different
> lists are and how exactly to report to each of them.
> 
> Lots of people have been confused about the 7/14 days of the kernel list
> vs. the 7/14 days of the distros list, the fact that these are two
> separate lists, etc. Many reporters contact distros first, or submit
> their report to both lists at the same time (which has the unfortunate
> effect of starting off the disclosure countdown for the distros list
> before s@k.o has had a chance to look at the report). I've shared the v2
> document with a couple of people who submitted reports and they said
> they found it a lot clearer. 
> 
> Probably the easiest way to see the end result of this series is to view the
> rendered HTML which I've put here:
> https://vegard.github.io/security-v3/Documentation/output/process/security-bugs.html

Thanks for doing this, it looks much better, but I do have some
objections with it.

First off, you didn't cc: the security@k.o group to see if they agree
with this, any specific reason why?  :)

Secondly, and the bigger one, I think we should just drop all of the
references to linux-distros and oss-security entirely, as those are
groups that are outside of our control and interaction and have
different rules that we might not agree with.  They also just a tiny
subset of Linux users and companies and as such do not really reflect
the majority of where Linux is used anymore.

But overall I like the slimmer size, so perhaps the end result just
being the first two major sections would be best.  Let me take those
changes first and we can see how the result looks for now to see if that
will resolve some of the major issues the security@k.o group have right
now with reports (i.e. CVE requests, other group's disclosure rules and
dates).

thanks,

greg k-h
