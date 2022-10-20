Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C1E605953
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJTIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJTIH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:07:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E22316C23F;
        Thu, 20 Oct 2022 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qBH+AWbAo+Gl0uKNfNEy4P9h6AZPNyWEVK1hOo2IV6w=; b=MHhEfsRBQHbqqUcVBr37yDxzsW
        ZbBcLbwkEVE1a4iMe9iSA1oA4WJtrXmv9JO8iaYhJtMDHDEFAe+7x6r6+W/jLF+O1EjQu7xGdz9/f
        OMCBgrx2hVpIYCWG8puROVR9S7EDyd52t5+PqTpahy1URTcNGHf9hSBsRLOU5GEEOL0DssY4A6zNf
        E+YsaqM2q2/LOm0UI9ZeheHPVfNFaLNeh48/OOgK4U8yB3bXFOVJkcSo+pCR+V1yAWOko7w27dUyu
        SAipytc9aW92io99feQO2MtRzBMaU6ZiZ7T/E1VHtkzKzViWEO4aeWuzrJ7lWZrLrpXfeFiwcn4iM
        ZkMJS7eQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olQak-00C4EV-Es; Thu, 20 Oct 2022 08:07:50 +0000
Date:   Thu, 20 Oct 2022 01:07:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [RFC 1/6] s390/ism: Set DMA coherent mask
Message-ID: <Y1EB1pvWkoHXQh+a@infradead.org>
References: <20221019144435.369902-1-schnelle@linux.ibm.com>
 <20221019144435.369902-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019144435.369902-2-schnelle@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 04:44:30PM +0200, Niklas Schnelle wrote:
>  	if (ret)
>  		goto err_resource;
>  
> +	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));

Nit:  but you could also just replace the call to dma_set_mask abobe with
a call to dma_set_mask_and_coherent.
