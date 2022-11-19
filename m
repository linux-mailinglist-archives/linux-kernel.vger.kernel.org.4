Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A03630DBC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbiKSJSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:18:30 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 357A1271A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:18:27 -0800 (PST)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 765282A02A4;
        Sat, 19 Nov 2022 10:18:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1668849506;
        bh=Vt5L0VElcFLbmhh0x4LVugTf29bcONLPlCjevjgvFSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxqePUhEdc0C9R5uhSi+uSJ/g85ULckh94wlPP27t6X8nuCvyvAbpxUIWRuoahfuu
         eO7zx1vYItI4B4YLKAFyGoTjN3jl8oPfhNj3hiS4jdlr7j2/SSq56ihOmpnizwj9JC
         ZDxF8CW4kvQDq7qD+2LlGw16aJqTA4Xkw8FB/qCsBGq6I+JG2miXnT/kA3v7NnMx0R
         wlNqj27wNFIwt+f2Gcp5q90fWxR6IY7+dczbcH7seymKYp1REx45BgSfsVi5YXlI9x
         VQxRI4RZa4v0JIxw4wT0eEv5YQqpKM47wIcpp/qPGa2B1VZoJw0RyOq92GRsXeoCPG
         yr65UEbrXrAPg==
Date:   Sat, 19 Nov 2022 10:18:25 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] iommu: Avoid races around device probe
Message-ID: <Y3ifYR9ZuqQN79vb@8bytes.org>
References: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1946ef9f774851732eed78760a78ec40dbc6d178.1667591503.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 07:51:43PM +0000, Robin Murphy wrote:
> We currently have 3 different ways that __iommu_probe_device() may be
> called, but no real guarantee that multiple callers can't tread on each
> other, especially once asynchronous driver probe gets involved. It would
> likely have taken a fair bit of luck to hit this previously, but commit
> 57365a04c921 ("iommu: Move bus setup to IOMMU device registration") ups
> the odds since now it's not just omap-iommu that may trigger multiple
> bus_iommu_probe() calls in parallel if probing asynchronously.
> 
> Add a lock to ensure we can't try to double-probe a device, and also
> close some possible race windows to make sure we're truly robust against
> trying to double-initialise a group via two different member devices.
> 
> Reported-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/iommu.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)

Applied, thanks Robin.
