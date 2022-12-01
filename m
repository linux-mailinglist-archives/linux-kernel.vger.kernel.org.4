Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08E063EFDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiLALtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiLALtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:49:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E129AE04
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:49:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o5so2312057wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9EKZPY2hBniiNOtz3xFsIq3ixIyaR/34E24Cwlg4TM=;
        b=Tfoq8xnEDOdKYT+BTIWDRJ/clQ9qBFy9Q6K+s4018wd20fxlU+a5wkqQijASISO6RY
         FGCzBGXt82C2oe8Ox5isIxegfmEwuD62h3jTMbh0HX1SKu/MuG1wG4MeGl4rJv+cXj+p
         bQqTHsfg7PcM7b+jN28i/NmNGOj5H4c/kbhWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9EKZPY2hBniiNOtz3xFsIq3ixIyaR/34E24Cwlg4TM=;
        b=pckH1lCF+fNjGpLW5F1LUjM0Q4BAv7NS/Qh2Lc3yw0Hn0ujKBAsKwal4xKhUCsf2Ys
         PzkxXmYMb6dhZuh64br15vQLW8DadM3XQQKDj4BF70tu8bC3Yg2Ore0/FDnNy4adckSj
         X55pWLdUDBwUFHqYA+uvzrDrDO5LQLosOypTdWJ1qi4qSqE5b/4MWX6vXXVmlOYxiUA/
         FHt+R7BM63/zW0idfuufj2oivtTS6frQW89Mb2Q7GbcXpYMuwM5bxdhHraMueP3y7La+
         Yf9bL8kMkK1VKQ80HCo4BieerEJa99ZMBOPxyXJeHQuJ2Ul7X9u6U7QuGbyH1ALMEdid
         xb9A==
X-Gm-Message-State: ANoB5pnRgnj82sgGUpXHciqtlgkFxXtEL3BCldmobl9nnfa7+3CWdPIo
        R9xwQc1R8+kz3hEZIiFVqelmog==
X-Google-Smtp-Source: AA0mqf4qcEqAuLwD8njmkdLkxFyZkebZPMxSJGaXrkDX3Ot1nqpkA1QFzJnmVd4NWofEpOUZXHT8/w==
X-Received: by 2002:adf:d84e:0:b0:241:7ad0:dd0a with SMTP id k14-20020adfd84e000000b002417ad0dd0amr41578048wrl.290.1669895388800;
        Thu, 01 Dec 2022 03:49:48 -0800 (PST)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-49-206.cust.vodafonedsl.it. [188.217.49.206])
        by smtp.gmail.com with ESMTPSA id m28-20020a056000025c00b00242257f2672sm4268751wrz.77.2022.12.01.03.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:49:48 -0800 (PST)
