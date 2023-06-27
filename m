Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3073FE61
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjF0OjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjF0Oi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:38:57 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B553C07;
        Tue, 27 Jun 2023 07:38:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98e25fa6f5bso468411566b.3;
        Tue, 27 Jun 2023 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876701; x=1690468701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aycEXc1p8AecpgCVFe3SN1Ps1KLQUbHdHOvGWse/Ca4=;
        b=jaXJB/YU3JQz39KDQb+QDAKFdsmnrticA9rtbWy1ykxlRnJIevC3j1hKmX/0MXVoJg
         w8jKqiTx/y9VWXNo0RJK0TTbnTi+K67/HN2VTh7KHWkPnGQEfyVpXole7nMsnq9KjbdU
         GNfMDg+30KGrk9ZG/1UvMhYx20ICRMS0AAYEUTAkoRSst1k7LoXzQD/0L2Mwvdp2379C
         9Muz3hE2k134stWl1rFqKDHWVHUbta01qqTOZNiG0/KdvW/8J6F83ImxVyahIfkbFR4+
         1IDF/pq7mHSbbSGFCBjfbVDLBkWqS+TO2qIz6/IRHUNtSzGJL0jvOsy4E/pKGoM6RguG
         b7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876701; x=1690468701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aycEXc1p8AecpgCVFe3SN1Ps1KLQUbHdHOvGWse/Ca4=;
        b=lSFl+keIJRKLNlxxvi/IYSQgC5RyZdzlBeGLlGveVECxWk9ydnk6rTtT9yFB+z2oPG
         wBI6htaCD4DykRIJm1GIrkkoKkPTGPO+VwW/3RXJpSsdLBFm8oz1d9HAcgnv10khL7Dy
         jUXu2od7fPUAoSanaU9NIw8q04iRI4WgoljXQJWY7gTUkZuwOrrbin914328fD8kX/ki
         IAVkCtjDTRJq7ujsSiXSkWJNlT19fg7lPGnLFWtcxD3ycTz5hmVxDsTgerM53hEGUcO/
         QCY71+zUAlwAJHClEKtvOWuiPpQKIbgTOd8d5ynTUiCYxme3ajAjmFkOmE9iI/MS76qY
         OxQg==
X-Gm-Message-State: AC+VfDxSNYTNpqrDRaDun+Vf/z7Glm8KJUrW4yQTkQSNf9/5XrUSGkDC
        uHwbsNUi1r8C3YrFz0LbAJcounQB7fvEJi8+
X-Google-Smtp-Source: ACHHUZ50qYhprpbhs8hRwJ1pExP9hgcQpDJ1t3RmUD8qchv2Au4jmHRBJUCn5fqkbiSdOan16EquKQ==
X-Received: by 2002:a17:907:7293:b0:988:d841:7f8d with SMTP id dt19-20020a170907729300b00988d8417f8dmr21453302ejc.71.1687876700555;
        Tue, 27 Jun 2023 07:38:20 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation ([193.85.242.128])
        by smtp.gmail.com with ESMTPSA id b21-20020a170906491500b009828dac8425sm4590406ejq.105.2023.06.27.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:38:20 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:38:18 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] media: bt8xx: make read-only arrays static
Message-ID: <ZJr0WvhFfCILwbeP@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230627134851.728487-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627134851.728487-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Tue, Jun 27, 2023 at 02:48:51PM +0100, Colin Ian King wrote:
> Don't populate the arrays on the stack, instead make them static const.
> Also add spaces between values to clean up checkpatch style warnings.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/media/pci/bt8xx/dvb-bt8xx.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
> index 4cb890b949c3..df83b59a618d 100644
> --- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
> +++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
> @@ -190,11 +190,15 @@ static int cx24108_tuner_set_params(struct dvb_frontend *fe)
>  	u32 freq = c->frequency;
>  	int i, a, n, pump;
>  	u32 band, pll;
> -	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
> -		1576000,1718000,1856000,2036000,2150000};
> -	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
> +	static const u32 osci[] = {
> +		950000, 1019000, 1075000, 1178000, 1296000, 1432000,
> +		1576000, 1718000, 1856000, 2036000, 2150000
> +	};
> +	static const u32 bandsel[] = {
> +		0, 0x00020000, 0x00040000, 0x00100800, 0x00101000,
>  		0x00102000,0x00104000,0x00108000,0x00110000,

Are you not missing space also here?

> -		0x00120000,0x00140000};
> +		0x00120000, 0x00140000
> +	};
>  
>  	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
>  	dprintk("cx24108 debug: entering SetTunerFreq, freq=%d\n", freq);
> -- 
> 2.39.2
> 

Regards,
Tommaso
