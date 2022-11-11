Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C5625168
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiKKDQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbiKKDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:16:49 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6D9DB9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:16:47 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id x196-20020a4a41cd000000b0049f064d2591so501181ooa.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b1rslYphVs3X8g1LOVSvRAzaw0S0/8SwRlMfDFpjDZo=;
        b=2mG28wGeIwv5HU6nme/BbWQEGGttfTfj6+TVPKnY15BC5bPw8mLemkfoQ4YfgVbUg6
         3LovG14juJKcHDNmcp5AY20rTaRBNRR6T6HRullxoFU/zIshV87avOhGfrZn+3ajX8Ii
         esoBEnhEPGfTjrrnqoUAQcoIBthvHN0x2ZBA9DLKSCiQHG74wQV6fpSCh6KMY680FqhA
         6qgTxb5RSZPkO+UeLtsqS15Fh5r+cXsBpuw81HYMs8A12oL91cH2A2GG5jXhRn+VbfCQ
         RASYN+HHvzeRJLVHOv/mKVXcmxUV0v/BFscq95KSqHO0NRUdQafUZ8U2xO/uDH9nMQ39
         LtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b1rslYphVs3X8g1LOVSvRAzaw0S0/8SwRlMfDFpjDZo=;
        b=mz4VLYzROenFvknVEaRhYIBNvBbg3b0sNX8il54tXqrgzmtq+QVck4vnEDX1l+lveK
         XOT3Z3pCgtvA9EaWFwzk/d1lL7qwvOjUy7btPQqxd1/IKzmCj8mLt0KIYBL/0QCtsXEY
         Ngpu1dRD21ULqft3IUCQMbS5krX2YPIsGlPCpU3hUwl0Sosd2ltkQIg5eAJtW3OKT8IH
         0gidKxBH9ts7Sd67/4pf/c+cE1om3GMc4ek2zTV+tq7cJv8NM1WtVWjDyj/3a7lRSVQ+
         AFEtbd1rk1T127Kf/VWGx5gE0vA8+LbFf5aiL0mz7ZmZo3o8U91gOz5u1v/Ph139y5Dy
         1dJQ==
X-Gm-Message-State: ANoB5pla+zPXfXlqIzksEIh8XxtaV+3dOCk0imjdolwqBQ0bnnvEq3zS
        wGBZuzh/Tqu+N71KuDhM36Yx31FgmjYHl2mgaZKg
X-Google-Smtp-Source: AA0mqf7TIl6q6cw4YFV4EmL8gbF1cFp7AyqpX+WpCbSf4iTsfDux98wMFabjvSkePawPqkxT3M70jVaayMsHh/mMtU8=
X-Received: by 2002:a4a:3c5a:0:b0:47f:9499:931c with SMTP id
 p26-20020a4a3c5a000000b0047f9499931cmr52183oof.81.1668136606729; Thu, 10 Nov
 2022 19:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-7-casey@schaufler-ca.com> <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
 <CAHC9VhSCAM+xdKf_f210-M-ZFY9KBVgpK84nbuCcVF9Z3qs2eA@mail.gmail.com> <94874c5f-5222-aab1-3fbf-5cacd15a2fdf@schaufler-ca.com>
In-Reply-To: <94874c5f-5222-aab1-3fbf-5cacd15a2fdf@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Nov 2022 22:16:35 -0500
Message-ID: <CAHC9VhSdn_zV594xqkXJT8uVg6e9DZPXmds1rdqBOt9vjHiffA@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 7:36 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/10/2022 3:36 PM, Paul Moore wrote:
> > On Wed, Nov 9, 2022 at 6:34 PM Paul Moore <paul@paul-moore.com> wrote:
> >> On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> Create a system call lsm_self_attr() to provide the security
> >>> module maintained attributes of the current process. Historically
> >>> these attributes have been exposed to user space via entries in
> >>> procfs under /proc/self/attr.
> >>>
> >>> Attributes are provided as a collection of lsm_ctx structures
> >>> which are placed into a user supplied buffer. Each structure
> >>> identifys the security module providing the attribute, which
> >>> of the possible attributes is provided, the size of the
> >>> attribute, and finally the attribute value. The format of the
> >>> attribute value is defined by the security module, but will
> >>> always be \0 terminated. The ctx_len value will be larger than
> >>> strlen(ctx).
> >>>
> >>>         ------------------------------
> >>>         | unsigned int id            |
> >>>         ------------------------------
> >>>         | unsigned int flags         |
> >>>         ------------------------------
> >>>         | __kernel_size_t ctx_len    |
> >>>         ------------------------------
> >>>         | unsigned char ctx[ctx_len] |
> >>>         ------------------------------
> >>>         | unsigned int id            |
> >>>         ------------------------------
> >>>         | unsigned int flags         |
> >>>         ------------------------------
> >>>         | __kernel_size_t ctx_len    |
> >>>         ------------------------------
> >>>         | unsigned char ctx[ctx_len] |
> >>>         ------------------------------
> >>>
> >>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>> ---
> >>>  include/linux/syscalls.h |   2 +
> >>>  include/uapi/linux/lsm.h |  21 ++++++
> >>>  kernel/sys_ni.c          |   3 +
> >>>  security/Makefile        |   1 +
> >>>  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
> >>>  5 files changed, 183 insertions(+)
> >>>  create mode 100644 security/lsm_syscalls.c
> > ..
> >
> >>> +/**
> >>> + * lsm_self_attr - Return current task's security module attributes
> >>> + * @ctx: the LSM contexts
> >>> + * @size: size of @ctx, updated on return
> >>> + * @flags: reserved for future use, must be zero
> >>> + *
> >>> + * Returns the calling task's LSM contexts. On success this
> >>> + * function returns the number of @ctx array elements. This value
> >>> + * may be zero if there are no LSM contexts assigned. If @size is
> >>> + * insufficient to contain the return data -E2BIG is returned and
> >>> + * @size is set to the minimum required size. In all other cases
> >>> + * a negative value indicating the error is returned.
> >>> + */
> >>> +SYSCALL_DEFINE3(lsm_self_attr,
> >>> +              struct lsm_ctx __user *, ctx,
> >>> +              size_t __user *, size,
> >>> +              int, flags)
> >> See my comments above about UAPI types, let's change this to something
> >> like this:
> >>
> >> [NOTE: I'm assuming it is safe to use __XXX types in syscall declarations?]
> >>
> >>   SYSCALL_DEFINE3(lsm_self_attr,
> >>                  struct lsm_ctx __user *, ctx,
> >>                  __kernel_size_t __user *, size,
> >>                  __u32, flags)
> >>
> > I wanted to clarify how I originally envisioned this syscall/API, as
> > it looks like it behaves a bit differently than I originally intended.
>
> That's why we're having a review cycle.

 :)

