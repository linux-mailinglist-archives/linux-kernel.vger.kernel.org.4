Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABA63FD71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiLBBDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiLBBDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:03:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888BACCECA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B6B8B8206B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716AC433D6;
        Fri,  2 Dec 2022 01:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669942986;
        bh=UYiR2KwlVMPHkoc3wjPpttxppo0m+c1eNSro/IUkOi8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=m+c3nf0f6Kc/qTWMo7WRforD99NC71b495YZjFqI1vnTWGau16Zq8VymR0wYD5Ugo
         ce/fd446+6tpYBdd6KxBUh2Mm3oOmyvNDTeZrBEkVfJMvI5t3R4saSBjxqoamvBO5f
         WYavhBHx/U1qzkv7ynRPbFiNIXGkCSTCc/HDvwFmwMp9E+1W8piRX/9ErmE9OAhQvo
         AapiKCGvetCAmxsoBmEYwDtu92LT+ZhU/B7MbLAXnBfb9tDJ+9PLWPfg5cU4sIahQF
         ACousRacwWtD5HrlP3MHfpAswC4DE2tCwZvW/mgWECbxiKJrL3QoFbqP/zHzD7lUSb
         8UUmG8r5F81LA==
Date:   Fri, 2 Dec 2022 02:03:03 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Subject: Re: [PATCH] error-injection: Add prompt for function error
 injection
In-Reply-To: <CAHk-=wjnwupwPOcTxGnDb1-dJ+wZDk1yiVvuDp8dAAAmLesrvA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2212020158420.6045@cbobk.fhfr.pm>
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic> <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com> <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com> <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com> <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org> <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com> <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
 <nycvar.YEU.7.76.2212020141280.27249@gjva.wvxbf.pm> <CAHk-=wjnwupwPOcTxGnDb1-dJ+wZDk1yiVvuDp8dAAAmLesrvA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022, Linus Torvalds wrote:

> > Anyway, I believe [1] that ERROR_INJECTION has been designed as a
> > debugging feature in the first place, and should stay so. After figuring
> > out now that HID-BPF actually has hard dependence on it, I fully agree [2]
> > that the series should be ditched for 6.2 and will work with Benjamin to
> > have it removed from current hid.git#for-next.
> 
> I do think that it is interesting to have a "let's have a bpf
> insertion hook here", so I'm not against the _concept_ of HID doing
> that.

Absolutely, me neither, quite the contrary -- I am quite happy to see 
HID-BPF happening, because it'll actually make life easier for everybody: 
for people with quirky hardware (trivial testing of fixes), for kernel 
developers (trivial testing of fixes), and for distributions (trivial 
distribution of fixes).

> It's not so different from user-mode drivers, after all, which we also 
> have. A kind of half-way state where we have a kernel driver, but one 
> that may need custom site-specific (or machine-specific) tweaks.

Indeed. The whole rationale from Benjamin, explaining quite nicely why 
HID-BPF is a good thing, can be found in the very original, initial 
ancient cover letter:

	https://lore.kernel.org/lkml/20220224110828.2168231-1-benjamin.tissoires@redhat.com/

> So I don't want to come across as being against having bpf used for 
> tuning some HID issue (and I can imagine it making sense in other places 
> that have machine-specific tweaks - I'm thinking of all the thermal 
> probe or pincontrol mess where sometimes you have GPIO's or motherboard 
> thermal sensors etc that are literally "user connected it to X").
> 
> But the notion that we'd use some error injection framework for it,
> and that you'd mix those concepts up - *that* I really think is just
> horrendous.

Fully agreed. I unfortunately missed that particular aspect during review, 
and it popped up only after HID-BPF appeared in linux-next.

-- 
Jiri Kosina
SUSE Labs

