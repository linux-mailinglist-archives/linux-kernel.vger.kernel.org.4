Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A593C665EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjAKPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjAKPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:23:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E7F8FFF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673450570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KI0yozfzdsV3itB+vtEutzzJl6QUZ8urWnALQve9kOY=;
        b=N5J/h76CnrTwachaozwMjtNF9JKLQebroBkhKZirSifInSK6QKKZc3NtK5U+Y9LvY1WKt4
        JB98gzzs6hF8iLjFhQqBYcw+JUyNrkErWsXjVuWYI9NZtyhg/+zayxTZ7b/8OCeBPuLfyS
        nKlQEe4ow0ZEVsQjVgvH24iAuGYA8/E=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-164-xo-UENMkO8eOh8QzM542eA-1; Wed, 11 Jan 2023 10:22:48 -0500
X-MC-Unique: xo-UENMkO8eOh8QzM542eA-1
Received: by mail-ua1-f71.google.com with SMTP id y10-20020ab0560a000000b003af33bfa8c4so6959547uaa.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KI0yozfzdsV3itB+vtEutzzJl6QUZ8urWnALQve9kOY=;
        b=DVZPiBcrsVXPkNuMsU+CGtREVTX1tS/SqHrJgugaymQc4Hrt83ink86fsw0daB/WXl
         KN7vApPYAiOsvSX+ChT5G8QWY+eFEukBgOu9ajxqcxRrP2NxJyWiWUUyzYRnD7Q+pxb6
         JsZjiG9/5POGjm/bzq5Q3epn1YPrkUxKZSZwZ5IoXGqNb8kegLHjX02jZ18JrUblCVJy
         Fp/TJkkibYzmrwelAK3/+3BDVW82AUVLoZk1rr3ynor9h9wc8wDl46qhWIEu/6YtRLvW
         a6XzZK0rqAR8CiSp1nW/PwQyUA45u/u4+ELBWw5OEAwCmdh9JDAHJ8sPrCSgX5G5Okqp
         wNdg==
X-Gm-Message-State: AFqh2ko/gOUltb4NuFy1MfBSKbj30jW2PFfqBYe+jzglilXNZEvB/Av/
        5HS7U2jYvGpFVG8b3UpfijhBtuZFqDhcP+zu7715kvEpZY279z6ilBASw/esmv1yfqCIpAn8841
        DWj1mWnsrgGHQwPvbO3ulDsDzlVMdX4DESZcuEekZ
X-Received: by 2002:a67:f918:0:b0:3ce:97c7:28af with SMTP id t24-20020a67f918000000b003ce97c728afmr4802261vsq.41.1673450565916;
        Wed, 11 Jan 2023 07:22:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvjE0S/WV/NDpsMDiI+oAuhiI5nQ2DubTEK2l9K3KdKpW3KjxUumLCHkjWZ99/USIUrU5A+zslosrOkdqj+drg=
X-Received: by 2002:a67:f918:0:b0:3ce:97c7:28af with SMTP id
 t24-20020a67f918000000b003ce97c728afmr4802244vsq.41.1673450565490; Wed, 11
 Jan 2023 07:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20230111152050.559334-1-yakoyoku@gmail.com>
In-Reply-To: <20230111152050.559334-1-yakoyoku@gmail.com>
From:   Eric Curtin <ecurtin@redhat.com>
Date:   Wed, 11 Jan 2023 15:22:29 +0000
Message-ID: <CAOgh=FxQQ6o6+JS5DaXu=SPyYssXTXgt4+njvnZ5b0msKj5c_w@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 at 15:21, Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Version 1.24 of pahole has the capability to exclude compilation units
> (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> currently supported by pahole and if it's used with a build that has
> BTF debugging enabled it results in malformed kernel and module
> binaries [3]. So it's better for pahole to exclude Rust CUs until
> support for it arrives.
>
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
>
> Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

I think this should be able to cover all the quirky build techniques.

Tested-by: Eric Curtin <ecurtin@redhat.com>

> ---
> V2 -> V3: Enable pahole option upon comparing with version 1.24
> V1 -> V2: Removed dependency on auto.conf
>
>  init/Kconfig            | 2 +-
>  lib/Kconfig.debug       | 9 +++++++++
>  scripts/pahole-flags.sh | 4 ++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 694f7c160c9c..360aef8d7292 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1913,7 +1913,7 @@ config RUST
>         depends on !MODVERSIONS
>         depends on !GCC_PLUGINS
>         depends on !RANDSTRUCT
> -       depends on !DEBUG_INFO_BTF
> +       depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
>         select CONSTRUCTORS
>         help
>           Enables Rust support in the kernel.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ea4c903c9868..d473d491e709 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
>           btf_decl_tag) or not. Currently only clang compiler implements
>           these attributes, so make the config depend on CC_IS_CLANG.
>
> +config PAHOLE_HAS_LANG_EXCLUDE
> +       def_bool PAHOLE_VERSION >= 124
> +       help
> +         Support for the --lang_exclude flag which makes pahole exclude
> +         compilation units from the supplied language. Used in Kbuild to
> +         omit Rust CUs which are not supported in version 1.24 of pahole,
> +         otherwise it would emit malformed kernel and module binaries when
> +         using DEBUG_INFO_BTF_MODULES.
> +
>  config DEBUG_INFO_BTF_MODULES
>         def_bool y
>         depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a5..1f1f1d397c39 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -19,5 +19,9 @@ fi
>  if [ "${pahole_ver}" -ge "122" ]; then
>         extra_paholeopt="${extra_paholeopt} -j"
>  fi
> +if [ "${pahole_ver}" -ge "124" ]; then
> +       # see PAHOLE_HAS_LANG_EXCLUDE
> +       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> +fi
>
>  echo ${extra_paholeopt}
> --
> 2.39.0
>

