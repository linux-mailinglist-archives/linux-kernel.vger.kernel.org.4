Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3007A5F4C8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJDXPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJDXPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:15:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598024BE4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:15:33 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id gb14so9084900qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wyZAXk4Acu6MKbPAGBakwgaYKNvJf0AvG+8lI+uqUjQ=;
        b=Xh6G67WSCodsfjgLeCRwkGJe9pEn8IVd7x7klEO4qsj+BRwtCNPJiLip22OBp/yp0M
         f3xRki8J2XTq2y/vBksr1ITD7BFsoJJOXyYlxHnR4QLw/RyMf2NcEyowxqh/hpyCiCYV
         DTmnQ7LlMRcleRnIFJUBRDQMMVqlaLBE0/Q3ADIbJdKxGZWIm2wqo6TI4SvP8dk0TRU/
         9y3bVl9MjDJv+3yoDV+qXGWcc39tRCzt0tm56w0CYWlKmChWU/cejppWSVQWhlUzjVfI
         /wTl3GfgdaEFImHL76zy786C9pk2fbX6VhVqfCdi//AsMmxAwaWojMdPDp8dnA+47Tyn
         XURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wyZAXk4Acu6MKbPAGBakwgaYKNvJf0AvG+8lI+uqUjQ=;
        b=2MhhXuivshxR++F9sdKZCn5j7De87NdOASjP5fLi48oT5x47jEh2vxZyy+SHLwIRMo
         M27YZzXoKzkYbHikqKYe2MxFyyW4h8/Huh7lCtRcx1qIasu30iubWtH1VxUzkrKz4PmR
         n9sDfllLo7oXFbS89S24S0vYyvHf8D3XsGXBNdd35CitnjLjlJ5VoS4UHSeWWJ08b7E0
         6nP3jPxNdKtbjC7UCBeKgFMe2gEEh+we/QuXU0JG18v3W0G1LLcYQIdnmUE2ITgRrUPz
         Jm11VRmDeveFYYrap29PNPG3cdLiqO+H41TqPSvQvRkAma+7jA2FmdKBSSam1+iEuTO8
         e3qw==
X-Gm-Message-State: ACrzQf24KF11RKBSS0+eHAiQv+7Sa18eMy62vC8GtbbFm2ag+3rczknn
        IqEjtxRwCfAppO8jDeK5bgywz0E+RmG+s1KUKWnC1iIGH4RCUA==
X-Google-Smtp-Source: AMsMyM5uZp8szIDIOW7vVtvUf41eLzZ3T62MvWVnmhjE5dbRJayK9uGjUpvsW10Q4Ks+0PxQwG9K+FNsRp+c0ZiCoOM=
X-Received: by 2002:a05:622a:47:b0:35d:4c69:553c with SMTP id
 y7-20020a05622a004700b0035d4c69553cmr21394507qtw.58.1664925332598; Tue, 04
 Oct 2022 16:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com> <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com>
In-Reply-To: <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Tue, 4 Oct 2022 16:15:20 -0700
Message-ID: <CACGdZYKvTLd0g2yBuFX+++XeSa6aapuAwOM7e63zhKgdKFEGEw@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000c713b05ea3da3f6"
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

--0000000000000c713b05ea3da3f6
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 4, 2022 at 3:40 PM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 10/5/22 03:33, Khazhy Kumykov wrote:
> > On Mon, Oct 3, 2022 at 11:12 PM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> This will allow a configuration to specify bfq or kyber for all single queue
> >> devices
> > That's the idea
> >> , which include SMR HDDs. Since these can only use mq-deadline (or none
> >> if the user like living dangerously), this default config-based solution is not
> >> OK in my opinion.
> > I don't think this is true - elevator_init_mq will call
> > elevator_get_by_features, not elevator_get_default for SMR hdds (and
> > other zoned devices), as it sets required_elevator_features.
>
> OK, but my point remains: why not use a udev rule ? Why add a config
> option to hardcode the default scheduler ? Most average users will have no
> idea which one to choose...
The kernel already picks and hardcodes a default scheduler, my
thinking is: why not let folks choose? This was allowed in the old
block layer since 2005.

My first thought was it'd be handy to have the kernel just start up
with the scheduler we wanted, rather than rely on userspace to listen
to an event to fix it.
But, some userspaces do not run a udev daemon (e.g. linuxboot, to my
recollection, others), so would need to stand one up, just for this.

Khazhy
>
> >>
> >> What is wrong with using a udev rule to set the default disk scheduler ? Most
> >> distros do that already anyway, so this config may not even be that useful in
> >> practice. What is the use case here ?
> >>
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
> >>
>
> --
> Damien Le Moal
> Western Digital Research
>

--0000000000000c713b05ea3da3f6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
/UbIw5ZqDzSZD+QwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAB2kM/dnvjLFQgOANm3u
6O2eeA2ns7z1bKAKieQOHylg6/QUVNni+2SneSjNFOL7zKYDtBMHUKgO3rKBJX/dJfvoR//2kO08
EJwmyX+bLsQT2TTkPa28tJsYOcW1ikfdH3YyiHExVlUrFFtpiEmAr1eGd2HceTBvTQJkhhkb+ulg
D5rKnhTMXtEOuP5gUf59gIwubIpqkpQTG/Ez2eBtlicznw3LBOKZ2msT+vdDFjQXrWBxPpdL3ll0
WdLiqC7rbo0uCQeFdhI4gi0CyUNeGXEjN0/qngDOR5RPl++zdVLTFOV0kf31NijoQZquscGXyUZ1
/IYjtCWWtKbMqFk6gmMxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAE31I/NNZSyeJ7AJhcbSqgwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDJ+D4BO
8PKdzWWPJeJDX47lrQdqlIDCgJRrkTZw74dsMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMTAwNDIzMTUzMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCCOR9aGg/NqKzCjMov4btgCkm3
Gn/KajhyWWM7EPaDRVfU1+CI3LaVxLoPGwzjg42zm4PvDwrb+Bhbnnlkr2oaiPGmAcTML2sr7eE4
ay5sI0MilCV5S51aSLSaciuPzeG8FpAzV6/8YFU17ete6uJ/ghN/CHumL2m1jIyaCNSQ/+ssdt18
Wo45r97wKTFpD2lIpaBrr2KiVq2PMdXmFlrETs6pTJtGs9hFVrj7E1a3goIQ6kbTwG8gIOfSPUHR
t0mg262y0KDuCekod7WJ22Qtw7KZiGj3guCIFB5q+Ay9dflIxgoXSQEGeRlVniNdqWrvHIPkLjif
ZdAIJvMkzzt7
--0000000000000c713b05ea3da3f6--
