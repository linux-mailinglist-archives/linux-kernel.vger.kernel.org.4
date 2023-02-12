Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE17C6939CF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 21:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBLUYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 15:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBLUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 15:24:10 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45C7E39D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:24:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so10332688pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 12:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HWFilNanFTJVAlWw1g+V6egLGtcyns2owNf2QnUOtlw=;
        b=xIoeiysSVuOwzvHR2WqylR52/VFPJD8QO7aSMzAG3vsUdQ6ku/KCjEFhbvyOi7gp+F
         ehZP+1uD9OGRznzjLNGSNa8MFEGCMwr+AKeEDDDDTslECNoGkaVzzYqYD4AHo0Y/T17K
         3sRYUcwc0rvCF7OAwrk26/m9l87ytWMQoYaVv5PqPmW0VAiP3KqNg9kj4OJTFWKffF/k
         uMVXczGpvPNo7ev/VDa5mc2NXgrO3LUNogegQacTyz0nXFCNdpeDkDqidwZPS9KmUNGi
         mXVdRSnshsnkHqv56iV0s+RL1fYO6+v3AzKQapq0R4kSA+rGTU4iL23+zXFEtrLPe98a
         SDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HWFilNanFTJVAlWw1g+V6egLGtcyns2owNf2QnUOtlw=;
        b=BD6C0czGZrPB1ZwwGSVP2YX96J2eepq6rha5Bv868FyYDFPZEH7rrRYR4hLm/SmdkO
         6jh3DSkzQguSMdWYOPTbwFbX0uUhJ4ck0gmc09AS88YDrO9YOrR7zMmLHA+KT8zW6yZ9
         UZ1YD/Z46N1rknM7YCGuQ9bZYeYYbMJvcXvEiju7b+WmjA/nF6BS2l0PoDrSLkZgB3P6
         dHyBwFVXxxkXg2hTXxyig1vZuLk+d5VINabeLaXYG7m9Hlz3Se3iZSqWB9nYyS/Dg36X
         gWDUoSFqpMgCEwQu++ZsqNDVOUasYPgte7iIcbmJqtFAg6HZAx1XxPmevb83LAg4PnsU
         fyGg==
X-Gm-Message-State: AO0yUKWaAdMv8d5SWA9046qU4sf0byEFl0iW1Jcuh7fJvo0xwt89nsmV
        nwAnwcIQOoG8KVuy9oBnmc4yqQ==
X-Google-Smtp-Source: AK7set8zTR5ia6k+GSss5gMoHr+xULpIqmDtvcfml6k8ThLqQ/yaeMPpmag80oG2dnErsUif+Th3vQ==
X-Received: by 2002:a05:6a20:1453:b0:c2:4766:2b59 with SMTP id a19-20020a056a20145300b000c247662b59mr25045910pzi.21.1676233449184;
        Sun, 12 Feb 2023 12:24:09 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:ee79:a5b1:b638:330c])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7928e000000b0058d8db0e4adsm6705528pfa.171.2023.02.12.12.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 12:24:08 -0800 (PST)
Date:   Sun, 12 Feb 2023 13:24:06 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1] remoteproc: mediatek: Check the SCP image format
Message-ID: <20230212202406.GA236598@p14s>
References: <20230210031354.1335-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210031354.1335-1-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:13:54AM +0800, Tinghan Shen wrote:
> Do a sanity check on the SCP image before loading it to avoid
> driver crashes.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 1 +
>  1 file changed, 1 insertion(+)
> 

I have applied this patch.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d421a2ccaa1e..0861b76f185f 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -649,6 +649,7 @@ static const struct rproc_ops scp_ops = {
>  	.load		= scp_load,
>  	.da_to_va	= scp_da_to_va,
>  	.parse_fw	= scp_parse_fw,
> +	.sanity_check	= rproc_elf_sanity_check,
>  };
>  
>  /**
> -- 
> 2.18.0
> 
