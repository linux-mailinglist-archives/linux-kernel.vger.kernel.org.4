Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59206DB439
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDGTap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDGTal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:30:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B083A7D9B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:30:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED596108C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 19:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28326C433EF;
        Fri,  7 Apr 2023 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680895824;
        bh=3ywzi95ZmiScAxaAds75UKy6vqGW+xnG6LmWrRIr+BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E6x8fviM6g7mbuOCJ9TcclQ6RWAvhdNJDv0A1AAXoY68HnRvxycuAAiXOqVLzdy/3
         +63WSI1xyX/KF6uvPfEssmGEt1vr9Ym2GbxqZHAePE8k8TmxJVilCEhW+i4laLRBgk
         g1IQamVkm/eQkwKgWYG/RQs0j8Lg6hvKTSnY1qV3EKiQjBnZAsDQfuxC4x7zne68La
         uH8sMiN8ZJX+VfnB1L8sJqhBbYGc9JpnIVDcxJJQwT8toNvAFmgFt2eccGeW/Zlgpy
         GJnmBnOdibL2k/iARUqtCErLXWH5TdJwt5eA9Unc9eWzjzsuTr24l6Qj2wnWIRNdmO
         al6dQyJxlfLdg==
Date:   Fri, 7 Apr 2023 13:30:21 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Lei Lei2 Yin <yinlei2@lenovo.com>
Cc:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cybeyond@foxmail.com" <cybeyond@foxmail.com>
Subject: Re: [PATCH] nvme: fix double blk_mq_complete_request for timeout
 request with low probability
Message-ID: <ZDBvTS1j26d3392/@kbusch-mbp.dhcp.thefacebook.com>
References: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR03MB4939C825BD5D9A135AA0EB9188919@PS1PR03MB4939.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 04:18:18PM +0000, Lei Lei2 Yin wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 53ef028596c6..c1cc384f4f3e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -450,8 +450,8 @@ bool nvme_cancel_request(struct request *req, void *data)
>  	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
>  				"Cancelling I/O %d", req->tag);
>  
> -	/* don't abort one completed request */
> -	if (blk_mq_request_completed(req))
> +	/* don't abort one completed or idle request */
> +	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT)
>  		return true;

I was suspicious about this path too, and had the same change long ago, but
shelved it when I couldn't produce any errors there. But the change makes sense
to me!

Reviewed-by: Keith Busch <kbusch@kernel.org>
