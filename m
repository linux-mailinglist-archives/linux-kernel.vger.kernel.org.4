Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ABB6DBBB4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDHPCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 11:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDHPCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 11:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C8259DA;
        Sat,  8 Apr 2023 08:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA79160A73;
        Sat,  8 Apr 2023 15:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4684FC4339B;
        Sat,  8 Apr 2023 15:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680966127;
        bh=KCF/0Tibfx4I4RExzaZxaJFHJNBnZehCKc6tyP06KRw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M6THKPfqVZDC9QpvRC8LqgxR8nzLRHRO4WttJRKgM/0HUvFX2vJyHP5i25iuLcnNh
         NPrYZ44btLmOCf0pZDE3WGNjUo8iuX8PfvWu1QMg3ygAVx/J8ZeGj5BDr8plUo3uoT
         XLPhHre2Q3boRklRsQ7zRgtNeeJNPyKT8kg4q3EWHRxM+0zYci4RxRB9BPeAMOEcGL
         lWgGKAuO0w6++/8oIJAqSLDuPludUB7cN4iH2hm16tEJS2gOnqDcxqEqMOSolFHuf/
         ePW7PaIGQzBKZ+cB8+xzqgliLsyRT2h/foAOF3Cc4F6Ikk65sQpkVwbe6NUIbDhcnm
         W7VKAoKEdPgPw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1842df7cb53so1433157fac.10;
        Sat, 08 Apr 2023 08:02:07 -0700 (PDT)
X-Gm-Message-State: AAQBX9cygfb5L0yk6ezyETlMjsAnXUH/hzoiEPSDcUcdiI3+qNqoTFuQ
        xUebFaZQz6hOU81F+G25vHOhkrpo8IDzXXTDR4Y=
X-Google-Smtp-Source: AKy350ZAHzHq5Rd7ipsVmZUlTezDkSzOxsC2jCPqr4vxSd7oKwjEHB2UQk6O7FuJQ0ugd/jCEJD1g9DlVIYd3jcqQzM=
X-Received: by 2002:a05:6870:1119:b0:17e:9b69:3ee5 with SMTP id
 25-20020a056870111900b0017e9b693ee5mr2445651oaf.11.1680966126561; Sat, 08 Apr
 2023 08:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-3-masahiroy@kernel.org>
 <CAKwvOdnmiL_wDgzepYb+ZGgWt2xnsp48-awn0Cd0c4RDR43t_Q@mail.gmail.com> <CAKwvOdn1Sjj=t1XJ3K-etFnemMs7UkbyGmbHC4c2H4O=77sjHg@mail.gmail.com>
In-Reply-To: <CAKwvOdn1Sjj=t1XJ3K-etFnemMs7UkbyGmbHC4c2H4O=77sjHg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 9 Apr 2023 00:01:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARar5i7FxEHPH9M3OaU6wKxpXhc0Tj0iT32VPw0TNLR2g@mail.gmail.com>
Message-ID: <CAK7LNARar5i7FxEHPH9M3OaU6wKxpXhc0Tj0iT32VPw0TNLR2g@mail.gmail.com>
Subject: Re: [PATCH 3/8] scripts/mksysmap: use sed with in-line comments
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 4:01=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Fri, Apr 7, 2023 at 11:59=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Mar 8, 2023 at 3:53=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> > >
> > > Move comments close to the code.
> >
> > Consider adding to the commit message why you switch from grep to sed;
> > that's currently unclear.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Also, perhaps scripts/mksysmap could just be replaced with a sed
> input-file? Then
> scripts/link-vmlinux.sh would invoke nm and pipe it into that sed script?



I still need shell.


The last line of the next commit 4/8 uses
shell code.



--=20
Best Regards
Masahiro Yamada