> > My thought was that this syscall would be used to fetch one LSM
> > attribute context at a time, returning an array of lsm_ctx structs,
> > with one, and only one, for each LSM that supports that particular
> > attribute.
>
> My thought with the interface I proposed is that we don't want a
> separate syscall for each attribute: e.g. lsm_get_current(), lsm_get_prev(),
> and we don't want a separate syscall for each LSM, e.g. lsm_get_selinux().

Agreed.  I believe that proposed syscall prototype, leveraging the
@flags parameter, supports this.

> We can either specify which attribute is desired or which have been returned.
> In either case we need an attribute identifier.

I never intended the lsm_ctx::flags field to indicate the attribute
itself, e.g. LSM_ATTR_CURRENT, that is for future use by the
individual LSM which is providing the attribute information in that
lsm_ctx array slot.  With that in mind, there is no way for the
syscall to return *what* attribute is returned, only the attribute
value.  This is intentional as I wanted to avoid using this syscall to
fetch different attributes at the same time (one attribute, with
multiple LSMs providing values is the intent).

The "why" is explained below ...

> >   If the LSM does not support that attribute, it must not
> > enter an entry to the array.  Requesting more than one attribute
> > context per invocation is not allowed.
>
> Why? That seems like an unnecessary and inconvenient restriction
> for the program that wants to see more than one attribute. A service
> that wants to check its fscreate, sockcreate and keycreate to see if
> they're appropriate for the container it's running in, for example.

First off, the currently defined attributes are *very* different in
nature so it is unlikely that a chunk of application code would want
to manipulate more than one in a given function.  That alone is a
fairly weak justification, but the idea that attributes aren't related
is important when one considers the access controls a LSM may place
around the management of these attributes.  Combining multiple
attribute requests in a single syscall could increase confusion as
when one of the requests is blocked but others are allowed.  What do
you do here, do you fail the entire syscall or supply just the
attribute that is allowed?  If you do supply just the attribute that
is allowed, do you return an error code?  How would you be able to
distinguish from a LSM which chose not return an attribute and one
that is actively blocking access to that attribute?

Supporting multiple attributes gets complicated very quickly.  Given
the syscall prototype where we treat the flag parameter as a bitfield,
we do allow ourselves the possibility of supporting this in the
future, but let's keep it simple right now.

It's also important to note that currently applications cannot request
multiple attributes via one action.  Even requesting one single
attribute requires a minimum of three syscalls, so we're definitely
improving things here with this syscall.

> >   The idea was to closely
> > resemble the familiar open("/proc/self/attr/current")/read()/close()
> > result without relying on procfs and supporting multiple LSMs with an
> > easy(ish) API.
>
>         rc = lsm_get_self_attr(struct lsm_ctx *ctx, size, attr_id, flags);
>
> This looks like what you're asking for. It's what I had proposed but with
> the attr_id specified in the call rather than returned in the lsm_ctx.

I was thinking that the attr_id would be conveyed as part of the flags
parameter, but I suppose keeping them separate makes life easier (no
worries about flag collisions with the much more generic attribute
ID).  I would suggest that we still treat the attribute parameter as a
bitfield to allow for the possibility of multiple attributes in one
request; as well as a reordering of the parameters:

 int lsm_get_self_attr(__u32 attr,
                       struct lsm_ctx *ctx,
                       __kernel_size_t *size,
                       __u32 flags);

> > Thoughts?
>
> I don't have any problem with *what I think* you're suggesting.
> To make sure, I'll send a new patch. I'll also address lsm_set_self_attr().
> Thank you for the feedback. Let's see if we can converge.

Sounds good.  Thanks Casey.

--
paul-moore.com
