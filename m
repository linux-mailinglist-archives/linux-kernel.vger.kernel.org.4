Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CC16B476C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjCJOtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjCJOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:48:19 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AEA107D64;
        Fri, 10 Mar 2023 06:47:32 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id m25-20020a05683026d900b006941a2838caso3032614otu.7;
        Fri, 10 Mar 2023 06:47:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GsE0EOHWsJSxAvEHDxOBITxOsibWjWWonW0C4i8mXzM=;
        b=Lvm5LDxlQHrREF2D5ZnOdbZF/q/W2sbOVk6xVvjMSuGlShSnbPCCDYWU91k6nDla1x
         QCBqVBB57Oc5IecOSAFBNkKSCaz3ZJ15q5vdZm9EquZztqFHBBsKw+ZJaZuhFCGtTCXI
         epEs+458OtJWZK2Fp2/r8mlRf9Fbqmd5ZJf1EhVDYPZz297007KU+N/4Xpz+1xc/jHfv
         cG+O3yvCSnyYUQx8Ync5ckgu4CS9khzZ02S3/uqeWCFHw+PlhDbPDj16qDD3dRUPJh9l
         63RwfBQjYET2daynvq9yHvw6UM9yFBBZ+iWCD1KC1ugLvdcqSC7miVI96VBWTKbKBKxH
         Mxlw==
X-Gm-Message-State: AO0yUKUrScO5PBhmidjji0Skjp/cTZ0VOR2mwWvQZDS+hpC9N/0K0OdT
        SOeQW9kHYl+lPzJs4EEkig==
X-Google-Smtp-Source: AK7set8SaZ8xFb2Ya0ChvHinEQuYIqvowtAWXeecOlTv8eIVQvsCopa3AU65eVzDB1SWxe/dKs3Mcw==
X-Received: by 2002:a9d:461d:0:b0:684:a7bb:864d with SMTP id y29-20020a9d461d000000b00684a7bb864dmr12538339ote.12.1678459651748;
        Fri, 10 Mar 2023 06:47:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a9d7292000000b0068bc476d777sm131264otj.13.2023.03.10.06.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:31 -0800 (PST)
Received: (nullmailer pid 1543640 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Eric Piel <eric.piel@tremplin-utc.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: lis3lv02d: Fix reading 'st,default-rate' property
Date:   Fri, 10 Mar 2023 08:47:13 -0600
Message-Id: <20230310144713.1543613-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property 'st,default-rate' is tested for presence, but the value is
ignored and the 'default_rate' value is updated with a stale 'val'
value. Fix this by using of_property_read_u32().

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 3a7808b796b1..efed515d7b50 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -1085,7 +1085,7 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	if (of_property_read_s32(np, "st,axis-z", &sval) == 0)
 		pdata->axis_z = sval;
 
-	if (of_get_property(np, "st,default-rate", NULL))
+	if (of_property_read_u32(np, "st,default-rate", &val) == 0)
 		pdata->default_rate = val;
 
 	if (of_property_read_s32(np, "st,min-limit-x", &sval) == 0)
-- 
2.39.2

