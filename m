Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B195B62BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiILV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiILV3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:29:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9474A81B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:29:05 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3496e668a5dso17880757b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=mxPU3RrXnbJ1WXb6Kin68nj36f2XNWSY+VuVvzRvyEk=;
        b=ho/udzQ1QwBPrL+l4lPxAGUsHZmchvUPQehgWyBn+SR92V2PaL0P66O1BjkjAFjVyS
         WySl7GCaFhY90IiNxtck4h8oFOAWvlP9tapWEwETZMkUuH/onb0lekOI9WR4DQySM/xl
         rh+rFhxH24KJYMa48SUw/KEzM7uwCKVF90xVf8lhp8+AgZ2rPRVjMXfJibgr4jTEuuOU
         32OQ1YIt81DKsn0QysexyfxUQOEJAyeDfuufX0Y9/h8Ke3zJy7hK8SFBrqP/dCc4tJTF
         ngtYRb9ls9lYXHl0LZx9cB4ONa+IagbfWMOtmUZp9GGmfguzTh2OctNsyyf3jMmERGQM
         Qexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mxPU3RrXnbJ1WXb6Kin68nj36f2XNWSY+VuVvzRvyEk=;
        b=t1xmHiK7PcRZXOERb3OWE7M0bycEIF7AvJBWc0ZFc9aWNN5Ai50k/G2mebVAo5hPlU
         AEBFoyINy50gmGnRsyoqwB3u+W/+CN3NpxePGtLf0Bnyyzpj/UN00EZ86/S/KJ76arEa
         xNYm7xjCjEi9+Z5hKqP54W6SsQ8XJWL7AGb4RK9YzLRncipDYQz9BwRi/fdl6tsCc7f9
         3LOfY5inWGZxBEgBYfnz+UVimXOFOd7OWcF06OiLhgQTkR/PapFx5uhLb5LVvm3BcYwz
         Bwx4cJndZQ5f0UiKu/rKK7/pJ9U4YNHES1dQrOBKRzSVVdLeZNoq0dxiKBE69sPmGw+K
         7oHw==
X-Gm-Message-State: ACgBeo0aoYF6hExr99kuaHQoIKfeNYaTyJG7IzzN7zQzTq4UkZXuLdsH
        HCuZ3lXxauCFatDCmTr3vKcSVW0=
X-Google-Smtp-Source: AA6agR6YE+RSwmk0iaq48+VyoAumb8My8Fi+5JunqR9z5dNQL2jD3vBbU5RMgxSZHYil+Pd5hNhaMKQ=
X-Received: from ptf16.nyc.corp.google.com ([2620:0:1003:314:e24f:43ff:fee6:db57])
 (user=ptf job=sendgmr) by 2002:a25:2411:0:b0:6af:2407:ecfa with SMTP id
 k17-20020a252411000000b006af2407ecfamr5440196ybk.10.1663018145243; Mon, 12
 Sep 2022 14:29:05 -0700 (PDT)
Date:   Mon, 12 Sep 2022 17:28:47 -0400
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220912212847.1337868-1-ptf@google.com>
Subject: [PATCH] mmc: sdhci-pci-core: Disable cqe for ASUS 1100FK family devices
From:   Patrick Thompson <ptf@google.com>
To:     Linux MMC development <linux-mmc@vger.kernel.org>
Cc:     Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>, ptf <ptf@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ptf <ptf@google.com>

The CQE implementation for the eMMC in the ASUS 1100FK family of devices
is broken. This causes installations to fail and thus we are disabling
CQE for this family of devices.

Signed-off-by: Patrick Thompson <ptf@google.com>
---

Hello,

I was hoping to get some advice on adapting this patch to target the
eMMC directly instead of a family of laptops. One idea is to use the
PCI-id of the controller (in this case [8086:4dc4]). Would that make
sense? Is there someone with more knowledge on the subject that could
confirm that the [8086:4dc4] device doesn't have a working CQE?

Thank you,
Patrick


 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 622b7de96c7f..3ba0250559e7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -890,7 +890,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
 {
 	return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
 	       (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
-		dmi_match(DMI_SYS_VENDOR, "IRBIS"));
+		dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
+		dmi_match(DMI_PRODUCT_FAMILY, "ASUS BR1100FKA"));
 }
 
 static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
-- 
2.37.2.789.g6183377224-goog

