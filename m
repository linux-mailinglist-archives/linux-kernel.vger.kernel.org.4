Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9600473E73B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjFZSLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjFZSLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6E10C1;
        Mon, 26 Jun 2023 11:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98EEE60F30;
        Mon, 26 Jun 2023 18:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B96FC433C8;
        Mon, 26 Jun 2023 18:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687803095;
        bh=2U52dcWmqtT+N7qp8s667kFTtabBWUvZfK1aeU1/FE8=;
        h=From:To:Cc:Subject:Date:From;
        b=elzxVr08Xovc7Dg1NIDcPOJEwiTpTvW8iJxSpC8bvAMtqRAbW3nRD17TFPtBZNiLO
         6ITijiI5XIuwMaHoB20aLVj/oQdhZrrRCn+i+LqN4h4RPHoQTp273MzXv2kh9g/xw3
         VC4sZyY1sCRz4r6rRi6DlPVNU+ohBOGgiApkJnS72iQ8a7dWgVZuoKFYA4cqWaQpst
         RVyKrk27vo+rH9LXtBvQp3pc63wSOxpewfgB1ElwAVuPwVDOOjrLhNfk1UVTl84t1s
         zp/OL48ZW7d9OuvUPM6mChk3Sgapg+64aMs+DhZXn5CWmix/+wRquRTAJJNiHrcBCu
         J7yY4Nmsvnkgg==
From:   SeongJae Park <sj@kernel.org>
To:     martin.lau@linux.dev
Cc:     ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date:   Mon, 26 Jun 2023 18:11:20 +0000
Message-Id: <20230626181120.7086-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
Cc: <stable@vger.kernel.org> # 5.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
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

