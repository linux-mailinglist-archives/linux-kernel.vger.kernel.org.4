Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCA161F675
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiKGOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiKGOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:44:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED12959C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:44:17 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so30750376ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c2CoTYYkSpK+sQj3p0R6Cfi101yt3YpQVds/7qZK0/E=;
        b=BC4wd+UVzNToFcbV2iVIZ9rGyRHo5M8PVDarYeufP55XrNjp8E1FCWyEVKl5CwoaY0
         lR+2atWzyXzMT4A3XPzWTFWDeHC3PbLvpogP9fta5cjFa5fbBaxIkMw1HGIi4P3d4I0c
         cza+mPzRFrTO1Rt27xiHBYqwdjRL5KfCWBTXsVRvLCXieB2HMwTp2CgraQPvvydqRQZd
         60i1wgkl4fnrTjNLVC5yiPE7Is22jItfeRhURFn6lCwPcOQxM0jk5dc+VfQ/tBUOZCmQ
         64TuCMlV4E8PCMTg22qLzhIbbSAXqpPkwC5iRK3DKGCbpSfEXTrajEXqk0yF3bDgFQ4f
         mM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c2CoTYYkSpK+sQj3p0R6Cfi101yt3YpQVds/7qZK0/E=;
        b=tiwjPRMGgjDI1aGRlIMuFmC/kc+QY58PoFde4rln7jjBkpgvv8ka6GvPnAMsthmZg6
         0kbDoM3U9QpAykyZN75dkAWa6MK2vugYIZg8kIygBEcL0A1aGflTuCdF/SFNuNNSmP51
         nlcOIgoR4wtLTGZV7b9zNukLnNwPgycy84HQdDsaZb08qIOTSQXoIT2TO6yrOPynhNNL
         lC/2RaV90hbrPXg3a27pZH+fXGQ0AApFV7vpHMBW/eIZTAqHNrs9Rd64OFL6Gb5ga/84
         7S5c0mu1G3xQOQTDx3VqviRAXQPyHT7rumQ5KE0D/HrZkJ73SoI8wcupr+A6D+LGaWT/
         qEug==
X-Gm-Message-State: ACrzQf2Ysh4tDtgw2pVFu6BO1lWMc6jHAF9foPsfkKiYNMr0w/sRQBb7
        1hgR435ST8L8a3KV68b+CgDBvXW+1+71EXZZHCjwPA==
X-Google-Smtp-Source: AMsMyM66VeTBEt4Ejj9PcxdBT6i+5GxO0WwEHmtm+cP2hP7E419Giec+LXEu+KXWIgYVPJ+vs8/wows07Wwnsj6FP4g=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr16653409ejc.690.1667832256100; Mon, 07
 Nov 2022 06:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20221021084708.1109986-1-bchihi@baylibre.com>
In-Reply-To: <20221021084708.1109986-1-bchihi@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Nov 2022 15:44:05 +0100
Message-ID: <CACRpkdYdmG5cFenESg36BwVpJ7FDJunPH1Z8dJjHwmu+NW-etA@mail.gmail.com>
Subject: Re: [v2, 0/2] Fix broken SET/CLR mode of a certain number of pins for
 MediaTek MT8385 SoC
To:     bchihi@baylibre.com
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:47 AM <bchihi@baylibre.com> wrote:

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

Patches applied, no need to resend for small issues.

Sorry for taking so long, I wanted some feedback from the Mediatek
maintainers but haven't heard anything, so I just applied them.

Yours,
Linus Walleij
