Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FEF654C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiLWFh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWFhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:37:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6DB38B1;
        Thu, 22 Dec 2022 21:37:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4771A6732D; Fri, 23 Dec 2022 06:37:19 +0100 (CET)
Date:   Fri, 23 Dec 2022 06:37:18 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
Subject: Re: [PATCH 01/13] blk-mq: avoid sleep in blk_mq_alloc_request_hctx
Message-ID: <20221223053718.GA2676@lst.de>
References: <20221223125223.1687670-1-shikemeng@huaweicloud.com> <20221223125223.1687670-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223125223.1687670-2-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 08:52:11PM +0800, Kemeng Shi wrote:
> +	if (WARN_ON_ONCE(((!flags) & (BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_RESERVED))))

This check does not make any sense.  I think what you want is

	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT) ||
	    WARN_ON_ONCE(!(flags & BLK_MQ_REQ_RESERVED))))
