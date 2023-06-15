Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1DE73128A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbjFOIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245400AbjFOIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:45:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25613599;
        Thu, 15 Jun 2023 01:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0t7RSbVRpZGhABu0UPXGpkAlTCxm0aGLoOOEJOAJWgg=; b=SJTyItSfh2OKMkkSvblQP43aWn
        keh4bnB9Zg1MmpiumtAjXgBcgfelU285m2veI7eBQn/ktu5ovpiQr5XeNYsPY+tjZoyp+1xNpCBuX
        QKJ+c5UG/wQxxdUM57FF3qx82b7q6QCtgrxNjfYW+hKbS1xpEZHge6GulVfQFr+V7yzPTdW8e/LsX
        qLHKSyhQMRnPTLGd0PpCEXUyS9kOVW0IRV3tKJVA3kzdbJjn3QxEmhhoLy3M0dnBic4L8y1CgsTUk
        W3ehYsD4v+wVSTUbPpOX8peIrBlLwKG95g1uFLR8m3lZTCgPconNQCoRax93mL6p4HojBtn71mBw3
        5TPieAiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9iaZ-00ECoc-0M;
        Thu, 15 Jun 2023 08:44:19 +0000
Date:   Thu, 15 Jun 2023 01:44:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "min15.li" <min15.li@samsung.com>
Cc:     axboe@kernel.dk, willy@infradead.org, hch@lst.de,
        dlemoal@kernel.org, gregkh@linuxfoundation.org, wsa@kernel.org,
        vkoul@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: add capacity validation in bdev_add_partition()
Message-ID: <ZIrPY2fS7LJI9voI@infradead.org>
References: <CGME20230615081227epcas5p40cd9cdf762fcaeedaa8cf8d92d425560@epcas5p4.samsung.com>
 <20230615160929.9240-1-min15.li@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615160929.9240-1-min15.li@samsung.com>
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

On Thu, Jun 15, 2023 at 04:09:29PM +0000, min15.li wrote:
> +	if (start >= get_capacity(disk) ||
> +		start + length > get_capacity(disk)) {

We need to check for overflows of the start + length value,
probably best using a helper like check_add_overflow.

Also a single tab indent (and thus the same as code below) is always
wrong for continuations, plase use either two tabs or align to the
opening brace.
