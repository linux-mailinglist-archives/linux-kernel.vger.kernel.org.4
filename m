Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0355630909
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiKSB7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiKSB7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:59:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DFF52158
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:51:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 028876281A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB0C433C1;
        Sat, 19 Nov 2022 01:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668822709;
        bh=fu4/1HaWI/LLlnuYvXu79voRYXVtVGUZKyjH9vTasoM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R3AFQQNEcNF2LnJUMTAZokYAWadmAkmKK4gPM2aQmN9jCLuAf+rcHJdcHOOxejYiX
         ymbtzWntiXyCR8SrAH9BfOiCl5hSubps0q7aiyEPOF+lV3WK6poQ1WxmBcB6k7X64e
         /7mIlkKmHKUAUJYbgCJlkLQ4H0h5XwBn8YcH76biJ9ghKlM+TY0LehVaWGihkTnt3G
         PeLsXjtkruRaOuIuLTWqEb233ATJY7Kvj9unkVsXP4v7QgkIpKqLNnAU3Eys0ZD3sk
         z7F03SQcBBnaKacA63ihlXIKDRr1NK/tz/Y9dMmHZDx/zExiuzm4d4MLSK7U2m22zA
         eASV1MyypSgdA==
Date:   Fri, 18 Nov 2022 17:51:46 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        GUO Zihua <guozihua@huawei.com>, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
In-Reply-To: <20221118135542.63400-1-asmadeus@codewreck.org>
Message-ID: <alpine.DEB.2.22.394.2211181713420.1049131@ubuntu-linux-20-04-desktop>
References: <20221118135542.63400-1-asmadeus@codewreck.org>
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

On Fri, 18 Nov 2022, Dominique Martinet wrote:
> trans_xen did not check the data fits into the buffer before copying
> from the xen ring, but we probably should.
> Add a check that just skips the request and return an error to
> userspace if it did not fit
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> 
> This comes more or less as a follow up of a fix for trans_fd:
> https://lkml.kernel.org/r/20221117091159.31533-1-guozihua@huawei.com
> Where msize should be replaced by capacity check, except trans_xen
> did not actually use to check the size fits at all.
> 
> While we normally trust the hypervisor (they can probably do whatever
> they want with our memory), a bug in the 9p server is always possible so
> sanity checks never hurt, especially now buffers got drastically smaller
> with a recent patch.
> 
> My setup for xen is unfortunately long dead so I cannot test this:
> Stefano, you've tested v9fs xen patches in the past, would you mind
> verifying this works as well?
> 
>  net/9p/trans_xen.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> index b15c64128c3e..66ceb3b3ae30 100644
> --- a/net/9p/trans_xen.c
> +++ b/net/9p/trans_xen.c
> @@ -208,6 +208,14 @@ static void p9_xen_response(struct work_struct *work)
>  			continue;
>  		}
>  
> +		if (h.size > req->rc.capacity) {
> +			dev_warn(&priv->dev->dev,
> +				 "requested packet size too big: %d for tag %d with capacity %zd\n",
> +		                 h.size, h.tag, rreq->rc.capacity);

"req" instead of "rreq"

I made this change and tried the two patches together. Unfortunately I
get the following error as soon as I try to write a file:

/bin/sh: can't create /mnt/file: Input/output error


Next I reverted the second patch and only kept this patch. With that, it
worked as usual. It looks like the second patch is the problem. I have
not investigated further.



> +			req->status = REQ_STATUS_ERROR;
> +			goto recv_error;
> +		}
> +
>  		memcpy(&req->rc, &h, sizeof(h));
>  		req->rc.offset = 0;
>  
> @@ -217,6 +225,7 @@ static void p9_xen_response(struct work_struct *work)
>  				     masked_prod, &masked_cons,
>  				     XEN_9PFS_RING_SIZE(ring));
>  
> +recv_error:
>  		virt_mb();
>  		cons += h.size;
>  		ring->intf->in_cons = cons;
> -- 
> 2.38.1
> 
