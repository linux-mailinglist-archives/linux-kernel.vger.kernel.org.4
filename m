Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BA65FDF40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJMRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJMRqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:46:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D9A144E2E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:46:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id iv17so1664626wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8ev4pPnANTRpeGlWtdz4fwBlwIXvv8bPS1IfQVbJRl8=;
        b=spEOO6U76Nh6i2+6RoX9Spc8ZrWUfpMBxYdZg71DhbEAxdLbP3OZ0lxY94eUlOO1pk
         i/2p78lMKLurk9qO/g7dEC28Z+ovo4pr0ykuK/9l+jUciDL+RVNbU2FFSlwUzmJJWpJi
         6n/1XZ/bR+uMlXdjyNGJgoejGPsh0E3kkFnJCiImPKr1thc28I3CysJL2AVoZ3b77zuP
         iSqg7yPPekTQ6qo03HSD5rzjLm8Th92dlmRc6Ei3QIjVrlY78jlFsP2aqAP6UwAquPLS
         3ScNR52QTymv8NTo2dcKAvJPtm2LxJQKZePuwYnyjAZvhBEBou9f5vB0txfCJRDOTIR1
         UEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ev4pPnANTRpeGlWtdz4fwBlwIXvv8bPS1IfQVbJRl8=;
        b=i23XniWSYBV85IaR/SEYQKBePVewoD1AjZkanul7UvL6yPvChku7IpcEU+GFSdeekc
         blTyRfqxs9G6K7g5NlHWDxSUwX18S+qpw6a2LeJhmz0NYqSVXp08mLfKPktjiPwbtjf+
         lmJ98nFnZi/wEwa0hyC0+yHtnDjU0t1p8DlXzaBB2SWzJSNxYRZD71YUhvC+efnCsuWs
         pM/yYXou9uCpjNkRESImk9iK6r14Bvek7zzEoRMstvAdRtnH/9UWRxbV/8n1rL+qC4Er
         +KrBWaI5W4nzXgU0AZ32c6Dv1DnGp1nHBOce5QlsbaEkXZtF6PZ5hoYf+zf5zPXnndVJ
         yTew==
X-Gm-Message-State: ACrzQf1aU5W85Gibwte/AmSEnuUuyBDVqCb4Icav1nwiIrq9miehcUF9
        6o/SoBNKUVmP/DRDMx9xOxETytLX+MjULtpjJLjbzg==
X-Google-Smtp-Source: AMsMyM5jTDHcnzM0bOBuCvnxWCxENWOdtk/sw+8edsqid0aaTs2MkW9UXd4iqx7XWudjfpF/TMUy0pZOq7ZpEIQYoxU=
X-Received: by 2002:a05:600c:310b:b0:3b4:c618:180d with SMTP id
 g11-20020a05600c310b00b003b4c618180dmr705289wmo.25.1665683202009; Thu, 13 Oct
 2022 10:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220921003120.209637-1-avagin@google.com> <20220921003120.209637-2-avagin@google.com>
 <00ffd40b257346d26dfc0f03d144ec71@ispras.ru>
In-Reply-To: <00ffd40b257346d26dfc0f03d144ec71@ispras.ru>
From:   Andrei Vagin <avagin@google.com>
Date:   Thu, 13 Oct 2022 10:46:30 -0700
Message-ID: <CAEWA0a6DHqZOduKhJi7o12RprGt2LGqGOC86TKN1bTXn36u7hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/timens: add a test for vfork+exit
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 9:10 AM Alexey Izbyshev <izbyshev@ispras.ru> wrote:
>
> On 2022-09-21 03:31, Andrei Vagin wrote:
> > From: Andrei Vagin <avagin@gmail.com>

<snip>

> > +     if (pid == 0) {
> > +             char now_str[64];
> > +             char *cargv[] = {"exec", now_str, NULL};
> > +             char *cenv[] = {NULL};
> > +
> > +             // Check that we are still in the source timens.
> > +             if (check("child before exec", &now))
> > +                     return 1;
>
> I know this is just a test, but...
>
> Creating threads in a vfork()-child is quite dangerous (like most other
> things that touch the libc state, which is shared with the parent
> process). Here it works probably only because pthread_create() followed
> by pthread_join() restores everything into more-or-less the original
> state before returning control to the parent, but this is something that
> libcs don't guarantee and that can break at any moment.
>
> Also, returning from a vfork()-child is explicitly forbidden by the
> vfork() contract because the parent would then return to an invalid
> stack frame that could be arbitrarily clobbered by code executed in the
> child after main() returned. Moreover, if I'm not mistaken, on x86 with
> Intel CET-enabled glibc (assuming the support for CET is ever merged
> into the kernel) such return would cause the parent to always trap
> because the shadow stack will become inconsistent with the normal stack.
> Instead, _exit() should be used here...
>

Hi Alexey,

You are right, it isn't a good idea to create threads from the vfork-ed
process. Now, vfork isn't a special case in the kernel code, so I think
we can just remove the check() call from here. I have sent an updated
version of this patch, pls take a look at it.

Thanks,
Andrei
