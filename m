Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC51E716B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjE3Rp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjE3Rpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:45:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D01BE;
        Tue, 30 May 2023 10:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7BC260B92;
        Tue, 30 May 2023 17:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26DBC433EF;
        Tue, 30 May 2023 17:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468753;
        bh=M2d8QfDnpbBofbpHBedx96eep1G2TGIo1MipTNzs2PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4PEQyK+Mb3z74hsjrsMPy/Evc1arWxzfqzw5cH2IvfHoHszeY/44cBnBqYAMJ+jP
         xBGueyzWYa9U21olM5/VoQEq+1K0LVOMVFqH0/tKhXG5NgpXgY+oqcByD67g7R+1TH
         QgZJETtDRtMqOoiIXXRKFQrci4R4JLPsf2mu1DYqVVJYpie6lNbKgynV+XlAgO+IT3
         IBJSEfy/xuieAy7mkdMWFgMUDA8WND/LwP35qGMvo5L+/oK8tYqy5Z9KC0Ecn4XOTu
         B3C20Rf4ygCQuBpZQUDWtpAzTq6G4LbfO0qERH5irkavwadEw/Ev/J0OQb+Jn1Tmaj
         br4bRC0Dg2SGg==
Date:   Tue, 30 May 2023 11:45:49 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        Ed Tsai <ed.tsai@mediatek.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/1] nvme: complete directly for hctx with only one
 ctx mapping
Message-ID: <ZHY2TUrKVBj2xGE2@kbusch-mbp.dhcp.thefacebook.com>
References: <20230530024120.17196-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530024120.17196-1-powen.kao@mediatek.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:41:19AM +0800, Po-Wen Kao wrote:
> ---
>  block/blk-mq.c           | 8 +++-----
>  drivers/nvme/host/nvme.h | 4 ++++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 1749f5890606..b60c78f5ad46 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1181,12 +1181,10 @@ bool blk_mq_complete_request_remote(struct request *rq)
>  	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>  
>  	/*
> -	 * For request which hctx has only one ctx mapping,
> -	 * or a polled request, always complete locally,
> -	 * it's pointless to redirect the completion.
> +	 * For a polled request, always complete locally, it's pointless
> +	 * to redirect the completion.
>  	 */
> -	if (rq->mq_hctx->nr_ctx == 1 ||
> -		rq->cmd_flags & REQ_POLLED)
> +	if (rq->cmd_flags & REQ_POLLED)
>  		return false;
>  
>  	if (blk_mq_complete_need_ipi(rq)) {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 7cf8e44d135e..acc9b1ce071d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -702,6 +702,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
>  	nvme_should_fail(req);
>  	if (unlikely(blk_should_fake_timeout(req->q)))
>  		return true;
> +	if (likely(req->mq_hctx->nr_ctx == 1)) {
> +		WRITE_ONCE(req->state, MQ_RQ_COMPLETE);
> +		return false;
> +	}

I don't think we want low level drivers directly messing with blk-mq
request state.

Is the early nr_ctx check optimisation really worth it? Would the
following work for your use case?

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6dad0886a2fa..a2d65bb127e29 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1176,7 +1176,8 @@ bool blk_mq_complete_request_remote(struct request *rq)
         * or a polled request, always complete locally,
         * it's pointless to redirect the completion.
         */
-       if (rq->mq_hctx->nr_ctx == 1 ||
+       if ((rq->mq_hctx->nr_ctx == 1 &&
+            rq->mq_ctx->cpu == raw_smp_processor_id()) ||
                rq->cmd_flags & REQ_POLLED)
                return false;
--
