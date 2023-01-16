Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA83266B57F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjAPCKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjAPCKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:10:20 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475F4EF5;
        Sun, 15 Jan 2023 18:10:19 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id k4so27702546vsc.4;
        Sun, 15 Jan 2023 18:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRTM5LfugtVbnK4pJAXLeBVsqWzRF0ELFyqowiKmfes=;
        b=DCoItcLNFC8vF3cziTczObT9NsG9iSE4h32SCYa/0/ibDnuFT3JQHq4kY4RO9JnSRo
         M3Zwf+JZP66OXDtQ2BIdyXbIzb21K5d+p3qc4NMwSG1WiO6/Qy5rgqHS+FIjUeoroAc/
         MlxjEd7it2+yaTkGYsEBouKrg4XCue4IE7P/td0QDm2VeqiLJ3ODWKKEHP5MY7Xfs/yQ
         jUz7cfS70jYtY0St87U06zDt4ltU/UFxYzO19jvw7fgkGbHMbjo0anRLyZYSWeqm8qvW
         peBdXxjyZI+gm4qkcPpuPKao7y1x5xuJP9sDYbs+J4ULqZ3L9pG8gEK+OZ/vPKD9WqP0
         jK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRTM5LfugtVbnK4pJAXLeBVsqWzRF0ELFyqowiKmfes=;
        b=PHEkwP+qL2qJkITNsf+mt0dtV6H9alR9fsEGR8J1sR31HiA2OrsUhxovBpZdSxxaUT
         RDkP3l4ZuzEn978nC4u/9n+fgZgvw9HO4yhM2X2QPdfYZ72f99V6eAsNJOU/xpi+h5w/
         U7JzKToxzjMTJgZFqwqM0gYj4r6IZ3E/zXpTjpUkKxe8SlqKb48v1M2DkzJNJXdu34Lt
         wJoiBJTmABYspdsj/VPbAiFJe1KPkjY0kyWIznohjmu+J4GuALhLFDf97FijzdXDvFqy
         j6T7Q42MWt9rtIJTaInEVD0Tzhei32mJJIj/3h9a8cWobxvjJaEie1IJyRD88e6dxui0
         pzlg==
X-Gm-Message-State: AFqh2kpUkZhQqUsw77csyuD+6PJt8qPEAs1Vx74KWv7nYhZoYitqRQ2J
        0ChLkGQEIxdsPm3IhwaYmkxJrkY9HFaKqArSi8EndGev
X-Google-Smtp-Source: AMrXdXuyk8L5jk9jy7v2wBte8HAIf0BI/iSKaNp6sUiS1YINDTzQ/wOBhZatkUbxfuL4Z7ttjb0eWLSHB6yvmIA7wp4=
X-Received: by 2002:a67:ae06:0:b0:3d1:d6e2:41c9 with SMTP id
 x6-20020a67ae06000000b003d1d6e241c9mr1318772vse.71.1673835018136; Sun, 15 Jan
 2023 18:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20230110014943.2196046-1-chunyan.zhang@unisoc.com>
In-Reply-To: <20230110014943.2196046-1-chunyan.zhang@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 16 Jan 2023 10:09:42 +0800
Message-ID: <CAAfSe-uNjzZFTpwRG4h=z=+r7SEmrU0iDU+Q2Wx+X4B91FJHpQ@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Convert Unisoc GPIO bindings to yaml and add
 support for UMS512
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Bartosz,

Would you please pick this patchset into your tree, if there are no
more comments?

Thanks,
Chunyan




On Tue, 10 Jan 2023 at 09:50, Chunyan Zhang <chunyan.zhang@unisoc.com> wrote:
>
> V4:
> - Rebased on v6.2-rc1;
>
> V3-resend:
> - Added Reviewed-by from Rob Herring.
>
> V3:
> - Removed a example from sprd,gpio-eic.yaml;
> - Added '|' at the beginning of description blocks;
> - Added Reviewed-by tags from Krzysztof Kozlowski and Linus Walleij.
>
> Changes on V2:
> * Addressed review comments:
> - Fixed typo;
> - Added description for 'reg' property and modified its maxItems;
> - Removed redundant examples;
> - Rephrased commit message.
>
> Chunyan Zhang (3):
>   dt-bindings: gpio: Convert Unisoc GPIO controller binding to yaml
>   dt-bindings: gpio: Convert Unisoc EIC controller binding to yaml
>   dt-bindings: gpio: Add compatible string for Unisoc UMS512
>
>  .../bindings/gpio/gpio-eic-sprd.txt           |  97 --------------
>  .../devicetree/bindings/gpio/gpio-sprd.txt    |  28 ----
>  .../bindings/gpio/sprd,gpio-eic.yaml          | 124 ++++++++++++++++++
>  .../devicetree/bindings/gpio/sprd,gpio.yaml   |  75 +++++++++++
>  4 files changed, 199 insertions(+), 125 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-eic-sprd.txt
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-sprd.txt
>  create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
>  create mode 100644 Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
>
> --
> 2.25.1
>
