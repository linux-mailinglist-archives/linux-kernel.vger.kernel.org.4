Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC170EB1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjEXCL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjEXCL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C213E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 19:11:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6C9637EF
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB104C4339B;
        Wed, 24 May 2023 02:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684894284;
        bh=kniNgZVPplXlMH2opmkUc/AvVlH7GGFlY5Hs9Bg07hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDdAUsc9NkNemL4s4tKZ5sJf84h5iEC1qpm7ZkLg+kuzpynj87mLY6juS0TFXB++F
         6emUiHXYY0lIhYQYyHLwTjd/wfF/F/gK/d0PFTXIh9TVouCfhG5+IvpYGzVLRKmGcN
         mTPQjQOZT8Lqca+5axder6TV/Bggx7jOynp/mbb8Lhjpeuc0DDv8vcyliff3cc/aTV
         68q/FZckV1KB39vwe7NsO+lfioR74pXfDYWcxv4Ux1JCbv8s7u9Y3uIqlCRvvum/ay
         l9uvhJ62GGxl5scGrE5qvizwTJwNqqqDLJwELRwqHVF4sS5j+1400LdY0MTFwe8d8v
         Vh/aHz1DFqoXw==
Date:   Wed, 24 May 2023 10:11:19 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Robert Foss <rfoss@kernel.org>, Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonas Karlman <jonas@kwiboo.se>, owen <qwt9588@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, kernel@collabora.com,
        Xin Ji <xji@analogixsemi.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, tzungbi@kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: Prevent endless probe loop
Message-ID: <ZG1yR9CYXzEPg5TJ@google.com>
References: <20230518193902.891121-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230518193902.891121-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 03:39:02PM -0400, Nícolas F. R. A. Prado wrote:
> Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through aux channel")
> Fixes: 269332997a16 ("drm/bridge: anx7625: Return -EPROBE_DEFER if the dsi host was not found")
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested-by: Tzung-Bi Shih <tzungbi@kernel.org>

The patch can fix the "login" test failures observed on
mt8183-kukui-jacuzzi-juniper-sku16 and mt8192-asurada-spherion-r0 in
kernelci[1].

[1]: https://linux.kernelci.org/test/job/chrome-platform/branch/for-kernelci/kernel/v6.4-rc1-3-g4b9abbc132b86/plan/cros-ec/
