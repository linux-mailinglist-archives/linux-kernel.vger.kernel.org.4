Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337464099E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiLBP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiLBP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:57:41 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BCD24E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:57:38 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B2Fuq0k006915
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 10:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669996618; bh=NzpZl93icD3NxV8EmwNZaY5iVoEk6J4HM2bRPv7t5+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=eQ3424MzYXhB0t2ItQIgSou/J/zhcEZf0xIFk5g2MA94AqgVI6VWsUepp1ENRCPdu
         IU681Xfe/4k4VdGtqbJ+Udm/cl/JfskvN2lUE5Y6hTljMyZvwKYPqD5feQUYyHIaoK
         lL/gQWfvAXG+Uxp2Fsm3Q9M1l+iRhprgiqMbhpkqT4YncDRu14sMvmvJRs5xLHTN6w
         020+a8TcmRwcQxfA0RHAP2axo3ay3K2rvGgzbowcHfRXMfHBzM5PKEnkdstdE2MUVe
         F62RAxF4Zs9DxZ5wgaBVvnKEpqtqTcqyH9/Qu7MYP3gFL2TXDtrXIg8YgAZomh/x4y
         a8BlkPBwnyS9A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2D9DE15C46FB; Fri,  2 Dec 2022 10:56:52 -0500 (EST)
Date:   Fri, 2 Dec 2022 10:56:52 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <Y4ogRH7zWLpmVXzJ@mit.edu>
References: <Y3vSQo85ofkfD/L8@zn.tnic>
 <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic>
 <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
 <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 05:41:29PM -0800, Alexei Starovoitov wrote:
> 
> The fault injection framework disables individual syscall with zero performance
> overhead comparing to LSM and seccomp mechanisms.
> BPF is not involved here. It's a kprobe in one spot.
> All other syscalls don't notice it.
> It's an attractive way to improve security.
> 
> A BPF prog over syscall can filter by user, cgroup, task and give fine grain
> control over security surface.
> tbh I'm not aware of folks doing "syscall disabling" through command line like
> above (I've only seen it through bpf), but it doesn't mean that somebody will
> not start complaining that their script broke, because distro disabled fault
> injection.
> 
> So should we split FUNCTION_ERROR_INJECTION kconfig into two ?
> And do default N for things like should_failslab() and
> default Y for syscalls?

How about calling the latter something like bpf syscall hooks, and not
using the terminology "error injection" in relation to system calls?
I think that might be less confusing.

							- Ted
