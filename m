Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F342A6C056D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCSVXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCSVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:23:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43B61ACC6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:23:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5418c2b8ef2so193034457b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679260983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3t4BVzD4fCwm/HjgI/nJs48qtp+oLOMusPFc01YzK68=;
        b=TxS+vK7pTMznDKj3CJxwaBZob2zK5huyzq98Gm/aC23LIAYJVq4l0ODUnNxKq8qzf3
         gFdMAjRw2OSyleyxzwHStOUTjzeh7wc7zyPgrtiNbdQvTfGr2dK3OAvT0Dh1+4P/SOJ5
         jeG1LFFvp4qoZs6amOAQv97eMYIOE7mYbGaY+etY5XYYe2kaIXE5e2l2TB1O3xXcM+Rr
         T91vs7EzG2ZPXm+7O7OOq8xIgs2kRBsWHUR+TOrDAWtJ0vxSmMXIT4bEEcHZ9q2sTn2G
         C5QBBEgQbHVJB5mZZwbdCHYNMxyFs1n2LShnmUgIOfdtRNFaEG8K6i5VooLslhfSPWr9
         DJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679260983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3t4BVzD4fCwm/HjgI/nJs48qtp+oLOMusPFc01YzK68=;
        b=Q/JBHmSi56eT8fFIODNE05bZYw8kSGbc7eSDLNNxeouI/dMKOwkinynYzmWoyjJuHk
         4BLEGeCcPJZYsY/7mP2cCWTwVvJc8S9PG22iXWuvR0ABq2ue57HjK0pl7dp+dFqymm47
         UViEibGrQXGSUIFtdBIcMfFKp56WPUgv/1fdNuVsBJQa8iFoHRut+uQ8+rYuGARZ3lWm
         oxoxpGJtmszHFp6bW6vDNHIAQQ0RZfxJIvckDAaSArA4reTA/inGhH1YtYlVLnvM97k/
         VrIP0AmCJVKZ6zJUfz7O46JsLus0JpF+tyN3S2OWf/aA+uEgc4ePPjMKFhEbkEE2UdUW
         4CHw==
X-Gm-Message-State: AO0yUKULzaLbg8o22A/nrRgc2WpAik7Q5uIsFfhhblg4xBGUeLg1bmz7
        qnr9bDraF28UUdh1FwfmgrqwN155FNXQtUogS4UnSw==
X-Google-Smtp-Source: AK7set+pmdlQsPUnH5++AclP/7dWprIh5EcdFa4L0ZPpOIjc6rfvFJoBLHUbrWdYf9tHxqedfQz612iLyZqa4UO6nQU=
X-Received: by 2002:a81:af46:0:b0:541:693f:cdd1 with SMTP id
 x6-20020a81af46000000b00541693fcdd1mr8699456ywj.9.1679260983115; Sun, 19 Mar
 2023 14:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1679259085.git.william.gray@linaro.org>
In-Reply-To: <cover.1679259085.git.william.gray@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Mar 2023 22:22:52 +0100
Message-ID: <CACRpkdYFSu3DAY4+EeoRk4cTkypgWg1C=UgforDO7mT96f0GDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] regmap-irq: Drop map from handle_mask_sync() parameters
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 10:02=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:

> Changes in v2:
>  - Pull out 104-dio-48e refactor to a precursor patch
>
> Remove the map parameter from the struct regmap_irq_chip callback
> handle_mask_sync() because it can be passed via the irq_drv_data
> parameter instead. The gpio-104-dio-48e driver is the only consumer of
> this callback and is thus updated accordingly.

Looks reasonable:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
