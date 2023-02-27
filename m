Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00936A422B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjB0NDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjB0NDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:03:37 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1E9EE2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:03:32 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id eg37so25293762edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:03:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grcfhPYMIKjKzUEzsOHSPvB1qMtGpdkLMhOfuCCOKaw=;
        b=Q+II4NtQd/ofR07y45CD/KQhdiepm5UYqMTeg2aOUsQfmJtXzBvoPV7M+wQjNI0m//
         9UpEkBy0GZApMoAU5R89dJ5+mRhBq2aH6X2gcX0u+OHTQaHGh7S2ZTm6Ax0duiiHV9TN
         QHptDC/85syUPCqAasXda4dg6rvNUTsDu8sm8xkEHw+HWPdYLdKdo+KB/btNdx9X5NSl
         sO3sdPc2NSaraqNq6aB+pQrU0RaVpxcQkQYk3XTWLktVafxPmoai0x8pmfv/3jF/OGJH
         6JBVH8Bi43A0ycJKrwtRBBKuy/qccQ4KeZPsJGwI2doKnjlQY3jao1w90zOkygoPeYah
         Jp2A==
X-Gm-Message-State: AO0yUKVZ9lpr/e0xKuVF0mpfLGHIXORShSH6fywuv30ABvAydWwm3xBP
        hBy4Xrsd1ifH9PzHyDHoS/DMhEStQLE4tK/Pd9k=
X-Google-Smtp-Source: AK7set8/+IQTMBrUkorz5oeO69IxuQ7TQaKpMOg0aTQQnpNVGG92OQO598DtjsXa5+Y/os9lNZ+SCvjlhex2XBerZEo=
X-Received: by 2002:a50:d544:0:b0:4ad:6e3e:7da6 with SMTP id
 f4-20020a50d544000000b004ad6e3e7da6mr11956787edj.6.1677503009941; Mon, 27 Feb
 2023 05:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20230225064148.274376-1-saravanak@google.com>
In-Reply-To: <20230225064148.274376-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Feb 2023 14:03:15 +0100
Message-ID: <CAJZ5v0hQ6Yp21OYfwNs4myoZaXRuB8h1A26wLy=LgLmkO2Vm5Q@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Avoid spurious error message
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 7:41 AM Saravana Kannan <saravanak@google.com> wrote:
>
> fw_devlink can sometimes try to create a device link with the consumer
> and supplier as the same device. These attempts will fail (correctly),
> but are harmless. So, avoid printing an error for these cases. Also, add
> more detail to the error message.
>
> Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
> Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f9297c68214a..4f02a10f802f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2088,9 +2088,9 @@ static int fw_devlink_create_devlink(struct device *con,
>                         goto out;
>                 }
>
> -               if (!device_link_add(con, sup_dev, flags)) {
> -                       dev_err(con, "Failed to create device link with %s\n",
> -                               dev_name(sup_dev));
> +               if (con != sup_dev && !device_link_add(con, sup_dev, flags)) {
> +                       dev_err(con, "Failed to create device link (0x%x) with %s\n",
> +                               flags, dev_name(sup_dev));
>                         ret = -EINVAL;
>                 }
>
> --
> 2.39.2.637.g21b0678d19-goog
>
