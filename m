Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C8633149
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiKVAWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiKVAWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:22:14 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3BB0409
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:22:05 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 11C74C009; Tue, 22 Nov 2022 01:22:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669076531; bh=vM/wC+9ICJ1E4nrONeaPjLJNoVIGOsJr7BNc+BzMDJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIjKLPrsg3FMz7iYQrv8nJOeLWQJeV7HrP5gu7PUgAR19sM8DbYU9xaTI29HkTqRu
         5sFafQw0OYQMYbTmIaEJGFR5lcSxbXFuOzyZyxvgZCiZsg4z+Y6txnBBeZGM4Pry44
         cy9R5z0TGsRnuj8tC1CYcyHXRwDyCJYRmrTxqpwgtITtpAImkfvW0RXLnvZjXa/TOM
         xQjeRiepZw4ehmhrod1t/WS1/AnCPCfBqAJ96KuYXgQF11JaVF+DsP3lJ5I41Gr/oG
         dhowSN7yjtbIlh0sPEMTgwO7BZNGTpsSLg/crOlGRbeKFjYjkEaxmRonxL/4C7zWFJ
         gJpvn1U4s9+Bw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 82C4DC009;
        Tue, 22 Nov 2022 01:22:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1669076530; bh=vM/wC+9ICJ1E4nrONeaPjLJNoVIGOsJr7BNc+BzMDJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Azpd+Ag7r50uyVvo3SYjrM1ns9DPJ9H8KV5jIAgDPd/2FctqIxvaTYOGd11KUrGTx
         e6SGxZOqtm0DUcJp2hrHcKc2sAlwJs4hEQcJ7fSQdEq3yIPGP4lV8TculjCIXJlmUL
         LhY7MFumlAFAKhMMwAH7MT2oXym6cgv3XRvhxMGVPiLBDrfIdiiv84KwIm4f8r6L5s
         wgb5rpWaANh9zHqWM0YLOe13T8No3FIWellJPs6T17H1fh3K/VgXiSo1X0AlZkn3GK
         5+0a2DT+mOOcz+VYF+Rsrbn1U72uZ4X+auOJjugnUi+v2S2lgTgUOth1fUwlA76hv3
         6yxZHHFg5VkRA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id fe24522f;
        Tue, 22 Nov 2022 00:21:59 +0000 (UTC)
Date:   Tue, 22 Nov 2022 09:21:43 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH 2/2] net/9p: fix response size check in p9_check_errors()
Message-ID: <Y3wWFxRVpei71PQt@codewreck.org>
References: <cover.1669072186.git.linux_oss@crudebyte.com>
 <fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss@crudebyte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fffb512c532bf1290f0f2b1df6068b2ff6cd14c0.1669072186.git.linux_oss@crudebyte.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schoenebeck wrote on Tue, Nov 22, 2022 at 12:04:08AM +0100:
> Since 60ece0833b6c (net/9p: allocate appropriate reduced message buffers)
> it is no longer appropriate to check server's response size against
> msize. Check against the previously allocated buffer capacity instead.

Thanks for the follow up!

>  - Omit this size check entirely for zero-copy messages, as those always
>    allocate 4k (P9_ZC_HDR_SZ) linear buffers which are not used for actual
>    payload and can be much bigger than 4k.

[review includes the new flag patch]

hmm, unless there's anywhere else you think we might use these flags it
looks simpler to just pass a flag to p9_check_errors?

In particular adding a bool in this position is not particularly efficient:
-------(pahole)-----
struct p9_fcall {
	u32                        size;                 /*     0     4 */
	u8                         id;                   /*     4     1 */

	/* XXX 1 byte hole, try to pack */

	u16                        tag;                  /*     6     2 */
	size_t                     offset;               /*     8     8 */
	size_t                     capacity;             /*    16     8 */
	bool                       zc;                   /*    24     1 */

	/* XXX 7 bytes hole, try to pack */

	struct kmem_cache *        cache;                /*    32     8 */
	u8 *                       sdata;                /*    40     8 */

	/* size: 48, cachelines: 1, members: 8 */
	/* sum members: 40, holes: 2, sum holes: 8 */
	/* last cacheline: 48 bytes */
};
----------------
Not that adding it between id and tag sounds better to me, so this is
probably just as good as anywhere else :-D

Anyway, I'm just nitpicking -- on principle I agree just whitelisting zc
requests from this check makes most sense, happy with either way if you
think this is better for the future.

>  - Replace p9_debug() by pr_err() to make sure this message is always
>    printed in case this error is triggered.
> 
>  - Add 9p message type to error message to ease investigation.

Yes to these log changes!

> 
> Signed-off-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> ---
>  net/9p/client.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 30dd82f49b28..63f13dd1ecff 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -514,10 +514,10 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
>  	int ecode;
>  
>  	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
> -	if (req->rc.size >= c->msize) {
> -		p9_debug(P9_DEBUG_ERROR,
> -			 "requested packet size too big: %d\n",
> -			 req->rc.size);
> +	if (req->rc.size > req->rc.capacity && !req->rc.zc) {
> +		pr_err(
> +			 "requested packet size too big: %d does not fit %ld (type=%d)\n",
> +			 req->rc.size, req->rc.capacity, req->rc.id);

Haven't seen this style before -- is that what qemu uses?
We normally keep the message on first line and align e.g.
> +             pr_err("requested packet size too big: %d does not fit %ld (type=%d)\n",
> +                    req->rc.size, req->rc.capacity, req->rc.id);

(at least what's what other grep -A 1 'pr_err.*,$' seem to do, and
checkpatch is happier with that)

-- 
Dominique
