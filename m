Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D0A689477
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjBCJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjBCJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:56:25 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E845712C6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:56:24 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id BB7B9223E73;
        Fri,  3 Feb 2023 10:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1675418183;
        bh=3XqqievITw2t2QG1VwV+Emtnj2p5q/klm0HM7CYydoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQ55Ae8f6qZltkzapqlC1R0Lsz+kmr+C4OjHZQeHmTNOPC0ANU2Ue1neqVWMl99eY
         +nbBi7pqTcUEeR8p4kRpdwUa+TKdzLtsisMb1ASTyKTU8XdMFceaPpmN6h8HnTHN0N
         2zciLEBxdMu/Otln2qCwjHJYnkV4L2nbFxGtzaNUHo6axcZr/XcSbarmgMYo0JkUeR
         FT3X5dZlrf07UMoxhBd/dote/Coksgxge11kLbgbFh1z69xQm/agecUV85ZA6io1Jt
         Eh/65jFF83cZ9nTC2WWJ4Qsdkb0vT5Svd9SM5KZ3QuN+rSYPsj+tqm4QVgI+HRp+Sa
         JqS/VmTTB+zfQ==
Date:   Fri, 3 Feb 2023 10:56:22 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: Fix apple_dart_device_group for PCI groups
Message-ID: <Y9zaRgki00RypvvC@8bytes.org>
References: <20230128113532.94651-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128113532.94651-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 12:35:32PM +0100, Sven Peter wrote:
> pci_device_group() can return an already existing IOMMU group if the PCI
> device's pagetables have to be shared with another one due to bus
> toplogy, isolation features and/or DMA alias quirks.
> apple_dart_device_group() however assumes that the group has just been
> created and overwrites its iommudata which will eventually lead to
> apple_dart_release_group leaving stale entries in sid2group.
> Fix that by merging the iommudata if the returned group already exists.
> 
> Fixes: f0b636804c7c ("iommu/dart: Clear sid2group entry when a group is freed")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 51 ++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)

Applied, thanks.
