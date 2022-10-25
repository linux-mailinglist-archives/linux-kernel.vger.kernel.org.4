Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC660CC13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiJYMmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiJYMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:41:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDD918540E;
        Tue, 25 Oct 2022 05:41:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a14so17830207wru.5;
        Tue, 25 Oct 2022 05:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElsXKifGPu+xWV5kp4Q++GnbWWKLpxXO2HTLVtO10F0=;
        b=HHau6xvD/rOVqNP6ObIxSLZ9tnj+QB3yZIBup+RJEu6HUeGApKsCbQg71GXp4WHpP1
         HeFb1s2MCV1T3pQc9zhYMbzja1i/iUogcuOd4ki2KtMh2nACc5tX5fxsuYV2uywXyQU8
         fIE4FU9pD8162SSETLavaz6p0DxVFO59t8uPJtGqLWgoimkuzYOK7U9Ss123dNaQ8Aaa
         35EVE8YbSiUjK9/tNd9xNViE4PEoZ2LA3d4nf/7vC7A/V8RNXS3Rc3gdP4z1gm0NEhee
         CqhgL3zs7MNbwytp/PiGRGhyRkWPmqRe9hHZotjX0JR0+3nikKGZ1CeLe+/gYnQdnZVW
         ISDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElsXKifGPu+xWV5kp4Q++GnbWWKLpxXO2HTLVtO10F0=;
        b=wpsVCRE0OwBnPEdKSp8O8pXje7hP4mL3L1NfJgCRbhqz6np5k6+HYXOSAUFRCA+ikE
         UIMtQgsdpDCSBbWMT4aa/SaVJx/YmBmaFXMP5/tweRrH4nlwJJIv2x/Pa7omp3B6p1rH
         1o94PMiKVpjQ7TTakR9GFAyZIWyvG8Pptu6dHfo7G7rox6lFYpOs8NsbXgLOpbPa2P6p
         uCPz9HZ+eAtXC9G7/agPknjtl0PkJcQ8HCaXRXF8s6tgaWeFaCFa1JD+51Vf3zHgsZ7q
         NFBZIHv+HFvf9kViJPHR5YhMQRDcuKL6ovB7luTuF19vrzB5dr7GFJQ7QcyJlmF9SpXl
         ZQMQ==
X-Gm-Message-State: ACrzQf0876CZyvxSPg3OkkjGXGTW0IARBSnHarB3di3cGNDAZKPFj3xC
        FnA4ILR+U/wyKiXPuYmS/No=
X-Google-Smtp-Source: AMsMyM4kI+X+FZY7+WMg564s3kMyQmXgsKWXajfJpp1On9XiNlJ/mym/OBtcbcEgIGxZXcTFg4DEdw==
X-Received: by 2002:a7b:c048:0:b0:3b4:fb26:f0f3 with SMTP id u8-20020a7bc048000000b003b4fb26f0f3mr48434995wmc.115.1666701715943;
        Tue, 25 Oct 2022 05:41:55 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a1980d55c4sm11250664wmb.47.2022.10.25.05.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:41:55 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ASoC: dt-bindings: rockchip: i2s-tdm: Make grf property optional
Date:   Tue, 25 Oct 2022 14:41:29 +0200
Message-Id: <20221025124132.399729-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
References: <20221025124132.399729-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
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

Turns out most things don't require the GRF, so making the property
optional is the obvious move.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
index 6a7c004bef17..8646cdc692d7 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -135,7 +135,6 @@ required:
   - clock-names
   - resets
   - reset-names
-  - rockchip,grf
   - "#sound-dai-cells"
 
 additionalProperties: false
-- 
2.38.1

