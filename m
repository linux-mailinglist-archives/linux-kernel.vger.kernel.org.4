Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6079A6BB6E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCOPD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjCOPDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:03:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B62943BD;
        Wed, 15 Mar 2023 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/OZYdHvNxnJHldt+dQxT7Qu67n4TEEbtWJcWrQD+P9I=; b=sbXS9dk3HJfQpKsXWh5i+YY8iD
        N35KMOzIc2DGeCHiBQhDjL0svRmHjR0e6IrmdYiV8UcPYn2h55zC5pa1PJOLE75QSqtzx9QM9xKlb
        fOVCkg5jvA0OnfvT6p5O+aP/ZbPeAqjlEaGeIGraDyiF3ouXcWl2voJwJvcOA9WoC1s32O7onsGKZ
        YcvAE6efgQZsEBG7MEyjziKU2q7f0he8jhCHHrpG07bEPIh9THuFdzv7b8MKeJFKlwcNzV4FscoOW
        jBrkN13ZUZmKlm6CO5IhnsbLTLrBmJSfvGuxNwIWc+TEJwKkLyJslCzQOVOJzPE5kGUQVcZqBNPJn
        FreQHovA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSea-00DjKI-2R;
        Wed, 15 Mar 2023 15:03:00 +0000
Date:   Wed, 15 Mar 2023 08:03:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 2/4] blk-integrity: convert to struct device_attribute
Message-ID: <ZBHeJOlwKD4v41kC@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-2-761a50d71900@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-2-761a50d71900@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +		container_of(attr, struct device_attribute, attr);
>  	ssize_t ret = 0;
>  
> +	if (dev_attr->store)
> +		ret = dev_attr->store(dev, dev_attr, page, count);
>  
>  	return ret;

This can be simplified to:

	if (!rev_attr->store)
		return 0;
	return dev_attr->store(dev, dev_attr, page, count);

(I'm still confused why 0 is the right return value here, but that's not
 new in your patch, so better don't rock that boat).

> +static ssize_t format_show(struct device *dev, struct device_attribute *attr, char *page)

Please avoid the overly long line here. an in the other methods.
