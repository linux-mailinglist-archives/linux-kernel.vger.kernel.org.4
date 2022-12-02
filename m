Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2285663FDC3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiLBBlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiLBBlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:41:36 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8958BD3A11
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:41:33 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id r18so3172446pgr.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+MW4210LWwtj6asWCMqx/NAYsZudm/fgmdcvruSZ2Y=;
        b=k4+atSlvZtlJTGfHBkT+xF7QnVYR/C4VxKC73HDVed5Q07/4rb66qaPJbEjOx0EpPt
         tEvGZNH9J0d0wfcPOXoccqWd/hNZe68gsgNCdtNzJ+Tm+nYAu2Tn8o+NdqqfWg8qBwbx
         qCLPnObe5IMNAzUR1zoHE4DAEfI/qTAvdo73SMlL5I7/VAA5/gVGnFDsUljA+2GEAYzz
         bvepfHP8CMrtfd8jP6BekRm+ow+Qv7/oxweQK/lIqmg/ezOQwWlk7SX19k8DloouoBON
         2X40PoAV1ewreVZ6wKeIK8yEJ6usFQNmsI4uqKS3Fg5n86SZi/tcrylbx4LTiYiygXqB
         /c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+MW4210LWwtj6asWCMqx/NAYsZudm/fgmdcvruSZ2Y=;
        b=QXxyFFWWkOyqbO5YXOEqy/anCmy3f9WoH4B3d/74Mqj9Cgghkf2AVvC8nkL0SxeOFP
         IphgP25YS5h7w2mibQx5+Se9alUwqJttST+pkv/W93vZ+++iw+BctwqxQ55D1EQnP8dY
         pfsAFLDeLKevMDJT+a+phFcsh5C5w6hhkckM8tlftgV72N0akr7tf6ZYhCbmaDLHCieX
         4YJ2Ym01c0dgyIQKttP71SWOgUcc270822g1u8YFutarRHexBTg7rN7BLGPU7ADfPP5s
         fEh0YUcHRzb0akKtZiH3f35uEJluFdPOdwdbRHkMsPEM7b4mJJ7S2LOlJKkl2y8yHUuO
         5FzA==
X-Gm-Message-State: ANoB5pmYcfiGK0Mqr+XKWJL7SpZAS/dX7OtorDYO4/fuwPvE6nzxaRyt
        akCD08A+ZUgY7Ds9HJ+Dgtk=
X-Google-Smtp-Source: AA0mqf6T1YT63po8EXKP27aPTi3WmPCQ7yAiqAoqp8lPiseRVTmSoo9cvKBRQzYWNI2OpIaMoFyLuw==
X-Received: by 2002:a63:1801:0:b0:45f:a78b:f905 with SMTP id y1-20020a631801000000b0045fa78bf905mr53907007pgl.296.1669945292959;
        Thu, 01 Dec 2022 17:41:32 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:c181])
        by smtp.gmail.com with ESMTPSA id x6-20020a623106000000b005745eb7eccasm3846712pfx.112.2022.12.01.17.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:41:32 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:41:29 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20221202014129.n5lmvzsy436ebo4b@macbook-pro-6.dhcp.thefacebook.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeq1m=9mU17WzfRQ1W6N0SgKHY-e2J35SpppWwUUBFbQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:13:35PM -0800, Linus Torvalds wrote:
> 
> I'm going to apply Steven's patch, because honestly, we need to fix
> this disgusting mess *before* it gets to mainline, rather than say
> "oh, we already have broken users in next, so let's bend over
> backwards for that".
> 
> The code is called "error injection", not "random bpf extension"

Right, ALLOW_ERROR_INJECTION doesn't fit hid-bpf.
As Benjamin clarified for hid-bpf we don't want non-bpf attach to
those 3 functions. Injecting errors there is not useful.
We'll come with some clean mechanism to express "attach bpf here".

But let's examine other places of "error injection".

The following are clearly falling into kernel debugging category:
mm/filemap.c:ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
mm/page_alloc.c:ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
mm/slab_common.c:ALLOW_ERROR_INJECTION(should_failslab, ERRNO);

The distros might disable such hooks while data centers might still
enable them. Consider chaosmonkey and other frameworks that stress
user space. They are used on non-production user space while
running on production kernel.
The cloud providers wouldn't want to spin another kernel flavor
with fault injection enabled just to satisfy this set of users.
So the FUNCTION_ERROR_INJECTION kconfig is absolutely necessary.
Whether it defaults to N or Y, doesn't matter much.

But where would you draw the line for:
include/linux/syscalls.h: ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);

Right now people can add to their .bashrc:

cd /sys/kernel/debug/fail_function/
echo __x64_sys_bpf > inject
echo 0xffffFFFF > times
echo 100 > probability
echo 0 > verbose

and stop their favorite syscall ever happening on their laptops after boot.

The fault injection framework disables individual syscall with zero performance
overhead comparing to LSM and seccomp mechanisms.
BPF is not involved here. It's a kprobe in one spot.
All other syscalls don't notice it.
It's an attractive way to improve security.

A BPF prog over syscall can filter by user, cgroup, task and give fine grain
control over security surface.
tbh I'm not aware of folks doing "syscall disabling" through command line like
above (I've only seen it through bpf), but it doesn't mean that somebody will
not start complaining that their script broke, because distro disabled fault
injection.

So should we split FUNCTION_ERROR_INJECTION kconfig into two ?
And do default N for things like should_failslab() and
default Y for syscalls?

In the other thread TAINT_FAULT_INJECTED was proposed.
I think it's fine to taint when injecting errors into should_failslab(),
but tainting when syscall is disabled feels wrong.

One can argue that ALLOW_ERROR_INJECTION(sys_##sname, ERRNO); was an abuse of
fault injection, but let's keep it aside and focus on moving forward from here.
