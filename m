Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67686F5F66
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjECTs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjECTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:48:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D587AB4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:48:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac70c975fcso14705221fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 12:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683143331; x=1685735331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgxHMAd2AIMSIN7wxwztZQuxCjRjDT1lsufiXrNyadA=;
        b=aogvjXXKvsH1JCvlSuu99w3M49a+Rox9nlF1yW7PWiOObH1fXAT5pOak8lxxjRSSs/
         uUUB2uES6rNkgkhJE0lSCAgPN/H7/tXyEsAywz+0KRgUTa1uomGgUKEP7H6HcCX9rhmr
         t3Erd3e6uNTmrhG1d/mAtgjoudH2HZMmUfGolqPePtU4Xljlni3kDasUhsNoxvT+owOA
         +y9OgsP9ajUid7qTrnqieZvGFHXE/MigJy9SH2sp8bCjsbLDXl0sALVYAUPC8u8/4iK2
         ztsSOWVNk7tEjd3X6W8mGLPZjN4p3AuCZXOS4wR6qGVWEMzLD+KhnEqKe9Az7gfEJNtY
         wJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143331; x=1685735331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GgxHMAd2AIMSIN7wxwztZQuxCjRjDT1lsufiXrNyadA=;
        b=EKyQl+hPKfWh3DYULp4cWIzbWmaPDo+6AvICcUvryWUaovfG6IAMVw26oQHSMqELoL
         hRR8KhYE/NBd0aX6A40M8qR+wpexbWXM0V1HVx1DEhdGBikfhvLIILlLNo1p8wmlhPpS
         qEF+tEZStYD0z2GfdMjA71haIcxaapZQTy7g9Ye62/R9HluZBFLXucRMppLbL9JI1tDj
         uAKqCDsLNeffNODUE8MHqqTsdNUC3YjiLKTbvNRv/U1BwueHvbiYWqCBK4mK+/q6Di0s
         f30CZ7is+mQx6xOUvXZJ5qjUJMf2B1Af1KdcnbVDoQGOnACa3L8k41xtaEBGgbRDVnpr
         HpzA==
X-Gm-Message-State: AC+VfDwF3oqHqr7oyhYLerJruoTXqDTLsQqFUYvoJF718IiYW108Jf/Z
        8QJKKg39Iupg3CsLgugWbFjoyE9HDX82o1Lto+E=
X-Google-Smtp-Source: ACHHUZ4NybURc8uLsP4LiiPVzi+nXZYpmTbylkvjCdEyJuSHfBGFZ4e/0y65cuVcRE8Kp/ENoMgol/Mx3aZAwrVJoGg=
X-Received: by 2002:a2e:680e:0:b0:2ac:775f:6fd3 with SMTP id
 c14-20020a2e680e000000b002ac775f6fd3mr287789lja.13.1683143330477; Wed, 03 May
 2023 12:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230412061700.1492474-1-AVKrasnov@sberdevices.ru>
 <60fa656e-bda1-1de6-a79e-3e3041cd69a8@sberdevices.ru> <780c0cae-18b6-2652-1c2c-6d398ea60451@amlogic.com>
 <e7c49f2d-b3c1-8d9b-76fe-c8759b37c7c7@sberdevices.ru> <20230418152505.72fc16da@xps-13>
 <15a6e415-1489-a81f-fc8f-2372678ad2cb@sberdevices.ru> <ee10bdeb-416c-70f0-d323-7107fe0746e8@amlogic.com>
 <5e4b395e-bf9d-0123-a0f2-2b378d950b29@sberdevices.ru> <fda1ae91-4bf8-6945-bd0d-b6dabc9cb4bd@sberdevices.ru>
 <a5010dcf-a8ce-f144-949c-687548cefce7@amlogic.com> <cf27b6b4-a75b-c5a6-32ea-ac20a2984192@sberdevices.ru>
 <20230502115913.78012d98@xps-13> <2274b432-d1a9-b3cf-4f7b-08c4a4c580b5@sberdevices.ru>
 <20230502132745.14349770@xps-13> <2b2f5cb4-84f7-65f6-13b2-42f965503023@sberdevices.ru>
 <20230502141703.29f0bc30@xps-13> <91cb8e19-e782-b847-8d2b-22580c371c34@sberdevices.ru>
 <20230502150553.65fdeb7f@xps-13> <8996d53c-54ff-6a37-e08b-95cae0629703@sberdevices.ru>
 <20230503100342.63215058@xps-13>
In-Reply-To: <20230503100342.63215058@xps-13>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 3 May 2023 21:48:38 +0200
Message-ID: <CAFLxGvwfi2RH3y2M6n0vqUHarp6DwR-wT7oBto3raA7oC3nJvg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] mtd: rawnand: meson: clear OOB buffer before read
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, oxffffaa@gmail.com,
        kernel@sberdevices.ru, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        "yonghui.yu" <yonghui.yu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for joining the party late.

On Wed, May 3, 2023 at 10:07=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
> > So for me main question here is:
> >
> > How JFFS2 should work with controllers where we can't update data and O=
OB
> > independently? Driver of this filesystem knows nothing about this featu=
res of
> > the controller.
> >
> > Or JFFS2 works incorrectly in my case when it tries to call write page =
callback
> > after calling write OOB callback (IIUC it is better to ask Richard as Y=
ou mentioned above).
> >
> > Or may be it is better to suppress OOB write callback (or set it to NUL=
L) in this
> > driver as in vendor's driver?
>
> I would assume using the unprotected free OOB bytes to store the
> cleanmarkers should work. But that's a bit fragile and very filesystem
> oriented. I don't like this much. But on the other side JFFS2 is
> legacy, you should use UBI (which does not play with OOB areas) :-)

Please note that JFFS2's main use case is NOR flash. Support for NAND
flash was never
considered as fully complete/stable. That's why UBIFS (JFFS3 in the
very beginning)
was invented.

Thanks,
//richard
