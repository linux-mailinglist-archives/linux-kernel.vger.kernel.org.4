Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA1694E55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBMRrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:47:34 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561BB1C312
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=A5df1yTIZD9wAyLTiI9WcLrb+WZ3/VTbUZ/qbUROp8w=; b=C4K8k+rtBUYTFU+iQu5F+kYFhj
        2DZHAIyak88UeJ7ohRtfc+kj9gm6eOtZq/BmFAeDtDFfnUTLW9Hmlr4F5VQVa606yjkMuKaNDRzCT
        6EsaOhaguz0wZ+5YpXB1dwsIa9zC6KoMfzhSA5Gtdik1pSjrk7roWUADvmU8Zxn8akghvcJhKdCt2
        uBjDVTuyJelFnyfkNfSqxmK14O3xJJ2qh8t9J8bLi3B2S3M1QZWJ0l2PDItEzQImdnCQ7ysybjDb/
        iNlm3P3KoB9bqll6rYKruGF1g1Q1KgWm8gOMMrT9Tl4vcSKT7hXIFZmMr6WR4IVIxOAx+E4m8AePo
        W3VvsuQbAz8k5zL4q84qv6OQlR4o08b4SE1vLsOPK9G+VwrSFpRXifkPKd3/CjoWVOlNJlhByez8x
        /DR1/l9M3XmT5sJ5201ztvBeUy1SliOxNbW+c2MYAJfol0HOwpYC4Kkl14MkoKbmzsKVlRGbM4Tx/
        drx1FLUAfU56Owji1zc65TyfcYo6i74oWzSPS1vCfcl82ErkmLu24pDtduCha4Xl68Khr1U0bVWn+
        I4gzh+qQ6xbizvrZUpvPWXRBG8b8NMPm8yMsV0X2DHs2fGSur2rIg+4YH4KaHffWpYyc4C91+sUzz
        1EaroH3VDG5E/rJ7UcT7V/SRBT2iQo61/K3JLA3uc=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 1/5] 9p/net: move code in preparation of async rpc
Date:   Mon, 13 Feb 2023 18:46:13 +0100
Message-ID: <1847623.mNM4OxGzmo@silver>
In-Reply-To: <20230211075023.137253-2-asmadeus@codewreck.org>
References: <20230211075023.137253-1-asmadeus@codewreck.org>
 <20230211075023.137253-2-asmadeus@codewreck.org>
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

On Saturday, February 11, 2023 8:50:19 AM CET Dominique Martinet wrote:
> This commit containers no code change:
>  - move p9_fid_* higher in code as p9_fid_destroy will be used
> in async callback

I would have just added p9_fid_destroy()'s prototype earlier in code instead
of moving stuff around:

static void p9_fid_destroy(struct p9_fid *fid);

Because that would not mess with 'git blame' history. But anyway, it's just
restructuring, no behaviour change, so:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

