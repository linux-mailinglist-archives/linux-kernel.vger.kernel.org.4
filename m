Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA2361231A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJ2NBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJ2NBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:01:10 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E605FDD0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:01:07 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oolSE-0006ID-NZ; Sat, 29 Oct 2022 15:00:50 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     John Keeping <john@metanate.com>, dri-devel@lists.freedesktop.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH] drm/rockchip: fix fbdev on non-IOMMU devices
Date:   Sat, 29 Oct 2022 15:00:46 +0200
Message-Id: <166704843772.1532410.11915201216204142960.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020181248.2497065-1-john@metanate.com>
References: <20221020181248.2497065-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 19:12:47 +0100, John Keeping wrote:
> When switching to the generic fbdev infrastructure, it was missed that
> framebuffers were created with the alloc_kmap parameter to
> rockchip_gem_create_object() set to true.  The generic infrastructure
> calls this via the .dumb_create() driver operation and thus creates a
> buffer without an associated kmap.
> 
> alloc_kmap only makes a difference on devices without an IOMMU, but when
> it is missing rockchip_gem_prime_vmap() fails and the framebuffer cannot
> be used.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: fix fbdev on non-IOMMU devices
      commit: ab78c74cfc5a3caa2bbb7627cb8f3bca40bb5fb0

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
