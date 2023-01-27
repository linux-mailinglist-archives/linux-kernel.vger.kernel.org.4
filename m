Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5063B67E5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 13:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjA0Mof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 07:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjA0Mod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:44:33 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2277DAA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:44:32 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b1so5782494ybn.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 04:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+sg6+kg+mDO+1d3pUfJQmwVY1aeKMmZ9aezNjGPZVg=;
        b=zrdO2hqCxOQx5qZ2F+gxHPPjqRFCI3zBruy4pMLBUzrYej743IiJmiROmYmf5g2pos
         YSlhFHqssAQuIPPSn86I6l4ltZTnh9lt7MlOoB5/dlad3nxfUrBT7tojHWtAbNwyY0sI
         v3QpQr+R3VCtBy+hXIE83LyTM5BYclNnbtf1c/Z9rvdsvusxAFdVjzRpuTJuhL6Fo1s8
         HzLyV/Xvpz9Ir5sOFwd30LsW0zfgV/nvCY8Z5y7erq4BIkku6cH6JZEZf/qzfMXuS+cX
         kYlUBejwQjGpFiXDpLMvwr8D+p5Zw5ynsiANaqfqFQvZRbe02w7VGwA4hQhoRt2xq0eu
         bt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+sg6+kg+mDO+1d3pUfJQmwVY1aeKMmZ9aezNjGPZVg=;
        b=3sddV+iQ5BE0ud+oxoKPZ6JgAd9gIT/aWeedni8dRiNxvrvsQWZQapskBgeyq871pk
         G4xaqoLS5mVmJ5yQCA57H358xC8TYqaxzCezSFzX28hPA7hqI76xykATilz7iXGfo9aB
         qo5hG+uaQvII4BA8gv5FuB7j3wSfpGUCPEqAYzNyAxInLf+TBI3S2TbQ+jSNzwirbeA6
         F/avPo8N7AL9/Z0kDZOq3Jog7ylAVSwPSz/ou2rvwbHPuFqDsISmQ/BY7+J3c9r2w+UJ
         5251azPZVYIkM+ChEPag63DDlgguvNYWoErolCVv9TM4v42gTm/erLYzPTUNDedsTIPC
         ag1Q==
X-Gm-Message-State: AO0yUKUDtA6zfhTxfl4oC5Khcrdw/byasrdji+B0Vbaxk08h4B+57rYw
        zr/a6ZpNLwEpMjkNURs8iLiJ8GBl/0LqhQTmiWMP7Q==
X-Google-Smtp-Source: AK7set/4H1YBNoNr7lHd1Z5jEkZeZBRo4qW9byaYRflLio74663CD1kkkfdTsnvh7hsxsffNlDvb99V3Xrk54g1gzBM=
X-Received: by 2002:a25:d884:0:b0:80b:66c5:9fc5 with SMTP id
 p126-20020a25d884000000b0080b66c59fc5mr1741253ybg.210.1674823471630; Fri, 27
 Jan 2023 04:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20221118104332.943-1-korotkov.maxim.s@gmail.com>
In-Reply-To: <20221118104332.943-1-korotkov.maxim.s@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 13:44:20 +0100
Message-ID: <CACRpkdYwBNjGzODYqvz+oScsO3u=R0dXMkP4UfqmosDugPFWRA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: single: fix potential NULL dereference
To:     Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:43 AM Maxim Korotkov
<korotkov.maxim.s@gmail.com> wrote:

> Added checking of pointer "function" in pcs_set_mux().
> pinmux_generic_get_function() can return NULL and the pointer
> "function" was dereferenced without checking against NULL.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 571aec4df5b7 ("pinctrl: single: Use generic pinmux helpers for managing functions")
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
