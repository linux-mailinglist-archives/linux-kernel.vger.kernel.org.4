Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA54A7062D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjEQI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjEQI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:28:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E645595
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f42ba32e24so2973105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684312118; x=1686904118;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZihnAL1nAkDBbq2KyMEHfWY+WWt7eWRA6dF80uZXMso=;
        b=G3QSKTUw0Oxncgfh6I40dQHk87EmvKdhFRf4n1G5iSXH+XaYVVT+Ra2U6O1C+SX7hG
         5OntSosJwXDp6Uf5nvYmFzYWDpxllRQpRLdp6lWK+0Hn2uJsoyWdkKVDv8mtUTUxfvRl
         BKiAvmrEMgb60bXnNbNffJf3jMSN+luwT5lb5nG/IM5zenRs+GNPulhKMb0bZWJ0mCBV
         DK8sDECKzx60jE+At3/Md1nScT338EQOPGVGQhqi7TgIFgMLsOVgsVih4yTAEMVmp9BG
         UV0GNj4nHNrCw3VbUiRp5FvhLOVjMOQAN0WLe3zovNqOjr9YY/kPmDDHArQ/ioJhE5RB
         8UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312118; x=1686904118;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZihnAL1nAkDBbq2KyMEHfWY+WWt7eWRA6dF80uZXMso=;
        b=fd7cDvSNovvhr8ivjwvc7XVFP6bVoMtq/Dfye6jMZc05vkdLpr/5UsIhYh6M0q4Uf8
         kfyUfs2wnDxsWu713yfJjLLHMfI0pwfP89DD2UEnrLAD9/ksQPxpsOKzIF2merL1u/4W
         dI1uQ/y5mdliQooSs2j2FmS4tb9b1J9ScbUvX1x8BlrxeSoywVfHwPLWBMvw08YRO6KO
         iazyMRY6BTHc7IvcbPEYM2KqqGx8yX4XuYUhcFHevLVLnBrYJkIyUG7MeB1b6Stt7Wb4
         ItA14vsCooSAJF9ninDifM1SxUMIU0ltqzgHknLBdyXK377IH3vhdp9GATPs1BKmkJhZ
         GTmA==
X-Gm-Message-State: AC+VfDw2vpwQVzYdhwnr7deHyRwqJBH6HEKL+vYEbWRozYzgztrY3caA
        kZKmUL9JUs3uYmOa+EeXkaWbfA==
X-Google-Smtp-Source: ACHHUZ7YKNglQi5AC4I94XCPl4u8XP7inha9SQYONn/dMfYjIeq63eOT4aRc1F8dTARCyWuhK96BGg==
X-Received: by 2002:a1c:f310:0:b0:3f1:74bd:bc22 with SMTP id q16-20020a1cf310000000b003f174bdbc22mr26806422wmq.6.1684312117897;
        Wed, 17 May 2023 01:28:37 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c4-20020a056000104400b0030922ba6d0csm2323066wrx.45.2023.05.17.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:28:37 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 0/2] Fix and clean MT8365 clock indexes
Date:   Wed, 17 May 2023 10:28:18 +0200
Message-Id: <20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACKQZGQC/1WOyw6CMBBFf4XM2rEt0Pr4FeOiLYNM1NK0SEgI/
 25x5/Lc5JzcFTIlpgzXaoVEM2ceQwF1qMAPNjwIuSsMtawbqdUJe17Qv57IoaMFL0a2jbO90Y6
 gOM5mQpds8MNufaKYzbHF5JWYxshevKdzY7T4q+xiTFS235Hbfdu+oefgUJgAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=163q5ZS2H6Rg2KSX1F5s5Y2O3lJW+MTWBH+aLyNFN0c=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkZJA0Cqynex2hMWv5jFuYbgLuJEm6GmoGzTrvVMjE
 2KVGv6OJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZGSQNAAKCRArRkmdfjHURVWzD/
 9ZqOS0zeXDxgtNISQviQzvACckTrVcuvTIWsU62emZwgz/vWSglHU5NO5g+YjQrk6SlIjNlFm9PvTp
 f9heTYMBlIBek9cd3jdwS7pL+8wemxp6Z5UtiUNh98B0c6VrONOe1Q8ZTsjKZ+YpE/N+ZUS6xMx8YX
 rMOsAIDqMOwgnigjDi5H1yOQnvIN1CS8wHmkgdFaWR2sN/QwZ+4NEkp9nTjxrHEBo5nim9mWGofror
 PpkezQoyJaTA5PhWxqy6tjgI7JQ7fgmHN26swYTRk6F3tMxGozmW64sJFHUXXVYgQsZFaouV9COfxx
 I8JBvNlmetiBYyOFlUR/hm+9r52t5Cb0BZnk5oLnY4ElTXmUDQAGKDknG1uJkG1jcgij/4ZkufFvwa
 wYsH2dtTYYd39CTQGz5ojHIScDO8fPDYSe7tMV/MQkmX8gAPdAjj1r/DZA1wocK/vxPk4GU1qEFnRG
 9oqiPwGpLATbNfHRWQPmvgo8qVNruvQQX0Xa/G7rI38cn6I4/e+Nj3eKfJ5blYFzn3vTnaIt8F8BTH
 cktEgwR9JZzeu7zSoI8numeAvh+VH+nOaCvEjKOsLM/R5LiS5k1s8gRcNFWFxYiLQjMirEswCuk7MR
 Tf7Nad3oHM+CDg04hcgsVjEYo/ymxc9h+urgq+KX1n0vPpWr/rBZaM/n5ANQ==
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

The first commit of this serie fix a regression which prevent the
initialization of the latest indexed clocks. The regression is
introduced with [1].

The second one cleans unused define since the probe mecanism change.[1]

[1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
     mtk_clk_simple_{probe,remove}()")

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Alexandre Mergnat (2):
      clk: mediatek: mt8365: fix the clock indexes
      clk: mediatek: mt8365: remove the max clock number defines

 include/dt-bindings/clock/mediatek,mt8365-clk.h | 375 +++++++++++-------------
 1 file changed, 175 insertions(+), 200 deletions(-)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230517-fix-clk-index-96043baf65be

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>

