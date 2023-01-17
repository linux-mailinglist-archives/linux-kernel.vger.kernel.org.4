Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F2666E81D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjAQVDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjAQVCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:02:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EEF4A1F8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:29:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jl4so34567800plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRpqq+2LxugqpZNX3s+wDiUYVm6GWNq9r7NcJVznttI=;
        b=DDL10rALn1z1FRoOFnw2dnP+4blUFM0iSm4tQ+rKvADmrEBfKO4DE+cHNhsOUk/lZM
         2xlZ5mLD71Pan3w8wL/z1Z3QPjnt3q+svnrggrB32gsUHn7e+LA1RgeXFKfKp60gvb0c
         3BYQ+iVZEa1Ulyahd4XWoCOV7Yat17xcCUUXrfNxxqhTR2+tza0X6jlZ6grUng+a/y1y
         iY+FHGeS5IDHLwUsft7YY/YHKIsFpq8qKQPNSDdaWabVD1GEMZNexuHF3nx1sur5GuO4
         yYrwdnSb9kbKnEJ/wwYeoNqyRIgTVT1WOwHluYP/L902eOEFRKQ13yP5sfQSMYdqSDoB
         Djcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRpqq+2LxugqpZNX3s+wDiUYVm6GWNq9r7NcJVznttI=;
        b=DQicEFQCbizhsunQqqHp3T4vsQ3L/aBObqsh7UBX1hacZK8Dup+wuoiQweDr2W/SOk
         buXgjVJdbKvoDGefoG51GEFcOHoobSnsyyBjEsCQ+Jj0iPcs6AO67KAuFoC2It3DKBa2
         K+W2P+wVHhYK4Aw2NPrCc5NCHrJQ1gQnFxWIoLTLBA6veSkkp7SghQlfK+20XUiw9NAv
         PQlOV8VXcfawuMOYl+Pig+6iNYLBbO9nfC0dUAUsz0+/DrjiJ9rFBb/ZpLciehEVRQeK
         psrK7IeNqFtvLa9LS5Ff3fPaRdN2/grQMClfpGhva8UrPynMx8GN37vuutDzMDnf1rp4
         7JGA==
X-Gm-Message-State: AFqh2kqK8YWC3oAkjNebhxUYMb/x4BgNEswfCge7kCax5J0tHsUTXfNX
        lTAgdpP8tmEMHNOjyK/lnnzBZQ==
X-Google-Smtp-Source: AMrXdXs5jEoPdwvpIvhpWsoNZ3dwLlPfm/N/TqJwrTUTJCQIR/xEnhuSGfUHyd3nbcshsUxFjBAa6w==
X-Received: by 2002:a17:902:ec82:b0:194:9874:7ece with SMTP id x2-20020a170902ec8200b0019498747ecemr5863503plg.29.1673983783644;
        Tue, 17 Jan 2023 11:29:43 -0800 (PST)
Received: from google.com ([2620:15c:2d1:203:c3b2:a57d:8316:74e6])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902da8200b00188ea79fae0sm21625839plx.48.2023.01.17.11.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:29:43 -0800 (PST)
Date:   Tue, 17 Jan 2023 11:29:38 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Quinn Tran <qutran@marvell.com>, Arnd Bergmann <arnd@arndb.de>,
        Saurav Kashyap <skashyap@marvell.com>,
        Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] qla2xxx: fix printk format string
Message-ID: <20230117192938.nryt2tlgjymkr5ux@google.com>
References: <20230117170029.2387516-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117170029.2387516-1-arnd@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:00:15PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Printing a size_t value that is the result of the sizeof() operator requires
> using the %z format string modifier to avoid a warning on 32-bit architectures:
> 
> drivers/scsi/qla2xxx/qla_mid.c: In function 'qla_create_buf_pool':
> drivers/scsi/qla2xxx/qla_mid.c:1094:51: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]
>  1094 |                     "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
>       |                                                 ~~^       ~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                                   |          |
>       |                                                   long int   unsigned int
>       |                                                 %d
> 
> Fixes: 82d8dfd2a238 ("scsi: qla2xxx: edif: Fix performance dip due to lock contention")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Link: https://lore.kernel.org/llvm/63c4ddba.170a0220.1547e.db75@mx.google.com/

> ---
>  drivers/scsi/qla2xxx/qla_mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
> index c6ca39b8e23d..1483f6258f92 100644
> --- a/drivers/scsi/qla2xxx/qla_mid.c
> +++ b/drivers/scsi/qla2xxx/qla_mid.c
> @@ -1091,7 +1091,7 @@ int qla_create_buf_pool(struct scsi_qla_host *vha, struct qla_qpair *qp)
>  	qp->buf_pool.buf_map   = kcalloc(sz, sizeof(long), GFP_KERNEL);
>  	if (!qp->buf_pool.buf_map) {
>  		ql_log(ql_log_warn, vha, 0x0186,
> -		    "Failed to allocate buf_map(%ld).\n", sz * sizeof(unsigned long));
> +		    "Failed to allocate buf_map(%zd).\n", sz * sizeof(unsigned long));
>  		return -ENOMEM;
>  	}
>  	sz = qp->req->length * sizeof(void *);
> -- 
> 2.39.0
> 
> 
