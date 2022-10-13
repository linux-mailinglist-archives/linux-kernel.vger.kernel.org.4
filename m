Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372945FD898
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJMLnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:43:02 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E429B1DCC;
        Thu, 13 Oct 2022 04:43:01 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id l28so790692qtv.4;
        Thu, 13 Oct 2022 04:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEW8tDgFPRHfRa0+o25FQhK00CXSj8b3QIG9cVhiYs4=;
        b=k9vosQSSe2uGFhMiSPsUYaLqLFc75RjjNHJ8Rjcm3/FeYM0S9OnB0FPtrbOG6kz48V
         R4d8n1rXcJ+vtT/ouBGyvbhfrGi5KUsYMFJPNBH6s4oVqYru1w1+7WaD5dG6gKLMzzBe
         x9XodDgUbqVYpeI64MKkcjrUahkoChBn/ojpR2HxqUd/zZIt15zUv1lbBAijbuLY5/7U
         0jmekt6FtlWMQ+9O5i1AVIDl+LowD7jSW3h5Eq/Q1zdF9uZCzpi9jgv24qt2zCIIa+WW
         T1/3GWI34SeJaTTZg7utepSRsLw+eBrUfEOuoKg0ug+bSIVg5UTRr57Bo89BPi+MNlbn
         b5cQ==
X-Gm-Message-State: ACrzQf2VYSfCCw3q5g5VPrMuVQNWQnb2rs0uK81cnsTSpTES0FFatjNs
        +qibZfr5qyg3NKkiqbvcqS6dNce8cvxaDPRP4xQ=
X-Google-Smtp-Source: AMsMyM4z3yNp6XfWTNSFLj9brRTdO0VIZDfirwaayxVUUERF2rw9dcPLiz9+Kl4NDl68FmLAg2jjqFgvCn36O7NkGyc=
X-Received: by 2002:ac8:5ac1:0:b0:39a:123c:9df5 with SMTP id
 d1-20020ac85ac1000000b0039a123c9df5mr16490537qtd.27.1665661380743; Thu, 13
 Oct 2022 04:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221013054947.1355884-1-pmanank200502@gmail.com>
In-Reply-To: <20221013054947.1355884-1-pmanank200502@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 13:42:48 +0200
Message-ID: <CAJZ5v0h2fmf=DFY2g9+sdStsj+coPQPwbub8QnNuaK26_xv69g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acpi_pcc.c: Fix unintentional integer overflow
To:     pmanank200502@gmail.com
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Oct 13, 2022 at 7:50 AM <pmanank200502@gmail.com> wrote:
>
> From: Manank Patel <pmanank200502@gmail.com>
>
> Fixed unintentional u32 overflow by casting it to u64 before multiplication.
>
> Signed-off-by: Manank Patel <pmanank200502@gmail.com>

A Fixes tag would be nice to have here.

> ---
>  drivers/acpi/acpi_pcc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index ee4ce5ba1fb2..b929d2e5c622 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -112,7 +112,7 @@ acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
>                  * processor could be much slower to reply. So add an arbitrary
>                  * amount of wait on top of Nominal.
>                  */
> -               usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * data->pcc_chan->latency;
> +               usecs_lat = PCC_CMD_WAIT_RETRIES_NUM * ((u64) data->pcc_chan->latency);

Or redefine PCC_CMD_WAIT_RETRIES_NUM as 500ULL?

>                 ret = wait_for_completion_timeout(&data->done,
>                                                   usecs_to_jiffies(usecs_lat));
>                 if (ret == 0) {
> --
> 2.38.0
>
