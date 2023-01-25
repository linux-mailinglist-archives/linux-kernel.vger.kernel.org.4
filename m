Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0267B3DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjAYOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAYOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:07:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F05B458
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674655598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kxg+3titRYX6fC8S6yWT9Jxz/i2LqobNBofvZWYgEqU=;
        b=a66DCIrcmDTiUNT6muLZYYOUj9G9XCvIlw0i9jO2a5A8w+PGhdscZdsqezrw+4X+0gAPlz
        0nDURRj0+58mQjgm/3HEBWuLGSHYqIwjbNtwhkhrChi7f+7Xd8NJqwmn04ssJNgyI6UZ2O
        4islgwPuqYQO2y7tNrl18Cj0oPFTZF0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-GJcCbw83PF2gCjAc8cvWEg-1; Wed, 25 Jan 2023 09:06:37 -0500
X-MC-Unique: GJcCbw83PF2gCjAc8cvWEg-1
Received: by mail-qk1-f197.google.com with SMTP id bk3-20020a05620a1a0300b007092ce2a17eso9530232qkb.22
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 06:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxg+3titRYX6fC8S6yWT9Jxz/i2LqobNBofvZWYgEqU=;
        b=EOIsNmMi43sFA3UXbhd2HhLMMbHCNGSvx6awdwPW+jsOwsvWrqWCnaH7TK9LbsM/h9
         gD8z4Bl7RP1qg/31Bb58Ps5BoIHWiCyXpF6x6Klufsi/DuIbMmHX45ogHQ3OnAakRRFM
         x2Q3NGj0MouPIr7/VJhC1dDFdRzPsjs0t1vr0LgpD/584VlRd8KTOkSx5s9weMgsDjoo
         aeLnUzltOwnTQ/f2CXeIy8fPdghYr/MsrdymO1oP5eczpOyvtpOkYH6jpSmdmfy9Zo04
         vGx1qKS620DwLVLiA5h7/bbFKPMhXHuN0KrrW+mC5IOL+lS4+IwYP/4SZohmHEgIlGSS
         Zu3Q==
X-Gm-Message-State: AO0yUKUfIUvr6ofW/MHvuuqRyhb4UB9RkRb24hWf1VmLeWeL4u+aP5Pf
        FTumaTr8efn+QfO2Zno+eIU8YBsKQpj2DJz6XH1GzsnZAgyQJcYtb+tKT9CAoAwVgiH7V7GIY0a
        D/BrFNdEND0/cC3jPs77Ah+k=
X-Received: by 2002:a05:622a:355:b0:3a8:2d6:521e with SMTP id r21-20020a05622a035500b003a802d6521emr4068901qtw.37.1674655596631;
        Wed, 25 Jan 2023 06:06:36 -0800 (PST)
X-Google-Smtp-Source: AK7set+qX5hBoKyNGM1sr+Indsw88q/wgODyBaPpmU6NN1x/OvV3Doaz1hXunkxpyfapb/yq/ykfvw==
X-Received: by 2002:a05:622a:355:b0:3a8:2d6:521e with SMTP id r21-20020a05622a035500b003a802d6521emr4068869qtw.37.1674655596357;
        Wed, 25 Jan 2023 06:06:36 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id d24-20020ac84e38000000b003a7e38055c9sm3296441qtw.63.2023.01.25.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:06:35 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: bridge: return errors in the show() method of the "state" attribute
Date:   Wed, 25 Jan 2023 15:06:22 +0100
Message-Id: <20230125140622.176870-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the show() method of the "state" sysfs attribute to
propagate errors returned by the enable_show() op. In this way,
userspace can distinguish between when the bridge is actually "enabled"
(i.e., allowing signals) or "disabled" (i.e., gating signals), or when
there is an error.

Currently, enable_show() returns an integer representing the bridge's
state (enabled or disabled) or an error code. However, this integer
value is interpreted in state_show() as a bool, resulting in the method
printing "enabled" (i.e., the bridge allows signals to pass), without
propagating the error, even when enable_show() returns an error code.

Thanks

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 727704431f61..5cd40acab5bf 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -293,12 +293,15 @@ static ssize_t state_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
 	struct fpga_bridge *bridge = to_fpga_bridge(dev);
-	int enable = 1;
+	int state = 1;
 
-	if (bridge->br_ops && bridge->br_ops->enable_show)
-		enable = bridge->br_ops->enable_show(bridge);
+	if (bridge->br_ops && bridge->br_ops->enable_show) {
+		state = bridge->br_ops->enable_show(bridge);
+		if (state < 0)
+			return state;
+	}
 
-	return sprintf(buf, "%s\n", enable ? "enabled" : "disabled");
+	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
 }
 
 static DEVICE_ATTR_RO(name);
-- 
2.39.1

