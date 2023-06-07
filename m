Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A3D725641
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbjFGHqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbjFGHpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:45:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3D2D65;
        Wed,  7 Jun 2023 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4Sx6PZ8z7yUHSRyrSyhfNlQuLMPtcylN+zdcdoTWpXg=; b=KEHhRRtM/7119LZoHZ21PYKQvf
        oxQ3RW7h1hm22BBehjrTIxZs+Hq4vNo2r7l6s04yZHqhXriMF63WHd9i5/zDyUJLhCmuIXXizFHjF
        4Jsv/ky6uLqB5DrYaMtEapqpJJHQIp+5COiFf/fjdAb68jrejI06b4/3yOXZm25RDROV2sLsCI7/M
        LzYuzlMAcsstPZ3ok7GYLmLvIlnHuHYvruYjB+JVdJQz2zhH7pKYEIBJ1kQdE+vY6qsnVevIkJy2M
        ta9L6kYnOflYPdvVBtihfIYaqAzWLOjNSQvLp3cM2kFEDfgTrtzUdL7vORwRcQ+gVauExyOPeEpbw
        JiOgiSfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6nqB-004n5l-03;
        Wed, 07 Jun 2023 07:44:23 +0000
Date:   Wed, 7 Jun 2023 00:44:22 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] xen-blkback: Implement diskseq checks
Message-ID: <ZIA1VkDdgt5kmqEt@infradead.org>
References: <20230601214823.1701-1-demi@invisiblethingslab.com>
 <20230601214823.1701-2-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601214823.1701-2-demi@invisiblethingslab.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:48:22PM -0400, Demi Marie Obenour wrote:
> +	if (diskseq) {
> +		struct gendisk *disk = bdev->bd_disk;
> +
> +		if (unlikely(disk == NULL)) {
> +			pr_err("%s: device %08x has no gendisk\n",
> +			       __func__, vbd->pdevice);
> +			xen_vbd_free(vbd);
> +			return -EFAULT;
> +		}

bdev->bd_disk is never NULL.

> +	diskseq_str = xenbus_read(XBT_NIL, dev->nodename, "diskseq", &diskseq_len);

Please avoid the overly long line.

> +	if (IS_ERR(diskseq_str)) {
> +		int err = PTR_ERR(diskseq_str);
> +		diskseq_str = NULL;
> +
> +		/*
> +		 * If this does not exist, it means legacy userspace that does not

.. even more so in comments.

> +		 * support diskseq.
> +		 */
> +		if (unlikely(!XENBUS_EXIST_ERR(err))) {
> +			xenbus_dev_fatal(dev, err, "reading diskseq");
> +			return;
> +		}
> +		diskseq = 0;
> +	} else if (diskseq_len <= 0) {
> +		xenbus_dev_fatal(dev, -EFAULT, "diskseq must not be empty");
> +		goto fail;
> +	} else if (diskseq_len > 16) {

No need for a else after a return.

> +		xenbus_dev_fatal(dev, -ERANGE, "diskseq too long: got %d but limit is 16",
> +				 diskseq_len);
> +		goto fail;
> +	} else if (diskseq_str[0] == '0') {
> +		xenbus_dev_fatal(dev, -ERANGE, "diskseq must not start with '0'");
> +		goto fail;
> +	} else {
> +		char *diskseq_end;
> +		diskseq = simple_strtoull(diskseq_str, &diskseq_end, 16);
> +		if (diskseq_end != diskseq_str + diskseq_len) {
> +			xenbus_dev_fatal(dev, -EINVAL, "invalid diskseq");
> +			goto fail;
> +		}
> +		kfree(diskseq_str);
> +		diskseq_str = NULL;
> +	}

And I suspect the code will be a lot easier to follow if you move
the diskseq validation into a separate helper.
