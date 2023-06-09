Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E007293B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjFIIw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjFIIv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE3BE2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686300664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PUwIKYQbWiICJqD4Rq9YjSeC0WyuaQsDDkRv9B8gaVA=;
        b=MZAudQ+fIcuXAoOfx+E2AT9sMnnNUfRzzel2zwuz2R6CS4lP1BMMzRrgdRR6JFNCmmF/NR
        GYrUtzEGOtZQ5n3aKonKnQ/7JbpjoOkWBxZpzArOOfhycOb+qFej2EozHR3Xwg8hTcMJ8x
        7lnsxI+6k1RktbVSz5QBwdo9TiSyUwc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-OLuHDa9JOt-EaHYELT6CXA-1; Fri, 09 Jun 2023 04:51:03 -0400
X-MC-Unique: OLuHDa9JOt-EaHYELT6CXA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b1a7e31de7so8745671fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300662; x=1688892662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUwIKYQbWiICJqD4Rq9YjSeC0WyuaQsDDkRv9B8gaVA=;
        b=KTBsAm8sG4bCimJWYDThhvQ5klvFzxrw2z50vlH5hC5Ewe6hqfdk+WI9QMiMTQ3wG8
         gkR0sF2s5nE6wsRwurgvXTdABWD7zC+HhLCRBbjyuWr8RB1fMjUwfb+sPgftpqQ+5ppf
         GnYDr4+9V1BySsp6t+Hlw7DpOXbJ7H/+hop2phJ3EWaWjhCSde7O4dI0x3TyC+p3Mwp2
         Qwb5dqyi2R7SBh2O27a3U/cFDBu6kH5lUxP1gUswizKhMyhAr31FHfRfvXVPJNcVEDJO
         x/6skHtX4+ryQWMG60EbT5MSI3HKqn2cy3/ug704DeMuNAZ9bjWBKnY9ugreJeduLB0R
         oLwg==
X-Gm-Message-State: AC+VfDxspxtf4OOOu5oNUc48+EL34wWbxLDofmImpeqAKQedKPKwiB/n
        UdRZMAHp5woE1YLahpB/iuaSqgvKeG12W+kZ7ocgIJ+OYm/5lsfxJOqBNAUdTp1fo/cJaloSsJq
        L38DGE7W2ouhF0PGf7cCnl6yXltDO9kAnDRCdJX6S
X-Received: by 2002:a2e:8095:0:b0:2b1:d4fc:75f2 with SMTP id i21-20020a2e8095000000b002b1d4fc75f2mr630704ljg.7.1686300661869;
        Fri, 09 Jun 2023 01:51:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74MF4dxCl8k4XChxgb3mf0hGEb09TATYrjAceDQVZS7F92Pkhh+82rhpkg6qWM7CqpxENGgwwTmxb7gP/C09s=
X-Received: by 2002:a2e:8095:0:b0:2b1:d4fc:75f2 with SMTP id
 i21-20020a2e8095000000b002b1d4fc75f2mr630691ljg.7.1686300661480; Fri, 09 Jun
 2023 01:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <CACT4oucYVtGPj+cJrkAKXiwW74VNqb1R3u9jYQ9XnU6-LVde7g@mail.gmail.com>
In-Reply-To: <CACT4oucYVtGPj+cJrkAKXiwW74VNqb1R3u9jYQ9XnU6-LVde7g@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 9 Jun 2023 10:50:50 +0200
Message-ID: <CACT4oudWXa+YPtxHReeMoP6538h=cXJ19MrMhxChUhyfrmuv9w@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     ojeda@kernel.org, danny@kdrag0n.dev, masahiroy@kernel.org,
        jgg@nvidia.com, mic@digikod.net, linux-kernel@vger.kernel.org,
        joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:49=E2=80=AFAM =C3=8D=C3=B1igo Huguet <ihuguet@red=
hat.com> wrote:
>
> On Fri, Jun 9, 2023 at 9:50=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
> >
> > =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> writes:
> >
> > > EditorConfig is a specification to define the most basic code formatt=
ing
> > > stuff, and it's supported by many editors and IDEs, either directly o=
r
> > > via plugins, including VSCode/VSCodium, Vim, emacs and more.
> > >
> > > It allows to define formatting style related to indentation, charset,
> > > end of lines and trailing whitespaces. It also allows to apply differ=
ent
> > > formats for different files based on wildcards, so for example it is
> > > possible to apply different configs to *.{c,h}, *.py and *.rs.
> > >
> > > In linux project, defining a .editorconfig might help to those people
> > > that work on different projects with different indentation styles, so
> > > they cannot define a global style. Now they will directly see the
> > > correct indentation on every fresh clone of the project.
> > >
> > > See https://editorconfig.org
> > >
> > > Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > > Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > > Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> >
> > So I must confess to still being really nervous about installing a file
> > that will silently reconfigure the editors of everybody working on the
> > kernel source; I wish there were a straightforward way to do this as an
> > opt-in thing.  We're talking about creating a flag-day behavioral chang=
e
> > for, potentially, thousands of kernel developers.  Something tells me
> > that we might just hear from a few of them.
> >
> > I wonder if we should, instead, ship a file like this as something like
> > Documentation/process/editorconfig, then provide a "make editorconfig"
> > command that installs it in the top-level directory for those who want
> > it?
> >
> > Or perhaps I'm worrying too much?
>
> This is a valid option, indeed, but In my opinion we are overlooking this=
.
>
> Adding an .editorconfig will not silently reconfigure the editors of
> everyone because for most editors you need to install a plugin to use
> it. In my opinion, that's enough "opt-in". Here is the list of editors
> that have built-in support, and those that need a plugin install. I

Sorry, forgot the link: https://editorconfig.org/

> don't think that those with built-in support are widely used for
> kernel development, and many of them allow to disable the feature.
>
> I see this as the exact same case as adding a .clang-format file, as
> we already have. Some editors, either built-in or via plugin,
> automatically reformat code when this file is present. And it's far
> more "intrusive" than editorconfig.
>
> Also, note that, for those with editorconfig enabled in their editors,
> the editor would be enforcing formatting rules that are mandatory, not
> optional.
>
> Said that, if you still prefer to do it via `make editorconfig`, I can
> change it.
>
> >
> > Thanks,
> >
> > jon
> >
>
>
> --
> =C3=8D=C3=B1igo Huguet



--=20
=C3=8D=C3=B1igo Huguet

