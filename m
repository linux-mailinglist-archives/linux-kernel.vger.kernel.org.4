Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BCE72FD26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbjFNLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjFNLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837EC1BF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686742854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqRtxC4vQZ4ynDIqtiUnhVg2NHb/54gy7jFIH/eIy1o=;
        b=BHZdwrHStHX4CpTbecheKxUyPh1fv7MXXSQ5uF+rGZwm4aN4gqadcZL2sqZlGH36LZznYQ
        lwL0WGIuP7/QrOPLpkPSMUKZo1C869orGR2ZiPmb9NK6egK+XJZoHibpdteo5GMiYD1uG7
        88VphBOYg5VLM4DufKJD/PGgdTcjEGA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-lqDW9aI2PLS-samoOK_lAw-1; Wed, 14 Jun 2023 07:40:51 -0400
X-MC-Unique: lqDW9aI2PLS-samoOK_lAw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1d8fa45a6so5085611fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686742850; x=1689334850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqRtxC4vQZ4ynDIqtiUnhVg2NHb/54gy7jFIH/eIy1o=;
        b=YwBfzJFd8ie+g+990frl+e46lwBhJsV8j0nK4FNPEBjaTLSLMlSMTP+5LlkXRgGf2f
         b1+vd4A55DZIfFG8F/o3VngoxaeLBosNYesnodys6cN0hvVTYF3i8T5u+BBHM3TDkRM0
         /Fwqy6N7TOb97W+PFxr9imyknLb2AUeBSXaKFV92wE2Enx3l4kVrh5WNGmHR0XadmHUs
         0pwebaT6ac4IPWzmKqifAv/wX2GVHF3iS1nxrsOuNaXC/z24WUYF/mTUmzp8sdSLL6Jq
         xEoO1QwdYcb5oG3GeAW1TPGIPglWoC32GBj0UJ/7x2QbzXqu2kRQH+sNcx+/7Nuq7F2H
         6RgQ==
X-Gm-Message-State: AC+VfDxMcQYvUZfT7c+U8RIXcin5ZEYMe4CQF9KKWT0CULo7cK9m/+wm
        scYtlpN5UOKA0AqwWXds5+VwHnzCuVVwJIa6mbMknDumWvnmd7jDUgqg8rVzJfHR1wm/AmXdQA5
        QneR8obtXk7DcCmAMnpFnXt4r8nCc01hFWxYpHdeP
X-Received: by 2002:a2e:b0c7:0:b0:2ad:87b3:7d62 with SMTP id g7-20020a2eb0c7000000b002ad87b37d62mr6042987ljl.46.1686742849866;
        Wed, 14 Jun 2023 04:40:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ZaAD473fvI3jCWuKwimS1NlGOx6vdL0Rd+cM1q2YBHSA/Qv/WM1IAMcFFlFkhdg8EXoeKBY0kFnWC/mz0qRo=
X-Received: by 2002:a2e:b0c7:0:b0:2ad:87b3:7d62 with SMTP id
 g7-20020a2eb0c7000000b002ad87b37d62mr6042964ljl.46.1686742849455; Wed, 14 Jun
 2023 04:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net>
In-Reply-To: <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Wed, 14 Jun 2023 13:40:37 +0200
Message-ID: <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org,
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

On Fri, Jun 9, 2023 at 3:23=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
>
> On 09/06/2023 09:50, Jonathan Corbet wrote:
> > =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> writes:
> >
> >> EditorConfig is a specification to define the most basic code formatti=
ng
> >> stuff, and it's supported by many editors and IDEs, either directly or
> >> via plugins, including VSCode/VSCodium, Vim, emacs and more.
> >>
> >> It allows to define formatting style related to indentation, charset,
> >> end of lines and trailing whitespaces. It also allows to apply differe=
nt
> >> formats for different files based on wildcards, so for example it is
> >> possible to apply different configs to *.{c,h}, *.py and *.rs.
> >>
> >> In linux project, defining a .editorconfig might help to those people
> >> that work on different projects with different indentation styles, so
> >> they cannot define a global style. Now they will directly see the
> >> correct indentation on every fresh clone of the project.
> >>
> >> See https://editorconfig.org
> >>
> >> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> >> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> >> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
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
> This is a legitimate concern. :)
>
> A safe approach would be to rename the ".editorconfig" file to something
> like ".editorconfig.default" and create ".editorconfig" symlinks in all
> (parent) directories where enforcing this rules don't change anything
> because the children files are already correctly formatted. Again, a
> script (provided in another patch) to check and potentially update such
> links would be useful.
>

I can't think of an easy way to create that script. Formatting is done
by each editor using the rules from .editorconfig, but I didn't find
any available good script or tool to check if a file complies or not.
Creating that script is not trivial.

I neither think it is good to enable it for some folders and not for
others: developers will be surprised of having assistance in some
files and not in others, I would be bothered with such inconsistency.

Right now I see 2 possibilities:
- Provide an .editorconfig.default so those that want to use it, can
do it. But I wouldn't mess with cherry-picking directories that
already complies and those that don't, just the developer chooses to
use it or not, and that's all.
- Provide an .editorconfig directly, and those that don't want to use
it, either disable it in their editors or manually delete the file.

Please tell me what approach you prefer.
--=20
=C3=8D=C3=B1igo Huguet

