Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAAA6878C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjBBJ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBBJ21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:28:27 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A2816309;
        Thu,  2 Feb 2023 01:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675330102; x=1706866102;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=La3wj2SGvz7TU9s+j9pQj9x3EPVU8m3Fuv9USC0qvtA=;
  b=h1kAJDfNhz0qd6EBkWwKviGFF3z33EIQwfmpG8Oq2fAubzyBYQdKfkk3
   KnfTYNvVmOufWe/goEV138FFsaRFWCSqQKGHt2CvL3mNrbbE8y/YGFCTl
   8tKATc0q8zW+rzi0gj9CXk+heVtRdRw63i/hGgpWEqQNKnUYVyKrwMbwu
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Feb 2023 01:28:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 01:28:17 -0800
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 01:28:14 -0800
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <linux-hardening@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <corbet@lwn.net>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v5 1/2] dt-bindings: ramoops: Add support to get the region dynamically
Date:   Thu, 2 Feb 2023 14:58:00 +0530
Message-ID: <1675330081-15029-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved memory region for ramoops is assumed to be at a
fixed and known location when read from the devicetree. This
is not desirable in an environment where it is preferred the
region to be dynamically allocated at runtime, as opposed to
being fixed at compile time.

So, update the ramoops binding by using some reserve memory
property to allocate the ramoops region dynamically.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v5:
 - Updated the commit description.
 - Removed example from yaml file.

Changes in v4:
 - Addressed comment made by Krzysztof on ramoops node name.

Changes in v3:
 - Fixed yaml error and updated commit text as per comment.

Change in v2:
  - Added this patch as per changes going to be done in patch 3/3

 .../devicetree/bindings/reserved-memory/ramoops.yaml          | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
index 0391871..51b6003 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.yaml
@@ -10,7 +10,8 @@ description: |
   ramoops provides persistent RAM storage for oops and panics, so they can be
   recovered after a reboot. This is a child-node of "/reserved-memory", and
   is named "ramoops" after the backend, rather than "pstore" which is the
-  subsystem.
+  subsystem. This region can be reserved both statically or dynamically by
+  using appropriate property in device tree.
 
   Parts of this storage may be set aside for other persistent log buffers, such
   as kernel log messages, or for optional ECC error-correction data.  The total
@@ -112,7 +113,13 @@ unevaluatedProperties: false
 
 required:
   - compatible
-  - reg
+
+oneOf:
+  - required:
+      - reg
+
+  - required:
+      - size
 
 anyOf:
   - required: [record-size]
-- 
2.7.4

