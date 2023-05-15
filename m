Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FAA703D20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbjEOS7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243904AbjEOS72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:59:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BDA176FE;
        Mon, 15 May 2023 11:59:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-250175762b8so11440746a91.1;
        Mon, 15 May 2023 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684177166; x=1686769166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlvUfXrVKILqxFedr05emePJ92D43kiYSthuZW0xPTA=;
        b=svSpD4vUmSifPUWJ9iAEua6vTgE2cbzEJzRqtz/3dG5dHuYRsh/zc4ESeYJNNMnLOU
         byJ+lpb8kkjLNs1Z8fmfxGg9rGXcntkeJ7Vi+7ZcypH9rpZqxZci2kLHD/pM5ifOCkuQ
         zsbc8jgRTHehwKxepU5KWAj2iGH4KCqccQGBdFyuiCjC/ShSCK6wVw2/upXSHjWZwA6C
         DuP5LQ8bH+/N8N1YTbaT0Qlgz+Twle9l6Tv5TsYh24lDH4/sRdbkxVq0ZrTxRkm6pfz2
         NYtftunwNMFF1XhQ+QD4sa7WILQ+/6lkZ9LTIIYtC21A6Y11b57hWEZbjf6cNDlDcTKs
         HI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684177166; x=1686769166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlvUfXrVKILqxFedr05emePJ92D43kiYSthuZW0xPTA=;
        b=I/PC5cC0ymWNQzo7inIDqpP4pOSmZaQBv1MIcxzzqvSfbps/hIW/5aWxLsjAW/y2HX
         srUf62YwCU2w7YsclY0D29IymIAj/32lQzon8v1Fs4Ijjh+rBVCZ3O2B5eqLAMz1K8z+
         N9AATUHnk5W/Rhg9RuzUNV6J/R8RpUz+GVgVIEsDDfcfCzpGe/N1u3qErugK1/u/oz8T
         KGjfOkCe/Rsp+0EPAqFp25SmcVgFjLHqAze6ey8iDduBHaM6vmbh+oTo5z6Z3LKZzbQm
         4z8dpHlqASLvKEmAWw7ejQUejMz0JSIFEmQE1U7GXl5Zzm5eTs83JnJ4SOtf8EWfb2ks
         vO0g==
X-Gm-Message-State: AC+VfDyyXxr7Z2Gnk8pfegEhwMmEK4zRgLi7ljl446xKMqg54WyBTpN8
        CVtNSQIcDfxzZqAaS3K6IBDegfjh9NY=
X-Google-Smtp-Source: ACHHUZ4f3MmUJg0Pa/8FmrHo/PnwleIl/6bP2T0NoZtVvVeY797iWSzgrtoy8bm2ItNZ6f08XKDubw==
X-Received: by 2002:a17:90a:3ccd:b0:250:4847:426a with SMTP id k13-20020a17090a3ccd00b002504847426amr31791596pjd.11.1684177166198;
        Mon, 15 May 2023 11:59:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i6-20020a1709026ac600b001aadfdfcd06sm9204861plt.299.2023.05.15.11.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:59:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 May 2023 11:59:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     llyyr <llyyr.public@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Message-ID: <54471eb9-3cd0-429d-b652-07fd380f359d@roeck-us.net>
References: <20230515144910.13514-1-llyyr.public@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515144910.13514-1-llyyr.public@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 08:19:10PM +0530, llyyr wrote:
> This value was found on a MSI Z690-A PRO DDR5 with NCT6687D.
> 
> Signed-off-by: llyyr <llyyr.public@gmail.com>

This needs to be a real name.

Guenter

> ---
>  drivers/hwmon/nct6683.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
> index a872f783e..f673f7d07 100644
> --- a/drivers/hwmon/nct6683.c
> +++ b/drivers/hwmon/nct6683.c
> @@ -173,6 +173,7 @@ superio_exit(int ioreg)
>  #define NCT6683_CUSTOMER_ID_INTEL	0x805
>  #define NCT6683_CUSTOMER_ID_MITAC	0xa0e
>  #define NCT6683_CUSTOMER_ID_MSI		0x201
> +#define NCT6683_CUSTOMER_ID_MSI2	0x200
>  #define NCT6683_CUSTOMER_ID_ASROCK		0xe2c
>  #define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
>  
> @@ -1220,6 +1221,8 @@ static int nct6683_probe(struct platform_device *pdev)
>  		break;
>  	case NCT6683_CUSTOMER_ID_MSI:
>  		break;
> +	case NCT6683_CUSTOMER_ID_MSI2:
> +		break;
>  	case NCT6683_CUSTOMER_ID_ASROCK:
>  		break;
>  	case NCT6683_CUSTOMER_ID_ASROCK2:
> -- 
> 2.40.1
> 
