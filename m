Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18E66960AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBNK0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBNK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:26:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A0B23643;
        Tue, 14 Feb 2023 02:25:59 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50A7C6600013;
        Tue, 14 Feb 2023 10:25:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676370357;
        bh=mfv0qhnO8fr6EAdEvEBRF7gUJfNIE7MQAQr8S57P2A8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cwsqP0Fsp92yfDqP4G+i6amfGYoUrxFRYZObLUBOmcT4VJ7CpeGSd1hDVoC5LDiP2
         SdIYujjKTUzl7HdQkZ3g6dpOH5I1OfI1Mfvxybg1aIwrJgktV+7BgGflyXFSV/bdtu
         mN3vvJpUSyaeYXjItSTh/+I+AbIjREn/gTyVLDuRqc7SgJR2CZzqX3wzONhhocbret
         ftbdbPyuC/sbz55vPKPUtq9jth7IXOVcmyOrUk0yGTJOQplUQL9ecSc+/CExoiWLdT
         2Ufow5R7EeONmDcomLSmYdHS8mdFqBLEIYrSRZUXFjjnnvMY0nXepaL+aQMsxSC1k3
         n/sFFInxX1cFg==
Message-ID: <09401672-3d4b-ef49-83e2-75abdcfb84bb@collabora.com>
Date:   Tue, 14 Feb 2023 11:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/5] arm64: dts: mediatek: Add dtsi files to use rt5682s
 on mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230211002626.454844-1-nfraprado@collabora.com>
 <20230211002626.454844-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230211002626.454844-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/02/23 01:26, Nícolas F. R. A. Prado ha scritto:
> Add a dtsi file for the rt5682s audio codec and another to wire it to be
> used by mt8192's sound card.
> 
> These dtsi files will be used by Spherion rev4 and Hayato rev5-sku2,
> which make use of the rt5682s codec instead of the rt5682 used in
> previous revisions.
> 

I think we're getting too many -audio-x devicetrees here... it's getting somehow
strange: imagine if we had 4 xxxx-audio-xxxx.dtsi for all of the supported
machines in dts/mediatek... that'd be at least *40* more files and would grow at
a quite fast pace. Too much IMO.

Check how I've done it in mt8195-cherry.dtsi, mt8195-cherry-tomato-r{1,2,3}.dts:
I didn't even have to add any mt8195-cherry-audio-xxxx.dtsi.

I understand your reasons for doing that - reducing duplication - but, in my
opinion, duplicating just 3 lines for 4 times is the way to go...
If those 4 files were used in *most MediaTek devicetrees* instead of one single
project, I'd agree with you though :-)

If you can come up with anything better than what I propose... I'd be even happier!

Cheers,
Angelo


