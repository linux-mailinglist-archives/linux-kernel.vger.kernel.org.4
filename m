Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7064D887
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiLOJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiLOJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:26:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B9642C;
        Thu, 15 Dec 2022 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GlKnCyO4Mi0jZH6xjHBtY0wnuIzOta6O4BfJysiqLpw=; b=T+xm1z7f99NPj5wkzQHaX8wjGv
        b7MbF1+63/hqaJOrU0PnWRrirKJogxwIekii7qXQKmUMd2LCknAzd1U7Aak6uM/B01CUtXWQpTX4K
        Wgjou/c1zX0Ivih4VYIjmCiqALgTMoMiz+ubx7xb4ewoR+8EP9iKt87hHch8hIDGvWFHgga6dGoQV
        JDB2wdO+J0l8UqR9CTYN2/PUtRFidgrwNq7fHOu1NE34ZrtO9VIF9sNWwvjY6/exJOnf80F/nkTnx
        QIN1o3P2zeV++QUrtSSaFjZjn0c1OIis9jZ2Pl5CpAubI0MowdHip87IVdHkKqRZdIXQnC212h4aC
        B/wuOW2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5kVb-008Evc-Vb; Thu, 15 Dec 2022 09:26:31 +0000
Date:   Thu, 15 Dec 2022 01:26:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
Message-ID: <Y5roR3jjhQwgFWVM@infradead.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-3-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209142331.26395-3-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 03:23:12PM +0100, Sergei Shtepa wrote:
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +	blk_mq_quiesce_queue(bdev->bd_queue);

I don't think we need the quiesce here (or in the detach path).
quiesce works as the low-level blk-mq dispatch level, and we
sit way above that.

> +EXPORT_SYMBOL(bdev_filter_attach);

Please use EXPORT_SYMBOL_GPL for new low-level block layer features.

> +int bdev_filter_detach(struct block_device *bdev)
> +{
> +	int ret = 0;
> +	struct bdev_filter *flt = NULL;
> +
> +	blk_mq_freeze_queue(bdev->bd_queue);
> +	blk_mq_quiesce_queue(bdev->bd_queue);
> +
> +	flt = bdev->bd_filter;
> +	if (flt)
> +		bdev->bd_filter = NULL;
> +	else
> +		ret = -ENOENT;

Not having a filter is a grave error that the caller can't do
anything about.  So pleas just WARN_ON_ONCE for that case, and
change the function to a void return.

> +	if (bio->bi_bdev->bd_filter && !bio_flagged(bio, BIO_FILTERED)) {
> +		bool pass;
> +
> +		pass = bio->bi_bdev->bd_filter->fops->submit_bio_cb(bio);
> +		bio_set_flag(bio, BIO_FILTERED);
> +		if (!pass) {
> +			bio->bi_status = BLK_STS_OK;
> +			bio_endio(bio);
> +			return;
> +		}

Instead of ending the bio here for the !pass case it seems to me it
would make more sense to just pass ownership to the filter driver and
let the driver complete it.  That would allow error returns for that
case, or handling it from a workqueue.  I'd also change the polarity
so that true means "I've taken ownership".  I.e.:

	if (bio->bi_bdev->bd_filter && !bio_flagged(bio, BIO_FILTERED)) {
		bio_set_flag(bio, BIO_FILTERED);
		if (bio->bi_bdev->bd_filter->fops->submit_bio_cb(bio))
			return;
	}

> +struct bdev_filter_operations {
> +	bool (*submit_bio_cb)(struct bio *bio);
> +	void (*release_cb)(struct kref *kref);
> +};

Nit:  I don't think these _cb postfixes are very useful.  All methods
in a method table are sort of callbacks.

> +/**
> + * bdev_filter_get - Increment reference counter.
> + * @flt:
> + *	Pointer to the &struct bdev_filter.
> + *
> + * Allows to ensure that the filter will not be released as long as there are
> + * references to it.
> + */
> +static inline void bdev_filter_get(struct bdev_filter *flt)
> +{
> +	kref_get(&flt->kref);
> +}

Looking at the callers in blksnap I'm not sure this works.  The
pattern seems to be the driver has a block device reference, and
then uses bdev_filter_get to grab a filter reference.  But what
prevents the filter from going away just bdev_filter_get is called?
At a minimum we'd need a something:

static inline struct bdev_filter *bdev_filter_get(struct block_device *bdev)
{
	struct bdev_filter *flt;

	rcu_read_lock();
	flt = rcu_dereference(bdev->bd_filter);
	if (!refcount_inc_not_zero(&flt->refs))
		flt = NULL;
	rcu_read_unlock();

	return flt;
}


with bd_filter switched to __rcu annotation, the kref replaced with
a refcount_t, updates switched to cmpxchg and a rcu_synchronize()
after clearing bd_filter.
