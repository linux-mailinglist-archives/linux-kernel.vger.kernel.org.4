Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDEA5F9A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiJJH7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJJH7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:59:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6E72D74A;
        Mon, 10 Oct 2022 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sWolSNkLX1ZPnLQhfmowne8piiQT5rQ6uM09AjXa5Dc=; b=aJIBlsb0nSpWjrle4oZywMion1
        d0M1TLezw/OcG2P0MgPxI6aB4/HTO9AxzYy4TBBhT7iUcr9rtBjX/6QDGEY3NVp14bJ4/jDCFWOLR
        AQbNGi/LTMEXH3wmTjrkT5Y5SGv/Ib9V7XughQZRpp+pgf73tDFKD5qBO9fZNJp7D5XdpZAn047TZ
        EiJJmMepreW3fKePOipspGiOfrSt007DayqpG0JoDUJoeTic1aqPtkls/MHiWNJVicPA3qcsuILrN
        M+txLRN4vmfGm/5lZL3wxlLajTmeHmNW15SUYd9J3te7dVhIl6aHu6Zoczw8l4kTSbppDR+vGd2rO
        RUq4Vc7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohngj-00HSJR-TP; Mon, 10 Oct 2022 07:59:01 +0000
Date:   Mon, 10 Oct 2022 00:59:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     ogeert@linux-m68k.org, linux-block@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        linux-mtd@lists.infradead.org, axboe@kernel.dk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, efremov@linux.com,
        josef@toxicpanda.com, tim@cyberelk.net, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com, mcgrof@kernel.org, hare@suse.de,
        damien.lemoal@opensource.wdc.com, johannes.thumshirn@wdc.com,
        bvanassche@acm.org, ming.lei@redhat.com, vincent.fu@samsung.com,
        shinichiro.kawasaki@wdc.com
Subject: Re: [RFC PATCH 01/18] block: add and use init disk helper
Message-ID: <Y0PQxdzmMzAAW0KF@infradead.org>
References: <20221005050027.39591-1-kch@nvidia.com>
 <20221005050027.39591-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005050027.39591-2-kch@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:00:10PM -0700, Chaitanya Kulkarni wrote:
> +void init_disk(struct gendisk *disk, int major, int first_minor,
> +		int minors, sector_t sectors, void *private_data,
> +		const struct block_device_operations *fops)
> +{
> +	disk->major = major;
> +	disk->first_minor = first_minor;
> +	disk->minors = minors;
> +	set_capacity(disk, sectors);
> +	disk->private_data = private_data;
> +	disk->fops = fops;

I don't like this at all.  For one major/first_minor/minors are
optional and discouraged for new drivers.  Setting the capacity is
a different thing and is done by helpers also used for revalidation
in many drivers.

It might make sense to pass the fops (and maybe private_data) to
blk_mq_alloc_disk / blk_alloc_disk, but even then I'm not quite
sure it is worth the churn.
