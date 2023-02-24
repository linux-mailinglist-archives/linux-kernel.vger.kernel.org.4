Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6446A16E3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBXHFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXHFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:05:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58164DE1A;
        Thu, 23 Feb 2023 23:05:04 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so51316054edz.10;
        Thu, 23 Feb 2023 23:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVlP+lQyDpzjJB2ngj4sejDTOFO0AAyaDoykPFt2lLY=;
        b=f3IdPR22ijQhNvsHjHhiV6lYLhBA+EVb1xgubviqUJms1zwX9SoiD/ZQxmhXPnrD+l
         Y5cgcXQr3PIo0VcFbFZZJ3FDrfL70RsKCEigYCZBuvcG1hP4i+y4vZP38fxQGrBGikpa
         cuId74aGiEsjQEkPPu4j3zRhV/DIZJA0VTOtjG7iWoARduSx0mVvkEYuIrQwCdAu83tl
         qPIcyOw/nPl4V75TfxoClnOY25AdwOVIh0INJZ1m/9VHlBHCHiR+40P5QCdjFLJgN2lL
         ZQFxfiEsZFfXDQFX4CzxacHJFR+sk80bxRKgdZ5Eg6NxbWyafuasfy/SelzSjaEGHOT6
         nHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVlP+lQyDpzjJB2ngj4sejDTOFO0AAyaDoykPFt2lLY=;
        b=1nWHLLnUjAV3Gncb6g1RA+DFrTAE9MN5eYKHa9rnzXDwu1rJn8p3VEI2nSxaJUNeYP
         voa4ttGddj3undnzAGpL4/rU4QPyVZflpZCMa0HMpVcKHv+CB65zTnEJSiaDjAuj5QUN
         xFlB4+gFi+IYmXN1UKV6FC05Jfh4oadmxXxPCkNcLF+ymMqJWkKI/ytf/KxHTE1y9vQm
         QBXQVmexX1IsBx+ReGoTt4CKyQIvho2BKjI6Ojq9DNktI/ydOodA/d2UsV7m1OYLLtIY
         XSra8pMBAoWam0o6HvvwPFqFJKWLQmyLbO4imjHO5kwGvPqxqBpuCIefUIjMXu7T7sVs
         9hmw==
X-Gm-Message-State: AO0yUKV4/R2D8dEWMZGC4Lnp0fZ9X3bLgN7fgS2jcJTNkUVGBTYKrAYA
        rQ3TzMwU3+BR0k6izTf+rO0=
X-Google-Smtp-Source: AK7set+WsknM4cAtjT5f+DiSwmlPiwKObB7zMJlVq+Ze3T/LxhGehpXylXVXHgdqL7wUBePdJJTNeA==
X-Received: by 2002:aa7:dac5:0:b0:4ae:eb0f:42a9 with SMTP id x5-20020aa7dac5000000b004aeeb0f42a9mr14868705eds.23.1677222303360;
        Thu, 23 Feb 2023 23:05:03 -0800 (PST)
Received: from sakura.myxoz.lan (81-230-97-204-no2390.tbcn.telia.com. [81.230.97.204])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b008e493b7bb61sm3317211ejp.153.2023.02.23.23.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 23:05:02 -0800 (PST)
Message-ID: <24d9dd82485fc058abddc31bd31a041926d7a905.camel@gmail.com>
Subject: Re: [PATCH v1 1/1] pstore/ram: Fix crash when setting number of
 cpus to an odd number
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     Weichen Chen <weichen.chen@mediatek.com>, yt.shen@mediatek.com,
        darren.chen@mediatek.com, keescook@chromium.org,
        tony.luck@intel.com, angelogioacchino.delregno@collabora.com,
        matthias.bgg@gmail.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Feb 2023 08:05:01 +0100
In-Reply-To: <20230224023632.6840-1-weichen.chen@mediatek.com>
References: <20230224023632.6840-1-weichen.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-24 at 10:36 +0800, Weichen Chen wrote:
> When the number of cpu cores is adjusted to 7 or other odd numbers,
> the zone size will become an odd number.
> The address of the zone will become:
> =C2=A0=C2=A0=C2=A0 addr of zone0 =3D BASE
> =C2=A0=C2=A0=C2=A0 addr of zone1 =3D BASE + zone_size
> =C2=A0=C2=A0=C2=A0 addr of zone2 =3D BASE + zone_size*2
> =C2=A0=C2=A0=C2=A0 ...
> The address of zone1/3/5/7 will be mapped to non-alignment va.
> Eventually crashes will occur when accessing these va.
>=20
> So, use ALIGN_DOWN() to make sure the zone size is even
> to avoid this bug.
>=20
> Signed-off-by: Weichen Chen <weichen.chen@mediatek.com>
> ---
> =C2=A0fs/pstore/ram.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ade66dbe5f39..fc57ac97e506 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -528,6 +528,7 @@ static int ramoops_init_przs(const char *name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0zone_sz =3D mem_sz / *cnt=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0zone_sz =3D ALIGN_DOWN(zone_sz=
, 2);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!zone_sz) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0dev_err(dev, "%s zone size =3D=3D 0\n", name);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto fail;

Might want to Cc this to the stable mailing list.
--=20
~miko
