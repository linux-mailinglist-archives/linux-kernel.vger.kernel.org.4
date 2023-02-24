Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9596A1905
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjBXJsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBXJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:48:21 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A57829E34;
        Fri, 24 Feb 2023 01:48:20 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z6so2141750qtv.0;
        Fri, 24 Feb 2023 01:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVXNCqpApA7ELtFM5W7tXqhzvT3RzGT0ucZSGwR72Fc=;
        b=dnY0C/s1YZxv6ExAkfxySx7upc3ZK6WcAbur+sTRGiK7sg05e5eNCaezffrO1QBDgS
         dIx+t4wtuI/ZdoxMkpMaAj3Rf0CNPlogjFI4ABmF2R6edDER3jzplFQbflqkCGKnwX6V
         SUm0w0O7T/TZQ2qlVv2JFDRNC7kh+sy7bK2HxcPhlj37u+z82i6F2KWV2zOeKm6atQRD
         /8CMxtBpU/GOHdtCRHmT3CYL2zbIh3pK6Ct//EReDOlU35qx/gB9nOlc0uubIWs4JF5w
         mNHrkDaInCMKtfFP4HmDyfBekwuBCI2V2F+6FdaYx7oCVlSc0THhnSivN89c4M4GSiy/
         kYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVXNCqpApA7ELtFM5W7tXqhzvT3RzGT0ucZSGwR72Fc=;
        b=5+SqAccAWHBEMXyVnX6GLwJYpcnwPy7KtXaX9fDw3Fgvm3O+tkfAToft/hPW0Vyat7
         iuwmu8SGOlUUrfTbvziJeixy+ErgIKJXSmwffvM9P/bgIfwwAN8snniV3ZlKK0uT32pR
         R68VF8/Oa45sEdLkV6lyGltvD++gKYNr515D3Jfl2dmkC2LtRaMTw9TSZB9N32sacZ8g
         fDuXbPRfJPJAKtakwxPDWmhktKZt06WMN402QhbrSmUN05010bfRfFRXWvv4FbUfsqHs
         ohgTxaz0AJ+2tMYA7TLS0u5haDxYPKf0Sd7+SfDs92PnRxyw9fIS7FpZhptyBTTGfnAx
         Lf0A==
X-Gm-Message-State: AO0yUKXRzdtE1pixGYZ0JPVzu0+1qjWuv+HhbCm4pPaca+BO4+vKsqJr
        7/dJD26PECBAuFaOldr4rdafeKBggNNgL+EcADo97OOEqrjkKg==
X-Google-Smtp-Source: AK7set8q1/ET9SaMohJ7q/8VDfxDX2T3g1CZP+PquoalRpsrVJj+NLUvNDoQfimqIv2A19WNteILS0DnkhT69hSTLQE=
X-Received: by 2002:aed:2791:0:b0:3bd:1a0b:8ac4 with SMTP id
 a17-20020aed2791000000b003bd1a0b8ac4mr2683586qtd.1.1677232099416; Fri, 24 Feb
 2023 01:48:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com> <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Feb 2023 11:47:43 +0200
Message-ID: <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
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

On Fri, Feb 24, 2023 at 12:51 AM Asmaa Mnebhi <asmaa@nvidia.com> wrote:

...

> > > > > Ah that=E2=80=99s my bad. The property should be called "ngpios" =
like in
> > > > > the DT
> > > > documentation. Will fix.
> > > >
> > > > And why do you need it? What's a corner case that the GPIO library
> > > > doesn't handle yet?
> > >
> > > We have 2 gpiochips, gpiochip 0 supports 32 gpio pins and gpiochip 1
> > supports only 24 pins.
> > > If I remove the logic from gpio-mlxbf3.c, the gpiolib.c logic will co=
rrectly set
> > the ngpios =3D 32 for gpiochip 0 but will wrongly set ngpios=3D32 for g=
piogchip 1:
> >
> > So, either you need to have two entries in DT per chip or ngpios should=
 be 56.
> >
> I already have 2 entries in my ACPI table, in the first entry, ngpios =3D=
 32 and in the second entry ngpios =3D 24.

Can you show the DSDT excerpt of this device? (Also including the
pieces for pin control)

Is this a table of the device in the wild?

> Gpiochip_add_data_with_keys only reads the ngpios property if (ngpios =3D=
=3D 0) which is not the case when
> bgpio_init is called. bgpio_init uses "sz" argument to populate the ngpio=
 in bgpio_init, which is not what we want.

Maybe bgpio_init() is not a good API for your case?

--
With Best Regards,
Andy Shevchenko
