Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7189572F49B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242402AbjFNGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbjFNGTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:19:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4B01BC5;
        Tue, 13 Jun 2023 23:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cpt7/j1iq5H8adWmH5F4O2jrSqEne7TQhNs0GXBvlgE=; b=IkmNWvX7rTEu3GicBPsUe2m6GE
        4gzsY2YXVx6WAcZIicMeC2/dthCdRTGvuTqlNrZG+VY1tLtdsN7DlF0wmYsBYS48onBHjqydO1aMg
        +bZM+OczV1r9dvL7sCpmUc+KBmjHR7Hh887KzQp3v7+PiqY6mOXtW0d0eiL07G1Zd95X1T3IaOgF8
        vcQHqljwgx0wbD4F5QHY256Ajtc5w9qOJdsgf2IM7dfkk5pRQ5d87n+VZJrnf9vdCNTxU3pk0H9im
        EGn5Fu2upztmZLqwqG9PwWBfrmuoSt3PD9DINQAOzet/cMe9oSloYqJXEL5KOSpZ9HuSs/+b73O/z
        Rbb8gl5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9JqQ-00AOvi-1m;
        Wed, 14 Jun 2023 06:19:02 +0000
Date:   Tue, 13 Jun 2023 23:19:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     axboe@kernel.dk, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kbusch@kernel.org,
        amergnat@baylibre.com, liusong@linux.alibaba.com,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, powen.kao@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        Chun-Hung.Wu@mediatek.com
Subject: Re: [PATCH v3] blk-mq: check on cpu id when there is only one ctx
 mapping
Message-ID: <ZIlb1vrQVwjOT1QV@infradead.org>
References: <20230614002529.6636-1-ed.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614002529.6636-1-ed.tsai@mediatek.com>
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

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
> -	if (rq->mq_hctx->nr_ctx == 1 ||
> +	if ((rq->mq_hctx->nr_ctx == 1 &&
> +	     rq->mq_ctx->cpu == raw_smp_processor_id()) ||
>  		rq->cmd_flags & REQ_POLLED)

But please fix the incorrct indentation in the existing code here
please while you're at it (maybe Jens can just fold it in):

	if ((rq->mq_hctx->nr_ctx == 1 &&
	     rq->mq_ctx->cpu == raw_smp_processor_id()) ||
 	    (rq->cmd_flags & REQ_POLLED))
