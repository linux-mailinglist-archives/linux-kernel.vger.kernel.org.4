Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77D6C4A09
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCVMNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCVMNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:13:40 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D02BE2FCE0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:13:37 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 3AEBC242D42;
        Wed, 22 Mar 2023 13:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1679487216;
        bh=gCT3/GCid8ybEXIa86EV6OCmCov2osg5/Ckg0CtX+PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCJ6g4L6pOXe8VkL7dufhOKQmtZ0mG6GnK7SGtj/J4pGhqEiX8xuGtHqqiBZ3MHSv
         S6F9SGZyAjkoAlNMH6l+ziB8f0RS4JiQhLJN2rQD/VwK1aBV5TvUIWtBkKOplw4vZd
         aVMvsRMsSKEd1aSv2IWjJjSLSCXdE1kdGGyQ3ymZBTQac7hadHjn+kSZb6ryVx9U2k
         EEyWussci8Qv+GuNRo/NYv6GI9RC6lroODKLTdttQ/KDK2JY3lK6RHR6rYRyt4KJjj
         kcsVHJbQXsHDn2RrGAk02veu82kwZqEnpSRdxesDgL52T25sV9ZWOMK4398CJTgdcU
         SNMWMZ7P2X14w==
Date:   Wed, 22 Mar 2023 13:13:34 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 34/36] iommu: make the pointer to struct bus_type constant
Message-ID: <ZBrw7ounuXyeUitT@8bytes.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-34-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313182918.1312597-34-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 07:29:16PM +0100, Greg Kroah-Hartman wrote:
> A number of iommu functions take a struct bus_type * and never modify
> the data passed in, so make them all const * as that is what the driver
> core is expecting to have passed into as well.
> 
> This is a step toward making all struct bus_type pointers constant in
> the kernel.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu@lists.linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.

This will probably cause conflicts in linux-next, but anyway, those
should be easy to resolve. So

Acked-by: Joerg Roedel <jroedel@suse.de>

