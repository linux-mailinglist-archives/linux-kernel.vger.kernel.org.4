Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B666AF19
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 03:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjAOCkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 21:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjAOCkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 21:40:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA2A248;
        Sat, 14 Jan 2023 18:40:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE79660BDC;
        Sun, 15 Jan 2023 02:40:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC6AC433F1;
        Sun, 15 Jan 2023 02:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673750400;
        bh=0TIlpXUyLjXgCWJoz/frRR9jRP9rDDMVSVFqtR3tMeA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u3QZQEsTqOENmtWwRPaMnAqKojLu2ZcEpTbuaJn5T7141w0ECFE67bSBG/MhHITmQ
         su607huar2CJEEYnnvyDc4t+pmLIrTajd+ugnd3td9218542nDk2t7AjbaKeH5f4y+
         aK4OcTvgltK3zRD0uKBns0lF68tb0+BDk+MezEjM1Q+ROIzrnv/rAquczd04gnhJTl
         QCkAV4ThOvNGdpDsCLVyZQtX5BBTUA11CbrGjEWrVDVLXerAQhYulwzDVTdTHgsD4S
         1W3t/qnoSj674g9xGSa/tdji22kBu26q/CHuNbgqE9LyDfjYaaSpE4mSScGRot43OZ
         qDYiQ5XJYLhjw==
Received: by mail-ot1-f42.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so14364540oto.5;
        Sat, 14 Jan 2023 18:39:59 -0800 (PST)
X-Gm-Message-State: AFqh2ko8yOICMu+lY0Io/c6hxwwI300uYaaJFaf/+yjvtEvy4MHoWEvd
        c2VwaJMNOuwGsGs8kjlk07B+YraQ61myETMT5Gg=
X-Google-Smtp-Source: AMrXdXtoyZNoBhCTlW2oVmTW6Au80Bu7uDXtz+FY9yhcsQaPhStbX/RPkg215wnou5HpVqBqN5lA8VUlPXTllDvcaFI=
X-Received: by 2002:a05:6830:14c7:b0:684:a3ad:87e8 with SMTP id
 t7-20020a05683014c700b00684a3ad87e8mr1046643otq.225.1673750399222; Sat, 14
 Jan 2023 18:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-5-ojeda@kernel.org>
 <CAK7LNAQj_WykFWcrj=L3wJYxDhOCGs+JHPB4E2vzWcx8y_at0w@mail.gmail.com> <CANiq72=MsV8EXV9cib+GJd0AXbpF8YSGdDd723m7=ON4jhjXxQ@mail.gmail.com>
In-Reply-To: <CANiq72=MsV8EXV9cib+GJd0AXbpF8YSGdDd723m7=ON4jhjXxQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 Jan 2023 11:39:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQo=w3F=VXNGYyo6-A4c8Sees6yVHrsaFXLknCrO0ET3Q@mail.gmail.com>
Message-ID: <CAK7LNAQo=w3F=VXNGYyo6-A4c8Sees6yVHrsaFXLknCrO0ET3Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] kbuild: rust_is_available: fix confusion when a
 version appears in the path
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 8:13 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 6:32 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > +set -- ${bindgen_libclang_output#**clang version}
> > +bindgen_libclang_cversion=$(get_canonical_version $1)
> >  bindgen_libclang_min_version=$($min_tool_version llvm)
> > -bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
>
> Nice trick :) To be honest, I am not really fond of `set`, and in this
> case it means the command is not symmetric (we remove the prefix using
> parameter expansion, and the suffix via positional argument
> selection), but if you prefer it that way, I think it would be fine.


I just tend to write efficient code.
(scripts/{cc,ld,as}-version.sh do not use sed or grep at all.)

Especially, I avoid unneeded process forks
in the process forks.






> However, why the double asterisk? One already matches any string,
> including spaces, no?


Sorry, it is my mistake.

I meant double pound.


  set -- ${bindgen_libclang_output##*clang version}



The double pound strips "the longest matching pattern",
just in case "clang version" is contained in the file path.
(but if a space is contained in the directory path,
it would have failed earlier.






>
> Cheers,
> Miguel




--
Best Regards
Masahiro Yamada
