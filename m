Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E716AB67A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 07:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCFGmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 01:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCFGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 01:42:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4D41CF78;
        Sun,  5 Mar 2023 22:42:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB615B80B6B;
        Mon,  6 Mar 2023 06:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E7CC433D2;
        Mon,  6 Mar 2023 06:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678084956;
        bh=vbmXtwLQpExWUGSPmIpEouqE3pH/PZT2tUi97t12HTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DpvK1VlfPgt5Rfmh4kY+Ho9TArL/E0CXfcQbUUlMX14YIbEF4g2/1YIFMoorB0QXz
         ZMBoL0qIf7rEHA/ARF0csk6UXDCPFQ1CZOQSqmGg7OUwWnnI4z41nRBQYl8EDOx34J
         TMi8WU0tx5lZL1kX1W6H8Wtfwvxg0763oHM1+4ec=
Date:   Mon, 6 Mar 2023 07:42:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Amit Shah <aams@amazon.com>,
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
Message-ID: <ZAWLWWofpqKtH3CT@kroah.com>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
 <ZAWB5kwcG9IpWvE/@kroah.com>
 <ZAWJtvfnFWEjsIXd@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWJtvfnFWEjsIXd@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 07:35:34AM +0100, Willy Tarreau wrote:
> On Mon, Mar 06, 2023 at 07:02:14AM +0100, Greg Kroah-Hartman wrote:
> > Secondly, and the bigger one, I think we should just drop all of the
> > references to linux-distros and oss-security entirely, as those are
> > groups that are outside of our control and interaction and have
> > different rules that we might not agree with.  They also just a tiny
> > subset of Linux users and companies and as such do not really reflect
> > the majority of where Linux is used anymore.
> 
> I'm wondering if instead they shouldn't just be mentioned as a warning
> about the risk of leak or forced disclosure. We know that reporters may
> find the address from various places, including various sites that may
> enumerate the long list of potential contacts, and not just this doc.
> It can be useful to have just a paragraph warning about the fact that
> oss-sec is public and that linux-distros has this strict disclosure
> policy without consideration for the availability of a fix, in order
> to warn them to only contact such lists once the fix is available and
> tested if they want to, but never before. Anything we can do to help
> serious reporters (i.e. those who are really embarrassed with a bug,
> not those who seek a Curiculum Vitae Enhancer) should be done. It's
> always a stressful moment to report a security issue on a project,
> you always fear that you might be doing an irreversible mistake, so
> whatever info we can pass about the risks (or lack of) should be
> welcome I guess.

That's a good idea, if it can be worded in a way that reflects that is
is not any sort of requirement or that it is normal part of our
development process.

thanks,

greg k-h
