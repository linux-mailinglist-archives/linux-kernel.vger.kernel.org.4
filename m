Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E16E67A2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjAXT3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXT3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FF4DCCD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674588533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=82l5q/fLAv2sY6gv1oBW5Tvks7WDzg3jqecVI/AwJrc=;
        b=G2l8ZSYX4Cqh3e+4FBXPqs5UDSEBmRE7WwJirJA5aIsMnfwOO6Bbc6ZZtdTlGERK5xBTMI
        r11XcdJibHnKPfqMEzEuGlhmDC9ObjKM1Ch7DQbXKgUHp94FKKd2H8Zm4fJiBkWgShXB1u
        omXU2oNCgNii+wSqrfXtcQZ+6IBE6oY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-49x_EFSQMoymN_NGX8Y09w-1; Tue, 24 Jan 2023 14:28:44 -0500
X-MC-Unique: 49x_EFSQMoymN_NGX8Y09w-1
Received: by mail-qv1-f69.google.com with SMTP id x6-20020a0cc506000000b005349c8b39d6so8001059qvi.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=82l5q/fLAv2sY6gv1oBW5Tvks7WDzg3jqecVI/AwJrc=;
        b=LWwS9azx1tHzrNlEMXRXFTB2nSmS0DEtyUeMOmAL/TZjoGVVT0PgTTxeJUa37oFG2o
         Rh2UeJIT4124NSNgC8qFCWL/PG3vcxNY06My6CgkG4wB6kqEHUgCULuuLhQHenG4n2Jw
         eZm0ocAfZdbu0/TTaJsqWBXpttK3Wf4N2NKQDVso99cqUmqd4hdBA6UTlOpYQhc7fghX
         ws0vZtgi+C6Wlmrj7SC0c+lZVyQoIxUW9TQ/7BACtnB6dkzObmhCe82bngERWrbDF37W
         xUdMXd1A7G4mb9Fi2zF/HdYyTyXrRp3V1STvwTDwkii5bR6Ivejgu0jlZed2AGjkp5lK
         P5YA==
X-Gm-Message-State: AFqh2kq6fFrN75dPKZvpVjvYk4rx5sJl83yl6HjL+cPdbeY5L2TGrWx3
        pHujf+ti8Gi67dqfCdFVTUWe/6x+Q5L2QuzyLi0vH14B95wSJg+GmdIwIPj9FtBnkbOh0ofOPy/
        ctbAKUbIbSQe0IQczBIu3wX9Y
X-Received: by 2002:ac8:7d0a:0:b0:3b6:392d:932e with SMTP id g10-20020ac87d0a000000b003b6392d932emr58439517qtb.48.1674588523939;
        Tue, 24 Jan 2023 11:28:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuUhPqwBpUj0NYkwBWWX+y5Ee4KwG3kdB2aovqWvAs/29sB79WmSHw07CZVqmfyGnYgOHdNVw==
X-Received: by 2002:ac8:7d0a:0:b0:3b6:392d:932e with SMTP id g10-20020ac87d0a000000b003b6392d932emr58439490qtb.48.1674588523736;
        Tue, 24 Jan 2023 11:28:43 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id f1-20020ac840c1000000b003a981f7315bsm1809017qtm.44.2023.01.24.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 11:28:43 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        bgolaszewski@baylibre.com, gregkh@linuxfoundation.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sh: fix spdx format
Date:   Tue, 24 Jan 2023 05:39:41 -0800
Message-Id: <20230124133941.632974-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch reports
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
FILE: arch/sh/include/asm/platform_early.h:1:
+/* SPDX--License-Identifier: GPL-2.0 */

Remove extra -

Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/sh/drivers/platform_early.c     | 2 +-
 arch/sh/include/asm/platform_early.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 143747c45206..1c2a571a8ab8 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -1,4 +1,4 @@
-// SPDX--License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/platform_early.h>
 #include <linux/mod_devicetable.h>
diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
index fc802137c37d..00b6e6dc4ac4 100644
--- a/arch/sh/include/asm/platform_early.h
+++ b/arch/sh/include/asm/platform_early.h
@@ -1,4 +1,4 @@
-/* SPDX--License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef __PLATFORM_EARLY__
 #define __PLATFORM_EARLY__
-- 
2.26.3

