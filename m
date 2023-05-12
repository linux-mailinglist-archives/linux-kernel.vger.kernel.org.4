Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9907470093E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbjELNbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241267AbjELNbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:31:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB803A84
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:31:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 5b1f17b1804b1-3f42c865535so43990655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683898263; x=1686490263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sal/WZx5spNSmuUPffjSgLCTPZYFtetd12n9WhF8+JE=;
        b=k4MHrVo1qElqYs8PkwvdhOj52YJYHzLkjg4vmod+5cpNuwYKeOuvAY65KSXcPY3P/l
         oDshufEvOBR9lMlsV1ROH+/LHs2+rSUifV/zBOv3XWtIyFexE4GDu2Zqjbiw4bKUaQkl
         aO4OYyVD6Sdb65Bf/EEVnFQ+YFguuBBk6/VarA0W4NZqvS/jcTij6G3NWA7OkbZOGVAR
         1tDgJqh2W/Kh3RlE1YpNxU+P3eBrbjhE+5P37yxAtjwawfpeJCKSWVsLj3enudDa+IBB
         rcNa8MytG7s1gkWc7ZezwTD27idxwn02JfdfkKURponGvMNHfujTmMEPu51tIE14coiP
         y3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683898263; x=1686490263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sal/WZx5spNSmuUPffjSgLCTPZYFtetd12n9WhF8+JE=;
        b=Hc1cuis7MWNt1eYCAD0gQvpBpQvM3XljRVpo4G0byOp/UPS6HlP7MdJcSSxVBpdHOi
         3Wglu536f4444UrJLHxjBMGYgLObPAxiU5HSGfH13h8MsbRIHiN0yUSlP8Br9CuIks9t
         LQ28V8+VtTQHAqg/1Ur0XHlsYmeN/OYdVmfvy1wJvzPjUtQAg+PFObqch/K/Y5ZZa7Cu
         9nYAXodEWbvVqbQeZwP1LbjyWg/AK0pj4c/41HehZAPJUBYcUk+bakSfs4gPTNu87Jq2
         9K8ooDJ48MDh3RSqY5SAPUlf6nekCmFvRUczA/DN1wkycZT4wFCxfAa11r2LCRt6nOWR
         ulWA==
X-Gm-Message-State: AC+VfDz5bqPvKaHPSzqLUW1aX2d1tyP+RoB8plLdMGwLqakWFVvWcaau
        DknQSscN/pYHVEYt/Gn4l6e7mw==
X-Google-Smtp-Source: ACHHUZ7I6MJOh59Iv3zeupw7Oqvew5xsWx9+nOqyLf9oKL+E5hwu1JKct9W7kbDIRe231p8KjwL3Pw==
X-Received: by 2002:a05:600c:3658:b0:3f4:2374:3517 with SMTP id y24-20020a05600c365800b003f423743517mr12185981wmq.19.1683898263098;
        Fri, 12 May 2023 06:31:03 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:680a:d01:57da:7169:d3ca:bc56])
        by smtp.gmail.com with ESMTPSA id p13-20020a7bcc8d000000b003f4289b18a7sm12946162wma.5.2023.05.12.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:31:02 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.org, hejunhao3@huawei.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: etm4x: Fix missing trctraceidr file in sysfs
Date:   Fri, 12 May 2023 14:30:54 +0100
Message-Id: <20230512133054.235073-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace ID patchset adjusted the handling of the TRCTRACEIDR register
sysfs to allocate on read.

Although this was initally correct, the final version of the patch series
introduced an error which resulted in the mgmt/trctraceidr file in sysfs
not being visible.

This patch fixes that issue.

Fixes: df4871204e5d ("coresight: etm4x: Update ETM4 driver to use Trace ID API")

Reported-by: Junhao He <hejunhao3@huawei.com>
Link: https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/KK3CVVMRHJWVUORKMFJRSXYCEDFKENQJ/

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 27 ++++++++++++-------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 5e62aa40ecd0..a9f19629f3f8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2411,7 +2411,6 @@ static ssize_t trctraceid_show(struct device *dev,
 
 	return sysfs_emit(buf, "0x%x\n", trace_id);
 }
-static DEVICE_ATTR_RO(trctraceid);
 
 struct etmv4_reg {
 	struct coresight_device *csdev;
@@ -2528,13 +2527,23 @@ coresight_etm4x_attr_reg_implemented(struct kobject *kobj,
 	return 0;
 }
 
-#define coresight_etm4x_reg(name, offset)				\
-	&((struct dev_ext_attribute[]) {				\
-	   {								\
-		__ATTR(name, 0444, coresight_etm4x_reg_show, NULL),	\
-		(void *)(unsigned long)offset				\
-	   }								\
-	})[0].attr.attr
+/*
+ * Macro to set an RO ext attribute with offset and show function.
+ * Offset is used in mgmt group to ensure only correct registers for
+ * the ETM / ETE variant are visible.
+ */
+#define coresight_etm4x_reg_showfn(name, offset, showfn) (	\
+	&((struct dev_ext_attribute[]) {			\
+	   {							\
+		__ATTR(name, 0444, showfn, NULL),		\
+		(void *)(unsigned long)offset			\
+	   }							\
+	})[0].attr.attr						\
+	)
+
+/* macro using the default coresight_etm4x_reg_show function */
+#define coresight_etm4x_reg(name, offset)	\
+	coresight_etm4x_reg_showfn(name, offset, coresight_etm4x_reg_show)
 
 static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpdcr, TRCPDCR),
@@ -2549,7 +2558,7 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	coresight_etm4x_reg(trcpidr3, TRCPIDR3),
 	coresight_etm4x_reg(trcoslsr, TRCOSLSR),
 	coresight_etm4x_reg(trcconfig, TRCCONFIGR),
-	&dev_attr_trctraceid.attr,
+	coresight_etm4x_reg_showfn(trctraceid, TRCTRACEIDR, trctraceid_show),
 	coresight_etm4x_reg(trcdevarch, TRCDEVARCH),
 	NULL,
 };
-- 
2.32.0

