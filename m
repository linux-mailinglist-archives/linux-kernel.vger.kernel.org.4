Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A55E9BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiIZIQ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiIZIQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:16:19 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8711901A;
        Mon, 26 Sep 2022 01:16:17 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id i15so3886289qvp.5;
        Mon, 26 Sep 2022 01:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xpIyz3/N0cBpohGA9LhBDEN8y3pRulYI1gvMSfO4nHU=;
        b=w8SFTG0IlHz1ZafZCtEHPNLAuOaKwbPEDPR7DR8YF2TKFmr23oVL8cji9iyyDAHiay
         mKUumfn7vq25Qem5tfS79nD+1U5fmuXZ6i7SMmsvKHGhcfNasmi0hc04kdTuxp7+SFcd
         4qBpJCWeKpP/swcQvV0ibczVSo4qPIcyan4Kz9gJYytIgkFKkCIT+KhYaKJV9O9ih3o9
         GjA57CdSSBRPr5sNdTBVupuTg0hdzdE+RGctiv6gtDRyKnh8xPVjhfTiy8CHpxy7YyTz
         MXhE4cp3Rpu4RcU44KLpcSRGsxuN8dV6Xkh8gw5Kh25EbXld5lCh20a/70TFXO+iS3Fk
         sS/g==
X-Gm-Message-State: ACrzQf1MwZ0CX2k7fKQGjoG6I7Q0BZPhKf7TCqxV0CTQP8CVby2QZxc0
        9efb+uiuBiLKoaw0BsYHP98mDr+Xdw9lpw==
X-Google-Smtp-Source: AMsMyM5rxntgyvpIeJJQDV/A/WjZLGudq8n0rA0nxIZqeNltC1cCK9GMB1Ekui8gz7tRat9sK+hSJg==
X-Received: by 2002:a05:6214:762:b0:4ac:ad95:2849 with SMTP id f2-20020a056214076200b004acad952849mr16221535qvz.14.1664180176382;
        Mon, 26 Sep 2022 01:16:16 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05622a22a600b0031f36cd1958sm10343580qtb.81.2022.09.26.01.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:16:15 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3457bc84d53so61093927b3.0;
        Mon, 26 Sep 2022 01:16:15 -0700 (PDT)
X-Received: by 2002:a81:6756:0:b0:345:525e:38 with SMTP id b83-20020a816756000000b00345525e0038mr19399171ywc.47.1664180174927;
 Mon, 26 Sep 2022 01:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <YyMlovoskUcHLEb7@kroah.com> <9cbea062df7125ef43e2e0b2a67ede6ad1c5f27e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <9cbea062df7125ef43e2e0b2a67ede6ad1c5f27e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 26 Sep 2022 10:16:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxf=+CnwXT61VvYhcHi093rz=0ftWQXKVviMunzE1HHw@mail.gmail.com>
Message-ID: <CAMuHMdWxf=+CnwXT61VvYhcHi093rz=0ftWQXKVviMunzE1HHw@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] a.out: remove define-only CMAGIC, previously
 magic number
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Наб,

CC binfmt

Thanks for your patch, which is now commit 53c2bd679017277f
("a.out: remove define-only CMAGIC, previously magic number") in
driver-core/driver-core-next.

On Fri, Sep 16, 2022 at 12:40 AM наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> The last user was removed in 5.1 in
> commit 08300f4402ab ("a.out: remove core dumping support")
> but this is part of the UAPI headers, so this may want to either wait
> until a.out is removed entirely, or be removed from the magic number doc
> and silently remain in the header

Indeed. This is part of uapi, and might break some unknown
userspace, while the gain is limited.  Do we really want to reduce
include/uapi/linux/a.out.h piecewise (e.g. N_BADMAG() seems to be
unused, too), instead of keeping it until a.out support is removed
completely?

Anyway, even at that point, it might be wise to keep the header file
around, as people have expressed the desire to run a.out binaries
through a userspace-compatibility wrapper.

> A cursory glance on DCS didn't show any user code actually using this
> value

What is DCS?

>
> Found with
> grep MAGIC Documentation/process/magic-number.rst | while read -r mag _;
> do git grep -wF "$mag"  | grep -ve '^Documentation.*magic-number.rst:' \
> -qe ':#define '"$mag" || git grep -wF "$mag" | while IFS=: read -r f _;
> do sed -i '/\b'"$mag"'\b/d' "$f"; done ; done
>
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  Documentation/process/magic-number.rst                    | 1 -
>  Documentation/translations/it_IT/process/magic-number.rst | 1 -
>  Documentation/translations/zh_CN/process/magic-number.rst | 1 -
>  Documentation/translations/zh_TW/process/magic-number.rst | 1 -
>  include/uapi/linux/a.out.h                                | 3 ---
>  5 files changed, 7 deletions(-)
>
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index eb2db3608a15..f48c6c6efaf7 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -69,7 +69,6 @@ Changelog::
>  Magic Name            Number           Structure                File
>  ===================== ================ ======================== ==========================================
>  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
> -CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>  HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
> index 86ef47906f37..27f60133fbe5 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -75,7 +75,6 @@ Registro dei cambiamenti::
>  Nome magico           Numero           Struttura                File
>  ===================== ================ ======================== ==========================================
>  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
> -CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>  HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
> index cbefdcbfbf53..520cc5cf4d63 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -58,7 +58,6 @@ Linux 魔术数
>  魔术数名              数字             结构                     文件
>  ===================== ================ ======================== ==========================================
>  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
> -CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>  HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/Documentation/translations/zh_TW/process/magic-number.rst
> index 7fd6e494467b..7d6debd0117e 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -61,7 +61,6 @@ Linux 魔術數
>  魔術數名              數字             結構                     文件
>  ===================== ================ ======================== ==========================================
>  PG_MAGIC              'P'              pg_{read,write}_hdr      ``include/linux/pg.h``
> -CMAGIC                0x0111           user                     ``include/linux/a.out.h``
>  HDLC_MAGIC            0x239e           n_hdlc                   ``drivers/char/n_hdlc.c``
>  APM_BIOS_MAGIC        0x4101           apm_user                 ``arch/x86/kernel/apm_32.c``
>  FASYNC_MAGIC          0x4601           fasync_struct            ``include/linux/fs.h``
> diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
> index 5fafde3798e5..bb15da96df2a 100644
> --- a/include/uapi/linux/a.out.h
> +++ b/include/uapi/linux/a.out.h
> @@ -70,9 +70,6 @@ enum machine_type {
>     The first page is unmapped to help trap NULL pointer references */
>  #define QMAGIC 0314
>
> -/* Code indicating core file.  */
> -#define CMAGIC 0421
> -
>  #if !defined (N_BADMAG)
>  #define N_BADMAG(x)      (N_MAGIC(x) != OMAGIC         \
>                         && N_MAGIC(x) != NMAGIC         \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
