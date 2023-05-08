Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B636FA16D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjEHHsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjEHHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A646A5FDA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:48:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E86662040
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BBEC433D2;
        Mon,  8 May 2023 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683532121;
        bh=G9HdM1QJziMzpOUvCuJGpW3lxswdvThqfd4Irkdvc78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFLrL35w0Msv/Ut1ZxVUaSrWlMrdhAImX35jJa+vNdjFsaccU4K/Tmt46yGGcK/ab
         ShGUwgzPb0DXnrbmb7y+amP1uv5G7AULBvvpwkxkCI8F/TrVO4X4k20OUy7LQhW354
         VQpewPMkAJfEPC2bALgNFB95LK7BWdgiYlJlZMw70TcptzYNU6cjXZ08Hv2+wil21O
         sidC919sGP4/xfCnp+E8wq+yejJrbmLzoCSv8Fv6Ym+qsqV0c+COSzCe4/6DDVgAN6
         SxgSWWuqvXXfvXnWitxgoPYDeztdtBvZsyFeoeZX5IbsFy458+BM+3hXZi1UEKlP5S
         A2B38BMSM4HgQ==
Date:   Mon, 8 May 2023 13:18:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tom Rix <trix@redhat.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, chunfeng.yun@mediatek.com,
        kishon@kernel.org, angelogioacchino.delregno@collabora.com,
        nathan@kernel.org, ndesaulniers@google.com, granquet@baylibre.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] phy: mediatek: fix returning garbage
Message-ID: <ZFipVfhLVyye/eud@matsya>
References: <20230414122253.3171524-1-trix@redhat.com>
 <ZFTMPWp8LhwA9uHz@matsya>
 <db9c3190-28d8-199f-f4f0-a12524d0451e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9c3190-28d8-199f-f4f0-a12524d0451e@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-23, 17:37, Matthias Brugger wrote:
> 
> 
> On 05/05/2023 11:28, Vinod Koul wrote:
> > On 14-04-23, 08:22, Tom Rix wrote:
> > > clang reports
> > > drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
> > >    'ret' is uninitialized when used here [-Werror,-Wuninitialized]
> > >          if (ret)
> > >              ^~~
> > > ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.
> > 
> > I have applied "phy: mediatek: hdmi: mt8195: fix uninitialized variable
> > usage in pll_calc"
> 
> Thanks Vinod, that was on my list for today as well. I was a bit puzzled
> because you took the patch that added it, but I wasn't sure if you would
> take the fix. How do you want to handle things like this in the future?

Fixes should be sent as Fixes patch

-- 
~Vinod
