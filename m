Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4DF610681
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 01:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiJ0Xq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 19:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiJ0XqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 19:46:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68645BC23;
        Thu, 27 Oct 2022 16:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73843B82719;
        Thu, 27 Oct 2022 23:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14589C433D6;
        Thu, 27 Oct 2022 23:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666914382;
        bh=vKyUpa6z1uRmhJcURUFkFkbLGb/GBvfWEJCcrU7tfqo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oXT8YtNrSRdfCCoSqjJfjvVD/CTH2tdzsgPEioQDOkJy0Wa41Ye/QlHnbD8jD5pvQ
         EMNq+ymHApj/JfjgbVPtTdAt3wVL9QWLKOuu4RGnfwTyPRBRy6e7kgX+bsZjrc1BNo
         0N1rt2MeucxNHbsQo0Egvw4AFBW5q1dAWqt6XhiWoT3+8Dj/1bElZqIzwTZFWjXlLI
         U2xBEEAq0H+3fcJBsUPW/+UG3mNYA7Y8EHwRZP3tqNz2r4eJt/U0fiv0O3icebuYFg
         4JMc0SvGf6kTBfU5CHDJ4w5DGxjOQU5yVCz8SX8R38gXtmtDfd0v/nFHftkj3ibdpi
         OrQpBXaRcNU4g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221021104804.21391-3-rex-bc.chen@mediatek.com>
References: <20221021104804.21391-1-rex-bc.chen@mediatek.com> <20221021104804.21391-3-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v6 2/3] clk: mediatek: Add auxiliary bus support for sysclk reset
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de
Date:   Thu, 27 Oct 2022 16:46:19 -0700
User-Agent: alot/0.10
Message-Id: <20221027234622.14589C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bo-Chen Chen (2022-10-21 03:48:03)
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index 74408849ed86..61b7ee23738a 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -444,6 +444,63 @@ void mtk_clk_unregister_dividers(const struct mtk_cl=
k_divider *mcds, int num,
[..]
> +int mtk_reset_controller_register(struct device *dev, const char *name)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev =3D mtk_reset_adev_alloc(dev, name);
> +       if (IS_ERR(adev))
> +               return PTR_ERR(adev);
> +
> +       ret =3D auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(dev, mtk_reset_unregister_adev, a=
dev);

Can we have devm_auxiliary_device_add() that sets the parent and
registers the device?
