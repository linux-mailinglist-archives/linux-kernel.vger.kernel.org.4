Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8E60E28B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiJZNs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiJZNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:48:12 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF989AE0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:10 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id e22so7206175uar.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brkO0GpjOrpi4VWYJB4XkhBpPumLSjQCpTphhW2JZPo=;
        b=oh3GGcDPzN8aJCP4zdGgyu/Zd31WmknhfgzIcwarhRvzJn5aMkWGNqBDMWQEZMKfgf
         DGUN6CabHhcq3tWnep9V5LH1Ryf8ey+grC5zwjNDBzcJiucLqURJNllmLub6Ewf76dhD
         2h/e1/W2ZB8S/3pd4R7IvGAyLoYBy9B9ZshzqRWOfX4gmYn2FcnSNtaQcMzB+4B/vB1R
         4vO8sBa4wFL5OGXOJLmoNSCy6TiRAiGqG9VX3UpnZGPWq+h0QdzwsTxlsOyd1g/wD5OR
         oT3Wry67yvPo5xlDawBBFBHguhcLkyS0Scam1z9/sxiFIvNoUlJIzrbZRTXo6aQpnb1c
         WcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brkO0GpjOrpi4VWYJB4XkhBpPumLSjQCpTphhW2JZPo=;
        b=NXVXxArhuduK/x0cCkH+FBDH833nHCuDN7oapeH5Z6znidD1y4n9C0kEIoUeoamqXs
         lKRvCqLr+MzRX0vNsAX5NsJ3ABGv9XkWx3RJIxcTcUZW8uuLvifx4vWGCVSH5GwPvduL
         hZQfl55O4qmPnBmA80H7+eBCdlYRw7WqV8woTCUB9bP8oYLIr7l5oNjY/O90tf+VOrwo
         P9UTRqwDUY/OPmiyHw/htQ6ZJfhGjs/i4Z3xw74A5Tltk1kYcHWbsiqyM/nSkR7vEDZw
         aH0QfYEI0IfEQEbGhuYXEBlEjfWNnDJpLD4JOXQer4G8WBhHqg90FPTLM13OPWB+QUuq
         7A7g==
X-Gm-Message-State: ACrzQf38XchM0Cffr3aVAL6UobsrTs64ZvhhRDWJKhS+eJjGIJ2bJnkZ
        6rc8XKslGZQY8XHxPyuV9fNa+Mg+R8fV2+U2NEN4SA==
X-Google-Smtp-Source: AMsMyM4N2vl2bTb9+z16PpwEN0NR7LmLKM9dvkBLSO3wmPZUqM7AcQ+W2T6ZNxlcbX0kkdlHCD+iHHOd9lU2AexlFRo=
X-Received: by 2002:a67:d20b:0:b0:3aa:52e6:9802 with SMTP id
 y11-20020a67d20b000000b003aa52e69802mr899600vsi.35.1666792089664; Wed, 26 Oct
 2022 06:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221025231043.115295-1-mairacanal@riseup.net>
In-Reply-To: <20221025231043.115295-1-mairacanal@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 26 Oct 2022 21:47:57 +0800
Message-ID: <CABVgOSn=JdcUtQm=o8+chLo4pDJbZEWA2nbbXz=AgByNhFghFA@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Introduce KUNIT_EXPECT_MEMEQ and
 KUNIT_EXPECT_MEMNEQ macros
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com,
        andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 7:11 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_E=
Q or
> KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp functio=
n,
> such as:
>   KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);
>
> Although this usage produces correct results for the test cases, if the
> expectation fails the error message is not very helpful, indicating only =
the
> return of the memcmp function.
>
> Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ that compare memory blocks until a determined size. I=
n
> case of expectation failure, those macros print the hex dump of the memor=
y
> blocks, making it easier to debug test failures for memory blocks.
>
> The v7 has some formatting changes on the first patch and it was rebased =
on
> top of the mainline (due to 7089003304c6).
>
> The first patch of the series introduces the KUNIT_EXPECT_MEMEQ and
> KUNIT_EXPECT_MEMNEQ. The second patch adds an example of memory block
> expectations on the kunit-example-test.c. And the last patch replaces the
> KUNIT_EXPECT_EQ for KUNIT_EXPECT_MEMEQ on the existing occurrences.
>
> Best Regards,
> - Ma=C3=ADra Canal
>
> v1 -> v2: https://lore.kernel.org/linux-kselftest/2a0dcd75-5461-5266-2749=
-808f638f4c50@riseup.net/T/#m402cc72eb01fb3b88d6706cf7d1705fdd51e5da2
>
> - Change "determinated" to "specified" (Daniel Latypov).
> - Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to =
make
> it easier for users to infer the right size unit (Daniel Latypov).
> - Mark the different bytes on the failure message with a <> (Daniel Latyp=
ov).
> - Replace a constant number of array elements for ARRAY_SIZE() (Andr=C3=
=A9 Almeida).
> - Rename "array" and "expected" variables to "array1" and "array2" (Danie=
l Latypov).
>
> v2 -> v3: https://lore.kernel.org/linux-kselftest/20220802212621.420840-1=
-mairacanal@riseup.net/T/#t
>
> - Make the bytes aligned at output.
> - Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Daniel L=
atypov).
> - Line up the trailing \ at macros using tabs (Daniel Latypov).
> - Line up the params to the functions (Daniel Latypov).
> - Change "Increament" to "Augment" (Daniel Latypov).
> - Use sizeof() for array sizes (Daniel Latypov).
> - Add Daniel Latypov's tags.
>
> v3 -> v4: https://lore.kernel.org/linux-kselftest/CABVgOSm_59Yr82deQm2C=
=3D18jjSv_akmn66zs4jxx3hfziXPeHg@mail.gmail.com/T/#t
>
> - Fix wrapped lines by the mail client (David Gow).
> - Mention on documentation that KUNIT_EXPECT_MEMEQ is not recommended for
> structured data (David Gow).
> - Add Muhammad Usama Anjum's tag.
>
> v4 -> v5: https://lore.kernel.org/linux-kselftest/20220808125237.277126-1=
-mairacanal@riseup.net/
>
> - Rebase on top of drm-misc-next.
> - Add David Gow's tags.
>
> v5 -> v6: https://lore.kernel.org/linux-kselftest/20220921014515.113062-1=
-mairacanal@riseup.net/
>
> - Rebase on top of Linux 6.1.
> - Change KUNIT_ASSERTION macro to _KUNIT_FAILED.
>
> v6 -> v7: https://lore.kernel.org/linux-kselftest/20221018190541.189780-1=
-mairacanal@riseup.net/
>
> - Format nits (David Gow).
> - Rebase on top of Linux 6.1-rc2.
>
> Ma=C3=ADra Canal (3):
>   kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
>   kunit: Add KUnit memory block assertions to the example_all_expect_macr=
os_test
>   kunit: Use KUNIT_EXPECT_MEMEQ macro
>
>  .../gpu/drm/tests/drm_format_helper_test.c    | 12 +--
>  include/kunit/assert.h                        | 33 +++++++
>  include/kunit/test.h                          | 87 +++++++++++++++++++
>  lib/kunit/assert.c                            | 56 ++++++++++++
>  lib/kunit/kunit-example-test.c                |  7 ++
>  net/core/dev_addr_lists_test.c                |  4 +-
>  6 files changed, 191 insertions(+), 8 deletions(-)
>

Thanks very much -- this works here, and be good to go into 6.2.

Cheers,
-- David
