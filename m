Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D565642E1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLERDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLERDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3307BDED5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670259719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8lLV7QRgk8RIPtXoZq0XZGuH6npXHy5x8jTIGXYeX1g=;
        b=VUxQzQ9O21ywJWCswjCwGL4OagFFHWyUd7gE+p0XlLa6zy0Bz+U2rY4WwqnLCMPt/GvEmC
        lqZHbfBLCBSxUBNh98dkkOySxWClqhwzK7f0VusjtOHF4IyaOVfGQiqbIq7bCwlXpvL7xn
        yU52WIknMfhA0+HZ59T2PKqLIvexkVU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-2bncyKoiNjyj81TIxkiCkA-1; Mon, 05 Dec 2022 12:01:56 -0500
X-MC-Unique: 2bncyKoiNjyj81TIxkiCkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C42886C053;
        Mon,  5 Dec 2022 17:01:42 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.39.194.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94E62112131E;
        Mon,  5 Dec 2022 17:01:39 +0000 (UTC)
Date:   Mon, 5 Dec 2022 18:01:34 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
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
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] error-injection: Add prompt for function error injection
Message-ID: <20221205170134.tbq3c3bhxvdx6pgp@mail.corp.redhat.com>
References: <CAADnVQLJFnu6gARdZ7ckgxeGaSv70jHBiQo+W=zDKO0-ELFGcQ@mail.gmail.com>
 <Y3ymzAYRyH5IWEe/@zn.tnic>
 <3fa8ec60-dd96-c41f-ea46-8856bf855949@meta.com>
 <20221122132905.12a8d5ad@gandalf.local.home>
 <a53e8c6d-b0e5-72bf-1aba-07609c9cf1bf@meta.com>
 <20221130143719.07e36277d1471b83e9a1b627@linux-foundation.org>
 <CAADnVQ+KLXPhowdBZq0PvGOq5tv4ovNtNCvGBXHQBkVbz4UVkg@mail.gmail.com>
 <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
 <c9912b24-f611-29b8-28e1-5e8be0d5ad41@redhat.com>
 <20221202193039.jle5fek5t5tff2lp@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202193039.jle5fek5t5tff2lp@macbook-pro-6.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 02 2022, Alexei Starovoitov wrote:
> On Fri, Dec 02, 2022 at 03:55:38PM +0100, Benjamin Tissoires wrote:
> > 
> > 
> > On 12/1/22 22:13, Linus Torvalds wrote:
> > > On Thu, Dec 1, 2022 at 8:59 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > 
> > > > The hid-bpf framework depends on it.
> > > 
> > > Ok, this is completely unacceptably disgusting hack.
> > 
> > [foreword: I have read the other replies, just replying to this one
> > because it is the explicit ask for a fix]
> > 
> > > 
> > > That needs fixing.
> > > 
> > > > Either hid-bpf or bpf core can add
> > > > "depends on FUNCTION_ERROR_INJECTION"
> > > 
> > > No, it needs to be narrowed down a lot. Nobody sane wants error
> > > injection just because they want some random HID thing.
> > > 
> > > And no, BPF shouldn't need it either.
> > > 
> > > This needs to be narrowed down to the point where HID can say "I want
> > > *this* particular call to be able to be a bpf call.
> > 
> > So, would the following be OK? I still have a few concerns I'll explain
> > after the patch.
> > 
[...]
> > 
> > While this patch removes the need for ALLOW_ERROR_INJECTION it has a
> > couple of drawbacks:
> > - suddenly we lose the nice separation of concerns between bpf core and
> > its users (HID in my case)
> > - it would need to be changed in 6.3 simply because of the previous
> > point, so it is just a temporary fix.

And third, it was bogus because the check_attach_modify_return() test was
inverted.

> 
> Agree, but it works short term.
> A silver lining is BTF_SET approach consumes 4 bytes per mark
> while ALLOW_ERROR_INJECTION consumes 16 bytes for struct error_injection_entry
> and then another 48 bytes per mark for struct ei_entry.
> 
> An alternative would be to define a known prefix like "bpf_modret_"
> or "bpf_hook_" and rename these three functions.

Not a big fan of that idea, sorry. It would work, for sure, but I don't
want to prefix my subsystem API by "bpf_modret_" which would make it
look like it is not part of my subsystem.

> 
> Then there will be no need for #include <linux/hid_bpf.h> in bpf core.

So I took your other advice to look into register_btf_kfunc_id_set().
And given that the internals of kfuncs are no more than a binary list of
ids, we can easily adapt it to have a better API to declare which
functions are fmodret. See [1] for the new series.

The net benefit are that now we can declare those functions outside of
any ALLOW_ERROR_INJECTION, outside of bpf-core, and also we can tag
sleepable ones which was not the case previously.

So I am rather happy with that v2. I'm sure there will be bikeshedding,
but this one looks better than my previous patch here.

> 
> > So I am not sure if this would qualify HID-BPF for 6.2. Please speak up.
> 
> Since that was the only thing I think it's fine to stay in the queue.

My plan is to see if we can get this validated in the next 2 days and if
not, drop it from 6.2 and reintroduce it in 6.3. After the weekend I
realized that delaying HID_BPF for one more release was not too much of an
issue in the end.

Cheers,
Benjamin


[1] https://lore.kernel.org/all/20221205164856.705656-2-benjamin.tissoires@redhat.com/

