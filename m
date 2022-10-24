Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED4060B96A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiJXUKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiJXUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:08:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0D8E79A;
        Mon, 24 Oct 2022 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R2CozcFHwiChhVIqs9e1K7KGsaZbKqtzxGeJtPv9o4I=; b=kIseVJ2df1bajoZTbCM6NTSzk3
        aAMcxXbtdOSJSoQJcJ5AwEtJfcHjIKlO54CzW1473JnXWY+4pbRjbCnbhZkHDnFMSYQI16SHsQ0Un
        C5HUIGuZI3Vj+yi1EJ73edNhXPpC7mWC/77d38X96cylJ45BjMRtPVupLNQ3MekhFWX1tMFRA/mik
        PidTxoEXuf4sxtY10c52U0iGpLcR889au95SDPugZ9kZ9aGB1BmsNG/p1Y3hezN49AE1g7PlzKIz6
        fBFxfL+yAc8Z7lM8uL8Nrf82mLnCBBDMeXHT7NPasxJeFoithuIP6hPw4h5SOmwzH9LS46qQFYM9e
        zw2/RcCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1on1Hd-002Ta1-SO; Mon, 24 Oct 2022 17:30:41 +0000
Date:   Mon, 24 Oct 2022 10:30:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Salvatore Bonaccorso <carnil@debian.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        adi@kriegisch.at
Subject: Re: Report in downstream Debian: mpt3sas broken with xen dom0 with
 update to 5.10.149 in 5.10.y.
Message-ID: <Y1bLwUkCgElIBNdU@infradead.org>
References: <Y1JkuKTjVYrOWbvm@eldamar.lan>
 <85ad4508-b979-c792-e92b-01bc16260dec@acm.org>
 <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK=zhgr=MYn=-mrz3gKUFoXG_+EQ796bHEWSdK88o1Aqamby7g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 05:26:44PM +0530, Sreekanth Reddy wrote:
> This issue is getting observed after having the below patch changes,
> 2b9aba0c5d58e141e32bb1bb4c7cd91d19f075b8 scsi: mpt3sas: Fix return
> value check of dma_get_required_mask()

Looking at this commit it seems odd.  dma_get_required_mask() should
only be used as an optimization for hardware that actually benefits
from a lower DMA Mask.  That means either classic PCI that requires
DAC cycles, or firmware architectures like aic7xxx that do need
additional overhead.  I don't think either is the case for mpt3sas,
so I think (in addition to fixing up the Xen required mask), mpt3sas
should do something like:

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 4e981ccaac4163..295942a8989780 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2992,8 +2992,7 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 	struct sysinfo s;
 	u64 coherent_dma_mask, dma_mask;
 
-	if (ioc->is_mcpu_endpoint || sizeof(dma_addr_t) == 4 ||
-	    dma_get_required_mask(&pdev->dev) <= DMA_BIT_MASK(32)) {
+	if (ioc->is_mcpu_endpoint) {
 		ioc->dma_mask = 32;
 		coherent_dma_mask = dma_mask = DMA_BIT_MASK(32);
 	/* Set 63 bit DMA mask for all SAS3 and SAS35 controllers */
