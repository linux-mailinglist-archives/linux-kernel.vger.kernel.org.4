Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5036EE62A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbjDYQ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbjDYQ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FC0D307;
        Tue, 25 Apr 2023 09:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE4962699;
        Tue, 25 Apr 2023 16:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B901EC433D2;
        Tue, 25 Apr 2023 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682441782;
        bh=22mPNmkUVHl+VVe7JN/fIv8NuIT+SW8vRSUhM5SEw18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHazUVu7uEXa/CUAumf1vdTfPwZ3kOoIumXwpjEuAww5ie1isrYoXmTIeMKDTnX+1
         3/g2NnbxeyflDVxa48sovr5yskrHJTDf7W6+kwyF1aA826C6+1OFN0MpxHbCFpBnE/
         rAPNmhNyb0GMwrsRLb1A4Eur7t7MlXei+uD8VFBKfEt7AsS4jhwjoDZhnDhC30nNhy
         wVsn+zHStUxjYoaAh6nT+ImJSbKkaCtFqiCMEsTqMuX6yklP/o4LKHESBFF82JiLoC
         QX9qX1oKiyKPuRx/6Q4qw3adV/pjr/Vwxcsa+fhcPjWcBqZrC51UXV8fGnsL6NiXIr
         lzv7Nat3L2f5Q==
Date:   Tue, 25 Apr 2023 18:56:18 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] drm/exynos: fix g2d_open/close helper function
 definitions
Message-ID: <20230425165618.2ztg4mecuvpkdg3a@intel.intel>
References: <20230417210423.2517593-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417210423.2517593-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Apr 17, 2023 at 11:04:11PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The empty stub functions are defined as global functions, which
> causes a warning because of missing prototypes:
> 
> drivers/gpu/drm/exynos/exynos_drm_g2d.h:37:5: error: no previous prototype for 'g2d_open'
> drivers/gpu/drm/exynos/exynos_drm_g2d.h:42:5: error: no previous prototype for 'g2d_close'
> 
> Mark them as 'static inline' to avoid the warning and to make
> them behave as intended.
> 
> Fixes: eb4d9796fa34 ("drm/exynos: g2d: Convert to driver component API")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Cc: <stable@vger.kernel.org> # v4.19+

Reviewed-by: Andi Shyti <andi.shyti@kernel.org> 

Thanks,
Andi
