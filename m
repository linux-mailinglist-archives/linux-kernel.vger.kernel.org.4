Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD1F65E743
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjAEJE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjAEJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:03:47 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0050E79
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:03:33 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id x65so23958456vsb.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bq6fbrm89Wj505hes5KkebMmopf15cqL74ic5xUS4cE=;
        b=aPoc/z738CDp+KaBXVHqKE1NJZKoDra2i+6EHl9mUA3mxfsljgABCG68ysGZnNPiD8
         ycH86LyVMdaImb3lcVJBoy23vImWTnjOqVgv6yrVXbOBLEs+16ZtF6d4ejKLSE5dETlt
         CS423HZshmzYe4YKkxuw3y2g5Lu7dSiYSTVno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq6fbrm89Wj505hes5KkebMmopf15cqL74ic5xUS4cE=;
        b=CPACdtfER/PUc6EIhY4dNUJbWt4jjEUKxHZAhOtCHQVGQf2qHFrxCNUDVuYHhXpVtq
         46tpbUf1P7uYhv3/a/k6Mv8t3UOlO9aNOjvyDY5O3l8lbVbw3SKZXxcyC6vT8HsuWT9b
         v4JxK1W6Tw23Pqt7nMGHtJLmubvG+szG4OAiY25vyP3BUyldoAdlUcJpLhTZpBr+6IoN
         O6o7gMlj8wBpmUobMdEuFP+jYKTpNMHRDWhwnNjFrxOVSbl5coACEwgEir83kjHwyAPD
         9/6Q7wkRuUmzVSKkVF/4GCjehfaWOaBO4BL3SL8xLhXZJuGAl9HmnA4M8YYyNY3xJild
         /6wA==
X-Gm-Message-State: AFqh2kobQMsgE3fwqPjqGefM6EPvFBvXnhT1xWaN8LZfRSsOWphNUDe5
        Tdx396kIgdT+I+Ls7rf7XhPnpJJAX0DbpMLLoNZv6g==
X-Google-Smtp-Source: AMrXdXuwCTR2fGOnMCsRQriJ+OQnC29RZ3V9tgnKJfLzj3aPE/ztb1euD+ZmDTzJF3h82BlYIZgmzUbg8fFoBOfJikI=
X-Received: by 2002:a67:c514:0:b0:3ce:b8eb:717e with SMTP id
 e20-20020a67c514000000b003ceb8eb717emr491817vsk.26.1672909412991; Thu, 05 Jan
 2023 01:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20230104083110.736377-1-wenst@chromium.org>
In-Reply-To: <20230104083110.736377-1-wenst@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 5 Jan 2023 17:03:21 +0800
Message-ID: <CAGXv+5FSc4H5QtMTZP7jj+SjDcU2u024cPm9LEAdT3oUoBusNg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc/mtk_scp: Move clk ops outside send_lock
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 4:31 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Clocks are properly reference counted and do not need to be inside the
> lock range.
>
> Right now this triggers a false-positive lockdep warning on MT8192 based
> Chromebooks, through a combination of mtk-scp that has a cros-ec-rpmsg
> sub-device, the (actual) cros-ec I2C adapter registration, I2C client
> (not on cros-ec) probe doing i2c transfers and enabling clocks.
>
> This is a false positive because the cros-ec-rpmsg under mtk-scp does
> not have an I2C adapter, and also each I2C adapter and cros-ec instance
> have their own mutex.
>
> Move the clk operations outside of the send_lock range.

Well this managed to untangle the lockdep warning a bit, but it still
appears. I'll keep looking into it.
