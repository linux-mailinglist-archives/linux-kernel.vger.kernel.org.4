Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F187293AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbjFIIus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbjFIIuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F3B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686300572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Emc5NZMXV0SIucAbT3Bsy8yUIVGNzCP8ASsJBgE9giM=;
        b=eY2gIGPZUvMVnSRl+Y8fIcbJVTvbFNRX9Ntnvfh3BLwMo9whmtWVMpdjvf5RJZoWAImh2O
        mWHI1CDh5yg68ms/dNZ39ogiP2has5MrdGwyyyC5Ih6QM9xNiDBtDHjAZTuD4AoKv+wZ6G
        N4Xc/PdeLj9dw0heWCsJNt2YCoQDh3Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-wyKQlJDeNi6icIxgxnlinw-1; Fri, 09 Jun 2023 04:49:31 -0400
X-MC-Unique: wyKQlJDeNi6icIxgxnlinw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f60dd5ab21so1246290e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300569; x=1688892569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Emc5NZMXV0SIucAbT3Bsy8yUIVGNzCP8ASsJBgE9giM=;
        b=jeKHqNKesgYpod0R3uz5pHz9u/HDz+iZ0G6T72+mk1ZEKWMtNasPeYN7e3htyVS/Ni
         wZEftsAls9LtzSTbGGzFWXrB+l5OA1wkvxl8zSOIIfIO4np7kzKW9Ena0lq9ca+tB0WA
         azx7ta9n9HX+lBdmEVyC9ll++mxyEqZrybhQR2RWwokZKfA4+xa/RJbLrMNAhQc6eOyW
         AFmrUkgEmtEMH8h7YuCkD07wAOppPvWcTkxBGjjn/bHZR7VAdsW29uY80nHvzhEitRiI
         aqNzV3an9w98NO8wdXqzinZrpsOSLR5Z3jy5pjRIw463Cj8AaNRt+0RQu7tkEOi81ko6
         6/wQ==
X-Gm-Message-State: AC+VfDz49CBAwn+l49M/B/mX6n68VSDMCezu/GffP9Sjgr+wvmmPAAOe
        cXLO6Xa13JMrfdHT5rMPB3lJRXSWlonrfyiHbXpMrLPTGH3vHFufCENgG2gqAtUWE9rJ07ktgPR
        pzx0SZ+NjP3NLT+/wIupWSRSdgmREL41CSek3jIIWEfa7hMP+
X-Received: by 2002:a05:6512:2f4:b0:4f6:56:c40e with SMTP id m20-20020a05651202f400b004f60056c40emr452667lfq.28.1686300569441;
        Fri, 09 Jun 2023 01:49:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BL3qWvDfPyUUitDGSioRWmk/YjuXZV+6gR2aY8EGxd/8s0Li32lrEjEs1c49mLh9Xf+SfRSiEVHgZ7SIyH64=
X-Received: by 2002:a05:6512:2f4:b0:4f6:56:c40e with SMTP id
 m20-20020a05651202f400b004f60056c40emr452648lfq.28.1686300569096; Fri, 09 Jun
 2023 01:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
In-Reply-To: <87sfb1oz13.fsf@meer.lwn.net>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Fri, 9 Jun 2023 10:49:17 +0200
Message-ID: <CACT4oucYVtGPj+cJrkAKXiwW74VNqb1R3u9jYQ9XnU6-LVde7g@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 9:50=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wro=
te:
>
> =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> writes:
>
> > EditorConfig is a specification to define the most basic code formattin=
g
> > stuff, and it's supported by many editors and IDEs, either directly or
> > via plugins, including VSCode/VSCodium, Vim, emacs and more.
> >
> > It allows to define formatting style related to indentation, charset,
> > end of lines and trailing whitespaces. It also allows to apply differen=
t
> > formats for different files based on wildcards, so for example it is
> > possible to apply different configs to *.{c,h}, *.py and *.rs.
> >
> > In linux project, defining a .editorconfig might help to those people
> > that work on different projects with different indentation styles, so
> > they cannot define a global style. Now they will directly see the
> > correct indentation on every fresh clone of the project.
> >
> > See https://editorconfig.org
> >
> > Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> > Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> > Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
>
> So I must confess to still being really nervous about installing a file
> that will silently reconfigure the editors of everybody working on the
> kernel source; I wish there were a straightforward way to do this as an
> opt-in thing.  We're talking about creating a flag-day behavioral change
> for, potentially, thousands of kernel developers.  Something tells me
> that we might just hear from a few of them.
>
> I wonder if we should, instead, ship a file like this as something like
> Documentation/process/editorconfig, then provide a "make editorconfig"
> command that installs it in the top-level directory for those who want
> it?
>
> Or perhaps I'm worrying too much?

This is a valid option, indeed, but In my opinion we are overlooking this.

Adding an .editorconfig will not silently reconfigure the editors of
everyone because for most editors you need to install a plugin to use
it. In my opinion, that's enough "opt-in". Here is the list of editors
that have built-in support, and those that need a plugin install. I
don't think that those with built-in support are widely used for
kernel development, and many of them allow to disable the feature.

I see this as the exact same case as adding a .clang-format file, as
we already have. Some editors, either built-in or via plugin,
automatically reformat code when this file is present. And it's far
more "intrusive" than editorconfig.

Also, note that, for those with editorconfig enabled in their editors,
the editor would be enforcing formatting rules that are mandatory, not
optional.

Said that, if you still prefer to do it via `make editorconfig`, I can
change it.

>
> Thanks,
>
> jon
>


--=20
=C3=8D=C3=B1igo Huguet

