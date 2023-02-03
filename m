Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF79689904
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBCMr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjBCMrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:47:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B749B6E1;
        Fri,  3 Feb 2023 04:47:18 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id n6so5047852edo.9;
        Fri, 03 Feb 2023 04:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGXpsDZW1GWu9cgvGV1/vMzbrERHy0kL3Gp0laeSlVY=;
        b=hWx5K20vJDnRicgVGstttjaCJ8ySjVATQYesILHoUCheZm/clr3DPRbGq31PW/R0zj
         GzGMVYiEKqEKTQhOwxnn2YBNwCeWWlUtLtlcV3NuVFwIAOITaB5ly80QXnwH6mYYuP34
         o2NqM+2CoBdv6M7FshiyCHKEkVb98Lz2AsO+SKa9zyOLB+0JhxsvC27APSjXsgJsVOZ7
         +SLp95kOJjDVOr46Rt9cv4bIsXEGvp7pd5lzLklpVSPhKaobDKgAFOXQJcfdV2Bz0RVh
         k5xUWiHl1q9AryJuAPknqH1nNX3fOzKPH3Noz3Lx1Yh7ESM2qGSlMrMuS3KeCQPLqKNj
         wLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGXpsDZW1GWu9cgvGV1/vMzbrERHy0kL3Gp0laeSlVY=;
        b=mBVdS5vrZ+J1jN8TBWliG5WFJEUWP0oHZQ5jILoPgSty7g9OHmwNCSNK1vZ797gjIU
         QVkvDyX2UWQVnsnQVzHlfNQes2JG5nfKpYc9NpD1oIEwResUlFXdQdvUqHdKGfxWNUHX
         7cTigwjT1Ljv0mEW6OmrwDGiKDBqzFl2kceErNPGkMTUlzTQmm8Z1lDbjgcpsR5f01us
         MXlkkoGZ75C/k7T6dwUK+u8YwbxOnfl3Lm7rVD8u0rDld5JnYA06dAzQt/KkHrppAqHv
         1tbFg21Kl9h8eJIFDLBddNh98slhxLpXUhQNZdO9Ws0Qazfi/9Fw6NuJWNqT613BV+9H
         JJpA==
X-Gm-Message-State: AO0yUKV8ap/Wbt2uqvDtlnecfI1iUg1KjqOqqT5o+b/IFhw9rSqC8u80
        V6D8rWg2HnZPQp4QhccHWKTtRc/iaf0L+wNB6Ak=
X-Google-Smtp-Source: AK7set8eeQOKgLm9lOBk+gmZZlEnTm8yS5hkLFrOS0N0ZjK5LPHwdgstiEfY+KMIsSJ7I/oOdQCuYAnF2PWYz3AprXg=
X-Received: by 2002:a05:6402:557:b0:4a2:45e7:ee63 with SMTP id
 i23-20020a056402055700b004a245e7ee63mr3023373edx.38.1675428437068; Fri, 03
 Feb 2023 04:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com> <20230127092246.1470865-6-peng.fan@oss.nxp.com>
In-Reply-To: <20230127092246.1470865-6-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 3 Feb 2023 14:47:05 +0200
Message-ID: <CAEnQRZD8MFkn8JB7CJviMF1=5gp6KWrM7-n935xk=Hv1j_VPuQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to TCML
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        arnaud.pouliquen@foss.st.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:33 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The i.MX8M Cortex-M core not has ROM. It has a requirement is
> the stack, pc value should be set in address 0 and 4 from the view of
> itself. From Cortex-A core view, the region is at TCML start address.
>
> The stack and pc value are the first two words stored in section
> ".interrupts" of the firmware, and the section is the first section in
> the firmware.
>
> When the firmware is built to run in TCML, there is no issue, because
> when copying elf segments, the first two words are copied to TCML also.
>
> However when the firmware is built ro run in DDR, the first two words
> are not copied to TCML start address.
>
> This patch is to find the ".interrupts" section, read out the first
> two words and write to TCML start address at offset 0 and 4.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 37 +++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 295e0e0e869a..f5ee0c9bb09d 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -7,6 +7,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/firmware.h>

I wonder why do you need to include this? Nothing in this patch looks like
it is using it.
