Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7386B6CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCMAxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCMAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:53:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90250359F;
        Sun, 12 Mar 2023 17:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA220B80DD5;
        Mon, 13 Mar 2023 00:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8946AC4339E;
        Mon, 13 Mar 2023 00:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678668805;
        bh=aA35MRvDWFOQZEAPUMfAgIrT1iLMQXDUWPCevZ4me1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z0rwPqzFa4Im/DKeAxORiHNI/WJ2wRaSs2aVAxlxAN1oVwQO8Q7rAts6s2+DE1jKB
         1bGuSP+2NFf3NRlWTeLTg+OdFYnIOiH8OYLQB4yDdkHxKYIooOJipu00eDReYAgwsa
         EZCozAftaXG4kD69iQiFmus/PM+fxJJ2ufe+OwdOy7GaD2fsJPJBeaORFjElIMfsSx
         LiWaJ1b8JRUVrfYj9l56ke0k0tcZqu+6w40sU2nePDDNhT/Dr+dbXSJG91QgHLln3x
         NL9RGr9XA99LNFV81NeUkwmX+WYlXHaCmhFsn2dh0uUSx0nCB5BA635eXMB/YyDacu
         OyhKTRXcSKI7A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1763e201bb4so12235851fac.1;
        Sun, 12 Mar 2023 17:53:25 -0700 (PDT)
X-Gm-Message-State: AO0yUKX+uUbgU9huH92V37KCdxsFkKOGRHdwBdgzrBxKXo3M9++i1oLT
        FmAM83jr4eyTRxzq/3CJDflK57nHP6i5IMvqbDI=
X-Google-Smtp-Source: AK7set+SmlLmW0ymGVTRP/QgWtdqyuQrqXYoQEokQAEA0Da2YKQ6UA2WOUJEfYsore0EdNSCePuLJwuUR8G2F5OwTXA=
X-Received: by 2002:a05:6870:954c:b0:16a:17d9:b66d with SMTP id
 v12-20020a056870954c00b0016a17d9b66dmr11159290oal.8.1678668804701; Sun, 12
 Mar 2023 17:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230312200731.599706-1-masahiroy@kernel.org> <CAHk-=wgL-GspdmghwQ2kXJO1QCKFY+HieU0arYSFDHBLO0dZuA@mail.gmail.com>
In-Reply-To: <CAHk-=wgL-GspdmghwQ2kXJO1QCKFY+HieU0arYSFDHBLO0dZuA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 13 Mar 2023 09:52:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
Message-ID: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Mon, Mar 13, 2023 at 8:26=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 12, 2023 at 1:07=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > This series fixes some bugs, then switch to 'git archive'
> > for source package creation as suggested by Linus.
>
> Thanks, looks good.
>
> Shouldn't we also revert e0ca16749ac3 ("kbuild: make perf-tar*-src-pkg
> work without relying on git")?
>
>            Linus


Right.

6/6 did that.

It may not be clear enough from the commit description,
but I added the following tag to 6/6.

Fixes: e0ca16749ac3 ("kbuild: make perf-tar*-src-pkg work without
relying on git")



Instead of a verbatim revert, I made some refactoring
to share code among deb-pkg, rpm-pkg, perf-tar*-src-pkg.



--=20
Best Regards
Masahiro Yamada
