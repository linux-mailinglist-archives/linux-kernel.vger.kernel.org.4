Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE646FA2C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjEHJAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjEHI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:59:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBE19D7B
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683536346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z8PQHzvF0FP7YhREChxFpdi1OEWsLB9gDTNuS4qVQWg=;
        b=OcQhKEaI56N6jG0yfYpRNhYXNyT/IxrVTaVWyhVEAevYpgDBtrhFCTwY7TlYLPjlwomivC
        5ndLXOzDHwftTMBp21cz4lHg2klh6imN1w5StT3vZtUaL8QJ/yyi9YPJ8d43W9ys3ofRlU
        C+juQ6381uiZTdpgNjeQIHEvpq4WZQw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-SOoDxs-WPYuS61hjV6swaA-1; Mon, 08 May 2023 04:59:05 -0400
X-MC-Unique: SOoDxs-WPYuS61hjV6swaA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ef455ba61cso2366028e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 01:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536343; x=1686128343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8PQHzvF0FP7YhREChxFpdi1OEWsLB9gDTNuS4qVQWg=;
        b=XiSMC4p1xFb0Xphc5jqrsoKqcsiqnBWdN8hQNai1ttAAbRgX2MQbfqviqRlYowHuGO
         o/ipiE7b9gh3yFzKjNIRAyA+yMpPAxcDdj3AeLpZ1BEl3KHAUOzPS2ImBHSgHL+c7y0v
         CwbvPoEmIB14NQ6N89fQKAEuX2mtKEpsl8CvnPDJbOV+GHer/5ZwqSwPrImp5lLUkRvy
         fXaNo/FTxgl9HHpk1jZQnVuqNvRPrhmKvrLFpKUtTqh91vB+Rz/7Ti0HjcFg/fUnde7m
         h4zqci9IpFT2P6FmsTfmv9r4WtaHYvofCLx1MriyhFro0QiuIatPodEFgXVeKkv4B/5J
         o7tA==
X-Gm-Message-State: AC+VfDyh9dA/eWr5doIeSL4wekzCrsCdYnIz5Uufjk1OUgChlMbtz5vk
        acLnTcEHNZ4kdx1EPzIFMXa9EvFsAn3c8qWfZJjI4Y0Kl7ynGewJ/C5g+tStD3rmhY9QOhWRkw+
        R2gCvUAEtGaCHJ91/AFdXkCP+oWVRX+EjvBz5v2GrxEIj1LZzk6I=
X-Received: by 2002:ac2:5d6b:0:b0:4eb:dd2:f3d2 with SMTP id h11-20020ac25d6b000000b004eb0dd2f3d2mr2693942lft.43.1683536343563;
        Mon, 08 May 2023 01:59:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63YO7xV1WKt85Q3j4jnjmwIGLNsUmwvNwsNOVHiKq8JGKCJbAnTBTqVleQEPxwVLe5YvO1jN0e77N/2pCT2dM=
X-Received: by 2002:ac2:5d6b:0:b0:4eb:dd2:f3d2 with SMTP id
 h11-20020ac25d6b000000b004eb0dd2f3d2mr2693932lft.43.1683536343194; Mon, 08
 May 2023 01:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com> <CANiq72=vTLT1PnbWu4pwNNyMO0S413G3O+_TLcCGLiDGr5fH7Q@mail.gmail.com>
In-Reply-To: <CANiq72=vTLT1PnbWu4pwNNyMO0S413G3O+_TLcCGLiDGr5fH7Q@mail.gmail.com>
From:   =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date:   Mon, 8 May 2023 10:58:51 +0200
Message-ID: <CACT4ouf2M1k7SaMgqv1Fj33Wen7UKuUyKp-Y9oer+THiWEebNg@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, danny@kdrag0n.dev, linux-kernel@vger.kernel.org,
        corbet@lwn.net, joe@perches.com, linux@rasmusvillemoes.dk,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I finally had a chance to look at this.

On Fri, Apr 14, 2023 at 3:36=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Apr 14, 2023 at 12:11=E2=80=AFPM =C3=8D=C3=B1igo Huguet <ihuguet@=
redhat.com> wrote:
> >
> > EditorConfig is a specification to define the most basic code formattin=
g
> > stuff, and it's supported by many editors and IDEs, either directly or
> > via plugins, including VSCode/VSCodium, Vim, emacs and more.
>
> Thanks -- v3 looks much safer!
>
> To clarify the risks (it would be nice to detail these in the commit mess=
age):
>
>   - Did you sample files manually or did you automate the search (e.g.
> grepping for spaces/tabs, for LF, etc.) to verify the current rules
> match the files in the kernel tree?

Originally I sampled manually, but I have crafted a script to collect
more data. It's not 100% reliable, but good to get an idea. It reads
the leading whitespaces and if >80% of the lines have one kind of
indentation, it considers that it's the one used in that file. The
results, filtered to show only the relevant ones, are pasted at the
end.

