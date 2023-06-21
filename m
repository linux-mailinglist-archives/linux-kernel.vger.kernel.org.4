Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4891738D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjFURqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjFURqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C9B1BDF;
        Wed, 21 Jun 2023 10:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D163C60FFA;
        Wed, 21 Jun 2023 17:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F718C433C8;
        Wed, 21 Jun 2023 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369588;
        bh=rTVtvaUBO4z3cuonHHr5lxCE9f6EkiuFLQwsHlt5v4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqw1oQmaLbVt5jRzb2yOcPrvwkMyXcSXitr+ykMirpGBfjOebyxml4t4HTVdfXb9s
         yMZnM2soMSsqGCd2yt7Nt3A2uzebZzj83onUa3SNTb9OMKjiQQCMp2qXT9hydb7SMu
         CV2I4K0VrO1jIJIcIoje6E7plJoIPxKbakdBLiHDVhVXFk0viv79Yxap0vEMfw3BBX
         t+C7ycMmW1k5K6NEwz1AyEmi+gNrKvT8k1STWKpjZi63IR6YU1cda556ueAZ55r9um
         iSVqE7QOywQ8CpBbHomTmTG/5rDkSnrgYkLmEho2/c845QwqFdnSfsOf0dt54QYAyX
         VG+lbTy+kXPmA==
Date:   Wed, 21 Jun 2023 18:46:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mfd: stmpe: Fix a corner case in stmpe_probe()
Message-ID: <20230621174623.GP10378@google.com>
References: <8de3aaf297931d655b9ad6aed548f4de8b85425a.1686998575.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8de3aaf297931d655b9ad6aed548f4de8b85425a.1686998575.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2023, Christophe JAILLET wrote:

> In stmpe_probe(), if some regulator_enable() calls fail, probing continues
> and there is only a dev_warn().
> 
> So, if stmpe_probe() is called the regulator may not be enabled. It is
> cleaner to test it before calling regulator_disable() in the remove
> function.
> 
> Fixes: 9c9e321455fb ("mfd: stmpe: add optional regulators")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/mfd/stmpe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
