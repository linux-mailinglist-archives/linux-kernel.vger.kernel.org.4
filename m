Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E8A611C59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ1VT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1VTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:19:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00B24AE1C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:19:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h185so5868842pgc.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3rdludOurvC4fVB6DK3mkTjnKTmpaPqFr2e/WcU1PY=;
        b=Ba7p35/O4HWTJ6gXbkKVc218UyBTKXLiCvsaBmMU9S9QH0SSlKGUaCiXW8I9NYRB33
         EweO63dvPYeifzge13DmYlNPALfhSgTjMQR0KaVKRHjFlIbzijOPwCc/WlxEdAZFUG/P
         bgx7kY6bca4Hfm3vWZGLThlemm7c0jMCm53RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3rdludOurvC4fVB6DK3mkTjnKTmpaPqFr2e/WcU1PY=;
        b=xCMdB7b23qq4yP4lYffwyN/YsG0ljZDQ9pyawbttySoPhUZJgTgc8zam9wH8SMxI/c
         fP0MInPbwzMh/Ylty7F7X5V+tUvT0EcwY4+yLATq+n0L694b475/5YBNN+9ADwVHi/ZU
         Tfp+mn9CZ0vSOopxewHFgWEFhOPfGG00thTM+QEYxwSgsNmu1Ieab9qiDRE+6WDRvI3G
         zfXLtfGzfpOdEjKxhlcRKyA1Vrmm0msjqJOc3O2qs4ra6sMSj4VcevOA6RyQRnjxNaBh
         t4iQd26A3xEHGYA3PH39qCu5jWxNLRsvU86ibElt1/fomT6jY+T2oRQUyhXTq9FeLAee
         5/9g==
X-Gm-Message-State: ACrzQf0p8Wf9eUHv8cWx5gou9CGYl09ZPMuLqT9qZQ6mYc/niUyu9e/s
        GqpxlqGdgT1TJuBGh4N0hAzwdNtsFZFVbw==
X-Google-Smtp-Source: AMsMyM6zyE4Kj02pCtPhqS5WKSQqcPsl7sXyYtaqdOEufXYwMr32tdQJVAgcIbgLy0QuXLyErok1Hw==
X-Received: by 2002:a63:1a07:0:b0:46b:2825:f9cf with SMTP id a7-20020a631a07000000b0046b2825f9cfmr1342652pga.370.1666991959465;
        Fri, 28 Oct 2022 14:19:19 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:65f9:c180:249c:190f])
        by smtp.gmail.com with UTF8SMTPSA id f2-20020a623802000000b00550724f8ea0sm3250546pfa.128.2022.10.28.14.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 14:19:19 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/2] usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS
Date:   Fri, 28 Oct 2022 14:19:08 -0700
Message-Id: <20221028141821.2.I5a309231785d3a4e37118a25e84f5caa0136a343@changeid>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028141821.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
References: <20221028141821.1.I9a5353f81d1509f85f3a04f0cdc9099f6fe60811@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver often takes on the order of 10ms to start, but in some cases
takes more than 100ms. It shouldn't have many cross-device dependencies
to race with, nor racy access to shared state with other drivers, so
this should be a relatively low risk change.

This driver was pinpointed as part of a survey of top slowest initcalls
(i.e., are built in, and probing synchronously) on a lab of ChromeOS
systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/usb/host/xhci-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 40228a3d77a0..4da03de1be70 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -689,7 +689,8 @@ static struct pci_driver xhci_pci_driver = {
 	.shutdown = 	usb_hcd_pci_shutdown,
 #ifdef CONFIG_PM
 	.driver = {
-		.pm = &usb_hcd_pci_pm_ops
+		.pm = &usb_hcd_pci_pm_ops,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 #endif
 };
-- 
2.38.1.273.g43a17bfeac-goog

