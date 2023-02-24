Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B296A1C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjBXNC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBXNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:02:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903D40EA;
        Fri, 24 Feb 2023 05:02:51 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z20so2516598pfa.13;
        Fri, 24 Feb 2023 05:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4kmb//j1ktNG8kl3LbBuVMKD6p3YK/069wRAvDgHWw=;
        b=mEd284bJCKom9xBLW2zOrmCT8xA5odpc9QjO3PA2QljSYGVDQeV4mXvDJYOnXaSaW2
         o8M4kuiwCDEpjemKSh1o8DJQSf5Mxt25/flaGMlhTvKK0WjaOMS9NE1x9GUXpzbSq0MF
         Pg90sZ/gQxTavGe+wiEK2MUockzdjrmNA5/B2Ux80v65qrXamhV8Ez29W1cD/geAhPzp
         QMTeU+aNmldJNLEuWvY0ZMEXDAOwHU2piSYVbfZ4fUxZUwmPSsmQpZn5/rWZhKdWfHWK
         L4Oz/WtdkKvh+LhMNGODQAveeL7V/eP3hE4RcQA7ngnG2GhlhjKJ2eXFWuuyJpQifAuS
         02kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4kmb//j1ktNG8kl3LbBuVMKD6p3YK/069wRAvDgHWw=;
        b=hGShIhNPuQIeYPhLdhdR97v5XJIUI2Hh71pIJ0+l3/EEHie3xOeHEltrDSykYwoTWx
         vbwRqk1W8U5mM5reB+SUj32btkQfCkqqqneH+MVEjyhfe+7EX49f61UW+fCse6apytB0
         JKE666CGBIkvhE70PtGDZ7VqwyjD2qr1+64zv2wMTGG7JZWD7H0301v98kmPSyXXBxvG
         jElQcVO/n4dB2BEWrg4+IFiRUXoA83AszS8KtprPZFC1qldEr6NOWhWqCLXDpk4hUz6a
         rNDARGqijZaVGKAjM+g0iKiELzJTt1SQTrOiAw9rGTNn6Zrx77PiGlerBBUOS9ZAonjc
         l1vQ==
X-Gm-Message-State: AO0yUKVmccAXl23ouLMB6bgyPc+h40eN3f99rt8nhi2LxDoMcFFIJkoT
        kMqzSkXXIbP6VL2YlWKHcok=
X-Google-Smtp-Source: AK7set9JNZ+z4Pw5WWyTxCy35IDfUE/pXuaEz1Oa82RSwh1QPzoVZ5qthKPToi6qWCFxhYMazdfc5Q==
X-Received: by 2002:a62:17c6:0:b0:5a8:b6cf:1a74 with SMTP id 189-20020a6217c6000000b005a8b6cf1a74mr13215268pfx.18.1677243770651;
        Fri, 24 Feb 2023 05:02:50 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id i13-20020aa78d8d000000b00592626fe48csm6545241pfr.122.2023.02.24.05.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:02:50 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     mudongliangabcd@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, void0red@gmail.com,
        eriri <1527030098@qq.com>
Subject: [PATCH] usb: gadget: udc: replace kzalloc with devm_kzalloc in mv_udc_probe and add a check for this allocation.
Date:   Fri, 24 Feb 2023 21:02:35 +0800
Message-Id: <20230224130235.4028566-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com>
References: <CAD-N9QX5i5toj8cs7DxBjYWtRGf3ZRnfTAf809sFW6iX0Ktfmw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Chen <void0red@gmail.com>

This driver uses the unified memory management api, so replace
kzalloc with devm_kzalloc to avoid a memory leak and add a check
for this allocation.

Reported-by: eriri <1527030098@qq.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b397f3a84..08474c08d 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2229,7 +2229,11 @@ static int mv_udc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&udc->status_req->queue);
 
 	/* allocate a small amount of memory to get valid address */
-	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	udc->status_req->req.buf = devm_kzalloc(&pdev->dev, 8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		retval = -ENOMEM;
+		goto err_destroy_dma;
+	}
 	udc->status_req->req.dma = DMA_ADDR_INVALID;
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
-- 
2.34.1

