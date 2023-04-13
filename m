Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F92F6E0AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjDMJzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjDMJzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:55:14 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF9878695
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:55:02 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id A459B243D2F;
        Thu, 13 Apr 2023 11:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681379701;
        bh=rUi0Rcf4zuSRU7BAknFYiQabOjqC/NB+bSBR0uFo6H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ijCfD2tfUkZ9cN7kJuHj4PG4sqS1p1/RjDrWJ2H9tT9qmcFETRc6ZiKVZfp+g75bt
         JUpkhJbrPHtQc8kmRraCP/92u8CVyBBmrZl7PXWcv/HDQ/gFwdGN1s6Y74c6btoLzE
         BX4hOeIEw1Y++3dNsgFZL/PFVSJhjMMDYIXtgFO5DAncLTIyA8R2ACd+ge492SWR0k
         CJTDjlhnzZo8jVwCrOUwJzy4m/WfNy0bcp3M67P8+bbTVtC1DNC+hWFg6cRZzYxqsO
         SJvuO87Nhv8DkiOqWJJzQ6Mtb8cYtfEzAo7YYSVpt9L/B6pYIun2WVZrDPD4zCmyd2
         3xQhce2ZYeloQ==
Date:   Thu, 13 Apr 2023 11:55:00 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Vasant Hegde <vasant.hegde@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu: amd: Set page size bitmap during V2 domain
 allocation
Message-ID: <ZDfRdMUF4o1YA71G@8bytes.org>
References: <20230404072742.1895252-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404072742.1895252-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:27:42AM -0700, Jerry Snitselaar wrote:
> With the addition of the V2 page table support, the domain page size
> bitmap needs to be set prior to iommu core setting up direct mappings
> for reserved regions. When reserved regions are mapped, if this is not
> done, it will be looking at the V1 page size bitmap when determining
> the page size to use in iommu_pgsize(). When it gets into the actual
> amd mapping code, a check of see if the page size is supported can
> fail, because at that point it is checking it against the V2 page size
> bitmap which only supports 4K, 2M, and 1G.
> 
> Add a check to __iommu_domain_alloc() to not override the
> bitmap if it was already set by the iommu ops domain_alloc() code path.
> 
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Fixes: 4db6c41f0946 ("iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API")
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
>  drivers/iommu/amd/iommu.c | 6 ++----
>  drivers/iommu/iommu.c     | 9 +++++++--
>  2 files changed, 9 insertions(+), 6 deletions(-)

Applied, thanks.
