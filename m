Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82626636953
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiKWSyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238111AbiKWSyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:54:39 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C318220B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:54:38 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id p4so18331085vsa.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 10:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YkY98wWkOr8gcPA7rEJ+Ei5Q1t6NA6kWh2YpykOcth4=;
        b=h/KmO1JPprgqmpWqh2J/alqyxC9f+AjXXJRyeDTBqUUe92grkau7vpD/KZxCtOjEBc
         Mn2ZR5cg4JdRUx4XruFVAsYt+t4jDonUJ9sSN3JfNww7hanbIIb3Nye9j86ejJoC8Xrm
         L/BYMoITUydsw+LXLxpT4M0eGnYAWUtODeGhy6xQK/L0zn4uk7e2AYmR+rfw45Dosmyu
         Ku7+Y24VnxQjRALrKlWZBz9N4x/pCcJjKJI5di/0EigVprwWuHFjKKQc3j90DohxKjWS
         EKPj8dTXKzpRO17HDO3dp0eu8ndJXZVO643mQCP9jYfLfScjJ2munKVM/J8eBD5qypK4
         gg+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkY98wWkOr8gcPA7rEJ+Ei5Q1t6NA6kWh2YpykOcth4=;
        b=u54sD5K/lQ68yuUKQPnQJ7J/Xzp4HAOOkVOk2iHG1PnS/IdEThrurWM3ydiXQfv9+s
         iLBET4kSy91zGBsm1VHVjtvJWBqFRCmy+wjdmRToavc0Cm8nFtMecCUteJbB78vSW566
         e49OLU9tWCfHNbwrapxotPOQ6hvSjQGUaurRceLwJI+bkv39m8/KWzcZljKS5utQAL3J
         K3SZLTkuZlpB4geADfvossC6qS9Mg73ovpdfVDQMDcbRnhezJtwe29RHPjXFVn9lhHym
         Wx/cv2J3kYg9e8fd0CagQX2lREHenrvat5QfnoBqUUYkm3d7WR7gfNREIjXw78xwLR4c
         wWvA==
X-Gm-Message-State: ANoB5plcDF4g1btJcppYdnBZ8y6NKQkpMHNi5F9u1FObOu2/F3bPwzQR
        UjmnMbk8WhnGeU3BThJETNY+fifshrKPo7O5xLuzl09SLA==
X-Google-Smtp-Source: AA0mqf68c8mA0lq5iZRPdSShNp/XWyAH9LMDdOzgyYW57LEaKd+hvqp1SyTHnEDwsaujfB8ZQyT1vHi+3W6lhckqjYQ=
X-Received: by 2002:a67:ed94:0:b0:3aa:8846:b9a with SMTP id
 d20-20020a67ed94000000b003aa88460b9amr6311148vsp.58.1669229677407; Wed, 23
 Nov 2022 10:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20221121055345.111567-1-jake.macneal@gmail.com>
In-Reply-To: <20221121055345.111567-1-jake.macneal@gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 23 Nov 2022 10:54:27 -0800
Message-ID: <CANDhNCqCYkv7Ja4RT2_DEPh2zFFL+SD82wru_FC6dupCo6_4RA@mail.gmail.com>
Subject: Re: [PATCH] time: copy tai value (International Atomic Time, in
 seconds) to output __user struct in get_old_timex32().
To:     Jacob Macneal <jake.macneal@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 9:54 PM Jacob Macneal <jake.macneal@gmail.com> wrote:
>
> Previously, this value was not copied into the output struct. This is
> despite all other fields of the corresponding __kernel_timex struct being
> copied to the old_timex32 __user struct in this function.
>
> Additionally, the matching function put_old_timex32() expects a tai value
> to be supplied, and copies it appropriately. It would appear to be a
> mistake that this value was never copied over in get_old_timex32().
>
> Signed-off-by: Jacob Macneal <jake.macneal@gmail.com>
> ---
>  kernel/time/time.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index 526257b3727c..7da9951b033a 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -311,6 +311,7 @@ int get_old_timex32(struct __kernel_timex *txc, const struct old_timex32 __user
>         txc->calcnt = tx32.calcnt;
>         txc->errcnt = tx32.errcnt;
>         txc->stbcnt = tx32.stbcnt;
> +       txc->tai = tx32.tai;
>

This does seem like something that was overlooked.

Arnd: There isn't something more subtle I'm missing here, right?

Otherwise:
  Acked-by: John Stultz <jstultz@google.com>

thanks
-john
