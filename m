Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D434260C9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbiJYKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiJYKOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:14:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25008183E23;
        Tue, 25 Oct 2022 03:06:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 576B66600363;
        Tue, 25 Oct 2022 11:06:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666692386;
        bh=VUGneu/GkKsEmT+PsR4f+B8IGy/eQwLdVzDz2FlK9lc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iOlw4dlTjzXRVQ1CT2YdYh77UHzv1fjxXQd5xg4emPrpVJc/2t++4xZYC8XA3BDPU
         UBTj7AMjXsbclKU3CP8qhVXAuFdoJxcW5qgbK+IAiTwmz+55/LdbwFTwx9wCInlBoa
         FxfMnPUv/fSYvpiXfnd05I+kLzzvugqV3AduZyvdbjqGlZhqnmGZTpMpAiuZY8sG9g
         JZ3dtrHD0kIdGjaBwvQU2gEIQaV9oMioeJXnk8WsYV+eyP+LFUzXBcxxBGL14+l2PH
         6DPxutnTohLkzhbfocvwg1bb9Qas69D66ofJOsDKb/rymnR86W6/ga8dnLR2wei41r
         IRzWN9T22iBfg==
Message-ID: <dcf284c6-dee5-d726-7f8f-c4ff1be99ddb@collabora.com>
Date:   Tue, 25 Oct 2022 12:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/4] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and
 MICVDD supplies
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-3-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024220015.1759428-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/22 00:00, Nícolas F. R. A. Prado ha scritto:
> The rt5682s codec can have two supplies: AVDD and MICVDD. They are
> already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
> binding.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

I also don't like these uppercase supply names... I wonder if it's worth changing
the driver to get "avdd" *or* "AVDD" (so, if "avdd" fails -> backwards compat)...

...this way, we can change the devicetree to use the lowercase names without
breaking abi.

Of course, this commit would need to be changed to document only the lowercase
supply names.

Driver-wise, we have a rt5682s_supply_names array... we could do something like:

static const char *rt5682s_supply_names_legacy[RT5682S_NUM_SUPPLIES] = {
	[RT5682S_SUPPLY_AVDD] = "AVDD",
	[RT5682S_SUPPLY_MICVDD] = "MICVDD",
};

static const char *rt5682s_supply_names[RT5682S_NUM_SUPPLIES] = {
	[RT5682S_SUPPLY_AVDD] = "avdd",
	[RT5682S_SUPPLY_MICVDD] = "micvdd",
};

for (...) assign_supply_names;
ret = devm_regulator_bulk_get(...);

if (ret) {
	for (...) assign_legacy_supply_names;
	ret = devm_regulator_bulk_get(...)
	if (ret)
		return ret;
}

What do you think?

Cheers,
Angelo
