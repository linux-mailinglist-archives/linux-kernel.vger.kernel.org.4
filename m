Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D864D93D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiLOKGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiLOKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:06:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C76FDD;
        Thu, 15 Dec 2022 02:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iRzkPWuCkQml6FYGQ4TeSDfpbXjzHlPcMLaQkvZAaQE=; b=2V1qG2uHmplQmT3bRDjmbko+Ot
        HY9m8IrWLuV49vQ/8DgONSsiWewojZXnbLNKHm/FdweSHW90r6i7onM+uXP9jPMahqSBNW+RiE6Ix
        jnE9iIFRM+4hRDUhauomEVtIo2ZRZ2qE5w0hxa/Cw1xOoLPLzwNhTUFx41OACjAgdO3o5wjvaRK1J
        DVtqQC7NAiVFfF4ik3p/Y61CtKdO7jVliVCIEEJ8VYSy1G/lLfi1MqIkVFRkB0Dk0/w8E2+WxKmQ0
        /GnElXVHFDtAU0TSJgq1gVova4ZCO/X8a0OFn6ehKzhFSUjwHQj+dceCySI9ibpAqAUD0cnapqLUV
        0SRsX12A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5l8A-008ffS-Mn; Thu, 15 Dec 2022 10:06:22 +0000
Date:   Thu, 15 Dec 2022 02:06:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/21] block, blksnap: functions and structures for
 performing block I/O operations
Message-ID: <Y5rxnsKpQga5GRzY@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-14-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-14-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	bio = bio_alloc_bioset(diff_region->bdev, nr_iovecs, opf, gfp_mask,
> +			       &diff_io_bioset);
> +	if (unlikely(!bio)) {
> +		if (is_nowait)
> +			ret = -EAGAIN;
> +		else
> +			ret = -ENOMEM;
> +		goto fail;

bio_alloc_bioset can't fail for the !is_nowait case.