Date:   Thu, 1 Dec 2022 12:49:46 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     ye.xingchen@zte.com.cn
Cc:     isely@pobox.com, mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: pvrusb2: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <20221201114946.GA1289482@tom-ThinkPad-T14s-Gen-2i>
References: <202212011927592559291@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212011927592559291@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 01, 2022 at 07:27:59PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/media/usb/pvrusb2/pvrusb2-sysfs.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
> index 3e42e209be37..81c8b65bd9ef 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-sysfs.c
> @@ -81,7 +81,7 @@ static ssize_t show_name(struct device *class_dev,
>  	pvr2_sysfs_trace("pvr2_sysfs(%p) show_name(cid=%d) is %s",
>  			 cip->chptr, cip->ctl_id, name);
>  	if (!name) return -EINVAL;
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", name);
> +	return sysfs_emit(buf, "%s\n", name);
>  }
> 
>  static ssize_t show_type(struct device *class_dev,
> @@ -102,7 +102,7 @@ static ssize_t show_type(struct device *class_dev,
>  	}
>  	pvr2_sysfs_trace("pvr2_sysfs(%p) show_type(cid=%d) is %s",
>  			 cip->chptr, cip->ctl_id, name);
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", name);
> +	return sysfs_emit(buf, "%s\n", name);
>  }
> 
>  static ssize_t show_min(struct device *class_dev,
> @@ -115,7 +115,7 @@ static ssize_t show_min(struct device *class_dev,
>  	val = pvr2_ctrl_get_min(cip->cptr);
>  	pvr2_sysfs_trace("pvr2_sysfs(%p) show_min(cid=%d) is %ld",
>  			 cip->chptr, cip->ctl_id, val);
> -	return scnprintf(buf, PAGE_SIZE, "%ld\n", val);
> +	return sysfs_emit(buf, "%ld\n", val);
>  }
> 
>  static ssize_t show_max(struct device *class_dev,
> @@ -128,7 +128,7 @@ static ssize_t show_max(struct device *class_dev,
>  	val = pvr2_ctrl_get_max(cip->cptr);
>  	pvr2_sysfs_trace("pvr2_sysfs(%p) show_max(cid=%d) is %ld",
>  			 cip->chptr, cip->ctl_id, val);
> -	return scnprintf(buf, PAGE_SIZE, "%ld\n", val);
> +	return sysfs_emit(buf, "%ld\n", val);
>  }
> 
>  static ssize_t show_def(struct device *class_dev,
> @@ -551,7 +551,7 @@ static ssize_t v4l_minor_number_show(struct device *class_dev,
>  	struct pvr2_sysfs *sfp;
>  	sfp = dev_get_drvdata(class_dev);
>  	if (!sfp) return -EINVAL;
> -	return scnprintf(buf,PAGE_SIZE,"%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  			 pvr2_hdw_v4l_get_minor_number(sfp->channel.hdw,
>  						       pvr2_v4l_type_video));
>  }
> @@ -563,7 +563,7 @@ static ssize_t bus_info_show(struct device *class_dev,
>  	struct pvr2_sysfs *sfp;
>  	sfp = dev_get_drvdata(class_dev);
>  	if (!sfp) return -EINVAL;
> -	return scnprintf(buf,PAGE_SIZE,"%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			 pvr2_hdw_get_bus_info(sfp->channel.hdw));
>  }
> 
> @@ -574,7 +574,7 @@ static ssize_t hdw_name_show(struct device *class_dev,
>  	struct pvr2_sysfs *sfp;
>  	sfp = dev_get_drvdata(class_dev);
>  	if (!sfp) return -EINVAL;
> -	return scnprintf(buf,PAGE_SIZE,"%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			 pvr2_hdw_get_type(sfp->channel.hdw));
>  }
> 
> @@ -585,7 +585,7 @@ static ssize_t hdw_desc_show(struct device *class_dev,
>  	struct pvr2_sysfs *sfp;
>  	sfp = dev_get_drvdata(class_dev);
>  	if (!sfp) return -EINVAL;
> -	return scnprintf(buf,PAGE_SIZE,"%s\n",
> +	return sysfs_emit(buf, "%s\n",
>  			 pvr2_hdw_get_desc(sfp->channel.hdw));
>  }
> 
> @@ -597,7 +597,7 @@ static ssize_t v4l_radio_minor_number_show(struct device *class_dev,
>  	struct pvr2_sysfs *sfp;
>  	sfp = dev_get_drvdata(class_dev);
>  	if (!sfp) return -EINVAL;
> -	return scnprintf(buf,PAGE_SIZE,"%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  			 pvr2_hdw_v4l_get_minor_number(sfp->channel.hdw,
>  						       pvr2_v4l_type_radio));
>  }
> @@ -609,7 +609,7 @@ static ssize_t unit_number_show(struct device *class_dev,
>  	struct pvr2_sysfs *sfp;
>  	sfp = dev_get_drvdata(class_dev);
>  	if (!sfp) return -EINVAL;
> -	return scnprintf(buf,PAGE_SIZE,"%d\n",
> +	return sysfs_emit(buf, "%d\n",
>  			 pvr2_hdw_get_unit_number(sfp->channel.hdw));
>  }
> 
> -- 
> 2.25.1

Looks good to me.
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
