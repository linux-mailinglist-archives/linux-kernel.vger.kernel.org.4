Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5476465DB4A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbjADRaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbjADRaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:30:35 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592317E06
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:30:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn22so36508725plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 09:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RraqTIc19Yf5WtljYry6wuVG1FISGDkwp9OBAd+D23A=;
        b=nYD+1MWGEyXXY7smw4USQOZ+pFDB8wUhA6OqZNwfBqAuXcxed7yNXs0Uh+Y5wKpErG
         jtF1Vx87FoUTEOUrJTCBixGhRZTHta5JTHroUkxEZwR5bMmK8UFhPhvL5EJoTmcdTdiV
         th3K4t/tI/kdnYSSfCSoZ4B9oxxIn0NCt/KhydPVoyLDcflZrSo22T84RVu1nSkc5zAp
         rlZJv/FPDdSV6svuxHyxxCOg9z6GPFXRxhdigGz8XvZTahIrx6SeEIUn0b1hKzSZUuAN
         ZRQYGWsNG/cIdRhBz3rO/VARYVcVowy/nJLBb9EZo49qBJl91Op8S0SFxsrvWi3CKcz9
         1H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RraqTIc19Yf5WtljYry6wuVG1FISGDkwp9OBAd+D23A=;
        b=T2pZ1fZoU8wdaJQxt34LOkWBotD32mZXCRhgHnZc/nrL59FsIlnDsAyQIcOOo5bxwV
         nU2iewqV0T7OliPekQvGw4X2T7X0THUThuvADr1R9MQrCFs3QCHTrusK5IBazf7tFukn
         hNrDtmfLvJBIioZqJv65XkFrarGp8OcVawz78WD3t5XnA6Yku/2/ugNQycW0sGNqxMhI
         Qk8w1G9BgPnSwhzv136l3krms+Z+gPRUiMy1pcGDK9RIYGwDbxnoD8xXkVpDaHJ9vt6u
         F2md3YyUvm0t+oEIFiqA3fuhUSAmRERo2QvhxYETJUsDnRIWlXiqyn6ettTQO48ShTZR
         sRJg==
X-Gm-Message-State: AFqh2kr4/WtnA2OczGwnlDOUwoBRKBzArKzGUOZa7xPdyBw/E/ulbRWq
        U+o1f8318aklVoxeNFVwfFRobujkk3LEsGRhi5i12w==
X-Google-Smtp-Source: AMrXdXuGAjwbDO6MlESAelpRxq+pO6qqLPGFFa6VegJVnadYDSgxviiV3lNZONQzL2U8Rb3QZX7hTECA6cgKpvNbp6Y=
X-Received: by 2002:a17:902:6b08:b0:190:f5f5:fd17 with SMTP id
 o8-20020a1709026b0800b00190f5f5fd17mr3078478plk.59.1672853434356; Wed, 04 Jan
 2023 09:30:34 -0800 (PST)
MIME-Version: 1.0
References: <Y1LBGZPMfCZ8A1bl@FVFF77S0Q05N> <Y1QEzk/A41PKLEPe@hirez.programming.kicks-ass.net>
 <Y1Z12xuY9fDaHuCm@FVFF77S0Q05N>
In-Reply-To: <Y1Z12xuY9fDaHuCm@FVFF77S0Q05N>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 4 Jan 2023 09:30:22 -0800
Message-ID: <CAFP8O3+X0ZoA3MjzgDDwqV2OyCwkperKiQK5cx36j0FypVdJeA@mail.gmail.com>
Subject: Re: kCFI && patchable-function-entry=M,N
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Joao Moreira <joao@overdrivepizza.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

 On Mon, Oct 24, 2022 at 4:24 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Oct 22, 2022 at 04:57:18PM +0200, Peter Zijlstra wrote:
> > On Fri, Oct 21, 2022 at 04:56:20PM +0100, Mark Rutland wrote:
> > > Hi,
> > >
> > > For arm64, I'd like to use -fatchable-function-entry=3DM,N (where N >=
 0), for our
> > > ftrace implementation, which instruments *some* but not all functions=
.
> > > Unfortuntately, this doesn't play nicely with -fsanitize=3Dkcfi, as i=
nstrumented
> > > and non-instrumented functions don't agree on where the type hash sho=
uld live
> > > relative to the function entry point, making them incompatible with o=
ne another.
> > > AFAICT, there's no mechanism today to get them to agree.
> > >
> > > Today we use -fatchable-function-entry=3D2, which happens to avoid th=
is.
> >
> > > ... but I understand that for x86, folk want the pre-function NOPs to
> > > fall-through into the body of the function.
> >
> > Yep.
> >
> > > Is there any mechanism today that we could use to solve this, or coul=
d we
> > > extend clang to have some options to control this behaviour?
> >
> > So the main pain-point for you is differentiating between function with
> > notrace and those without it, right?
> >
> > That is; suppose you (like x86) globally do:
> > -fpatchable-function-entry=3D4,2 to get a consistent function signature=
,
> > you're up a creek because you use the __patchable_function_entries
> > section to drive ftrace and now every function will have it.
> >
> > So perhaps something like:
> >
> >  -fpatchable-function-entry=3DN,M,sectionname
> >
> > would help, then you can have notrace be the same layout, except a
> > different section. Eg. something like:
> >
> >  #define notrace __attribute__((patchable_function_entry(4,2,__notrace_=
function_entries)))
>
> FWIW, I think that'd work for me, and that was roughly my original propos=
al on
> IRC. My only concern with this approach is code size, since all uninstrum=
ented
> functions gain some point less prefix NOPs.
>
> We can make that slghtly better as:
>
> #define notrace __attribute__((patchable_function_entry(2,2,__notrace_fun=
ction_entries)))
>
> ... since we don't care about placing NOPs *within* the function
>
> > It does make the whole: CFLAGS_REMOVE_file.o =3D $(CC_FLAGS_FTRACE)
> > a bit of a pain, but I've long favoured removing all that and having
> > explitic notrace attributes on all relevant functions.
> >
> > Then again; perhaps it could be made to work by ensuring CFLAGS starts
> > with:
> >
> >  -fpatchable-function-entry=3D4,2,__notrace_function_entries
> >
> > and have CC_FLAGS_FTRACE include (and hence override with)
> >
> >  -fpatchable-function-entry=3D4,2,__ftrace_function_entries
> >
> > assuming that with duplicate argument the last is effective.
>
> TBH, it'd be nice to move ftrace to the `CFLAGS_WHATEVER_obj.o :=3D n` ap=
proach
> the other instrumentation uses, which IIUC would allow us to define diffe=
rent
> flags for the two cases (though I'll need to go check that).
>
> Thanks,
> Mark.

Hi Mark and Peter,

Sami asked my opinion (as the main -fpatchable-function-entry=3D
implementer on the llvm-project side) on this extension
(-fpatchable-function-entry=3D4,2,__ftrace_function_entries).
I think this is fine.

You may consider bringing this up as a GCC feature request
(https://gcc.gnu.org/bugzilla/show_bug.cgi) and CCing the author/the
committer of https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D417ca0117a=
1a9a8aaf5bc5ca530adfd68cb00399
(original -fpatchable-function-entry=3D support) and the author of
https://gcc.gnu.org/git/gitweb.cgi?p=3Dgcc.git;h=3Dc23b5006d3ffeda1a9edf5fd=
817765a6da3696ca
(powerpc64 ELFv2 support).
On the feature request, a summary (so that toolchain people don't have
to read every message in this thread) will help:)



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
