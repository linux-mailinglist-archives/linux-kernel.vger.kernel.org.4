Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F090A7157EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjE3IGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjE3IGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:06:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD652A8;
        Tue, 30 May 2023 01:06:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 840A5219D0;
        Tue, 30 May 2023 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685433969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ukbl4q0oH8kV5ZgAOr0o4FI9d9WKzL+MxA+Kz6z5tX8=;
        b=Ki27RLJOVorsjFnZmsstxVVQLhIFGev9cVJFWAktH3fgZ0qOHDJ9BvIxzHbCJQy82azP4J
        ZU8IGGZx7BvXTz+b986cSjh9v5EdcOPRMy3+dezyb5lUdXdAsFq0U/0oz3Tipcf7TG2jIN
        R8qZHj8zF2i2u7kdJP0/H2YRf/vncdY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 237672C141;
        Tue, 30 May 2023 08:06:08 +0000 (UTC)
Date:   Tue, 30 May 2023 10:06:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     maninder1.s@samsung.com,
        "keescook@chromium.org" <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "bcain@quicinc.com" <bcain@quicinc.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "nathanl@linux.ibm.com" <nathanl@linux.ibm.com>,
        "ustavoars@kernel.org" <ustavoars@kernel.org>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Onkarnath <onkarnath.1@samsung.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH 1/1] arch:hexagon/powerpc: use KSYM_NAME_LEN in array size
Message-ID: <ZHWub0ibU7etLnXK@alley>
References: <20230529052821.58175-1-maninder1.s@samsung.com>
 <CGME20230529052832epcas5p4fa1b8cf25d9810d32bd2ccf012086fb3@epcms5p1>
 <CANiq72ncDr68qeahrHuQ63dj1Va3=Us6ZSjGRkr6Zp8j+=yH_Q@mail.gmail.com>
 <20230529105707epcms5p1418eac680ebe1736196706b0db80dd39@epcms5p1>
 <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n_eso7_pgna8ukmEnuCQPsKYPr0NU-Ss9Nwv0VzX=etg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-05-29 16:50:45, Miguel Ojeda wrote:
> On Mon, May 29, 2023 at 1:08 PM Maninder Singh <maninder1.s@samsung.com> wrote:
> >
> > I Will add co-developed-by` tag.
> > because this change was identified while we were working on kallsyms some time back.
> > https://lore.kernel.org/lkml/YonTOL4zC4CytVrn@infradead.org/t/
> >
> > this patch set is pending and we will start working on that again, so i thought better
> > to send bugfix first.
> 
> Sounds good to me!
> 
> (Fixed Wedson's email address)
> 
> > Yes, I think second buffer was not related to kallsyms, so I have not touched that.
> 
> Kees: what is the current stance on `[static N]` parameters? Something like:
> 
>     const char *kallsyms_lookup(unsigned long addr,
>                                 unsigned long *symbolsize,
>                                 unsigned long *offset,
>     -                           char **modname, char *namebuf);
>     +                           char **modname, char namebuf[static
> KSYM_NAME_LEN]);
> 
> makes the compiler complain about cases like these (even if trivial):
> 
>     arch/powerpc/xmon/xmon.c:1711:10: error: array argument is too small;
>         contains 128 elements, callee requires at least 512
> [-Werror,-Warray-bounds]
>             name = kallsyms_lookup(pc, &size, &offset, NULL, tmpstr);
>                  ^                                           ~~~~~~
>     ./include/linux/kallsyms.h:86:29: note: callee declares array
> parameter as static here
>             char **modname, char namebuf[static KSYM_NAME_LEN]);
>                                  ^      ~~~~~~~~~~~~~~~~~~~~~~
> 
> But I only see 2 files in the kernel using `[static N]` (from 2020 and
> 2021). Should something else be used instead (e.g. `__counted_by`),
> even if constexpr-sized?.
> 
> Also, I went through the other callers to `kallsyms_lookup` to see
> other issues -- one I am not sure about is `fetch_store_symstring` in
> `kernel/trace/trace_probe_tmpl.h`. Steven/Masami: is that "with max
> length" in the function docs enough? Is it 0xffff?

The best solution would be to pass the buffer size as an extra
parameter. Especially when some code passes buffers that are
allocated/reserved dynamically.

Sigh, I am not sure how many changes it would require in kallsyms
API and all the callers. But it would be really appreciated, IMHO.

Best Regards,
Petr
