Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6656AAF31
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCEKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:53:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D454C36;
        Sun,  5 Mar 2023 02:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F202C60A77;
        Sun,  5 Mar 2023 10:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E82C433EF;
        Sun,  5 Mar 2023 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678013577;
        bh=PKP8yNwYu5JxGWzHMlkMnanKDHiZpsXtixrITkln+8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlYIUGZx9SiREHG5oJUGfZqD7VCl9Nhfm9RjqbSv1p9tPDSqAgwM2pSfXU9ZVkd9I
         rE3TOkPubiCPTfxAYNd9eOMgEpVB9aVgGeTCZXScqXDIUGj9wkoPIm1bWxTuHqiKl3
         0eKo8rG2NWxg6zABe93r6G5iB+BCsj0wMKyVpX0ki5jRMahe6ZpGp2QKcp3iYB0Qy5
         XygdYjr9oy3y24CDKG9zQtCWSMR94LXHO9gss9ooSnByj6E3QnTSAEqGLngoFgATIT
         qeXOwwv39vklsG0nGywJ6DsTNM0BiAT/uWIpiBdXIQ2K7jdw3CUwwFGKj9f4NPdEZk
         P4V4BP4Y4wmMw==
Date:   Sun, 5 Mar 2023 10:52:51 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 04/10] mfd: rt5033: Fix STAT_MASK, HZ_MASK and AICR
 defines
Message-ID: <20230305105251.GI2574592@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <f66e0d7263519261f0ee8ef32e12b6e81caa42e4.1677620677.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f66e0d7263519261f0ee8ef32e12b6e81caa42e4.1677620677.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023, Jakob Hauser wrote:

> The charger state mask RT5033_CHG_STAT_MASK should be 0x30 [1][2].
> 
> The high impedance mask RT5033_RT_HZ_MASK is actually value 0x02 [3] and is
> assosiated to the RT5033 CHGCTRL1 register [4]. Accordingly also change
> RT5033_CHARGER_HZ_ENABLE to 0x02 to avoid the need of a bit shift upon
> application.
> 
> For input current limiting AICR mode, the define for the 1000 mA step was
> missing [5]. Additionally add the define for DISABLE option. Concerning the
> mask, remove RT5033_AICR_MODE_MASK because there is already
> RT5033_CHGCTRL1_IAICR_MASK further up. They are redundant and the upper one
> makes more sense to have the masks of a register colleted there as an
> overview.
> 
> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L669-L682
> [2] https://github.com/torvalds/linux/blob/v6.0/include/linux/mfd/rt5033-private.h#L59-L62
> [3] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/include/linux/battery/charger/rt5033_charger.h#L44
> [4] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L223
> [5] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/battery/rt5033_charger.c#L278
> 
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  include/linux/mfd/rt5033-private.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
