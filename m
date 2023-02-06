Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4161068BE8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjBFNov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjBFNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2E241FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:17 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso8825666wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZk++rAGilP0se2vyyYc9G9oc9KF7qnie14AIpwjJ4k=;
        b=PVvD4x0O5Q22hJvMzp2jlbWAqCDih5j+vPpSY5gW+tkccS3qK4OnDzcR3RlL/J5DZQ
         D6pee7D9WPVkNiVrNY68T8WMhFPbpwn+KlZKzIxWtL8PuIPBc4iHLr2OeKhAUSPxQxIF
         eLLebwJvuhXWsIkFAF+lv1fzzEkoGkL0giCIwFZfKXM+1M0yGj9+HfgO+9HoLC/8c2rh
         uDCpvXzWfmIVIAO0cW6lFd033DRLVuKmMhafqk55koxKDRqAyd+KnkN2i+PUZGCLz4QV
         nEkeT1J6x8oeZxx07EnqglMKb0D4BwV+T4lMA62xJY2h4KUMg9kWtZ+wMjSZaWhqmPZN
         bnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZk++rAGilP0se2vyyYc9G9oc9KF7qnie14AIpwjJ4k=;
        b=n4Z/AQz/gm4FX9NZJv1nFy+fJKUshRJcqTkM9w+NjhMjO9ayssG21EvGPtxxKCSNyN
         KEZOUmIxQMIXPNuUTACKyHqMi4t3iXjP6Dvq6C4UBQMJy2XCwTHfWR11umqty+gFcmTJ
         eBp0XRnnlpMF7KLidQTM9NLOv6Y++8SOov8s/tMSl2HuHCEXl9j0DAmUleKF41t/gGts
         scypovnIO1LM2LwZqrrz26rHbVujL60bo/z59BB9KYYYB1V89eTgyaKMF8i/qGQtnS2P
         5XzHrTeG8zyBJC8i112r9Zk3LxGYfZDK4FGGP9DAympEoYGzkftKeQES/VOKDBa/2A4S
         hx/Q==
X-Gm-Message-State: AO0yUKXS8xR1rZlodCCMIgLGGJ0qWldxU5pZGR33yDsZ3oCrOp+tpfQT
        recvMl12bULFZbbmlvur+1kED7/fvI6cYE1j
X-Google-Smtp-Source: AK7set/jX3/LZO9deONWBV+4EHtI2+16PUSS77Hr/BKRnELJynZeaYF4awQBxnTrweYtwTOqEXgp6Q==
X-Received: by 2002:a7b:c00d:0:b0:3da:f5d1:c677 with SMTP id c13-20020a7bc00d000000b003daf5d1c677mr19585070wmb.35.1675691056034;
        Mon, 06 Feb 2023 05:44:16 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:15 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/22] of: base: add of_parse_phandle_with_optional_args()
Date:   Mon,  6 Feb 2023 13:43:43 +0000
Message-Id: <20230206134356.839737-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

Add a new variant of the of_parse_phandle_with_args() which treats the
cells name as optional. If it's missing, it is assumed that the phandle
has no arguments.

Up until now, a nvmem node didn't have any arguments, so all the device
trees haven't any '#*-cells' property. But there is a need for an
additional argument for the phandle, for which we need a '#*-cells'
property. Therefore, we need to support nvmem nodes with and without
this property.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/of.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 8b9f94386dc3..98c252d2d851 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1008,6 +1008,31 @@ static inline int of_parse_phandle_with_fixed_args(const struct device_node *np,
 					    index, out_args);
 }
 
+/**
+ * of_parse_phandle_with_optional_args() - Find a node pointed by phandle in a list
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ *
+ * Same as of_parse_phandle_with_args() except that if the cells_name property
+ * is not found, cell_count of 0 is assumed.
+ *
+ * This is used to useful, if you have a phandle which didn't have arguments
+ * before and thus doesn't have a '#*-cells' property but is now migrated to
+ * having arguments while retaining backwards compatibility.
+ */
+static inline int of_parse_phandle_with_optional_args(const struct device_node *np,
+						      const char *list_name,
+						      const char *cells_name,
+						      int index,
+						      struct of_phandle_args *out_args)
+{
+	return __of_parse_phandle_with_args(np, list_name, cells_name,
+					    0, index, out_args);
+}
+
 /**
  * of_property_count_u8_elems - Count the number of u8 elements in a property
  *
-- 
2.25.1

