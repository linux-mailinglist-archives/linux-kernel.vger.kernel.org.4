Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A26E426C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjDQIVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 04:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjDQIVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:21:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE0426B2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:21:18 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1poK6b-0001cB-Kj; Mon, 17 Apr 2023 10:20:57 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, Olof Johansson <olof@lixom.net>,
        Chao Wang <D202280639@hust.edu.cn>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Chao Wang <D202280639@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix unwind goto issue
Date:   Mon, 17 Apr 2023 10:20:56 +0200
Message-ID: <6931079.K2JlShyGXD@diego>
In-Reply-To: <20230417030421.2777-1-D202280639@hust.edu.cn>
References: <20230417030421.2777-1-D202280639@hust.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 17. April 2023, 05:04:21 CEST schrieb Chao Wang:
> Smatch complains that
> drivers/iommu/rockchip-iommu.c:1306 rk_iommu_probe() warn: missing unwind goto?
> 
> The rk_iommu_probe function, after obtaining the irq value through
> platform_get_irq, directly returns an error if the returned value
> is negative, without releasing any resources.
> 
> Fix this by adding a new error handling label "err_pm_disable" and
> use a goto statement to redirect to the error handling process. In
> order to preserve the original semantics, set err to the value of irq.
> 
> Fixes: 1aa55ca9b14a ("iommu/rockchip: Move irq request past pm_runtime_enable")
> Signed-off-by: Chao Wang <D202280639@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Looking at the code, that makes a lot of sense.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



