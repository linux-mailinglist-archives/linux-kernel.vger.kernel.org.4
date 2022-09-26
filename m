Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A585E983B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 05:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiIZDWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 23:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbiIZDWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 23:22:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FFE2194
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:22:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id u24so7223495edb.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 20:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yQsxXFVnnycu0Ai4HAskpMNXUco0LHrZ9qALshiE0Kk=;
        b=TVddU5EuFj2t8KIz7T3zCcDHTC4WeulJBoHq9EOsixQxw9p+2NBuF8VMquNFeDbozy
         G0mxNI+BTMiiYOluXsqZBzifT5mNk4PwqWXe9qc/RUX++dzObFco3u6ohP87bJ2o7kt3
         tA7AC7/8JQ0rMS6oFMZfwH6xivu21fXZrzUxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yQsxXFVnnycu0Ai4HAskpMNXUco0LHrZ9qALshiE0Kk=;
        b=Qagetr2K/OtxSjege2TzDgDdsg3IktYJZEZry2axOsuRbrKvqdUf+vZ3SsHqPeM54R
         KM5bgTsFgI8CLo46moG18oEAj5bckyMoJx4dkPrLXw/ttrmWgdwZkwVqt+29eUx5hS6X
         LGB2J0p84W1ADmSS9NIOnLi7J1c9SAJi7SRsVUSNBem82HsyXQ97umPEGYSWFGeUWJ0P
         PoVufOpp5IY9L2lDuZvkwbHJfu+NtMXbPzFN8LGvIxoel3oAZFTphjjcqORFyQNBqcw2
         aI6D7mTYm9Ie1kREEGfPzT6IjWnW6OlBHfV5nruD0pg2kGjGjEqiUes3xPhyDPDyqQR/
         KFmA==
X-Gm-Message-State: ACrzQf0Ufu4rkpleUCx7u1GhvBhRnA4EzObPJepdZWMRVDPk2VWNEANY
        BXln/ky2wf958qwtLspzsW9CFc5IhInuYgIxyWafdg==
X-Google-Smtp-Source: AMsMyM4D/ZSyLsYSyu8xNz2kCJSqJ/H1GIkKLJy/AFRCNUaeLI2dpgccDtbydmm91X48YfUGORxcS3U01CQX45V/rng=
X-Received: by 2002:aa7:cc02:0:b0:453:b0f3:9927 with SMTP id
 q2-20020aa7cc02000000b00453b0f39927mr20858524edt.66.1664162524995; Sun, 25
 Sep 2022 20:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220915072458.18232-1-angelogioacchino.delregno@collabora.com> <20220915072458.18232-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915072458.18232-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 11:21:53 +0800
Message-ID: <CAGXv+5GwYEv2O70_3rjDmY=RHZ900x3RKSaFYqzb_nTumT+YoA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] clk: mediatek: clk-mt8192-mfg: Propagate rate
 changes to parent
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        nfraprado@collabora.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, drinkcat@chromium.org,
        weiyi.lu@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 3:25 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Following what was done on MT8183 and MT8195, also propagate the rate
> changes to MFG_BG3D's parent on MT8192 to allow for proper GPU DVFS.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
