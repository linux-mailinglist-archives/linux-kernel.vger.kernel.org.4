Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6831C74565F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGCHsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGCHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF61C2;
        Mon,  3 Jul 2023 00:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84D160DDF;
        Mon,  3 Jul 2023 07:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2891AC433C9;
        Mon,  3 Jul 2023 07:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688370500;
        bh=RNMHeuYF/T054Bixv9qGLbviyZ5intw9e4cOmr/ZaUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sT0zp/0cY+MBAHRS4qTxPT/Rk6jXkyvtsclI8ywOR29Ym6ZfEAbf9YtSn3hfavLwK
         jCDgpaAMM715SEEGFCHVagvrP2fmSYUiEz0FEmvS5dAfDMPs1gaBHxIw9gG2B9UVEc
         3bZzXfy348jOwhMY7lihk3v6v7qi+ptq/j+aruDT0fmVmEwKoIvqI1A2r58HkGZq7k
         vuOvIPrVl+EDIpn/Kc+/DN5ycigmNiQDRl60mrCHypIwfPJ4ngRO9dap89YH1zsFDY
         cuh27CGcUikP+NHbH+Z7Qb7FoMexlN53g+1JbGGDZj/SvYLjdxvHp9Lps/GWaz9TT8
         Vguv1FJajJL9Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qGEIU-0007iB-0x;
        Mon, 03 Jul 2023 09:48:34 +0200
Date:   Mon, 3 Jul 2023 09:48:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <ZKJ9UrB8FRkLzLc-@hovoldconsulting.com>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 10:24:04AM +0100, Srinivas Kandagatla wrote:
> For some reason we ended up with a setup without this flag.
> This resulted in inconsistent sound card devices numbers which
>  are also not starting as expected at dai_link->id.
>  (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)
> 
> With this patch patch now the MultiMedia1 PCM ends up with device number 0
> as expected.

This appears to fix the intermittent probe breakage that I see every
five boots or so:

[   11.843320] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
[   11.867467] snd-sc8280xp sound: ASoC: adding FE link failed
[   11.867574] snd-sc8280xp sound: ASoC: topology: could not load header: -517
[   11.867725] qcom-apm gprsvc:service:2:1: tplg component load failed-517
[   11.867933] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
[   11.868379] snd-sc8280xp sound: ASoC: failed to instantiate card -22
[   11.873645] snd-sc8280xp: probe of sound failed with error -22

and which I've reported here:

	https://lore.kernel.org/lkml/ZIHMMFtuDtvdpFAZ@hovoldconsulting.com/

as unrelated changes in timings resulting from that series made the
problem much harder (but not impossible) to hit.

With this fix, I've rebooted 20+ times without hitting the issue once.

I'm guessing that you found this issue while investigated that probe
race, Srini? It does look related, and it does seem to make the problem
go away, but I'm not comfortable claiming that the intermittent probe
breakage has been resolved without some analysis to back that up.

> Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
> Cc: <Stable@vger.kernel.org>

I noticed that Mark dropped this to avoid regressions in stable, but if
this indeed fixes the probe race then we may want to consider
backporting it after all.

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/qdsp6/q6apm-dai.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
> index 5eb0b864c740..c90db6daabbd 100644
> --- a/sound/soc/qcom/qdsp6/q6apm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
> @@ -840,6 +840,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
>  	.pointer	= q6apm_dai_pointer,
>  	.trigger	= q6apm_dai_trigger,
>  	.compress_ops	= &q6apm_dai_compress_ops,
> +	.use_dai_pcm_id = true,
>  };
>  
>  static int q6apm_dai_probe(struct platform_device *pdev)

Johan
