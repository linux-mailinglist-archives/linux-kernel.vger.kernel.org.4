Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F36698E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBPIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBPIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:22:51 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A123C25
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:22:49 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id p14so1197540vsn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t4Hmavd74pc9hNKbMy0OT4KjV0TBYqpmbiZ39L4sh4g=;
        b=U6ZdpCafQotK8qbTTSdk+96qUzTw9xQpMg+ZhUkq4h9bs64Ym3JcCYJK3QPFAo9RZs
         1Qrg104hDRL/7TryGDwRy+efxYYuXEjALAxLKnNFCtIrMIOYRKrYh4YmBiL4DCtLh0sT
         p8Vod9IfZzH9eiSRRtG0yWXXbWm3zWi39Ugf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4Hmavd74pc9hNKbMy0OT4KjV0TBYqpmbiZ39L4sh4g=;
        b=BCdvBgDEdUekHC9bfbeUV8ZxB4t+4Wg8ekdbHtPkpuMud/qISRJXBn8xXKhbdqyHBC
         l9GLMSJruNXP0LST9GSCR3mvr1tqJcq/6S/a2iw2WWLUFxu8WkkN7gwNQXr187FpbgdO
         3cBdfwrl6bfSAaG+Mije5OaCdc27TWvI2N0t3n4d4Hwxcqos8MmGkRJwwPssIdEmg3rq
         hu9rFZ6ckap/oX3wYPRgIeHMFxSPRRi/aKlOhE9Ro+vMpTIaMLSJjjP4MoVxBv/gkiUG
         +qPPPP3Rcv6iKAigSzaVYvV6cnaraw3PTIwgqq6h64m0sFiaPe01rg2Q+mWPLS8hJ8sS
         iM3A==
X-Gm-Message-State: AO0yUKXMpBDO+lyB7VEubOl7Lf1eR5l5635YwtDCofT5qVayK3HMV56s
        oIIe3R8xpKsibVj3pToefnVihTkNU3I2pCJ85KrcRw==
X-Google-Smtp-Source: AK7set/NiPdqGO4lax1hRZGi4C5xRM7rX75lwKlIcLeNUE7rasZWoOGb5+OT1/zHR5BKwnytbaZ5kCNjsC8Vf+ml7tM=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr953233vso.60.1676535768772; Thu, 16 Feb
 2023 00:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-20-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-20-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 16:22:37 +0800
Message-ID: <CAGXv+5Ft-dmvedRvyjXJwv7Cx+j=GPH6_j1s2oJFwPKYc_Qz_A@mail.gmail.com>
Subject: Re: [PATCH v2 19/47] clk: mediatek: mt8183: Compress clocks arrays
 entries where possible
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Increase human readability and decrease number of lines by compressing
> the clock array entries where possible, to a maximum of ~95 columns.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Looks better. Thanks!

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
