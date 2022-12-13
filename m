Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31564B815
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiLMPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiLMPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:08:49 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F369266
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:08:48 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d14so18101140edj.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmCSRNYWGRh53ANKHIG9zq2BxJtN1OCNfzLk/Oj3LyI=;
        b=kguGhTJ+Ndrw26kfqS1x05TdFZofEt0wYOIaG0NPY+Zl9ZuQLI4hkznOrhzIPa5YGH
         zfc0Tx0gqFBz84QCwZamDYAyq0aw0MMfgCX8/2cgXZKiQ8KOLco2cKreU4dyfaHoH/O7
         zNYYrRAxWPyBxPkcB9HbWzkQMnxQf0RK+Mmg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmCSRNYWGRh53ANKHIG9zq2BxJtN1OCNfzLk/Oj3LyI=;
        b=z56qPZD7jVF7ImV0njLg0xIH2tEc0jLlwsM8Q1o/VBPfVNDJJ4i/+j731ANnfYui1n
         SRRxmsSzcmHW9+gZgGtJgyUkBu7vtkU8OZhCmR8zqS6cJx/MpO+tN0PMSNE+5jlXTvuj
         CqOUn13avB+Wfg3HKifQ1XpCV0GH7V6nWnjlOvCRllsqlzb3f6TPdEbM4iMtsEQRU/i7
         w3GJoS2X4jVV7D/JB4PaMZWFojKmuHfuI8GAquAVoLpmkZDb2g5eH4H0y6WA5Rv8n4SU
         8sSyV5VxocqCaRRFk3Tx5Yb4y/Ju094ELUO+fphd5Pqn0rFyfKXWtuHWRN8CToN33nWb
         iafA==
X-Gm-Message-State: ANoB5pn2cJinCswm2ltLJX8+cx21OuZoKnmjvngU4I4S1TRyacip+8Tr
        2l/r/9gMBUS5s/tjSnucJKmBkg==
X-Google-Smtp-Source: AA0mqf58O4Ns2Pwe7vT7aqwJgWWVvv3vGYdcJGMxOQCS1foLblD+NNjkGuZh7h11Cq1hfhivDgWaNw==
X-Received: by 2002:a05:6402:3710:b0:45c:835b:8fb3 with SMTP id ek16-20020a056402371000b0045c835b8fb3mr15637831edb.30.1670944127112;
        Tue, 13 Dec 2022 07:08:47 -0800 (PST)
Received: from alco.roam.corp.google.com ([100.104.168.209])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm5070258eds.40.2022.12.13.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:08:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 13 Dec 2022 16:08:22 +0100
Subject: [PATCH] xhci-pci: set the dma max_seg_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221213-xhci-max_seg_size-v1-0-608f716a3792@chromium.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=dnER4XXok/jcs6u5Dn/oTOUm9ImEIHCydXeSr3eDf9c=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjmJV3L8s4WP9dFOY1ICJVhhrMxiLx29uWVGYiOrZu
 Y1rzt/iJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY5iVdwAKCRDRN9E+zzrEiKtsEA
 CVdiyfiAKrzrdAgVEZHiEXJ7k2+96oeUwCVcF6vuON+IVpDOiU+vqSlv6dqjugCwaA1OuSDZYOD/dd
 bYQnJcG7YrMpKHTQsd0qRaf/f5/KxTL+M7q/5y17hp86PH6vKhofJpNRoXLXgqab1C6V09ZQMljaqC
 2bOAkCoD12u2dkAVAiUJNZCo7ITTUK6f6wgtl1WlFmwcZilRxW00ZvP7M5zU54zFwtibJ/Lgm+tOlc
 Vvj2K2FffEbe/yLllbXN7mqsAGqoVAvAP+Ppv5IfyTRabQ9HLFxkiqMRDM1QgS9WmrERFbGd4iCJYH
 EAKgJolrnarFIa6OiGmve9AIPcMaLl2IWSR3RNrOGq7f/uuO/+Ja15ZrrG+WXVrLfXQ8y4HLS+JSmo
 dHZrPuIX25VinT1dXf7hwmJqv6hOEZGyLeRoIzN9d4D5ZXmFq+1N46WOh332GmBmQ7AtOCbOeKBiZH
 Sy/800gqdF4yxGePFiuiV0mUzrj7TZkXbx9DPmRfV1uyc6coNfdNuK7R2VnUSEuc/9xcKH27XAZ6Ch
 0hGXtJdRc5o6HAetElUHajHuJbAM8kFIHnZaUC9QY9cJYabPIG2YP88sqr78/ed0NGHALRLL1929jc
 fNquFZe/9Y/KdiWsDSTEd17gf1JLko2iYGBcm7hwQI6bCOqsk+sKI/7nNsPQ==
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

Allow devices to have dma operations beyond 64K, and avoid warnings such
as:

xhci_hcd 0000:00:14.0: mapping sg segment longer than device claims to support [len=98304] [max=65536]

Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
To: Mathias Nyman <mathias.nyman@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/usb/host/xhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 7bccbe50bab1..116a2f328772 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -453,6 +453,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
+	dma_set_max_seg_size(&dev->dev, UINT_MAX);
+
 	return 0;
 
 put_usb3_hcd:

---
base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
change-id: 20221213-xhci-max_seg_size-de366fbf12bc

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
