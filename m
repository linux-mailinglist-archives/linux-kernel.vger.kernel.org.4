Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34D72437D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjFFNBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbjFFNBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:01:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB354F4;
        Tue,  6 Jun 2023 06:01:01 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 836906606EBB;
        Tue,  6 Jun 2023 14:00:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686056460;
        bh=5X1vYezIwDbqeMCS78Q98whyEA5uh7OHIVeHGqM+EtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bfbe3+nAwOOs1sT8xUYl78AUiOqTLNLqOgHUc/MMsJpbI2TDRkVIX6ZshuNRESg9i
         CdTefngagGRRzKM4hy1+okSH2ATYC5alLYo+nqBMbCr8XQZc/FeMDRo77evveNN2f4
         BnDSjSwiV0mwF3IkIGbs6zsl/GjEX0rb/SG6NDtMJwajllD3EQWPXu3P9CNUY6WYb5
         +tJAmdnnTF1NlgPxo4erKN7XTd90KoNPywzu47sO77C/9mlBtrAD+e7XMK71xaQtHl
         Vs1bC8qAw/u7GPyFqqkgOHqkpWqAtBQ7NDwl8W9btme5JJ+7PWhae+nF4+OHx+w1sQ
         e9LrCwjcVgdJg==
Date:   Tue, 6 Jun 2023 09:00:54 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz
Message-ID: <0e9667dc-8f91-49a0-903e-6725204e11ad@notapiano>
References: <20230602183515.3778780-1-nfraprado@collabora.com>
 <01c88a42-274c-f8cf-73a6-29741579d9db@collabora.com>
 <4b2fdd36-0871-ecc7-5d64-e088d7f51987@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b2fdd36-0871-ecc7-5d64-e088d7f51987@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:38:42AM +0200, Matthias Brugger wrote:
> 
> 
> On 05/06/2023 10:21, AngeloGioacchino Del Regno wrote:
> > Il 02/06/23 20:35, Nícolas F. R. A. Prado ha scritto:
> > > The capacity-dmips-mhz parameter was miscalculated: this SoC runs
> > > the first (Cortex-A55) cluster at a maximum of 2000MHz and the
> > > second (Cortex-A76) cluster at a maximum of 2200MHz.
> > > 
> > > In order to calculate the right capacity-dmips-mhz, the following
> > > test was performed:
> > > 1. CPUFREQ governor was set to 'performance' on both clusters
> > > 2. Ran dhrystone with 500000000 iterations for 10 times on each cluster
> > > 3. Calculated the mean result for each cluster
> > > 4. Calculated DMIPS/MHz: dmips_mhz = dmips_per_second / cpu_mhz
> > > 5. Scaled results to 1024:
> > >     result_c0 = dmips_mhz_c0 / dmips_mhz_c1 * 1024
> > > 
> > > The mean results for this SoC are:
> > > Cluster 0 (LITTLE): 12016411 Dhry/s
> > > Cluster 1 (BIG): 31702034 Dhry/s
> > > 
> > > The calculated scaled results are:
> > > Cluster 0: 426.953226899238 (rounded to 427)
> > > Cluster 1: 1024
> > > 
> > > Fixes: 48489980e27e ("arm64: dts: Add Mediatek SoC MT8192 and
> > > evaluation board dts and Makefile")
> > > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > 
> > 
> 
> Applied, thanks

Hi Matthias,

this patch doesn't show in your v6.4-next/dts64 branch, while the other patch
you just applied does, so I just wanted to double check it was really applied.

Thanks,
Nícolas
