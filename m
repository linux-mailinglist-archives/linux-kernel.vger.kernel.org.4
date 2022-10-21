Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D061607155
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJUHoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJUHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:43:57 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CF247E11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:43:55 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id a2so413338vsc.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jZeV2XvG8OTFaeamp7Oz+7QHULpnGkgDcIka2+N+Fhw=;
        b=E40si7tOXBKq+RUObyxs/WNUmLOnlwRgbC0Y8H+doCnSlyI9F+gcGM63gmzMktqOEj
         2NruFWcCNJQi8oHxVuk+yfi0pBJB2pEhdQt81c0WShz32WtOFsBfyO6muOQL1uwvU9X3
         CyrrkT1p84MZ0Xg97Xa73kSfPb6zY4pyW5liyrg2vI/7K7JlAC9p9wcmqpnlTqtcs/b0
         IVtKRAcj9hFQDCVRcwHBHMyuU19OSTb3XuIQ3fCtGb5IrKhid5doBoWp/CcoDZnKEFM2
         5DEsNYdN01q8huf9KMcKN4HrourQmR1dRS+BTL+/wXYQWTde7kJ+rwv8BD7QN6n7rrhh
         T4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZeV2XvG8OTFaeamp7Oz+7QHULpnGkgDcIka2+N+Fhw=;
        b=NgowwkWKtH4rIfTFglmoJ6+y9tq3lGBvwj8IKLUd7DLc6UIuoR6sDHJ0M2QjkAfAxH
         ZbPeH190pSPt9cK9S9y1OriYkPqegAxP8eeEs4rXoJJQ/Cmxb2tKx2YUJAAwW1UX2bBq
         3G9LU0PhrR6DuvTjR6v+BwITfGsOZNOOx/wm8QweUMxfCszQqT8WWlMh33GYTywTc0JR
         iZj0lsqCa/Cr9s00Hm8akuchnMgwIaR0eOTV00u3ylXX9Zy61HOcO76MQw02T34o1iqq
         cNPYMbBsYZd7blcW73FQZmL7UMBH+x+zc+7wqJw3IXS1zHCUel8Wg858N5WyiO6sXwG2
         Wx+g==
X-Gm-Message-State: ACrzQf2t7GJos28pBmakYdoPaa6hyCaZAZgHB3+RfMkO61kWdNC24SOF
        xpa/HUUpqV9tTvX89I31YU/dIkQN2UMrJ5tw1h108Q==
X-Google-Smtp-Source: AMsMyM7c8roYAv0bhhxIs3sWSkrTq2ikats76AE8z4czFMuHVqVA/dTDJUCR+VsHC8FnsuEW8CIdAOWS6ES0bouXlnk=
X-Received: by 2002:a05:6102:284a:b0:3a7:ce5:ca83 with SMTP id
 az10-20020a056102284a00b003a70ce5ca83mr11171350vsb.38.1666338234284; Fri, 21
 Oct 2022 00:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221019073239.3779180-1-davidgow@google.com> <6bb18060-158a-a2e7-3382-5d42813fe247@riseup.net>
In-Reply-To: <6bb18060-158a-a2e7-3382-5d42813fe247@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Oct 2022 15:43:42 +0800
Message-ID: <CABVgOSn7cg962HLARiGfOT0tLzra91tESrw1dVk6XK2Y8ZsV5Q@mail.gmail.com>
Subject: Re: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>, kunit-dev@googlegroups.com,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008b7cf805eb869aa1"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008b7cf805eb869aa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 7:36 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> [cc Javier]
>
> Hi David,
>
> On 10/19/22 04:32, David Gow wrote:
> > The xrgb2101010 format conversion test (unlike for other formats) does
> > an endianness conversion on the results. However, it always converts
> > TEST_BUF_SIZE 32-bit integers, which results in reading from (and
> > writing to) more memory than in present in the result buffer. Instead,
> > use the buffer size, divided by sizeof(u32).
> >
> > The issue could be reproduced with KASAN:
> > ./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/tests =
\
> >       --kconfig_add CONFIG_KASAN=3Dy --kconfig_add CONFIG_KASAN_VMALLOC=
=3Dy \
> >       --kconfig_add CONFIG_KASAN_KUNIT_TEST=3Dy \
> >       drm_format_helper_test.*xrgb2101010
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Fixes: 453114319699 ("drm/format-helper: Add KUnit tests for drm_fb_xrg=
b8888_to_xrgb2101010()")
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
>

Thanks a lot, Ma=C3=ADra!

> > ---
> >
> > This is a fix for the issue reported here:
> > https://lore.kernel.org/dri-devel/CA+G9fYsuc9G+RO81E=3DvHMqxYStsmLURLdO=
B0NF26kJ1=3DK8pRZA@mail.gmail.com/
> >
> > Note that it may conflict with the KUNIT_EXPECT_MEMEQ() series here:
> > https://lore.kernel.org/linux-kselftest/20221018190541.189780-1-mairaca=
nal@riseup.net/
>
> I believe this patch will go to the drm-misc-fixes tree, so I can rebase
> the series (and address the format issues) as this patch hits mainline.

We're probably going to want the KUNIT_EXPECT_MEMEQ() merged in the
kselftest/kunit tree reasonably soon, as there's a few things we'd
like to use it for that we're hoping to get into 6.2.

Given that any conflict is only likely to affect context lines, it
hopefully won't be too much of a problem to resolve it when everything
gets merged, though.

Cheers,
-- David

--0000000000008b7cf805eb869aa1
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDe
6Pyffl9m8tbUT0KX8FWAQfRUJq8yxZIWnOsHKuv+vzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMjEwNzQzNTRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAGU1/ZMSFPcmaG/Dqyss/
EXFCzK980mpRuBfmu8UiKRorkwDkMSdjtT6JVQID2jc30tkHros+T5XANm6nqhKCQ7x4g/f8tvYf
oxgHGkGx/SqQqcRHoK5nixj1zF0WITsy2RSfamy9r4VYVb9SIGrcDecE0eGQb/eUqTYxp/6QhfE5
QFHOd/7tiEhZskQ+HO5qec2YAAWB/huXHH65GJoV1fhwJkpofyjOoCXucTnxFSmTC7vy6CqpsmQN
szmtknxvVKujKZJTUkHHHVeWj+NhtNxXo6pXy5q9puWOc5uf0hMA1Z+fu0lrpz6BNZIzg97uiA96
N5BFeQ3+DJMyOFNEqQ==
--0000000000008b7cf805eb869aa1--
