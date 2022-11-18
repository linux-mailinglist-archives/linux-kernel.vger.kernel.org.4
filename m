Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8699262F1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbiKRJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbiKRJqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:46:30 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1C8FFB2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:46:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jn7so2243172plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yAGhoUsMxs2sC8md2MBnH6lAKU536ruw0p1wXnUnqx8=;
        b=hB1z4Zq0cIGj5xqEbdIc9Try6UeRi5TufQA1V2870JTTuXhMytdkZBgtLsVW4/mm90
         b5JensghdKiQ5bPX/tHoY5+NsD/b8rIYzV94Ti+k+22nbZeFcK9dmmnyXxCYU5eiCuIe
         fuWWkkBLef5QyWm+wgzumd1knfj1/34NMnMbkm0zLYqDB/qVOQavBImaRAxWlVieSU01
         7S4AFEzjmk7w8UHqv6L26Jez+Z9HTAxaCHgKpQe8OGo8Ypl62O4hxkUsBxJ2UooIhaNX
         RBHXn4zXwQLqW13vTrb8Xa3eXShyTL3wJn1+hdcIebYMsyo5AZNcTTaHSAVsfs1jf0+x
         aG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yAGhoUsMxs2sC8md2MBnH6lAKU536ruw0p1wXnUnqx8=;
        b=nD/TXFhqESnziAOglIHvKVojV8BgLFvKTdTEzECCrhoRbvpkmCBKzIo80/xDaTc9ct
         uw4O1WWhDaIBisqUEtTE4QIHg2kHth2aVT1GF3PMXn8BB8ApFaKGcbcwBNaPqYDvmbzA
         UyG+txluHatNlmXuJm1SiC8ljn9Z6nTKLud1q1NX+/6bUtt2FKHDz2ZodV73EBWCZLVw
         97nDYoqaomsu4L76jI+55MpzQzbxLnda2/tbfbRJP1UYOLpR/h+1bCvfzIv/zLuXRx+S
         pabdmk1aeZyoVHk4/UhbYinKHi3pG7WeRdmQKlYua0u3KQZamZx8bCtjcAgHqy58V6Py
         dW1Q==
X-Gm-Message-State: ANoB5pnNwQz2slgeWGE72Eqr9f6iRHp0NvBppYjaZea8d3uCJmWKR3a5
        iAtJL32E8zqwCXyxE2/CcK6/PT0uxi4SoeFmGZBrqg==
X-Google-Smtp-Source: AA0mqf7KvjqnKLTejxVMCRk1Ye4pVlzsupzUISR3rd9uxhXAzl/ggV5YOiheX933yJDBN2D5T1bQ4V2baF5bN6PRWAE=
X-Received: by 2002:a17:902:6bc5:b0:188:6baf:2011 with SMTP id
 m5-20020a1709026bc500b001886baf2011mr6456815plt.165.1668764766612; Fri, 18
 Nov 2022 01:46:06 -0800 (PST)
MIME-Version: 1.0
References: <202211171524116446204@zte.com.cn>
In-Reply-To: <202211171524116446204@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:30 +0100
Message-ID: <CAPDyKFqbbcwyf9YUAPBZdfA4ujM6EcvcujQ9Skr7x_q571-CqQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: pwrseq: Use device_match_of_node()
To:     ye.xingchen@zte.com.cn
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022 at 08:24, <ye.xingchen@zte.com.cn> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with device_match_of_node().
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/pwrseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
> index ef675f364bf0..2374669b588a 100644
> --- a/drivers/mmc/core/pwrseq.c
> +++ b/drivers/mmc/core/pwrseq.c
> @@ -29,7 +29,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
>
>         mutex_lock(&pwrseq_list_mutex);
>         list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
> -               if (p->dev->of_node == np) {
> +               if (device_match_of_node(p->dev, np)) {
>                         if (!try_module_get(p->owner))
>                                 dev_err(host->parent,
>                                         "increasing module refcount failed\n");
> --
> 2.25.1
