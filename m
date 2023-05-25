Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791177107FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjEYIzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbjEYIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:55:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550FB1B0;
        Thu, 25 May 2023 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K9sG0POcwk6ioMsTPXOQV3eSTLgEBbB2sxvA5LCbWcQ=; b=fdt7VIxbv3TkQRWM91jZwpprV9
        ZJ6UeaeNYURZHcPVWl9lz509obvVWnmwXb94DjsnzdOTi1W5NRxUZgm2G3iLTvanTBrrRKA2uUBmW
        R6Le1Lg0MiA0ZT1X3YX7aEMYsV8Hmk91GojRCW2d3WSGcp15cT8xeI+PBwhD71nTJXrz8Yl75BfiX
        wDqDKKIlWysLrK0rRjcX0ZddExqgE/5YrnkwxWDzH2gxFiPnx8D0zSdtvNZk/rBZJ+Q+00ABKMECF
        gp4O0zcjlabod1RTaTrITZTNx6itpSK+cG5turE8dUFqrt8KB4fkxbhUY1mYJ1gyVxHcskP5cHHud
        qsE4p1SA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q26kq-00G3tZ-2y;
        Thu, 25 May 2023 08:55:28 +0000
Date:   Thu, 25 May 2023 01:55:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, chengzhihao1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] block: Fix the partition start may overflow in
 add_partition()
Message-ID: <ZG8igEyXrFa4j/gf@infradead.org>
References: <20230522070615.1485014-1-zhongjinghua@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522070615.1485014-1-zhongjinghua@huaweicloud.com>
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

On Mon, May 22, 2023 at 03:06:15PM +0800, Zhong Jinghua wrote:
> +	if (p.start < 0 || p.length <= 0 || p.start + p.length < 0)
> +		return -EINVAL;
> +
>  	start = p.start >> SECTOR_SHIFT;
>  	length = p.length >> SECTOR_SHIFT;
>  
> +	/* length may be equal to 0 after right shift */
> +	if (!length || start + length > get_capacity(bdev->bd_disk))
> +		return -EINVAL;

While we're at it, shouldn't these be switched to use
check_add_overflow?

