Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C665DFEF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbjADWXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240637AbjADWWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:22:44 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C375442E1B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:22:16 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b12so23258052pgj.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40aCXfWhTqUFcCFEIzCnKJwULoW1yAHahg0ZbSH052M=;
        b=PqpRQqIVQqFNj7Q19Abfst0HigNal+4IW1isdwI2TW3/yaJzSsVnI+Xe2O41Sc5OfF
         Tu1+SGVtg0Ct7wVCDoNQKrIEl82X/ixo9XOsG4KBg7eSS/0AtXJfs2eO/gIRhj6W45dh
         hVlxDDgzg//wst937/ps/2SNYqxzPJxJqviJ+umMmn/wFjya0+RoxSSHqMIF8bbiXHtL
         nre0uYRJePf/uvb5PG+H2hCUf7BR2se7AMFW/8vkAZWJ4UWFeg+5167Uo+gyYx9sUcXI
         m9tFe5qpxxnT9YlxtnH5Bp9/XIz8UGPLwl+BknH8NHz4djAE7MbQIAfdglHUCg7ULmEy
         XWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40aCXfWhTqUFcCFEIzCnKJwULoW1yAHahg0ZbSH052M=;
        b=JKILlqHCqtLWJgf7s/TPsZaV4vL0vrYrWiVAtckiU31mkRJe83MRKvp3eZ7rUsMN9X
         HE+1sBsP56OpAo1NJtV7uAwiLHsW//9w7uOeVQR/PrwwGBoLROx/pn57Wo/sM66AaVob
         TPbdGxoN/VO62iVtoEyyLlUw8HHCSwpc5pqPT10CB1sSQryCAPGolz3oJHtKoKxF9zpl
         LEgUAqIGTixWIMDTcF2N98LPkfGiPP/9Yw1WRxMS8xwKON4Hdk0u1aRGgRAiLbMGmS+B
         JqhNyecu4ZbE5Pufkjyi2qSy8Wl1QYZmzTGWHbmISwLmqkctwLJRkmMGRkYRQNssUJj7
         G6kA==
X-Gm-Message-State: AFqh2kqViSbIpnnXuE74X3jT7mXMbW9Ja/nk7pk/VVfifpRQ3a2J7gDU
        2XMFptGQs21Pe6b6nMeKogRpPA==
X-Google-Smtp-Source: AMrXdXsVIW3Vk9fPr6HAQ5LszLahtDigXGrZxRbdl1FZx199jQzS4XLF4LPyQMfbFxAzkqhdqJa1Hg==
X-Received: by 2002:a05:6a00:26c8:b0:582:b3c9:efe with SMTP id p8-20020a056a0026c800b00582b3c90efemr7751121pfw.19.1672870936297;
        Wed, 04 Jan 2023 14:22:16 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:1328:ca09:d4c2:fcbc])
        by smtp.gmail.com with ESMTPSA id a6-20020aa794a6000000b005817969c0a2sm15264728pfl.75.2023.01.04.14.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:22:15 -0800 (PST)
Date:   Wed, 4 Jan 2023 15:22:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: Re: [PATCH] remoteproc/mtk_scp: Move clk ops outside send_lock
Message-ID: <20230104222213.GB2112402@p14s>
References: <20230104083110.736377-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104083110.736377-1-wenst@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:31:10PM +0800, Chen-Yu Tsai wrote:
> Clocks are properly reference counted and do not need to be inside the
> lock range.
> 
> Right now this triggers a false-positive lockdep warning on MT8192 based
> Chromebooks, through a combination of mtk-scp that has a cros-ec-rpmsg
> sub-device, the (actual) cros-ec I2C adapter registration, I2C client
> (not on cros-ec) probe doing i2c transfers and enabling clocks.
> 
> This is a false positive because the cros-ec-rpmsg under mtk-scp does
> not have an I2C adapter, and also each I2C adapter and cros-ec instance
> have their own mutex.
> 
> Move the clk operations outside of the send_lock range.

Thanks for providing such a clear explanation - it makes my job a lot easier.

> 
> Fixes: ("63c13d61eafe remoteproc/mediatek: add SCP support for mt8183")

This is the wrong format for a "Fixes:" tag.  Please see
Documentation/process/submitting-patches.rst for details.

> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I have fixed the above and applied this patch.

Thanks,
Mathieu

> ---
>  drivers/remoteproc/mtk_scp_ipi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
> index 00f041ebcde6..4c0d121c2f54 100644
> --- a/drivers/remoteproc/mtk_scp_ipi.c
> +++ b/drivers/remoteproc/mtk_scp_ipi.c
> @@ -164,21 +164,21 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  	    WARN_ON(len > sizeof(send_obj->share_buf)) || WARN_ON(!buf))
>  		return -EINVAL;
>  
> -	mutex_lock(&scp->send_lock);
> -
>  	ret = clk_prepare_enable(scp->clk);
>  	if (ret) {
>  		dev_err(scp->dev, "failed to enable clock\n");
> -		goto unlock_mutex;
> +		return ret;
>  	}
>  
> +	mutex_lock(&scp->send_lock);
> +
>  	 /* Wait until SCP receives the last command */
>  	timeout = jiffies + msecs_to_jiffies(2000);
>  	do {
>  		if (time_after(jiffies, timeout)) {
>  			dev_err(scp->dev, "%s: IPI timeout!\n", __func__);
>  			ret = -ETIMEDOUT;
> -			goto clock_disable;
> +			goto unlock_mutex;
>  		}
>  	} while (readl(scp->reg_base + scp->data->host_to_scp_reg));
>  
> @@ -205,10 +205,9 @@ int scp_ipi_send(struct mtk_scp *scp, u32 id, void *buf, unsigned int len,
>  			ret = 0;
>  	}
>  
> -clock_disable:
> -	clk_disable_unprepare(scp->clk);
>  unlock_mutex:
>  	mutex_unlock(&scp->send_lock);
> +	clk_disable_unprepare(scp->clk);
>  
>  	return ret;
>  }
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
