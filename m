Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802576BEA12
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCQN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCQN0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:26:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4B75073D;
        Fri, 17 Mar 2023 06:26:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x36so5068717ljq.7;
        Fri, 17 Mar 2023 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679059590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG0u4cQmxwUjiK1WMXH1+VMGQyE9TfyJFnQDUv5VBmQ=;
        b=pdB5G0UmcJXPsPNybdWNYdY7OIGa5bPsOFWL7tVREULieY7xe6M6OEO0POS0itAvtv
         rgOUhKoFwTQ/ctyXEnD1rS1Gj6SGrRk/vj4NjZvmw1AbSpib0bq24BPW/N2Azy6aLIuD
         KRm84JlWCSQvB7ECwaNveUxirgekosVaOwrC83ahMKrmQF8+QRRW9QIJcbiThyZP4lHL
         vBNoBiFOHLJB8uZ0aGwbSStkIsFXsYmqbPycBbO4Wo/NAQtTAjuGgyycea4BW2c+lPr9
         QeUQ1a7IBb969WukIBrMGpT5CONruftWREUrxtUDze9MdjsjjNEIH/R37kBhQmWCWDke
         piWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679059590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QG0u4cQmxwUjiK1WMXH1+VMGQyE9TfyJFnQDUv5VBmQ=;
        b=Uz7YsdM4bhZ6hN5LtjwJzJhTEZz/TGyEpKo9t+G6Ik5FRzErdmQNHjoKL2ncXgmvCy
         WS3XZOXUGG+m53ULkVxcTcX4LehAg/+n8grqnXq+0dLiObYnNcaowFlJgZP6hE9SHyHJ
         Y1mYZ8BXGdf6hVzlh/F+qJ+fkaYM66/REERK7AHn/7PpCt0s04EMikNOdP1AZGx8qD8s
         0GZLLnkoXjRodZczaL8J8eA8Yip6cgQgfJmmPEcmAvTZY7aCidXpdayT9Jpvnie793h5
         2wM++sKpGUdyG67OjBjwrfmCAq7ondJMvqOtDVBSPLL1W6pOmyfH8bzHtcThn2Naq+Ph
         8uBQ==
X-Gm-Message-State: AO0yUKW2/eo1SZk2HgxiAnzvbFVPlwOhXQAbBvCri6WA4b8Zg4aJv7YN
        8mE+st5D44SjvvaEjBAfXM8=
X-Google-Smtp-Source: AK7set/RZWG5HCeVhQh/szYUfNVQl66zginixsiPhrig40kZTsvy20emhYZQ6VluayxW3oHpXEzuGQ==
X-Received: by 2002:a2e:be92:0:b0:28e:a8aa:6f95 with SMTP id a18-20020a2ebe92000000b0028ea8aa6f95mr4189453ljr.8.1679059590083;
        Fri, 17 Mar 2023 06:26:30 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e740f000000b00295b588d21dsm411083ljc.49.2023.03.17.06.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 06:26:29 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 3/4] nvmem: core: export nvmem_add_cells_from_of()
Date:   Fri, 17 Mar 2023 14:26:19 +0100
Message-Id: <20230317132620.31142-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317132620.31142-1-zajec5@gmail.com>
References: <20230317132620.31142-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This symbol can be cleanly re-used by the fixed NVMEM layout driver.
Allow passing DT node as argument to make it a bit more generic.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/core.c           | 7 ++++---
 include/linux/nvmem-provider.h | 7 +++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 212c5ba5789f..985a42cfb0a2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -694,7 +694,7 @@ static int nvmem_validate_keepouts(struct nvmem_device *nvmem)
 	return 0;
 }
 
-static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
+int nvmem_add_cells_from_of(struct nvmem_device *nvmem, struct device_node *np)
 {
 	struct nvmem_layout *layout = nvmem->layout;
 	struct device *dev = &nvmem->dev;
@@ -702,7 +702,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 	const __be32 *addr;
 	int len, ret;
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node(np, child) {
 		struct nvmem_cell_info info = {0};
 
 		addr = of_get_property(child, "reg", &len);
@@ -739,6 +739,7 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvmem_add_cells_from_of);
 
 int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
 {
@@ -970,7 +971,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (rval)
 		goto err_remove_cells;
 
-	rval = nvmem_add_cells_from_of(nvmem);
+	rval = nvmem_add_cells_from_of(nvmem, nvmem->dev.of_node);
 	if (rval)
 		goto err_remove_cells;
 
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3e97c8315c45..2b5410be2636 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -195,6 +195,8 @@ void nvmem_del_cell_table(struct nvmem_cell_table *table);
 int nvmem_add_one_cell(struct nvmem_device *nvmem,
 		       const struct nvmem_cell_info *info);
 
+int nvmem_add_cells_from_of(struct nvmem_device *nvmem, struct device_node *np);
+
 int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner);
 #define nvmem_layout_register(layout) \
 	__nvmem_layout_register(layout, THIS_MODULE)
@@ -226,6 +228,11 @@ static inline int nvmem_add_one_cell(struct nvmem_device *nvmem,
 	return -EOPNOTSUPP;
 }
 
+static int nvmem_add_cells_from_of(struct nvmem_device *nvmem, struct device_node *np)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int nvmem_layout_register(struct nvmem_layout *layout)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1

