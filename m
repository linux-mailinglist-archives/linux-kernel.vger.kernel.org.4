Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6677419DF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjF1UuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjF1Utv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:49:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410819B0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:49:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b6824141b4so9626305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687985386; x=1690577386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vr1uGKS8yimH0wL2pnkRpehoKj4yux612ywDNz5FjuI=;
        b=Is1rd5GHrGje7AW8Oo1Nyjoj3Yo6Wc9d1X+rAR807gekf0gMd9Qi4avwq3f/BM67HQ
         2MkR1jWYEB6CQxhh8QKpp1JVnOiJdaV7IkzI2yNNgMjSogPeIUOgsEPJnkDzFtGhZBK2
         8B6veo651uzIlQZUHs/8zT0lqVLoz6qRXMC4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985386; x=1690577386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr1uGKS8yimH0wL2pnkRpehoKj4yux612ywDNz5FjuI=;
        b=P9GA1vMVICyYze5JFnYLjb54AuRCUaqfGcqXeLSs9c3Z78Lk9mM4ikbAa1cpGK0Y5w
         CvyWkWzHe+H7ghZfmohD61gWoM13zpxxSWZyLdRojtlXHoXifTnSCTsw5Te7+64xAPsf
         w1VZsdcBYag9ImfwjyJ1uF3VHbJs0o2cu6XIgayUvyDoJGprNayhdR6a9gYX8GbrpD9d
         Cv9ZFeZ64GFpnM+1i4h90Y2FaS9mT8LlP23MjNbXT9W5tz4rVWU7GCkWC3pAHj941mMH
         zq1J0r1+/ZR1mS1Lfg5nfwBXux4miLWC6CfdYVlsazbDAMU7Zg+IKFoCPkydX5lWVdzw
         ffwQ==
X-Gm-Message-State: AC+VfDzDnOlElWSx+0Iy7U1MAuu+pn2tQqaE0pMZ5e5Hx4+YK/jzY/ms
        TPK06cGS71Mq1koZqVViYZnSSA==
X-Google-Smtp-Source: ACHHUZ6wMbb5D8+wuxsmeAWX9doMe9pb0ZXFdgDEFDvZ8PnK8g/Z/X9SwXLqHJQaUTSbJSnCSlbu2Q==
X-Received: by 2002:a17:90a:c906:b0:263:7d8:4a with SMTP id v6-20020a17090ac90600b0026307d8004amr3121008pjt.18.1687985386686;
        Wed, 28 Jun 2023 13:49:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v29-20020a63481d000000b00553d27ab0e0sm7642080pga.69.2023.06.28.13.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:49:46 -0700 (PDT)
Date:   Wed, 28 Jun 2023 13:49:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 05/10][next] scsi: aacraid: Replace one-element array
 with flexible-array member in struct sgmapraw
Message-ID: <202306281348.5571090DAD@keescook>
References: <cover.1687974498.git.gustavoars@kernel.org>
 <9dfcdf55597a49ed7e19ba064f5be424b344e175.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dfcdf55597a49ed7e19ba064f5be424b344e175.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:56:12AM -0600, Gustavo A. R. Silva wrote:
> Replace one-element array with flexible-array member in struct
> sgmapraw.
> 
> Issue found with the help of Coccinelle and audited and fixed,
> manually.

As with the other two, I see expected binary changes in
aac_read_raw_io() and aac_write_raw_io() due to the simplified count
calculations.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/scsi/aacraid/aachba.c  | 4 ++--
>  drivers/scsi/aacraid/aacraid.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
> index fff0550e02e4..b3c0c2255e55 100644
> --- a/drivers/scsi/aacraid/aachba.c
> +++ b/drivers/scsi/aacraid/aachba.c
> @@ -1267,7 +1267,7 @@ static int aac_read_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
>  			return ret;
>  		command = ContainerRawIo;
>  		fibsize = sizeof(struct aac_raw_io) +
> -			((le32_to_cpu(readcmd->sg.count)-1) * sizeof(struct sgentryraw));
> +			  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentryraw);
>  	}
>  
>  	BUG_ON(fibsize > (fib->dev->max_fib_size - sizeof(struct aac_fibhdr)));
> @@ -1401,7 +1401,7 @@ static int aac_write_raw_io(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u
>  			return ret;
>  		command = ContainerRawIo;
>  		fibsize = sizeof(struct aac_raw_io) +
> -			((le32_to_cpu(writecmd->sg.count)-1) * sizeof (struct sgentryraw));
> +			  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentryraw);
>  	}
>  
>  	BUG_ON(fibsize > (fib->dev->max_fib_size - sizeof(struct aac_fibhdr)));
> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
> index d1fc1ce2e36d..87015dd2abd9 100644
> --- a/drivers/scsi/aacraid/aacraid.h
> +++ b/drivers/scsi/aacraid/aacraid.h
> @@ -527,7 +527,7 @@ struct user_sgmap64 {
>  
>  struct sgmapraw {
>  	__le32		  count;
> -	struct sgentryraw sg[1];
> +	struct sgentryraw sg[];
>  };
>  
>  struct user_sgmapraw {
> -- 
> 2.34.1
> 

-- 
Kees Cook
