Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAF86C137C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCTNeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjCTNeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:34:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0409E2130;
        Mon, 20 Mar 2023 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ZH7pgpUeJbXrkFFil6ceo9u06+QpQF5ILp07z1RGgk=; b=xt5nxVFijLtiUlCb289PXu9H0E
        rjmWwb4I9vYRpNZB5SqcRePpUqQrzECXPX8Ogac1as2ySTojc7Ik+5mQvMi8I410746j7DeyHm6To
        MXAKt2KY7ffbqMy/sz8VBeahv84AYeU1volXuChFZYIvEJLvS+nK5qCz18hTfB69QHTLt2jUsmjih
        DYsmYB889q+XZTfZZ6kVLRRmVaKSutrml/MpxPDFjpSdPMHDOJyixIWY0Htvuz543esS7vGhlr2MU
        2X8Fn3zQZG++8Vc2+/3HoGWXDfWc1wDz0jmHobL1YjNwS5Qeq2+HFVdJxmGfJ+c+Y5HBx5nSP7CNZ
        I7Lk1AIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peFeF-009CO0-0A;
        Mon, 20 Mar 2023 13:34:03 +0000
Date:   Mon, 20 Mar 2023 06:34:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
Message-ID: <ZBhgy/+u/5+79uZq@infradead.org>
References: <20230310082413.58141-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310082413.58141-1-frank.li@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 04:24:13PM +0800, Yangtao Li wrote:
> Introduce queue_logical_block_mask() and bdev_logical_block_mask()
> to simplify code, which replace (queue_logical_block_size(q) - 1)
> and (bdev_logical_block_size(bdev) - 1).
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> Like wo done for fs.
> This round we add helpers and start converting in the next cycle.
> https://lore.kernel.org/lkml/20230309124035.15820-1-frank.li@vivo.com/

Please always send the helper with the actual users.

And for use in file systems the request_queue is very much the
wrong object to work on.  All the block layer APIs for consumers like
file systems are based on struct block_device.

