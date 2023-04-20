Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275986E93D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjDTMLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbjDTMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:11:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629A59F9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:11:02 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-74dd7f52f18so153047685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681992662; x=1684584662;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1LxyGqG5WL9KaWkh2+hx1G34IN6yuPWN+Fhp92J1jU=;
        b=cTJefAavuwEJMjxkP+0FJDK3FU5t0pFA/baHq7/CmHy65JmN7YNzl9jvNl5LvW3L4x
         OQdTQ26zgzvvHsB+MZi8aOpANQpN3DtBE1EuVo68DnYjkp9fUlROl3FCbLedV6R3FRFp
         NlX83jBxJnLmpsCkSgrApq8ib+WNe5GoHNlZ2BSjkR++2eWWrUlws0tfNEWn79TyXDsQ
         ovHsNFOtSlEUNCklfiIftrxzbIwByHeI7vlTqJLSyHhT0We5KeQGQKYQiiDWghEXsa/p
         mEGLNeF/Cw4UyKjErsrje0/sybjqovhKCszdLDltHj3SGkoqxDvAfCvB49zrrEJYrQZO
         YgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681992662; x=1684584662;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1LxyGqG5WL9KaWkh2+hx1G34IN6yuPWN+Fhp92J1jU=;
        b=f8a7oM5f/qL4qfgVzEK2Clre0XHbxOkgLnC0SubXPuDZjJaFmRJe8BnqSz4U2l65aL
         zWRxqVGst9qjdE66m3r9YXVpdd3UN/2NB73QMGCdADH3NGb5TlvviCMncXY4aGsvzoGk
         SE/sbW5mA+3pwJeFkvuD6CiVvi4wy4N70mZi7gVmRteUWryo2tlb/Ef7gWn23Uqgfdzz
         OFmmVRMi02Mjx6gBqSQjehkQ4suHNJvOeCnPJzsD+CZT/Y5GX4Aj1vzZWjFgB5BJYDAH
         buxcwnGfVC42NxNCRosYX/LQiVrjYnvt3yRAST0lWR6HvVjc134BinxXQoEHwRaxzWKs
         +usw==
X-Gm-Message-State: AAQBX9dj/tF6AiwEcbXo8bZOn1daDX0TWkE50VPila0HH3vn1BifRnIz
        NFdjk1c+5ItwsZz27gBA0A==
X-Google-Smtp-Source: AKy350aU+AhiGvWT2mOUumNh9NQQKESPC9pzdG1xi3NmMoT7bYT1AMbxetODVE0RwWxqXoOIEYgjpA==
X-Received: by 2002:a05:622a:1a18:b0:3ef:3008:bf with SMTP id f24-20020a05622a1a1800b003ef300800bfmr1925477qtb.9.1681992661750;
        Thu, 20 Apr 2023 05:11:01 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id z28-20020ac87cbc000000b003e388264753sm435619qtv.65.2023.04.20.05.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 05:11:00 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:12f9:9c2e:cc67:fe3b])
        by serve.minyard.net (Postfix) with ESMTPSA id A196B180044;
        Thu, 20 Apr 2023 12:10:59 +0000 (UTC)
Date:   Thu, 20 Apr 2023 07:10:58 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi: ipmi-bmc: Improve errno
 returned to userspace
Message-ID: <ZEEr0r/6/lLiwlsy@minyard.net>
Reply-To: minyard@acm.org
References: <20230419150032.3483229-1-govert.overgaauw@prodrive-technologies.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419150032.3483229-1-govert.overgaauw@prodrive-technologies.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, what do you think?

-corey

On Wed, Apr 19, 2023 at 05:00:32PM +0200, Govert Overgaauw via Openipmi-developer wrote:
> While the KCS driver is not in KCS_PHASE_WAIT_READ state it returns
> -EINVAL to userspace on a write call. change this to -EAGAIN to indicate
> that the error is related to the state and not the argument.
> 
> Signed-off-by: Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
> ---
>  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> index cf670e891966..4c7400faf333 100644
> --- a/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> +++ b/drivers/char/ipmi/kcs_bmc_cdev_ipmi.c
> @@ -405,7 +405,7 @@ static ssize_t kcs_bmc_ipmi_write(struct file *filp, const char __user *buf,
>  		kcs_bmc_write_data(priv->client.dev, priv->data_out[0]);
>  		ret = count;
>  	} else {
> -		ret = -EINVAL;
> +		ret = -EAGAIN;
>  	}
>  	spin_unlock_irq(&priv->lock);
>  
> -- 
> 2.30.2
> 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
