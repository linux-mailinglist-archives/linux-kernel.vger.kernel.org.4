Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FD5603024
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiJRPue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiJRPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:49:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC622BC1;
        Tue, 18 Oct 2022 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jlcxA1wJ/GgonSkru8M9jDo39zGihqj0ye56NeeAZqE=; b=a6jDpIlqRUHOK5t8sl/lTtmxHC
        KQOmwUjw3j0q+6WFkWnS4+frZSE7kM5s314K+jhI3DtPesg0WpXTrlfU6aavuAgz2K0MdOs6TXlgW
        d/F05dQucWAYwBnjXUBaufNt9YK1L5heeFWtHr8KVn5s5dorioUksmgmntLUGG7it1DNECdaWz10J
        xQd0P95Svab+1e9MyJWlOLM0Pb03GoPD1GwGcbZL/FMEpdRmKxMJzukEU2CXA3kG/AXd31QzxDCvH
        ENkzTL2ytvSHjmMTvOkcLhSLdkuiqedwYWKDR/bKjtCkbXPRmT9ESrv1TYEsmy95qr7eM3r6OXHyP
        5StUISfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okoqQ-007xY3-CW; Tue, 18 Oct 2022 15:49:30 +0000
Date:   Tue, 18 Oct 2022 08:49:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     jack@suse.cz, hch@infradead.org, ebiggers@kernel.org,
        paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v4 4/6] blk-wbt: don't show valid wbt_lat_usec in sysfs
 while wbt is disabled
Message-ID: <Y07LCnJN5q8ueV7X@infradead.org>
References: <20220930031906.4164306-1-yukuai1@huaweicloud.com>
 <20220930031906.4164306-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930031906.4164306-5-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>  {
> +	u64 lat;
> +
>  	if (!wbt_rq_qos(q))
>  		return -EINVAL;
>  
> -	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
> +	lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
> +
> +	return sprintf(page, "%llu\n", lat);

	if (wbt_disabled(q))
		return sprintf(page, "0\n");
	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));

but otherwise the patch looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