>  - move p9_client_flush as it will no longer call p9_client_rpc
> and can simplify forward declaration a bit later
> 
> This just simplifies the next commits to make diffs cleaner.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  net/9p/client.c | 198 ++++++++++++++++++++++++------------------------
>  1 file changed, 99 insertions(+), 99 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 622ec6a586ee..53ebd07c36ee 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -428,6 +428,66 @@ static void p9_tag_cleanup(struct p9_client *c)
>  	rcu_read_unlock();
>  }
>  
> +static struct p9_fid *p9_fid_create(struct p9_client *clnt)
> +{
> +	int ret;
> +	struct p9_fid *fid;
> +
> +	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
> +	fid = kzalloc(sizeof(*fid), GFP_KERNEL);
> +	if (!fid)
> +		return NULL;
> +
> +	fid->mode = -1;
> +	fid->uid = current_fsuid();
> +	fid->clnt = clnt;
> +	refcount_set(&fid->count, 1);
> +
> +	idr_preload(GFP_KERNEL);
> +	spin_lock_irq(&clnt->lock);
> +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
> +			    GFP_NOWAIT);
> +	spin_unlock_irq(&clnt->lock);
> +	idr_preload_end();
> +	if (!ret) {
> +		trace_9p_fid_ref(fid, P9_FID_REF_CREATE);
> +		return fid;
> +	}
> +
> +	kfree(fid);
> +	return NULL;
> +}
> +
> +static void p9_fid_destroy(struct p9_fid *fid)
> +{
> +	struct p9_client *clnt;
> +	unsigned long flags;
> +
> +	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
> +	trace_9p_fid_ref(fid, P9_FID_REF_DESTROY);
> +	clnt = fid->clnt;
> +	spin_lock_irqsave(&clnt->lock, flags);
> +	idr_remove(&clnt->fids, fid->fid);
> +	spin_unlock_irqrestore(&clnt->lock, flags);
> +	kfree(fid->rdir);
> +	kfree(fid);
> +}
> +
> +/* We also need to export tracepoint symbols for tracepoint_enabled() */
> +EXPORT_TRACEPOINT_SYMBOL(9p_fid_ref);
> +
> +void do_trace_9p_fid_get(struct p9_fid *fid)
> +{
> +	trace_9p_fid_ref(fid, P9_FID_REF_GET);
> +}
> +EXPORT_SYMBOL(do_trace_9p_fid_get);
> +
> +void do_trace_9p_fid_put(struct p9_fid *fid)
> +{
> +	trace_9p_fid_ref(fid, P9_FID_REF_PUT);
> +}
> +EXPORT_SYMBOL(do_trace_9p_fid_put);
> +
>  /**
>   * p9_client_cb - call back from transport to client
>   * @c: client state
> @@ -570,6 +630,45 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  	return err;
>  }
>  
> +static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
> +					      int8_t type, uint t_size, uint r_size,
> +					      const char *fmt, va_list ap)
> +{
> +	int err;
> +	struct p9_req_t *req;
> +	va_list apc;
> +
> +	p9_debug(P9_DEBUG_MUX, "client %p op %d\n", c, type);
> +
> +	/* we allow for any status other than disconnected */
> +	if (c->status == Disconnected)
> +		return ERR_PTR(-EIO);
> +
> +	/* if status is begin_disconnected we allow only clunk request */
> +	if (c->status == BeginDisconnect && type != P9_TCLUNK)
> +		return ERR_PTR(-EIO);
> +
> +	va_copy(apc, ap);
> +	req = p9_tag_alloc(c, type, t_size, r_size, fmt, apc);
> +	va_end(apc);
> +	if (IS_ERR(req))
> +		return req;
> +
> +	/* marshall the data */
> +	p9pdu_prepare(&req->tc, req->tc.tag, type);
> +	err = p9pdu_vwritef(&req->tc, c->proto_version, fmt, ap);
> +	if (err)
> +		goto reterr;
> +	p9pdu_finalize(c, &req->tc);
> +	trace_9p_client_req(c, type, req->tc.tag);
> +	return req;
> +reterr:
> +	p9_req_put(c, req);
> +	/* We have to put also the 2nd reference as it won't be used */
> +	p9_req_put(c, req);
> +	return ERR_PTR(err);
> +}
> +
>  static struct p9_req_t *
>  p9_client_rpc(struct p9_client *c, int8_t type, const char *fmt, ...);
>  
> @@ -613,45 +712,6 @@ static int p9_client_flush(struct p9_client *c, struct p9_req_t *oldreq)
>  	return 0;
>  }
>  
> -static struct p9_req_t *p9_client_prepare_req(struct p9_client *c,
> -					      int8_t type, uint t_size, uint r_size,
> -					      const char *fmt, va_list ap)
> -{
> -	int err;
> -	struct p9_req_t *req;
> -	va_list apc;
> -
> -	p9_debug(P9_DEBUG_MUX, "client %p op %d\n", c, type);
> -
> -	/* we allow for any status other than disconnected */
> -	if (c->status == Disconnected)
> -		return ERR_PTR(-EIO);
> -
> -	/* if status is begin_disconnected we allow only clunk request */
> -	if (c->status == BeginDisconnect && type != P9_TCLUNK)
> -		return ERR_PTR(-EIO);
> -
> -	va_copy(apc, ap);
> -	req = p9_tag_alloc(c, type, t_size, r_size, fmt, apc);
> -	va_end(apc);
> -	if (IS_ERR(req))
> -		return req;
> -
> -	/* marshall the data */
> -	p9pdu_prepare(&req->tc, req->tc.tag, type);
> -	err = p9pdu_vwritef(&req->tc, c->proto_version, fmt, ap);
> -	if (err)
> -		goto reterr;
> -	p9pdu_finalize(c, &req->tc);
> -	trace_9p_client_req(c, type, req->tc.tag);
> -	return req;
> -reterr:
> -	p9_req_put(c, req);
> -	/* We have to put also the 2nd reference as it won't be used */
> -	p9_req_put(c, req);
> -	return ERR_PTR(err);
> -}
> -
>  /**
>   * p9_client_rpc - issue a request and wait for a response
>   * @c: client session
> @@ -838,66 +898,6 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  	return ERR_PTR(safe_errno(err));
>  }
>  
> -static struct p9_fid *p9_fid_create(struct p9_client *clnt)
> -{
> -	int ret;
> -	struct p9_fid *fid;
> -
> -	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
> -	fid = kzalloc(sizeof(*fid), GFP_KERNEL);
> -	if (!fid)
> -		return NULL;
> -
> -	fid->mode = -1;
> -	fid->uid = current_fsuid();
> -	fid->clnt = clnt;
> -	refcount_set(&fid->count, 1);
> -
> -	idr_preload(GFP_KERNEL);
> -	spin_lock_irq(&clnt->lock);
> -	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
> -			    GFP_NOWAIT);
> -	spin_unlock_irq(&clnt->lock);
> -	idr_preload_end();
> -	if (!ret) {
> -		trace_9p_fid_ref(fid, P9_FID_REF_CREATE);
> -		return fid;
> -	}
> -
> -	kfree(fid);
> -	return NULL;
> -}
> -
> -static void p9_fid_destroy(struct p9_fid *fid)
> -{
> -	struct p9_client *clnt;
> -	unsigned long flags;
> -
> -	p9_debug(P9_DEBUG_FID, "fid %d\n", fid->fid);
> -	trace_9p_fid_ref(fid, P9_FID_REF_DESTROY);
> -	clnt = fid->clnt;
> -	spin_lock_irqsave(&clnt->lock, flags);
> -	idr_remove(&clnt->fids, fid->fid);
> -	spin_unlock_irqrestore(&clnt->lock, flags);
> -	kfree(fid->rdir);
> -	kfree(fid);
> -}
> -
> -/* We also need to export tracepoint symbols for tracepoint_enabled() */
> -EXPORT_TRACEPOINT_SYMBOL(9p_fid_ref);
> -
> -void do_trace_9p_fid_get(struct p9_fid *fid)
> -{
> -	trace_9p_fid_ref(fid, P9_FID_REF_GET);
> -}
> -EXPORT_SYMBOL(do_trace_9p_fid_get);
> -
> -void do_trace_9p_fid_put(struct p9_fid *fid)
> -{
> -	trace_9p_fid_ref(fid, P9_FID_REF_PUT);
> -}
> -EXPORT_SYMBOL(do_trace_9p_fid_put);
> -
>  static int p9_client_version(struct p9_client *c)
>  {
>  	int err = 0;
> 


