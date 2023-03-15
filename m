Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC66BB983
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCOQUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjCOQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:19:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C326B1CF74;
        Wed, 15 Mar 2023 09:19:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6199961DF2;
        Wed, 15 Mar 2023 16:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB12C433A0;
        Wed, 15 Mar 2023 16:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678897140;
        bh=s/UR+rMqXgjNiMejx6NvJ82ozNlF7r5j28HwdNJ2jWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NDxg4L/nDrcff4Dfo4WwNjOWouDATRcxY11eCvYZZPg8C4DQhiAkuqoiG6eoVE5+x
         WLRd8F0KcAtGJGNKaZylgfcl9EeggpJ+ODSKDwNogU0Xg5dMwflN0+cHobQ8owNLrA
         4EgxcLnQEC6+cs5Awnoyb9R9eJjEbafkvC9N0ZDj85L8anq3CUzgWcEVafx5AUUU0A
         vmt8jLkaQ4niH4c0Lh0B4BOvWxDcLXyzwweMZp4fhrSM+6/9TsWkAe3xR+bR/L2Sdj
         ik2yE9YMGAywxUH6B0ukwq/90zHsHZGGYCS24qJgJ/UdmB0X8VurCe3S+Wem36DgFV
         p4Tx0fx0sZGTw==
Received: by mail-ot1-f45.google.com with SMTP id x16-20020a9d6d90000000b0069aa2f33789so982024otp.4;
        Wed, 15 Mar 2023 09:19:00 -0700 (PDT)
X-Gm-Message-State: AO0yUKVpRQm+qmCt2wJMjEGyRZcVFGNpux3B5efEZo4tU/t1/1/drMTX
        sukGuKdzIl21m74/gpMX8TpRjX6I9KI0jEEsxXg=
X-Google-Smtp-Source: AK7set+RObHaBAeZtiuhCRl8G74EUcjxBryzkMIotLf70CTLQeBIcJJA7IS/IlDDVuY75wqz0efcog66F7wPTEIDA5M=
X-Received: by 2002:a9d:2b0:0:b0:698:b03a:4fb0 with SMTP id
 45-20020a9d02b0000000b00698b03a4fb0mr1652071otl.1.1678897139974; Wed, 15 Mar
 2023 09:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230111161155.1349375-1-gary@garyguo.net> <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz> <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
 <20230313220234.GZ19419@kitsune.suse.cz> <ZA+fGpAdnvB5VwKW@righiandr-XPS-13-7390>
 <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
In-Reply-To: <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Mar 2023 01:18:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASSxfEPp+e1=sP0FAYLMXjyT7T5iqe8=UJB+XNYMt6ogQ@mail.gmail.com>
Message-ID: <CAK7LNASSxfEPp+e1=sP0FAYLMXjyT7T5iqe8=UJB+XNYMt6ogQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
To:     Andrea Righi <andrea.righi@canonical.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:38=E2=80=AFPM Andrea Righi
<andrea.righi@canonical.com> wrote:
>
> On Mon, Mar 13, 2023 at 11:09:31PM +0100, Andrea Righi wrote:
> > On Mon, Mar 13, 2023 at 11:02:34PM +0100, Michal Such=C3=A1nek wrote:
> > > On Mon, Mar 13, 2023 at 10:53:34PM +0100, Andrea Righi wrote:
> > > > On Mon, Mar 13, 2023 at 10:48:53PM +0100, Michal Such=C3=A1nek wrot=
e:
> > > > > Hello,
> > > > >
> > > > > On Mon, Mar 13, 2023 at 09:32:16PM +0100, Andrea Righi wrote:
> > > > > > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> > > > > > > Currently modversion uses a fixed size array of size (64 - si=
zeof(long))
> > > > > > > to store symbol names, thus placing a hard limit on length of=
 symbols.
> > > > > > > Rust symbols (which encodes crate and module names) can be qu=
ite a bit
> > > > > > > longer. The length limit in kallsyms is increased to 512 for =
this reason.
> > > > > > >
> > > > > > > It's a waste of space to simply expand the fixed array size t=
o 512 in
> > > > > > > modversion info entries. I therefore make it variably sized, =
with offset
> > > > > > > to the next entry indicated by the initial "next" field.
> > > > > > >
> > > > > > > In addition to supporting longer-than-56/60 byte symbols, thi=
s patch also
> > > > > > > reduce the size for short symbols by getting rid of excessive=
 0 paddings.
> > > > > > > There are still some zero paddings to ensure "next" and "crc"=
 fields are
