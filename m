Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5C60BF18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJXXz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiJXXyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:54:51 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEEC303F06
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:11:37 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o5so7724185vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wgYeHWDY557XtHMLRtUX7OPU/EboVT6jtNmcPBSKxk=;
        b=ZajeYhpsV5Zdez+eRW07mbQARwemleDED0REBwglUw+M+wDur25dSDaISM+S6b3Es6
         oup67PnJPBPwupR2R5rvogQnsFM1bfaz433n7LttMdI+qoMqLCAW0lUl/52BHps/aNW/
         4s6um2wnBIb43aYtg8TtVqliJXipK3/drfa/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wgYeHWDY557XtHMLRtUX7OPU/EboVT6jtNmcPBSKxk=;
        b=4rRGW1ZoeOCODQGZZ0lqW7cYHf7WmSGE/qs1VxALvnCl4AWT1TKdcSM4ElabTUxVDw
         +OEpNrKF01GwYJV2631OhOQHCGoAzzVA3KqYn0xYuykCw81ViC8/+hyAv3Uji0obAEDb
         oQQLqojlmAZJw4Eelp6QyMeE1nWJ9O0NdnUA7S7jC60hl5QMQIireOWojlwU2Ef80Y9r
         CE4lVzga53dmHOAAy1w36M/uelCoNWk4KLJjQKsR6P2LMCa3vx4xi7/6IV9Ji89T0HZt
         ssWGWTh2cZsBW32cy5jOlmfE2i42HD8zdoc0G63sEoRZftjKWz1j5XTxFYOhkuqYRWOf
         qG9A==
X-Gm-Message-State: ACrzQf3vCvU1OQzsBiA8D3F4Du0XwNPOzM4nVzB0BPLXkhU6mkbhDYbb
        8wPHrNUEHgrJZXkpKUcodrIjnXMdKNbDhWty+cS4gTAdt1t6Ug==
X-Google-Smtp-Source: AMsMyM4mB7pDUnJT5RpxnXEdEdWK0HwNgbfB+RNRZIgkDSL7pmpqSenH7TsBHZDWAklXfskjjMRaoRopr8Q8KHKkp7M=
X-Received: by 2002:a05:6102:38c9:b0:3a9:7206:b99e with SMTP id
 k9-20020a05610238c900b003a97206b99emr20722488vst.65.1666649482560; Mon, 24
 Oct 2022 15:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:11:11 -0700
Message-ID: <CAGXv+5HHAD_grwNXk-gVorY=p6DidHGqBgVHZhX5B2j5Vv-_Ew@mail.gmail.com>
Subject: Re: [PATCH 09/10] clk: mediatek: mt8186-mfg: Propagate rate changes
 to parent
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:23 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Propagate the rate changes to MFG_BG3D's parent on MT8186 to allow
> for proper GPU DVFS.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
