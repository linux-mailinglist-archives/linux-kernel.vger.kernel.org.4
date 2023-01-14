Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9266A93B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 05:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjANEcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 23:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjANEcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 23:32:08 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA639E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:32:03 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id v127so19756419vsb.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 20:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oO6Xe/LNqbGKuJJJLeHGIIY9nNJ4QCvJI77KwJY08mk=;
        b=CoPkWkB2ezBrrzBtxTTvgajjrOhW6ivFJOlapQm7cvodY23VoEd6Xt8Y2b3B4YG1tS
         UpLfg5NN3V+RTo9gQuFBs7ElH63xA1xdps3Rd38q/vlyI1AQUooKrZfn1UAV73y2QsRn
         JFzfHZsykW8xrk7A3hUPITT16KHhzy/F3TeWvC/YFBdPawqsvSc7Sp0E/KJurRuG9uLE
         4ZtQ5nBKhjuP5Jw8Q51h9SjkMo1fDInz6AIXvZy4KDS0FnpGt//s3KeW2jHaAdxw5OE2
         e0MIAIL8qrsKBD2+N6bjZKuljNOn3WfqNpbyXHVq/isr61aXxUf4TsxYyYqoyf562hPf
         XwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oO6Xe/LNqbGKuJJJLeHGIIY9nNJ4QCvJI77KwJY08mk=;
        b=JHjumnl2k8eMXcViNQciE4mN6Gt45qqAuMgd6o1fqvgnF3ROnxGJE888e1FeTCejV9
         5Rli1p/toOyYJMw/xubIT990XFBl6byJTx+2jncP7GvBzfCHSc2SEKD9Eg3JvLIRD77T
         k3IaiGnYfkp4DA7Q8u2+Y+F0jWjiWszMN4HyfUL+18wjIfvNYAvrxDP9sqlEs15jDrvZ
         lND/yePAQbxMCZYB135dM/2lHoTD20ODwfqrUSG5wQyz/U07R2upM9zJBfNSO4p24ZlH
         gVNdQBMA3zIwsqPm0t44y9xhKSFPnoQPKuU8OneAC/oe29mWd+THoS7smplicD10l6tA
         /fLw==
X-Gm-Message-State: AFqh2kquW9RRw+UNoVc2T4dzCrlPXk4AdOv1kI7lJ+g6MU6xvkzOH7Y4
        p0MneOSgUQHczmn9G3/Vgl7ibIUwhU5d88XRecFOXw==
X-Google-Smtp-Source: AMrXdXs8VGyuFeHyg+2k0NFHwQ6Mq5GSgXrH9LAtQRSYBeOulj1FCtu+zwxThlyrHNvSEyGBo52TkLH4K85RlNZ+69E=
X-Received: by 2002:a05:6102:3017:b0:3d2:30a3:70d1 with SMTP id
 s23-20020a056102301700b003d230a370d1mr393506vsa.38.1673670722868; Fri, 13 Jan
 2023 20:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20230114005408.never.756-kees@kernel.org>
In-Reply-To: <20230114005408.never.756-kees@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 Jan 2023 12:31:51 +0800
Message-ID: <CABVgOSkeCHF3Nrcd6eWQ=kFaaTo19+hStYdZg1ngQm7dGyBxHA@mail.gmail.com>
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into MEMCPY_SLOW_KUNIT_TEST
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Daniel Latypov <dlatypov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ece60c05f231d454"
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

--000000000000ece60c05f231d454
Content-Type: text/plain; charset="UTF-8"

On Sat, 14 Jan 2023 at 08:54, Kees Cook <keescook@chromium.org> wrote:
>
> Since the long memcpy tests may stall a system for tens of seconds
> in virtualized architecture environments, split those tests off under
> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: David Gow <davidgow@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Thanks: this is okay as-is, but I left a few suggestions below, having
tried it out a bit more.

Daniel's comment about kunit_skip() aborting the test is the only real
fix, but depending on how easy you'd want to make turning these tests
off, there are a couple of possible tweaks to the Kconfig option.

Cheers,
-- David

