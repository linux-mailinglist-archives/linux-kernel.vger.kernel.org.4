Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0962D3EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiKQHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiKQHTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:19:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC2328E20;
        Wed, 16 Nov 2022 23:19:01 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id f18so2891832ejz.5;
        Wed, 16 Nov 2022 23:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T81/5fLCvQ7zJ3Q+OGaVNq/xGeY/shWwLqml1r4UttA=;
        b=g+JlJalFyfkuRhZgHgB1WiVyFtcCzlXAKGT0Hhz5ioaV/axZtkgdxBoxLeYRd3lyCE
         BZDOTfUZMDH6gzoIvIwW5uh3iXT5Hup7pn+QZTP4CUguTmVNdDS2KLIHJhQq/Ely5dMq
         fu3kOGVPmoHdXuHDe4Usm8J9Ojy3Ol8Rt84kJs/H2JznXL+t041Zza5RrG5wdkxaiwVu
         o6XgaoTbkakzydz2x8MFwLg/AKw1Gu6xnmhBMz0MScMUXdtq4SPsmEZL7Z6A3yplx8xK
         9zcLXugEAYjK3m3Gj35G+YANGL4yE5QJ3INj/KHv20ckVXEFI7kDi6fpMOOvnKoZ6Qrd
         b4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T81/5fLCvQ7zJ3Q+OGaVNq/xGeY/shWwLqml1r4UttA=;
        b=ms2JawHDsyZ5YTPQxhfTCRrigOXlA2KnGSjd+q4l4IywOMTuF2suapZH+4NiU/rNUD
         0axvx6+aIQ/zyxLeq3w1zxQQhZ0mLk1y4XhnRlueQFGMs0TFM0/pWIlazEQc3DxF/jXw
         asw/57LbdxJ4HgihsV9SsPILdgTcZahU2y88heOEArGsopynLkZi+sNndApDgnQaemwv
         LH0BujIsx7kpfY5iyEWPNChACFp47XzTbFtlcyx4R+1xHFIAmdIQmlQsEH5h9lxXRDRO
         oqaCxktyJlOfLvRi4RrVj39yryRwr0gXPp245cr3LolmW9BxFKuyvQSN74Tx/uzIq8lm
         Erng==
X-Gm-Message-State: ANoB5plKd9vacrjc35q1cRr8gw81jGD4+bnpGmE7NltsPA3SbR0U6ulw
        ogGaiRd2EdKHmt19bLAwosI=
X-Google-Smtp-Source: AA0mqf5OG6D/pxIWa7/stkwqLg6Spam6QLL78l5FqXWpvJ925eTGaqfdsxHMJcAcxpRaRG4GCwggmw==
X-Received: by 2002:a17:906:229a:b0:78d:d762:5457 with SMTP id p26-20020a170906229a00b0078dd7625457mr1158533eja.67.1668669539494;
        Wed, 16 Nov 2022 23:18:59 -0800 (PST)
Received: from localhost (89-138-235-186.bb.netvision.net.il. [89.138.235.186])
        by smtp.gmail.com with ESMTPSA id en20-20020a056402529400b00461bb7e7ef1sm154207edb.30.2022.11.16.23.18.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Nov 2022 23:18:58 -0800 (PST)
From:   Eli Billauer <eli.billauer@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, imv4bel@gmail.com,
        stern@rowland.harvard.edu, Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH] char: xillybus: Fix trivial bug with mutex
Date:   Thu, 17 Nov 2022 09:18:25 +0200
Message-Id: <20221117071825.3942-1-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@unit_mutex protects @unit from being freed, so obviously it should be
released after @unit is used, and not before.

This is a follow-up to commit 282a4b71816b ("char: xillybus: Prevent
use-after-free due to race condition") which ensures, among others, the
protection of @private_data after @unit_mutex has been released.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/xillybus/xillybus_class.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/xillybus/xillybus_class.c b/drivers/char/xillybus/xillybus_class.c
index 0f238648dcfe..e9a288e61c15 100644
--- a/drivers/char/xillybus/xillybus_class.c
+++ b/drivers/char/xillybus/xillybus_class.c
@@ -227,14 +227,15 @@ int xillybus_find_inode(struct inode *inode,
 			break;
 		}
 
-	mutex_unlock(&unit_mutex);
-
-	if (!unit)
+	if (!unit) {
+		mutex_unlock(&unit_mutex);
 		return -ENODEV;
+	}
 
 	*private_data = unit->private_data;
 	*index = minor - unit->lowest_minor;
 
+	mutex_unlock(&unit_mutex);
 	return 0;
 }
 EXPORT_SYMBOL(xillybus_find_inode);
-- 
2.17.1

