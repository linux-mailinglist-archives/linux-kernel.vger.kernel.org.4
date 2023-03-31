Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83396D1CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCaJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjCaJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:47:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3DF1EA01;
        Fri, 31 Mar 2023 02:46:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1FC26603130;
        Fri, 31 Mar 2023 10:46:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680255981;
        bh=P67dJp8jlhGIoFrtYFrtXg/5E26fTlL2SNAKeKDupvU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WOPz8ggTHTlcizmA4vPA6aNGDVNqrdxZxS+U9Sv12ItQKcuKtmEP62ZDuDDAojp5q
         Am6LYmO4ZBS5YXO9JW4xEXZH3Axoup1DMleqG+jM4YNDwVmPsvL4QDTnoew98aR66d
         S//ebMyCRdXWt48U49XgqmRL9DuoCNnkPrH5Y/W4R1YK3g4OP/60IalNxQ5Z2K+eI6
         EoCMLnNweohHB+in5mvjAVaMqQBNyciyhe+AcsMZfGgxkCCFwf53PC/d6q5e+P4dMl
         JG74KjlnAFVrliJzVi85iz6+NYrYpsWUW+D5YCyGCy2dBLlcmLTOJ3tbDZmouxcWGD
         AT2GoIqE1Wwug==
Date:   Fri, 31 Mar 2023 11:46:17 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 RESEND 2/2] drm/panfrost: Add basic support for speed
 binning
Message-ID: <20230331114617.6932e609@collabora.com>
In-Reply-To: <5814d779-0635-43fe-3fe8-31c130f05b3a@collabora.com>
References: <20230323090822.61766-1-angelogioacchino.delregno@collabora.com>
        <20230323090822.61766-3-angelogioacchino.delregno@collabora.com>
        <5814d779-0635-43fe-3fe8-31c130f05b3a@collabora.com>
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

On Fri, 31 Mar 2023 10:11:07 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> Il 23/03/23 10:08, AngeloGioacchino Del Regno ha scritto:
> > Some SoCs implementing ARM Mali GPUs are subject to speed binning:
> > this means that some versions of the same SoC model may need to be
> > limited to a slower frequency compared to the other:
> > this is being addressed by reading nvmem (usually, an eFuse array)
> > containing a number that identifies the speed binning of the chip,
> > which is usually related to silicon quality.
> > 
> > To address such situation, add basic support for reading the
> > speed-bin through nvmem, as to make it possible to specify the
> > supported hardware in the OPP table for GPUs.
> > This commit also keeps compatibility with any platform that does
> > not specify (and does not even support) speed-binning.
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>  
> 
> Hello maintainers,
> I've seen that this got archived in the dri-devel patchwork; because of that and
> only that, I'm sending this ping to get this patch reviewed.

Series queued to drm-misc-next.
