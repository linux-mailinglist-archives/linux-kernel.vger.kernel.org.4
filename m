Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C1C637A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKXNi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKXNiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:38:25 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981EF3906
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:38:24 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id b2so1206233iof.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jjAR6rlB4JMjlGqRrLWgv/Ac31Ixo2IqG4bvjUhXq9c=;
        b=mUQLw6Wa6j1GSgFj97mD/5wFRMKGcD9q7amkxtEpuOKuB0vjDi2WCCayXRlzSt6B5q
         CwsbAzgmdx597n/MSMdAj8V/YjVEpHDFRT6zOa1ycV1HXdtsEMGWe05d7R+ou+OpLMRO
         vQnNjWJl6JJC6+/2Ri9aa6WyBBE4m2yc0msgT7sEKTF/qB2H9XWXp99clLb0Qlhepc4u
         uuh7RoOlto//WAWuL+6jtDUeZOlGYaLwzI+Yy7M/oZyR3YYaVGRw8CiLdD1lYf2jLuX5
         SWrFfAxZizcl07Ye0dNr+4XG3rXOgcEGNenO1+IuEP7NVCf+OECNGKdoRs8Cz19Vq/KI
         Kl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjAR6rlB4JMjlGqRrLWgv/Ac31Ixo2IqG4bvjUhXq9c=;
        b=q36l52cGcuizPT5qEmXSGRwuM8c2VODb1nWMbnJNLQfFM1+taBnpeK7KwAJiFdJJ8+
         d4b7Idduy9et0CW3t5XX2cNl/KZMGC92MKxf8waJ6BW9O7EKk4PVabgcbt4VhkE8bgBd
         5KxU2yP+55Dpd4ocS9kbixARWmbSvbZUz0sA/PUXaGD2rT3+Ykujj7LWNnuXbHjxmXi6
         QfTmXz/2iyKidEF9bCRFpDJ+jOdAKVCPdEyxpzQUgM7zX3R1VmakNw7ewBdkf3nouiD1
         AlhZCnFNT2MjRNH1HuSU8Nlh9VbaCMCkG9dp+xQB3Afmo7rwcPC71feQntRCRRsRJpFi
         xHWQ==
X-Gm-Message-State: ANoB5pkEHFJv3Kcm7K+GgSxgL2ygcH7mUemI6JymWQ98CH7hKwrEW/Tt
        vpWI8LutyZ1q4+7+sH+KT6s/KbD6FJ2mpJ0tXU3749Sq704=
X-Google-Smtp-Source: AA0mqf6aYBJFanD8L72iQ3HEo50+OIhM/0RhHfrrb0kM0Kwfr8a4hj/ojdbk4oX7tZC6keNuhMVY0hgXP/ldygmACtU=
X-Received: by 2002:a02:a596:0:b0:363:a127:4cf9 with SMTP id
 b22-20020a02a596000000b00363a1274cf9mr14931954jam.66.1669297103310; Thu, 24
 Nov 2022 05:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20221124090815.7e550d88@canb.auug.org.au> <CAG48ez31N1S6g1h8HT8Wxvt8a5m7Y1gJ6JKkVTB2z9G8AGbONA@mail.gmail.com>
 <20221123161312.48c1a103da3e4c2df8da7bf9@linux-foundation.org>
In-Reply-To: <20221123161312.48c1a103da3e4c2df8da7bf9@linux-foundation.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 24 Nov 2022 14:37:47 +0100
Message-ID: <CAG48ez1swiSzbtmQipC8OubnUHnmKQgPhwqnhHbs+K5ArK9dpA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the mm tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
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

On Thu, Nov 24, 2022 at 1:13 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 24 Nov 2022 00:06:28 +0100 Jann Horn <jannh@google.com> wrote:
> > On Wed, Nov 23, 2022 at 11:08 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > In commit
> > >
> > >   d5d60d30f574 ("mmu_gather: Use macro arguments more carefully")
> > >
> > > Fixes tag
> > >
> > >   Fixes: a6d60245d6d9 ("asm-generic/tlb: Track which levels of the page table=
> > >
> > > has these problem(s):
> >
> > I'm not sure what happened here - when I apply the mail that I sent
> > with "git am", the "Fixes" line is properly one line. But in the
> > version that landed in the tree, it looks as if the quoted-printable
> > encoding was not decoded for that one line?
>
> My email client has trouble decoding the quoted-printable stuff.  I
> have a nightly script which tells me about stragglers, but Stephen
> sometimes gets there first.  99% of people use
> Content-Transfer-Encoding: 8bit.

Ok, I'll change my git configuration to that and hope that doesn't
break something else. ^^
