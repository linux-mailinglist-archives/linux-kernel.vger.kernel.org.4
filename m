Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87A64B702
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiLMOMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiLMOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:11:21 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6421255
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:10:34 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z13-20020aa79f8d000000b00576b614b7d2so2130168pfr.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MKI07Bx0MT4z42ihUE6Ms1XD+dup6KrK+Vea+qzaT8o=;
        b=rY5gG2Ir0bwLKC240UeBvFVur1c/4YpMgDS5iaNAtxBXer2SEpIADomFcS+TypZdlC
         gkeQIaiS6z3TZbTHAdjZYch55Z0DDUnWvLdburjIXT3n4wIrOxklAXRDQLtTcMVXFlC8
         ECbfIoJ6uxcYjlXlATeMxQdIbGwgdyN2548vWVmy1rpRFVIxVHaM27dfDgfU1zunkSlv
         Izd9BwW3HOj0bl0Cyxj4pASAwO845iNzolWve6lbUGi0c4UGaVUrhzAW7+oTcXwb/igD
         +WvSHbrLdVC8gTQvF/WDucwaK+1nDs7notdjny0Qh2WTFf6oDccsp1rNNPYl6STK9Pz9
         hd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKI07Bx0MT4z42ihUE6Ms1XD+dup6KrK+Vea+qzaT8o=;
        b=zfP4T3oR8cgF30hUt/tJwyynI6Cc9wx2kAijQt7A8ymZIlfpU5/KQ15jF8WY0AUYtf
         HL6Vi6EvwafCqJ4w5+QYT8p68QOsuu/pKWnyIkBHWJjQuqa+gJsBYr90+mNC+wRULZlU
         E2yd5dW+rKRz9vzyHKMgUkkOoDX1RS4Yq7lntzk1u5oKNrC8qSjRyGy18FQ7qBaeaJ/C
         xSe71WdMtnoRGZGSwM+b63TMZi4VxqEAFlAkxfSjNpkDpkP0XSpwuB3Gt90GxTmr2BZx
         n/DF49ts6PrMW+5A2vHUstxMuhGQaOvJi9lANIm2oYGO/x7m/QsPMlAGP66h9c0/NjoB
         jRPQ==
X-Gm-Message-State: ANoB5pkutb+47u3WK0PXz2nk0jS3XxOkOy5oryBKeIMDuYZ1TDXhIRT0
        Vc0Mi69oylES6mVAoE+izqhuD9bwKITAz/Iftv4=
X-Google-Smtp-Source: AA0mqf4ED9AjZvtuotnnanTk1xUkXF09so4t5LMDhw646LjDd+sbIc63QDGMrIyBbxoWYh7eG4Q5e367VTb2GwrDLJE=
X-Received: from albertccwang.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:83d])
 (user=albertccwang job=sendgmr) by 2002:a17:90a:8407:b0:21a:150d:fe63 with
 SMTP id j7-20020a17090a840700b0021a150dfe63mr446633pjn.73.1670940634139; Tue,
 13 Dec 2022 06:10:34 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:10:04 +0000
In-Reply-To: <20221213141005.3068792-1-albertccwang@google.com>
Mime-Version: 1.0
References: <20221213141005.3068792-1-albertccwang@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213141005.3068792-3-albertccwang@google.com>
Subject: [PATCH v3 2/3] usb: xhci-plat: add xhci_plat_priv_overwrite
From:   Albert Wang <albertccwang@google.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, howardyen@google.com, pumahsu@google.com,
        raychi@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Howard Yen <howardyen@google.com>

Add an overwrite to platform specific callback for setting up the
xhci_offload_ops, allow vendor to store the xhci_offload_ops and
overwrite them when xhci_plat_probe invoked.

Signed-off-by: Howard Yen <howardyen@google.com>
---
 drivers/usb/host/xhci-plat.c | 20 ++++++++++++++++++++
 drivers/usb/host/xhci-plat.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 2f04acb42fa6..11ff89f722b7 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -173,9 +173,26 @@ static const struct of_device_id usb_xhci_of_match[] = {
 MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
 #endif
 
+static struct xhci_plat_priv_overwrite xhci_plat_vendor_overwrite;
+
+int xhci_plat_register_offload_ops(struct xhci_offload_ops *offload_ops)
+{
+	if (offload_ops == NULL)
+		return -EINVAL;
+
+	xhci_plat_vendor_overwrite.offload_ops = offload_ops;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xhci_plat_register_offload_ops);
+
 static int xhci_vendor_init(struct xhci_hcd *xhci)
 {
 	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+
+	if (xhci_plat_vendor_overwrite.offload_ops)
+		ops = priv->offload_ops = xhci_plat_vendor_overwrite.offload_ops;
 
 	if (ops && ops->offload_init)
 		return ops->offload_init(xhci);
@@ -185,9 +202,12 @@ static int xhci_vendor_init(struct xhci_hcd *xhci)
 static void xhci_vendor_cleanup(struct xhci_hcd *xhci)
 {
 	struct xhci_offload_ops *ops = xhci_offload_get_ops(xhci);
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
 
 	if (ops && ops->offload_cleanup)
 		ops->offload_cleanup(xhci);
+
+	priv->offload_ops = NULL;
 }
 
 static int xhci_plat_probe(struct platform_device *pdev)
diff --git a/drivers/usb/host/xhci-plat.h b/drivers/usb/host/xhci-plat.h
index 5aa0d38fa01a..0656d6daa194 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/drivers/usb/host/xhci-plat.h
@@ -22,4 +22,11 @@ struct xhci_plat_priv {
 
 #define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
 #define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
+
+struct xhci_plat_priv_overwrite {
+	struct xhci_offload_ops *offload_ops;
+};
+
+int xhci_plat_register_offload_ops(struct xhci_offload_ops *offload_ops);
+
 #endif	/* _XHCI_PLAT_H */
-- 
2.39.0.rc1.256.g54fd8350bd-goog

