Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657FE74FDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGLDVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjGLDVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EDB93;
        Tue, 11 Jul 2023 20:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613B961628;
        Wed, 12 Jul 2023 03:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01898C433C7;
        Wed, 12 Jul 2023 03:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689132075;
        bh=/NuFIWfEtVjk5MvroN0JIwWzQv+7JB4TBDHgC9DyCxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nsHuyOFlOfGP8W5cNrlZS+JZtz4WNfbJ3xNhO/Diz6kJf1YahQVGjiWGISpV7KKkO
         SirSzT6+Iey/kn0zRhDR5DEKmJRQRDUDYaIOJXh+ahNGgXUyRs/qMWi9Glh+7rhHx3
         XTcq9L/IpBB/hq6c+CgQ4A+aTeOrE3SGjsDTzhzPuJDCEBVcOEdkrR0xBM0ns9TtBs
         tQKqpy6SrlL5py4Ykit+ZGJ/2RIwTeaZHeIPEyg3vqiug1bzHGvpQ8LvFiTbXieuwv
         xAnG92vdQu8FVifLfMdDuJjN3sBdbWU0WzPk+1Wi0aVV4FFcLtH7kVGdpvpv+0dXFJ
         lQF0uJuPrGRSA==
Date:   Tue, 11 Jul 2023 20:21:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3 00/12] net: stmmac: replace boolean fields
 in plat_stmmacenet_data with flags
Message-ID: <20230711202114.5e4f1dcd@kernel.org>
In-Reply-To: <20230710090001.303225-1-brgl@bgdev.pl>
References: <20230710090001.303225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023 10:59:49 +0200 Bartosz Golaszewski wrote:
> As suggested by Jose Abreu: let's drop all 12 boolean fields in
> plat_stmmacenet_data and replace them with a common bitfield.

Peppe, please take a look.
