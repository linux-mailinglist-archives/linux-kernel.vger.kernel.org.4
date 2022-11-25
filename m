Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10C7639234
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiKYXcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKYXcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:32:48 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513B1B7AA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 15:32:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z18so8149117edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 15:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4NT0UyLFq74utORBOv4WInxsxyZMPY8J7uSXPHg5TpA=;
        b=BW6K4u2C+woJDSiuJAEih/ZnYA0F9FxR6us1Bde8zIK4mcIkcYMMCJwbyUWkXu1h6r
         pzcFc+fO6MESNK3xN9+ooAvVEEJLUNaWC6ccu35ftWDhQ+N/JEjs87zR178srgsfULL9
         UF6Y8mXXg7QupirMwWMUkEm/9Dmif1V4FH+60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NT0UyLFq74utORBOv4WInxsxyZMPY8J7uSXPHg5TpA=;
        b=7IcPlcpQCNHRMum5NyUiPqs0jVfqYJVxykegYw5ms6gzIvSm9kKEnHZ80bwHJsbwq2
         Bu9fcueODYomaxbZtXXo+VYW1DFhJRnCewRpTgP4AboEdYJh1IO6YnZdrMTgciSVPWoi
         uHHS4FWe8Sj6sExDUKvy7p05VFk0BcUSTMSb1R1vui0YbXg8o2XyRJgVuF2RrXaxZpJE
         k6Wgtn4uqe2ojcxRksJhrA6c2/zdXDf7jnncGSAjB1SsLeckIS5FgcaGKp1G3wZRdZ0H
         rApGWn0fcuYa3Oed7C5YLAoXFceoQIrEQ72GJhYg/uRmsqydnpTBwy48TfpLOGPsgHcv
         2gXg==
X-Gm-Message-State: ANoB5pn3+nV0VMm8O33bmyLbcCpE0PT30zsesStemdkbZEnJnwBtzg0o
        4CCVkC4b+x42lJFeFlPwNKiyMA==
X-Google-Smtp-Source: AA0mqf5aNjXsBsD6xe6UJddqUzfL16Tyg8A80VdfhLrJdfeM3jFl65zhd5cZyI803E0nQX/s+ODdqQ==
X-Received: by 2002:a05:6402:e9c:b0:458:d064:a8c2 with SMTP id h28-20020a0564020e9c00b00458d064a8c2mr37748277eda.346.1669419165220;
        Fri, 25 Nov 2022 15:32:45 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id a4-20020aa7d744000000b004615f7495e0sm2325076eds.8.2022.11.25.15.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 15:32:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Sat, 26 Nov 2022 00:32:22 +0100
Subject: [PATCH v2] mailbox: mtk-cmdq: Do not request irq until we are ready
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221125-mtk-mailbox-v2-0-886f70c7173c@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=QjxAB+2ksa7uNlJhD3r206IvwLS8xrHsNDF+xigH57s=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjgVCLcbL6+FYpmnVdQr6P3EW3wpQ5JbUz/SYX3vu5
 oY2BcJ6JAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4FQiwAKCRDRN9E+zzrEiGx7D/
 4unhnIlngokFsgCtXIVGn9UwrructwwSqM3dW4jQBnylKPqVJBca+a8ifBW4QvCFH2SCFxLJEynWrN
 4KtM6nYyBvJnucIh6FC4je5ktr11CplKMAxcBPEe6ICJffvI4Lmn7eiobgKrC2V8mBqm1KMhPHTBvI
 XRxf1SjycDxThmDNqZnBEBBbpKSMKnnNYet/PTydUs/vrpU84H+MplwHGKiqp/BX8GEU66oYrUZCeK
 T2BX4vf+3BySMNlY8McuJGyqG+ttCsVzc/Kku6QkxicxfouNV7AvaBo2ojfnR7v5F7+7AWm1ToaCLr
 7gQgFT+yedAUHdoXmb+1dv59ZqAIuNW2tPcMM9/hhnlqDrcjskHRKGf/4Rg1TAwXaqXctMK7u8R4EY
 MEGFHMXAM116HamLBnLWOllsw/o31HMbxK5RBxtBHP61yJHdPKp74++DX6+oAKirP+EgSlqsWHv5ti
 PUg3rxPrngU/05UDKD6g3Z4piSUEgMo+Aks7CFnU9/5OZ4gcw6EiSTep8cdxR4SqjhmWEK7dRb0oKG
 OYoQX+yoX/03xtE8/GCy7uXJXQ1o4hT2UryOcBjQTfqInB3ypoJCBQ2tvWo9h0dGsSKgRds4Ihds7d
 YlO78muMw5YUW/EaMOwDE/dc5depwtst6yA0lnjtdAHP0WWufniasBGi1Emw==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system comes from kexec() the peripheral might trigger an IRQ
befoe we are ready for it. Triggering a crash due to an access to
invalid memory.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Jassi Brar <jassisinghbrar@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
---
Changes in v2:
- I have managed to repro a different panic. Moving the irq enabling to the very end of probe.
- Link to v1: https://lore.kernel.org/r/20221125-mtk-mailbox-v1-0-2e3ee120850c@chromium.org
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 9465f9081515..9ff4f89a55c0 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -545,12 +545,6 @@ static int cmdq_probe(struct platform_device *pdev)
 	cmdq->control_by_sw = plat_data->control_by_sw;
 	cmdq->gce_num = plat_data->gce_num;
 	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
-	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-			       "mtk_cmdq", cmdq);
-	if (err < 0) {
-		dev_err(dev, "failed to register ISR (%d)\n", err);
-		return err;
-	}
 
 	dev_dbg(dev, "cmdq device: addr:0x%p, va:0x%p, irq:%d\n",
 		dev, cmdq->base, cmdq->irq);
@@ -617,6 +611,13 @@ static int cmdq_probe(struct platform_device *pdev)
 
 	cmdq_init(cmdq);
 
+	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
+			       "mtk_cmdq", cmdq);
+	if (err < 0) {
+		dev_err(dev, "failed to register ISR (%d)\n", err);
+		return err;
+	}
+
 	return 0;
 }
 

---
base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
change-id: 20221125-mtk-mailbox-ba6cbd1d91b6

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
