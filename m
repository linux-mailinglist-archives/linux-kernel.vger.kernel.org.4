Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789EE72BBC7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjFLJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjFLJLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:11:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFB59D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f654d713c0so4261420e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686560765; x=1689152765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Og9TBGAwPn+7cIBOXsPpips1XtfHFEVu/z5r53B7A8w=;
        b=MPjcE+/rzgc7kcCRs8WWQAkWJPGqXjGOhIyM7CYg626COM8DZM0R6GAVFHrsem0gZo
         FPovE9X7d7I6k0vyte//F3QcCb/krQSJNRZTtGTpQWY1Zs1ZAtx4C29BW1ZuABgy22qf
         d6a7rAXInnJMPCSrlJQv0okSfjsTF0DE6ie90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686560765; x=1689152765;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Og9TBGAwPn+7cIBOXsPpips1XtfHFEVu/z5r53B7A8w=;
        b=T5uk+hGCAVwGWRte6p9z5AJVwz9KG8qX8ARPU7XLABaUePn32zaLZBqEnhecYKsrMA
         hEXealGgR3PCDRJ0r1sbXV/skXhpRJqF8LWU5+REkcqI/b8eKJAHjPp6mIZ13lNuSNSx
         y5RxYKJFJwMK65rUW5QGB2QRH5Sq91zLaSa5BVWqrZ2mX1PjBQ0QoY5rAw4Frfe9kX3z
         FnRRiymSFxE6BJLjMlnVtdSmPDQbtDZeuG6M1aOVQI9rRoSOXDvonZtRSgHCu4rSQKUv
         ZFNNUT9WogoTG7W9bjvjlrNunUfWbPCucNUTcMU6BhTpmCLu53e7mKzpoRPot4TP1myB
         7Vpw==
X-Gm-Message-State: AC+VfDzRQHZc/tf/QUscDygFrXb2RBKDXONMI2NCq7BN4lT7i5lsLxZU
        TnoIfXhR6NLW+m5wmjmaiKr41w==
X-Google-Smtp-Source: ACHHUZ4AFtdtk5vbc84pFx8fmkaQZYYeUjmkPCbIs8hGaLKWkMZPhnp7T4qVI3RpJ/wytxakqMSOwg==
X-Received: by 2002:a2e:8401:0:b0:2aa:3cee:c174 with SMTP id z1-20020a2e8401000000b002aa3ceec174mr2147269ljg.13.1686560765135;
        Mon, 12 Jun 2023 02:06:05 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:82e9:e3cf:d6f0:4c6a])
        by smtp.gmail.com with ESMTPSA id o10-20020a1709061d4a00b0096a742beb68sm4867275ejh.201.2023.06.12.02.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:06:04 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@chromium.org>
Subject: [PATCH v2 0/2] ASoC: mediatek: mt8173: Fix error paths
Date:   Mon, 12 Jun 2023 11:05:30 +0200
Message-Id: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANrfhmQC/3WNOw6DMBBEr4Jcx5HXKA6kyj0iCv/AW4DRGqxEi
 LvHUKVJN292R29jyRP6xB7VxshnTBinAvJSMRv0NHiOrjCTQtZCgeTj0sC95j2+15kbq4TUrXJ
 GO1YmRifPDenJhmP0+3ucZ/Iln7ZXVzhgWiJ9TnmGo/3jycCBN9DfbCtqUA6eNlAccR2vkQbW7
 fv+BeYEHJPKAAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Ricardo Ribalda Delgado <ribalda@chromium.org>,
        Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=u4u7hEhZSgxD4Q24UIMt8SKbPVPeHlqMVl5rw50ldGE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBkht/dkMYqHwnIEHZ+41JKijVvqLzD6KdwPtBHF
 P52bsfcRM6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCZIbf3QAKCRDRN9E+zzrE
 iIVVD/0ewCXTJuAPyBW65v11fUyArpepY+0UQh6uLOiQfVArXUMuNaQu2qYTOTCRbQwUSx8T1Yi
 tobpmaXoHg5Fj+ZChbIz0CCOuaOxEMzPGX/vNWZcFS85T5YAesx2ur4WM3S8tic6IcRRQnDdGgP
 GCRt/PDdn4h7nxOw5Ur/7waoXc85mnWerg3iwkrRmnAM5p8fdxmLBlOvU4vXYnU9kctdO/Vd+A/
 ffnMjOdxSjR2OwM61CAgwwH78pFh2m10/B+spY8YSzLuNdc8FECn/cSb2lqKXdWuXqIQM3Pc2u3
 floqMLaH/OyVeFxyL/RMgDizstyHN3KlfhWmvnVdQtK0uC797lIqxFAjDQmsPqNo/qODGu4sNyD
 1ii76GTmZwZbBhVEhY/duPnnHCcHaXoW2qUsqdTp7G+kQOi4GhTNu3gqkR8tnDhOwJqU92ppmT6
 1a4M0lBqysOBdbhvDjxCfM62xyXw9Ibn0AL+v7PY7VPkD4Qq8jhIK7iaj9/sZ4k2RvtadLNNuBB
 bnK2Qky9LICNc4JCdD1qZxl/NcalR0eFzqJhjqDGjKK/UTOOKYpgLCtDMjRNtU0UniyLpcJvlAw
 UzEkU0U8IuUdmEUk9B4okALWK6iHVmJkZ28sKcVLCAOv+bdAjtyeXbpcMo5oClTpEwuoZdKL1qD
 5ntBFv1Zxs4PvNw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASoC: mediatek: mt8173, presented a couple of error paths errors, lets
fix them.

Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>
---
Changes in v2:
- Fix other error paths bugs, Thanks Dan!
- Link to v1: https://lore.kernel.org/r/20230612-mt8173-fixup-v1-1-81f5c90316d1@chromium.org

---
Ricardo Ribalda Delgado (2):
      ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path
      ASoC: mediatek: mt8173: Fix irq error path

 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230612-mt8173-fixup-bc602a96dbad

Best regards,
-- 
Ricardo Ribalda Delgado <ribalda@chromium.org>

