Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F462681577
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbjA3Pqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjA3PqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:46:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F3A3EFC2;
        Mon, 30 Jan 2023 07:46:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so14233312ejc.6;
        Mon, 30 Jan 2023 07:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtnZbZJn7qNpx2WFbnWyJjOFxWWoyjTJRNSLs8byDPo=;
        b=NiJunNOyCwnkCJjG0thYBSqZO7dQZMrPwN2Tyb8r1J+U6hjCLrVhiLiUFxzA0D2aFS
         dLMgtLsw8t3DA1b0UJK9eU9e2Hl6EeY81QmYS6t1WU1JBmNDWMY3BLdYZhSttYwvBkBU
         BEkXWdTBzeMtWby+7O30J8wCrf6CLxp/HyJK9owgQ59tjIP5PMC2SUMqbhEnxCw1r2IW
         eZZ/YTKZT3NTpNMRkdypVNzuL/QEivLh3GaTb3SRlGiOIHUCil2FbXQrg04+icYa4+/r
         rxRAO/i3JxrStsLkzpdmxoDbyLdmki9UjX18YLyA2zNw08YcjrICZ9HVvT4Ro/1lXwhy
         Yfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtnZbZJn7qNpx2WFbnWyJjOFxWWoyjTJRNSLs8byDPo=;
        b=T9f4b05B0sdfK/plEof4murBHAmS7G+4yUWw7Fz0Yy2DCLiaPOrHfPSqfYFdFr/tVz
         45XbbPcvcorhZT4x4B9UaabywxNIgMUJHq/9h3wPJKQntPAD89D+6tCeQ2/fEqlzjmyY
         VgeGtUkbGdtGIaAspqqRNBWHHoSL4TDV691o7Xke1H8p+4RpqhnwiQtPVJXnUFN6xFZC
         p+w/dQKXTKv4IJwfzXiN5EXZcctC0K5ZgCr+mV2kuHRv+qUFcO6RDk8/a3fR6Bqftq2Y
         sL9h3V7p4Bb6dy8gVCISPHx79qwdK1thXU98AySwBccz49AGa7+0eRYjng8EJfDZ+TqE
         kaGQ==
X-Gm-Message-State: AO0yUKVaSJkXpKJM7E5zDCUTFXZaE9uZgsz+TT3FBa4QtqI5gEt+tOue
        sVK8viky7yoNdbXoI/kAFGE0pfE7djQ=
X-Google-Smtp-Source: AK7set8ONfiRFGonYBPV38i9/CXf+w/8U8FKS/LlLh/w/m8eq1UeosyR0ypAdVBUjF1v1S2NnK7q1Q==
X-Received: by 2002:a17:906:2704:b0:887:dea8:b025 with SMTP id z4-20020a170906270400b00887dea8b025mr4786278ejc.65.1675093564226;
        Mon, 30 Jan 2023 07:46:04 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p17-20020a170906b21100b00886c1a02d20sm2719108ejz.47.2023.01.30.07.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:46:03 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     krzysztof.kozlowski+dt@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, john@phrozen.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        sean.wang@mediatek.com, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/2] pwm-mediatek: Convert to schema and fixes
Date:   Mon, 30 Jan 2023 16:46:03 +0100
Message-Id: <167509354269.581356.8213728106190442559.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
References: <20221128112028.58021-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Nov 2022 12:20:26 +0100, AngeloGioacchino Del Regno wrote:
> This series converts pwm-mediatek.txt to schema and fixes
> mt7622.dtsi to declare the needed #pwm-cells on the pwm node,
> required to not trigger a dtbs_check warning... and to make
> that node actually usable.
> 
> AngeloGioacchino Del Regno (2):
>   arm64: dts: mediatek: mt7622: Add missing pwm-cells to pwm node
>   dt-bindings: pwm: mediatek: Convert pwm-mediatek to dt schema
> 
> [...]

Applied, thanks!

[2/2] dt-bindings: pwm: mediatek: Convert pwm-mediatek to dt schema
      (no commit info)

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
