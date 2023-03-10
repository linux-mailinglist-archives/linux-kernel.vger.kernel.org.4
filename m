Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D36B4771
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjCJOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjCJOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:49:11 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088D71241C8;
        Fri, 10 Mar 2023 06:47:44 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id e9-20020a056830200900b00694651d19f6so3018291otp.12;
        Fri, 10 Mar 2023 06:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678459663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV8iy1W+HzbM7y1sc4cc2CVnizJ5BO/3Cf1trLEFKYw=;
        b=HUggcPDvnndBgOC2PHR7gxqRevwSVmFEquvZevOMBDTy/jnQ/wDqSKEQqF3NW3TEv/
         o+ucbkrMIipWjfWsTOr7Ia5B9qoNq0V09v6kaS3L8WiJ9J1ud5VK8JdrIIb5UCQ9XV/1
         5ozTflou0WTL36uXXlC8Q7ZqQHsUvS4GnHR7vJ4U2pGXfMkFDqLX0tmEz48tO7qvUaeI
         6omGfN/awsaLlSUJuTLHRyLAm646+dpFyKmYb0rIpqcJe476fq6NkHZEXd7D8gSYMpPg
         WXbzCgI3g0O4X1bXqVIdEXUpkjW4S9mJy+jBTZAKSFdcK1KDlEWx3qdcMZh5VXrTk9pL
         QN/w==
X-Gm-Message-State: AO0yUKWHKbf8Fv5VPr/nGx1icP61kUP9ToQUseRvbRvbspgitti75zuy
        CTeB8NqVpuji0PDjpqR35w==
X-Google-Smtp-Source: AK7set/E91M/DeQ2a1JpWl0X0cQUJeecXU0OnwwVJTHI7R2Y9BdaX8OyAkHZpawpFKpiIsbABzXv0A==
X-Received: by 2002:a05:6830:44a2:b0:690:e454:fc1e with SMTP id r34-20020a05683044a200b00690e454fc1emr15757037otv.7.1678459663313;
        Fri, 10 Mar 2023 06:47:43 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 64-20020a9d06c6000000b006864816ecd9sm106511otx.59.2023.03.10.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 06:47:42 -0800 (PST)
Received: (nullmailer pid 1542708 invoked by uid 1000);
        Fri, 10 Mar 2023 14:47:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: zinitix: Use of_property_present() for testing DT property presence
Date:   Fri, 10 Mar 2023 08:47:08 -0600
Message-Id: <20230310144708.1542682-1-robh@kernel.org>
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

It is preferred to use typed property access functions (i.e.
of_property_read_<type> functions) rather than low-level
of_get_property/of_find_property functions for reading properties. As
part of this, convert of_get_property/of_find_property calls to the
recently added of_property_present() helper when we just want to test
for presence of a property and nothing more.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/touchscreen/zinitix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index cdf9bcd744db..b6ece47151b8 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -260,7 +260,7 @@ static int zinitix_init_regulators(struct bt541_ts_data *bt541)
 	 * so check if "vddo" is present and in that case use these names.
 	 * Else use the proper supply names on the component.
 	 */
-	if (of_find_property(dev->of_node, "vddo-supply", NULL)) {
+	if (of_property_present(dev->of_node, "vddo-supply")) {
 		bt541->supplies[0].supply = "vdd";
 		bt541->supplies[1].supply = "vddo";
 	} else {
-- 
2.39.2

