Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A416FDA52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 11:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbjEJJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbjEJJDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 05:03:19 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326B23A96
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:03:17 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-54f846d24d1so1068553eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 02:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683709396; x=1686301396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMjeCMC/4Q3TMdYdgIMW1QMW7kWGP2cWpwPZAIpQS9Q=;
        b=MuuFEvVREOXCGJXlminekYSdnWKsfo3jTOQOaquCe3bs/J7dPBu9z1XXIXiHwVkQ2C
         TKrjNsUtVnTjWP5m66UdkOEWCnIdfC1T7p4Ay4q7BL/WZBYC7CwIebNhQV3UciiR81Bt
         kIYLPpqR+R71WfQHfg+cf1af6VHgQA27x4bxuDiY3qjZy9Kbo9v2NOQLePclg/euDrfz
         C8Kaw/7pGS0wDjb2RwDSiYZXvQswLc1N8HYGKmqW9TFjFeN1mTDJTPDq6bo1gMV+V/S0
         NgfTfqiHFwYTEJufxn0xIhWG3yVJXYFruPKWGtK3MDFCRgJJuPnR2xMkeQYr30fA79TX
         exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683709396; x=1686301396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMjeCMC/4Q3TMdYdgIMW1QMW7kWGP2cWpwPZAIpQS9Q=;
        b=CUFAPpUwH/GkzWFRBwqUtG+N2Xr0WdIaL98VeiDNO68+j5+4z95Fl1eDu4Eyx2ePHW
         nymicG5eCwmBjkSr8MJNmiAhaAozudCdO+jfyTy2Vy/CAebOy2ZlAMxT56UEtNz01uU1
         LHl9Zj9BAzwX/YAtub7P5Yvfu7kL6G4ikBCplRf0lZshJxMPLqyOCTZIvhaV2Ji8PNOj
         Ut0vYY66u8nNb8ZX3vA8NHKC9aZORR7indUeBEGGRLLwge+VsmLIXZQVuxB5010orIJQ
         Tm6BxchyvcAECNMWdhIQhv3H+AoVs7DDExj50mUtSRK5SAedAwZLONPsH3kAxjTe8ZL0
         8ASA==
X-Gm-Message-State: AC+VfDz1FWCbUEX+R393TIYuXGRq5zSlgbgdOTtUId/zei4K7pYK/ehT
        BQ5pd619JpJfodIAu1tSOITKpo0IGAeEFJ3RZcU=
X-Google-Smtp-Source: ACHHUZ5q/i4IuYgLDjHeL/Nh7DaCl+7p/egM0PY/LxatYrUi4pUvSvDMyUTKd+Bk8MQtN9QkiWYhsJ9GQZYfCaCfvsU=
X-Received: by 2002:a05:6808:1d8:b0:392:2f89:6a1b with SMTP id
 x24-20020a05680801d800b003922f896a1bmr2689808oic.41.1683709396376; Wed, 10
 May 2023 02:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230510084713.3528908-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20230510084713.3528908-1-rick.wertenbroek@gmail.com>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Wed, 10 May 2023 11:02:40 +0200
Message-ID: <CAAEEuhoTeOe34w2DfrJNT3Zdq5Ej++KtavKfwwgqWyXqk0m_4g@mail.gmail.com>
Subject: Re: [PATCH] mm: memory_hotplug: Fix format string in __add_pages warning
To:     rick.wertenbroek@heig-vd.ch
Cc:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 10, 2023 at 10:47=E2=80=AFAM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> The format string has a typo and prints e.g.,
> "Misaligned __add_pages start: 0xfc605 end: #fc609" instead
> of "Misaligned __add_pages start: 0xfc605 end: 0xfc609"
> Fix "#%lx" =3D> "%#lx"
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

The issue appears in the __remove_pages format string as well,
sorry didn't notice that right away. I'll send a new patch.

Rick
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..446abb088b51 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -325,7 +325,7 @@ int __ref __add_pages(int nid, unsigned long pfn, uns=
igned long nr_pages,
>         }
>
>         if (check_pfn_span(pfn, nr_pages)) {
> -               WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__=
, pfn, pfn + nr_pages - 1);
> +               WARN(1, "Misaligned %s start: %#lx end: %#lx\n", __func__=
, pfn, pfn + nr_pages - 1);
>                 return -EINVAL;
>         }
>
> --
> 2.25.1
>
