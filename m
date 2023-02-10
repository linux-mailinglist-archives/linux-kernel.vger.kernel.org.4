Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262976921B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBJPN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjBJPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:13:23 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C855ACE6;
        Fri, 10 Feb 2023 07:13:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso6508755wms.5;
        Fri, 10 Feb 2023 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qFzkK8hl+QAofsP+VURF4ajN7hzwnlwiCh1ujs/8w3M=;
        b=Sc7u5lVqMsUcV1GDTwfCQ5FWdvZyXqGkZBxML3eax8wAm+hxRd8ZEEx/BGPufl5DBk
         EThrWjTB+04Az0bUBu+IgrQVlAHjKafWu78CpWBBNVOJ+X6EI5SYZT7DA5VFARq9ZM14
         hqgvy/bo14RmXTjPoQ7cBHeUQA/zyY7VycuH9gjN0N4FJT6lDBfRb+3x8NOvLDYV3Qtz
         MO/r93tsT6I0PE0Bl31hMEV+ZRPmbETzmCc/FTEaPUUBFN37ueT1L6qozn81PlUsDpz1
         pttkR54GntkjV435bM+3QeO0ZGNOkp3YR+OCgGuyB05vvELlPDb/LK7ey99Uux6abJJ7
         f2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFzkK8hl+QAofsP+VURF4ajN7hzwnlwiCh1ujs/8w3M=;
        b=2vdISzu3O+yETJqrSikGTVSEeYNIGML5LdG1mYj44Aq02zcLDR1QfQ3iUFb6NcBN4W
         EqApR09UnZIxhZGm6nLvhTFIcWZhzGJodrJZPs68476YJBS99FVRfzkWqV7t2MMyn8rC
         eLpASGv3rEDE9cahbguq8tBrShxxpqmAUgU1mLrxcxSpGVXzM7CxoOzw3LrueanuuHsJ
         lSstGTHJFnofXxBXrTuT5miD2mAEFVHymE3GTRibv5w4Lt2GA+ODtb8POuN8+wGiDDpd
         SFkkeno4r2/MJxQeSbKAIIx/MVKUS0jQhnvbYbJVEweT3LujQYGQgRRU/PxghafAUEJ6
         kTZQ==
X-Gm-Message-State: AO0yUKWIZvk7Im8LcAnUy/hbOHBH3Y5W+4U8DPj24vNrCnws59DmMkYX
        Qb3P8CpmvOneXS4/qIZ91U6B0nZaP9T8d8EZ
X-Google-Smtp-Source: AK7set8uE/dlxuaGskKjWgKxmwul/XLTPciYk8/cRzLrH7HsehwEPiCZc4ma4G4/5GLmxwg8XhARWA==
X-Received: by 2002:a05:600c:4d09:b0:3de:db64:a56f with SMTP id u9-20020a05600c4d0900b003dedb64a56fmr17180668wmp.13.1676042001552;
        Fri, 10 Feb 2023 07:13:21 -0800 (PST)
Received: from precision7540.ncl.ac.uk (janus-nat-128-240-225-11.ncl.ac.uk. [128.240.225.11])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c080700b003daf672a616sm4921553wmp.22.2023.02.10.07.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:13:20 -0800 (PST)
From:   Dale Whinham <daleyo@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dale Whinham <daleyo@gmail.com>
Subject: [PATCH] Input: synaptics - enable InterTouch on Panasonic Let's Note CF-RZ6
Date:   Fri, 10 Feb 2023 15:12:39 +0000
Message-Id: <20230210151239.211503-1-daleyo@gmail.com>
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

SYN0505 confirmed working reliably on the CF-RZ6 using
'psmouse.synaptics_intertouch=1'.

This ID may also be used by other models in the Panasonic Let's Note
/Toughbook range.

Signed-off-by: Dale Whinham <daleyo@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b0f776448a1c..7570f6770ed2 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -188,6 +188,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2068", /* T14 Gen 1 */
+	"SYN0505", /* Panasonic Let's Note CF-RZ6 */
 	"SYN3052", /* HP EliteBook 840 G4 */
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
-- 
2.34.1

