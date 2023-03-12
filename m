Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2757F6B63E9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 10:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCLJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 05:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLJHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:07:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895A3B223;
        Sun, 12 Mar 2023 01:07:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h14so8723824wru.4;
        Sun, 12 Mar 2023 01:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678612069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LH/M3cso09ywcoLugxoDXWjh29NuaE9CRH1ycId3RM=;
        b=RQ11GhX4BFnjzENPJ9aXbi6LxYBjB3qKGUT8PW7MHvTI8oYxJnkfUjY/YYiTwDlWDi
         zrANA0N7m3RpzJMHBb/VZ5fgDF7N1oK430Yp/e3JgKziC3VEjWK4+TmxuNfKaWbP73xd
         uSRxZkKr6RtzLFgGXd5V9Xk8Ly6Egz7HD3q6Uz26wLKAO2Hg0lFd1O/HP6iuQ5/7tsZU
         B01tmWJIjd3VngsAbgC2Cn0C20d4IT4pu36jyVo6uj8zV2a0FBCx9YSu7SNh7/WuS6Aw
         t3fWI+75MYTK4jr4/E93DUqk+hyIcpjyhVjT2V+sKDLJUGQF4W3binAf5glza/MuPBvl
         idwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678612069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LH/M3cso09ywcoLugxoDXWjh29NuaE9CRH1ycId3RM=;
        b=e6gNqUVZrcfwLVtdYbQ2eRrHEY9ndATI8sxE737O8qae0F25can9kzS+LDIpbcd2WS
         X+hZCtRQiCM357e/sGC3a8oDZhg67d1Hgrx07stcpXQYRWMkJWFNU+2R0lRldU0YHga+
         ZREFPVvWEBefA/CmD+PjBJ6g5Xe43nGc5+M+nU6EAlgkqpetYq/o8hRHOqP5aj1+ElX1
         h+HTZ87N7vaNZKySqEED2AZKGEkTeXYvnR7LNBaQuSdXUXhzPYH896rwhaLPgZ7UwN+Z
         Hg2GSuddj/re4u+1PpR/AM27Yh1v0yqepx6l2YFDtY59gp8t0KssSt9n1uxYBfpICiro
         gBtQ==
X-Gm-Message-State: AO0yUKVNvRiQza1il2Yjah19Rofx16a9BGlUspcAOAbjhJabN13o9nRU
        Tv2Thwk5bn0FrmVniWXo0bA=
X-Google-Smtp-Source: AK7set/QMrKLsbwNFgoemgJjvcnvnAUFbAmMc0gFhvCX6bBPLP5mvMyoi9Z45OtnQgBo6qPMgVVbbw==
X-Received: by 2002:adf:da45:0:b0:2ce:ad08:ca4 with SMTP id r5-20020adfda45000000b002cead080ca4mr538188wrl.35.1678612068824;
        Sun, 12 Mar 2023 01:07:48 -0800 (PST)
Received: from localhost.localdomain ([84.32.202.14])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b002c5706f7c6dsm4506372wri.94.2023.03.12.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 01:07:48 -0800 (PST)
From:   Yaroslav Furman <yaro330@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     yaro330@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2
Date:   Sun, 12 Mar 2023 11:07:45 +0200
Message-Id: <20230312090745.47962-1-yaro330@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZA12pMgwA/8CguYd@kroah.com>
References: <ZA12pMgwA/8CguYd@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
let's avoid them.

Signed-off-by: Yaroslav Furman <yaro330@gmail.com>

---

V3: Moved the code in the appropriate place, after the 0x0578 device,
as pointed out by Alan Stern
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index c7b763d6d102..1f8c9b16a0fb 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -111,6 +111,13 @@ UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA),
 
+/* Reported by: Yaroslav Furman <yaro330@gmail.com> */
+UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
+		"JMicron",
+		"JMS583Gen 2",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Thinh Nguyen <thinhn@synopsys.com> */
 UNUSUAL_DEV(0x154b, 0xf00b, 0x0000, 0x9999,
 		"PNY",
-- 
2.39.2

