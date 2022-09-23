Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EE5E7339
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiIWFEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIWFEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCFD126B45
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:03:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB4E4B8281B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 05:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D20C433D6;
        Fri, 23 Sep 2022 05:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663909435;
        bh=PHDr+wDiM2EHB4+LpuPtHojr+ixo/WuKiAKue3B1Nfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ya1OHf3/RA+A8h42XFYRJphF4JmKCzrDQkXDrHhrDiGzlqT5iYI5c0ykeQk4EpOSy
         ybbRVf2BEbAIMLdh8wnG5qPJgRoNnanTkb6Eb4aUZwGoNHatXt1K93cKbna0b21Ray
         Ajt4d713ZczqW52OZH+Z8EKjCkVSEpSwCA6HKv2Ri5IXexFTiUoGh/SUStQ2gHWgMn
         H/tWvjGriRsgsyc6aPIRQSYyjtu44u7shF/LYFP/0btftWWeGEa/DSMULezfbZdFfU
         /LzDvUWHBAup7Xoii7IGMxuEmSZZnkZMIxBFEu6V9f9nq0IBmTB5FZp7vQ0+DUAHSW
         /EsRfFQ/6FEtg==
Date:   Fri, 23 Sep 2022 13:03:51 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ASoC: mediatek: mt8195-mt6359: Use snd_soc_pm_ops
 instead of custom ops
Message-ID: <Yy0+N13mJlGZE9E4@google.com>
References: <20220922103502.49981-1-angelogioacchino.delregno@collabora.com>
 <YyxGXXSp2JD9a6ah@google.com>
 <YyxjZ9nCBdVovkVs@sirena.org.uk>
 <ce4a6e7f-dee3-c260-bd42-bc77927916e8@collabora.com>
 <978af4cc1a8bfa92675bb201947cfdac1e5429f1.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978af4cc1a8bfa92675bb201947cfdac1e5429f1.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:39:54PM +0800, Trevor Wu wrote:
> On Thu, 2022-09-22 at 16:10 +0200, AngeloGioacchino Del Regno wrote:
> > Il 22/09/22 15:30, Mark Brown ha scritto:
> > > On Thu, Sep 22, 2022 at 07:26:21PM +0800, Tzung-Bi Shih wrote:
> > > 
> > > > snd_soc_pm_ops[1] sets some more fields.  I'm not quite sure
> > > > whether
> > > > it would introduce any side effect or not.  Perhaps Trevor could
> > > > provide some suggestions.
> > > 
> > > If it does it should be to fix isues rather than introduce new
> > > problems - I suspect the other operations just don't work
> > > currently.
> > 
> >  From my upstream tests, this didn't introduce any issues, that's why
> > I've
> > sent this patch.
> > 
> > In any case, let's check with Trevor, just as to be extremely sure,
> > but please
> > use an upstream kernel for eventual tests, as there are quite a bit
> > of changes
> > between 5.10 and current upstream.
> > 
> > Cheers,
> > Angelo
> 
> I think it's not a big risk if Angelo already did the test and
> snd_soc_pm_ops is also used in MT8186.
> I can help do more tests on 5.10 when the patch is back to chromium in
> the future.
> MTK also have a plan to support complete suspend/resume functionality
> in MT8195. If Tzung-bi has concerns about the patch, I can help submit
> the patch at the time.

I have no further concern as long as you guys are also aware of the change.
