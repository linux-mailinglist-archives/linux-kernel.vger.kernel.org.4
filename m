Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3B17419CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjF1Uj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjF1Uiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:38:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE32D54
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:36:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666683eb028so157445b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687984600; x=1690576600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FTd9gs+JLXNSUN9G5qmFwQT5UBGhyuUIDz3ia4Gn7nk=;
        b=GPy0Zf6gjV4znmNrJ1uBnnE0LvBnybeQ1VjgDHwQPY9pQVO6/fVUBkUcT4X+n5ZfLX
         hRQOO671JUQStKch9ipzQpLyLpbSsGljyL4pdK2TiPGy2XOiPhanu4Ef0GUfz7Z9kF+p
         hUsMCS8Gt9BC23RH13wgHBzwftfJ7L4/Z0Q3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984600; x=1690576600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTd9gs+JLXNSUN9G5qmFwQT5UBGhyuUIDz3ia4Gn7nk=;
        b=WUs+dFGHLk+IRKqGcu90n1nWoCZvzwAo8J/7qBzTtI/7/isc1grmddKyirX7pNH1xG
         nS306K2Dd5C/3xjYrLGJfYT43JGXw1IYTkE6Oowls2/e3pRhHewJ2CR3lHYQy3BHpJe3
         YPLTCjLKFWCdLNXrOoFr0DqCLI070BKA2jTy4Ezij4YxmH6FKSr0OsomldaXs/0iOtXH
         A8ZebHGFQ3fYl7ODkQFIps9KfH93A3uZMaNYAeggCF/HoGW7qdJEz7Fv4fTB9RYcaL4F
         H6dxhSQPnJsCEOaE9CCTNqI5wuC0mx/scVPEEiP8JeUWjnBfj4z7FakVBZBxEeTyn4I6
         TPxA==
X-Gm-Message-State: AC+VfDzQPSHexnvX0s+pkkZAb2sj/8Pyj0BUSvY4bPYJ8H/a6uEYhB+u
        Ufe7wkzKpa1Mq2IggMSvHeOtTg==
X-Google-Smtp-Source: ACHHUZ5JSbI0ce1k8EZnnUwzRJCg/C5b0Pk7W1P4b4v1+xpCWmFrgeIE5+NVstSZtJr6q2KkuC/hvQ==
X-Received: by 2002:a05:6a20:144a:b0:122:d1c3:59e9 with SMTP id a10-20020a056a20144a00b00122d1c359e9mr21993643pzi.1.1687984600238;
        Wed, 28 Jun 2023 13:36:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x48-20020a056a000bf000b0064d32771fa8sm2814288pfu.134.2023.06.28.13.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:36:39 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:36:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 08/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct sgmap
Message-ID: <202306281311.3A69CB64@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <0c7402fe6448186cda5a2618a35eb5f8d1cbb313.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7402fe6448186cda5a2618a35eb5f8d1cbb313.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:57:13AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> sgmap and refactor the rest of the code, accordingly.
> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.

This change _does_ have binary output differences, although it looks
like you got most of them. I still see:

commsup.o:
-       mov    $0x40,%edx
+       mov    $0x38,%edx

This appears to be the sizeof() here:

        ret = aac_fib_send(ScsiPortCommand64, fibptr, sizeof(struct aac_srb),
                                FsaNormal, 1, 1, NULL, NULL);

struct aac_srb includes struct sgmap. I think this needs to explicitly
include the 1 sgmap, which seems to be sent in the fibptr:

        srbcmd = (struct aac_srb *)fib_data(fibptr);
	...
        sg64 = (struct sgmap64 *)&srbcmd->sg;
        sg64->count = cpu_to_le32(1);

i.e. "sending 1". This seems to fix it:

