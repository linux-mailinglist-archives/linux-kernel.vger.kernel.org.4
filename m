Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DC063FDA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLBBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLBBdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:33:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AAEC3FC6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:33:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2970EB81FBE
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01B4C433D6;
        Fri,  2 Dec 2022 01:32:58 +0000 (UTC)
Date:   Thu, 1 Dec 2022 20:32:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@meta.com>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20221201203257.6fa19473@gandalf.local.home>
In-Reply-To: <nycvar.YFH.7.76.2212020158420.6045@cbobk.fhfr.pm>
References: <20221121104403.1545f9b5@gandalf.local.home>
        <Y3vSQo85ofkfD/L8@zn.tnic>
        <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
        <Y3ymzAYRyH5IWEe/@zn.tnic>
        <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
        <20221122132905.12a8d5ad@gandalf.local.home>
        <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
        <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
        <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
        <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
        <nycvar.YEU.7.76.2212020141280.27249@gjva.wvxbf.pm>
        <CAHk-=wjnwupwPOcTxGnDb1-dJ+wZDk1yiVvuDp8dAAAmLesrvA@mail.gmail.com>
        <nycvar.YFH.7.76.2212020158420.6045@cbobk.fhfr.pm>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 02:03:03 +0100 (CET)
Jiri Kosina <jikos@kernel.org> wrote:

> On Thu, 1 Dec 2022, Linus Torvalds wrote:
> 
> > > Anyway, I believe [1] that ERROR_INJECTION has been designed as a
> > > debugging feature in the first place, and should stay so. After figuring
> > > out now that HID-BPF actually has hard dependence on it, I fully agree [2]
> > > that the series should be ditched for 6.2 and will work with Benjamin to
> > > have it removed from current hid.git#for-next.  
> > 
> > I do think that it is interesting to have a "let's have a bpf
> > insertion hook here", so I'm not against the _concept_ of HID doing
> > that.  
> 
> Absolutely, me neither, quite the contrary -- I am quite happy to see 
> HID-BPF happening, because it'll actually make life easier for everybody: 
> for people with quirky hardware (trivial testing of fixes), for kernel 
> developers (trivial testing of fixes), and for distributions (trivial 
> distribution of fixes).

Full disclosure, I'm not against a bpf_hook either. In fact, I think I even
stated something to that effect, like adding a bpf_hook annotation to
functions or whatever, so that people can plainly see that the function can
have bpf attached to it.

I just *hate* the ad hoc way of using infrastructure for other purposes
than what they were designed for.

-- Steve
