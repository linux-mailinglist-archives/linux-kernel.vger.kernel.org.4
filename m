Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADB6E6DA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjDRUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjDRUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:47:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97236118E9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:46:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kx14so7845772pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681850815; x=1684442815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwZIiVHUhQZs52apnr131loVbxJzKqT7q8JveSlmJaI=;
        b=5tCJ3PNikCivXIc33R3cairDzMx0H0YL+Bfpqf3eGrF7DDSbI2A/dL2MtyDC0Pvt2v
         PvoPFLnxKKl3ZBK9bgeki1aAT/vXeboRnMIWpqzBG1fuzvnmU3IhM02AE3ATj4KOaCMH
         DDuLvu/qq6MyA3Pi6pwCbSeUK4TO42yxHdr+um2eLK6/nOI3+6XuWzE9lE0BZTSKppa9
         9u22oXvOvFkEi1bd+3dfJxrUhTRfs0kGB8g69I4I6+RyRLwz9kSOtokqXLcgk+1SiYF5
         Tx0jrA4vgtr8UNjMMHhqD5nTm6yjHF/eCmZEir12z1n/twW+qI9mqZ+EVVCpWdxYeah3
         6xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850815; x=1684442815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwZIiVHUhQZs52apnr131loVbxJzKqT7q8JveSlmJaI=;
        b=iPenoomrHHCs2L5REzgAYPqWotBs3Aqyrwry9TRdnVkc9diRP8aJqPT7x9Naqmo77D
         vZjyaa5ocMqt4IfLhF0T32NLNdhGWJ0+fSOs5XOcZAxj+8lelSIZb+R0qbeRnzTRHfA3
         DlonhjUYYubXgBOtfFHCahPZHQ/NBgkfRelyzR5It7oOEEReb4RdqG+9fRfQSpB2ht6j
         lk3oopOg+u9WTrW/GT9VU3eAVLRuoaYdSAVaSgfZRszciAX6S+PkSXCkrg5QYIfgoH4X
         /NpDFTIrFwmaTttx8vtMChbq32iiUAzTfm7tqTa61VjtzlKJaPSgWX6gC3dq/sMbMnPC
         nwmQ==
X-Gm-Message-State: AAQBX9fq2Gnmzk4cZ3fPuPQsjSITW8xj67Eju375+kRaV24CtKf56L67
        ourfSgkbljQNWHl9bn8GTtgGq2MAzzugmG7K3kB8oQ==
X-Google-Smtp-Source: AKy350aRAESMi4ZeF0sSdTbpctykvqapaRJIrCqwEiq/p38uC1kh3VmnMLr7DgyjuS7SCK7g8yF2FgdUI3/pCrXJSmQ=
X-Received: by 2002:a05:6a21:9986:b0:f0:302a:ccd1 with SMTP id
 ve6-20020a056a21998600b000f0302accd1mr1087927pzb.8.1681850814640; Tue, 18 Apr
 2023 13:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230414005309.GA2198310@google.com> <CAKwvOd=yQS+0oDC46Hc5D_V0JET8=xbQmAJrpBdg7c4i2EyqHg@mail.gmail.com>
 <20230418203611.GA3640630@google.com>
In-Reply-To: <20230418203611.GA3640630@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Apr 2023 13:46:40 -0700
Message-ID: <CAKwvOdnxCJo-FoPfcNw=SBum6yRXOY7_meT8T6gsjV3c3FFm5A@mail.gmail.com>
Subject: Re: clangd cannot handle tree_nocb.h
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, nathan@kernel.org, trix@redhat.com,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 1:36=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> On Fri, Apr 14, 2023 at 03:47:51PM -0700, Nick Desaulniers wrote:
> > On Thu, Apr 13, 2023 at 5:53=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Hello!
> > >
> > > I have been trying to get clangd working properly with tree_nocb.h. c=
langd
> > > trips quite badly when trying to build tree_nocb.h to generate ASTs.
> >
> > Hi Joel,
> > Thanks for the report.  What are you using clangd for? I'll bet
> > something interesting.
>
> Thanks for the response and sorry for the late reply. I am at the OSPM
> conference. I use vim and vscode with clangd. In vim, YCM uses it to
> highlight compiler errors live while editing, I am pretty happy with it s=
o
> far and has been a huge time saver. Enough that now I want to use it for
> everything...

Cool! I use vim, can you share more info about your set up for this?
I'll have to try it.

>
> I first came across clangd when developing Chrome userspace code which is=
 C++
> :). In Chrome, ninja builds can be made to output compile_commands.json.
> However, now I noticed the support in the kernel and was like, wow I need=
 to
> try it. Further, YCM seems to work much better with it than without :)
>
> > I've never used it myself, so I don't know where to even begin with
> > how to reproduce the issue.
>
> Ah ok. :). When I ran get_maintainer on the script, your name popped up a=
nd
> someone also suggested that you're the goto person for clang on the kerne=
l
> (which I kind of already knew ;)

You've cc'ed the right set of folks.  We might not have the expertise
related to clangd specifically, but we can point you in the right
direction.

>
> > It might be worth filing a bug upstream at
> > https://github.com/llvm/llvm-project/issues
> > or internally under the component
> > Language Platforms > C++ > Clang > Tools > Clangd
> > with detailed steps to reproduce (and what the observed error actually
> > is). Feel free to cc me, though I don't know the first thing about
> > clangd.
>
> Ok I will consider doing this if needed. One thing I do observe is lack o=
f
> good support for header files and it is a known clangd issue [1].
>
> However, the fixes I was proposing can purely be done in the kernel itsel=
f
> since all it'd require is generating compile_compands.json with the -D<ma=
cro>
> and editing files to keep clangd happy. I guess one question is, how welc=
ome
> would such changes to header files be since they're for tooling and isn't
> code that will be compiled outside of clangd.

Specifically your patch sites some log print that doesn't look
indicative of a failure:
https://github.com/llvm/llvm-project/blob/53430bfd5c9d0074dd6de06dccea366e1=
d40bce4/clang-tools-extra/clangd/TUScheduler.cpp#L903-L906
so something else is going on here. Just trying to make sure we root cause =
this.

>
> (Linked issue may not directly related to what I'm saying)
> [1] https://discourse.llvm.org/t/header-file-heuristics-issue/1749
>
> Thanks.
>


--=20
Thanks,
~Nick Desaulniers
