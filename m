Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39E268E412
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 00:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjBGXBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 18:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjBGXBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 18:01:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8C912F06
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 15:01:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso2634990pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 15:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTf07qTobRvFNEOlYlJqV5SF3piK99zxyELcaKNScNs=;
        b=izbdy8nkqes83emxWyH2/f6utXKy4skfO3eStORNppJy6CYGvLj/pDh/CoVGCJaGTP
         M9ZPgGUA4vPVEusXc9xSs5bwYkLul4PwP9X1zlVYYddG/8Vs8lWNJEYLfOotZk5Bcw6m
         82sqiPDITLEKVrOiLprXUFqcwkKbDp4dGRbSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTf07qTobRvFNEOlYlJqV5SF3piK99zxyELcaKNScNs=;
        b=GIGudRwYD9dWA6tnyO5Q3ph4IyJvJjUSlV99ZqB+fCq0uz8WLjSm6HSkiuCjtWQ5xp
         GaCMluHZiJ7vwRkeJ6XLG3MpMhKkeAIcwN/4BHncGv1R0HxWTqMvMvHCTiM2feeH1Rfq
         GCQ4kH1iQAcsQReX+2uTaTMCEWofnV7/6FpNZNItShZ9cTuKV1s5zk8kSB51gPtyDt+/
         zPnwkTT0X2N33c8CMbOaVOTk+frmvMdtIPGKCfqN7XA2iJiTIAIEr23YrOFYOr9j2h/e
         HAFljL1JEz8SjndWTybQzjopmi0yBc8YhKX2Ev/G1/E8TNnBPy+bxMYxng76BdUsXbcY
         29XA==
X-Gm-Message-State: AO0yUKVDGqrAS3e/iihDIEyR9WWH9wbYdPwv7XFQD34CPA1eTyDoH+sF
        /A0GruutbCJxJKOFL9IrN+oEsA==
X-Google-Smtp-Source: AK7set+fDacQiRQcwTpDjwGKlzv2yYCCHtNdjZcTiWEgD+0zpQZ6cdterIjVrP204wVOR+2UF9VL8w==
X-Received: by 2002:a17:902:e205:b0:196:77fd:abfd with SMTP id u5-20020a170902e20500b0019677fdabfdmr4121073plb.64.1675810880741;
        Tue, 07 Feb 2023 15:01:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b0017fe9b038fdsm9405296plk.14.2023.02.07.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 15:01:20 -0800 (PST)
Message-ID: <63e2d840.170a0220.2b199.00a7@mx.google.com>
X-Google-Original-Message-ID: <202302071500.@keescook>
Date:   Tue, 7 Feb 2023 15:01:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
References: <Y+LJz/r6+UeLqnV3@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+LJz/r6+UeLqnV3@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 03:59:43PM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element array with flexible-array
> member in struct report_log_lun_list.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
> on memcpy().
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/204
> Acked-by: Don Brace <don.brace@microchip.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good to me -- both before and after, there is 1 extra all-zero
entry at the end. But now the struct is using a flex array correctly.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> Changes in v3:
>  - Amplify the existing comment instead of adding a new one. By Don
>    Brace[1].
>  - Add Don's Acked-by tag to the changelog.
>    Link: https://lore.kernel.org/linux-hardening/d881ad98-a291-1c9b-53dc-199f23f1625e@embeddedor.com/ [1]
> 
> Changes in v2:
>  - In v1 we thought that the original code was allocating one too-many
>    entries for the list. However, Don Brace commented that the allocation
>    was actually intentional[2]. So, I added a code comment with his feedback.
>    Link: https://lore.kernel.org/linux-hardening/16e6c434-44af-2efb-d4bc-a253e93e5590@embeddedor.com/  [2]
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/c80c0979933e0c05e80d95792ef167a28640a14b.1663816572.git.gustavoars@kernel.org/
> 
>  drivers/scsi/smartpqi/smartpqi.h      | 2 +-
>  drivers/scsi/smartpqi/smartpqi_init.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/smartpqi/smartpqi.h b/drivers/scsi/smartpqi/smartpqi.h
> index af27bb0f3133..228838eb3686 100644
> --- a/drivers/scsi/smartpqi/smartpqi.h
> +++ b/drivers/scsi/smartpqi/smartpqi.h
> @@ -954,7 +954,7 @@ struct report_log_lun {
>  
>  struct report_log_lun_list {
>  	struct report_lun_header header;
> -	struct report_log_lun lun_entries[1];
> +	struct report_log_lun lun_entries[];
>  };
>  
>  struct report_phys_lun_8byte_wwid {
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index d0446d4d4465..49a8f91810b6 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -1259,7 +1259,8 @@ static int pqi_get_device_lists(struct pqi_ctrl_info *ctrl_info,
>  			"report logical LUNs failed\n");
>  
>  	/*
> -	 * Tack the controller itself onto the end of the logical device list.
> +	 * Tack the controller itself onto the end of the logical device list
> +	 * by adding a list entry that is all zeros.
>  	 */
>  
>  	logdev_data = *logdev_list;
> -- 
> 2.34.1
> 

-- 
Kees Cook
