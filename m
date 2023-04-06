Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08A06DA17F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDFTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjDFTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:36:09 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD57AA6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:36:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sg7so3938274ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680809766; x=1683401766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cfBu7ny4boS9Y/7qj052s9pihxiH3sSFTHbJOJ58P+A=;
        b=Twlx/bP6m2jy2fZonvmqk4nFEHpd1/ykkoIVh2l143Ux0L+oKc4kWlPpsaaZodPA2J
         zAYrdKpQ34FVVvCh0Lm4vKu6s2BejMK8CdBoCkTWzUmE/LxXTutJ44EtLlSSnJJ931W2
         eBhoP2mTglWndlfd/RYDH6tzg9cP/68TA9P08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809766; x=1683401766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfBu7ny4boS9Y/7qj052s9pihxiH3sSFTHbJOJ58P+A=;
        b=aExCdmjeSMKfHYPzRVfr7AkJRKJvNJ0w0isDd45JP+ooRYW8zvbHi9XD0gjg7HX3j5
         MKlFhLbpLQdHWZ9rDeROOuB5y0gr46OcvVKUAKCbCaB7jq6gahEwPYSY7t+35Maen5Q9
         GIHAnUU+NidY0ODa36Vs/4CypFwOU8Fe9wscfrWGr5h1wlfIYQXow4iGdzoHCtgYUVcb
         HeUrLAl+7lhFOShtD6wNVwgd5PfVaSL+VmyxVbI2LVTqfJWkS6eWlFT6sovoVO5OSlJF
         anhYsTSuFuoiSv5D3lhFx0iucOf8Z8VF1lAInO25CkYCkzV7g+4VV1WptF0h19R3ujB+
         /KkA==
X-Gm-Message-State: AAQBX9cuPFNcCpW6TPrUhebZLC0mUKowAiG+7GD8WfRoEUsrFLJzDCr8
        0XqS5G4rPYsHGg3kWT13YJ6YTBf/Rjy4kn9PyD8Hp6H8
X-Google-Smtp-Source: AKy350YNd/GIqdXWGkFzj0TW54XEa4Pl60LyfdhDlgym8vGx3HmkfmRqKWDmUuMp/jO9drt5LlczBQ==
X-Received: by 2002:a17:906:4a8b:b0:944:43e:7983 with SMTP id x11-20020a1709064a8b00b00944043e7983mr8295597eju.67.1680809766338;
        Thu, 06 Apr 2023 12:36:06 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ht16-20020a170907609000b00931db712768sm1183239ejc.4.2023.04.06.12.36.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:36:05 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id sg7so3938136ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:36:05 -0700 (PDT)
X-Received: by 2002:a17:906:e41:b0:933:1967:a984 with SMTP id
 q1-20020a1709060e4100b009331967a984mr3762785eji.15.1680809765017; Thu, 06 Apr
 2023 12:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
In-Reply-To: <caca6879210940428e0aa2a1496907ab@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Apr 2023 12:35:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
Message-ID: <CAHk-=whd4w2wu13O9b5VRKE1b3MoUk89Q_WzhELyqXGAKmfqmQ@mail.gmail.com>
Subject: Re: revert bab65e48cb064 PCI/MSI Sanitize MSI-X checks
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: multipart/mixed; boundary="000000000000faf1ae05f8b004fe"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000faf1ae05f8b004fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 6, 2023 at 4:05=E2=80=AFAM David Laight <David.Laight@aculab.co=
m> wrote:
>
> So code like:
>         for (i =3D 0; i < 16; i++)
>                 msix_tbl[i].entry =3D i;
>         nvec =3D pci_enable_msix_range(dev, msix_tbl, 1, 16);
> Now returns -22 if the hardware only supports 8 interrupts.
>
> Previously it returned 8.

Does just moving the pci_msix_validate_entries() down to below the
hwsize update code fix it?

IOW, something like this attached patch?

ENTIRELY UNTESTED! This may be seriously broken for some reason, but
it does seem like the current code makes no sense (that "Keep the IRQ
virtual hackery working" comment seems to not possibly be true since
the MSIX nvec has effectively been checked against hwsize by the
pci_msix_validate_entries() code before).

I don't know this code. Thomas?

                     Linus

--000000000000faf1ae05f8b004fe
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lg5iq4dx0>
X-Attachment-Id: f_lg5iq4dx0

IGRyaXZlcnMvcGNpL21zaS9tc2kuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL21zaS9t
c2kuYyBiL2RyaXZlcnMvcGNpL21zaS9tc2kuYwppbmRleCAxZjcxNjYyNGNhNTYuLjhlZGM3YmVl
YmY2ZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvbXNpL21zaS5jCisrKyBiL2RyaXZlcnMvcGNp
L21zaS9tc2kuYwpAQCAtODA1LDkgKzgwNSw2IEBAIGludCBfX3BjaV9lbmFibGVfbXNpeF9yYW5n
ZShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBzdHJ1Y3QgbXNpeF9lbnRyeSAqZW50cmllcywgaW50CiAJ
aWYgKGh3c2l6ZSA8IDApCiAJCXJldHVybiBod3NpemU7CiAKLQlpZiAoIXBjaV9tc2l4X3ZhbGlk
YXRlX2VudHJpZXMoZGV2LCBlbnRyaWVzLCBudmVjLCBod3NpemUpKQotCQlyZXR1cm4gLUVJTlZB
TDsKLQogCWlmIChod3NpemUgPCBudmVjKSB7CiAJCS8qIEtlZXAgdGhlIElSUSB2aXJ0dWFsIGhh
Y2tlcnkgd29ya2luZyAqLwogCQlpZiAoZmxhZ3MgJiBQQ0lfSVJRX1ZJUlRVQUwpCkBAIC04MTks
NiArODE2LDkgQEAgaW50IF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKHN0cnVjdCBwY2lfZGV2ICpk
ZXYsIHN0cnVjdCBtc2l4X2VudHJ5ICplbnRyaWVzLCBpbnQKIAlpZiAobnZlYyA8IG1pbnZlYykK
IAkJcmV0dXJuIC1FTk9TUEM7CiAKKwlpZiAoIXBjaV9tc2l4X3ZhbGlkYXRlX2VudHJpZXMoZGV2
LCBlbnRyaWVzLCBudmVjLCBod3NpemUpKQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCXJjID0gcGNp
X3NldHVwX21zaV9jb250ZXh0KGRldik7CiAJaWYgKHJjKQogCQlyZXR1cm4gcmM7Cg==
--000000000000faf1ae05f8b004fe--
