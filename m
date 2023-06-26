Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A3273DFF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjFZNBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjFZNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:01:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AED6121
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:01:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-312824aa384so2741189f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687784470; x=1690376470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRFMtW1n5WTYQjYvVy/I9g/WOAZN488DDgX8HS+qDGc=;
        b=Jrz1KAMAKfMtJJsQH6PyeitwpJnwbJBDFkHRjFASqFOFrua68iYG5NJNX1SZ6Lyb6t
         Vp2ecpdBSPh68DWhtDeEqY4LgYXB+1/LBxmHE8xpgfl9/8k//O04MiYqNcu3XnZA4Jty
         f3k0vA1YBFa9sMaumBZY6ff25exH4+izejZHjGQBmgxeDQJK2wlDdDUfpeSzXgBj92nD
         4/uEr4SgdvOfwFejTqapjzsoPku8niMKfS4THYXhpIRL4sdQEBJT+yUKBuTVEDyKJ9Xi
         ZjUmqJPdD9YZ0qVkh3U1Ub73VLZYreKw5pfrvwPt8nRNZB2PxpvuEcpJDeaMRBFUTe4W
         H4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687784470; x=1690376470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRFMtW1n5WTYQjYvVy/I9g/WOAZN488DDgX8HS+qDGc=;
        b=JtHK6Nx1TzwOleYhcTyId0lZdnGNgvESCHborgJVBWnH7/5Kx/bIYjI3M3kC8faqhy
         tYc/p3ZKcZM5nXqwUbjkKRYGNiaIH9ecuiPx/gduapZFMfTLquIjogwjyJuYsdbxfUMI
         /p/Gi5xSR1OMULhcHObNjc+QRE/TY8UIi23gcBqpMcbN6cuBtEjYPF72WIm8Jfqbr4c0
         nWjPu9yhLKQEyskjdHbl0S6D229A/nrqbaPEPdn9JcANivLH8uQ5JE6+FxN6mDXT4cHv
         AjCOzlj6nQmNUE15SrO2HUM0zK5gcQtHBk0AovHDrmKUU7pYkvABtGkdTm7RmYQE5Jh/
         8bzA==
X-Gm-Message-State: AC+VfDy08ptwFKfgyXy+QeoRe5KOUaALRM8G60A+siQZWLFmAgqXz8bc
        WD6rfciy4dW4YqHfRhRQiR9HAg==
X-Google-Smtp-Source: ACHHUZ6RIDygr3u+3XCSH//4Wvdyamoykdy3IJ7M9oTa5bNTdhSKtq/rdDRfYml9nEsfvcZsmswFMQ==
X-Received: by 2002:a5d:68c6:0:b0:313:e952:e500 with SMTP id p6-20020a5d68c6000000b00313e952e500mr2855606wrw.7.1687784469960;
        Mon, 26 Jun 2023 06:01:09 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5232000000b003047ae72b14sm7373703wra.82.2023.06.26.06.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:01:08 -0700 (PDT)
Date:   Mon, 26 Jun 2023 16:01:05 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Uros Milojkovic <uroshm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, marvin24@gmx.de,
        p.zabel@pengutronix.de, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: nvec: udelay to usleep_range
Message-ID: <b7319d00-d8db-4e8b-9143-7926f8a34fbe@kadam.mountain>
References: <CAP=xWk6GvVQxzTJ6jS2pQ9dKvgoFFHc=m4yMma101MGKgdcm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP=xWk6GvVQxzTJ6jS2pQ9dKvgoFFHc=m4yMma101MGKgdcm5A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 02:55:35PM -0400, Uros Milojkovic wrote:
> Checkpatch pl alerts that usleep_range is preferred to udelay. The
> change is made.
> Signed-off-by: umilojkovic <uroshm@gmail.com>
> ---
>  drivers/staging/nvec/nvec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index 2823cacde130..8bb3b691d1f5 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -627,7 +627,7 @@ static irqreturn_t nvec_interrupt(int irq, void *dev)
>          break;
>      case 2:        /* first byte after command */
>          if (status == (I2C_SL_IRQ | RNW | RCVD)) {
> -            udelay(33);
> +            usleep_range(33, 200);

These kind of patches are only allowed if you have actually tested it
on real hardware.

>              if (nvec->rx->data[0] != 0x01) {
>                  dev_err(nvec->dev,
>                      "Read without prior read command\n");

regards,
dan carpenter

