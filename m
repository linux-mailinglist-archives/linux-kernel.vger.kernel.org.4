Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B217325A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240711AbjFPDI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241688AbjFPDIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:08:52 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF772D59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:08:50 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-4714ec7e30eso1809e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686884929; x=1689476929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssboqFuJsuzuCpdbRQ+L+w3xrtVqrpdJ2PznGonY4y4=;
        b=d2AvKjRRoiVHcqXfjX+XcACUNe5ZTaFoeBkqwyRBv+zr4ioeULu8utJj12aZsFcCEL
         Cb9D3qb0Q4RI4jqJ14EKgvYwpb0KjzXcAOx3ljqUU464Xvmica0Eak6cu9KXAeEWqC/m
         gLmvtREDwQAfwajnK4PuGDPJ600BuT40OnBy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686884929; x=1689476929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssboqFuJsuzuCpdbRQ+L+w3xrtVqrpdJ2PznGonY4y4=;
        b=fh3MGoFONyRcxmbDcA0u+Ll6g06/J1BqPWorsbVx8D4nA6OdAVOSQ0AAXYv+BI5kS1
         Fp0latitTul98QVfEifIcsKPKx76iQ+sDEBtCacGQwIAI69zH061BHdtGWQpjnCbp2kq
         Zj++RVWovXimoJ8LCSaQqlXqNrwkHRvSAqlV+6OblccB8xZeAn7NxX+m+M+H9pUcTpjP
         TLAdrSe7+BmR2zCd+crUo9voFhwEQLx4mY+EPn6G8V5Nkhnv09fuqbNiykL7L8bpiLVf
         codm9O+cCzVWeNrStT/20HYQV6pWn882hSSqL1BracdRF6+QurBX/y4zIHDQjy9rtTbi
         eHcQ==
X-Gm-Message-State: AC+VfDw64VgSIbPRoMYuXm0uPrdwfmB0IEM7QsnMZKwmG0C40V1mlwtz
        RKUsrfXmMtzWP0eVg5ojq6k6s7Kb2UxHW9ROW9o/KA==
X-Google-Smtp-Source: ACHHUZ7jff06HWZ1eakTPLpb+hwvGHtO2juAwSdDJVfKa0iM8R/TGrdtDP76FqlJtPr0NQcCcS/yLA4TFAbZ8vS6S8E=
X-Received: by 2002:a1f:4308:0:b0:44f:e6ff:f30e with SMTP id
 q8-20020a1f4308000000b0044fe6fff30emr1067981vka.10.1686884929582; Thu, 15 Jun
 2023 20:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com> <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 16 Jun 2023 11:08:38 +0800
Message-ID: <CAGXv+5GOum2QKhEPn+Oj+QZ1+Ts2OhRyjmJPOfQHifUjW3NXYQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not
 released issue
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 8:21=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In case of error after of_ioremap() the resource must be released:
> call iounmap() where appropriate to fix that.
>
> Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver a=
nd common probe")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
