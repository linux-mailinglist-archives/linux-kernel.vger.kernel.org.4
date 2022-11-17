Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9362D306
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbiKQF4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbiKQF4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:56:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C3B40906;
        Wed, 16 Nov 2022 21:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oYkLvPPkUUlFvOfLMkG1YO/c1AMDYnkpSXIR9noBSbs=; b=JERQWmzsatc0AhN0FUeVFlzFcz
        5HN1sqTqGGj4/xDhC5WhgUofXX6ig9XC0b4tSyf5nVAYnoVHJA5zv3PobTRCPZAhOu0nYCN9cx7HQ
        fQsQGE9H/i5u3W/xw1oGIswcjSZU8lkmUxDbDJTLl8SKLnWUFEm5EX4yEmugDxU7p575t5fn2BN7k
        EcnV4UAD/OcxX0yFlDD19cba8mIQ/aMNs0WCByh571SXO7Yhp4xYK19wtmT7Mdps+AB6yyB46Up5Z
        ZJxbCI7bMezwxbYrN8zVQ6MBpXqo/lfwO4j4ANaw0907YtajLI4nfKv8qBYvuEZ+JyXkAV5qGiKxy
        BqXKL+SQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovXsR-00AZrQ-Nu; Thu, 17 Nov 2022 05:55:55 +0000
Date:   Wed, 16 Nov 2022 21:55:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] init: move block device helpers from
 init/do_mounts.c
Message-ID: <Y3XM62P7CaeKXFsz@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e0ab0429b1fc8a4e3f9614d2d1cc43dea78093.1668644705.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:42:43AM +0000, Daniel Golle wrote:
> In init/do_mounts.c there are helper functions devt_from_partuuid,
> devt_from_partlabel and devt_from_devname. In order to make these
> functions available to other users, move them to block/bdev.c.

Yes, they should be moved and I have an old patch to do this a bit
smarter.  But that doesn't mean anyone else should call them.
