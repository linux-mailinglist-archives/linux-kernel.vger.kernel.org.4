Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECCF7416AE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjF1QqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:46:17 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:41430 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjF1QqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:46:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B418613E2;
        Wed, 28 Jun 2023 16:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF24C433C9;
        Wed, 28 Jun 2023 16:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687970773;
        bh=Anh7J4kRhla0M1qr85cZBcy7HHbIz4mqCgOTHfAu7b4=;
        h=From:To:Cc:Subject:Date:From;
        b=jjWMAEUDSlBwfrfqiCEyfcuBYUqTlz/wwd8ni3Lu7xzaEwKOtQ9FP/L9et5oyjVVJ
         ZgEmyFeNGrWs84CYZANfS8F0unnD0CWsQyPUjzVlxc9S5ZYyGA0QdYyBCdbdGDIgL5
         NBszENm6/4vgSOv2dcK4+mWK0RCdyO8ikAxKJkL30Pc+LmNCAY4oKzF+wvoUMv4TJN
         vFemQWAni9uVer6e2IFtc9+0Bn3sNFbxbPEj5I1GzKjXhc6rhin82rZeUfQ8IHbyUx
         uk/s4bO9MhQ6bHDAlW4WUzKyjOXZeUwVRTX99QLpk4jtEoVuBmN2SR6blmjERdOiyY
         9WFcjPJKmXOiA==
From:   SeongJae Park <sj@kernel.org>
To:     martin.lau@linux.dev
Cc:     SeongJae Park <sj@kernel.org>, Alexander.Egorenkov@ibm.com,
        ast@kernel.org, memxor@gmail.com, olsajiri@gmail.com,
        bpf@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date:   Wed, 28 Jun 2023 16:46:11 +0000
Message-Id: <20230628164611.83038-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__register_btf_kfunc_id_set() assumes .BTF to be part of the module's
.ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
the function prints an error message and return an error.  As a result,
such modules cannot be loaded.

However, the section could be stripped out during a build process.  It
would be better to let the modules loaded, because their basic
functionalities have no problem[1], though the BTF functionalities will
not be supported.  Make the function to lower the level of the message
from error to warn, and return no error.

[1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/

Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
Changes from v1
(https://lore.kernel.org/all/20230626181120.7086-1-sj@kernel.org/)
- Fix Fixes: tag (Jiri Olsa)
- Add 'Acked-by: ' from Jiri Olsa

 kernel/bpf/btf.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b682b8e4b50..d683f034996f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 
 	btf = btf_get_module_btf(kset->owner);
 	if (!btf) {
-		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
-			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
-			pr_err("missing module BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
+		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+			pr_warn("missing vmlinux BTF, cannot register kfuncs\n");
+		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+			pr_warn("missing module BTF, cannot register kfuncs\n");
 		return 0;
 	}
 	if (IS_ERR(btf))
-- 
2.25.1

