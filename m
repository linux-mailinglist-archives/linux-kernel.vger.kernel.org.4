Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED50630CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiKSHKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiKSHKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:10:47 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981F19AC89
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 23:10:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so6865813pgh.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 23:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLfutM//l1JeLmYWgcuF3keAYqBydnpWS3SIvHEVczA=;
        b=S3hjkax/ZPmxaSs5nifMGwDU7dk06fLWe1zX6DFNrd15t61R66RRZ1ulSrZyGoV6pw
         L7pS15YDK5beihv9j1NBTK9B10VkJ6w2sERXe1w7QKhhkiAGcUtjLd3P1XmswdrJORf3
         53MnGnoiHgkb2GISy6n04DPLrqnxF45Q0W0qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLfutM//l1JeLmYWgcuF3keAYqBydnpWS3SIvHEVczA=;
        b=xm/kfj7d1wAKl6FkEyj7vCbeCQsTX7J6bRM4FvJj1n8P5pwIzP405EvbnVaE72Wzww
         dXx1BLEU4x6E9Mj7Ade8FxvXwiA4e3rBZjGa5y5nEAVm8PR1jp1r/gSHb9DKFv1dOXLA
         twe1gkbgPAF/e9PckEIiYOEyQ+bBQKMOLz7VesGvwO2A3liTI0TlEAS75n7KXjJ2wZSy
         aPLCm//95ENjGowTZ1fUDE0THgXN5SF5ufwlMdL8t+79wKiQFwRSMXM0jwQwr0X7OlQm
         hb9ZfGa5icnpJ6Ly7t5mtg0aThtnkFHEIJYJuhg/I0w8gvi33Ujju4J2ypPpJdVQ7hYI
         bH7g==
X-Gm-Message-State: ANoB5pkssl5DhOWP1ya3kIZ80E1QeHMzDMKJTHK6k1jKyuV1lfnz7o91
        jGW6w7V9Y40J8Hn6YSHZLuzr2w==
X-Google-Smtp-Source: AA0mqf5RYXmLx5MpjORrRWarR/rPeq8OtvX90H+TAgrog/B/dRcti0U+2lIYzfS0HhYQY1Mr7Z6OeQ==
X-Received: by 2002:a62:a515:0:b0:56e:28b1:56a3 with SMTP id v21-20020a62a515000000b0056e28b156a3mr11283867pfm.43.1668841845821;
        Fri, 18 Nov 2022 23:10:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b0017f73dc1549sm4934138plf.263.2022.11.18.23.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 23:10:45 -0800 (PST)
Date:   Fri, 18 Nov 2022 23:10:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] scsi: qla2xxx: Use struct_size() in code
 related to struct ct_sns_gpnft_rsp
Message-ID: <202211182309.D5AC082E3@keescook>
References: <cover.1668814746.git.gustavoars@kernel.org>
 <9bd4775fe9c88b33c3194f841a2ec2f559d58032.1668814746.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bd4775fe9c88b33c3194f841a2ec2f559d58032.1668814746.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 05:47:56PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/qla2xxx/qla_gs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
> index 69d3bc795f90..27e1df56b0fb 100644
> --- a/drivers/scsi/qla2xxx/qla_gs.c
> +++ b/drivers/scsi/qla2xxx/qla_gs.c
> @@ -4072,9 +4072,8 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
>  		}
>  		sp->u.iocb_cmd.u.ctarg.req_size = GPN_FT_REQ_SIZE;
>  
> -		rspsz = sizeof(struct ct_sns_gpnft_rsp) +
> -			(vha->hw->max_fibre_devices *
> -			    sizeof(struct ct_sns_gpn_ft_data));
> +		rspsz = struct_size((struct ct_sns_gpnft_rsp *)0, entries,
> +				vha->hw->max_fibre_devices);

This should be able to use sp->u.iocb_cmd.u.ctarg.rsp instead of the
explicit struct with a NULL. (It's just using typeof() internally, so
it's okay that it isn't allocated yet.)

-Kees

>  
>  		sp->u.iocb_cmd.u.ctarg.rsp = dma_alloc_coherent(&vha->hw->pdev->dev,
>  								rspsz,
> -- 
> 2.34.1
> 

-- 
Kees Cook
