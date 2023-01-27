Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC82867E81F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjA0OWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjA0OWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:22:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404248419A;
        Fri, 27 Jan 2023 06:22:33 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h12so5100776wrv.10;
        Fri, 27 Jan 2023 06:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP+rhIH9mNOkOjcXJ9CVHf6dwRVakHxg9jm1BkBlrsk=;
        b=Ax+WWrbJ9jIuxe1ElYzKFHmskU0zGhoJboqcMGFcRAgF7IuHudLGDukdYgE3cW8PVm
         1+D5guEUUA6sqWmlJ8UDSwDLbo1ViQQ91OttDP7nhOedE5aH9YHYfOGFro9GILKerVqU
         g3ox0nL8gMz9t6PqzYW95i0ZyioLFZe/AZndRUuZJP8qfvXLE34DcWrioc+31MutOWLQ
         KNk4uroTiOovFuLTYvGKCnVsDIYDavd+LhJFvOob/DphJRIO0Ly4l3gh8dhEpWthuFYD
         cEoXCTmPtsn4WG1Lv7FcJXKgATEnmJetMikiHKUNw7h/oQjahKJTS5KLWKukqKNpyfV7
         unTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP+rhIH9mNOkOjcXJ9CVHf6dwRVakHxg9jm1BkBlrsk=;
        b=YM7uYbgwG0bTkwhSvXF/IZNI3Xt+5B62QIMZq+MZ4LiDp/uzdBDlySV1+mH6yMdQ8n
         T6mf0ERhXHwxYMmvk/eROtI9Q91Si8wf5KWWJbFwFjixXug0sjdx7mtV048mDtArp8XB
         hEHA9hT/mZ3sfTZgxrk9ux1vcokxBOaPMAgjO9DyrCdmuC7apuatBe81nvN1ifMRTG3a
         6yyEPr1KI7/2JlaNnk41/rkqzjTtjnRYxKiY4vKdZjt0D73GQ9yxjrqo7pDCfYzrNEpk
         N2qgX6Rg8rezEYxBpcw+IuyWHVfjXmjdqvI7WIel4TKPZLv4AUxxIQtXEHn+W8YWnMBf
         QYsA==
X-Gm-Message-State: AFqh2kqjCzfIrAKGScCPao3Ns7E/qWlnbXmDNiHeNBLjbmCISVwfLaQ8
        3iW+HQu3t/KX8yV/aWYFRJE=
X-Google-Smtp-Source: AMrXdXsef18V9RoF1zoMane1QGci9nSqkakcINjFi5UsiBoFE4hvVo3/UpKvBXXVkitmcqc90kUlrA==
X-Received: by 2002:a05:6000:1e04:b0:2bd:e8c2:c9bc with SMTP id bj4-20020a0560001e0400b002bde8c2c9bcmr34979943wrb.42.1674829351706;
        Fri, 27 Jan 2023 06:22:31 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id c11-20020adfa30b000000b002bfb5ebf8cfsm4301039wrb.21.2023.01.27.06.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 06:22:31 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/5] arm64: dts: meson: bananapi-m5: remove redundant status from sound node
Date:   Fri, 27 Jan 2023 14:22:18 +0000
Message-Id: <20230127142221.3718184-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127142221.3718184-1-christianshewitt@gmail.com>
References: <20230127142221.3718184-1-christianshewitt@gmail.com>
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

The sound device is enabled by default so remove the redundant status.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 3c1267a7ffef..86f0afe6491e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -233,7 +233,6 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
-		status = "okay";
 
 		dai-link-0 {
 			sound-dai = <&frddr_a>;
-- 
2.34.1

