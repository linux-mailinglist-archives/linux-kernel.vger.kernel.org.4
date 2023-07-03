Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C77456E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGCIFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbjGCIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4744E19A3;
        Mon,  3 Jul 2023 01:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1722660DDA;
        Mon,  3 Jul 2023 08:03:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70354C433C9;
        Mon,  3 Jul 2023 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688371418;
        bh=64oGb5ihfm4X63PYKvuMZKR34aUYooJu4D3Jsi79c0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YARn7hEeYvnYuhmItmaC1E7Nsf/3kr9CeC+L45w+pJDt1I5Q6074Rhul8TwyaQ2eX
         +s9HwxY5eVDIFTUdsNuqnzgiXxZ/nYruWZ5FXub9537nFg5CGCqJipYZR1/xZZK46L
         hPJqX6NV43l9MXwHhuxkrSvBaADp7k19xPtgsSQBlD3vKPxEMR+yZhZaQtCM+6fBxB
         htsZsBJ2fj0yMv4ISRc4kw2J7F+1ymOOjC5QsdV0x2hTmQrKwkC77mEbg+3o1HaaC9
         +qwBWcRapGI7ILMsiWAaSo2iH8GzRIfYFIPiwTnlSXgBnQcmQabWXzj8UVUic0fqp8
         65zeDBgnNK7xQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qGEXI-0006af-2F;
        Mon, 03 Jul 2023 10:03:52 +0200
Date:   Mon, 3 Jul 2023 10:03:52 +0200
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
Message-ID: <ZKKA6K44mp_vjwtp@hovoldconsulting.com>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <ZKJ9UrB8FRkLzLc-@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKJ9UrB8FRkLzLc-@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:48:34AM +0200, Johan Hovold wrote:
> On Wed, Jun 28, 2023 at 10:24:04AM +0100, Srinivas Kandagatla wrote:
> > For some reason we ended up with a setup without this flag.
> > This resulted in inconsistent sound card devices numbers which
> >  are also not starting as expected at dai_link->id.
> >  (Ex: MultiMedia1 pcm ended up with device number 4 instead of 0)
> > 
> > With this patch patch now the MultiMedia1 PCM ends up with device number 0
> > as expected.
> 
> This appears to fix the intermittent probe breakage that I see every
> five boots or so:
> 
> [   11.843320] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
> [   11.867467] snd-sc8280xp sound: ASoC: adding FE link failed
> [   11.867574] snd-sc8280xp sound: ASoC: topology: could not load header: -517
> [   11.867725] qcom-apm gprsvc:service:2:1: tplg component load failed-517
> [   11.867933] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
> [   11.868379] snd-sc8280xp sound: ASoC: failed to instantiate card -22
> [   11.873645] snd-sc8280xp: probe of sound failed with error -22
> 
> and which I've reported here:
> 
> 	https://lore.kernel.org/lkml/ZIHMMFtuDtvdpFAZ@hovoldconsulting.com/
> 
> as unrelated changes in timings resulting from that series made the
> problem much harder (but not impossible) to hit.
> 
> With this fix, I've rebooted 20+ times without hitting the issue once.
> 
> I'm guessing that you found this issue while investigated that probe
> race, Srini? It does look related, and it does seem to make the problem
> go away, but I'm not comfortable claiming that the intermittent probe
> breakage has been resolved without some analysis to back that up.

Ok, scratch that. I just hit the race again also with this patch
applied:

[   11.815028] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
[   11.838667] snd-sc8280xp sound: ASoC: adding FE link failed
[   11.838774] snd-sc8280xp sound: ASoC: topology: could not load header: -517
[   11.838916] qcom-apm gprsvc:service:2:1: tplg component load failed-517
[   11.838996] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
[   11.839430] snd-sc8280xp sound: ASoC: failed to instantiate card -22
[   11.844801] snd-sc8280xp: probe of sound failed with error -22

Sorry about the noise.

Johan
