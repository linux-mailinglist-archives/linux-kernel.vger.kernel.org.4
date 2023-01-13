Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB9669B05
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjAMOxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAMOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:52:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CD7EC96
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:38:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d2so1138172wrp.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=2ejaSnB1iatZ6NYDeZgR8Ys8saXOivDL9OIRxuhbO4g=;
        b=1FED3wJOiUsiU/4XBOp+Iew/qsd5F05j1dL4ieFLIRSoAOucms+VIRY2TkWLYK1/Mo
         C000/abxcNXlJFgYoGeAnOw0EwHqZFJsXd/o7NxdpZiGFQ2D83/R2vP1Iwy/J7zyAQZO
         /Bz7mwDgzMDdXXTn2BoE2+7ZtHpBsoFWonZ+c4ujuSzkiwdZUeSCnzDtobGpxyGIryFs
         QdWiQUOxIby/1P9JP7YAGrjvzaqWTLxXSThxMGjV4e/u2y9bqo0FywWIdYhe7bRo3/+v
         lkkwmp/VNJumPVcTUnlF651Rqb6QGfB8vQlHVhlJYaWKl8KOqfJt5TMKaunqMKYKXYu1
         AGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ejaSnB1iatZ6NYDeZgR8Ys8saXOivDL9OIRxuhbO4g=;
        b=piGE/iSZrfxZIFDlwC2Nk+XODSSbBe4FL+v8c/4xzULOCtCJmfwL+wdQGaQ8vCqvOm
         XC0VTLjCvNFeWMLQnnlWEAVu13vMSB07WqdzaPA/jf9ZVPPtOcY12eX8IymCfXLYOmt0
         fqEzylpivulO/9/w9pFDoElHxppffcaAmSSX0feaLS1xlZ2N/S/57ZjqLDkmA1XuQPDM
         5FPjgfT54v/wY8yNFBWCcuRxHtoU7Sm5uTigLGqGfd4pSwxCRIpy8+udjZ8K+69n4YxQ
         l8gmK4Kt+y/2V5DG/eupvVNHsPZW2X7u6FEkPrLqKVk3PPlQZwxMqDbBMR8/6HTPzJh7
         HyEQ==
X-Gm-Message-State: AFqh2kqz26jWnDbu00g63RdOXkSxpeTlRLOONSaSB6Ud40nDWllNVPgS
        4laipyLaqjIIUxkZcthftK3FB1Dkdn2yX0+I
X-Google-Smtp-Source: AMrXdXs6wVwbGhncvBdLaUdQtZ76sjJkpM7KXwjIMOaf1uFHHJunxBWWY6eu8hoiKtY2O5CNHxNT6Q==
X-Received: by 2002:adf:da50:0:b0:242:6777:bfa0 with SMTP id r16-20020adfda50000000b002426777bfa0mr54038944wrl.53.1673620709705;
        Fri, 13 Jan 2023 06:38:29 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q4-20020adfdfc4000000b002bc6c180738sm14721156wrn.90.2023.01.13.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:38:29 -0800 (PST)
References: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] clk: meson: switch from .round_rate to
 .determine_rate
Date:   Fri, 13 Jan 2023 15:37:55 +0100
In-reply-to: <20221225212632.2760126-1-martin.blumenstingl@googlemail.com>
Message-ID: <1jzgamcxej.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 25 Dec 2022 at 22:26, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The goal of this series is to switch the meson sub-drivers to use
> clk_ops.determine_rate instead of clk_ops.round_rate. The former has
> lower precision (2^31 instead of 2^32 on 32-bit systems). Also the idea
> of the .determine_rate callback is that is replaces .round_rate so the
> latter can be removed at some point.
>
> No functional changes (apart from the 2^31 to 2^32 difference mentioned
> bove) intended.

Applied. Thx Martin.

>
>
> Martin Blumenstingl (4):
>   clk: meson: mpll: Switch from .round_rate to .determine_rate
>   clk: meson: dualdiv: switch from .round_rate to .determine_rate
>   clk: meson: sclk-div: switch from .round_rate to .determine_rate
>   clk: meson: clk-cpu-dyndiv: switch from .round_rate to .determine_rate
>
>  drivers/clk/meson/clk-cpu-dyndiv.c |  9 ++++-----
>  drivers/clk/meson/clk-dualdiv.c    | 21 +++++++++++++--------
>  drivers/clk/meson/clk-mpll.c       | 20 +++++++++++++-------
>  drivers/clk/meson/sclk-div.c       | 11 ++++++-----
>  4 files changed, 36 insertions(+), 25 deletions(-)

