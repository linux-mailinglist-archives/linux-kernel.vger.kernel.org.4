Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537A863FD40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiLBAqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiLBAqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:46:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479B16583
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:46:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 622EA621D5
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFDAC433D6;
        Fri,  2 Dec 2022 00:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669942005;
        bh=t6IQZOYkxcblDL+267tdpgvLUiNLdayCJqmW3yn9GV0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=QThmY0/Q5r1Iq0hGXIQIyyxY6p9iLIiEnq4RUO4anNCtbAx4jiWBcz5xKp+Og+ar3
         OzUc3ItpXMox1LBxzgVkhHmOl7n6fuMumrMC029dWSZIaOozVCprPUIta+5jPGRc+9
         dZWEkS6PKXuc8EzcBecQcYDVRIiMQa/vFCnPtRmuuZz1+8cWcoH+giGU3IouH86rhZ
         3M+ceqIaWbLuPND5ef+vDSNyO3YnKWYzENr4+CZsEd24716rqX8M+7uat1EQNpGWhA
         CMovlfhKKyRkm4rLPpGU6ymSprLyi6zbeZoQqQPSDYGYgCrWzA1KDt7ZEnl//fis4q
         LympGstGpG4Hg==
Date:   Fri, 2 Dec 2022 01:46:39 +0100 (CET)
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
In-Reply-To: <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
Message-ID: <nycvar.YEU.7.76.2212020141280.27249@gjva.wvxbf.pm>
References: <20221121104403.1545f9b5@gandalf.local.home> <Y3vSQo85ofkfD/L8@zn.tnic> <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com> <Y3ymzAYRyH5IWEe/@zn.tnic> <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com> <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com> <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org> <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com> <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
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

> > The hid-bpf framework depends on it.
> 
> Ok, this is completely unacceptably disgusting hack.
> 
> That needs fixing.
> 
> > Either hid-bpf or bpf core can add
> > "depends on FUNCTION_ERROR_INJECTION"
> 
> No, it needs to be narrowed down a lot. Nobody sane wants error
> injection just because they want some random HID thing.
> 
> And no, BPF shouldn't need it either.
> 
> This needs to be narrowed down to the point where HID can say "I want
> *this* particular call to be able to be a bpf call.
> 
> Stop this crazy "bpf / hid needs error injection" when that then
> implies a _lot_ more than that, plus is documented to be something
> entirely different anyway.
> 
> I realize that HID has mis-used the "we could just use error injection
> here to instead insert random bpf code", but that's a complete hack.
> 
> Plus it seems to happily not even have made it into mainline anyway,
> and only exists in linux-next. Let's head that disgusting hack off at
> the pass.
> 
> I'm going to apply Steven's patch, because honestly, we need to fix
> this disgusting mess *before* it gets to mainline, rather than say
> "oh, we already have broken users in next, so let's bend over
> backwards for that".
> 
> The code is called "error injection", not "random bpf extension"

Seems like quite a few parallel threads are currently going on about this, 
so it's a little bit hard to catch up for me as I am apparently CCed only 
on some of them.

Anyway, I believe [1] that ERROR_INJECTION has been designed as a 
debugging feature in the first place, and should stay so. After figuring 
out now that HID-BPF actually has hard dependence on it, I fully agree [2] 
that the series should be ditched for 6.2 and will work with Benjamin to 
have it removed from current hid.git#for-next.

[1] https://lore.kernel.org/all/nycvar.YEU.7.76.2211211716270.27249@gjva.wvxbf.pm/
[2] https://lore.kernel.org/lkml/nycvar.YFH.7.76.2212020135390.6045@cbobk.fhfr.pm/

-- 
Jiri Kosina
SUSE Labs