> > > > > > > properly aligned.
> > > > > > >
> > > > > > > This patch does have a tiny drawback that it makes ".mod.c" f=
iles generated
> > > > > > > a bit less easy to read, as code like
> > > > > > >
> > > > > > >     "\x08\x00\x00\x00\x78\x56\x34\x12"
> > > > > > >     "symbol\0\0"
> > > > > > >
> > > > > > > is generated as opposed to
> > > > > > >
> > > > > > >     { 0x12345678, "symbol" },
> > > > > > >
> > > > > > > because the structure is now variable-length. But hopefully n=
obody reads
> > > > > > > the generated file :)
> > > > > > >
> > > > > > > Link: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol=
 length to 512")
> > > > > > > Link: https://github.com/Rust-for-Linux/linux/pull/379
> > > > > > >
> > > > > > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > > > >
> > > > > > Is there any newer version of this patch?
> > > > > >
> > > > > > I'm doing some tests with it, but I'm getting boot failures on =
ppc64
> > > > > > with this applied (at boot kernel is spitting out lots of oops'=
es and
> > > > > > unfortunately it's really hard to copy paste or just read them =
from the
> > > > > > console).
> > > > >
> > > > > Are you using the ELF ABI v1 or v2?
> > > > >
> > > > > v1 may have some additional issues when it comes to these symbol =
tables.
> > > > >
> > > > > Thanks
> > > > >
> > > > > Michal
> > > >
> > > > I have CONFIG_PPC64_ELF_ABI_V2=3Dy in my .config, so I guess I'm us=
ing v2.
> > > >
> > > > BTW, the issue seems to be in dedotify_versions(), as a silly test =
I
> > > > tried to comment out this function completely to be a no-op and now=
 my
> > > > system boots fine (but I guess I'm probably breaking something else=
).
> > >
> > > Probably not. You should not have the extra leading dot on ABI v2. So=
 if
> > > dedotify does something that means something generates and then expec=
ts
> > > back symbols with a leading dot, and this workaround for ABI v1 break=
s
> > > that. Or maybe it is called when it shouldn't.
> >
> > Hm.. I'll add some debugging to this function to see what happens exact=
ly.
>
> Alright I've done more tests across different architectures. My problem
> with ppc64 is that this architecture is evaluating sechdrs[i].sh_size
> using get_stubs_size(), that apparently can add some extra padding, so
> doing (vers + vers->next < end) isn't a reliable check to determine the
> end of the variable array, because sometimes "end" can be greater than
> the last "vers + vers->next" entry.


I am not familiar enough with ppc, so I may be misundering.

Checking the for-loop in module_frob_arch_sections(),
they seem to be orthogonal to me.

dedotify_versions() is only called for the "__versions" section.
get_stubs_size() only affects the ".stubs" section.
I did not get how they are related to each other.


BTW, we decided to not go in this direction in the former discussion.
I am not sure how much effort is needed to track down the issue
in this version.

If we add new sections to keep the backward compatibility
for the current "__versions", this issue may not exist.



> In general I think it'd be more reliable to add a dummy NULL entry at
> the end of the modversion array.
>
> Moreover, I think we also need to enforce struct modversion_info to be
> __packed, just to make sure that no extra padding is added (otherwise it
> may break our logic to determine the offset of the next entry).
>
> > @@ -2062,16 +2066,25 @@ static void add_versions(struct buffer *b, stru=
ct module *mod)
> >                               s->name, mod->name);
> >                       continue;
> >               }
> > -             if (strlen(s->name) >=3D MODULE_NAME_LEN) {
> > -                     error("too long symbol \"%s\" [%s.ko]\n",
> > -                           s->name, mod->name);
> > -                     break;
> > -             }
> > -             buf_printf(b, "\t{ %#8x, \"%s\" },\n",
> > -                        s->crc, s->name);
> > +             name_len =3D strlen(s->name);
> > +             name_len_padded =3D (name_len + 1 + 3) & ~3;
> > +
> > +             /* Offset to next entry */
> > +             tmp =3D TO_NATIVE(8 + name_len_padded);
>
> ^ Here's another issue that I found, you can't use TO_NATIVE() in this
> way, some compilers are complaining (like on s390x this doesn't build).
>
> So we need to do something like:
>
>         /* Offset to next entry */
>         tmp =3D 8 + name_len_padded
>         tmp =3D TO_NATIVE(tmp);
>
> I'll do some additional tests with these changes and send an updated
> patch (for those that are interested).
>
> -Andrea



--
Best Regards
Masahiro Yamada
