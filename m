Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798E6AE44B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjCGPR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjCGPRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:17:30 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1918874DFF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:14:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ky4so14434281plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvfvphEax9rDC9DBLoGwM3hS+dg6woN4JsLGnKLFC0E=;
        b=dnD8dpvLQps1mmGsFHbmc5wqxPYOJR1C4dW+iS7wU3VI3KF8COlTX5UZqZ8ZRb+yg0
         Qd2+HV0bNKXywkv9wJedtnX3537K/UxMvEZRU8M6WOQqSsfmabTeURTuiCyCQMHaOzM0
         EcLzc/fvqN5lUxrSMeIP7Ux983eK7541XwBTAk2Cx0tDnF9SkpYbp235ZZG6A0e7hcd5
         MzDFVIihEUdy2F97W33zUVIwNY0J+zahzQ2Cg3+gHoTlSrYxur3C6q1RHm9YLjr2XTBK
         PzMXt8vZ+ACXtZXO0ggi++CPlPtiQcIDCfzl/g5Y91wWfpjFj8rFz2QPHFOs68A0qkAR
         vUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvfvphEax9rDC9DBLoGwM3hS+dg6woN4JsLGnKLFC0E=;
        b=IV6pzjNovSQda2hEDsb4NFvHjBhipWJveo508j5J9hDv1B6c468sRKi+NTIzvROkUg
         oekovbb9RbN6t/cSQAB8Uh4ey2PaE5Lbjmb6mZhFv5mo0iOZaef6LNd9+KR4InDn9ykT
         0z8yTbOIArFvm6Jg95gHOu1CnbF5/MznYxPvA9l1Qjre4QLChMqNF86eatsXK8wFhKBu
         +E+0Al7H3y/mz1yxJAkuDK8iWO66sA1lmFRLRa+07uzZwqRlhCDc4UD7NYs27ZgU430L
         0mhw+b6YS0fTMR93aVuwIiNsRN95SQmunLP6+mLBnFudNO6OBbERjtFNxdE88LRLyCQD
         UUeg==
X-Gm-Message-State: AO0yUKWrhC8QxReW7ZlrFRfWmriNboIHdBI5VjqVry7/ZhrqIl2BKg/d
        UkU3d8zt1ZNLapUDbNpDMHOjeiDJcDw/Q2Rc1w==
X-Google-Smtp-Source: AK7set/sLdrolS6AecmD6tHXDxRV1zlmbLFHu0nL+yR7wuazTgILajS6RvEZijHARHtWQksfpJyZ7A==
X-Received: by 2002:a17:903:1205:b0:19e:f315:98c with SMTP id l5-20020a170903120500b0019ef315098cmr373395plh.57.1678202071604;
        Tue, 07 Mar 2023 07:14:31 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090340c800b0019c2cf12d15sm8549332pld.116.2023.03.07.07.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:14:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/7] PCI: endpoint: Warn and return if EPC is started/stopped multiple times
Date:   Tue,  7 Mar 2023 20:44:11 +0530
Message-Id: <20230307151416.176595-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
References: <20230307151416.176595-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the EPC is started or stopped multiple times from configfs, just emit
a once time warning and return. There is no need to call the EPC start/stop
functions in those cases.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 4b8ac0ac84d5..62c8e09c59f4 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -178,6 +178,9 @@ static ssize_t pci_epc_start_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &start) < 0)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(start == epc_group->start))
+		return 0;
+
 	if (!start) {
 		pci_epc_stop(epc);
 		epc_group->start = 0;
-- 
2.25.1

