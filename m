Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D69070ED78
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbjEXF6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239564AbjEXF6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:58:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB71C198
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x+N6WV/CyF+wzcgIuD5OCrwWYrJjwwC1z6uAEEubo1c=; b=Z6UOwVj6yiJqAeVLNAZ5XhFLod
        2EeVpQrzvSFp1FuDVe5FS9XKyvLxPCovJLnu8rRx4dRQJcQT3/vRc+NZbl6b//WJVDbFpktB4KteQ
        +pDPdy9X+pjQqYQfLAA5BjRsMwUDKyNs+2c9bz7Wn5LvjOlQrGdi6yrqgkaJjELWFStL0HOkcels2
        B7kuxD/oOE3yHM9u284tmeBGKOVrnGpcEQbSwYXtGgzYMRbORVw6dCvO1j17V2GUnVJiTRqYeTFyQ
        v8tyhtAWI+yggCuYTzbKsUqal3i16OWiJ25sHZ6w03k6Hbb6ovbNjFUsXceTprqjU3doItbgE/JRX
        4A/pAHoQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1hVh-00CRpm-1c;
        Wed, 24 May 2023 05:58:09 +0000
Date:   Tue, 23 May 2023 22:58:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH 1/2] ubi: block: Fix use-after-free of gendisk
Message-ID: <ZG2ncaTjxCnRWcUZ@infradead.org>
References: <20230523-ubiblock-remove-v1-0-240bed75849b@axis.com>
 <20230523-ubiblock-remove-v1-1-240bed75849b@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-ubiblock-remove-v1-1-240bed75849b@axis.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 03:12:16PM +0200, Vincent Whitchurch wrote:
>  static void ubiblock_cleanup(struct ubiblock *dev)
>  {
> +	int first_minor = dev->gd->first_minor;
> +
>  	/* Stop new requests to arrive */
>  	del_gendisk(dev->gd);
>  	/* Finally destroy the blk queue */
>  	dev_info(disk_to_dev(dev->gd), "released");
>  	put_disk(dev->gd);
>  	blk_mq_free_tag_set(&dev->tag_set);
> -	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
> +	idr_remove(&ubiblock_minor_idr, first_minor);

I think the real fix here is to implement the free_disk method
and free the idr there.  That ensures the ID can't be reused until
the disk is entirely freed as well.
