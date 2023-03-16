Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC2B6BD7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCPSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCPSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:15:19 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E26DC09A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:14:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p20so2660891plw.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678990493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pqp+Ruz/AdnKmnGI6Zv/MF4JDiJ9A6hS03v38ROXSso=;
        b=SoOra7MYJ9yivi4lQa+vmZdoc/naYbQn9Og1Qszg3CNCnmunbPcxN6IQPbIdWCxvjX
         A2CGlAaXFkP3JeXKtzf1JiVPR9liWuArRur29p8mmckt6mm4C3MeEgpD2na9oUeLn4JG
         cjzIf2GrTGasQgwLHVk9vzwdwfWyvLsybrVQuf14AnoHT+hWYDtRbhd/4DO0O/bAFjZ4
         hHR01N0LyzuCTjuvpm1C+u2llD2UfK/+mmfns+5H4nH0ZCHpS0w3L50138PZXXyslGT/
         RWes9KJ2go8TmDh2f3qiTVEIckz1KrlgU4QOWerkkpSKlWqRSn4VFGgsv2ljPQAZm7x6
         3LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqp+Ruz/AdnKmnGI6Zv/MF4JDiJ9A6hS03v38ROXSso=;
        b=xwfcH/erbqAW/1n350q8R3eLXTUrFu1Wvs5PGnAVGzk6OHDWw+cw6AMWdz7IkEnv7c
         pKj+4wxtvMG+edNNMFcVCEdhA9FAvzJ+mH0yqHWtmPRTjswtPTAYWIrodTZUnXyXfyuH
         qA0L3ConX1ZmLx2lSN/ki2cVnuPRgZcxDAseoHu5wdLXTpxgQw1Dwssp95JT6lqSHoQR
         pF/sjIRpkDFl60PmjK6o9tZl7pHApZG1QD+uMgD/YBHcN+lZQOSu+yrYu92J+wcUroBh
         2vPhHmhhMeHc1XfdQOM7nL2S26n2KZXxYyK5PHXRpUQ0GmqKoqizWGWjn+FnvmRqVXfw
         1W3g==
X-Gm-Message-State: AO0yUKUbGJQG5hHxhDAgJ/Eb5xKbD/okCyMNwgNiwYtLYNQhAZL5WQS3
        jpud3oiZJR1xBO8lQyEmboN9xA==
X-Google-Smtp-Source: AK7set+RPXOketPy5+X+PCkBvQftwRTp+x6bJhpmW+1XHc3+dvZDWj/l3PB2TxM/AHSGIWzWn0XNJg==
X-Received: by 2002:a05:6a20:8b90:b0:d3:5b84:6fcd with SMTP id m16-20020a056a208b9000b000d35b846fcdmr4638504pzh.12.1678990493121;
        Thu, 16 Mar 2023 11:14:53 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:5997:2b9a:5757:d5f4])
        by smtp.gmail.com with ESMTPSA id r20-20020a63ec54000000b004ff6b744248sm5436710pgj.48.2023.03.16.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:14:52 -0700 (PDT)
Date:   Thu, 16 Mar 2023 12:14:50 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] remoteproc/mtk_scp: Fix one kernel-doc comment
Message-ID: <20230316181450.GA2421452@p14s>
References: <20230316084011.99613-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316084011.99613-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:40:11PM +0800, Yang Li wrote:
> Fixs the function name in kernel-doc comments to clear the below
> warning:
> 
> drivers/remoteproc/mtk_scp_ipi.c:136: warning: expecting prototype for scp_ipi_lock(). Prototype was for scp_ipi_unlock() instead
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4544
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/remoteproc/mtk_scp_ipi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index fc55df649b40..9c7c17b9d181 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -125,7 +125,7 @@ void scp_ipi_lock(struct mtk_scp *scp, u32 id)
>  EXPORT_SYMBOL_GPL(scp_ipi_lock);
>  
>  /**
> - * scp_ipi_lock() - Unlock after operations of an IPI ID
> + * scp_ipi_unlock() - Unlock after operations of an IPI ID

I have applied this patch.

Thanks,
Mathieu

>   *
>   * @scp:	mtk_scp structure
>   * @id:		IPI ID
> -- 
> 2.20.1.7.g153144c
> 
