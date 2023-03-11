Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148BD6B6196
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 23:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCKW4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 17:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCKW4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 17:56:18 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5937059811;
        Sat, 11 Mar 2023 14:56:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so8184639wrw.2;
        Sat, 11 Mar 2023 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678575376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRJm994bLxnOpAp+E4u5XM0Yn52ttuGkoeVqmWeZf60=;
        b=OcMAdo4fhR3HXLrDBbxbeWQeJBDZMdhMxQSgOf7/Jr+CDqw5Tng8vnYs7/RAxxyKXj
         pdCIJ76ms1rWp1fT6+l4oKNrROQhuJgIUWFi1xrt0V3FHkb5og2TpH8AIlkC5EFeD/ci
         9nUIxzHh3w8xiRvUX0GXt+veKQti7ijt1pha/nCLY3yA0joG62yMjVy0AQgbSrclezaO
         R9DRr2BP7bWYwjIwePFLBfYuIv9TYuXWQr+NnvjV2E09mK7++T+8SLUfIbRWOtQDcYbL
         e8SM0sCMjENDBseY5x0F4BG6/aL630Eohvy63sUxn64MTTKIQ/hK1kniF/gBgha1hERQ
         YNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678575376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRJm994bLxnOpAp+E4u5XM0Yn52ttuGkoeVqmWeZf60=;
        b=QRDCvUwbDTXyjT71qYMHwfNRdeBkRwLxF0uILip9o62Z36c3YJjG9sHDB3Nh3Qlm1S
         FT2VAix6Wn3hcG0JVPYfUTbaOkCZTcmyakhkd0D4qhp4g/BrDdpdCvtJU85L+8UpppVU
         Nr+4Bl1C0pWefZwmYrnEFJjarBkQXvA1HEtvf4Vg8kcTWEbkll4vej+AAP678zxn5PM0
         /gtOMP6rC1oVZi0tlL63niEGmype4hQAZUuL8Q7ThNCTlWa7jjxU5+iie5r3JdfOGlts
         0UX3j2tQvPfOrb9om+duwRDuDC5gfZbTggChsrzYJ0/cM6COP1g5QKJy1mM9g4oNg1ej
         jSaw==
X-Gm-Message-State: AO0yUKVNJR4V2zRvuTTQ2K/qjqVZSiBR+1F77PCsDg3jKnnQuod2zDZ4
        RxA4lvVfgkiSNpy8yTX2r5bL1mnwdhXHHPFTE2RdYPnJM6flYw==
X-Google-Smtp-Source: AK7set/SCcEDI2KJ4hEFObvnslfkf0macT3DAmUw1XPG0uSBoI5v5eIdyuiRt7RbnTZ7g66lkjinYdkohhIh+oLU7HA=
X-Received: by 2002:a5d:6a48:0:b0:2c3:f972:cef with SMTP id
 t8-20020a5d6a48000000b002c3f9720cefmr1257495wrw.0.1678575375619; Sat, 11 Mar
 2023 14:56:15 -0800 (PST)
MIME-Version: 1.0
References: <ef2c926cf7b148028f1902279cb35a41@intre.it> <906901ED-DAE3-4A36-A3E4-16DF6F251C48@kernel.org>
 <c2d598d5a11d4a29815a4eca63606159@intre.it>
In-Reply-To: <c2d598d5a11d4a29815a4eca63606159@intre.it>
From:   Jere Viikari <jere.viikari@gmail.com>
Date:   Sun, 12 Mar 2023 00:56:04 +0200
Message-ID: <CALDd4YW6_Vw=VHaxzZiLjhr9w+tqbVmCaXKGiUFMeKbWxkiRxg@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce per-interrupt kernel-stack randomization
To:     Ornaghi Davide <davide.ornaghi@intre.it>
Cc:     Kees Cook <kees@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "nsaenzju@redhat.com" <nsaenzju@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am concerned about the disclaimer. When I replied, I had also to
remove all other information to ensure that I did not violate the
terms.

> Nota informativa: In ottemperanza della Legge 196/2003 e al Regolamento U=
E 679/2016 (GDPR) sulla tutela dei dati personali, le informazioni contenut=
e in questo messaggio sono strettamente riservate e sono esclusivamente ind=
irizzate al destinatario indicato (oppure alla persona responsabile di rime=
tterlo al destinatario). Le idee e opinioni espresse sono quelle dell=E2=80=
=99autore e, a meno che non sia chiaramente scritto, non rappresentano nece=
ssariamente quelle di Intr=C3=A9 S.r.l. Qualsiasi uso, riproduzione o divul=
gazione di questo messaggio e' vietata, anche ai sensi dell=E2=80=99art. 61=
6 c.p. italiano. Nel caso in cui aveste ricevuto questa e-mail per errore, =
vogliate avvertirci al piu' presto a mezzo posta elettronica all=E2=80=99in=
dirizzo privacy@intre.it e distruggere il presente messaggio.
> Please note: In reference to Italian law 196/2003 and to the Regulation E=
U 679/2016 (GDPR), this email transmission including its attachments, is in=
tended only for the person or entity to which it is addressed and may conta=
in confidential and/or privileged material. Any views or opinions are solel=
y those of the author and do not necessarily represent those of Intr=C3=A9 =
S.r.l., unless specifically stated. Any review, retransmission, disseminati=
on or other use of, or taking of any action in reliance upon, this informat=
ion by persons or entities other than the intended recipient is prohibited.=
 If you received this email due to an error, please contact the sender via =
e-mail to the address privacy@intre.it and delete the email transmission im=
mediately.

Google translation in English:

Information note: In compliance with Law 196/2003 and EU Regulation
679/2016 (GDPR) on the protection of personal data, the information
contained in this message is strictly confidential and is exclusively
addressed to the indicated recipient (or to the person responsible for
forwarding it to the recipient). The ideas and opinions expressed are
those of the author and, unless clearly stated, do not necessarily
represent those of Intr=C3=A9 S.r.l. Any use, reproduction or disclosure of
this message is prohibited, also pursuant to art. 616 criminal code
Italian. If you have received this e-mail in error, please notify us
as soon as possible by e-mail at privacy@intre.it and destroy this
message.
Please note: In reference to Italian law 196/2003 and to the
Regulation EU 679/2016 (GDPR), this email transmission including its
attachments, is intended only for the person or entity to which it is
addressed and may contain confidential and/or privileged material. Any
views or opinions are solely those of the author and do not
necessarily represent those of Intr=C3=A9 S.r.l., unless specifically
stated. Any review, retransmission, dissemination or other use of, or
taking of any action in reliance upon, this information by persons or
entities other than the intended recipient is prohibited. If you
received this email due to an error, please contact the sender via
email to the address privacy@intre.it and delete the email
transmission immediately.

-Jere
