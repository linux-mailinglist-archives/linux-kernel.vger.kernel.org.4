Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F786DA0B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbjDFTJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239838AbjDFTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:09:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B7A6EB8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:09:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sg7so3795922ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1680808150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU3XAV3DVNH8txjSiCYm9/fmGAbKNyWHO/luoOp01rU=;
        b=VGb8KEA4nHDrklCnMumqH8GfP6Uj+m0ccKqPoCTtr14M7jaYwOPF0XxvUY50FCudZm
         VYWf0wFvGIM9vEbWyrRcRmogYvvh8KfbyDKwbKAPRkqhxxi8uE+yjDxhprqk3kEdpst/
         CdGti3EX7CTdyqYUZGvW6KNq9hpYOrkcP9jXC2jJLIPMkQfZNKp4H4Z9RLyYJCxPqjiI
         Ls8zr+VEciYSBDJgA3MZEVPiYbkRaZQBaYcFy4sPSC9JO7YYcNjngcU+56ppoZraTFh9
         Na3hw+ZyxgAkZDijI86J39mGkzHPs67ZXOMtXk3LBGimVxFA5SrBQ+QRBfMtovJIGvKb
         i8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680808150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SU3XAV3DVNH8txjSiCYm9/fmGAbKNyWHO/luoOp01rU=;
        b=nutq+PuhY6czoR0dqFTAHqLmY+b/lLhwJ6T/LFRYyk25tQbcn6RNEc5rNoNMiX3P1T
         ColSwF9mdNGqAnuIVrmq8DwdaMn4XWclgdQFmEsa6wGuFFkL5D1GQ4L5poNqxck4El7f
         Ph0oTHsFEBeTZN8dl9bv3ThW9008e0tPGlVxoxhkc09RAb9AL1DKZzrOPO5xrpYmqA1j
         DB+rZddrR7IaH4pwrRlzyfO2WyQQCYxiBh8xpxjvQLmTBBn4MWjdcAbK0KFn4PZfTTyU
         3LLVG1YteJyGFJgTorxve71W6wBhSJXM633KBVnrdsPwHlB1SnsXbs4W5FIFk9bIFJnq
         jyxg==
X-Gm-Message-State: AAQBX9fxZx7MGLw7LUcr/gReg9i5zaqljW/0hsisDV5+0cni7Q/YUKkD
        uUw0aNojahEKqGz/55oK1Dwa7axmzNjo+Ps28zg=
X-Google-Smtp-Source: AKy350Yz7DsuaCxrsXxeoNzNm7vn5FsTz43bcBPKQl5iN/XiXCepnwMkdM/LwTmZpWsVDRhaONPOnwDf//O7yD3qy2Y=
X-Received: by 2002:a17:907:8c0b:b0:92f:41e4:e48b with SMTP id
 ta11-20020a1709078c0b00b0092f41e4e48bmr3602630ejc.6.1680808149498; Thu, 06
 Apr 2023 12:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <trinity-3aa9784a-714a-47cd-866b-3ae77ecca0fb-1680773596235@3c-app-gmx-bap56>
In-Reply-To: <trinity-3aa9784a-714a-47cd-866b-3ae77ecca0fb-1680773596235@3c-app-gmx-bap56>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Apr 2023 21:08:58 +0200
Message-ID: <CAFBinCAsRoc_-zG52Q284Br8FpL9OSw93in-DRWTGaP4VZWWjQ@mail.gmail.com>
Subject: Re: [PATCH] correct uart_B and uart_C clock references for meson8b
To:     hfdevel@gmx.net
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

excellent catch - thanks for finding and fixing this!

On Thu, Apr 6, 2023 at 11:33=E2=80=AFAM <hfdevel@gmx.net> wrote:
>
> commit b3b6a88d2347d2ec9075603920e616836cb46750
> Author: Hans-Frieder Vogt <hfdevel@gmx.net>
> Date:   Thu Apr 6 10:21:49 2023 +0200
>
>     [PATCH] correct uart_B and uart_C clock references for meson8b
>
> with the current device tree for meson8b, uarts B (e.g. available on pins=
 8/10 on Odroid-C1) and C (pins 3/5 on Odroid-C1) do not work, because they=
 are relying on incorrect clocks.
> This trivial patch changes the references of pclk to the correct CLKID, w=
hich allows to use the two uarts.

When you're re-sending this with fixed subject line then please also
add the following line above your Signed-off by:
Fixes: 3375aa77135f ("ARM: dts: meson8b: Fix the UART device-tree
schema validation")


Best regards,
Martin
