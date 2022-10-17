Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2C600B92
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiJQJuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiJQJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:50:14 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C457929820
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:50:01 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id e22so4146590uar.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODsmbg7BkAQxQqFdr9mvdYHhSzuV8ymKABrXWhG3P/4=;
        b=NHNdLlZ6k0TfGJkws9Sv+KJR26eBvLaMd2f9LZ3OfpxmaiO7ThqL2Jssn4aqmQBQei
         9bT/OUH9ZlMXLMUtAqFb2xCm5EA5EJoy4u7nujATCTvH4gcp6Lji22oQO32xk2r9m0e0
         ahktLMcfqtk0jzDCuCnQA9I0TLUr+fsCskXx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODsmbg7BkAQxQqFdr9mvdYHhSzuV8ymKABrXWhG3P/4=;
        b=TfYUlCMA4FZdj+8XqmLfolBbcbg/9aTSPr8rVOy8B3IKnWklOnTgfLN2hsIxYRnESo
         Kk8ZoVqx3Huk047l0Dxqkg5+tyHUcenqaavJ+1TPvBDMa4kRomhpj9/DUWgiRezS3Yky
         qwYCY3uKbMYH0nMsBvhQsOAKOokscVP6vd9iRoh3KpYwBcd4w7jH+UTAl5oW8iNB0ug7
         rUUolrxm5RWDXZzcNVnSrZqbFKTLHUWs2bym4k78xQcABvZRr0ytYeR5gEGg4aRffze4
         ODxx/QoAr0rNz+kqK83WmJIdGHD5S34rtiX5D7gmKmyi+8gP5uE0jUxnz6wK8M8vGvwb
         mCZQ==
X-Gm-Message-State: ACrzQf002xpJpRPamnpjN2+o5YCJjtQmv+KGzltz9hY7lNMnw2s04GCv
        OqhmfehBaD0QHGePOIUnJXqpKfKTl1YvjLqLWAsFNw==
X-Google-Smtp-Source: AMsMyM6F3rJpTxDDVrEGahK/LEkym9dPWVfJuS8iQS9gvSIlZxufJp9v5EIVgFbOEkOvFbdsxxmNhoqULjOJlqhCpwE=
X-Received: by 2002:a9f:29a3:0:b0:3d6:4c6f:9d92 with SMTP id
 s32-20020a9f29a3000000b003d64c6f9d92mr3849868uas.43.1666000176425; Mon, 17
 Oct 2022 02:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221008164807.113590-1-linux@fw-web.de> <CACRpkdYNZGJaVN0eRZPmkmWr=it7xZtAPM=qV0EyQWUZgZ68hQ@mail.gmail.com>
In-Reply-To: <CACRpkdYNZGJaVN0eRZPmkmWr=it7xZtAPM=qV0EyQWUZgZ68hQ@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 17 Oct 2022 17:49:25 +0800
Message-ID: <CAGXv+5FNQmx4Mxm2fTkWBazX7B_LzGuTY3cQK5f_yO4cE5c8mA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: allow configuring uart rx/tx and
 rts/cts separately
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 5:42 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Oct 8, 2022 at 6:48 PM Frank Wunderlich <linux@fw-web.de> wrote:
>
> > From: Sam Shih <sam.shih@mediatek.com>
> >
> > Some mt7986 boards use uart rts/cts pins as gpio,
> > This patch allows to change rts/cts to gpio mode, but keep
> > rx/tx as UART function.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
>
> No response from maintainers for a week and patch makes sense
> so patch applied for next!

Could we add "mt7986" to the patch subject? Otherwise it could be taken
to be updating all the SoCs.

ChenYu

> Yours,
> Linus Walleij
>
