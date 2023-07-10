Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68374CDB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGJGzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjGJGzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:55:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B6DDA;
        Sun,  9 Jul 2023 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IuH8LJYvcYtMLcwMqbYORbIhMXRU2KvEfyHfs6OUorc=; b=OVdL0XtjMCVX+22CogqYkdhhyA
        QiE4e5Z8wApctUXJnJKZ0336tbFQXORdewh908tvLiioSwUuh+C7ZaJ3ZhTbxoWIKycR1De4U3ipL
        2bN7TkkYz3Ii/9okTSkZ//HCBcJE3KcF3OL08YKC5hyDP8Pdhgvli7hBwSmaF/wJ5TYn6bd5JLLcg
        yadjKuO32T8li4lSDFZYtyMfEW41eE2hMU7vcbFu1w+j0wE5F4Hm3LgOLqR48V4LgDY7lgmRwZpmk
        CkZo8gdvtUIz94VEC1RDbqhbeuwWNesjO0AzAvert2a0PuCxgbwjFUPCZly3zSkmhqNg+v4XHx5RA
        PEb84NSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qIknR-00Adk7-1N;
        Mon, 10 Jul 2023 06:54:57 +0000
Date:   Sun, 9 Jul 2023 23:54:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Minwoo Im <minwoo.im.dev@gmail.com>, gost.dev@samsung.com,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>
Subject: Re: [PATCH v7 1/3] ublk: add opcode offsets for DRV_IN/DRV_OUT
Message-ID: <ZKurQVJotCwBSHkD@infradead.org>
References: <20230710064607.155155-1-nmi@metaspace.dk>
 <20230710064607.155155-2-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710064607.155155-2-nmi@metaspace.dk>
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

On Mon, Jul 10, 2023 at 08:46:04AM +0200, Andreas Hindborg wrote:
> +#define		UBLK_IO_OP_WRITE_ZEROES		5
> +/*
> + * Ublk passthrough operation code ranges, and each passthrough operation
> + * provides generic interface between ublk kernel driver and ublk userspace, and
> + * this interface is usually used for handling generic block layer request, such
> + * as command of zoned report zones. Passthrough operation is only needed iff
> + * ublk kernel driver has to be involved for handling this operation.
> + */
> +#define		__UBLK_IO_OP_DRV_IN_START	32
> +#define		__UBLK_IO_OP_DRV_IN_END		96
> +#define		__UBLK_IO_OP_DRV_OUT_START	__UBLK_IO_OP_DRV_IN_END
> +#define		__UBLK_IO_OP_DRV_OUT_END	160

I guess I was just a little late to catch this before your resend,
sorry.  Please look at my comment on the last iteration.

