Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9071D6330C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKUXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiKUXjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:39:18 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5756B4F01
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:39:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vv4so22755302ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ehabT/SWyuxZAFQVGOlc3gf5GNfQZBfPsZlMRjNRcE=;
        b=Z9Ppn1iS94cKQXbFfqIKO6UCL8nYmxAOoDhKQaH/HqikOla9W1FmIIM4OUciRY+9PW
         mMLQ9BgPKROkY8OtqIgLH3EuQ0onG+GmXdwbnejEZFay+OVzsJ3bKl9OaLj4FsBvW+iZ
         bUjdMT4NzMxTDubjC4llZsxWCuMD+Iad7Q1vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ehabT/SWyuxZAFQVGOlc3gf5GNfQZBfPsZlMRjNRcE=;
        b=h5xJB8R5SjcxrSZvaqv4shu2t+cG4aw9ZqPl/6ikq1QbCjv3arMUMZEMY54roDfGRI
         +ssgDinKDeGX8JFB04XuKBzOPb/0NlihsKVx7k9A3xHQ14+9+1ezp9gp/E+jfn9GFdgD
         gluAZDb8pGOqYms52laFAu6rIb3hmsYWA+M2xC/dnBDV9QesgBD9SrLqKoWbMwrzhiPL
         DbZKIWJnmprOEe18OWSSnuw8xCb91gUYu2BwlB8S91UMCS4FU9phB8SNXGf3DZsGSP8o
         kElC+K40xCDxsQTmVF9GZQDggzIhmyBOuV0Id6Ey32G/XwRu6DaArOcKbgoNsfkOU/5+
         TpXw==
X-Gm-Message-State: ANoB5pmAz4ho/m8N0HhwwPtJQLDtY8pVXkvShslBGrPsAjwmCm7l5bC4
        HRGC2qRKkEAFJmiITorjxEoZfQ==
X-Google-Smtp-Source: AA0mqf6BvPDUi/dw2PVwPuhGcem2sPVKE+0SnBNbp3pnF6iT+L/QymDwd4laUxejvVIIaoQj+R5yXg==
X-Received: by 2002:a17:907:8c0d:b0:7ae:70f9:114 with SMTP id ta13-20020a1709078c0d00b007ae70f90114mr17121024ejc.44.1669073956335;
        Mon, 21 Nov 2022 15:39:16 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090631da00b007b27aefc578sm5411835ejf.126.2022.11.21.15.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 15:39:15 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 22 Nov 2022 00:38:55 +0100
Subject: [PATCH v1 1/1] pinctrl: meditatek: Startup with the IRQs disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221122-mtk-pinctrl-v1-1-bedf5655a3d2@chromium.org>
References: <20221122-mtk-pinctrl-v1-0-bedf5655a3d2@chromium.org>
In-Reply-To: <20221122-mtk-pinctrl-v1-0-bedf5655a3d2@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=ULSRbYzh0w9ZAWNFdOlTTU/M16f8fiyJqpNG4+AGQnI=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjfAwfzhyYWIqnakB+IO0fgl8p763kk9dDJ1yT//Eb
 pC9/5NqJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY3wMHwAKCRDRN9E+zzrEiHr7D/
 9lpg4m76+Y9UreH5QlwV4hPqKvzA2p1T6cb5XqoDvEv108OZStLOpQa+Nv/TFqLJuDLKz7GsRFn1AU
 rtiCLFLurNf7a8PNQkaPb2nYISiYS4uNl73QVNWwgpcBXNBGoiHPV9yvTpKb1f258JXu6Ek4Hov1OL
 u4/Wb9GwRWzd3UoJWQljRwjqpDlLtKFba4f//3Tx1OOTYHcM2VNuTbaAtFqNp6GNRYVv4b2yp3mM46
 k2Fvsgzu9XL0LamP0PDkWUZqncRQtgnCOiNptvMRZEYrRbiiPihfbxl2K2gZJ7fXv6PmQr+CT/IAas
 9yWZT/xcjbt+Z9eq8vwQadAIRF3R4x82DWyMtVx1IkSNVqMzjODmdTYh9ak3YKOsV86lO+A/UnHgmi
 O++6IdmC/MELcw17t7E29N+ci2hnzqCLRmj83MlMlSV9syAyO9mY6Eleqg2+NItBpRNIjsMYZhivWx
 Qp5a2g8i2HSip7CY/AWrYkSeYerruih+K6rHB5cRsUguSb4I9bUiH0qg2X5dxhugBBIQ1D+WSxHfT2
 RnYSvamJXiiTR8SmAXzGv14j6p+3RvQJltlzZyAtdSmhU1c02dvSEGBUi7C8CQGpezwuB+sgGRXogT
 oO2SbXKlaHSKpyJIZJXiMsLtD5YtZ8V2YOtZoQFLpRmrK3FcoCHpdTM+7+Qg==
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

