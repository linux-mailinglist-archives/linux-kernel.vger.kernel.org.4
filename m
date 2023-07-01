Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF0744AA4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGARO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGAROz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 13:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB901FF2;
        Sat,  1 Jul 2023 10:14:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A43D660B61;
        Sat,  1 Jul 2023 17:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3811AC433C7;
        Sat,  1 Jul 2023 17:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688231693;
        bh=hMsiFA2hQ67p3GRfHf5DpEvwd2EB5lcU/ks331R0sgs=;
        h=From:To:Cc:Subject:Date:From;
        b=WpiBVRcXXPqUP2guWne88aAmNf+tqPvo4MP0c1/h3rz7A5bxv6Q6dsNVMgoZ/3uUm
         3U54MxnIAGSmfOB2D5How2kl9lo8hqX3F9S1R3wWAuAF0XWwa6EO5wn8tH4HddXWhN
         Hq1STedO23p1QACDpvFlxkCfeFsrDuYRdYoaaSZIAMt8OPl6pvLuxplaMOksvWOv/o
         r01OXVLAgwpGkt/WaVAdWAwYkt7IQOdijbHWqBIm7yBWM9s3U9gPe7zppwH+VwhqZi
         Fbqn889ovI2PtIZlkXbfyjOr30EjwZTDj8G3+Lq4TZSPjZpKeMLOU0P1ZM0j1CnFsK
         YwA1NMFNhFdGw==
From:   SeongJae Park <sj@kernel.org>
To:     daniel@iogearbox.net
Cc:     SeongJae Park <sj@kernel.org>, Alexander.Egorenkov@ibm.com,
        ast@kernel.org, jolsa@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, olsajiri@gmail.com, bpf@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date:   Sat,  1 Jul 2023 17:14:47 +0000
Message-Id: <20230701171447.56464-1-sj@kernel.org>
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
Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Changes from v2
(https://lore.kernel.org/bpf/20230628164611.83038-1-sj@kernel.org/)
- Keep the error for vmlinux case.
Changes from v1
(https://lore.kernel.org/all/20230626181120.7086-1-sj@kernel.org/)
- Fix Fixes: tag (Jiri Olsa)
- Add 'Acked-by: ' from Jiri Olsa

Notes
- This is a fix.  Hence, would better to merged into bpf tree, not
  bpf-next.
- This doesn't cleanly applied on 6.1.y.  I will send the backport to
  stable@ as soon as this is merged into the mainline.

 kernel/bpf/btf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 29fe21099298..817204d53372 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7891,10 +7891,8 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
 			return -ENOENT;
 		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
-			pr_err("missing module BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
+		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+			pr_warn("missing module BTF, cannot register kfuncs\n");
 		return 0;
 	}
 	if (IS_ERR(btf))
-- 
2.25.1

