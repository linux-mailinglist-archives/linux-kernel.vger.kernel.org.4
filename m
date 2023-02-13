Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54044695014
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBMS6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjBMS5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:49 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C52ECE;
        Mon, 13 Feb 2023 10:57:48 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-16aa71c1600so16261621fac.11;
        Mon, 13 Feb 2023 10:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25JgBmt061z2zUT7Rn2AWSIssQrUdgZ1DK2ZqeBawkI=;
        b=L084l8ve1Ciy9gxw+ILSf96unYRjmyPf/PxoHxG+SxAAX/2DkIR2JvJHS2CqbB8XjA
         kw+KBbylhH6Ewqr6jyhyjsOPA9LaRrWw1f9I/okg+5dHf0DDj8PKvJwLQNddwuez8X6l
         Jkn4NWYHgEK5+pvjxE38jgrCXnkuBStmnktqTWGfVWyGsTiQVPO2UxRr/hwQqdqVSi52
         crKpqNqQDwXs4fJVe3fR0uMIQ6Dnid2mZLM0tYl/nYcWPeWq4iVAxM4sB4fvG+Qn3OHJ
         coJcHRycyNmV9ebEADPcWVT7Mso4QDkl/Fhzg8b/3Ol6f78ao/Bcc9O5nqg7vC6Tlhc5
         CaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25JgBmt061z2zUT7Rn2AWSIssQrUdgZ1DK2ZqeBawkI=;
        b=2xv3sHDq5bEc+08inDKH5JBgp8H4VuOmjOky6AHwYGZWJuG5cxm4XW3PDftJUdlGtC
         fU/gtB2Qr33QudRKtnlhpJb3Xe9QGBeo8Cuc+3XnExUrRghfbps2aONiOBokoSWz9NXi
         HEHuujSH+WE3KXq+fSpdtnIjx8SLDcJ75ZQc2vnhpSj4t+feP1vOf3yvB1wDbp8nS+O6
         kBZh6kwgERp2/zidNjaiTC5JBF+zRXQyu/p/cEtqPq9gkAABU4girkOHCB9uvH2UHTxf
         YfePILTJtwjKIEJcjEuDCHeqHpNTaGlS+slrInoLwAK5eLUjZTYGUtUC/f6YWV5oXRhY
         YCMA==
X-Gm-Message-State: AO0yUKWhrLQmEdD5FaRLzeEThtxt6qCNvPunUhGQBmj3WzlON54r5D9R
        wEtVQAfZu6dA0I0x9idcmv+78PhxGng=
X-Google-Smtp-Source: AK7set8zPRWtI61BPb9IaZ/DhhTOYGxaoLctcu5yQ2PxdMyaLws4rgQgo9e+eoi7a0GTR4Q3i8547A==
X-Received: by 2002:a05:6870:d1c5:b0:16d:f4aa:2c9c with SMTP id b5-20020a056870d1c500b0016df4aa2c9cmr4072490oac.33.1676314667421;
        Mon, 13 Feb 2023 10:57:47 -0800 (PST)
Received: from xps8900.attlocal.net ([2600:1700:2442:6db0:5829:dabf:a50e:e9f2])
        by smtp.gmail.com with ESMTPSA id ef15-20020a0568701a8f00b0016df97ab05bsm1654958oab.31.2023.02.13.10.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:57:46 -0800 (PST)
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] of: do not use "%pOF" printk format on node with refcount of zero
Date:   Mon, 13 Feb 2023 12:57:00 -0600
Message-Id: <20230213185702.395776-6-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213185702.395776-1-frowand.list@gmail.com>
References: <20230213185702.395776-1-frowand.list@gmail.com>
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

of_node_release() can not use the "%pOF" printk format to report
the node name of a node when the node reference count is zero.
This is because the formatter device_node_string() calls
fwnode_full_name_string() which indirectly calls of_node_get().
Calling of_node_get() on the node with a zero reference count
results in a WARNING and stack trace.

When the reference count has been decremented to zero, this function
is in the subsequent call path which frees memory related to the node.

This commit resolves the unittest EXPECT errors that were created in
the previous commmit.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
---

The scripts/dtc/of_unittest_expect summary statistics before this commit:

** EXPECT statistics:
**
**   non-zero values expected:
**
**     EXPECT found              :   50
**     EXPECT_NOT not found      :    4
**
**   zero values expected:
**
**     EXPECT not found          :    0
**     missing EXPECT begin      :    5
**     missing EXPECT end        :    0
**
**     EXPECT_NOT found          :    0
**     missing EXPECT_NOT begin  :    0
**     missing EXPECT_NOT end    :    0
**
**     unittest FAIL             :    0
**     internal error            :    0

The scripts/dtc/of_unittest_expect summary statistics after this commit:

** EXPECT statistics:
**
**   non-zero values expected:
**
**     EXPECT found              :   55
**     EXPECT_NOT not found      :    4
**
**   zero values expected:
**
**     EXPECT not found          :    0
**     missing EXPECT begin      :    0
**     missing EXPECT end        :    0
**
**     EXPECT_NOT found          :    0
**     missing EXPECT_NOT begin  :    0
**     missing EXPECT_NOT end    :    0
**
**     unittest FAIL             :    0
**     internal error            :    0

 drivers/of/dynamic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index becb80f762c8..dbcbc41f3465 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -329,9 +329,17 @@ void of_node_release(struct kobject *kobj)
 {
 	struct device_node *node = kobj_to_device_node(kobj);
 
+	/*
+	 * can not use '"%pOF", node' in pr_err() calls from this function
+	 * because an of_node_get(node) when refcount is already zero
+	 * will result in an error and a stack dump
+	 */
+
 	/* We should never be releasing nodes that haven't been detached. */
 	if (!of_node_check_flag(node, OF_DETACHED)) {
-		pr_err("ERROR: Bad of_node_put() on %pOF\n", node);
+
+		pr_err("ERROR: %s() detected bad of_node_put() on %pOF/%s\n",
+			__func__, node->parent, node->full_name);
 
 		/*
 		 * of unittests will test this path.  Do not print the stack
-- 
Frank Rowand <frowand.list@gmail.com>

