Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E5074956A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjGFGOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjGFGOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:14:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F1710F2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:14:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 787AE61882
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86ACC433C7;
        Thu,  6 Jul 2023 06:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688624055;
        bh=VF7EajoQhYvqmxOEcoOLJjSq1A7k7YQBhV8Tz0D7gM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J11t8+3rmnuCwBxgU75U8OwLGHb2mVbqY8RGPxIakNjiNFMdqRvt8Yo8L0uNSdINb
         nufZLNutYsTEjmkApL9bJ4sPV9DKWe75wcTA3HDfbPtqC6HuPqmm5ET36q59G9xqRH
         poOp5Mp+YioNqGz3IwjwOgO3F0UhJRKWfoMUqirS4yUKSm+T/Qvh76I+oxPD1XE2He
         Xu4bXAtF6AxiZZNyui8MTxeRE17Bi5TO3RBI4ei1RkC991aB7wEf42CeEQhZtmyClH
         YFnUKsCCi9NyBSiKH3Tuct0voE/1KDBbBwVzVUk7g6eXpisthmgMR2/JFMeMzeyf4Y
         TPo0rR6Yci6FA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qHIGD-00045E-1x;
        Thu, 06 Jul 2023 08:14:38 +0200
Date:   Thu, 6 Jul 2023 08:14:37 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Alex Elder <elder@linaro.org>
Subject: Re: [PATCH 7/8] ASoC: topology: suppress probe deferral errors
Message-ID: <ZKZbzctgLpV-67hJ@hovoldconsulting.com>
References: <20230705123018.30903-1-johan+linaro@kernel.org>
 <20230705123018.30903-8-johan+linaro@kernel.org>
 <ac232872-734f-d192-d46c-555ebe3625c5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac232872-734f-d192-d46c-555ebe3625c5@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:07:22PM +0200, Amadeusz Sławiński wrote:
> On 7/5/2023 2:30 PM, Johan Hovold wrote:
> > Suppress probe deferral error messages when loading topologies and
> > creating frontend links to avoid spamming the logs when a component has
> > not yet been registered:
> > 
> >      snd-sc8280xp sound: ASoC: adding FE link failed
> >      snd-sc8280xp sound: ASoC: topology: could not load header: -517
> > 
> > Note that dev_err_probe() is not used as the topology component can be
> > probed and removed while the underlying platform device remains bound to
> > its driver.
> 
> I'm not sure that I understand that argument... what's wrong with
> dev_err_probe(tplg->dev, err, "ASoC: adding FE link failed\n");
> instead of
> dev_err(tplg->dev, "ASoC: adding FE link failed\n");
> ?

In short, it is not correct to use dev_err_probe() here as this is not a
probe function.

dev_err_probe() is tied to driver core and will specifically allocate
and associate an error message with the struct device on probe
deferrals, which is later freed when the struct device is bound to a
driver (or released).

For ASoC drivers, the struct device is typically bound to a driver long
before the components they register are "probed". I use quotation marks
as this is not probing in the driver model sense of the word and the
underlying struct device is already bound to a driver when the component
is "probed".

> Personally I would prefer dev_err_probe() to be used as it also provides 
> debug message.

Yeah, but it would be conceptually wrong to do so (besides the fact that
it would waste some memory).

Johan
