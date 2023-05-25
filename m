Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62087710D59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbjEYNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbjEYNhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:37:55 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A226189;
        Thu, 25 May 2023 06:37:54 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-623921866bfso4214936d6.1;
        Thu, 25 May 2023 06:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685021873; x=1687613873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsSHALAsMKukrtmUiJgckekRC7Xr3Hckq7yajpTmIdM=;
        b=Z6WDfgLoM9sg8yoUUmKWkOuatboVl1Lf46DaVTQmR84jCP6kdZCgrzPasEsnsupakm
         Ojuwgr1RCQOZ+DMDJ5zzt5gOFtRzIAz+aiPTd2/CKEwEFXJJ9riktR+PEkEBzexel91T
         d5DxajXvriNo69hsCjAgwuRWObVOYmV/BiQ/Dd1XcQks/1xsxxZ+VQDFqSMcoRQOXRVC
         Ll2v3mWTdFF8ShzxIXV0SJxhtWbXInXB14jlwfPEJE6D/GSIs1jJ/6+q4mg7zsaPlc/U
         sFfd2caKAyLEqBT7ycT3HRseB6KjOrCWb/U7iroUGbA2hgatKM2eQeGw1ACAXsAonN49
         etoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685021873; x=1687613873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsSHALAsMKukrtmUiJgckekRC7Xr3Hckq7yajpTmIdM=;
        b=hKoGOkd7piPW9/E+czPtiQ3rKYeMC0W2ogXSzPb5AIXBKHFX2mHLK58NgCwUta4Eps
         X+MxwMo+mGh9Xs0514ekhHyvYqfmKTKQMIA7Q/s1g3JoISRFEhAD9fPvzZLzL6CJ1N14
         Gg3H5Z4KjtjYXlFSZE8M3kKh9r38UD7VnamFN6ChSko8RoFpzMMV6J4Gyyz2a4eLHLam
         k0SdvrVVZpIRrra9Xt2VFlQCWXOHAhWi/pcgo5itoa+w8vmnOQ9JJ1b/3ac75wz6zqYY
         +zhdIz/V+Wd0bNnq9ALfqfBtRwxDd/rMAlIAQhXXedxr6ivlx8mLwt0ZbG8JEph9Cj8I
         ICGw==
X-Gm-Message-State: AC+VfDyUfB2f1m5igs9nxMd53ljJgguXaP6sKSmz/oXd++UKqPg3qHpn
        5sg+yY3zFyuhbaNwc7k5ybgqU5BSbDbANRQKLKE85yAysow=
X-Google-Smtp-Source: ACHHUZ63JuzKH6ZAhBoClRi8mKfFsNB3KpcYNMw7K/05YNYZbeuQi36TcaQJUo8i/MRcAef3k7H3JRwtMKtgwk6bCmI=
X-Received: by 2002:ad4:5d4e:0:b0:5ef:8ae8:9adb with SMTP id
 jk14-20020ad45d4e000000b005ef8ae89adbmr1336967qvb.37.1685021873493; Thu, 25
 May 2023 06:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230525040324.3773741-1-hugo@hugovil.com> <ZG84KCeMIINFVTMh@surfacebook>
 <20230525092627.edf4f7f9df4b9b1cf7b568a4@hugovil.com>
In-Reply-To: <20230525092627.edf4f7f9df4b9b1cf7b568a4@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 May 2023 16:37:17 +0300
Message-ID: <CAHp75VenvvkC1evsmhSBNT5=V=D92RX1JXnwZWAtsJ2TrADvRA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] serial: sc16is7xx: fix GPIO regression and rs485 improvements
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
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

On Thu, May 25, 2023 at 4:26=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Thu, 25 May 2023 13:27:52 +0300
> andy.shevchenko@gmail.com wrote:
> > Thu, May 25, 2023 at 12:03:13AM -0400, Hugo Villeneuve kirjoitti:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > >
> > > Hello,
> > > this patch series mainly fixes a GPIO regression and improve RS485 fl=
ags and properties
> > > detection from DT.
> > >
> > > It now also includes various small fixes and improvements that were p=
reviously
> > > sent as separate patches, but that made testing everything difficult.
> >
> > > Patches 1 and 2 are simple comments fix/improvements.
> >
> > Usually we put fixes at the beginning of the series, but these patches =
are
> > missing Fixed tag. Are they really fixes or can be simply moved to the =
end of
> > the series?
>
> these are not code fixes, they are comments improvements. I was not aware=
 that you need to put a Fixes tag for correcting syntax errors in comments,=
 or adding comments to improve clarity.
>
> I often submit such comments patches but was never asked to put a Fixes t=
ag before. Seems strange to me...

In this case there are probably no conflicts, but the usual grouping
of patches is following
1) fixes that may be backported;
2) cleanups / refactoring /etc;
3) new features.
4) additional light-weit cleanups, such as whitespace cleaning (it's a
radical, we probably do not accept pure whitespace cleaning patches,
but you got the idea).

Seems patches 1 and 2 fall into category 4).

--=20
With Best Regards,
Andy Shevchenko
