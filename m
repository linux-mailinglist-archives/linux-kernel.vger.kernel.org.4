Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A5C666028
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAKQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjAKQRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF085F4A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673453783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdVdHrWSOthsu83h4mspCthGXV43Z66ec9tzF1QpCy0=;
        b=edqaKft8xhdPzjfQKzAN33/0MbFOWcvnOAuc1wcnTF/cd4xh0F0HzHxugOwP6JlsUi7pIx
        G/9u0IJbp2oSW+OQIhuOoq75a12ayhYV2FSSmXWf2yNNZxNnHUA0AYhEejs9+xMbtXHcMh
        4wimSJs+CkIo5gTvZ7U6jJGGcRWmh4o=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-o4VAxrhnPk6zIgOA_eddAQ-1; Wed, 11 Jan 2023 11:16:22 -0500
X-MC-Unique: o4VAxrhnPk6zIgOA_eddAQ-1
Received: by mail-vk1-f197.google.com with SMTP id x75-20020a1f7c4e000000b003d591e8cac6so4705117vkc.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:16:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdVdHrWSOthsu83h4mspCthGXV43Z66ec9tzF1QpCy0=;
        b=0TUb+kBH2VrszdwjB+a1+Hp6Jbmlc45QgJ4VsNHHSHs9NpFR3CMCgvu0kgvTrD/WOi
         +V1sv/c6OB5dj83beNXSGE8jK8pL29qSR3O1cYpMW2V28M2s0qK07e1mxWnp4vkgL2V9
         VBzJjVxWzjHm7wrhpVaTcWev8a+JJl3EOpHtBi3L1NqcikAyQq52yS3BlGv1N221me7e
         oJ3e4MLiBGjlEFR/BSmtvEAtpxoqviRLXB4eY3fGCA//COnozfm67/GoyAEQ3SEwXCq9
         2Iiur+avmwUFTqyzH1Sct2HKBL1KW7Tn5F5Y8V1F0f1LgcqKGdknwm52l9ljAdjY4Rig
         TS1Q==
X-Gm-Message-State: AFqh2kqIbi/3BhiEqWiEx72f1la235gw/biJKAE8XsKklCVW44hHjEPs
        l9q5hxtrrWNGScpqb+oWZvPn+nAVHaWnQhKoPb7mUpu81NxlzHwsT6Cq7dXVXPuwT0A/8Jc1+5g
        JSa+oc4DH9tDPp/3w6VRXAlnD1Xsioydsxf4J5DkP
X-Received: by 2002:a67:e952:0:b0:3d0:bf68:840c with SMTP id p18-20020a67e952000000b003d0bf68840cmr1475250vso.77.1673453781471;
        Wed, 11 Jan 2023 08:16:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtak3p24cmq19eeoK3cO2WUNbKWCsq8l66Nbt68Lh6eMqgevT8R30p+o4D+Rnr1CbXO/Ulfzga4uLfAT2UNDLQ=
X-Received: by 2002:a67:e952:0:b0:3d0:bf68:840c with SMTP id
 p18-20020a67e952000000b003d0bf68840cmr1475239vso.77.1673453781227; Wed, 11
 Jan 2023 08:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com> <CAEg-Je-hOFT34_TBD_YwUNsOjdJv_O=VAL7ojXmEqQ6ybOp8Jg@mail.gmail.com>
In-Reply-To: <CAEg-Je-hOFT34_TBD_YwUNsOjdJv_O=VAL7ojXmEqQ6ybOp8Jg@mail.gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Wed, 11 Jan 2023 16:16:05 +0000
Message-ID: <CAOgh=FxuUA_-rcp-p-R-WV6zYhywztNeXOfpuO5rFo=UJ5xVJA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Neal Gompa <neal@gompa.dev>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 at 15:34, Neal Gompa <neal@gompa.dev> wrote:
>
> On Wed, Jan 11, 2023 at 10:21 AM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
> >
> > Version 1.24 of pahole has the capability to exclude compilation units
> > (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> > currently supported by pahole and if it's used with a build that has
> > BTF debugging enabled it results in malformed kernel and module
> > binaries [3]. So it's better for pahole to exclude Rust CUs until
> > support for it arrives.
> >
> > Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=
=3D49358dfe2aaae4e90b072332c3e324019826783f [1]
> > Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=
=3D8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> > Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
> >
> > Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> > Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> > Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > ---
> > V2 -> V3: Enable pahole option upon comparing with version 1.24
> > V1 -> V2: Removed dependency on auto.conf
> >
> >  init/Kconfig            | 2 +-
> >  lib/Kconfig.debug       | 9 +++++++++
> >  scripts/pahole-flags.sh | 4 ++++
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 694f7c160c9c..360aef8d7292 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1913,7 +1913,7 @@ config RUST
> >         depends on !MODVERSIONS
> >         depends on !GCC_PLUGINS
> >         depends on !RANDSTRUCT
> > -       depends on !DEBUG_INFO_BTF
> > +       depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
>
> Does the order matter here? I'd rather it prefer a fixed pahole and
> disable BTF only if we can't use pahole properly.

The order won't matter.

>
>
> >         select CONSTRUCTORS
> >         help
> >           Enables Rust support in the kernel.
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index ea4c903c9868..d473d491e709 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
> >           btf_decl_tag) or not. Currently only clang compiler implement=
s
> >           these attributes, so make the config depend on CC_IS_CLANG.
> >
> > +config PAHOLE_HAS_LANG_EXCLUDE
> > +       def_bool PAHOLE_VERSION >=3D 124
> > +       help
> > +         Support for the --lang_exclude flag which makes pahole exclud=
e
> > +         compilation units from the supplied language. Used in Kbuild =
to
> > +         omit Rust CUs which are not supported in version 1.24 of paho=
le,
> > +         otherwise it would emit malformed kernel and module binaries =
when
> > +         using DEBUG_INFO_BTF_MODULES.
> > +
> >  config DEBUG_INFO_BTF_MODULES
> >         def_bool y
> >         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > index 0d99ef17e4a5..1f1f1d397c39 100755
> > --- a/scripts/pahole-flags.sh
> > +++ b/scripts/pahole-flags.sh
> > @@ -19,5 +19,9 @@ fi
> >  if [ "${pahole_ver}" -ge "122" ]; then
> >         extra_paholeopt=3D"${extra_paholeopt} -j"
> >  fi
> > +if [ "${pahole_ver}" -ge "124" ]; then
> > +       # see PAHOLE_HAS_LANG_EXCLUDE
> > +       extra_paholeopt=3D"${extra_paholeopt} --lang_exclude=3Drust"
> > +fi
> >
> >  echo ${extra_paholeopt}
> > --
> > 2.39.0
> >
>
>
> --
> =E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=
=EF=BC=81/ Always, there's only one truth!
>

