Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA026A18A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 10:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjBXJUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 04:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBXJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 04:20:49 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1E111EAD;
        Fri, 24 Feb 2023 01:20:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id pt11so16449481pjb.1;
        Fri, 24 Feb 2023 01:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N08NCmCCZX/PJaf98DfIoxPh9MJw6PLJ74Y+IJaNRas=;
        b=WPXmFVhVxXL4cESNapaCfjjEIWLdVPqtWXmNr0z8Hprm4/vjWCGung/SzAcwGNLSsu
         l/WWuahIwkaexuiCpZ3yrhnhaoK1kZ9wfZn9fwDOITE4HRYuFhXPRmz6rWKvnVXOb1Ur
         Yx5wjYTM37da4ZkFfm8CsRWQ4hRlNa9jlsoCDP4E2imNOEqphQSCEfnogBFaACiO/hKc
         bdBmCbD14xQDaS0sbnz3mcceL0qtCKgq+S2gZOVtMtT1apyMtvwTBOPSR/yEFS0iMMmf
         vxk9QCh/jlhpcL+TRWH2Oj7Qvu4tWa/TACgorhn4+AtXxFVc/LwFKxxHv4YtdaCugrJh
         xE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N08NCmCCZX/PJaf98DfIoxPh9MJw6PLJ74Y+IJaNRas=;
        b=mC4hNs+mfU49R7Lr44RMbV7hjgp4ujGnBBTaRY4LZx9iloE1t7HR5obeaWmHYTd4na
         1/a614wUP5+EFW7LBjuKxz6fucMFipeu6ttR41j7mbThS10oXJFZ/1J3oLqza/btoY7n
         s42hx/P7W70mV/ym3EYmQdJ10kQfCIbqZn8+2aIOm2RLY9RbtRyYEzO6UPYk3k4+zX4U
         aVdM1b3uIraQWQU7DbNoXpn9wSBwy871zEUhyn70YjMuK2hD/BGhuZDINUn4dbF0QAEO
         OW2d+eaRjiUSCONKDB4gyrLp+n6ds2qWS/Ag1NaaCDyHs9fPfmrkZpcSSQJcGUrD1DKv
         jI+g==
X-Gm-Message-State: AO0yUKUvuzpcLXi+IzQxD9TKvgnBjI6U/5/LfOLYs2Ox41U10hcAoK9I
        VgoTrMiRKQKRelCR3/R5aV0=
X-Google-Smtp-Source: AK7set8WlnBE1VyZe/i8iGP2JlYtRk0vxI0icGIx2VuSCi8Fs2kZT7A5HmBJPFd6vKde+jw/D7mqhw==
X-Received: by 2002:a17:90a:f0f:b0:237:8fb4:4bcc with SMTP id 15-20020a17090a0f0f00b002378fb44bccmr1791153pjy.27.1677230448098;
        Fri, 24 Feb 2023 01:20:48 -0800 (PST)
Received: from passwd123-ThinkStation-P920.. ([222.20.94.23])
        by smtp.gmail.com with ESMTPSA id be1-20020a170902aa0100b001991d6c6c64sm6467751plb.185.2023.02.24.01.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 01:20:47 -0800 (PST)
From:   void0red <void0red@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Chen <void0red@gmail.com>
Subject: [PATCH] usb: gadget: udc: add return value check of kzalloc in mv_udc_probe
Date:   Fri, 24 Feb 2023 17:20:44 +0800
Message-Id: <20230224092044.3332374-1-void0red@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Even an 8-byte kzalloc will fail when we don't have enough memory,
so we need a nullptr check and do the cleanup when it fails.

Reported-by: eriri <1527030098@qq.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081

Signed-off-by: Kang Chen <void0red@gmail.com>
---
 drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index b397f3a84..6dd6d52de 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -2230,6 +2230,10 @@ static int mv_udc_probe(struct platform_device *pdev)
 
 	/* allocate a small amount of memory to get valid address */
 	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
+	if (!udc->status_req->req.buf) {
+		retval = -ENOMEM;
+		goto err_destroy_dma;
+	}
 	udc->status_req->req.dma = DMA_ADDR_INVALID;
 
 	udc->resume_state = USB_STATE_NOTATTACHED;
-- 
2.34.1

