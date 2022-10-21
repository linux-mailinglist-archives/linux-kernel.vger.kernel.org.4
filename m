Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968476072D3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiJUIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJUIsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:48:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F2186D66
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v1so3705422wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDtPL7fkaCFAp3KfpjYgG/R3mid8Rw0WiVwoN+Pwb6M=;
        b=SaC3/AqQNnhlmygAxmEsqoIpED788Sg1O1M4mwdd4LihqskwD53Z6+rBAQeyAnWRdj
         RQNg4nM9PBDydzEFc6h2iv/9blckNa10wbzhdMNXMkmC/RLGrSrtVuM5TWa0dqw+Rtnq
         3E2oGhW8JqFgXhYHhWM17+zM/RsRtsiv8CI6hWtgxGHFWRhwwfRSvdr9ApnTqI5AK8VI
         P658S8m8K7vDQu1YFxYPG6zDQ0d7XsYZNJvyw70S7wQbtvIL7/0y13uvNLDwmzucLJeQ
         m19AGGxUyJzLzfmVKhpMaOFTWsfjwwPeXUifg3fooY9nNUqJQhAFzNsv2/FmoymE/Jdh
         kOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDtPL7fkaCFAp3KfpjYgG/R3mid8Rw0WiVwoN+Pwb6M=;
        b=mR9/b8gHMAbfu736xQFO0otPXFDXt9yGR+NNoHdjOLHGplHAiNFpWlJ/0atJx6UQDe
         fytNil1KwkafVJRzMEx1+3X381K92NWaajr50Ik7kScD9FoqP29lMl3DIzeEh8Mvf7c/
         6oPYBY8fTPJIqnpuIFdjhI5gDlfEzl9Zoy5BhQj1Blc5StSHBl82jT6k3OO0yl1M3ZEM
         ilBlzUs1zJYCAbh9EESKQptTxF3++nH8B804r/rvRmsRl9MYqkdXswNygscIgqRqksi/
         CKR6ps5xms7eLifE/WLk3BqIi7q8QKctwjRKTGzHjmFsxEJW8LbA76YqwZQzCxX+vvpg
         tETw==
X-Gm-Message-State: ACrzQf0nUw2SsH/S6HzPUYRFYeKwh4OYi8PrTDCQNCucMpxKcbuTqo8X
        i33nzBVzWsUDxLfjWT33Nx+MpSEELis2OQ==
X-Google-Smtp-Source: AMsMyM7zvf0JLCBhMlobPuIA2iHhJ1o+FgclTU3OJG8WbwhWecxsKXKVKWubyy7f0Cz1XxndijfJaw==
X-Received: by 2002:a05:6000:1d82:b0:22c:ae77:c8dc with SMTP id bk2-20020a0560001d8200b0022cae77c8dcmr11751829wrb.413.1666342076824;
        Fri, 21 Oct 2022 01:47:56 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-248-155.w90-24.abo.wanadoo.fr. [90.24.137.155])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c0b4500b003c41144b3cfsm2040233wmr.20.2022.10.21.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:47:56 -0700 (PDT)
From:   bchihi@baylibre.com
To:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [v2, 1/2] pinctrl: mediatek: common: add mt8365_set_clr_mode() callback for broken SET/CLR modes
Date:   Fri, 21 Oct 2022 10:47:07 +0200
Message-Id: <20221021084708.1109986-2-bchihi@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021084708.1109986-1-bchihi@baylibre.com>
References: <20221021084708.1109986-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balsam CHIHI <bchihi@baylibre.com>

On MT8365, the SET/CLR of the mode is broken and some pin modes won't
be set correctly.
Add mt8365_set_clr_mode() callback for such SoCs, so that instead of
using the SET/CLR register, use the main R/W register to
read/update/write the modes.

Co-developed-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 15 +++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  8 +++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index f25b3e09386b..076ae0b38e3d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -330,6 +330,21 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 		return -EINVAL;
 	}
 
+	if (pctl->devdata->mt8365_set_clr_mode) {
+		bit = pin & pctl->devdata->mode_mask;
+		reg_pullen = mtk_get_port(pctl, pin) +
+			pctl->devdata->pullen_offset;
+		reg_pullsel = mtk_get_port(pctl, pin) +
+			pctl->devdata->pullsel_offset;
+		ret = pctl->devdata->mt8365_set_clr_mode(mtk_get_regmap(pctl, pin),
+			bit, reg_pullen, reg_pullsel,
+			enable, isup);
+		if (ret)
+			return -EINVAL;
+
+		return 0;
+	}
+
 	bit = BIT(pin & pctl->devdata->mode_mask);
 	if (enable)
 		reg_pullen = SET_ADDR(mtk_get_port(pctl, pin) +
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
index 6fe8564334c9..11afa12a96cb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.h
@@ -216,7 +216,10 @@ struct mtk_eint_offsets {
  * @spec_dir_set: In very few SoCs, direction control registers are not
  * arranged continuously, they may be cut to parts. So they need special
  * dir setting.
-
+ * @mt8365_set_clr_mode: In mt8365, some pins won't set correcty because they
+ * need to use the main R/W register to read/update/write the modes instead of
+ * the SET/CLR register.
+ *
  * @dir_offset: The direction register offset.
  * @pullen_offset: The pull-up/pull-down enable register offset.
  * @pinmux_offset: The pinmux register offset.
@@ -252,6 +255,9 @@ struct mtk_pinctrl_devdata {
 	void (*spec_pinmux_set)(struct regmap *reg, unsigned int pin,
 			unsigned int mode);
 	void (*spec_dir_set)(unsigned int *reg_addr, unsigned int pin);
+	int (*mt8365_set_clr_mode)(struct regmap *regmap,
+			unsigned int bit, unsigned int reg_pullen, unsigned int reg_pullsel,
+			bool enable, bool isup);
 	unsigned int dir_offset;
 	unsigned int ies_offset;
 	unsigned int smt_offset;
-- 
2.34.1

