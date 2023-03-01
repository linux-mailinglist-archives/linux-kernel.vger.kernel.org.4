Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219DC6A6DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 15:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCAOEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 09:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAOEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 09:04:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C248322A11
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 06:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677679400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OPcCye6IbsOS6TPPQL+ZOfj0BZvbnC0wnJLL+X1w++0=;
        b=dqQv5CHtkAkGeGMcKbttvcmDNL9g23F7v7s2MBSfJbcyNrQnJzL/5xk+pkQC1kwyqhZ4LN
        5KLUU7Wc3SgLJkI8CQ8EIT+VOf5597NVTyY9Sw50TfkMzX7gO8k+eOBGxIUR51ONhJI6Kt
        qO835EmKyLyTZarPhJkTUv4RgcWchEg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-_FE-agj-PxOmLCJpw3c_Yg-1; Wed, 01 Mar 2023 09:03:17 -0500
X-MC-Unique: _FE-agj-PxOmLCJpw3c_Yg-1
Received: by mail-wr1-f70.google.com with SMTP id r14-20020a0560001b8e00b002cdb76f7e80so693018wru.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 06:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677679396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPcCye6IbsOS6TPPQL+ZOfj0BZvbnC0wnJLL+X1w++0=;
        b=ROUTGd5hMb6dlx+qlWdAFOMmrEIcaxntUcCLQONwP6/vWzwuJ5pJIkBowknnYW957D
         kN4YhCDLni1u3mX8appsAUSUrblApUR8JxHO0os3qNLoFIOEmxTIYO5wIoILfWEqnDA5
         5auEW9Mi8Ho/7saBnWio9LROvrSF5DBR+WLF2qiPJlBqoxX5ys+yFVp18kN31H5kSuHZ
         w9tOsHWF5xuOaNFuir8yggf370urv6RdmdgExiKOG6uqxaNInYYnV4Y1JniYYM70Vk7K
         YF8c1dhzndZTCfKcK7nYrgBSjEIxxJfrnzPLo/suBFWBIOTHpwj7+cXQGRmVTrpOz5a8
         9PMg==
X-Gm-Message-State: AO0yUKWbAknXSbgmylMS6t5MTXMU4eDmUp/TfzL9UIpkUiPcicS9zbHM
        1PySDjszWXWw2VwMx3uWBJgiwEg+81hET5GRi2yFGbLplYLyH57sQ7QlpIhp5Qkqi7SrnEBFwKc
        /dG2zgh58sels5U3ykXw9kYc=
X-Received: by 2002:a05:6000:12cb:b0:2c7:dec:77a8 with SMTP id l11-20020a05600012cb00b002c70dec77a8mr4396801wrx.57.1677679396405;
        Wed, 01 Mar 2023 06:03:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+f3vfjFdrHKZdPcRzXPnzvXa0v8gj4mrbOqXoIeqQjI/jVUlJ/YhlJpZQiwQPucIj038EtZQ==
X-Received: by 2002:a05:6000:12cb:b0:2c7:dec:77a8 with SMTP id l11-20020a05600012cb00b002c70dec77a8mr4396778wrx.57.1677679396043;
        Wed, 01 Mar 2023 06:03:16 -0800 (PST)
Received: from klayman.station (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id d2-20020adfe842000000b002c552c6c8c2sm12841612wrn.87.2023.03.01.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 06:03:15 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: bridge: fix kernel-doc parameter description
Date:   Wed,  1 Mar 2023 15:03:08 +0100
Message-Id: <20230301140309.512578-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
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

Fix the kernel-doc description for the "struct fpga_image_info *info"
parameter of the fpga_bridge_get() function.

Fixes: 060ac5c8fa7b ("fpga: bridge: kernel-doc fixes")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 5cd40acab5bf..ff4470067ed5 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 /**
  * fpga_bridge_get - get an exclusive reference to an fpga bridge
  * @dev:	parent device that fpga bridge was registered with
- * @info:	fpga manager info
+ * @info:	fpga image specific information
  *
  * Given a device, get an exclusive reference to an fpga bridge.
  *
-- 
2.39.2

