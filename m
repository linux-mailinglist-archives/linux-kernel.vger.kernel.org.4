Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE2368BA1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBFK2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBFK2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:28:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41619693
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:28:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so4458694wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZk++rAGilP0se2vyyYc9G9oc9KF7qnie14AIpwjJ4k=;
        b=rca3RaQWSAWTwMrwC2qwAd1ACrtzv5VYts1LFzO6PW0TfzH1ExJydgnSjVsH1f8kc6
         Pzgd9cpUisQE3NaO43FmPYKayhnkGOAoIdtiA1r0B5d3z9LF49zs81yvBOfVMkQQlE5w
         ob7E2l9EZG7eUqJIMB2nu3uK46Y7kCfkIMkV+sLolDsFrkZ7mW927zfRFSs3oZ8HmInP
         3dwpJyH/yPNRVNaEnkL6y4+hP2s4ZcpM9j7iTCIBf12l4WzVOkJESYexMtWmrZVKCQWx
         iaAvINTpvQ0PsRji2qL1RSqJttIque7ByOyuMrsj1eJXS5Aq9dgIqOXEo0aXVT1P4sJJ
         CqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZk++rAGilP0se2vyyYc9G9oc9KF7qnie14AIpwjJ4k=;
        b=HdloXrPOLQOrw/JYlX8FhBRj4YWR0Fxfl4EgK7uROQ23KagmyXQ4xWnExanzD//Usb
         0DCJrguj1py9+QnN1Dn29vqD099n7aQS0HqXHfu39tXKpSZ5FIDZCv0l+pEAoxJVTlIP
         AYmJiOxnTIntCRvjUxA2wqE0EKJxdULQw73xZEVQHd4qMvclnA7xuFg3zTPAyX99aKAN
         KRRWnOQGTRajBJYzDd7Vg4rsBsBFwMPjYFYsOquVOFtzY3bIr01tT7nUjSIJPVqvDr7B
         riTj+6IY68bZDmXAWq6dv42cHE4v9ml3nyMLX4WwvT8dPVNdecUNQn+KthhDoCYs9QnA
         I7ZQ==
X-Gm-Message-State: AO0yUKUy2FmWeGWSU2ptqY3bjYGhW/5kRcjyBDao+6hkNIHf9n5wpzcT
        nIaZVW/A2AQbCoKE/hmDcR0/2A==
X-Google-Smtp-Source: AK7set/+0nRXyQIkGG+egaD6kOLzc7tJZdUrpo+U6pQedIztLn7Ur5vx6OLszjzgRdu6G8d0Dvzzlg==
X-Received: by 2002:a7b:c388:0:b0:3db:2e6e:7826 with SMTP id s8-20020a7bc388000000b003db2e6e7826mr304431wmj.5.1675679304587;
        Mon, 06 Feb 2023 02:28:24 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c310a00b003de77597f16sm11002446wmo.21.2023.02.06.02.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 02:28:24 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 09/37] of: base: add of_parse_phandle_with_optional_args()
Date:   Mon,  6 Feb 2023 10:27:31 +0000
Message-Id: <20230206102759.669838-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
References: <20230206102759.669838-1-srinivas.kandagatla@linaro.org>
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

