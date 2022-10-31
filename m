Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1D5613E65
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJaTik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiJaTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:38:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37F313EBF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:38:18 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 11F536602846;
        Mon, 31 Oct 2022 19:38:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667245097;
        bh=HcD3iJFYh/LzQMrdgMl5U6VmxC4NvEgAIzxRfRabqx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AU07LhC3To/nN2H7HgWZUnTq5RGaVWJqMPuM/9+0MEfFjKnt5nhmKvxH6gP7SQYNO
         h1WsKY/8z58bnXIGcqNb8d8XocaFgR9vEKFS8L1/Vzr8YdK3dYd9qSf29nFKhLimOb
         +hyRjQ0WPXlMS9bB7cAS00TPJux0y2MCGORmlUKC1BXtuwZVGRVKKv9C9rQThjYt4n
         J7jbIeeo04yV3ol17UUFVwJj2TVXCMjm0e+Vw5qO6eXyUVx7Kuq+TUcw/tUxsNg5nL
         pYq3dAIsG8E7VZMvFm08LjzdCt6HxlAr5JAK+Jt1/vx8s7l9rZzCR5qRgt/c8BLvbl
         05YYDUoi2Amrw==
Date:   Mon, 31 Oct 2022 15:38:10 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ASoC: rt5682: Support dbvdd and ldo1-in supplies
Message-ID: <20221031193810.vdsdndr4ltvhrfel@notapiano>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
 <20221028205540.3197304-7-nfraprado@collabora.com>
 <Y1/JCN+mtlT0r/rw@sirena.org.uk>
 <20221031163140.h63kjpivwg7xpvs3@notapiano>
 <20221031190938.GA3264845-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221031190938.GA3264845-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:09:38PM -0500, Rob Herring wrote:
> On Mon, Oct 31, 2022 at 12:31:40PM -0400, Nícolas F. R. A. Prado wrote:
> > On Mon, Oct 31, 2022 at 01:09:28PM +0000, Mark Brown wrote:
> > > On Fri, Oct 28, 2022 at 04:55:38PM -0400, Nícolas F. R. A. Prado wrote:
> > > 
> > > > @@ -35,6 +35,8 @@ const char *rt5682_supply_names[RT5682_NUM_SUPPLIES] = {
> > > >  	"AVDD",
> > > >  	"MICVDD",
> > > >  	"VBAT",
> > > > +	"dbvdd",
> > > > +	"ldo1-in",
> > > 
> > > Why are we making these inconsistent in style with the other supplies?
> > 
> > In short because the other supplies already have users while these are new ones.
> > My understanding was that new supplies should have lowercase names, following DT
> > convention. But I do see the argument on having them all be consistent for a
> > single driver/binding. If there are no remarks from Rob or Krzysztof I can
> > change it in the next version.
> 
> We want lowercase and consistency... Between the 2, I pick consistency.

We could have both if we converted the existing ones to lowercase first, but as
I mentioned in [1] this requires using devm_regulator_get_optional() before
falling back, which seemed like an abuse of that API and to unnecessarily
complicate the code.

So leaving the existing ones as they are and just keeping the consistency for
the new ones seems like the way forward.

[1] https://lore.kernel.org/all/20221028211224.iiphmwrpqqs27jr4@notapiano/

Thanks,
Nícolas
