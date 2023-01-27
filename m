Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4277267DA81
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjA0AOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjA0AN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:13:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6F5721DB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:13:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDB6D619B6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50860C4339B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674778381;
        bh=Dy2e0MZ3sBbbfQ1uJYMvKeZWrpufgehg6WjJ7Pz8zps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y7VWTZHhu/NF7whDsrUsV7nhgna6BF9j9//ltrDZmUOizcuCspsdmQYYxA1ffKS3v
         1w5lJ/nimN3bp3F+uqjfNahY+wAv3Qt07i/Zahr+2PG6ZkdyrbP2KHL3FgNlr8SevZ
         /0xzOTNvuLNkkV06cnPRnJB7oIhnjhROzH4qa+LnBj8zZEw/gESXjB0UO9rIpwPoQg
         Gv+DVI/5wVA8QHALuuKmx/0ul2wjOEx40B3UlCmdgY69InTvfNA0SOklowRcWgDI+l
         mkVKMhXdWYcmLs27UT22/UtS79SInCkjhx/KtUd+dfucIvAb99EBu/Sd6iaapYm4of
         nzZMP1vfP9a9w==
Received: by mail-lj1-f177.google.com with SMTP id o12so3803233ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 16:13:01 -0800 (PST)
X-Gm-Message-State: AFqh2krcn9snIDKvCL/MYNbXaYOP6FtnM69Zw9SX/8c+TVN/1+V5ST2x
        BMkhii1N16HHktuWh3pxOloDWLSlwFUfXw5tdg==
X-Google-Smtp-Source: AMrXdXu3+25tG1AX0tTAw3NUXePsMdfOctSjTiPoTIR7dx8NyyD2yH5l7oUNVibnGbCskGPI5hLrYcA5NRyzuh0kmsg=
X-Received: by 2002:a2e:bd13:0:b0:287:4eeb:53dc with SMTP id
 n19-20020a2ebd13000000b002874eeb53dcmr2191832ljq.27.1674778379356; Thu, 26
 Jan 2023 16:12:59 -0800 (PST)
MIME-Version: 1.0
References: <1673330093-6771-1-git-send-email-xinlei.lee@mediatek.com> <1673330093-6771-2-git-send-email-xinlei.lee@mediatek.com>
In-Reply-To: <1673330093-6771-2-git-send-email-xinlei.lee@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 27 Jan 2023 08:12:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY__wuHgZmPKGxKPceHTcupUqKyxPb0CrG=ZB1c47T+Dohg@mail.gmail.com>
Message-ID: <CAAOTY__wuHgZmPKGxKPceHTcupUqKyxPb0CrG=ZB1c47T+Dohg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/mediatek: dsi: Reduce the time of dsi from
 LP11 to sending cmd
To:     xinlei.lee@mediatek.com
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xinlei:

<xinlei.lee@mediatek.com> =E6=96=BC 2023=E5=B9=B41=E6=9C=8810=E6=97=A5 =E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Xinlei Lee <xinlei.lee@mediatek.com>
>
> According to Figure 16 Turnaround Procedure on page 36 in [1], you
> can see the status of LP-00 -> LP10 -> LP11. This state can correspond
> to the state of DSI from LP00 -> LP11 in mtk_dsi_lane_ready function
> in mtk_dsi.c.
>
> LP-00 -> LP10 -> LP11 takes about 2*TLPX time (refer to [1] page 51
> to see that TLPX is 50ns)
>
> The delay at the end of the mtk_dsi_lane_ready function should be
> greater than the 2*TLPX specified by the DSI spec, and less than
> the time specified by the DSI_RX (generally 6ms to 40ms), to avoid
> problems caused by the RX specification

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> [1]:mipi_D-PHY_specification_v1-1
>
> Fixes: 39e8d062b03c ("drm/mediatek: Keep dsi as LP00 before dcs cmds tran=
sfer")
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index 3b7d13028fb6..9e1363c9fcdb 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -721,7 +721,7 @@ static void mtk_dsi_lane_ready(struct mtk_dsi *dsi)
>                 mtk_dsi_clk_ulp_mode_leave(dsi);
>                 mtk_dsi_lane0_ulp_mode_leave(dsi);
>                 mtk_dsi_clk_hs_mode(dsi, 0);
> -               msleep(20);
> +               usleep_range(1000, 3000);
>                 /* The reaction time after pulling up the mipi signal for=
 dsi_rx */
>         }
>  }
> --
> 2.18.0
>