> v2: fix tristate to bool
> v1: https://lore.kernel.org/lkml/20230107040203.never.112-kees@kernel.org
> ---
>  lib/Kconfig.debug  |  9 +++++++++
>  lib/memcpy_kunit.c | 15 ++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index c2c78d0e761c..f90637171453 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>
>           If unsure, say N.
>
> +config MEMCPY_SLOW_KUNIT_TEST
> +       bool "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS

I think it'd be better to not include the "if !KUNIT_ALL_TESTS" here,
because it's very convenient to be able to use:
./tools/testing/kunit/kunit.py run memcpy --kconfig_add
CONFIG_MEMCPY_SLOW_KUNIT_TEST=n
to override it.

That does undermine the way KUNIT_ALL_TESTS works a bit, though it
depends if you want to consider this a new set of tests, or just an
option for the existing ones.

> +       depends on MEMCPY_KUNIT_TEST
> +       default KUNIT_ALL_TESTS

Does this default work for everyone? Personally, I think these tests
aren't slow enough that we'd want them disabled from an "all tests"
build by default. So I'd keep it as-is.

> +       help
> +         Some memcpy tests are quite exhaustive in checking for overlaps
> +         and bit ranges. These can be very slow, so they are split out
> +         as a separate config.
> +
>  config IS_SIGNED_TYPE_KUNIT_TEST
>         tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>         depends on KUNIT
> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> index 89128551448d..5a545e1b5dbb 100644
> --- a/lib/memcpy_kunit.c
> +++ b/lib/memcpy_kunit.c
> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>         }
>  }
>
> -static void init_large(struct kunit *test)
> +static int init_large(struct kunit *test)
>  {
> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> +               return -EBUSY;

As Daniel notes, it shouldn't be necessary to return here, as
kunit_skip() will abort the test. (It's a macro, so isn't marked
__noreturn itself, but kunit_try_catch_throw(), which it uses, is.)

> +       }
>
>         /* Get many bit patterns. */
>         get_random_bytes(large_src, ARRAY_SIZE(large_src));
> @@ -319,6 +323,8 @@ static void init_large(struct kunit *test)
>
>         /* Explicitly zero the entire destination. */
>         memset(large_dst, 0, ARRAY_SIZE(large_dst));
> +
> +       return 0;
>  }
>
>  /*
> @@ -327,7 +333,9 @@ static void init_large(struct kunit *test)
>   */
>  static void copy_large_test(struct kunit *test, bool use_memmove)
>  {
> -       init_large(test);
> +
> +       if (init_large(test))
> +               return;
>
>         /* Copy a growing number of non-overlapping bytes ... */
>         for (int bytes = 1; bytes <= ARRAY_SIZE(large_src); bytes++) {
> @@ -472,7 +480,8 @@ static void memmove_overlap_test(struct kunit *test)
>         static const int bytes_start = 1;
>         static const int bytes_end = ARRAY_SIZE(large_src) + 1;
>
> -       init_large(test);
> +       if (init_large(test))
> +               return;
>
>         /* Copy a growing number of overlapping bytes ... */
>         for (int bytes = bytes_start; bytes < bytes_end;
> --
> 2.34.1
>

--000000000000ece60c05f231d454
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA9
ihEeqqotVVu40PO9t2NN3L17bfyC8zL4LqQWPQaMEzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMTQwNDMyMDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAjje3qwbCtMMbW9f8vCj5
iKdyRLImUmjwZlueemApTHHxNOBfeFHmODKJKkWm5oLEjaUA/XlfYJg1owt26kQvIku+PylUtuLc
prpADKbwLeLDE5DeTbIWz3aUj1lo+Ol5s59eHaE7PazyHoxmXv/fqWpBmLvT6R/eD8pDkkrzRuEf
yrSyce/5IikcrtE1JApwcOso8mWQY9C3MGEwbvrw0zp6GROQ7Eaz90Od5iKx+p9C1CYMvpOavZpq
uipmJOyYFdjqlYimc2KdygB19I/ezZYF0VvGvIO4oilpEEgBrEOKO5AQ/Cq5PaCCUHdXjFcfoC/4
O857bIrhrkKWtNnplA==
--000000000000ece60c05f231d454--
