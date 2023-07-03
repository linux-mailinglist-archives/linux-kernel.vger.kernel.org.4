Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F410674579C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGCItA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGCIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:48:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFC6E59;
        Mon,  3 Jul 2023 01:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AB7A60E76;
        Mon,  3 Jul 2023 08:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0611C433C8;
        Mon,  3 Jul 2023 08:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688374116;
        bh=pox5/8OU+E0k0USvT7GzuoL1tE4nYDvau0NjWziCQbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QO5q0gD+xg0S2yRaTSvnhQN1rQSHd3GjZR/BSvSF5xkz6zcOhpSknzlG215Zkx8V1
         8v1d/RtC05HMr5F/BsBtEzRd6iS5S9L+yhc3Glx/DuUHH6YdlaokKLWtPnxvbbVqiT
         R5r/TOG61tIwNf/cZ87WVI4Q1lc8Kisxk6Vzle1GYtj9yAxPib85Q3ISjzapugs4H3
         2slsG81RGvle2x2nfzci471SvTPp0apDznCWCf+t7pn5nLQWbFTDEqoN8lQ/YsbJg7
         IbCkh1dwJtggfdSWh8rpKfY1jFVlQsadGyzWELnwwgAVUPZ0EG+oWb8lQU5q+XrtP6
         jg7EQP/EkplYg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qGFEo-0006nE-37;
        Mon, 03 Jul 2023 10:48:51 +0200
Date:   Mon, 3 Jul 2023 10:48:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>, johan+linaro@kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <ZKKLcnosI5jD-IXv@hovoldconsulting.com>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <ZKJ9UrB8FRkLzLc-@hovoldconsulting.com>
 <ZKKA6K44mp_vjwtp@hovoldconsulting.com>
 <877crh76ge.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877crh76ge.wl-tiwai@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 10:19:29AM +0200, Takashi Iwai wrote:
> On Mon, 03 Jul 2023 10:03:52 +0200,
> Johan Hovold wrote:

> > Ok, scratch that. I just hit the race again also with this patch
> > applied:
> > 
> > [   11.815028] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
> > [   11.838667] snd-sc8280xp sound: ASoC: adding FE link failed
> > [   11.838774] snd-sc8280xp sound: ASoC: topology: could not load header: -517
> > [   11.838916] qcom-apm gprsvc:service:2:1: tplg component load failed-517
> > [   11.838996] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
> > [   11.839430] snd-sc8280xp sound: ASoC: failed to instantiate card -22
> > [   11.844801] snd-sc8280xp: probe of sound failed with error -22
> 
> Isn't it rather an issue about the error code passing in qcom driver?
> How about the change like below?

Indeed, and I tested a change like that here:

	https://lore.kernel.org/lkml/ZIHSGf18Aw7htb9o8@hovoldconsulting.com/

but that only seems to make the problem worse currently.

This should probably still be fixed, but I was just hoping that the DAI
numbering could have been the cause for the probe deferral (which then
triggers the other bugs).

Johan
