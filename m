Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56B60FA56
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiJ0OYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiJ0OYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:24:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CFA17C560;
        Thu, 27 Oct 2022 07:24:05 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 059F366028EA;
        Thu, 27 Oct 2022 15:24:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666880644;
        bh=u7zIRu/8QWohIQBCOgJ696m1CJ5uogOYxUrppj/SchU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l+EOaol1JPNqrtg4feZPQfX8BiKhX1f4VFn/rJ97bUuxFzXRYlt39rsyN6UwwpTT0
         1uV/xQqO73f+O0I9e/yGqB5rIwhhs8dXXqC+4l4YIXkdy6QvS8bpMIE7cOO2AQooQB
         Ei0LJe0d/Bj3js0z1QEXP819dxRZtGt3/plVqFYusHksepXbUnBj0i2XdBpWxrpOfm
         VewvOZXVP3l84zq+M2HGCHT3FP48QnpDBwScyFUd6GvHUcGBy+rGHFG66kNKz1NGh9
         Bdq/9mvkgqQI6JnogXphGntXp+cGo5psFJUxMl3HJXdkvrDkyFS4k673N5MXWY3ksA
         yuJwgu/mSHR4A==
Date:   Thu, 27 Oct 2022 10:23:57 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, kernel@collabora.com,
        Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and
 MICVDD supplies
Message-ID: <20221027142357.fefxa2cjthdza4yw@notapiano>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
 <dcf284c6-dee5-d726-7f8f-c4ff1be99ddb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcf284c6-dee5-d726-7f8f-c4ff1be99ddb@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:06:23PM +0200, AngeloGioacchino Del Regno wrote:
> Il 25/10/22 00:00, Nícolas F. R. A. Prado ha scritto:
> > The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> > already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
> > binding.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> 
> I also don't like these uppercase supply names... I wonder if it's worth changing
> the driver to get "avdd" *or* "AVDD" (so, if "avdd" fails -> backwards compat)...
> 
> ...this way, we can change the devicetree to use the lowercase names without
> breaking abi.
> 
> Of course, this commit would need to be changed to document only the lowercase
> supply names.
> 
> Driver-wise, we have a rt5682s_supply_names array... we could do something like:
> 
> static const char *rt5682s_supply_names_legacy[RT5682S_NUM_SUPPLIES] = {
> 	[RT5682S_SUPPLY_AVDD] = "AVDD",
> 	[RT5682S_SUPPLY_MICVDD] = "MICVDD",
> };
> 
> static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
> 	[RT5682S_SUPPLY_AVDD] = "avdd",
> 	[RT5682S_SUPPLY_MICVDD] = "micvdd",
> };
> 
> for (...) assign_supply_names;
> ret = devm_regulator_bulk_get(...);
> 
> if (ret) {
> 	for (...) assign_legacy_supply_names;
> 	ret = devm_regulator_bulk_get(...)
> 	if (ret)
> 		return ret;
> }
> 
> What do you think?

No one seems opposed to it, so I'll add that to the next version.

Thanks,
Nícolas
