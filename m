Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A56F2520
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjD2OtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjD2OtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 10:49:05 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79524171B;
        Sat, 29 Apr 2023 07:49:04 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-555e853d3c5so8781697b3.2;
        Sat, 29 Apr 2023 07:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682779743; x=1685371743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAAQBlElYSJ/lUA1HDuQ/lPfFlPU+q4Pqd13n8Qey/4=;
        b=NjcG1Eqp32KDMChclqGfpAl1AdgNB0vFLHatV2ipjz8irmf4W+/MXDdev6cTwaAcr+
         BjzHCnzXvppQ5MIjAtk1htEYdUd08SM8tjXRxKwrslrG4ICgwyDbzs+jOondoO+q/R4M
         ZvUCUzuP09fQUzUKx9OfibJNufustQew/4lvblPt12VnnQMkw85iEc6/rQYDSC/y7mmH
         CvMJikLz2RYTgNZqB3JyVhFIf8DLBI13Oh5V+FxeMw0+T5XZyRRtkHu9psu/BNtRWlVE
         HtpppdZeU384MBEuQJnfS8PdfFGSFGmw9ZgPdTZ/iTN33gsWUTK2cnNe+vvthi7kLmka
         5x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682779743; x=1685371743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mAAQBlElYSJ/lUA1HDuQ/lPfFlPU+q4Pqd13n8Qey/4=;
        b=KudvcAPvK75DKAHEsyKvsdan8ZuBPiY0Hx4aL126B7WwavDMpVam1b8E6ixoq2yzSp
         mK4VUJ5GEGaV6A2mtYKGSW9hYQcjx4y6H+Rpz2kFBMnTg+crpnuXU6gCgUUXgK5pJY3X
         HpxOOXB2jb490gaKHcAtssIaPOhZ2D+TH61RH8rZ3UbhcILIeHqF3o7qwNxeJmq3veXA
         KPgTgI2CK/k14C7X7FA5WU43rmCwjackyjRRpq3yNkTPCCm7LXeBKcF9uUqdjga8yWbQ
         7aQUYqDcaKYrQGECAglA5J8aOS0G+Ha+zbWTxAhFXCqnXK5qXqC1z+lOgoNyJsTq/OK/
         exkA==
X-Gm-Message-State: AC+VfDwnfmZ7XKnho7n+HfnI/TIFprGsYUA9o5VfS8h4+i+oHSWcCl/7
        TA6QZJEmWFbNM4q3Usf9X8Wh0BxVQsEGwKZQC+s=
X-Google-Smtp-Source: ACHHUZ5ZBPdoWBjca0sMHAhKwwRtzgGBN0NmGyhanWoeVLSxU58ypBn3NJAAjovntGuo3+YSHqZMzs8oBgcsPKbN9xk=
X-Received: by 2002:a0d:e64a:0:b0:54f:8171:38db with SMTP id
 p71-20020a0de64a000000b0054f817138dbmr7075672ywe.32.1682779743632; Sat, 29
 Apr 2023 07:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230429142547.328125-1-samsagax@gmail.com> <18804132-56f2-436e-ba1c-298653324d37@roeck-us.net>
In-Reply-To: <18804132-56f2-436e-ba1c-298653324d37@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Sat, 29 Apr 2023 11:48:52 -0300
Message-ID: <CABgtM3ifjcZa5HGXrUKTStPZua0W-cXZOv=gkVg_3mQNS6o4vg@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Use less convoluted enum cast
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
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

Thanks, Guenter!

El s=C3=A1b, 29 abr 2023 a la(s) 11:43, Guenter Roeck (linux@roeck-us.net) =
escribi=C3=B3:
>
> On Sat, Apr 29, 2023 at 11:25:48AM -0300, Joaqu=C3=ADn Ignacio Aramend=C3=
=ADa wrote:
> > Change
> >
> >   .driver_data =3D (void *) &(enum type) {enum_literal};
> >
> > to more readable form:
> >
> >   .driver_data =3D (void *) enum_literal;
> >
> > and corresponding cast usage as board type flag.
> >
> > Signed-off-by: Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
>
> Applied to hwmon-next.
>
> Thanks,
> Guenter



--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
