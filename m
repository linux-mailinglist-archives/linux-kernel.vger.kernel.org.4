Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB16A2215
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjBXTHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjBXTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:07:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF32E0E2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:07:04 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A2E326602FCE;
        Fri, 24 Feb 2023 19:07:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677265622;
        bh=CCW4naAHvfl4tjBL1Fqp4N6OXlt0PApFtXxoADlWb68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZnwcqKqjUfDZPu0RLuyMr6gR4w84I1K+tAaBLoztEfEqXZq0Z0vfwgpYy/xmYPUOp
         K5GPK9VN2ekdlb1iof/C3NeauEhO9uzh60IWL/k0rxvBJIBFFnZ/h8z7XomRVjWfdG
         ue1167sxgj6A+Xv6TaZtt3WXQTbPOp9OJOFtvFI7bVEi8GsfemGBzlx3G2bfoQYNbz
         SKH8oEl3/aUqbFfWFNj0OCREI3MmDWkO/7AO7LIdg5gM5jpTwqIrd/FgxgxbeW59Fz
         wGAt6i/WIhdHYDXeiVL0dGXLhhcP1RZ/oiIbskcSWTKrTND+dkaEUs5DTLZ4+YBcHf
         Ia1TkwtumA6Ow==
Date:   Fri, 24 Feb 2023 14:06:57 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: mt8192: Remove spammy log messages
Message-ID: <20230224190657.edrvkg22gz5gff4g@notapiano>
References: <20230223-asoc-mt8192-quick-fixes-v1-0-9a85f90368e1@kernel.org>
 <20230223-asoc-mt8192-quick-fixes-v1-1-9a85f90368e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230223-asoc-mt8192-quick-fixes-v1-1-9a85f90368e1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:03:55PM +0000, Mark Brown wrote:
> There are a lot of info level log messages in the mt8192 ADDA driver which
> are trivially triggerable from userspace, many in normal operation. Remove
> these to avoid spamming the console.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Probably the spammiest messages are 

[   33.881459] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_runtime_resume()
[   33.889320] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_enable_clock()
[   34.029456] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_runtime_suspend()
[   34.041718] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mt8192_afe_disable_clock()

from mt8192-afe-pcm.c, so I think it would make sense to get rid of those in
this commit as well.

Way less spammy, but there are also

[  176.209790] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_dai_tdm_hw_params(), id 43, rate 48000, channels 2, format 6, mclk_rate 24576000, bck_rate 3072000
[  176.224149] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_dai_tdm_hw_params(), out_channels_per_sdata = 2
[  180.272153] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_tdm_en_event(), name TDM_EN, event 0x8
[  180.281462] mt8192-audio 11210000.syscon:mt8192-afe-pcm: mtk_tdm_bck_en_event(), name TDM_BCK, event 0x8, dai_id 43

from mt8192-dai-tdm.c.

Anyway, if you prefer to keep only changes in the ADDA driver for this commit
that's fine too, and I can send another patch removing these other ones later.

Either way,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
