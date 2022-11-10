Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5C624E81
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 00:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJXgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 18:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKJXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 18:36:30 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9092B85
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:36:28 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id l127so3479886oia.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 15:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ft0hBbh9NEYU0Q7LYEiUUDxfj2Q8E7rZp1hHrO+RN0=;
        b=gwTsesygGDK9RHm4ccvvyo7xedqsjAAWJ+PsCK12AavacXlui2OiIxwTtt4JBPq+Bp
         2W+GbHMwJMdZwGqvobWfbmC5F8rro/S2IhV/oijWt8SKlM8jbieJBoeasva1ghe0Nn5a
         LBJMLP5NUzzx9TRGgAmfShISCrmRreX4qeb35DfsajyAJppUKRHsFeOtP+lB/X4sUtQm
         C3BItKKFQ7nMG2Wq23MGTw13aGrlJ7hZkZ06J/5V23gF+BNJiJdV1Sp6LUo64+KfVm2T
         +AocSuBt6eS5F1mbRlj9ipNb3Ma8qqTILPJKDxeeFdxzOB8qGNZeKLsaIwaJBSCwCWgG
         OctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ft0hBbh9NEYU0Q7LYEiUUDxfj2Q8E7rZp1hHrO+RN0=;
        b=I4Js9jCAWlO13hrif9oXmZrptuNrqsMjEAH+nn2TA/QnLsSI3jZnPmUJmIT8z3gj76
         ZVLg1zUKpOtO1R25cNrEke9e48ugMTftBTbDJXvcYrGf7p3M/OeMz/OeneHv+JfKrgMm
         UxZLY7qtQIKBM/TbgCGVsTV51MvslRk/9shmrEAZamA1wUxFCT0OPE1HObDdn1qsy682
         IAH7Oa/M4Wbq6eQQCrGKktPfjv5RdSJEulxGARexEU17tmOI+UFj+unMHIGZLrzxJFeN
         eaXYyhiSC2PvY6OCY+vfFAgdD8laamOmY4vFyHpgE8AFnRdjaDqCxqXwqwxVIOMVrUBi
         h8XQ==
X-Gm-Message-State: ACrzQf1jGHh9fAPufo6TUB0k3Ju+KiTRoiSQKQnmJEm38wkSERFhu8cE
        tysXiCphkHmRsle0VU2dLXcGFCIycD357ksPoZLB
X-Google-Smtp-Source: AMsMyM4NJn94t8DTDVfilpvElddesuRrU5drh86cqDoFkFEPrwBe+yf9kbLVNK8+HaGnPvpMNAvB54yeHNFwQl/A4RY=
X-Received: by 2002:aca:6502:0:b0:35a:6535:df with SMTP id m2-20020aca6502000000b0035a653500dfmr2182347oim.51.1668123388137;
 Thu, 10 Nov 2022 15:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-7-casey@schaufler-ca.com> <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Nov 2022 18:36:17 -0500
Message-ID: <CAHC9VhSCAM+xdKf_f210-M-ZFY9KBVgpK84nbuCcVF9Z3qs2eA@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 6:34 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> > Create a system call lsm_self_attr() to provide the security
> > module maintained attributes of the current process. Historically
> > these attributes have been exposed to user space via entries in
> > procfs under /proc/self/attr.
> >
> > Attributes are provided as a collection of lsm_ctx structures
> > which are placed into a user supplied buffer. Each structure
> > identifys the security module providing the attribute, which
> > of the possible attributes is provided, the size of the
> > attribute, and finally the attribute value. The format of the
> > attribute value is defined by the security module, but will
> > always be \0 terminated. The ctx_len value will be larger than
> > strlen(ctx).
> >
> >         ------------------------------
> >         | unsigned int id            |
> >         ------------------------------
> >         | unsigned int flags         |
> >         ------------------------------
> >         | __kernel_size_t ctx_len    |
> >         ------------------------------
> >         | unsigned char ctx[ctx_len] |
> >         ------------------------------
> >         | unsigned int id            |
> >         ------------------------------
> >         | unsigned int flags         |
> >         ------------------------------
> >         | __kernel_size_t ctx_len    |
> >         ------------------------------
> >         | unsigned char ctx[ctx_len] |
> >         ------------------------------
> >
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > ---
> >  include/linux/syscalls.h |   2 +
> >  include/uapi/linux/lsm.h |  21 ++++++
> >  kernel/sys_ni.c          |   3 +
> >  security/Makefile        |   1 +
> >  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 183 insertions(+)
> >  create mode 100644 security/lsm_syscalls.c

...

> > +/**
> > + * lsm_self_attr - Return current task's security module attributes
> > + * @ctx: the LSM contexts
> > + * @size: size of @ctx, updated on return
> > + * @flags: reserved for future use, must be zero
> > + *
> > + * Returns the calling task's LSM contexts. On success this
> > + * function returns the number of @ctx array elements. This value
> > + * may be zero if there are no LSM contexts assigned. If @size is
> > + * insufficient to contain the return data -E2BIG is returned and
> > + * @size is set to the minimum required size. In all other cases
> > + * a negative value indicating the error is returned.
> > + */
> > +SYSCALL_DEFINE3(lsm_self_attr,
> > +              struct lsm_ctx __user *, ctx,
> > +              size_t __user *, size,
> > +              int, flags)
>
> See my comments above about UAPI types, let's change this to something
> like this:
>
> [NOTE: I'm assuming it is safe to use __XXX types in syscall declarations?]
>
>   SYSCALL_DEFINE3(lsm_self_attr,
>                  struct lsm_ctx __user *, ctx,
>                  __kernel_size_t __user *, size,
>                  __u32, flags)
>

I wanted to clarify how I originally envisioned this syscall/API, as
it looks like it behaves a bit differently than I originally intended.
My thought was that this syscall would be used to fetch one LSM
attribute context at a time, returning an array of lsm_ctx structs,
with one, and only one, for each LSM that supports that particular
attribute.  If the LSM does not support that attribute, it must not
enter an entry to the array.  Requesting more than one attribute
context per invocation is not allowed.  The idea was to closely
resemble the familiar open("/proc/self/attr/current")/read()/close()
result without relying on procfs and supporting multiple LSMs with an
easy(ish) API.  The new, single syscall should also be faster,
although none of this should be happening in a performance critical
section anyway.

In addition, the lsm_ctx::flags field is intended to convey
information specific to the given LSM, i.e. it should not repeat any
of the flag information specified in the syscall parameters.  I don't
believe any of the currently in-tree LSMs would require any special
flags for their contexts, so this should always be zero/clear in this
initial patchset, but it is something to keep in mind for the future.

Thoughts?

--
paul-moore.com
