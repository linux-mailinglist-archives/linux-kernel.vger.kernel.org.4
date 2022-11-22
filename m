Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1463D633AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKVK6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKVK6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:58:35 -0500
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE02D1E716
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=NFmQ4BHqkfYXHJbxs2dTDkAt9Y6OhHoJPxA7yM9/MD0=; b=jX5AbsTOTPWw97x7bnntdg6Lmp
        wB9CV0UkXgWqIYIaWdWNtep50iCxoweH1Bw3Z70pmgb4IxkMp5QinylflkFiG3BNkwKZ0gNXJePmy
        TMD+pd2zOCgszFCscGuEbG3QvEm1A8LHOBhbgyHhnHL23kXjm+35L6utQZdbSohCgkQBN9m1HwJKY
        p3vUAd8asloTPM1xYK5C77OfwdVmdIhWGuvS5tqiC2WJ0Aa+VM1+L8XxFEHuwqtp3I+xBETBK92Gt
        EQJDp2lX0duL0dQKb4VfKjEZ99Ds+zFajwSt51i3UrJmmU8nvX9Ftdd7kRUMIUATCyx9mOcnUbfh0
        +Os/QOg0uega6pFpISltbZbbz4sV8/8LniCX0ZKk3ARcrGSunOVnGVlag+qdNd9LB3hWXLp7a+23q
        Cq37lwRVvlw9Ul64L/j5AKuFB6bm3cbVqZSX7VWAAKYDToJAAMkErg51GiYXYGhSrKzh2THVmtybA
        z91ZYNE79pKVpAGwKNHvJho5QPcb7PF4NtdWpvLp9X0subBbxFFGMaSG3qZsABydiiioq+DkPnnks
        aVSQ+aodqK63mpX6dew2cX3sLzR2kuA4CQz3vPqdz8xdo1qBf6bLDEL8aQAwDiQBRIbC1qVOUTOAn
        HySKBI6Z0bFFvWYzBIzabnxCviroZ135WgCC3tu4M=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/xen: do not memcpy header into req->rc
Date:   Tue, 22 Nov 2022 11:58:26 +0100
Message-ID: <2044434.5qkcZKU06U@silver>
In-Reply-To: <20221122001025.119121-1-asmadeus@codewreck.org>
References: <20221122001025.119121-1-asmadeus@codewreck.org>
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

On Tuesday, November 22, 2022 1:10:25 AM CET Dominique Martinet wrote:
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
> ---

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

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
> 




