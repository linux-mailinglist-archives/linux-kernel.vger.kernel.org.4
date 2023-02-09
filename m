Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29668691173
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 20:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjBIThw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 14:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:37:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F642CC6F;
        Thu,  9 Feb 2023 11:37:49 -0800 (PST)
Received: from localhost (unknown [86.120.32.152])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2F0766020CE;
        Thu,  9 Feb 2023 19:37:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675971468;
        bh=rhDtpmqy4aWizG8w41QdC/uCJpCIZ4JNM87GvHiVTm0=;
        h=From:To:Cc:Subject:Date:From;
        b=bWKmBIUWt8UglmQLQVTp2+M07vvVWXpqa77cjPwDR82g7g6wcWB6XtqnuMek7G/K1
         tdcpQUNs/q9yz7JqzIBgNfylx3LEz3feeAuRiOTdJnTUfydqlt8DaeSaJrNafdNlzI
         1M7+ZwM+zluWZ1Udm1yoO1Xp2Twl/VOSz6XbckbBRT8zLigfUBSKteuaE2zlT3UYPM
         LQLjOlJ2Ztd1NnkFrGw4UPqW+nn3qghRVVzIaMMdgFE3piST6UsMoOh+/gm5bQcxRT
         mVMquwQ+W7u8j8sHuVLdFUK6BEQomVR/tdSNkWLthxjN9QfmXefph/3o2UbV8UyHur
         /Nbo3mG4B4+bQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 1/1] dt-bindings: Fix multi pattern support in DT_SCHEMA_FILES
Date:   Thu,  9 Feb 2023 21:37:35 +0200
Message-Id: <20230209193735.795288-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT_SCHEMA_FILES used to allow specifying a space separated list of file
paths, but the introduction of partial matches support broke this
feature:

$ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml path/to/schema2.yaml"
[...]
  LINT    Documentation/devicetree/bindings
usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [...]
                [-v]
                [FILE_OR_DIR ...]
yamllint: error: one of the arguments FILE_OR_DIR - is required
[...]

Restore the lost functionality by preparing a grep filter that is able
to handle multiple search patterns.

Additionally, as suggested by Rob, use ':' instead of ' ' as the
patterns separator char. Hence, the command above becomes:

$ make dtbs_check DT_SCHEMA_FILES="path/to/schema1.yaml:path/to/schema2.yaml"

Fixes: 309d955985ee ("dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
 - Use ':' instead of ' ' as the patterns separator char, per Rob's review
 - Drop empty line between Fixes and Signed-off-by tags

 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index bf2d8a8ced77..8b395893bd85 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' \)
 
-find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
+find_cmd = $(find_all_cmd) | grep -F -e "$(subst :," -e ",$(DT_SCHEMA_FILES))"
 CHK_DT_DOCS := $(shell $(find_cmd))
 
 quiet_cmd_yamllint = LINT    $(src)
-- 
2.39.1

