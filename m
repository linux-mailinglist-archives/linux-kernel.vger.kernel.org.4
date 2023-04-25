Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924676EE316
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjDYNb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbjDYNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2B214442
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:31:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B169D62E87
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D5C433A7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682429463;
        bh=wmID8emQw+is79zlL5AF9o/8qFWaAe9tV8o9bZxfmd8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=st4p308KBj30FGGNjBVlzWhIO3+6w06o6Z0nUOl7vDHpvIq64qY179xoM9DlVUMYg
         KbU2Dw/vcVEEdidJKz5pmPmtWgjrdS6skIeMOIxCdPPy11VrPQtfGswh7nEfBOGNDr
         NBTV25ZRmHCeUaND41NJqa65fyAKhTGNnKmyT7ykiNg6HKxxkOkFxsd+SEi+x4/zX2
         7J+KVyR23DcfUPYsvOfe3GuTLc8syUBVNCCN/fE4uV9fG3jlTM+0wNyWMl8nE6Io0b
         slRZq52cOfYhFLEf5ScU/8prCZ7Hj8ghfoK2CS8xTo09HqPsFdR33ltHvx+ua1qmXI
         Rux0i8icNS1Fg==
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-63b60366047so4617227b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:31:03 -0700 (PDT)
X-Gm-Message-State: AAQBX9ejAYREe6DW9d47DBlzY6kc05JnZle2ChNLyTyn6cYd/6eqd/yH
        pzntePscKgTTbLEUhM8D3TvWk06r6CpGnhDNlW+lsg==
X-Google-Smtp-Source: AKy350aIvPvFU11G6qOuvvWHhyxXmANsSsmKypyebe+yKmS7qPVlrUVJUhVNvRKDlhe6tff+0goq4lc4uY0rFxX3mp8=
X-Received: by 2002:a05:6a20:3d94:b0:f3:6b70:2dd7 with SMTP id
 s20-20020a056a203d9400b000f36b702dd7mr12684872pzi.34.1682429462222; Tue, 25
 Apr 2023 06:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de> <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de>
In-Reply-To: <14636275-4d26-d639-5f6e-293fc6d1c4c6@web.de>
From:   Robert Foss <rfoss@kernel.org>
Date:   Tue, 25 Apr 2023 15:30:51 +0200
X-Gmail-Original-Message-ID: <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
Message-ID: <CAN6tsi7caOQZLLvbL7phMEtNvBLaWgJuHLkLo3YWdqQw7Vxnaw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: Move a variable assignment behind a
 null pointer check in receive_timing_debugfs_show()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Allen Chen <allen.chen@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Hsin-yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Markus,

This patch seems to be a part of a series without being marked as
such, this causes issues when importing this patch with maintainer
tools like b4 which automatically pull in the entire series and not
just the specific patch. Either label the patch as being part of a
series ( [PATCH 1/XX] ), or submit it separately.

On Sun, Apr 16, 2023 at 5:47=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> Date: Sun, 16 Apr 2023 17:30:46 +0200
>
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Creceive_timing_debugfs_show=E2=80=9D.
>
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cvid=E2=80=9D behind the null pointer check.
>
> This issue was detected by using the Coccinelle software.
>
> Fixes: b5c84a9edcd418cd055becad6a22439e7c5e3bf8 ("drm/bridge: add it6505 =
driver")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

The email in the Signed-off tag should match the email of the sender,
which it doesn't.

With the two above issues fixed, please add my r-b.
Reviewed-by: Robert Foss <rfoss@kernel.org>

> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge=
/ite-it6505.c
> index abaf6e23775e..45f579c365e7 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3207,7 +3207,7 @@ static ssize_t receive_timing_debugfs_show(struct f=
ile *file, char __user *buf,
>                                            size_t len, loff_t *ppos)
>  {
>         struct it6505 *it6505 =3D file->private_data;
> -       struct drm_display_mode *vid =3D &it6505->video_info;
> +       struct drm_display_mode *vid;
>         u8 read_buf[READ_BUFFER_SIZE];
>         u8 *str =3D read_buf, *end =3D read_buf + READ_BUFFER_SIZE;
>         ssize_t ret, count;
> @@ -3216,6 +3216,7 @@ static ssize_t receive_timing_debugfs_show(struct f=
ile *file, char __user *buf,
>                 return -ENODEV;
>
>         it6505_calc_video_info(it6505);
> +       vid =3D &it6505->video_info;
>         str +=3D scnprintf(str, end - str, "---video timing---\n");
>         str +=3D scnprintf(str, end - str, "PCLK:%d.%03dMHz\n",
>                          vid->clock / 1000, vid->clock % 1000);
> --
> 2.40.0
>
