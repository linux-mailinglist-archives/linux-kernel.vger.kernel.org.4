Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB03613B78
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiJaQkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiJaQkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:40:06 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0842BC3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:40:06 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id g129so11163412pgc.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5iO8KHmbbjpD0edAAD18XYUlbSGy4UU+ld7nxMCDFQ=;
        b=f6sBbSTtkybqzueieI+VtnyYAa3mfvhUAoAPAXbX6KTa0VuF2Gj4VLvdcCI3yn+bjV
         vygemIjVW+edZoc6IXpqrBLZv/cEN5vC1goTpcv48tP7rQXTiFwSXUBPlgvmHehDKV1z
         wCJxVVYP5lYSA/iEdBm8RGzEWT2LLaxdy2Vv+D4kPE5dng7z0YX4fI5Grc0bhn0cyIoh
         wEJjH5Dh3Dp6UUp7J4iX9NWbtkP7aY9k67y9iaS3QWetm1eF5m1kRWk31G41eX9A55PM
         tffvF1cYYRgQpKGK6KLaPa6ZHQIs/vhTK7rVs6+Ps8cJrzLfto6b2vPi3kEJFNh1UWdK
         l8dA==
X-Gm-Message-State: ACrzQf2WJKdZ0yZshJ8miYR64EwfnAQXOykEiT4GuVsPay0VRSlho9/A
        QGKTaZrP/yCCrdsCCxQX9B1OAQ==
X-Google-Smtp-Source: AMsMyM4wbIhY06SY2nUR74pUKGuIl5gTFPk+xpQFABfA9XZzwdh1qCxm1jXpjY9c4HML23XPnl7EdQ==
X-Received: by 2002:a63:c146:0:b0:46f:c9e8:777d with SMTP id p6-20020a63c146000000b0046fc9e8777dmr4645744pgi.459.1667234405901;
        Mon, 31 Oct 2022 09:40:05 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id i63-20020a625442000000b0056be2a3c87csm4835445pfb.154.2022.10.31.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 09:40:05 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     bchihi@baylibre.com, sean.wang@kernel.org,
        linus.walleij@linaro.org, matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [v2, 0/2] Fix broken SET/CLR mode of a certain number of pins
 for MediaTek MT8385 SoC
In-Reply-To: <20221021084708.1109986-1-bchihi@baylibre.com>
References: <20221021084708.1109986-1-bchihi@baylibre.com>
Date:   Mon, 31 Oct 2022 09:40:04 -0700
Message-ID: <7h5yg02bh7.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balsam,


bchihi@baylibre.com writes:

> From: Balsam CHIHI <bchihi@baylibre.com>
>
> On MT8365, the SET/CLR of the mode is broken and some pins won't set or clear the modes correctly.
> To fix this issue, we add a specific callback mt8365_set_clr_mode() for this specific SoC.
> This callback uses the main R/W register to read/update/write the modes instead of using the SET/CLR register.
>
> This is the original patch series proposed by Fabien Parent <fparent@baylibre.com>.
> "https://lore.kernel.org/linux-arm-kernel/20220530123425.689459-1-fparent@baylibre.com/"
>
> Changelog:
> Changes in v2 :
>         - Rebase on top of 6.1.0-rc1-next-20221020
>         - Delete MTK_PINCTRL_MODE_SET_CLR_BROKEN quirk
>         - Add mt8365_set_clr_mode() callback

nit: subject of cover letter should also include "pinctrl: mediatek:"
prefix.  Also note that you're missing the word "PATCH" in all of the
subjects.

Tip: If you use `git format-patch`, you can just pass `-v2` on the
cmdline and it will create the prefixes for you automatically.

Kevin
