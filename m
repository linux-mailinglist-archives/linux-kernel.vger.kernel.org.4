Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154F64A12E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiLLNgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiLLNfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:35:47 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FCB13E28
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=HEmAqWujrVxNCQMKl7ptRdTCY1TyWIcI8oh1636jxcU=; b=F52oo6ztaWYvJ/v3/RSAYaULwe
        +PhRv7I8Uq6Uxxx5wQleZfm4qd0DEszRDRnwUFuRyd1mCPg6N1QdL+lhT4yFngIvLqlDsFb/125KD
        nYJqUCjUtivSA2jcfebm8VXNRmBrNgJwg/tcy9i3yb98QArdi2kg2rNk/H++5IDOeEgJoiqwWlvsd
        8TCZfRN26Sx0hXUuBqPrXbylEwqk23t11R2Ap35ESplCj6kvro/Y2j0OgJz3DuQ0BiZ0sL+MxKy3i
        UIqxxI4g2z7r0T3fp1KHm2IarvNkMnu/FjXESN/+T8iUgJDaVT2v/5qCy+FIZDtyIqcu088QMCv2i
        bJ2FWmuZ0yQAFqwi0Yna+sVomriQbUda2ltppEUsYn9ZdaglMW6/CAuAuLxwm8cY5D32NaF6ls1nA
        ZSDtjEb/vUh34DBx7EwH4YQbAmCFenGX2R61xXdnyl7dUUvxr1yigzTljr43MxdM4b4OW/7hkGK7Q
        5uegmpdk+9SI7ptFLMPeh8gmRNtkdtBZvUEUJ8j7vS0OHxcV6XaX/MNkLOyBUV7lSTjQC0e2W0Amo
        W+7973zZnAV0WsQ8AQfzVo/I7d5cA743t4tWaypgry7de6kHliQ7TN+E0GMus+oGGIRO12fKO/UPC
        SRwYFgKvHxZJF7k/ExW+XoWuQv6dZ1SuuQfSS3W10=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Marco Elver <elver@google.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH] 9p/virtio: add a read barrier in p9_virtio_zc_request
Date:   Mon, 12 Dec 2022 14:35:39 +0100
Message-ID: <21422678.bhv4C0q8Fj@silver>
In-Reply-To: <20221210001044.534859-1-asmadeus@codewreck.org>
References: <20221210001044.534859-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, December 10, 2022 1:10:44 AM CET Dominique Martinet wrote:
> The request receiving thread writes into request then marks the request
> valid in p9_client_cb by setting status after a write barrier.
> 
> p9_virtio_zc_request must like p9_client_rpc issue a read barrier after
> getting notified of the new request status before reading other request
> files.
> 
> (This has been noticed while fixing the usage of READ/WRITE_ONCE macros
> for request status)
> 
> Link: https://lkml.kernel.org/r/167052961.MU3OA6Uzks@silver
> Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  net/9p/trans_virtio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 3c27ffb781e3..98425c63b3c3 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -533,6 +533,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
>  	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
>  	err = wait_event_killable(req->wq,
>  			          READ_ONCE(req->status) >= REQ_STATUS_RCVD);
> +
> +	/* Make sure our req is coherent with regard to updates in other
> +	 * threads - echoes to wmb() in the callback like p9_client_rpc
> +	 */
> +	smp_rmb();
> +

Oh, I had p9_client_zc_rpc() for this in mind, but I see why you chose this
place in p9_virtio_zc_request() instead. LGTM

I also made some tests to check whether this barrier would hurt performance,
but I measured no difference. So this should be good to go:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  	// RERROR needs reply (== error string) in static data
>  	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
>  	    unlikely(req->rc.sdata[4] == P9_RERROR))
> 



