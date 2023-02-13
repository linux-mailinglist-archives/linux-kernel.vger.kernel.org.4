Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14977694ED5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBMSHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBMSHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:07:50 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928DE1F93A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=akMfePs3N2PcAvu5Nq/PqkDdQ9WQCjfhn/rZvX1a8+Y=; b=hD5Rrsg4X5+wBTUwx87Szs44MO
        jvYYTSpla2cylioms7AQLxd2hNB2pRzr5O5lLFMqlUFZtJj5gaxAstxrdDZ8PSckbAkhrXAFp5zmu
        jOV0Ywqbvazg6Ucz/zn2BnuVTrZG9cSqTX67AvUubJNm4MfylRtIsQfhJnSlx4zDM4oU8NEmgPRi7
        JAfmp80e6KhoaImcPCd4zIYgIUjLNTejgA+6xWfF6P9fR0HOU+tJ0v8ct0PdhDTQWJrCBgR5fDGDj
        RwCXQcUXGwow0OhM7YdBa1Azr8IMg/WPX2Q8s8r/gSronSQBBxjPvbs+4OY/sdM5OA+UCnCMPbIxk
        A/8jlxrQ+JDtfcLdRWheKo8s7WznMw77KB08jKCqRby1QVMGNLlmqyHavZ7sr0P6HB2sM+s+B8KQw
        VW3TCwK2CYLXgTEvCBAVIrn8EMsQCuVA/xOwTM/x5qMc7M/33fuXvNa8p0CrS6XBavbnlK6cX/xEj
        akV4F6YXSBAEgrD6ncL/LBYApMr5nZr2koKyZKb7FxDEpsVMnoUiE76+TQ5FlK6eCAd0B8HFrE2ZW
        JUxEFAsp+wPjuvsUJ7SRwdy899cHRwi3qx6VuaQYR8ygm5lIvbZxNEXN80TsqSjNpOBO/BBuvJcnm
        pH6ymD+Z0SAA8b3P2MD253vJUSYY/X1j+NYW0tQ4Q=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 2/5] 9p/net: share pooled receive buffers size exception in
 p9_tag_alloc
Date:   Mon, 13 Feb 2023 19:06:13 +0100
Message-ID: <2221747.x32gLWZWRm@silver>
In-Reply-To: <20230211075023.137253-3-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <20230211075023.137253-3-asmadeus@codewreck.org>
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

On Saturday, February 11, 2023 8:50:20 AM CET Dominique Martinet wrote:
> The async RPC code will also use an automatic size and this bit of code
> can be shared, as p9_tag_alloc still knows what client we alloc for.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  net/9p/client.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 53ebd07c36ee..4e5238db4a7a 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -282,8 +282,15 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint t_size, uint r_size,
>  			    t_size ?: p9_msg_buf_size(c, type, fmt, apc));
>  	va_end(apc);
>  
> -	alloc_rsize = min_t(size_t, c->msize,
> -			    r_size ?: p9_msg_buf_size(c, type + 1, fmt, ap));
> +	/* Currently RDMA transport is excluded from response message size
> +	 * optimization, as it cannot cope with it due to its pooled response
> +	 * buffers (this has no impact on request size)
> +	 */
> +	if (r_size == 0 && c->trans_mod->pooled_rbuffers)
> +		alloc_rsize = c->msize;
> +	else
> +		alloc_rsize = min_t(size_t, c->msize,
> +				    r_size ?: p9_msg_buf_size(c, type + 1, fmt, ap));
>  
>  	if (!req)
>  		return ERR_PTR(-ENOMEM);
> @@ -728,18 +735,10 @@ p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...)
>  	int sigpending, err;
>  	unsigned long flags;
>  	struct p9_req_t *req;
> -	/* Passing zero for tsize/rsize to p9_client_prepare_req() tells it to
> -	 * auto determine an appropriate (small) request/response size
> -	 * according to actual message data being sent. Currently RDMA
> -	 * transport is excluded from this response message size optimization,
> -	 * as it would not cope with it, due to its pooled response buffers
> -	 * (using an optimized request size for RDMA as well though).
> -	 */
> -	const uint tsize = 0;
> -	const uint rsize = c->trans_mod->pooled_rbuffers ? c->msize : 0;
>  
>  	va_start(ap, fmt);
> -	req = p9_client_prepare_req(c, type, tsize, rsize, fmt, ap);
> +	/* auto determine an appropriate request/response size */
> +	req = p9_client_prepare_req(c, type, 0, 0, fmt, ap);
>  	va_end(ap);
>  	if (IS_ERR(req))
>  		return req;
> 


