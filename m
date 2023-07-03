Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEE745C23
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGCMVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjGCMVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF56A1AD;
        Mon,  3 Jul 2023 05:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D47160F05;
        Mon,  3 Jul 2023 12:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C723BC433C7;
        Mon,  3 Jul 2023 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688386866;
        bh=iVpVYys+6HpIG93JCxQUvBWe/5NbR/bCynk6NtjIifE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2vK617R6XxCCO41svbYSKf3ouMwj1fyD898WRlATYojK40HeGQHlMW2yPeRt5q37
         ltn+iRBycdtcpufxn9hTiQse+Wmtz0bTwj5KqkRAElOidoHI+DnkpACnY+7VviNixS
         uOpY/aF61DdUS2PaZUQ1erZnUfhCOKXUOUEBMJUrbmOuGUxk+Jjm9/9R0Qlp6FsToL
         qwpAJAZp+1pHfoV9kWbj/IC8RdHN54aPt+vq0MPBd7PsClfph58N47VSR8BqXmWUwI
         K+54vCmWx/ZBPg+Q89kOfeO43OZ/+LgbL3GweVUC1J4qixnRqk9klGP/TBjdH+2hnk
         a1OoBo3j9dmNw==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qGIYS-0001My-31;
        Mon, 03 Jul 2023 14:21:21 +0200
Date:   Mon, 3 Jul 2023 14:21:20 +0200
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
Message-ID: <ZKK9QASAPdYjaa21@hovoldconsulting.com>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <ZKJ9UrB8FRkLzLc-@hovoldconsulting.com>
 <ZKKA6K44mp_vjwtp@hovoldconsulting.com>
 <877crh76ge.wl-tiwai@suse.de>
 <ZKKLcnosI5jD-IXv@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKKLcnosI5jD-IXv@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 10:48:51AM +0200, Johan Hovold wrote:
> On Mon, Jul 03, 2023 at 10:19:29AM +0200, Takashi Iwai wrote:
> > On Mon, 03 Jul 2023 10:03:52 +0200,
> > Johan Hovold wrote:
> 
> > > Ok, scratch that. I just hit the race again also with this patch
> > > applied:
> > > 
> > > [   11.815028] q6apm-dai 3000000.remoteproc:glink-edge:gpr:service@1:dais: Adding to iommu group 23
> > > [   11.838667] snd-sc8280xp sound: ASoC: adding FE link failed
> > > [   11.838774] snd-sc8280xp sound: ASoC: topology: could not load header: -517
> > > [   11.838916] qcom-apm gprsvc:service:2:1: tplg component load failed-517
> > > [   11.838996] qcom-apm gprsvc:service:2:1: ASoC: error at snd_soc_component_probe on gprsvc:service:2:1: -22
> > > [   11.839430] snd-sc8280xp sound: ASoC: failed to instantiate card -22
> > > [   11.844801] snd-sc8280xp: probe of sound failed with error -22
> > 
> > Isn't it rather an issue about the error code passing in qcom driver?
> > How about the change like below?
> 
> Indeed, and I tested a change like that here:
> 
> 	https://lore.kernel.org/lkml/ZIHSGf18Aw7htb9o8@hovoldconsulting.com/

That link was missing was apparently broken, should have been:

	https://lore.kernel.org/all/ZIHSGf18w7htb9o8@hovoldconsulting.com/
> 
> but that only seems to make the problem worse currently.
> 
> This should probably still be fixed, but I was just hoping that the DAI
> numbering could have been the cause for the probe deferral (which then
> triggers the other bugs).
 
Johan