If the system is restarted via kexec(), the peripherals do not start
with a known state.

If the previous system had enabled an IRQs we will receive unexected
IRQs that can lock the system.

[   28.109251] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
[swapper/0:0]
[   28.109263] Modules linked in:
[   28.109273] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.15.79-14458-g4b9edf7b1ac6 #1 9f2e76613148af94acccd64c609a552fb4b4354b
[   28.109284] Hardware name: Google Elm (DT)
[   28.109290] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
		BTYPE=--)
[   28.109298] pc : __do_softirq+0xa0/0x388
[   28.109309] lr : __do_softirq+0x70/0x388
[   28.109316] sp : ffffffc008003ee0
[   28.109321] x29: ffffffc008003f00 x28: 000000000000000a x27:
0000000000000080
[   28.109334] x26: 0000000000000001 x25: ffffffefa7b350c0 x24:
ffffffefa7b47480
[   28.109346] x23: ffffffefa7b3d000 x22: 0000000000000000 x21:
ffffffefa7b0fa40
[   28.109358] x20: ffffffefa7b005b0 x19: ffffffefa7b47480 x18:
0000000000065b6b
[   28.109370] x17: ffffffefa749c8b0 x16: 000000000000018c x15:
00000000000001b8
[   28.109382] x14: 00000000000d3b6b x13: 0000000000000006 x12:
0000000000057e91
[   28.109394] x11: 0000000000000000 x10: 0000000000000000 x9 :
ffffffefa7b47480
[   28.109406] x8 : 00000000000000e0 x7 : 000000000f424000 x6 :
0000000000000000
[   28.109418] x5 : ffffffefa7dfaca0 x4 : ffffffefa7dfadf0 x3 :
000000000000000f
[   28.109429] x2 : 0000000000000000 x1 : 0000000000000100 x0 :
0000000001ac65c5
[   28.109441] Call trace:
[   28.109447]  __do_softirq+0xa0/0x388
[   28.109454]  irq_exit+0xc0/0xe0
[   28.109464]  handle_domain_irq+0x68/0x90
[   28.109473]  gic_handle_irq+0xac/0xf0
[   28.109480]  call_on_irq_stack+0x28/0x50
[   28.109488]  do_interrupt_handler+0x44/0x58
[   28.109496]  el1_interrupt+0x30/0x58
[   28.109506]  el1h_64_irq_handler+0x18/0x24
[   28.109512]  el1h_64_irq+0x7c/0x80
[   28.109519]  arch_local_irq_enable+0xc/0x18
[   28.109529]  default_idle_call+0x40/0x140
[   28.109539]  do_idle+0x108/0x290
[   28.109547]  cpu_startup_entry+0x2c/0x30
[   28.109554]  rest_init+0xe8/0xf8
[   28.109562]  arch_call_rest_init+0x18/0x24
[   28.109571]  start_kernel+0x338/0x42c
[   28.109578]  __primary_switched+0xbc/0xc4
[   28.109588] Kernel panic - not syncing: softlockup: hung tasks

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index 65d312967619..27f0a54e12bf 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -303,12 +303,15 @@ static struct irq_chip mtk_eint_irq_chip = {
 
 static unsigned int mtk_eint_hw_init(struct mtk_eint *eint)
 {
-	void __iomem *reg = eint->base + eint->regs->dom_en;
+	void __iomem *dom_en = eint->base + eint->regs->dom_en;
+	void __iomem *mask_set = eint->base + eint->regs->mask_set;
 	unsigned int i;
 
 	for (i = 0; i < eint->hw->ap_num; i += 32) {
-		writel(0xffffffff, reg);
-		reg += 4;
+		writel(0xffffffff, dom_en);
+		writel(0xffffffff, mask_set);
+		dom_en += 4;
+		mask_set += 4;
 	}
 
 	return 0;

-- 
b4 0.11.0-dev-d93f8
