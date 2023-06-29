Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E5741EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjF2DxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjF2Dwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:52:50 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984A2724
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:52:49 -0700 (PDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0FACA3F26A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688010767;
        bh=ln7LWd40lnjGepxvFLRyaxcRyxZ30/1SOSyaN+ooqhU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QIpPVd77DbiwRV+SI1GrWj1L/oA8VXduVNWPQmMSHyHEZdp/JxrzuKb8E2Kj7D23n
         brRU3uRg/qrdVnvM0cG7k0VW8AVz5QVK3JC7In+BjPiZP8/a4BhRD25oM7IxpubqKJ
         LAU4dzEiaWUh6gU5Jm76m/ZziJ0WNe/fDc6w2yTszEN5aogu6hjy2BGtrLj3JdVoV4
         0ifoik3HNm/3akIZnndq8AAn//9yv4ADyz21V+HYQvEgNM91ODkm3sRxJLNzeUgRDS
         Ce+IRjHFQFVO0nvzJN89Ucam1HaZxs6jItbgoND1zo9Z/dh35Qjkczkj0sbwQa1M6E
         xVKeWyqh/qZvg==
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7835d5bfaecso11898039f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 20:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010765; x=1690602765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln7LWd40lnjGepxvFLRyaxcRyxZ30/1SOSyaN+ooqhU=;
        b=PC4snC1dT41Me+ElNTi2LFxKXiQuCN3PR/YPqOOEfQDQ2XG+8h40ZmLYjriGGGYns9
         Vw8GLiX94Pq2QZkYFFnCAF7sVMV2gTG1KpC8/p0Z4r4Kz1VNZv2hUAGpSDVZmXqmRyWD
         Yje13T7q5ITUIkfV50IRuoNXKQ8+/VryTsLZegPmXC+HX/OdP43S9G/Lgd8ffmotliJP
         J1kLLi2h5bhc4bha/fe/dD88V0XthDiTrkMb3m5YAo9882cLp+ah8ZbaEJPdNCiL82zC
         ifQL6T0C7Ec2HsaFqGjtgSlVwVv+LkOGKASIfj97IbVdAkeZnqUBbge54iC6/OM4UIRg
         twLA==
X-Gm-Message-State: AC+VfDwOZoqKJ6e3e2kcHGQ2B4+gB4n4hbIN7mRu+DXjsOu8juMq6wxG
        b9QrjBzdDz9K8EgCDnSR/RvVtikwZdGfBb1hX22eJYCzvmUO+OeNwFAACczsEXvBjgHC/x6vJca
        ioi+v2u4Gi8I9y1ZciYSxq+BwHsPXXB3xpZnyQGtsnqEkKwaIRmSA77LFcA==
X-Received: by 2002:a05:6602:19c7:b0:783:7307:faea with SMTP id ba7-20020a05660219c700b007837307faeamr7544501iob.2.1688010765017;
        Wed, 28 Jun 2023 20:52:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ahLOnBMgwMBsY52+7hoRe2i6gCDHsrz6TZy1dtXaKOLZeiNExKjYO+GHTOJMSyok6Q0EEBkJFQLvNqRPoS4U=
X-Received: by 2002:a05:6602:19c7:b0:783:7307:faea with SMTP id
 ba7-20020a05660219c700b007837307faeamr7544484iob.2.1688010764714; Wed, 28 Jun
 2023 20:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230628085253.1013799-1-koba.ko@canonical.com> <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608340E81A15F20EBAD75F08FC24A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Thu, 29 Jun 2023 11:52:33 +0800
Message-ID: <CAJB-X+U7Af3ypru3O0quGTqrsJPMO3b7uoBTNjTLSixrmrvXJw@mail.gmail.com>
Subject: Re: [PATCH] EDAC/i10nm: shift exponent is negative
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Luck,
I agree with your points
is it expected to shift with negative?

Thanks
Koba Ko

On Thu, Jun 29, 2023 at 12:41=E2=80=AFAM Luck, Tony <tony.luck@intel.com> w=
rote:
>
> >       ranks =3D numrank(mtr);
> >       rows =3D numrow(mtr);
> >       cols =3D imc->hbm_mc ? 6 : numcol(mtr);
> > +     if (ranks =3D=3D -EINVAL || rows =3D=3D -EINVAL || cols =3D=3D -E=
INVAL)
> > +             return 0;
>
> This seems to be just hiding the real problem that a DIMM was found
> with some number of ranks, rows, or columns that the EDAC driver
> didn't expect to see. Your fix makes the driver skip over this DIMM.
>
> Can you build your kernel with CONFIG_EDAC_DEBUG=3Dy and see
> what messages you get from this code:
>
> static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
>                              int minval, int maxval, const char *name)
> {
>         u32 val =3D GET_BITFIELD(reg, lobit, hibit);
>
>         if (val < minval || val > maxval) {
>                 edac_dbg(2, "bad %s =3D %d (raw=3D0x%x)\n", name, val, re=
g);
>                 return -EINVAL;
>         }
>
> -Tony
>
>
