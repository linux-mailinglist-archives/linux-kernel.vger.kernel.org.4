Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA15607144
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJUHi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJUHiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:38:15 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED25F248CA5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:38:12 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id p4so2087350uao.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2BFkwaDejBBSomy84F88CH9UEh0T/riuEx6sXGK34s=;
        b=hR2udoLwTlh2mYlAtw+23AYzzjWnNevCUbfaUToL7c1xZBBIyYyFgnfl7qc1b50Z1h
         kKC6/a6qoyElAldKJeWkMGtu2eIDPCwdiGVXloot3/yghRv03byFOOzFWnUWbJrXqZSl
         up70h80ZEaeExvo4pTPiQgRHftH+aGXByTZPbvDQl/tK7snWf9IEwxs6Yip1JpCpw3Kl
         FwxG85NppRmQ2xbR7YDVZf0y80XNmmeNJJhOoLNN+fcPNShAOjCfUxyoXlZuzxKticSe
         ZGDzHZsgySOqUfe4JCiKvfHVVmZJskT+vSfBIaXDwOClm8tVBM7cvtPJj6JCobGrlNDn
         D2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2BFkwaDejBBSomy84F88CH9UEh0T/riuEx6sXGK34s=;
        b=P22pkSNAbn104kVr0OBfTpSQPnpcMdoVxzbdf+c+2ELGs87fdgQZ6ynREuVrWkBW0k
         RmWdON8ZcI2gJPLwHZkdRKYQrxqnzyapimmnGS3Wl75aC444ViRKQFCuUIKs0UcgMvRL
         8LSFF2ZULVHYB30QBoeAhjRDlpkUFc2t1PVbaO2OgnmAyEGn7EOnCVCgXE3r1hAUZ6sa
         zK8jiSUd/HeHepZDCQQBILXhP94SE8CfxaoWrZa0o0W18SO+b9fwsRO6iSzYq0akpZ9X
         8vk1+FGC9ILRbmBOe/Dng4Zd3ax+qYU9VGX+4pJwO1q5Qj4uKa1k/ddW3v/sRZQiaG9I
         RJ+g==
X-Gm-Message-State: ACrzQf2lkO/WTTJ31n4F6wr5TFYjz19WGbQl9l+LEbVJxVH0HK7/mihN
        aQj8lyBpw3xhNreRIjjmij5Ze1EwWMXV21zd0ePnfBCN/+g=
X-Google-Smtp-Source: AMsMyM7HHuen4PWY3jxXVJtXYjBTCoZ9T+nYLlemsYegq6drh05omW1aEcJ7CpmnLgg8cK73IWyaoQSAderLj2KUw0U=
X-Received: by 2002:ab0:39c1:0:b0:3ef:dcae:f17 with SMTP id
 g1-20020ab039c1000000b003efdcae0f17mr8269175uaw.26.1666337891404; Fri, 21 Oct
 2022 00:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221019073239.3779180-1-davidgow@google.com> <20221019172919.GA5336@elementary>
 <5639218e-bcc8-55b0-ea30-7bf2b26c92b9@redhat.com>
In-Reply-To: <5639218e-bcc8-55b0-ea30-7bf2b26c92b9@redhat.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Oct 2022 15:37:59 +0800
Message-ID: <CABVgOSkbqRtUTmL83HU6Nf0kp9KmrL6ZpRL2F3VDtSDEQq1DCA@mail.gmail.com>
Subject: Re: [PATCH] drm: tests: Fix a buffer overflow in format_helper_test
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001c0de205eb86862a"
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

--0000000000001c0de205eb86862a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 4:03 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 10/19/22 19:29, Jos=C3=A9 Exp=C3=B3sito wrote:
>
> [...]
>
> >>  drivers/gpu/drm/tests/drm_format_helper_test.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/=
gpu/drm/tests/drm_format_helper_test.c
> >> index 8d86c250c2ec..2191e57f2297 100644
> >> --- a/drivers/gpu/drm/tests/drm_format_helper_test.c
> >> +++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
> >> @@ -438,7 +438,7 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(st=
ruct kunit *test)
> >>      iosys_map_set_vaddr(&src, xrgb8888);
> >>
> >>      drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &f=
b, &params->clip);
> >> -    buf =3D le32buf_to_cpu(test, buf, TEST_BUF_SIZE);
> >> +    buf =3D le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
> >>      KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0)=
;
> >>  }
> >
> > Thanks a lot for fixing this bug David, I just tested it and
> > worked as expected.
> >
>
> I've pushed this to drm-misc (drm-misc-fixes) now. Thanks!
>

Thanks very much!

> > Do you think that we should update the other calls to
> > le32buf_to_cpu() to follow a similar approach?
> >
>
> Feel free to post follow-up patches if you think that other changes are n=
eeded.
>

I _think_ this should be the only actually necessary change. Maybe
there's some cleanup of the way TEST_BUF_SIZE is used, or the sparse
annotations for endianness, but I'd need to look into exactly what the
various drm_format definitions are in more detail to know for sure.

Cheers,
-- David

--0000000000001c0de205eb86862a
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC2
ebUzVmIQ//JkjEGV+eb2jr2zMFLB8jGNyKXTXDg25jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjEwMjEwNzM4MTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAfPvz0hgtrZtFJm1gDccm
LeVuLS63Jc1txkKOYwcdeXxMpY51wNEeT2e1ipiJ+L/mbkTbtXuuQKUK3Zpsb0StcTYXJ0RNe7t4
1mbSTLqP55onei5a0YYCuKT8PhTkCyzOWCDpDIOZetvyZoqPTEmSRL2jJ+E1s0bJjM1/HmCnrocG
JsA+Xe3wfd7kFbhGOBwuUWxrm5qqo3aJjZzkEEAVWW+5tkffFhP7b5KNs3zsnE+l0aiq7dCV4yM1
Q/0EKbLo5LE2zgi30SFAVQwJTnheL0Cznz77VWJfK5dGoUtuKT7PNtriPXbKlVZj8l3TCdAzyTnV
OGYAUWOVnqxl0NkHCA==
--0000000000001c0de205eb86862a--
