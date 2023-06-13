Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8464C72DCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjFMIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241620AbjFMInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:43:10 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC06E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:42:58 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9e4adf29eso6288141cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686645777; x=1689237777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ff1bnOtZ9v4wnT3giejCsPL/6NFwZf5IbRyq9gwT7LM=;
        b=GwHeWIOYWMgxT/JG8jvs0Roqgm1VzTQocD+q4UBfuXNC6lMi+WNBUXfyf75pUYtyVY
         UahuC5U+/akRU1X6i9XzUyBOFY/DAyV9WPBr1+1BdlMIzS51NfMLY4TkuKlBrDVTs/+f
         HmY10qTACjf857qkYqLYsfMM91f9huJ74R8mh8FFuJ3E9bUchM+m2DywW49voyZdvuwA
         PLt1eAE/QxsZrUUPVKweIN05EWUNYxLllV3/pPXuQ60mo7lcyIejDvbOJapeje+UzxW0
         c+RvfW/kPmxi5700hUztZYpQFoPq3UsDuDGMNnX7UPcD58QtwXrvfkfV6E14LWhdzCm6
         /E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645777; x=1689237777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ff1bnOtZ9v4wnT3giejCsPL/6NFwZf5IbRyq9gwT7LM=;
        b=cciGQZ6G/pwel1oAKIKRYzLu3o5ul0gVr8s4Oo0cSiOSqkhpAqQ4mmsR5kJxr92tjO
         tTtO1YkwzYjnof4dlRbAaljMIPNDtCd8qLbrTRPGNuvv6e9Z2tb433Z9ngc72EegzH5k
         IrC06JMZ28ejOAtc/mspaiLTwP/t0UuQRK/avICMYLk0OAgWUqtUsO00oucNqaTyHy28
         zApJg3zHPV+bcXFWvEPbaxIFg1kcgasJBm73etxyLwWGgMmBN9J4Umx+IVWYBRkhpKit
         RnSZDrTCR7hYjNAtxELnaf8CIdP/yznZiz2KgnwTtwFMKh/kApLlg0u6q4b0jWYMWcxd
         P27A==
X-Gm-Message-State: AC+VfDy0CwIusV2GRml43rN0snNjYG9Mbu0Q2bBIMG7yAGpP+rpOT3pD
        APLpJbkgCP9HhF4MLI+QKF9LIQnmJNHmBRftOrdgFQ==
X-Google-Smtp-Source: ACHHUZ5HM8XujNiJiPfNAJ4f3QXYqPcQBJItqXklDUYyfowV9lvwCH/kGUwlRr4yuYG2jeptYwVdZQma2l5ssQj92vs=
X-Received: by 2002:a05:622a:1991:b0:3d9:4586:3ab2 with SMTP id
 u17-20020a05622a199100b003d945863ab2mr14550698qtc.28.1686645777567; Tue, 13
 Jun 2023 01:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230613011853.6385-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230613011853.6385-1-jiapeng.chong@linux.alibaba.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Jun 2023 14:12:46 +0530
Message-ID: <CAFA6WYO1dr_Se9AWyToZCwbxDA10D2bM_ADXLCLi8Acx+sxspQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Use kmemdup() to replace kmalloc + memcpy
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 06:49, Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use kmemdup rather than duplicating its implementation.
>
> ./drivers/tee/optee/smc_abi.c:1542:12-19: WARNING opportunity for kmemdup.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5480
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Add one commit message.
>
>  drivers/tee/optee/smc_abi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 3861ae06d902..d5b28fd35d66 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1541,12 +1541,11 @@ static int optee_load_fw(struct platform_device *pdev,
>          * This uses the GFP_DMA flag to ensure we are allocated memory in the
>          * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
>          */
> -       data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +       data_buf = kmemdup(fw->data, fw->size, GFP_KERNEL | GFP_DMA);
>         if (!data_buf) {
>                 rc = -ENOMEM;
>                 goto fw_err;
>         }
> -       memcpy(data_buf, fw->data, fw->size);
>         data_pa = virt_to_phys(data_buf);
>         reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
>         reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> --
> 2.20.1.7.g153144c
>
