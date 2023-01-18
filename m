Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27978671535
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjARHlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjARHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:39:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90CD2ED76;
        Tue, 17 Jan 2023 23:02:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95DBBB81B7B;
        Wed, 18 Jan 2023 07:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379B0C433A0;
        Wed, 18 Jan 2023 07:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674025327;
        bh=hpCZZmsqf4/6Mxu3Z+UTxXvwuRL1LaW+0KrqiGLzrlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DSgHVawM2Lsbp1jqLhhrzzbXJt2A/+zta9eAwgCv3451lTKsCGx3Xy0LDIRX49ICc
         NK+gQKeOG47zXzt54pg53kZEJ0P+rQrFot+WzXi/WdNiD/QGHjAVcP6LhEYXIuneX7
         aV8/FNmafMuswBPQHR2WAe4H+Ii+7BaO5BA3DNheJdnY+dpib9ZU1WdrN9gxvSo6a6
         i7suaS0Ta2qvPrl2vJf/2GkourBl7CrW5Tb9VSF1uGS0nGGIbKyFchzA8bVZhYYyaE
         SqkgWJM/vhO98tSNVK2vAX4kmmPVlGuM3Cvzjjgc8pmU5wNZPIC2PJxGWK4P2z/JhW
         TwZ8CbFBzGKyA==
Received: by mail-oi1-f171.google.com with SMTP id s124so11106094oif.1;
        Tue, 17 Jan 2023 23:02:07 -0800 (PST)
X-Gm-Message-State: AFqh2krB0e2Yg9EkSs5F4kHXsYDKi39pYpFCp2/ZNvkwUGdZmMqs1ofB
        qtS53meYXd3KWvAxaGmgU+5c9HOtFnDuGrH45/o=
X-Google-Smtp-Source: AMrXdXsA6TO3KoaA5mmSLZluzpXf4b6ZeQmXmJvwyWq+RJVZeL/soOW8ymGGgGshJhB/twbLBiGcGi2bdeQkWA3W1WE=
X-Received: by 2002:aca:acd5:0:b0:364:5d10:7202 with SMTP id
 v204-20020acaacd5000000b003645d107202mr275302oie.194.1674025326155; Tue, 17
 Jan 2023 23:02:06 -0800 (PST)
MIME-Version: 1.0
References: <20230111161155.1349375-1-gary@garyguo.net> <20230112214059.o4vq474c47edjup6@ldmartin-desk2>
 <20230113181841.4d378a24.gary@garyguo.net> <20230117175144.GI16547@kitsune.suse.cz>
 <20230117192059.z5v5lfc2bzxk4ad2@ldmartin-desk2.lan>
In-Reply-To: <20230117192059.z5v5lfc2bzxk4ad2@ldmartin-desk2.lan>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Jan 2023 16:01:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
Message-ID: <CAK7LNATsuszFR7JB5ZkqVS1W=hWr9=E7bTf+MvgJ+NXT3aZNwg@mail.gmail.com>
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 4:23 AM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> On Tue, Jan 17, 2023 at 06:51:44PM +0100, Michal Such=C3=A1nek wrote:
> >Hello,
> >
> >On Fri, Jan 13, 2023 at 06:18:41PM +0000, Gary Guo wrote:
> >> On Thu, 12 Jan 2023 14:40:59 -0700
> >> Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >>
> >> > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> >> > >
> >> > > struct modversion_info {
> >> > >- unsigned long crc;
> >> > >- char name[MODULE_NAME_LEN];
> >> > >+ /* Offset of the next modversion entry in relation to this one. *=
/
> >> > >+ u32 next;
> >> > >+ u32 crc;
> >> > >+ char name[0];
> >> >
> >> > although not really exported as uapi, this will break userspace as t=
his is
> >> > used in the  elf file generated for the modules. I think
> >> > this change must be made in a backward compatible way and kmod updat=
ed
> >> > to deal with the variable name length:
> >> >
> >> > kmod $ git grep "\[64"
> >> > libkmod/libkmod-elf.c:  char name[64 - sizeof(uint32_t)];
> >> > libkmod/libkmod-elf.c:  char name[64 - sizeof(uint64_t)];
> >> >
> >> > in kmod we have both 32 and 64 because a 64-bit kmod can read both 3=
2
> >> > and 64 bit module, and vice versa.
> >> >
> >>
> >> Hi Lucas,
> >>
> >> Thanks for the information.
> >>
> >> The change can't be "truly" backward compatible, in a sense that
> >> regardless of the new format we choose, kmod would not be able to deco=
de
> >> symbols longer than "64 - sizeof(long)" bytes. So the list it retrieve=
s
> >> is going to be incomplete, isn't it?
> >>
> >> What kind of backward compatibility should be expected? It could be:
> >> * short symbols can still be found by old versions of kmod, but not
> >>   long symbols;
> >
> >That sounds good. Not everyone is using rust, and with this option
> >people who do will need to upgrade tooling, and people who don't care
> >don't need to do anything.
>
> that could be it indeed. My main worry here is:
>
> "After the support is added in kmod, kmod needs to be able to output the
> correct information regardless if the module is from before/after the
> change in the kernel and also without relying on kernel version."
> Just changing the struct modversion_info doesn't make that possible.
>
> Maybe adding the long symbols in another section? Or ble
> just increase to 512 and add the size to a
> "__versions_hdr" section. If we then output a max size per module,
> this would offset a little bit the additional size gained for the
> modules using rust. And the additional 0's should compress well
> so I'm not sure the additional size is that much relevant here.





I also thought of new section(s) for long symbols.



One idea is to have separate sections for CRCs and symbol names.




section __version_crc:
   0x12345678
   0x23456789
   0x34567890


section __version_sym:
  "very_very_very_very_long_symbol"
  "another_very_very_very_very_very_long_symbol"
  "yet_another_very_very_very_very_very_long_symbol"




You can iterate in each section with this:

   crc +=3D sizeof(u32);
   name +=3D strlen(name) + 1;


Benefits:
  - No next pointer
  - No padding
    - *.mod.c is kept human readable.





BTW, the following is impossible
because the pointer reference to .rodata
is not available at this point?

struct modversion_info {
     u32 crc;
     const char *name:
};



--=20
Best Regards
Masahiro Yamada
