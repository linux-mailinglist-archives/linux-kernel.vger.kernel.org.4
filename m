Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC16E1440
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjDMSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjDMSk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:40:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD487DB0;
        Thu, 13 Apr 2023 11:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B30640B7;
        Thu, 13 Apr 2023 18:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536EDC433EF;
        Thu, 13 Apr 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681411224;
        bh=mwYnTH2xTUlzJflPd1vC123IfsPEl3nEWJIFOU/ryso=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=C1b7JS3gODDSYYlBDTIpxlgxG1R4XL1R85N0pALFWGPerftCQh/QgRTkSYmNuEYE9
         L/Edkv3kS7VyqrGIxRIIdjjQO2xm/Qoe5ITC3m4M51owUTozFTFYrb45KhE0FrHJ9E
         yjniCCFn4wdkU5OC0UqrILGm8af4piU0eXT+ootGLCww0CkSFCgOTSkv41JoWKduH1
         wNXgpYg6SbGBH3SUhdHfLx6632/mSuRMo2Q/jkQfKPur8yk4bqg7cVIAPHLTp5pE43
         rCPZVphcdd8JaZowPPREGMbP25Ke1cssVQFxLKe/7IZLp0MzhMSd+NPktv81meIG13
         zpAqAywMfmBGA==
Message-ID: <f09425fde83f4b21ee301ef8810c4c29.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230413090128.60119-1-gehao@kylinos.cn>
References: <20230413090128.60119-1-gehao@kylinos.cn>
Subject: Re: [PATCH] mediatek/clk-mt8173-apmixedsys: convert to devm_platform_ioremap_resource
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     gehao@kylinos.cn, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Hao Ge <gehao@kylinos.cn>, matthias.bgg@gmail.com,
        mturquette@baylibre.com
Date:   Thu, 13 Apr 2023 11:40:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hao Ge (2023-04-13 02:01:28)
> diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/m=
ediatek/clk-mt8173-apmixedsys.c
> index a56c5845d07a..fe386bf8225d 100644
> --- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> +++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
> @@ -90,7 +90,7 @@ static int clk_mt8173_apmixed_probe(struct platform_dev=
ice *pdev)
>         struct clk_hw *hw;
>         int r;
> =20
> -       base =3D of_iomap(node, 0);
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
>         if (!base)

This needs to be updated.

>                 return PTR_ERR(base);

And PTR_ERR(NULL) is 0, which is wrong.
