Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBB8661A42
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbjAHV5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236244AbjAHV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C9A1BF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ja17so4992541wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOkszWL1f9GVml0746jDT8yMPEtjrokgHcFXyXEm/8s=;
        b=gHvlwGyyqfbIoMsGj5XtztPSaWHbWKuWNYBVEPCt6YD/lvMyYgWpMagqH0fvxj4b8f
         DRhYN2LHpPxKxBNvTs5KFhe/pPNinrNMkwsGgM/AGr4Rb4dazkLfv9kplmGO4SSUkNwC
         wqKbkCwPrU0yJtEI5adnM3b9NQD45fOSqUqnXHz8OW+CAuafP2Kb/I/XLoe9Twi3RbBH
         8oA8DkjMjMNGDsMfp8DwkH3NGspLV7MC2pe/dh0vDEpYFoWeJLEsf+y/8iDhu9iAl5cf
         n6K5ohp/2WKkUHhbWuHTjWeANMpWfHq0rYv827OMzlOT7J636eAgcPjCMUusVnn+6t29
         153g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOkszWL1f9GVml0746jDT8yMPEtjrokgHcFXyXEm/8s=;
        b=14F2XeViVBplE6YHdvrMGdz1CaDyXRH8ktqDexh+MWQxtHoSzSYUqg9+THZCdyO7By
         Np7OVG+0uhUZWk0RH+yuZzhV0l27mBLjZRcus0NdeC8QSlYIyVo1Ce/HI1cnyoOSQs0J
         PBvn6c7512FstbLpSXw71cfJ3lws6y8IibUjiwXrwksB66pbXsOxKgQ2AKnUZBe96Uy3
         wHV871itpsAx+cd0jTqb5SFp7bJuVU3nIsrLtb3/sTFBeXmWi7AQasAhPW1D0/L6v+VI
         2Thf7nDGJOckjVgvWK0zbBU5UFxJ7Uc02KtUTNdPZVNBqKuwNtyxXxv31w8Ngw96RTim
         7kNg==
X-Gm-Message-State: AFqh2kqI/8hSxmMmO2tvhsITtd45IFeD8mhPP4rZ8M6HVKELdN4FV8VA
        EkUgmb6LYvLG7oHlAwvA4NA=
X-Google-Smtp-Source: AMrXdXtVfoEpBgeNekkkNi55q7SX/k+Pmu7LFSOvEqslPJsI9x1RuNB61fEPLJKybrzzQwaeSW2EyQ==
X-Received: by 2002:a05:600c:3ba7:b0:3d3:4dac:aa69 with SMTP id n39-20020a05600c3ba700b003d34dacaa69mr44428516wms.36.1673215029870;
        Sun, 08 Jan 2023 13:57:09 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:09 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 7/7] parport_pc: Limit the number of PCI BAR pairs to 2
Date:   Sun,  8 Jan 2023 21:56:56 +0000
Message-Id: <20230108215656.6433-7-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
References: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
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

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

Decrease the number of PCI BAR pair slots allocated for port subdrivers
from 4 to 2 as none wants more than 2 at this time, reducing the memory
footprint a little.  No functional change.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index 9b4fe9a2b549..88e125e36230 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2657,7 +2657,7 @@ static struct parport_pc_pci {
 		int lo;
 		int hi;
 		/* -1 if not there, >6 for offset-method (max BAR is 6) */
-	} addr[4];
+	} addr[2];
 
 	/* Bit field of parport modes to exclude. */
 	unsigned int mode_mask;
-- 
2.30.2

