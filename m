Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B060CD32
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiJYNQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiJYNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:16:08 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92521C897D;
        Tue, 25 Oct 2022 06:16:06 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id z30so7936473qkz.13;
        Tue, 25 Oct 2022 06:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Gp8hIHayT/q2QL+oi9paN1etmItfVfSgG3PlVV1iAg=;
        b=ZULCWQ7xmbw4sD9aTf0S98jOj5PKOfIbDhJ+IlkxV9G//m/Imy0xZgmrkBxf1VEffa
         yqXdptsxVap3gphPo48+XgDv4yAAFHqarAxmyxmG3zhNqyCBThPcmSUdYSjq7jGqv5Sm
         fRU2H5GA8SRx0W4ko8Na0b0P67VkDW5TqlJ5tfuwratgNI5nnl6i+giNvJ/0dYCkN+Ol
         sgOBBZkajyK3GdUTKu/oVTWwyEnGQxkkXiS50+ZVl6OKX2Xh3yRfhddFGdx9OYjAIEew
         iHaabU0kz1rm6WPx1ln1e0yB9ZzPaVRfTACkx/IxRcY4FLZxnVXytuF8eoWhxQ1ZgKUJ
         b0Qw==
X-Gm-Message-State: ACrzQf2fogUSYQxpmq+pUmOGLjfE1VOV2i4SIUCtRtbS96U4NNrrYrC3
        88IhFzcavOL39ECVqXy2RrnKQlSCFJaz9Weud4HY74bD
X-Google-Smtp-Source: AMsMyM63tcNohjwVZJqEBDvtoilMkb6vKCwWsg4UeavjXNIs4l7lHHpsqIrFobD/Amgse+nK27xNoy2GNNmZame3NqQ=
X-Received: by 2002:a05:620a:4626:b0:6ee:b43:d2bc with SMTP id
 br38-20020a05620a462600b006ee0b43d2bcmr25641666qkb.764.1666703766067; Tue, 25
 Oct 2022 06:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221020115513.93809-1-ulf.hansson@linaro.org>
In-Reply-To: <20221020115513.93809-1-ulf.hansson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 15:15:55 +0200
Message-ID: <CAJZ5v0iPaP60OxzS4RQv8-JO1-cuv=JAW8zHwjCbyVXgLDa-RA@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: psci: Extend information in log about OSI/PC mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 1:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> It's useful to understand whether we are using OS-initiated (OSI) mode or
> Platform Coordinated (PC) mode, when initializing the CPU PM domains.
> Therefore, let's extend the print in the log after a successful probe with
> this information.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 821984947ed9..c80cf9ddabd8 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -181,7 +181,8 @@ static int psci_cpuidle_domain_probe(struct platform_device *pdev)
>         if (ret)
>                 goto remove_pd;
>
> -       pr_info("Initialized CPU PM domain topology\n");
> +       pr_info("Initialized CPU PM domain topology using %s mode\n",
> +               use_osi ? "OSI" : "PC");
>         return 0;
>
>  put_node:
> --

Am I expected to pick up this one?
