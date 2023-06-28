Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8C7741281
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjF1Nc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjF1Ncb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:32:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FF61705;
        Wed, 28 Jun 2023 06:31:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso4805820a12.2;
        Wed, 28 Jun 2023 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687959098; x=1690551098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FUnaW6Od3Yv31RkB8JAdBBWdogXZHwC3KylqgBdp8I=;
        b=pZt0W2Ch5oOAafjon76+3AXSaQqYipdQahYl7hiTfj2uMPO5byT4CkSR6N/0LZafUO
         IE+4ZvNP5BjxXieb3AdwDKd4nZJUTgeFMPJfT1sVPa1cziz8XcDCn0xX6h8b9igT5NbA
         mJQagYG9VGy6pQDN33XTNlfe9e+9lxiTbBId9JXi/NoMiDfPE5VGOzgJtsoCQHEvSTAC
         fNC7QrN0NJJkeDC4MLJWWyGTXhn9r9q4HxMiQ3dmjwgGUFBggjJtdjlaojfO8hNqlMIh
         DomUMpWytZdIsKIxn5iaCZLgKfZqVYN76jWuBrMN6p3+G8MewpnrRWGrpx2LEbPjZh93
         f7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687959098; x=1690551098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7FUnaW6Od3Yv31RkB8JAdBBWdogXZHwC3KylqgBdp8I=;
        b=KpLRf42EN+yy+J75xRUm6qWMj0uC/3yShlbmyBkC0WkDxASHB0NgGEBEdus8JmiHTG
         3jNuyWPOrPeXGhyuYkpDRsh05+I2hMMOeQNqNIMrU022YriEGGY9b413Y1yeT7bJBXOv
         4icatWTE0kjbzSjCk6mInxa/05MHHQe/cG+hTBvCiMAzr1rkK1IPuaGcUMjCvFYJKhMT
         k24SHJIzCuxRCg07YTGxdsz4CbidH+WvCKIEkOJnZIFg1Ph6+LwJfJUVHNk9QY1VzVH6
         e9eO2+2LDuWNWaboYFHrg6GDkvWECYhUL/22e9a79guxz6LX1KxjbOlG27JDBrPz5sxC
         CcPA==
X-Gm-Message-State: AC+VfDxQgV02kqe9LZHM+xuR5CsHtiR10yKNaRjiLzutRTIgA10pDCga
        9Dl7OYx7G2xeKaIf8hAgcgdOY9GRtMZz3QZR1bs=
X-Google-Smtp-Source: ACHHUZ4tJxtb9mtDVz05B6rx/caVQ80f6FNKZiZvs5KBgQj2R9xBIm9SvAJ8zNw1mIaeX7ncVTXV+oUnck/F3olR/bU=
X-Received: by 2002:aa7:d4d5:0:b0:51d:3747:f88a with SMTP id
 t21-20020aa7d4d5000000b0051d3747f88amr8767995edr.31.1687959098117; Wed, 28
 Jun 2023 06:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <1687955688-20809-4-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1687955688-20809-4-git-send-email-quic_mojha@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Jun 2023 16:31:01 +0300
Message-ID: <CAHp75VeWEkEnBLgkk_xi633WP9hTegi3W-zh2nRim6JRz4V0mg@mail.gmail.com>
Subject: Re: [PATCH v4 03/21] soc: qcom: Add qcom_minidump_smem module
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 3:35=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
> Add qcom_minidump_smem module in a preparation to remove smem
> based minidump specific code from driver/remoteproc/qcom_common.c
> and provide needed exported API, this abstract minidump specific
> data layout from qualcomm's remoteproc driver.

...

> +#include <linux/kernel.h>

Why?

Missing headers:
err.h
export.h
string.h
types.h

byteorder/generic.h

> +#include <linux/module.h>
> +#include <linux/io.h>

Can you have them ordered?

...

> + * Return: On success, it returns iomapped base segment address, otherwi=
se NULL on error.

IO mapped (or MMIO?)

...

> +       return ioremap((unsigned long)le64_to_cpu(subsystem->regions_base=
ptr),

Why casting?

> +                       *seg_cnt * sizeof(struct minidump_region));

Something from overflow.h?

...

> +       /* If it is not valid region, skip it */

if region is not valid, skip it

...

> +#ifndef _QCOM_MINIDUMP_H_
> +#define _QCOM_MINIDUMP_H_

This header uses EINVAL, IS_ENABLED() and (to some extent) dma_addr_t.
So do you need respective headers to be included?

> +#endif /* _QCOM_MINIDUMP_H_ */

--=20
With Best Regards,
Andy Shevchenko
