Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80B95EBF37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiI0KFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiI0KFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:05:38 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B966AA3D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:05:37 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id d14so4857000ilf.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KMDPm9tfxqbkL9YemYDxZDKB4K9QzyoYtKdQxEFag6I=;
        b=CoDsXSwd8sG5Bs4BldgrkYONAW+DokpelmfcLoj9fOBdnH6QeSLExEsirl7Ls3MAq9
         mDzqWzv9HEChi13yiwgkXnr0KuxVjZpBA953zPf0Dlc1SrByIH7+GcL+/kK4Nun7PXVG
         kSP5xEX+gNvHP3dD5p1mHhebRdAIoLwit7UNH6iOe+q8uXyOwqHfEZYUjXQ9sp6CmwiU
         0btSngNIf2zY7tXDtfjLM/6R8G35T+DhSw5v2gBJLXpxtDu3fVckk93Rc/JukJWeFohp
         nD2on5+KGkJ7NdkAs8w4Pxl7G39BcvQ0jRJbJ7LAbsA25hfSuQzmuuGluBL/rULv3zwR
         DFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KMDPm9tfxqbkL9YemYDxZDKB4K9QzyoYtKdQxEFag6I=;
        b=VtGMv/8Q0imjar/uLFe0OCbOV+4RWEU4Huceo0FfpeAXAGGM3vyOmHyzvAdmXC3/KA
         DvROY5qxM2OAUnOl/6axWGmeVnhSo9pkbtbL90guGxcLMbEYJM6OUeSZKSuX+pEyX5Bi
         8ZhfS8DYzr2/uo1tHHcsB3yCQy5AypZWj96QBwXEyJZtH4zSZ2ycNhF9VuGHKCf/IYzj
         jFg0QnmmrCYmJgwx1/wF4DV1Vh44OllMkGdtAT+LRAwOgM2fqZGbm6iBASXv75mq/fCr
         lGMxRHFyv8nLnYZeanXSrR8OVPHtTqE1VV9nQ5iNU2aFMf52d38fWuOL9yVM4soq/irY
         QXAQ==
X-Gm-Message-State: ACrzQf2A/ox9Hrz9zpt92zqo+UBuOEyjUU670RG6XnK2vZ4CTS1I0Rjj
        qSzihP1QwChq7oLcwARc3Fl3qSo5sQO+Ilm6Xg6GWg==
X-Google-Smtp-Source: AMsMyM5qtPTHDyEOFZW8f8BH9J8kzgkGtIgU5GquNcVOxcmrhNri4fDu8OutQMG+p1if1aaTHEpF3JJBrbItEkTn+zQ=
X-Received: by 2002:a05:6e02:12cf:b0:2f5:ddd9:b3d3 with SMTP id
 i15-20020a056e0212cf00b002f5ddd9b3d3mr12322716ilm.122.1664273136354; Tue, 27
 Sep 2022 03:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <1664272126-82706-1-git-send-email-quic_qianyu@quicinc.com>
In-Reply-To: <1664272126-82706-1-git-send-email-quic_qianyu@quicinc.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 27 Sep 2022 12:04:59 +0200
Message-ID: <CAMZdPi_u75BVP9scBCV3OToGhmOgJ7df599-OYw9D6iXsdgdOg@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: Use mhi_soc_reset() API in place of
 register write
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, mrana@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sept 2022 at 11:49, Qiang Yu <quic_qianyu@quicinc.com> wrote:
>
> Currently, a direct register write is used when ramdump collection
> in panic path occurs. Replace that with new mhi_soc_reset() API
> such that a controller defined reset() function is exercised if
> one is present and the regular SOC reset is done if it is not.
>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

> ---
>  drivers/bus/mhi/host/boot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 5bed8b51..79a0eec 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -118,9 +118,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>                         /* Hardware reset so force device to enter RDDM */
>                         dev_dbg(dev,
>                                 "Did not enter RDDM, do a host req reset\n");
> -                       mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
> -                                     MHI_SOC_RESET_REQ_OFFSET,
> -                                     MHI_SOC_RESET_REQ);
> +                       mhi_soc_reset(mhi_cntrl);
>                         udelay(delayus);
>                 }
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
