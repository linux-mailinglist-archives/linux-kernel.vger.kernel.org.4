Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D744633340
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiKVC0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiKVC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:26:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6AE1235
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35138B818E7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:23:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F244C433D6;
        Tue, 22 Nov 2022 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669083781;
        bh=I7YL3bCCeJLisRqnPwuXs7B4Zp+B67ITumrFT7w6sqg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gi8ir3+/8iN5kIl4rz24XcNBNG2WqmFDqg06GajceHVzR0sDg9jmi9lhyYuA65fDE
         4cfm5SAdTEY1q/1B1nJv4X/rUvLMWUAdR+TljW3ZjxWnYZpsFMfbf6Nwtgeqm7bGeO
         QnOhi9dvdfdtP4f8KNPVw+PCgmCJNY+HpgwoXngiQbBaUtUTttlV/UAi7vLUXKdCJr
         c9xdlDf8nzJw7ClZSDLsOQAjJ0dfLfPMfqU15gtYxKju97fDHx+AJA9YODDPayNRf1
         VNtOEwJycXqWe8SQui6NMbfYeNAPvPXdcImVOCrrLxVLC/X0ONswdBp7g0TAvcA4UY
         x/WsplDl5gEOw==
Date:   Mon, 21 Nov 2022 18:22:59 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/xen: do not memcpy header into req->rc
In-Reply-To: <20221122001025.119121-1-asmadeus@codewreck.org>
Message-ID: <alpine.DEB.2.22.394.2211211822510.1049131@ubuntu-linux-20-04-desktop>
References: <20221122001025.119121-1-asmadeus@codewreck.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022, Dominique Martinet wrote:
> while 'h' is packed and can be assumed to match the request payload,
> req->rc is a struct p9_fcall which is not packed and that memcpy
> could be wrong.
> 
> Fix this by copying each fields individually instead.
> 
> Reported-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Suggested-by: Stefano Stabellini <sstabellini@kernel.org>
> Link: https://lkml.kernel.org/r/alpine.DEB.2.22.394.2211211454540.1049131@ubuntu-linux-20-04-desktop
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> Follow up from the previous xen patch's review.
> 
> This isn't an immediate fix so I don't think this one should be rushed
> in with the rest of the overflow fixes -- I'll let this sit a bit in
> -next after reviews.
> 
>  net/9p/trans_xen.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index 4665215bc98b..e8e3f54a837e 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -216,7 +216,9 @@ static void p9_xen_response(struct work_struct *work)
>  			goto recv_error;
>  		}
>  
> -		memcpy(&req->rc, &h, sizeof(h));
> +		req->rc.size = h.size;
> +		req->rc.id = h.id;
> +		req->rc.tag = h.tag;
>  		req->rc.offset = 0;
>  
>  		masked_cons = xen_9pfs_mask(cons, XEN_9PFS_RING_SIZE(ring));
> -- 
> 2.35.1
> 
