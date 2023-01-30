Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482F66817B8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbjA3Rfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbjA3Rfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:35:41 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF294520B;
        Mon, 30 Jan 2023 09:35:08 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso3740369wms.5;
        Mon, 30 Jan 2023 09:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EHjZ+YN0j4sLX2KHlCojw242O/2EHaDDkDQJJPYtaLQ=;
        b=OHR1HHrnyewta5PX324PMuUipBvZZEmlPwmSCWynFvinnfaP1FAF5tbiBLSelOCH0y
         6pF3aUJyU6ApuHLiTJUB/G9H+180PRP00xvE5HAvDIWYdl4asMm1zqIiAD5lt6gAAypr
         Lcu0VY0ADFJuYMXuGTeDAEm3Hv3u8kInUpUntHpHbjqZ48qf0v9KRSzZQwDxrx8Dp4lB
         PxsGee6HBy6jjfINYWFaImKuyaFLhIeKMzf/wi2wtMt+nwyqSZyDCvm/j2HRmnwjmQx2
         +kKyeeH7HpNfi1AgSD9ZRiAMG3swRme8G4fpp849jDybmaM/HNluj4bNxg4XUg5MKbfp
         o3Fg==
X-Gm-Message-State: AO0yUKWLOC/2PJ5v5tmaWc0LTP7awX67huUc9O4Ke4vi1UHXUW+xa0OF
        +6Wh8caQEVrF/NmP0dCqgBZzY9yF9wsz960uSsw=
X-Google-Smtp-Source: AK7set9WP8nYtp2JJtUO/vZuxso2tWygrLPvcMPpqRYgEEqBa3pbZZPMgzcWdGcfXGOr6j4rP6f1f3EfZoO2M5fdEb8=
X-Received: by 2002:a05:600c:3481:b0:3dc:5844:6394 with SMTP id
 a1-20020a05600c348100b003dc58446394mr320269wmq.131.1675100095555; Mon, 30 Jan
 2023 09:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20230127170222.9895-1-adrian.hunter@intel.com> <20230127170222.9895-3-adrian.hunter@intel.com>
In-Reply-To: <20230127170222.9895-3-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 30 Jan 2023 09:34:44 -0800
Message-ID: <CAM9d7chny89+rtP6orSJOKrAqb4GbzCG53KV4O1J9mhKvCcWnQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] perf symbols: Add support for x86 .plt.sec
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URI_NOVOWEL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Jan 27, 2023 at 9:02 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> The section .plt.sec was originally added for MPX and was first called
> .plt.bnd. While MPX has been deprecated, .plt.sec is now also used for IBT.
> On x86_64, IBT seems to be enabled by default, but can be switched off
> using gcc option -fcf-protection=none. On 32-bit, option -z ibt will
> enable IBT.
>
> With .plt.sec, calls are made into .plt.sec instead of .plt, so it
> makes more sense to put the symbols there instead of .plt. A notable
> difference is that .plt.sec does not have a header entry.
>
> For x86, when synthesizing symbols for plt, use offset and entry size of
> .plt.sec instead of .plt when there is a .plt.sec section.
>
> Example on Ubuntu 22.04 gcc 11.3:
>
>   Before:
>
>     $ cat tstpltlib.c
>     void fn1(void) {}
>     void fn2(void) {}
>     void fn3(void) {}
>     void fn4(void) {}
>     $ cat tstplt.c
>     void fn1(void);
>     void fn2(void);
>     void fn3(void);
>     void fn4(void);
>
>     int main()
>     {
>             fn4();
>             fn1();
>             fn2();
>             fn3();
>             return 0;
>     }
>     $ gcc --version
>     gcc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
>     Copyright (C) 2021 Free Software Foundation, Inc.
>     This is free software; see the source for copying conditions.  There is NO
>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>     $ gcc -Wall -Wextra -shared -o libtstpltlib.so tstpltlib.c
>     $ gcc -Wall -Wextra -o tstplt tstplt.c -L . -ltstpltlib -Wl,-rpath=$(pwd)
>     $ readelf -SW tstplt | grep 'plt\|Name'
>       [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>       [11] .rela.plt         RELA            0000000000000698 000698 000060 18  AI  6  24  8
>       [13] .plt              PROGBITS        0000000000001020 001020 000050 10  AX  0   0 16
>       [14] .plt.got          PROGBITS        0000000000001070 001070 000010 10  AX  0   0 16
>       [15] .plt.sec          PROGBITS        0000000000001080 001080 000040 10  AX  0   0 16

On my machine, it's not enabled by default.  And it doesn't create .plt.sec
even if I pass -fcf-protection=full option.

$ gcc --version
gcc (Debian 12.2.0-10) 12.2.0
Copyright (C) 2022 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ gcc -Wall -Wextra -shared -fcf-protection=full -o libtstplt.so tstpltlib.c
$ gcc -Wall -Wextra -fcf-protection=full -o tstplt tstplt.c -L.
-ltstpltlib -Wl,-rpath,$(pwd)
$ readelf -SW tstplt | grep 'plt\|Name'
   [Nr] Name              Type            Address          Off    Size
  ES Flg Lk Inf Al
   [11] .rela.plt         RELA            0000000000000688 000688
000060 18  AI  6  24  8
   [13] .plt              PROGBITS        0000000000001020 001020
000050 10  AX  0   0 16
   [14] .plt.got          PROGBITS        0000000000001070 001070
000008 08  AX  0   0  8
   [24] .got.plt          PROGBITS        0000000000003fe8 002fe8
000038 08  WA  0   0  8

Thanks,
Namhyung
