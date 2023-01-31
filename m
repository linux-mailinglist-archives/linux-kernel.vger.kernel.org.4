Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF116832AC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjAaQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjAaQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:29:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9F65BD;
        Tue, 31 Jan 2023 08:29:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F0C0615A6;
        Tue, 31 Jan 2023 16:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D34C433D2;
        Tue, 31 Jan 2023 16:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675182597;
        bh=80ARtY9sgkVPESn81Oqqo5DIsJpKbmYVYBaV3VBCuwQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eWOvPpBqFK7vAeA46vJdFhABLEptcTRkIJIMhzJzD3qCGh0ORrk+NNAvBBoxgd4B9
         HF4apI7dGTOzdlPbp+pQZ4QKPWag4YFxSk+rAqmkwRTfFSPw17o1Js39Hjd8rNZDNt
         aSCX+45vylgVAsygQqyHfDlJEnjJqwnHUJKOD8xWx+VM0NeAxLCAGEEvzHJ3S623aE
         1QXahjRd/RcyZzRQRVi2UHPKX2fgBEhJTNWpiiTUtWmgGEF1zyT7RmHeReUdcNiQeC
         K+XQMgFLQXdXKrPMm5WCB9rx9CVyjnoruY+F02+fRfA3P+w0FHNhT3qxdbxQ3Fjjfi
         o/86JlppRhlXw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1631b928691so19985324fac.11;
        Tue, 31 Jan 2023 08:29:57 -0800 (PST)
X-Gm-Message-State: AFqh2kolhKUfO971MaKZXEzRIfAShLCaJys5G439IrGHo0GYfK4DkZkY
        cXnwzD5faIUvpfpblXTA21rIhu8Wf/MYI8vEP/s=
X-Google-Smtp-Source: AK7set8OuDanNI4MWpW21EocGtrdNwWJiAfbBBJxGVJOPOIKqWivQVkp/cG1s+/i10hMquAZLlASXlcwveDmpN3GZOM=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr2746630oaf.287.1675182596534; Tue, 31
 Jan 2023 08:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20230129184602.3974058-1-masahiroy@kernel.org>
 <20230129184602.3974058-4-masahiroy@kernel.org> <CANiq72=BRW9TunjKQmeMthm7Esc_YKM++NmWh-Dqc9Av13SNow@mail.gmail.com>
 <CAK7LNAQttb=qc5vsZNudYwTxmn=y3HZzVqZwAzMvLfUJXa4OFQ@mail.gmail.com> <CANiq72miWD_MtTrC0Ua7o4Tk5oDbQSFefwmYCsGx3Y=85ziJfQ@mail.gmail.com>
In-Reply-To: <CANiq72miWD_MtTrC0Ua7o4Tk5oDbQSFefwmYCsGx3Y=85ziJfQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Feb 2023 01:29:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3Z+G+pvDEsy0M1YOxV74XSEodU=QrKN-NGqd1KgFagg@mail.gmail.com>
Message-ID: <CAK7LNAR3Z+G+pvDEsy0M1YOxV74XSEodU=QrKN-NGqd1KgFagg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] kbuild: srcrpm-pkg: create source package without cleaning
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 9:00 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jan 30, 2023 at 2:29 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > I guess you are talking about kernel-devel-*.rpm
> > (and linux-headers-.deb).
> >
> > They are not useful for building external modules
> > written in Rust since they do not contain *.rmeta etc.
> > I am not caring about that because Rust support is not
> > mature enough yet.
>
> Yeah, that is what I meant, i.e. since the Rust ML was Cc'd, I checked
> and wanted to say removing `rust` from there was OK (an `Acked-by`
> seemed too much for just that line :).
>
> > I stopped hard-coding the top-level directories.
> > The resulting source package still contains all check-in files
> > under rust/, so it is good from the source package perspective.
>
> Sounds good to me.
>
> > 5/5 changed the behavior because rpm-pkg re-uses the
> > *.src.rpm generated by srcrpm-pkg.
>
> (3/5?)


Yes.


>
> > Having *.src.rpm in the kernel tree seems Redhat's preference.
> > Commit 8818039f959b2efc0d6f2cb101f8061332f0c77e
> > added --define='_srcrpmdir $(srctree)'.
>
> Thanks for the details! I just noticed it, so I thought I would let
> you know just in case.
>
> (Perhaps it could be useful to mention this change in the output in
> the commit message.)


Fair enough.

I updated the commit description in v3.


>
> > In contrast, binary rpm files are generated under rpmbuild/RPMS/.
> > I want to fix this inconsistency, though.
>
> That would be nice.
>
> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
