Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603A263BA25
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiK2HEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiK2HEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:04:02 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AF391DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:04:01 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y4so12540743plb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO/cDnZZW/RlYHuzoKyfVL5YxwkikYi3mPwl9HeEE7E=;
        b=oTlxBTjxb0OLs3LbtbLfBJy+5BE4R1aiDbHvx7Le4Ike9jM0Ec1TgEe8ZTAv3pACeV
         pc8VkakOjvc3fBYd/f0vQMP0EOWw3WZNUaok6ZRd2zuQL4NAor8HNgA/jeKfxWfO9Cxf
         P25OeRVnt7yFQbez6xPQ07sIqlDzOaQ+pGTvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO/cDnZZW/RlYHuzoKyfVL5YxwkikYi3mPwl9HeEE7E=;
        b=Qn/sYOZbV0LESxjB95CZsE7DQUbF4QYdKMARPGSCJEuN6UwCUzWNipMKocO9eprurb
         0yfCansk+ECVIk7Il9sxU4+Gaddq29YdnmXhoRTg++LcA7bh4SuRN6dwpEdJLBkPgoUD
         Mw3aEn4MMn+uLUZOnSWAsZ6fpT+Yzri63W7l2gdgaKWFLFaZMMe+z4B3pnYJOClCSOY3
         2NCUnO0O3RQqrdkZtROQtQ69VeIVfPRlpnLl4IUrtEeBh2cZ46cYDSooI+DdgyyPrWSC
         lxB2+RH2H4WowEYqCY0XICmWH1ffypHWCHV9Xuf/EBkxWzl7m06XozJIZ0xAFXESQPuJ
         2K2w==
X-Gm-Message-State: ANoB5pkfJTN/XhHBmCJIUV+c62qWtURRjnkVY+ewpqJzd/3L7HUzLfZH
        or6LHPo5UpDI4LNJJanZrF28Fg==
X-Google-Smtp-Source: AA0mqf5XVl2scp/GL8QqnK/jwLxKtG6rYycCaa648SfkyfYV/m7xzyJUi6ZoDwIhFKq1LLUDb7xy0w==
X-Received: by 2002:a17:902:f243:b0:189:8046:4335 with SMTP id j3-20020a170902f24300b0018980464335mr12291749plc.152.1669705440997;
        Mon, 28 Nov 2022 23:04:00 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ac4a:f96:259:b58a])
        by smtp.gmail.com with ESMTPSA id y69-20020a62ce48000000b0056d3b8f530csm9140261pfg.34.2022.11.28.23.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 23:04:00 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     sboyd@kernel.org, angelogioacchino.delregno@collabora.com
Cc:     mturquette@baylibre.com, yangyingliang@huawei.com,
        jose.exposito89@gmail.com, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, rex-bc.chen@mediatek.com,
        chun-jie.chen@mediatek.com, msp@baylibre.com,
        nfraprado@collabora.com, linux-arm-kernel@lists.infradead.org,
        miles.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 00/10] MTK: Undesired set_rate on main PLLs and GPU DVFS
Message-Id: <166970543840.607733.16874108898291986445.b4-ty@chromium.org>
Date:   Tue, 29 Nov 2022 15:03:58 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 12:22:57 +0200, AngeloGioacchino Del Regno wrote:
> There's no reason to declare CLK_SET_RATE_PARENT on main system PLL
> dividers, as any rate change on those (mainpll, syspll, univpll) will
> change clock rates on critical system peripherals and busses.
> 
> This change was performed only on SoCs that I could test... I'm sure
> that the same can (and should) be done on more MTK clock drivers for
> practically all MTK SoCs, but I don't feel confident in pushing things
> that I couldn't test, so that's done only for MT8173/83/86/92/95 and
> on MT6795.
> While at it, I've also added the much needed clock notifier treatment
> on MT8186 for GPU DVFS, like done on other clock drivers in the past.
> 
> [...]

Applied, thanks!

[01/10] clk: mediatek: clk-mtk: Allow specifying flags on mtk_fixed_factor clocks
        commit: 672c779e4cff5f4a103077e9b398f144c85db802
[02/10] clk: mediatek: mt8186-topckgen: Drop flags for main/univpll fixed factors
        commit: 295de9d0d063cc576c5c6322aeeda64d3579d9e5
[03/10] clk: mediatek: mt8183: Compress top_divs array entries
        commit: 23037ab63336a4a1d98645bf7ee76240ed20bc65
[04/10] clk: mediatek: mt8183: Drop flags for sys/univpll fixed factors
        commit: c01d64ca5166fa88d27c7c4a2a294dd10d20f780
[05/10] clk: mediatek: mt8173: Drop flags for main/sys/univpll fixed factors
        commit: f757c9e951b89c40db41592a22785b5a25c58224
[06/10] clk: mediatek: mt6795-topckgen: Drop flags for main/sys/univpll fixed factors
        commit: 0cf308ee3472019539582ee279b637beb34ad2ff
[07/10] clk: mediatek: mt8192: Drop flags for main/univpll fixed factors
        commit: b56603285f7e323591267bec9a9d6950e9bdb7cb
[08/10] clk: mediatek: mt8195-topckgen: Drop flags for main/univpll fixed factors
        commit: 327eeb6c240ab9293ab730789ea651fbc3fe6123
[09/10] clk: mediatek: mt8186-mfg: Propagate rate changes to parent
        commit: ecc639ddbe0d7bf1c66f6c69ee54ee005484d886
[10/10] clk: mediatek: mt8186-topckgen: Add GPU clock mux notifier
        commit: 3256ea4f6582d2cb9b63ad96451957c217a52582

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>
