Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D1D67E2F0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjA0LSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjA0LSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:18:00 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FA1287F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so4667577wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZk++rAGilP0se2vyyYc9G9oc9KF7qnie14AIpwjJ4k=;
        b=mH55wi35SGoIcZosh++cTF0urwF1ISiGMPK+u5pVhn0ZP+8/mXMQ4553H5Xq+rDlnD
         Q0Q9/4IgRPYC4GEYvRk5127ZvR7qVaYONYG7qCpiq13Silz5Rx/fgSNPGzLq2QECnpZ2
         +3VBnVquC5hIX5otJ31sYDAz8Dh6QQc16zAS88ut9nr7lMdz1TMFruQCpMAyaYme1Hhj
         2yklV773O7HtDjyNCubCQ2X891uP1r/eTu1NdMbjdLXFZF+beGrIRejXNMcPA2M0NVN8
         07awVLrveihnfUwpzYMX7eFoYmPt2Y3sSlw/liYBFuvUP20/2d71c2wlKMY2caBWJteH
         uFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZk++rAGilP0se2vyyYc9G9oc9KF7qnie14AIpwjJ4k=;
        b=X8CNyUf0erOgtLXkZ3tSqccsfFOs6I3tgSiNkzjNKRyjrePhjoZqMFM+oH+0Bis+zW
         wPjb54v6j2Fev9tKwdvZLbBHUk8zg4xIFcwYosqCern0vvsE4DceTNhRtLiAlBc6Ybp7
         I5HYAEM2Z9BZKAvUxJTEBaC6/yYLwhARDh00BNH22/Gm27GtCZYw9wrlq4PfpYLzttub
         zGNHf420c0OOEBueUOJgC8d8V/hy/QtjKOupd9kuyHFwcm+2RWI/vcN7EcirMBui9YQO
         BDopca4SGVZ6DG3Q+KU9A+iA7ykGnnq+hEoWqZCFAkS7aSCRll8TF55dVUFlfsLnNYld
         PDkA==
X-Gm-Message-State: AO0yUKUXBNDvebpfHhmi2HS1giO857Z6E24QEMDQtTAIUYMwxcfrLSZ/
        NmK7WKvbyI+I56OFX78Xa6rx6Q==
X-Google-Smtp-Source: AK7set8MUufCIV5SK0DowvJgLbvrhsIt9z7sgQlLhwXuv4Uua+lEErojzprxg23G+a8T16pW1NCy6Q==
X-Received: by 2002:adf:8b48:0:b0:2bf:d6f9:23d6 with SMTP id v8-20020adf8b48000000b002bfd6f923d6mr653061wra.45.1674818272559;
        Fri, 27 Jan 2023 03:17:52 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/37] of: base: add of_parse_phandle_with_optional_args()
Date:   Fri, 27 Jan 2023 11:15:37 +0000
Message-Id: <20230127111605.25958-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
References: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
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

