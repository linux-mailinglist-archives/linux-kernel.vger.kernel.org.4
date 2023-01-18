Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08C56720CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjARPMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjARPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:10:20 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0A13B0ED;
        Wed, 18 Jan 2023 07:10:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k8so19768764wrc.9;
        Wed, 18 Jan 2023 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I7lrvTAlA/3t43ULdgygOD2DvyJWRLH9rn+t5O59C4Y=;
        b=TlXrrR3oLwQF0H1oQ8zO7QxSERWmDmVaeW5jHGErLAPhlCd466aElVeI12xdp3SR6X
         lZ+xkj6WkFnkDAOV2QLRxuLeQRBVEH3mGF2hJprYhQGnuEZtKgPucXfL7dahyku4dM92
         eyO6lzaoggWF1VqfV52FQprhhON0Tzew3P2ni0BZepGWZZnAtJ15kCViAKDfN+zSsbUf
         LMlKM5guK4dXJ6Y66UiiVIKigLXznwsf/FCxvfa5fOuNHx6wP3bG/d4LiXAgy30izivP
         aGWLMvzIjMbjnTo42+6pZsO0Zj6IFeG5vD+QOFrei0QrnPBWKM9i7NOvoa+MOh6JREUb
         vQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7lrvTAlA/3t43ULdgygOD2DvyJWRLH9rn+t5O59C4Y=;
        b=IijYSSdY2sKLzFIZPj+5Fkh3zJ2CL44bbz0fcaN9Jk/AMTQMCP1F55C7xAs5351xzT
         KoPUVyikIgK/c84uWFDJFwlqvTwj5pGLH9fs3xzBgGb3hejXeStwTHZt8Xq3GYI2iivE
         3AE4IbJZVo4hIt6TCdn+tpz6Tk4BUdT24NJPmA1SQ8YlUz20ITzDGhMWavE850/ecWI5
         92bCtiKkkEQZpIJRiwIUNOuB6z5mo6mdjre2kSX9ReCfp8Nkk0L6m5cj+UiuGeBeyctH
         ++ZGhZGdIfs03XX3JjLb1vD51pOznRuprx6c0qBJsfKQhQBVM9OQknq4rLV38f+qkYQg
         Cudw==
X-Gm-Message-State: AFqh2ko1Ah7RB8Qq1mA1EvvPq7m6A/ocavCGBfY/86GhCsYoR/8Su7j0
        XvVBLdQ+LueUWa24vyusUM5lveNtJqHQ6w==
X-Google-Smtp-Source: AMrXdXud9Vgud1/nkgt+2pvzn+6PugO5Q1FOSENUGO2/6oCi+JrBipRvnA9IQQX9M4Ijt4HqaUHTrw==
X-Received: by 2002:adf:edd1:0:b0:2bc:7d12:e736 with SMTP id v17-20020adfedd1000000b002bc7d12e736mr6296609wro.1.1674054613965;
        Wed, 18 Jan 2023 07:10:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i15-20020a05600011cf00b00294176c2c01sm31123998wrx.86.2023.01.18.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:10:13 -0800 (PST)
Date:   Wed, 18 Jan 2023 18:10:09 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832: Replace macro
 AD9832_PHASE() with function
Message-ID: <Y8gL0XNYw5qbK82B@kadam>
References: <20230118150306.16448-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118150306.16448-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 10:03:06AM -0500, Brent Pappas wrote:
> Replace the macro AD9832_PHASE() with a static function to comply with
> Linux coding style standards.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 6f9eebd6c7ee..537825534a28 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -59,7 +59,9 @@
>  #define AD9832_CMD_SLEEPRESCLR	0xC
>  
>  #define AD9832_FREQ		BIT(11)
> -#define AD9832_PHASE(x)		(((x) & 3) << 9)
> +
> +static unsigned short ad9832_phase(int x) { return (x & 3) << 9; }

The original is fine here.  Just leave it as-is.

regards,
dan carpenter

