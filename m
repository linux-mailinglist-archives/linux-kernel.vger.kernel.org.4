Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC5A6D9989
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbjDFOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239113AbjDFOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:24:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EFE8A63;
        Thu,  6 Apr 2023 07:24:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n21so1827462ejz.4;
        Thu, 06 Apr 2023 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680791067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D46T9b+JJuDM9M92e3n0i/9IffXB1t0ukgzPjf3oFz0=;
        b=A/r7tQ0PnsQ64+9g5Gfs6KSA3+qzI8bsgiGZZgE16Gp3vDtw48exdxiJ8Iz0C07izX
         nuFakgJIseCy73hgs1F6h2/NT3hOmk4B2+vQ1/kj6uh1MsCoh4Xm3gIf1WqKJfgBlCTr
         5v+5SOI/bR2os9onRTUEA8D7WUIBmBwcGEcpQMk44PKMF5+/8y6eM0RBMrkHqTd9zDqA
         o0gnXO64FgVrQda+i0mrswuPYmK0GeXHY40hI2D5pTE/WZ5nva5EeOxHftNIBGZlR5qU
         Pxr9m3VOqRlVUj4Zm7ck3HRqlTYQzthHHytI0qFfjC2WwEurSX//CLE+NKTxlW4yOw5n
         0JJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680791067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D46T9b+JJuDM9M92e3n0i/9IffXB1t0ukgzPjf3oFz0=;
        b=rR7QHgvP1HYygbKSWq5Jpi2if1SgzIWaeeNYMccQ+ifXhIJSWmc4Beq+tl/I7BjUa9
         74GYHQ16YUe0fAKzMHlpo0TNBE8UEsDV2FENbnufrULj65ra0uMz/aMTb0PurHwsZX+1
         VqkzDscfiKxLoQM2fWfhBbg3ILo9t8Dmn7E56SbSNm0GPo9JCyzAc6ONNNF100sQy1Fc
         nGHqDEvOdx626KuPDJJBrfQf/7MN9UQEMvCnpSOEwcZLVswg7r4M2qewakOcG+Vz0bxT
         7CludpjjFCQF9tC2pZ/wjgvfYy2/IscrsA7UZPml2AbYHSmQpfC5ARstjLa2ZIUJ81wk
         kMrQ==
X-Gm-Message-State: AAQBX9ch6Kcll+B1+EzOSwQr351pXAXba2nBX9IhpoWI0wSHH9rxhIpS
        bKt5EalyV2+6A5TH+Aj5aiE=
X-Google-Smtp-Source: AKy350bCrQlikbBNVUPFFO3VqIfZ5VOfMh1r211B7R/tc1dagRENa+zD/kM2XqL0g+dZplFOqWL2iA==
X-Received: by 2002:a17:906:9383:b0:948:d1af:3afb with SMTP id l3-20020a170906938300b00948d1af3afbmr5046735ejx.13.1680791066760;
        Thu, 06 Apr 2023 07:24:26 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906348800b009473bbe5f7dsm851290ejb.208.2023.04.06.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:24:26 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, u.kleine-koenig@pengutronix.de,
        wenst@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, jitao.shi@mediatek.com,
        weiqing.kong@mediatek.com, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] pwm: mtk-disp: Fix backlight configuration at boot
Date:   Thu,  6 Apr 2023 16:24:25 +0200
Message-Id: <168079104605.1968941.232523344220592816.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403133054.319070-1-angelogioacchino.delregno@collabora.com>
References: <20230403133054.319070-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 15:30:52 +0200, AngeloGioacchino Del Regno wrote:
> Since the pwm-mtk-disp driver was fixed to get PWM_EN state from the
> right register, an old two-wrongs-make-one-right issue emerged: as a
> result, MT8192 Asurada Spherion got no backlight at boot unless a
> suspend/resume cycle was performed.
> Also, the backlight would sometimes not get updated with the requested
> value, requiring the user to change it back and forth until it worked.
> 
> [...]

Applied, thanks!

[1/2] pwm: mtk-disp: Disable shadow registers before setting backlight values
      commit: 36dd7f530ae7d9ce9e853ffb8aa337de65c6600b
[2/2] pwm: mtk-disp: Configure double buffering before reading in .get_state()
      commit: b16c310115f2084b8826a35b77ef42bab6786d9f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
