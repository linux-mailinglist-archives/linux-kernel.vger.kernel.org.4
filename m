Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7125660BEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJXXos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJXXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:44:25 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201822AE6E3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:02:55 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id s28so9214003vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQO3SP/T7mx2gTBdrb26vhHeh//fHC6TncgJjNKUlYk=;
        b=Z2jdLbMLpmR99cxAypgqWbtshKYj35Ebkj3fTaxTstePFu0H4CEsORE/+N7wFrwEmz
         S/V+Csf+m+CzpG6iUJdChy/UPbuZNn5bkt0lnfgo9MjI+y6nCdCgZI5ZXuAWjBjy2q9L
         C/NwSuG10/nz1AaJX3BLGjYT8/toKDF0M0nco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQO3SP/T7mx2gTBdrb26vhHeh//fHC6TncgJjNKUlYk=;
        b=it9HxtiC+dTHiio9wKl8tpX8G6X5XuoYRDR8jKmBCa/ydE5B26jNJQnq+NX/dyWvJF
         ui/FX3gRNPa2vQMfKS3iEVtYMdSyu906Gqlolhhzz//gmBQ6t7dYu5DXGv+CnXqFOWfN
         OXjb1y7rrdxyjTxu8GJXeZlbLH4z0vUx07WIeaYhsy1zQUsp1G/nZoSKj0ZaSdr2tO6W
         +eHEDuLqb8kLS5pQA6x1hgvABxlCzH00PD1RZD7knAJfStnykhKGKYByVhC3rf2AQfIe
         OdEBz6nGy4MON8/M27QsCUTqvYWVAI/NRuW13LX2+KmqurlLf7MXJwxS5XCq2WMBN4T8
         yDPQ==
X-Gm-Message-State: ACrzQf3tr8KQHFmWPq/dqvRvwuHDZ9u+8zDLJ8PJ4/q73xdvci4NoFas
        r8qMuJl6aNnp4rW0QAAnkyoVqJ7lPjYAP7sXXw+KYA==
X-Google-Smtp-Source: AMsMyM4Nc2SEf14KxCoAjSdAd9I9wEQsYdGBrpODBvx0PQyqe810u6vS6uHm6Jb+ldd50UX+leY9mLoXV+Dk3qKhG48=
X-Received: by 2002:a67:f684:0:b0:392:ac17:f9b0 with SMTP id
 n4-20020a67f684000000b00392ac17f9b0mr20548005vso.85.1666648974339; Mon, 24
 Oct 2022 15:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com> <20221024102307.33722-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024102307.33722-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 24 Oct 2022 15:02:37 -0700
Message-ID: <CAGXv+5HgWwjNz73wdvQv-9qTiQCvbmE9kMp6ts+DccdBUQZ9HQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] clk: mediatek: mt8183: Compress top_divs array entries
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
> There's no need to split each FACTOR entry in two lines, as each of
> them does fit in one line just fine.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Git word-diff + ignore whitespace showed no code changes, so

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
