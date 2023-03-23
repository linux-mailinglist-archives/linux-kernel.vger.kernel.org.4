Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB856C6532
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjCWKfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjCWKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:34:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194543B23B;
        Thu, 23 Mar 2023 03:31:17 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F315B6600880;
        Thu, 23 Mar 2023 10:31:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679567473;
        bh=+nm2bNNzHBVf9VlMG8H7LfVJnc2HYpp4Jv5fZk9O/P0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DmcXxUHsBgzcjkPlqCyk9JvYYX0h/4JWd1Yv3VEttg902d9MkJzptLUJji4fhsKOK
         GncwT/heO9DpacKfQEdTh+6I8oRR17JiT9tIxPRO6fLHBYy+fUHzbnpbJq0XfU98Eb
         laKTbSQhEboyfk3tJz8OC3Va5Pinz9gKnlXrGKWhHz9CFB9Kb5hiDK9KbY1plYATfg
         i+ZasWGE7SUHph8GGuNbXY+2Psi9TNtsD2NEbe/4mw3MS9ZgDxDulvNupUDqPrxtbo
         oEzpqLwF3n/2bqtJCo90JAWVMtqVlVa9Xmea6c5ER62ow71xaFs3DSglMmCViTPr29
         Feulyon4prtOQ==
Date:   Thu, 23 Mar 2023 11:31:09 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        steven.price@arm.com, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org,
        alyssa.rosenzweig@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        wenst@chromium.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/12] Panfrost: Improve and add MediaTek SoCs
 support
Message-ID: <20230323113109.0a611095@collabora.com>
In-Reply-To: <0800ffeb-c7c4-1671-173e-1529b8eeb12c@collabora.com>
References: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
        <0800ffeb-c7c4-1671-173e-1529b8eeb12c@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023 09:24:06 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> Il 16/03/23 11:20, AngeloGioacchino Del Regno ha scritto:
> > Changes in v5:
> >   - Changed minItems for power-domain-names in base schema as
> >     suggested by Rob
> > 
> > Changes in v4:
> >   - Refactored power-domains and power-domain-names exclusions as
> >     suggested by Krzysztof
> >   - Small changes in MT8192 bindings addition
> > 
> > Changes in v3:
> >   - Changed MT8186 bindings to declare only two power domains
> >   - Added a commit introducing MT8186 specific platform data to
> >     panfrost_drv
> > 
> > Changes in v2:
> >   - Add power-domain-names commit from Chen-Yu to the series
> >   - Kept sram-supply in base schema, overridden for non-MediaTek
> >   - Added Reviewed-by tags from Steven Price to the driver commits
> >     (as released in reply to v1's cover letter - thanks!)
> > 
> > This series adds support for new MediaTek SoCs (MT8186/MT8192/MT8195)
> > and improves MT8183 support: since the mtk-regulator-coupler driver
> > was picked, it is now useless for Panfrost to look for, and manage,
> > two regulators (GPU Vcore and GPU SRAM) on MediaTek;
> > 
> > The aforementioned driver will take care of keeping the voltage
> > relation (/constraints) of the two regulators on its own when a
> > voltage change request is sent to the Vcore, solving the old time
> > issue with not working DVFS on Panfrost+MediaTek (due to devfreq
> > supporting only single regulator).
> > 
> > In the specific case of MT8183, in order to not break the ABI, it
> > was necessary to add a new compatible for enabling DVFS.
> > 
> > Alyssa Rosenzweig (3):
> >    drm/panfrost: Increase MAX_PM_DOMAINS to 5
> >    drm/panfrost: Add the MT8192 GPU ID
> >    drm/panfrost: Add mediatek,mt8192-mali compatible
> > 
> > AngeloGioacchino Del Regno (9):
> >    dt-bindings: gpu: mali-bifrost: Split out MediaTek power-domains
> >      variation
> >    dt-bindings: gpu: mali-bifrost: Set power-domains maxItems to 5
> >    dt-bindings: gpu: mali-bifrost: Fix power-domain-names validation
> >    dt-bindings: gpu: mali-bifrost: Add sub-schema for MT8192's power
> >      domains
> >    dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
> >    dt-bindings: gpu: mali-bifrost: Add support for MediaTek MT8186
> >    dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
> >    drm/panfrost: Add new compatible for Mali on the MT8183 SoC
> >    drm/panfrost: Add support for Mali on the MT8186 SoC
> > 
> >   .../bindings/gpu/arm,mali-bifrost.yaml        | 80 ++++++++++++++++++-
> >   drivers/gpu/drm/panfrost/panfrost_device.h    |  2 +-
> >   drivers/gpu/drm/panfrost/panfrost_drv.c       | 37 +++++++++
> >   drivers/gpu/drm/panfrost/panfrost_gpu.c       |  8 ++
> >   4 files changed, 123 insertions(+), 4 deletions(-)
> >   
> 
> Hello maintainers,
> 
> this series is fully tested, fully reviewed and fully ready.
> 
> Can anyone please pick it ASAP, so that we can finally get GPU support
> on MediaTek SoCs (including lots of Chromebooks)?

Queued to drm-misc-next.

Thanks,

Boris
