Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F77361549A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKAWDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiKAWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:03:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0163894;
        Tue,  1 Nov 2022 15:03:10 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33F8F660284F;
        Tue,  1 Nov 2022 22:03:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667340188;
        bh=yMp4w9RoWXCGng4R5gRPNg63j86qA6FnSxUKrRZ65bs=;
        h=From:To:Cc:Subject:Date:From;
        b=j+ei/IQG//damy7N0vcrtAagkDLsrP4ZOsk52t5QV64cHuYQQBW58N91q6uAmEQzo
         5Zh7RRckssF/ZPC1kHvZymv8aB4O9ocAzfWN6QULCBkX3NTPJikOLE2A4giFsFLtJz
         HPEbSPCP1UVpf4vcqCYag3kgn3oZ8HN9MZKdR0L5J1Vg/eoAk9aFnh6VZgb+ahnC7D
         p+VO7ciIXExKioAmxgyth17Z8pOiozefhqs7gQPMpoi8SdUXSLKK/Syn4IFXLo0JNL
         majVSvEOYMtQHT7H2k6Fzo1ng8cfLGPQETsuk85neh3FM3vVXlHt5VTg3Sq56rQuaz
         nOQoa4+tBaUDA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] kbuild: Add DTB_FILES variable for dtbs_check
Date:   Tue,  1 Nov 2022 18:03:03 -0400
Message-Id: <20221101220304.65715-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently running dtbs_check compiles and runs the DT checker on all
enabled devicetrees against all dt-bindings. This can take a long time,
and is an unnecessary burden when just validating a new devicetree or
changes in an existing one, with the dt-bindings unchanged.

Similarly to DT_SCHEMA_FILES for dt_binding_check, add a DTB_FILES
variable that can be passed to the dtbs_check make command to restrict
which devicetrees are validated.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Usage example:
make dtbs_check DTB_FILES='arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb'

 scripts/Makefile.lib | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ec391c6a2641..f3ac6d3632a2 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -418,9 +418,16 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
 DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
+ifeq ($(DTB_FILES),)
 quiet_cmd_dtb =	DTC_CHK $@
       cmd_dtb =	$(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
 else
+SHOULD_CHECK_DTB = $(filter $@,$(DTB_FILES))
+
+quiet_cmd_dtb =	$(if $(SHOULD_CHECK_DTB),DTC_CHK,DTC) $@
+      cmd_dtb =	$(if $(SHOULD_CHECK_DTB), $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true , $(cmd_dtc))
+endif
+else
 quiet_cmd_dtb = $(quiet_cmd_dtc)
       cmd_dtb = $(cmd_dtc)
 endif
-- 
2.38.1

