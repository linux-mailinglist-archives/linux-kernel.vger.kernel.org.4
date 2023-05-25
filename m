Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445CB710E96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241668AbjEYOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbjEYOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:50:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD6139
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:50:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so3298095e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685026239; x=1687618239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeLXr/ztgvOtVsK+Kl+n0JOEyozvguRk+veU2UYviCg=;
        b=N1q2y9PxsUwtmnergtMtlKIEo5yB8DE1LaJOQmZOxctO0npZLLxgcZpWp1MlAFKVuX
         fd/3QOUX6duwieVU7egfpm72qHByhULGPh6QoLcp27T1Ta1aoRXoU2zzmRN+Djl+a/nj
         8RT42EHCVaxcxAdoh07FhJpYj9zAa1XEiTNPcPuzby9JkCSKWz+1OCjP9I3TvOg2DcVa
         Y3ns+bTt7AbWE/roWBBzulJMuMqikbfisGkNnvBDM09RV/PfnQSZYhR8UPG6jGVq/yKA
         bllZaPxRIm02cbuDoN6dQsxpETd4yLqPCPEKZaAGXlgX997P96sHp9B7X1e3ABuuexOn
         gcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026239; x=1687618239;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeLXr/ztgvOtVsK+Kl+n0JOEyozvguRk+veU2UYviCg=;
        b=DGvC6hWYlZNoP5IBo7sw/cExHJjLsS9Ki164VP39xZrQchCHW2kD8GcWi371URP9Ft
         KZnLdYnao4UCFOj4Nz9SSq112FKSxHF0aGiCuuyPFi/oAIz1+k/W6do99REPse6tIBlv
         aeQCdHe6SkGo0aMtpFgt5ODKd3Nt1Ae9sXkdZ8Z7H6wHfkhWJSdQft+M9q/sVtQ1k5Fs
         WWKb/RuusuXslBNVfmUyAcJHCezqpC5rB9Gjs3kTbnKK2CLe+fcLdCquZKI+ydMy2CT9
         GNmkRGEa70kjaigKi1+xaMmU3OlrSdNgdqJLa3pzStu1+AzUSJKqbfL6Cwx4LtyoU4yI
         EeIw==
X-Gm-Message-State: AC+VfDyuHd/GLV3OGKZTzlP/OMn4vJw2P1ucrUrNBZbwC8vFfANr5MZe
        4o199Pi4oi3vMF+tKW7iRnX7aw==
X-Google-Smtp-Source: ACHHUZ61k/sCKf41zD6WPEp1UUz7BzalUtlMAH6Mf0Oxs5zHLKiCMmMLMIuF82QNh9dW5i5xV7F6yg==
X-Received: by 2002:a7b:c5da:0:b0:3f6:774:fec with SMTP id n26-20020a7bc5da000000b003f607740fecmr2762120wmk.29.1685026239445;
        Thu, 25 May 2023 07:50:39 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id n4-20020a05600c294400b003f3157988f8sm2349559wmd.26.2023.05.25.07.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:50:38 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 0/2] Fix and clean MT8365 clock indexes
Date:   Thu, 25 May 2023 16:50:26 +0200
Message-Id: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALN1b2QC/3WOOw6DMBAFr4JcZ8E2vyRV7hFR2GYJq4BBNkEgx
 N1j6FKknCfN02zMoyP07B5tzOFMngYbQF4iZlplXwhUB2aSy5TnooSGFjDdG8jWuMCt4FmqVVP
 kGllwtPII2ilr2sP6jMlcxBk4I5JpGMkk/XRNizz5eTnE0WHYzpBnFbglPw1uPbtmcaz/EmYBH
 EQmeVkqUaZSP7RaO9IOYzP0rNr3/QvBW6pQ5gAAAA==
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=mJgIzKbuG8pOxtxWfLmmBivGM0R6E16D6cc2oakm5fM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkb3W+7R4+WpLQFt5TQvVau/Q3VcVbO3w8VqqssbLY
 g5NzkRyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZG91vgAKCRArRkmdfjHURclZD/
 9QLAUKtYzpR4BF4chcuH2K+VHCEK/q+A72ywFvKsKuqPYRq3bl/hB3x9pw/ZIf8ZTIn0jdVYXxicFt
 4v66fpwPsT7bZFvIWwt3pOy7NgbWH+xHHRXh2y4V6RS/fIwekCb9vwty3//kGvBan7/Z2/+sbpSJkp
 zzMy/9Mcw5n9MdE4KvbK5TvB6RIRBOFs2/Oli0bZqhW/M0YTByzZPbqK89UtpCgxs3ok1vtCsC5u4M
 v15AywGqae1FGszDfABRIIr5I2oJWjTm4zz16RH6B4dC90EmM0/2unf8fIZQK3sFnxS/58XsaKnyGm
 INyRxjk5FfNaMzWZorK5s7PRTiTYokSnVpqbL/O1YwCfG15QLTd8xlYzMk5jOROui+mcv3ZDzGOe2r
 M3jEMABp7BPr3k+yxCluJ9rQXh2kfAd36EpgRzVgoOZTQnjHW5+lrpbxhqCwZGFfnx3aiT3JPbqLLK
 x+KK6oN/1l90s7lrSAdoNfDMhcKda+Ghv2ZWNBYxVGh+oHz03B4a5HnicdgxYsXFytTVC2/hw4W7DZ
 JBSlS/aVAmHJMam/I9GpfPLL1obX+zETV9SwV2iruVVx9Eb7+THBnB5Bg9L6DX6qlW0t3gdhfwDn+w
 g/h4HGJcjlSWUYC1F0X413yT93KRezxA/bm+7jABjd3Uoty15pMrAB+04Jdg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first commit replace un unusable clock by another one.

The second one fix a regression which prevent the initialization of the
latest indexed clocks. The regression is introduced with [1].

[1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
     mtk_clk_simple_{probe,remove}()")

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- Add the missing clocks in the mt8365 clock driver.
- Revert all change in binding file except for one clock.
- Link to v1: https://lore.kernel.org/r/20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com

---
Alexandre Mergnat (2):
      dt-bindings: clock: mediatek: replace unusable clock
      clk: mediatek: mt8365: Fix index issue

 drivers/clk/mediatek/clk-mt8365.c               | 11 +++++++++++
 include/dt-bindings/clock/mediatek,mt8365-clk.h |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230517-fix-clk-index-96043baf65be

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