-       ret = aac_fib_send(ScsiPortCommand64, fibptr, sizeof(struct aac_srb),
+       ret = aac_fib_send(ScsiPortCommand64, fibptr,
+                               struct_size(srbcmd, sg.sg, 1),

Then I see changes in both aac_write_block() and aac_scsi_32(), but they
match the changes you made to get the correct size (it's just an easier
calculation for the compiler to perform, so the code is slightly
simplified).

So I think with the hunk I suggested at the start, and a comment on the
(expected) binary changes, this should be good to go.

-Kees

> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/aacraid/aachba.c   | 24 ++++++++++--------------
>  drivers/scsi/aacraid/aacraid.h  |  2 +-
>  drivers/scsi/aacraid/commctrl.c |  4 ++--
>  drivers/scsi/aacraid/comminit.c |  3 +--
>  4 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
> index 03ba974f6b2a..b2849e5cc104 100644
> --- a/drivers/scsi/aacraid/aachba.c
> +++ b/drivers/scsi/aacraid/aachba.c
> @@ -1336,8 +1336,7 @@ static int aac_read_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32
>  	if (ret < 0)
>  		return ret;
>  	fibsize = sizeof(struct aac_read) +
> -			((le32_to_cpu(readcmd->sg.count) - 1) *
> -			 sizeof (struct sgentry));
> +		  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentry);
>  	BUG_ON (fibsize > (fib->dev->max_fib_size -
>  				sizeof(struct aac_fibhdr)));
>  	/*
> @@ -1471,8 +1470,7 @@ static int aac_write_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
>  	if (ret < 0)
>  		return ret;
>  	fibsize = sizeof(struct aac_write) +
> -		((le32_to_cpu(writecmd->sg.count) - 1) *
> -		 sizeof (struct sgentry));
> +		  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentry);
>  	BUG_ON (fibsize > (fib->dev->max_fib_size -
>  				sizeof(struct aac_fibhdr)));
>  	/*
> @@ -1590,9 +1588,9 @@ static int aac_scsi_64(struct fib * fib, struct scsi_cmnd * cmd)
>  	/*
>  	 *	Build Scatter/Gather list
>  	 */
> -	fibsize = sizeof (struct aac_srb) - sizeof (struct sgentry) +
> -		((le32_to_cpu(srbcmd->sg.count) & 0xff) *
> -		 sizeof (struct sgentry64));
> +	fibsize = sizeof(struct aac_srb) +
> +		  (le32_to_cpu(srbcmd->sg.count) & 0xff) *
> +		  sizeof(struct sgentry64);
>  	BUG_ON (fibsize > (fib->dev->max_fib_size -
>  				sizeof(struct aac_fibhdr)));
>  
> @@ -1621,9 +1619,9 @@ static int aac_scsi_32(struct fib * fib, struct scsi_cmnd * cmd)
>  	/*
>  	 *	Build Scatter/Gather list
>  	 */
> -	fibsize = sizeof (struct aac_srb) +
> -		(((le32_to_cpu(srbcmd->sg.count) & 0xff) - 1) *
> -		 sizeof (struct sgentry));
> +	fibsize = sizeof(struct aac_srb) +
> +		  (le32_to_cpu(srbcmd->sg.count) & 0xff) *
> +		  sizeof(struct sgentry);
>  	BUG_ON (fibsize > (fib->dev->max_fib_size -
>  				sizeof(struct aac_fibhdr)));
>  
> @@ -1691,8 +1689,7 @@ static int aac_send_safw_bmic_cmd(struct aac_dev *dev,
>  	fibptr->hw_fib_va->header.XferState &=
>  		~cpu_to_le32(FastResponseCapable);
>  
> -	fibsize  = sizeof(struct aac_srb) - sizeof(struct sgentry) +
> -						sizeof(struct sgentry64);
> +	fibsize  = sizeof(struct aac_srb) + sizeof(struct sgentry64);
>  
>  	/* allocate DMA buffer for response */
>  	addr = dma_map_single(&dev->pdev->dev, xfer_buf, xfer_len,
> @@ -2264,8 +2261,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
>  		dev->a_ops.adapter_bounds = aac_bounds_32;
>  		dev->scsi_host_ptr->sg_tablesize = (dev->max_fib_size -
>  			sizeof(struct aac_fibhdr) -
> -			sizeof(struct aac_write) + sizeof(struct sgentry)) /
> -				sizeof(struct sgentry);
> +			sizeof(struct aac_write)) / sizeof(struct sgentry);
>  		if (dev->dac_support) {
>  			dev->a_ops.adapter_read = aac_read_block64;
>  			dev->a_ops.adapter_write = aac_write_block64;
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index 94eb83d38be6..3fbc22ae72b6 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -507,7 +507,7 @@ struct sge_ieee1212 {
>  
>  struct sgmap {
>  	__le32		count;
> -	struct sgentry	sg[1];
> +	struct sgentry	sg[];
>  };
>  
>  struct user_sgmap {
> diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
> index e7cc927ed952..df811ad4afaa 100644
> --- a/drivers/scsi/aacraid/commctrl.c
> +++ b/drivers/scsi/aacraid/commctrl.c
> @@ -561,8 +561,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
>  		rcode = -EINVAL;
>  		goto cleanup;
>  	}
> -	actual_fibsize = sizeof(struct aac_srb) - sizeof(struct sgentry) +
> -		((user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry));
> +	actual_fibsize = sizeof(struct aac_srb) +
> +		(user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry);
>  	actual_fibsize64 = actual_fibsize + (user_srbcmd->sg.count & 0xff) *
>  	  (sizeof(struct sgentry64) - sizeof(struct sgentry));
>  	/* User made a mistake - should not continue */
> diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
> index bd99c5492b7d..d8dd89c87b01 100644
> --- a/drivers/scsi/aacraid/comminit.c
> +++ b/drivers/scsi/aacraid/comminit.c
> @@ -523,8 +523,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
>  	dev->max_fib_size = sizeof(struct hw_fib);
>  	dev->sg_tablesize = host->sg_tablesize = (dev->max_fib_size
>  		- sizeof(struct aac_fibhdr)
> -		- sizeof(struct aac_write) + sizeof(struct sgentry))
> -			/ sizeof(struct sgentry);
> +		- sizeof(struct aac_write)) / sizeof(struct sgentry);
>  	dev->comm_interface = AAC_COMM_PRODUCER;
>  	dev->raw_io_interface = dev->raw_io_64 = 0;
>  
> -- 
> 2.34.1
> 

-- 
Kees Cook