These are some personal conclusions from the script's results:
- .py: although the official and most widely used style in the
community is 4-space indentation, in Linux tree many files use tabs.
What should we do here? 4-space is the clear standard for python...
- .rb: only one file in the whole tree
- .pm: only 3 files in the whole tree
- Files with many different indentations, better not to specify them:
rst, cocci, tc, xsl, manual pages
- Files that we should specify, tab indented: awk, dts, dtsi, dtso, s, S
- Files that we might specify, with preference for tab indenting but
not 100% clear: sh, bash, pl
- Files in tools/perf/scripts/*/bin/*: there is no clear formatting
for any file type, only for .py files that are tab-indented. To get
these results I've run my script from tools/perf/scripts directory.

>   - Would it be possible to go further than grepping and apply the
> rules (e.g. trigger a "save") through the entire tree to see whether
> there would be spurious changes?
>
>     If that comes out clean (or mostly clean), then we would be fairly
> confident this will not surprise developers (and it would be nice to
> have the script around for future updates of the `.editorconfig`).
>
>     Perhaps EditorConfig provides a script to check this already?
> Otherwise perhaps it can be done with editorconfig-core-c or
> editorconfig-vim or directly scripting on a couple editors?

It seems that EditorConfig libraries are only to parse the config
file, and applying the formatting is completely up to the linter or
editor's specific plugin.

I found a cli tool called editorconfig-checker that checks if there
are files that don't respect the formatting from .editorconfig, but it
gives tons of false positives.

Scripting any editor would be the way, but I don't have experience doing th=
at.

>   - Are we sure the rules match the output of automated formatters we
> are using? (e.g. for Rust we enforce `rustfmt`, and thus we need to
> ensure the editor does not "fight" the formatter; otherwise developers
> may need to run the formatter more).

I'm only aware of Clang and Rust formatter configs in Linux tree, and
I think this complies with them. Do you know about any other?


SCRIPT FILTERED RESULTS:
Note: files might have "unknown" indentation for different reasons:
- there are different styles in a file
- the file contains only non-indented lines like simple Makefiles
- the script got confused with leading alignment whitespaces that
shouldn't be considered indentation
- others?

(1594 ignored files with unknown extension/shebang)

.0:
    tabs:    0
    2-space: 3
    3-space: 1
    4-space: 1
    6-space: 0
    8-space: 0
    unknown: 2

.1:
    tabs:    0
    2-space: 0
    3-space: 1
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 12

.2:
    tabs:    0
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 1

.8:
    tabs:    1
    2-space: 0
    3-space: 1
    4-space: 2
    6-space: 0
    8-space: 1
    unknown: 5

.S:
    tabs:    1253
    2-space: 8
    3-space: 7
    4-space: 2
    6-space: 0
    8-space: 13
    unknown: 47

.awk:
    tabs:    10
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 1

.awk (shebang):
    tabs:    2
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 0

.awk -f (shebang):
    tabs:    1
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 0

.bash (shebang):
    tabs:    12
    2-space: 0
    3-space: 0
    4-space: 5
    6-space: 0
    8-space: 1
    unknown: 38

.bconf:
    tabs:    7
    2-space: 3
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 19

.c:
    tabs:    35746
    2-space: 10
    3-space: 2
    4-space: 26
    6-space: 0
    8-space: 1
    unknown: 507

.cocci:
    tabs:    7
    2-space: 23
    3-space: 3
    4-space: 4
    6-space: 0
    8-space: 0
    unknown: 35

.dts:
    tabs:    2656
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 24

.dtsi:
    tabs:    1977
    2-space: 1
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 20

.dtso:
    tabs:    56
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 1

.h:
    tabs:    17546
    2-space: 93
    3-space: 65
    4-space: 220
    6-space: 2
    8-space: 40
    unknown: 6653

.json:
    tabs:    0
    2-space: 1
    3-space: 0
    4-space: 5
    6-space: 0
    8-space: 0
    unknown: 0

.pl:
    tabs:    28
    2-space: 1
    3-space: 0
    4-space: 2
    6-space: 0
    8-space: 0
    unknown: 18

.py:
    tabs:    43
    2-space: 14
    3-space: 0
    4-space: 87
    6-space: 0
    8-space: 2
    unknown: 6

.py (shebang):
    tabs:    5
    2-space: 0
    3-space: 0
    4-space: 5
    6-space: 0
    8-space: 1
    unknown: 0

.rb:
    tabs:    0
    2-space: 1
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 0

.rs:
    tabs:    0
    2-space: 0
    3-space: 0
    4-space: 35
    6-space: 0
    8-space: 0
    unknown: 3

.rst:
    tabs:    381
    2-space: 581
    3-space: 392
    4-space: 245
    6-space: 17
    8-space: 35
    unknown: 1670

.s:
    tabs:    4
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 0

.sh:
    tabs:    611
    2-space: 24
    3-space: 0
    4-space: 31
    6-space: 1
    8-space: 1
    unknown: 103

.sh (shebang):
    tabs:    26
    2-space: 4
    3-space: 0
    4-space: 2
    6-space: 0
    8-space: 0
    unknown: 14

.sh -x (shebang):
    tabs:    1
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 0

.tc:
    tabs:    8
    2-space: 20
    3-space: 0
    4-space: 40
    6-space: 0
    8-space: 0
    unknown: 34

.txt:
    tabs:    1045
    2-space: 103
    3-space: 8
    4-space: 57
    6-space: 2
    8-space: 14
    unknown: 686

.xsl:
    tabs:    2
    2-space: 0
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 0
    unknown: 8

.yaml:
    tabs:    0
    2-space: 3279
    3-space: 2
    4-space: 12
    6-space: 2
    8-space: 3
    unknown: 57

Kconfig:
    tabs:    1581
    2-space: 1
    3-space: 0
    4-space: 0
    6-space: 0
    8-space: 1
    unknown: 56

Makefile:
    tabs:    823
    2-space: 17
    3-space: 6
    4-space: 3
    6-space: 2
    8-space: 5
    unknown: 2005


>
> Cc'ing Andrew since he applied originally the `.clang-format`.
>
> Cheers,
> Miguel
>


--=20
=C3=8D=C3=B1igo Huguet

