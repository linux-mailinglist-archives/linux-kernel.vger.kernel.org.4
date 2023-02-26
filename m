Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920D06A2CEC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 02:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBZBLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 20:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBZBLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 20:11:38 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED1C671
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:11:36 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id f13so5610719vsg.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 17:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9RFZ7AWt4X2lrI5xhdLQ/HTqb8VHpflL4SruE6foLkY=;
        b=lEIe2g7PaVP/GmG7rynzYTb+aEGbZu6LXRW2Ho3rm6CV+r79icUuxNUYA1A/iOLoVk
         17EO3H3CDwvya/qSqkzR40iMf0HwDf8lMytmDTUKuirtALANZnXaMPFtYoPPva9Nzreu
         Sr4HX7zvpIeXcToAEltUXc+hZ5LTZv6BrgC/WOvWvy/8JdtAKSS6Ra9NYOFFEaZb5VvT
         ZSxtqzoWNvkKHmJM3JPcdPzJP0peAbktZvEZcjBLpq4/KqxoOmPqh8PsJaGN2uA+Lodw
         nHsyBkZ4f5LaT8jTL/volkDFFQrXM3Pdj90RdL43XuR6uFlOuDp4aGzOibJwNT1gvXy4
         edVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RFZ7AWt4X2lrI5xhdLQ/HTqb8VHpflL4SruE6foLkY=;
        b=x//v05YtRW5jQuERwBapG04KbpeWBqF1GLOPG2SJgwDiXw+b9cP0899YSkVCAXsbVy
         puOYqoGKTEO0ZP+C1si0vKaPQJWATeli7B+z7Wg1Hjk0fq30d6v3h8NwmPHh2j5I+Xql
         DRDrUuFvYpAK3mABkRk0BvsyKU1yPmUnEB2N0Z8HX2ROAvDFskxnIDwN+halquOG+YWm
         cAJG/fBuomlWh044DfAoJGYbJYApEPWiD882C+loRPH3DQQ5ltnP8jQE2d/jREg9riXN
         yMtYMZymek5geiKQy8X+U3B6+1+4B4nOzqbLJZhM3151SbyJwpU99aWgKMJ/+6izJR1P
         kSaw==
X-Gm-Message-State: AO0yUKUzs+pBKk8E9FuQEs0VQFrhY0hkr1SEMKeuYoenRh3203k3uJXH
        C2CnjIrjpj1VbouYtZ+goZOu7Xp8/FhMfL5vsFyGtg==
X-Google-Smtp-Source: AK7set8gfDEGYUkFKjm7qFEk5GBdkDmBsmBomEh5CU9ofdegKezl2/MITT4ZdTT26fpyC6xR4Dd3+MOoXm1/tjFpf8M=
X-Received: by 2002:a1f:4343:0:b0:400:ea69:7082 with SMTP id
 q64-20020a1f4343000000b00400ea697082mr4973937vka.0.1677373895820; Sat, 25 Feb
 2023 17:11:35 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
 <9f682c4d-e7b7-5e23-84f5-cea4fdac2085@leemhuis.info> <CABXGCsNruNKfx3d1dpneRUvn3dCqv_bM93TdJsCLeRYiP3qYaA@mail.gmail.com>
 <6bfa6d67-27ce-04b3-a1f9-3768b8a0169f@leemhuis.info>
In-Reply-To: <6bfa6d67-27ce-04b3-a1f9-3768b8a0169f@leemhuis.info>
From:   David Gow <davidgow@google.com>
Date:   Sun, 26 Feb 2023 09:11:23 +0800
Message-ID: <CABVgOSnCLbqHHA-gT6FwtJYKYAHt_9uwR_S2r6ZE8hm6eZaLBA@mail.gmail.com>
Subject: Re: [6.3][regression] after commit 7170b7ed6acbde523c5d362c8978c60df4c30f30
 my system stuck in initramfs forever
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, rmoar@google.com,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003c1f7705f5900b1c"
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

--0000000000003c1f7705f5900b1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 25 Feb 2023 at 23:53, Thorsten Leemhuis <linux@leemhuis.info> wrote=
:
>
> On 25.02.23 15:55, Mikhail Gavrilov wrote:
> > On Sat, Feb 25, 2023 at 7:22=E2=80=AFPM Thorsten Leemhuis <linux@leemhu=
is.info> wrote:
> >>
> >> [CCing the regression list, as it should be in the loop for regression=
s:
> >> https://docs.kernel.org/admin-guide/reporting-regressions.html]
> >>
> >> On 25.02.23 14:51, Mikhail Gavrilov wrote:
> >>> new kernel release cycle returning with new bugs
> >>> Today my system got stuck in initramfs environment after updating to
> >>> commit d2980d8d826554fa6981d621e569a453787472f8.
> >>>
> >>> I still do not understand how to configure the network inside the
> >>> initramfs environment to grab the logs.
> >>> Since an attempt to rebuild the initramfs with all modules (dracut
> >>> --no-hostonly --force) leads to the stuck initramfs environment and
> >>> impossible entering into initramfs console.
> >>
> >> Do you see any error messages? I have problems since Friday morning as
> >> well (stuck in Fedora's initramfs) and see a lot of BPF warnings like
> >> "BPF: invalid name" and "failed to validate module". Was able to do a
> >> screenshot:
> >>
> >> https://www.leemhuis.info/files/misc/Screenshot_ktst-f36-x86-64_2023-0=
2-24_07:53:14.png
> >
> > I also seen such messages
> > https://freeimage.host/i/img-1475.HMPL26l
>
> Pretty sure that's the same problem, at least the symptoms match. If
> anyone needs a config to reproduce this, here's one of mine that shows
> the problem:
>
> https://www.leemhuis.info/files/misc/config
>
> > P.S.: I also use Fedora Rawhide.
>
> Happens for me on all Fedora 36, 37, and 38 (my rawhide build failed for
> other reasons, so I couldn't test).
>
> Ciao, Thorsten

Thanks for the report, and sorry this seems to have broken.

I've not been able to reproduce this locally yet, but I'm looking into it.

In the meantime, a few questions if you have time:
- Does this happen with CONFIG_KUNIT=3Dy as well as CONFIG_KUNIT=3Dm?
- Does this patch fix it?
https://lore.kernel.org/linux-kselftest/20230225014529.2259752-1-davidgow@g=
oogle.com/T/#u

I can't think of any particular reason this commit would cause these
problems, but there were some issues with the way these 'hooks' were
built, so it's possibly related.

Sorry again for the inconvenience!

Cheers,
-- David

--0000000000003c1f7705f5900b1c
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDQ
3aalqUbG+39zrnaDH2VwfOpzCFFJmKes+jVFif8aGjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAyMjYwMTExMzZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEADRFftbwkR7WRok5V4vi1
+/bGrTAxaPe66uQecVpmXER2nS5d6MP/VZ6A1hts/ojQ5iZwLchaaqOHEA/JY2O1Vi4I2Hsr/k2+
DBWMa31W56t1Y+/A3efCFf9gpqC2lUIh0XrjRO0V0Fd2GiEnO7sapRM7MhiHq7pMM9XDRadxZLX+
szsJBj7DRGA+RNlWGkanNutT1jmO0Kzl2K10hE4Nh8hHFC1Y0r3LscevU6jV5hB5b04bOR0a+2rh
ezoO9CUUeDZeursm7Uh4FefmCnl6U+aCYJw80IrNW0z6I15Hzsj/e3n39VJrIiuwAEfNZcF+QpF7
A8qsbaCga1dm54lduw==
--0000000000003c1f7705f5900b1c--
