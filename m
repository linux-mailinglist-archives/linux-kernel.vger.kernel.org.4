Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE27672B9F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjFLINl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjFLINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:13:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BF51FE9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:12:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso29131205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686557572; x=1689149572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gc+miDzZceXCLueDQlgChLb47zA+DR3zS3KkscEcQ/E=;
        b=TRzCPGz+Dq58XxB3JdEWqYt8+rvlmUpC+39cO6M1Y40MdAkZ7QLtwzQHTtg66aAPIC
         k0VSpTG+VNmvOh0ERZepO44jfP1iLTjuSEUKtnNhB5x3k01TuG0A3CykBRTOzog9+rbz
         HPmDlpujfiOgPajTRfAgS3aviuOIGZreHnEyPL59pXWhbYoePoVYp6cIjgcgsHZ+bNnp
         X1i5xQJfEPL9DSy9CKB6aqHbOkVqc4XvLTpwFUZGSCX0Gohgw5BoIydC7Y0qs1jKyvDw
         rwIarQnRitax1WzUnhRN8ntEbpBWEtk75snkv+3sxEoCMZl6vt9yi5Ywca2Q08w7b6dx
         2qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686557572; x=1689149572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gc+miDzZceXCLueDQlgChLb47zA+DR3zS3KkscEcQ/E=;
        b=TOALzwuvMaraYWm3Z55UEQykF9hPo1Hl4MdZRGL56OgYebU8cQ3NSLZn1Lgpw0z8C7
         eypoNHbT6rTo8xOLQBJOxpcdnQlvyDpSXxvmdMDvyAzuT8IaKyqHPOX1uUxgIdaEW2h0
         5io15sZoxKFKviSTpUYC/2TN6OgKoaAHZiECk4coKHCY1E12j2M9KKzkdYUxoWApQsv0
         pZcl563Yf0lasx+wwDAXpTqdo0UiO1ExgvqoajilZvXty42z9Lmc8qz9szaOMVxRr2/p
         4F6wstTdBDleE/zFHC77ISgiRJMTFJ35f2cLJrbSkqAfOxM/FaYbD3MroXotbps90YCY
         fFvA==
X-Gm-Message-State: AC+VfDyj1ZngZKaExz/NBnA5BUlg+4paCGa5JBy89mimYRre5KUvNv+t
        0hRUlF7nPnFLA/ApQcP56wKXpg==
X-Google-Smtp-Source: ACHHUZ62clwI1bDc8gob+L8cRFqX7RG2mHcT69nqtEtI1HNgVVz1bnuC3Biqy4NvHzcY8XnVdYQGwQ==
X-Received: by 2002:a1c:7718:0:b0:3f7:e660:cdc5 with SMTP id t24-20020a1c7718000000b003f7e660cdc5mr6736284wmi.9.1686557571903;
        Mon, 12 Jun 2023 01:12:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v18-20020adfebd2000000b0030789698eebsm11686312wrn.89.2023.06.12.01.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:12:49 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:12:45 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ricardo Ribalda Delgado <ribalda@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@kernel.org
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Fix error path
Message-ID: <178ec977-5be3-4b2a-bb24-1286be68baf2@kadam.mountain>
References: <20230612-mt8173-fixup-v1-1-81f5c90316d1@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612-mt8173-fixup-v1-1-81f5c90316d1@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 09:49:32AM +0200, Ricardo Ribalda Delgado wrote:
> @@ -1175,14 +1179,11 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_cleanup_components;
>  
> -	irq_id = platform_get_irq(pdev, 0);
> -	if (irq_id <= 0)
> -		return irq_id < 0 ? irq_id : -ENXIO;
>  	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
>  			       0, "Afe_ISR_Handle", (void *)afe);
>  	if (ret) {
>  		dev_err(afe->dev, "could not request_irq\n");
> -		goto err_pm_disable;
> +		goto err_cleanup_components;

Hm...  I hadn't noticed that.  You're right, but I don't think your
patch goes far enough.  I think everything after the first
successful call to snd_soc_add_component() should be goto
err_cleanup_components;

But I am not 100% sure.

regards,
dan carpenter

>  	}
>  

