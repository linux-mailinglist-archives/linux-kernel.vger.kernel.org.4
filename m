Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0F76229FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiKILPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiKILPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:15:20 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67926252;
        Wed,  9 Nov 2022 03:14:53 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id h21so10158949qtu.2;
        Wed, 09 Nov 2022 03:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2LoQEn5/8EtgWAYYJZo0hd0ZjYLVH9VwKS+TlrTIk8U=;
        b=zwUZbdy4a1Hlm8/4LWUX1PK3WOAYybBzupQ7ihYjU2gTT2Q28TDxCfhhpKCXjPFpDn
         sVpbEk74sTXNfOu+kKKubadymyfnqwisH3OpZ//uEx9/DuXMyaPMDLMX0kozd2LC6IuV
         NKb+LoYdu9FHWDmGZTmYM69tmaV+2fYDHoZT2Cu0P0VhBsKWD4syMG7BFpK7sWv0BnBP
         m+ZmeLY4JTnm8v2dzTHQTTEk6IkUIMjS4pfxaOyTG1tDCGW5SBopBeLmjK0wSUykA2mE
         yz8VQkcDRSAQOCOSshlqnQ9anblyBDHOUOe63w7E/Wuvp5M7psbw6pJjm0siA3Ekiejo
         uvIg==
X-Gm-Message-State: ACrzQf0SeKMn5I6EWYcIQVfCv+lMxQpyb8+sOrbgm1CR9VdLx5sjJZ3c
        YuaxIi9lkQpBYbB2h7ZFcERQzN8e7T0r4AjuK3EQwh1q
X-Google-Smtp-Source: AMsMyM5nuCDdu/kzC0URQJdfcaMgsRlSh9RigkZ48kqx1mrKcKMKMgQEFgO+YfQ0gFCzRqd3Fki+zuGBGYncCOV1EMA=
X-Received: by 2002:ac8:690f:0:b0:3a5:4678:5b24 with SMTP id
 bt15-20020ac8690f000000b003a546785b24mr865490qtb.411.1667992492912; Wed, 09
 Nov 2022 03:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20221109105114.32886-1-andriy.shevchenko@linux.intel.com> <20221109105114.32886-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221109105114.32886-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 12:14:40 +0100
Message-ID: <CAJZ5v0grw=PcbLcMmaUSU_spdh7W2tSAy0zyw=08H+Ak82NXNA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] resource: Convert DEFINE_RES_NAMED() to be
 compound literal
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 11:50 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently DEFINE_RES_NAMED() can only be used to fill the static data.
> In some cases it would be convenient to use it as right value in the
> assignment operation. But it can't be done as is, because compiler has
> no clue about the data layout. Converting it to be a compound literal
> allows the above mentioned usage.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/ioport.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 27642ca15d93..67d3fb2133b6 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -155,7 +155,7 @@ enum {
>
>  /* helpers to define resources */
>  #define DEFINE_RES_NAMED(_start, _size, _name, _flags)                 \
> -       {                                                               \
> +(struct resource) {                                                    \
>                 .start = (_start),                                      \
>                 .end = (_start) + (_size) - 1,                          \
>                 .name = (_name),                                        \
> --
> 2.35.1
>
