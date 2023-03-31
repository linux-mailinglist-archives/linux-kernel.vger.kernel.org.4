Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E2B6D1C5D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjCaJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjCaJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:30:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465AF1B7F4;
        Fri, 31 Mar 2023 02:30:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50BE66603130;
        Fri, 31 Mar 2023 10:29:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680254975;
        bh=lMAebDq17jh7DdNz0cBlqr1fwRmhsP03/MJGfkU1R+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPBOOuTWx/PQ4Jo1UY5Tr8aSNr+DKcHxRpQT9tov4AyHcg8SvcD7zt/LzzgIoDRtB
         w51cc+rm15Z4WQmg1oZ5iDhLV6/JQf7Um3d7mAmyVkIakqT4ucQLvxqHjnqLIE3h2d
         XFJJA6hV5ldZ4z2dnTzMcsEglkbGJQGnAX4SO/dSguxe6zagccaIPi6AQl0VQGCnPu
         3Io9CUJdL140asZCXYIW1mT8jWKx0wxWMO9bRTtHN4qNomLqqcEBHHfHx4KiQuXJiC
         NC3GzF1JzNdu9/J+B/fbWsgpSad5gfrdDFxvyl1fzvpC1wyWs0OpxEDIui4H87FOKZ
         be8yyv1mbztbQ==
Date:   Fri, 31 Mar 2023 11:29:32 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, steven.price@arm.com,
        robh+dt@kernel.org, alyssa.rosenzweig@collabora.com,
        wenst@chromium.org, kernel@collabora.com
Subject: Re: [PATCH v1 RESEND 2/2] drm/panfrost: Add basic support for speed
 binning
Message-ID: <20230331112932.73b39d5a@collabora.com>
In-Reply-To: <fb19c82b-f2bf-7f22-ba5c-e1a1c98f987f@collabora.com>
References: <20230323090822.61766-1-angelogioacchino.delregno@collabora.com>
        <20230323090822.61766-3-angelogioacchino.delregno@collabora.com>
        <5814d779-0635-43fe-3fe8-31c130f05b3a@collabora.com>
        <20230331104914.708b194e@collabora.com>
        <fb19c82b-f2bf-7f22-ba5c-e1a1c98f987f@collabora.com>
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

On Fri, 31 Mar 2023 10:57:46 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
wrote:

> Il 31/03/23 10:49, Boris Brezillon ha scritto:
> > On Fri, 31 Mar 2023 10:11:07 +0200
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > wrote:
> >   
> >> Il 23/03/23 10:08, AngeloGioacchino Del Regno ha scritto:  
> >>> Some SoCs implementing ARM Mali GPUs are subject to speed binning:
> >>> this means that some versions of the same SoC model may need to be
> >>> limited to a slower frequency compared to the other:
> >>> this is being addressed by reading nvmem (usually, an eFuse array)
> >>> containing a number that identifies the speed binning of the chip,
> >>> which is usually related to silicon quality.
> >>>
> >>> To address such situation, add basic support for reading the
> >>> speed-bin through nvmem, as to make it possible to specify the
> >>> supported hardware in the OPP table for GPUs.
> >>> This commit also keeps compatibility with any platform that does
> >>> not specify (and does not even support) speed-binning.
> >>>
> >>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>  
> >>
> >> Hello maintainers,
> >> I've seen that this got archived in the dri-devel patchwork; because of that and
> >> only that, I'm sending this ping to get this patch reviewed.  
> > 
> > Looks good to me. If you can get a DT maintainer to review the binding
> > (Rob?), I'd be happy to queue the series to drm-misc-next.
> >   
> 
> The binding was acked by Krzysztof already... so, just to be sure:
> 
> Krzysztof, can the binding [1] get picked?

Oops, sorry, I didn't realize Krzysztof is a DT maintainer.
