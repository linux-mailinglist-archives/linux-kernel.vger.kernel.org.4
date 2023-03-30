Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700926D066F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjC3NWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjC3NWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0F1BD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680182481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UMgOcaBYHmqhOkJHME9qiHTqpNNGWfEaKghbG+Vz4mM=;
        b=LgYtwN+tZjcDF/k9qlae8C3tMfYZjqYFwkT/5Js9Few0m9imTnx3+RiMHPzwTMnJUr9aiy
        V/ViynQZWrOEbkE+zW0KA6Nc8MKIEtqxxjeiGJLKX61icJ2h5llHgeynr8m2dWbHNDNFKL
        v1/AtRrRNozktYFORJHh2T3rZnsWjIk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-mYeZ7VlTPDSiznLOUuqDXQ-1; Thu, 30 Mar 2023 09:21:18 -0400
X-MC-Unique: mYeZ7VlTPDSiznLOUuqDXQ-1
Received: by mail-qt1-f200.google.com with SMTP id x5-20020a05622a000500b003e259c363f9so12387891qtw.22
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 06:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMgOcaBYHmqhOkJHME9qiHTqpNNGWfEaKghbG+Vz4mM=;
        b=WqDFgMd2gPeN/xmehT5cjxRGQyzd4T0vdSncahUmbYunItw9OH4eRk2S70vJTejGRF
         V00txOFGl9x7qshPJ6MIrIAe+2CQCqIRHdNHhIPV3upuhYeuo6BythF/TiF6zYvqRWm9
         YJSZvzNIlfaq+gzBWLs8730Q4PuaRlyIiqmeDQUtJDI8k9uWtQO5TjfgaDNC0dApNCpD
         c+9me6uLS4K+RZA+prKq6UtkXCwjIJCuiqvk3D9b1+5NyWboAqva0A9OuwUOskQU1fSM
         8ik4scuRfddTd/fNN95u+f0288qWIjG3jr6Jc/NMdFRdAvY4kUj0gEwJ+QXZR2AnmYSs
         zXng==
X-Gm-Message-State: AAQBX9fIKvfqeOxzM1YifOqa6jJwsWwjFA6xM4Vjqr/Zw252P7uqDaJY
        pKNo2MjhFkgIgnnozymT9CEYMCptAUWJHCzrv+Gzg3z8MB5ru2LgVv20ngcdLhPrsq1zWuJAWlN
        YqMz11uA8w4LzffKPODVt4og3
X-Received: by 2002:ac8:57c2:0:b0:3b6:3a12:2bf9 with SMTP id w2-20020ac857c2000000b003b63a122bf9mr41512590qta.2.1680182477788;
        Thu, 30 Mar 2023 06:21:17 -0700 (PDT)
X-Google-Smtp-Source: AK7set/gzHee0RWTGrj5XptDSoc7k80mtN1LbJfu1rmyF743GurwDMiR8L9IeT+B4QfnE1T3ZSvMjQ==
X-Received: by 2002:ac8:57c2:0:b0:3b6:3a12:2bf9 with SMTP id w2-20020ac857c2000000b003b63a122bf9mr41512554qta.2.1680182477546;
        Thu, 30 Mar 2023 06:21:17 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id fu48-20020a05622a5db000b003b9b8ec742csm17026168qtb.14.2023.03.30.06.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:21:17 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ccaulfie@redhat.com, teigland@redhat.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] fs: dlm: remove unused count_match variable
Date:   Thu, 30 Mar 2023 09:21:14 -0400
Message-Id: <20230330132114.1826399-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
fs/dlm/dir.c:67:26: error: variable
  'count_match' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned int count = 0, count_match = 0, count_bad = 0, count_add = 0;
                                ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/dlm/dir.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/dlm/dir.c b/fs/dlm/dir.c
index fb1981654bb2..982f7a5570fe 100644
--- a/fs/dlm/dir.c
+++ b/fs/dlm/dir.c
@@ -64,7 +64,7 @@ int dlm_recover_directory(struct dlm_ls *ls)
 	char *b, *last_name = NULL;
 	int error = -ENOMEM, last_len, nodeid, result;
 	uint16_t namelen;
-	unsigned int count = 0, count_match = 0, count_bad = 0, count_add = 0;
+	unsigned int count = 0, count_bad = 0, count_add = 0;
 
 	log_rinfo(ls, "dlm_recover_directory");
 
@@ -158,14 +158,6 @@ int dlm_recover_directory(struct dlm_ls *ls)
 							     b, namelen);
 				}
 
-				/* The name was found in rsbtbl, and the
-				 * master nodeid matches memb->nodeid. */
-
-				if (result == DLM_LU_MATCH &&
-				    nodeid == memb->nodeid) {
-					count_match++;
-				}
-
 				/* The name was not found in rsbtbl and was
 				 * added with memb->nodeid as the master. */
 
-- 
2.27.0

