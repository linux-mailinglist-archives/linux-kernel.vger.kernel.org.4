Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1326771C8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjAVTRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjAVTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:17:07 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0016017140;
        Sun, 22 Jan 2023 11:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674415017; bh=c1IRj/bXs0ZSnBzNS6Vm6yrTRBHjo0gnt7Wwh6wxKNY=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=nNozw9Nwl+1DCds7iMk1s9TIhXB5hLPZp7L54uWiwhyebNbPTpCtqXWcenVm2/65k
         FY9ug+2hKn2TvKlAdHbUwEZ6+uf8aIAufBKAj18q6CvBpTWnB+XTTkhIwst4m3KiBv
         P7hBGC0FwHrrSu7Stq+0/zPo6MLXDLXV5wdEG++w=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 20:16:57 +0100 (CET)
X-EA-Auth: lsVo5PQ3/JpvafZJkIhgD9/MbsoLUtOI5uigvOhUb9vByVwrHNpBZkXelbNH8jRvWvSgn61MHDPamW/fr4AICvQUxXmDPjAZ
Date:   Mon, 23 Jan 2023 00:46:53 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH v2] scsi: Replace printk+WARN_ON by WARN macro
Message-ID: <Y82LpRtFFux4wUaD@ubun2204.myguest.virtualbox.org>
References: <Y7sj22gCmnYqTzP4@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7sj22gCmnYqTzP4@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 01:43:15AM +0530, Deepak R Varma wrote:
> A combination of printk() followed by WARN_ON() macro can be simplified
> using a single WARN(1, ...) macro. Patch change suggested by warn.cocci
> Coccinelle semantic patch.
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Changes in v2:
>    - Remove printk() from the WARN macro to avoid build warning
>    - I missed to build the change before sending the earlier version which
>      results in a build error due to incorrect brace balancing. Fixed it.

Hello,
May I request a review and feedback comments on this patch proposal?

Thank you,
./drv

> 
>  drivers/scsi/initio.c   | 3 +--
>  drivers/scsi/scsi_lib.c | 6 ++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
> index 375261d67619..fea591d9d292 100644
> --- a/drivers/scsi/initio.c
> +++ b/drivers/scsi/initio.c
> @@ -2738,8 +2738,7 @@ static void i91uSCBPost(u8 * host_mem, u8 * cblk_mem)
>  	host = (struct initio_host *) host_mem;
>  	cblk = (struct scsi_ctrl_blk *) cblk_mem;
>  	if ((cmnd = cblk->srb) == NULL) {
> -		printk(KERN_ERR "i91uSCBPost: SRB pointer is empty\n");
> -		WARN_ON(1);
> +		WARN(1, KERN_ERR "i91uSCBPost: SRB pointer is empty\n");
>  		initio_release_scb(host, cblk);	/* Release SCB for current channel */
>  		return;
>  	}
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 9ed1ebcb7443..0f1e9ee4591b 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -3009,10 +3009,8 @@ void *scsi_kmap_atomic_sg(struct scatterlist *sgl, int sg_count,
>  	}
>  
>  	if (unlikely(i == sg_count)) {
> -		printk(KERN_ERR "%s: Bytes in sg: %zu, requested offset %zu, "
> -			"elements %d\n",
> -		       __func__, sg_len, *offset, sg_count);
> -		WARN_ON(1);
> +		WARN(1, KERN_ERR "%s: Bytes in sg: %zu, requested offset %zu, elements %d\n",
> +				__func__, sg_len, *offset, sg_count);
>  		return NULL;
>  	}
>  
> -- 
> 2.34.1
> 
> 
> 


