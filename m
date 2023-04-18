Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DD6E6D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjDRT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDRT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5219776;
        Tue, 18 Apr 2023 12:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F7F46389D;
        Tue, 18 Apr 2023 19:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BFBC433EF;
        Tue, 18 Apr 2023 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681847806;
        bh=1baWnnsOYQNcfQ6JgaY1FCV+Q/yFo/OKljnAUA/yo7o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZQV0UbOYlRa2PnvGE07lApoerEcvPIhcWcQONv420DovZx7ssFaWMFrjt2l2KKx3
         5qgMQar8iwxUAXeviM9IiuUpzHODBU2bN0tSQ2IzaVEPPWUL2nEb9P3CBbhfhiaRx+
         XRc7so7gItC0l8SogyzWCGGKPBwBsHT2oUmqn42+p9+Cauu/hltf6nLk1sYVmip4dx
         kJyEtw1WMQA7F2JWdUmb2plBWA8UgjaZYIy/iCO+5CjwA9e1baJv0Rqf8w6j0BtqL9
         c6mN2uDJvZGwJMF11/3IRVJZiJKtS8QYG86VM859dHT3hQU1lw99bfKESrt4Gl2Dx1
         76znlPOtpsDsQ==
Received: by mail-yb1-f182.google.com with SMTP id k39so8449793ybj.8;
        Tue, 18 Apr 2023 12:56:46 -0700 (PDT)
X-Gm-Message-State: AAQBX9eot/H9NtWHhvRdAyEUY6xLJSg5XWvtGbO29rU3syOYQHpCDKl4
        CkYlBbrWcLsmbrwhG+xiiMAwsnX0r3iYtkQbyg==
X-Google-Smtp-Source: AKy350b2kwnFHC8moys3w7DzqeW537uNq+2dpf8DUVz7knHxiYvUG+d4B+vNSo1Jz96Xk/6CnCJb3hf6L09XNwv3be4=
X-Received: by 2002:a25:76ce:0:b0:b95:e649:34b6 with SMTP id
 r197-20020a2576ce000000b00b95e64934b6mr1344329ybc.1.1681847805973; Tue, 18
 Apr 2023 12:56:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230315121303.3358416-1-tmricht@linux.ibm.com>
In-Reply-To: <20230315121303.3358416-1-tmricht@linux.ibm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Apr 2023 14:56:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJo14uLmz5n4gSEf0gjEcODCMrsNEZKj_EnZoVPGFfDQw@mail.gmail.com>
Message-ID: <CAL_JsqJo14uLmz5n4gSEf0gjEcODCMrsNEZKj_EnZoVPGFfDQw@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Fix wrong size for perf test Setup struct perf_event_attr
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, jolsa@kernel.org, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 7:13=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The test case ./perf test 'Setup struct perf_event_attr' fails.
> On s390 this output is observed:
>
>  # ./perf test -Fvvvv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  running './tests/attr/test-stat-C0'
>  Using CPUID IBM,8561,703,T01,3.6,002f
>  .....
>  Event event:base-stat
>       fd =3D 1
>       group_fd =3D -1
>       flags =3D 0|8
>       cpu =3D *
>       type =3D 0
>       size =3D 128     <<<--- wrong, specified in file base-stat
>       config =3D 0
>       sample_period =3D 0
>       sample_type =3D 65536
>       ...
>  'PERF_TEST_ATTR=3D/tmp/tmpgw574wvg ./perf stat -o \
>         /tmp/tmpgw574wvg/perf.data -e cycles -C 0 kill >/dev/null \
>         2>&1 ret '1', expected '1'
>   loading result events
>     Event event-0-0-4
>       fd =3D 4
>       group_fd =3D -1
>       cpu =3D 0
>       pid =3D -1
>       flags =3D 8
>       type =3D 0
>       size =3D 136     <<<--- actual size used in system call
>       .....
>   compare
>     matching [event-0-0-4]
>       to [event:base-stat]
>       [cpu] 0 *
>       [flags] 8 0|8
>       [type] 0 0
>       [size] 136 128
>     ->FAIL
>     match: [event-0-0-4] matches []
>   expected size=3D136, got 128
>   FAILED './tests/attr/test-stat-C0' - match failure
>
> This mismatch is caused by
> commit 09519ec3b19e ("perf: Add perf_event_attr::config3")
> which enlarges the structure perf_event_attr by 8 bytes.
>
> Fix this by adjusting the expected value of size.
>
> Output after:
>  # ./perf test -Fvvvv 17
>  17: Setup struct perf_event_attr                                    :
>  --- start ---
>  running './tests/attr/test-stat-C0'
>  Using CPUID IBM,8561,703,T01,3.6,002f
>  ...
>   matched
>   compare
>     matching [event-0-0-4]
>       to [event:base-stat]
>       [cpu] 0 *
>       [flags] 8 0|8
>       [type] 0 0
>       [size] 136 136
>       ....
>    ->OK
>    match: [event-0-0-4] matches ['event:base-stat']
>  matched
>
> Fixes: 09519ec3b19e ("perf: Add perf_event_attr::config3")

Shouldn't a kernel with this change work with an old version of perf withou=
t?

Anyways, looks like the change is needed regardless.

Acked-by: Rob Herring <robh@kernel.org>

>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/tests/attr/base-record       | 2 +-
>  tools/perf/tests/attr/base-stat         | 2 +-
>  tools/perf/tests/attr/system-wide-dummy | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
