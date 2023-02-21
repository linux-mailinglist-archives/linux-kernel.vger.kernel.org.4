Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB369D969
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjBUDnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjBUDm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:42:57 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDEC244A3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:42:05 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id b20so2728045vsu.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676950922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2wvNe81rytZk90715HG2PCFmsyrxc7m5FnCYoyAF2fY=;
        b=gSgc21gqnxo+9Vtja7nTND1/RIBvEEnMHnGSZgMoyHlmJBIoboHUVtAcSe6xCZwf2Q
         snyU3Wyrrr8mxSbEhmlhvXNkQMzTR26RdOV8pZ58igo6ABEvNDcRU7RsEwUgICrxM8lT
         fWm++o8S2Ar+lAbv8CKcLdK9FvBzghYCXeU6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676950922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wvNe81rytZk90715HG2PCFmsyrxc7m5FnCYoyAF2fY=;
        b=R4tHOXKUYbrxOBUQxexPm5YNzlcB/9d4wrmj8I/sG2CiFVnQnRtScNh2xitKvLqdAj
         V6rxfcd7L6cWA0SazBmCvzeEOmQx0mADdFB0q7h5gwa1QkCZGObuwMl+OLi9loXEH9y4
         tym33aXQhgOnDGh3LRc3FHbjIRSzp0mNGRlUuOvr2oz6s2R3sYVExdgx9up/6x1GbEgL
         zArA3EqRi2hWJORSkl73c30ZgMT0bjSJPkqB+K3I5ObS2TXBdg2a84RtKYeN6p0m2Quu
         uPvoTlHSPAWhMH+zFExRNhWvoiilcmNrBS2IdozLHxKXQRpIeyGgux0chyHQz22VcKWd
         YByg==
X-Gm-Message-State: AO0yUKVdgphoqXVY0XcDL95V1UL2KgU1KTYCtLPz5v/X48nJWg4gwiZI
        JB7NhOsV9Abs0v3+3Ol9M19/sNGmQoI2wpwUFZfrjA==
X-Google-Smtp-Source: AK7set9PgnBSccgq3Ct1gGwwBge0XfivA3QB+E6pPiBYxo7qYILxFZVZjtWeBwAiOZDIwlHlnxLPhZ0nRJ2hPyMS95U=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr829198vso.44.1676950922742; Mon, 20 Feb
 2023 19:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com> <20230220150111.77897-25-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220150111.77897-25-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 11:41:51 +0800
Message-ID: <CAGXv+5H7osyeENN1un9+isBxwM=bzniSg2teBf7Gubm37_NzmQ@mail.gmail.com>
Subject: Re: [PATCH v3 24/55] clk: mediatek: mt7622: Move apmixedsys clock
 driver to its own file
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:01 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating mt7622 clocks to the common simple
> probe mechanism, move apmixedsys clocks to a different file.
> While at it, use the builtin_platform_driver() macro for it.
>
> During the conversion, error handling was added to the apmixedsys
> probe function.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
