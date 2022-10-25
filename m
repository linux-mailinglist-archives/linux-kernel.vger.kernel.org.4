Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D21B60CC16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiJYMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiJYMmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:42:03 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C118B494;
        Tue, 25 Oct 2022 05:42:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g12so7830152wrs.10;
        Tue, 25 Oct 2022 05:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ic2JEDn8iIKh6kokfWzyIvyt1AwKkoMppVSCI5C57s=;
        b=p7sLxOhF7+RJa8UpoEmVVGga9/XxYJpHt9VYi4nB27HDInsNdVKl7A7Y7xodOhf69i
         cH4p45wrXBpH/+j58uHRVEPx6mxh/2gQckDVhrgiGCsUh2ynjtz/IBUS9xWyK2fYpC97
         ds2Ro5NO2Ho8uNlbpqNj6GO2mpGF4KKPfRwhoSf+FnqBq9kw4hpbqz5kplGxdOap8pvc
         nkTIEyN5cbLojENWjdgwwecAr4ejh7T8CkVx6Cc6JRqgtS7O5SoOxMymWmJexfOrWeoK
         Zm82tzz/g9IR2WW1Wkt62/F8UDLk7lV/5fp9xSUxnVSXRy6hoTpp6OcmSUn8vhSmBfHS
         3CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ic2JEDn8iIKh6kokfWzyIvyt1AwKkoMppVSCI5C57s=;
        b=gcayYFe6fsCxvAm+oDVmS6Nz7b8wQhHVXGk7Xzc+nxKjmZnTfwnAWsHJkwEgH6+dG3
         /PxBIw91D9Te2c2M9RV+K5LbU9MCEIN7A1fl3MQMJxzfWyRGth01/PTY9pz5xRPZEgxh
         b8FsCzkJ0VnwWPO1TaS1rrsZ5T5vpqj9NGjUDaXm0wMWGL+B+vQZUVQeQuDppM1+Zf9c
         8XgONU9Xk0DYOEBeFX49JyQwoWAC4mk9CPa63p/+n7Gd5to7aM0Y94xLDYPokMaIzrIB
         tRmI83jj9b39Sh/gl4WyRF8STaQvIVHP4Bwy+nvpVTg5TzhEBUkOo0IBMdTMxjbQRuuD
         2GGw==
X-Gm-Message-State: ACrzQf0H0uRBiY1/7q1ym0QrwnurOCCg233j8rwoK2xR7t2q7hE7Jxny
        KXJyw379txh8X0ZgkMaKglk=
X-Google-Smtp-Source: AMsMyM4PfHc5iZZPnvgw3lB96B0iv3Tf8sL+cm4ldHaMrUPmjOZBcBtMm3ogjXQBRx7LsZBd9zG5SA==
X-Received: by 2002:a05:600c:1c1e:b0:3c6:fa3c:32a9 with SMTP id j30-20020a05600c1c1e00b003c6fa3c32a9mr15113010wms.203.1666701720859;
        Tue, 25 Oct 2022 05:42:00 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ay19-20020a05600c1e1300b003a1980d55c4sm11250664wmb.47.2022.10.25.05.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:42:00 -0700 (PDT)
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
Subject: [PATCH 3/4] ASoC: dt-bindings: rockchip: i2s-tdm: Add RK3588 compatible
Date:   Tue, 25 Oct 2022 14:41:31 +0200
Message-Id: <20221025124132.399729-4-frattaroli.nicolas@gmail.com>
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

This adds the compatible string for the RK3588 SoC.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
index 8646cdc692d7..0503f4f3fb1a 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -21,6 +21,7 @@ properties:
       - rockchip,rk1808-i2s-tdm
       - rockchip,rk3308-i2s-tdm
       - rockchip,rk3568-i2s-tdm
+      - rockchip,rk3588-i2s-tdm
       - rockchip,rv1126-i2s-tdm
 
   reg:
-- 
2.38.1

