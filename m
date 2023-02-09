Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8317068FBF6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBIA0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBIA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:26:42 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73251B557;
        Wed,  8 Feb 2023 16:26:41 -0800 (PST)
Received: from localhost (unknown [86.120.32.152])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 980F766020AF;
        Thu,  9 Feb 2023 00:26:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675902399;
        bh=SvGznSgCk0kXiWJzYL7DhQ57hEnM/O2D+FdMBOZ1PBc=;
        h=From:To:Cc:Subject:Date:From;
        b=VXrlmnsNZahFydzuCxiOBpeyxJC31ryCyBXenjqRA5sokWYwSsGjcYQqEzertrTPo
         X8qxG16s9DgjCE4VbTVYU1793WPTV5TkWsafeD1dPjfE+RDYx+V82jeXiCeZav5hzb
         crYKY0s+hJ6AGhf/miMxrvTblh8tsF+Gmdz1fLj4qgTnqDx9a8I3rWrxiKX9cVErKN
         qD17qlwo/5nuhR/ARxlWpLBZxjxXyrVea0r3fGb8S+TEWt/FShKh+U42Z3Qo6Eqz0d
         B4D+Kp69WZoDBMw4kjrlyO8CZ36RhHW6uG0oOKzt2R/mW2HK6YTg5ysA8OARomn2um
         LJok4Qy9dwjyg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 1/1] dt-bindings: Fix multi pattern support in DT_SCHEMA_FILES
Date:   Thu,  9 Feb 2023 02:26:34 +0200
Message-Id: <20230209002634.745163-1-cristian.ciocaltea@collabora.com>
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

Fixes: 309d955985ee ("dt-bindings: kbuild: Support partial matches with DT_SCHEMA_FILES")

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index bf2d8a8ced77..5475c25ae803 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
 find_all_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
 		-name 'processed-schema*' \)
 
-find_cmd = $(find_all_cmd) | grep -F "$(DT_SCHEMA_FILES)"
+find_cmd = $(find_all_cmd) | grep -F -e "$(subst $() ," -e ",$(strip $(DT_SCHEMA_FILES)))"
 CHK_DT_DOCS := $(shell $(find_cmd))
 
 quiet_cmd_yamllint = LINT    $(src)
-- 
2.39.1

