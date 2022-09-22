Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164265E60F1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiIVL1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiIVL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679CAE11AC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:26:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E3062C98
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E81C433C1;
        Thu, 22 Sep 2022 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663845985;
        bh=r0sKRJGzevBgLu3Rbdi7fUNAHgKJFzt2opqHR0c7spk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iRE4bI8A+0TnU1wE7Y8MT4qGFHaCrSvtI83L17WLv8Efu67EmK61r7AvprBhit1/U
         fr+VL/x0UinsCEj1F7wbkhrvvCD8dcUJXTJhKQxZk+NStLPNKF86qOO++Xl6AOPuND
         cY+4r6dYgdIJuln4W/atj2FZ7zrtzjXW1MuzDufYESpEuu1wYVqGwsiZq9v5lP86mW
         n0qcCkKyFlXs5pbba3kb0fTaswhqW/ia066CwIY8xIKa5CdHp99qSXkaJ8DWqWYSbG
         P4Mu7ocJKB1E8dMCLbk1Zk9bPDgjao1CoOyk2fXQoUa0B6uf6mxGaykpVPw/5a9Q0F
         arknxZp/qNlJw==
Date:   Thu, 22 Sep 2022 19:26:21 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-mediatek@lists.infradead.org, trevor.wu@mediatek.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops
 instead of custom ops
Message-ID: <YyxGXXSp2JD9a6ah@google.com>
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 12:35:02PM +0200, AngeloGioacchino Del Regno wrote:
> -static const struct dev_pm_ops mt8195_mt6359_pm_ops = {
> -	.poweroff = snd_soc_poweroff,
> -	.restore = snd_soc_resume,
> -};
> -
>  static struct platform_driver mt8195_mt6359_driver = {
>  	.driver = {
>  		.name = "mt8195_mt6359",
>  		.of_match_table = mt8195_mt6359_dt_match,
> -		.pm = &mt8195_mt6359_pm_ops,
> +		.pm = &snd_soc_pm_ops,

snd_soc_pm_ops[1] sets some more fields.  I'm not quite sure whether
it would introduce any side effect or not.  Perhaps Trevor could
provide some suggestions.

[1]: https://elixir.bootlin.com/linux/v5.19.10/source/sound/soc/soc-core.c#L2150
