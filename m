Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E826869D9E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjBUD51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjBUD5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:57:25 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9DD21942
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:57:18 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id w126so1734026vkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=abwOXxZAy2IWA1v+hcnlmlYBnF3pC1N5e091p0+kqCY=;
        b=EYsbi0WbjzmeajfB7FkE1Sjn42SiG07kszNQeO4bmzmFEM3nEblatl6GYqTtXZrNeM
         bGN+diyzDKyYVX7EBpeM8lWiVi+dOB1tlZgN6uuGW5FwTN8nabv/nGbnH9xBGZxzq3Lv
         H7hOty45Ro/kRV081gCkzdrR+rBqxUA+gBDiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abwOXxZAy2IWA1v+hcnlmlYBnF3pC1N5e091p0+kqCY=;
        b=dQRE916q985C9wsNwh6VhSgfyq7E9M7P7RwsnwKHAw+jCm0KllA7ftEyc37WQMEDKK
         0HDD2Zd9RM2f6Qo6c8/q+h8tIjJ/Ror6YAWYPxtTCtidcu1TdClahgPlRScCZtFIhQ7S
         xtWl1jUjl9xGsVDni9xHJV6K4Sh6i9ImsEf2xGKdv0vi0xt5tZh5hfH+dBoDO03NC9QF
         2p9NRVknUA27jfj4ZutPwcVHPq65jjdSIyvhjOlIQ8Zvl60N/q1UBxChaMBUTtdiD5C+
         OwZhTgl71XuGrDDnzqWXfm1/xHRgEIQpw9zvndGXh5ebkaNUJlFl1NHEy+9CidkVPWUu
         WKnw==
X-Gm-Message-State: AO0yUKXMhKWEyt/BqcA+w6V3/BRj93tROReBse0kFznXnUQYzsou/IJn
        syEm1/gVRceL7AOLdyMqbFYYZfi9HKKOgnhVRkd5mg==
X-Google-Smtp-Source: AK7set85+8uGYvX/31NEkS0PijJj9uGf3ECBO7SgPA+DVMmlvxh5qtMlrAAK6g4OzKVTncAREBChRQihS9f3vpZC++0=
X-Received: by 2002:a1f:a3c8:0:b0:40b:9:82fd with SMTP id m191-20020a1fa3c8000000b0040b000982fdmr814221vke.18.1676951837787;
 Mon, 20 Feb 2023 19:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-52-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-52-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:57:06 +0800
Message-ID: <CAGXv+5HjKuNLYtieHO4T1MXN7Uovz4oALqcP1DVAowY=h2c0Lg@mail.gmail.com>
Subject: Re: [PATCH v3 51/55] clk: mediatek: mt8135: Properly use
 CLK_IS_CRITICAL flag
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
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Instead of calling clk_prepare_enable() for clocks that shall stay
> enabled, use the CLK_IS_CRITICAL flag, which purpose is exactly that.
>
> Fixes: a8aede794843 ("clk: mediatek: Add basic clocks for Mediatek MT8135.")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
