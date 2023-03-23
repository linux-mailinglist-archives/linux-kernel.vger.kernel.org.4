Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9028B6C7239
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 22:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjCWVRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 17:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCWVRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 17:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CABE2596B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679606220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6KV3+ggucumc5QD34On/pnyUwkWX5K53u9B57Btq2Dg=;
        b=IEetVWzjHoylUEe6lDHwGyDq3+yWeUxDFt8xBwKg2Y/wkQ3gvDrIumkb7WbsESZ2Bh4qlk
        XbbP5wZI9iQZ0njN714kAhtDxptxkaKWFu1PpiOMr9c4BMdKczB0Dz21Yvr2XmOm1ecl7W
        qSzSiBcDPuA4zUDPzSZFmX7U8GofB2g=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-E6GKyu8GMSKQeWR3nRE_2A-1; Thu, 23 Mar 2023 17:15:40 -0400
X-MC-Unique: E6GKyu8GMSKQeWR3nRE_2A-1
Received: by mail-qv1-f72.google.com with SMTP id w2-20020a0cc242000000b00583d8e55181so35464qvh.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 14:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KV3+ggucumc5QD34On/pnyUwkWX5K53u9B57Btq2Dg=;
        b=HAQff4dI5gIgMzLa6gnR0IvQdLDTFBHWoxBCA1U3T+8baEE4elTXtjWFRTMe5lprVm
         NuXhzNdfokYDOCwQaES6upxluKspixi6xJe5+zkPFQtLe3Am22RK6Okx/2XpvgncyJv5
         DcogkxfEfFxb3mXYwUtc8IlK7CJN+/5IkRx+gp0TxTCkyRec/DIQ8NWV4/9Sl/OApyZF
         ARdxdwm6oLXhB2bzM9udTSJ7fDYVXOwcR1lqJfrDiPwVsAiGI5cZkAuqMFga3pslCqmh
         x2zG0zYHTOau9jKOtwRVmGZDH1gSholah11i9UOQNWVwDmZn1jBr6fNnv11/Zb55mbnc
         h20A==
X-Gm-Message-State: AO0yUKU8phj5TgPo86JGYnkgbfZHxcZMkBOPoPOuQtTZB9JqV/f0TrkV
        O6JpMZgJLRQEwNdyRB9awRbKOuSohMcrWHsY+HR/j8mE6/xO/+th2RLEP11advQEZAGAUyh6Tfp
        2BoijpPZg1WfcV8NxCEH8IBqv
X-Received: by 2002:ad4:5ca7:0:b0:557:a5c5:7e01 with SMTP id q7-20020ad45ca7000000b00557a5c57e01mr11200936qvh.25.1679606139887;
        Thu, 23 Mar 2023 14:15:39 -0700 (PDT)
X-Google-Smtp-Source: AK7set+tvzAycBc1q7Z1SybzVhbz3gSyQZZjVzp64y0qPk4l+LZH6qxGccQxM9QKATFbt8WTwlMI0g==
X-Received: by 2002:ad4:5ca7:0:b0:557:a5c5:7e01 with SMTP id q7-20020ad45ca7000000b00557a5c57e01mr11200902qvh.25.1679606139628;
        Thu, 23 Mar 2023 14:15:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm8694926qke.127.2023.03.23.14.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:15:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     juergh@proton.me, jdelvare@suse.com, linux@roeck-us.net,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] hwmon: remove unused superio_outb function
Date:   Thu, 23 Mar 2023 17:15:35 -0400
Message-Id: <20230323211535.2637939-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/hwmon/vt1211.c:198:20: error: unused function
  'superio_outb' [-Werror,-Wunused-function]
static inline void superio_outb(int sio_cip, int reg, int val)
                   ^
This function is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/hwmon/vt1211.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 4a5e911d26eb..fcd4be7a5a85 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -195,12 +195,6 @@ struct vt1211_data {
 /* VT1211 logical device numbers */
 #define SIO_VT1211_LDN_HWMON	0x0b	/* HW monitor */
 
-static inline void superio_outb(int sio_cip, int reg, int val)
-{
-	outb(reg, sio_cip);
-	outb(val, sio_cip + 1);
-}
-
 static inline int superio_inb(int sio_cip, int reg)
 {
 	outb(reg, sio_cip);
-- 
2.27.0

