Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919E36BA259
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjCNWTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjCNWS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:18:58 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7709124CBA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:18:02 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5416b0ab0ecso203297307b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678832221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgQUA3Qjd0xDMQl85AKvmwvo3UzAj5eVYeuKrfB9jKY=;
        b=P3QbAFY4C3wMQOLu9Xc9iJsc78YVBPbhzqz6wSLJDVm/uQxMbSLzUb9TxmZ3V63b28
         wZvLjSX6krn2yLuNJKHw5WjmoNOiULtf/MHn8KYABjQI0qocn1BlBZ/mttOKcw/tePSj
         UsRxsw8+5mi9y3Jf4LwhivKfKCMNBxH5Nj0qZDponTNiew0x8ci8CnuAz99jj1nnJiSS
         VMHdzA6N9RETW9gmiGTU7Uzs8RyneKJwGgl/89nWlCmZKrxULNo3bKzupwINUryAyMtE
         dzyFh3Nrr62ryyIqs8IaBkZ5WCuyFNMWaVH1/v1gLEe7farhgnH3PLX9WvcAoGLnEUmm
         AkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678832221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgQUA3Qjd0xDMQl85AKvmwvo3UzAj5eVYeuKrfB9jKY=;
        b=QP0gkegs51CItoPIxFaVUoW3HLfGYDqYBuM7Rw2P8+OFMsZMVdI9bs+CGPYno0mENc
         V/bvbwMr8vQUdvVYKKkl6gbxsqDe89aWSSF7dRHBH/4Kjnl1wUeWgxzKrVn5phUnJ9u2
         S567MAOxNL3nrTmCCP7DjUie/LlG8WA1C/zc19HUnP/szRvKVWrOJ/FJVVHgWIEoPiD6
         cO2k/I/r+psCQllk2QJvG4kW+XE+XxYPsmfzzDIy7QLG/1F4xlzIeqodPL+tvFlRzNc1
         VnnS/h3dOQRjT7L9vgBW6qA2SHVgnqDoFfmVLdKiVLG5zCK+cqe0A0H5mAwIphMHVovu
         0NgQ==
X-Gm-Message-State: AO0yUKUuk39StQGxmReWcjKDo570co45I0XQTMHz1rHqYm8qY49yaut9
        +cqx3AGDWrswWw1KBntRubajK7hFLats4MFEBerWJA==
X-Google-Smtp-Source: AK7set/TEJJr4f9uFhqo+VduBSSU76xwR/4cMKOIovtYwfVxV0OUOCvYsbszh0moZBR1fIJW7w/59OW0L+x+zwoLfnM=
X-Received: by 2002:a81:ac67:0:b0:541:753d:32f9 with SMTP id
 z39-20020a81ac67000000b00541753d32f9mr8154484ywj.9.1678832220514; Tue, 14 Mar
 2023 15:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
In-Reply-To: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Mar 2023 23:16:49 +0100
Message-ID: <CACRpkdZ=1N2RF1ct3AXOy1+k1Jmjeo6OKxEUZv4Xux-smOLhmg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in pm8xxx_xoadc_parse_channel()
To:     Kasumov Ruslan <xhxgldhlpfy@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 8:37=E2=80=AFPM Kasumov Ruslan <xhxgldhlpfy@gmail.c=
om> wrote:

> The left side of the loop condition never becomes false.
> hwchan cannot be NULL, because it points to elements of the
> hw_channels array that takes one of 4 predefined values:
> pm8018_xoadc_channels, pm8038_xoadc_channels,
> pm8058_xoadc_channels, pm8921_xoadc_channels.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 63c3ecd946d4 ("iio: adc: add a driver for Qualcomm PM8xxx HK/XOADC=
")
> Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
