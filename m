Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741AF6BB6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbjCOPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjCOPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:06:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631001814D;
        Wed, 15 Mar 2023 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D3Kfq69kTt44Q7IZ7dUTzD+1DepCf+nNfh1l9AVUnNc=; b=paJ/X6zhKZhgIN7oMv/is4E0c+
        klivSszjLFQ1pSOM6rOvoD4ZylgYzO9ILmpVbM9vqlhNu0ky08M3y/EuW5r0RfsD0zW5n7d1wDcTb
        cJFCN3knwBXgQGg5oCutx3SkNx4EJRdLM7eThUhV0DyqPXY0ukSoLga71/JqgWWdHehovHb0Rtk1q
        ZMDQohOe7Wq/QjmDoopWqmAlqMQFPrEXA4wiJgzGrZZYh9yU9AZ+fVGPUWl8ijSTfiXHMKfE3jSyk
        2V+rRbYczB+RT+ZsN5k+rvokLD7ZNFySAjJydq2QRTfGZdVwXsclFm0spK/csYfN7ufyvEop3gDis
        Vjf8brWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcSiK-00DjbD-02;
        Wed, 15 Mar 2023 15:06:52 +0000
Date:   Wed, 15 Mar 2023 08:06:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 3/4] blk-integrity: register sysfs attributes on
 struct device
Message-ID: <ZBHfCwnqUtBpqdTW@infradead.org>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-3-761a50d71900@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309-kobj_release-gendisk_integrity-v2-3-761a50d71900@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static const struct attribute_group integrity_group  = {

Double whitespace before the =

> +	.name = "integrity", .attrs = integrity_attrs,
>  };

We generally put each field member on separate lines for readability.

>  int blk_integrity_add(struct gendisk *disk)
>  {
> +	return device_add_groups(disk_to_dev(disk), integrity_groups);
>  }
>  
>  void blk_integrity_del(struct gendisk *disk)
>  {
> +	device_remove_groups(disk_to_dev(disk), integrity_groups);

Can't we just add integrity_group to disk_attr_groups and remove these
calls entirely?

