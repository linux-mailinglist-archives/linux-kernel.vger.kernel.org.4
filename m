Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3A618737
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiKCSO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiKCSOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:14:46 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CA6469;
        Thu,  3 Nov 2022 11:14:44 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id k26so1703838qkg.2;
        Thu, 03 Nov 2022 11:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXQkmBG3ZRWtQ3X/34JIoN1SRy6ecuLj5X84hLwMjgE=;
        b=SdYLDaz4iFloa3jzfMPNfQPDoYAI8IV4l/gOQhynoIzUtXOT8Q+GKw4OFIg25pVm+1
         m+xmaNrWD9fXRFtVUNBqV5gEcpss28MyX+aCyVf/NUGJZBg1Y0InE0r/eJKUi+oM1dLu
         MJbE5ndIhk3UE6YIeRjHCelmsq4SUE67cGPN1PGTMk+n70Wheq6GYS5ocRe9Rcm0l8d4
         aBfImf2p5iQq5VuGmLxgGdqHyx5WMUJGELr3JzoOfmC+e4KAWmOXtKPhN/k9GZSLILIp
         YhTI07r8oDAD+1NJGRKZUjHtH34KcSAMAaemsF73B3eVPCyZ2G91QUImlUfoVca6AI5y
         vV5w==
X-Gm-Message-State: ACrzQf0rf77WKZaVgxMCrb70J+TPVO6q+7vH2XC/Ylg0WGf8nEaO7Unu
        61h0L7DMN/b//uxNFtf8OudS8IBn+alUupv6ml4=
X-Google-Smtp-Source: AMsMyM7gFB4U8TgGv0uuiym4T4ZjE5E4A8JkWKAZLwnwsGi7CqEg41huTTzir4c3eE+XLrqwVwLsvvbczDNjKpBKxfY=
X-Received: by 2002:a37:65c9:0:b0:6fa:1ef8:fa10 with SMTP id
 z192-20020a3765c9000000b006fa1ef8fa10mr20114702qkb.648.1667499283608; Thu, 03
 Nov 2022 11:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221103150431.87598-1-colin.i.king@gmail.com>
In-Reply-To: <20221103150431.87598-1-colin.i.king@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:14:32 +0100
Message-ID: <CAJZ5v0i4=m1xhVbh10jsFyuHvKBQP3pia0QdONg4bQERR3Ay2g@mail.gmail.com>
Subject: Re: [PATCH][V2] cpufreq: longhaul: Make array speeds static const
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Nov 3, 2022 at 4:04 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Don't populate the read-only array speeds on the stack but instead
> make it static. Also makes the object code a little smaller. Replace
> hard-coded loop array bounds with ARRAY_SIZE.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: replace 4 with ARRAY_SIZE in for-loop as suggested by Joe Perches.
> ---
>  drivers/cpufreq/longhaul.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 3e000e1a75c6..4c57c6725c13 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -407,10 +407,10 @@ static int guess_fsb(int mult)
>  {
>         int speed = cpu_khz / 1000;
>         int i;
> -       int speeds[] = { 666, 1000, 1333, 2000 };
> +       static const int speeds[] = { 666, 1000, 1333, 2000 };
>         int f_max, f_min;
>
> -       for (i = 0; i < 4; i++) {
> +       for (i = 0; i < ARRAY_SIZE(speeds); i++) {
>                 f_max = ((speeds[i] * mult) + 50) / 100;
>                 f_max += (ROUNDING / 2);
>                 f_min = f_max - ROUNDING;
> --

Applied as 6.2 material, thanks!
