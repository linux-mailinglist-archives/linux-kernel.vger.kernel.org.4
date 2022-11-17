Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149362D309
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 06:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbiKQF4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 00:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiKQF4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:56:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D32C66C85;
        Wed, 16 Nov 2022 21:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fHV8C99I/AoA0afDaQTlC1+ocHHbTKqGLXuQDD4SZVQ=; b=xUZyKlM+cvVD3VMjPnAYr6EqMG
        QZ2Z6eZE1aHyNZKXXpWGnNCKBLe9naR5d9jfRyXXn+NRegL+kFP44y4zlLlYioyjrSbYcFEfYX/aO
        g6wfzaNqk/3b4UspJcwodTmeoFsZtxlZHLI7+chfWr1C8PaYeRtQMNhi8UanlfxBUFRscZqA6y5fw
        xwwiYjgZNlFhXjaqhFu+A64ZWSp10WAqQa3z15r+j2q9yvdE4RO/RIuQOZ/SGii/Xyvl3TgfEtHPi
        cKxlAKoQ9p4hDvVZ558oErgHv2UrC5eKgg3m2tFE4zV6lTFJQDNzK6PXIOBYjDxNdGP2T73pVFtMV
        rgPmJ6bg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ovXt7-00Aa6P-M0; Thu, 17 Nov 2022 05:56:37 +0000
Date:   Wed, 16 Nov 2022 21:56:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] blkdev: add function to add named read-only
 partitions
Message-ID: <Y3XNFXMaYFesFa+j@infradead.org>
References: <cover.1668644705.git.daniel@makrotopia.org>
 <2015e6097f7166915d829740ff33aab506948a0a.1668644705.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2015e6097f7166915d829740ff33aab506948a0a.1668644705.git.daniel@makrotopia.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:44:40AM +0000, Daniel Golle wrote:
> Add function bdev_add_partition_ro() which can be used by drivers to
> register named read-only partitions on a disk device.
> Unlike the existing bdev_add_partition() function, there is also no
> check for overlapping partitions.
> This new function is going to be used by the uImage.FIT parser.

Err, no.  No on has any business adding partitions to the block device
except for the partition parser.
