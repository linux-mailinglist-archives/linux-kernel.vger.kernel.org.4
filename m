Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65B6FFBE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjEKVex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbjEKVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:34:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA63A9B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:34:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643990c5373so9262381b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683840889; x=1686432889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+0/GVZgLBH6PMkReAmP7J8wDURjmtx81m3HSPypGMA=;
        b=jaNXHgOsOc00cBPbE6wx9gckIw2Q/Um/cKSBDT2gyxXE5t2692YhDFoGrbxBzaKGpz
         fX1qUuRiG7BqMGEb6gWUkI9GBpnS6wPZpOhfYu7mu30SwaBpiNMxc+Ig0Rqc5DufL4RS
         AqDHQzqAg+72MtBDEp+tAC3aLLMtJavmkawLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683840889; x=1686432889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+0/GVZgLBH6PMkReAmP7J8wDURjmtx81m3HSPypGMA=;
        b=MLi3mBdQjEcqZDQTOOuCNu2dev6WvMsqRCG4XnT5W+KSstrRKKX/3WV8MeZV0I+ya3
         V7cJyTREEhv2IKpzNSYLSZTV5sIlqgX7SmZ5qjLgMXWb3Io+m85PXrJekzvAyuEmtqWT
         k38OCrqWE0g3MymIOn6xeHIvfgzOheJMZqxitF8TyTG9oNq9hAk+ItL/aflxj9plln9i
         BofeFrYx5PGhObYEQD9gGWT4t4xaGibIW+IUU0Sl0L6u+qi9QIsi5jHo5HvHTWXgzpve
         0gXaHf3vduHD9pwVdVxfc/YDlDLQfWxwFO8EW8gxFDmfZUKvK/MEOcWhIDQk5Tsbi503
         3/7Q==
X-Gm-Message-State: AC+VfDwm/BUqaxR3g+fzS2PaM8lHR4nDQKYt/Sj+NclgvOa4jkQa8NP5
        NAqoXtEhfA0wjp4N3u4V2BAKSXD8Th92YnAkoXMewQ==
X-Google-Smtp-Source: ACHHUZ6aIVQi2PoT8nJNkXF7lJUrXqlz/U4E4/5bAfucHx/weKzuj5vTz8HeUezW4TkZKZWK6UC36A==
X-Received: by 2002:a05:6a00:88f:b0:648:24c1:fe5a with SMTP id q15-20020a056a00088f00b0064824c1fe5amr11096650pfj.16.1683840889532;
        Thu, 11 May 2023 14:34:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020aa7864d000000b0063b85893633sm5723353pfo.197.2023.05.11.14.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:34:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible array
Date:   Thu, 11 May 2023 14:34:45 -0700
Message-Id: <20230511213441.never.401-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; h=from:subject:message-id; bh=RrVUNVC3gegju2xKIW8jFRuLI/RiqJcR7VGQB4D/Evs=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkXV90iD6pl1iKdfr2Ps0RyjFlScFvSso0BrIaopyd ZQOueMqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZF1fdAAKCRCJcvTf3G3AJkTuD/ 4guSJdw3bNVmQ7eEYndRa0y3hZ2G3lDOgGzJbSemtYsubbOwoTLZe+nua0LcHDXyY5X27tNGTi+1SL M2w1+4cS74i5Wv7ig0XOjBlSTXJv99aZdTWoek/gPqxzNo/1Z1rvK+EO4jGYYR3eDZJhwpq0iP3REc OeS7z8lj2kaaaSmDPEwUlWqep+kgbb3uZoKAkxnOKRW8s3wLomio5a2iVMLTyohD92ibYs3j0eL7R3 CBOdQ2ZCrCz7kg0RkqC1mytmxEICPDNZokdROVAkKxlnHn03DVS+hQ4L/ytYUIF/LMXwRbP4y3wJWm UPc533JZYrKt1BpU7ubrsfXcuXcgrHRPvy91+GpRdUYNqIJbSwyn4gDo5UTSZs0S8B2m065X0BHcG/ 96PPWKo/woEwMCfFCTS12eG/zQrfrtQuwoCwGnzpwHfVw0r4GGRyv65ck8IRczuKsADvUdhiW5nKjT wE3i70lGdoI8OuMv1xbQVQLbm/Wapp+Xr/ff8uJWd4te9iULOl3bctVgAlTLGcn1bHZiwC7shh+vBE hEYELPR++NZekxFdRZr3ylL6b3TYMspR3f3aGPt1Je0uKcUIhYDuQFck85l2c3/lOikRFyW9ftK6/o GxUiMHjtwTAOBBNZlX0e1ylDvTaN+Gw1flVjeJt5AkPKxUwAp8O/Fqg7mnkw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the ongoing effort to convert all fake flexible arrays to proper
flexible arrays, replace aa_buffer's 1-element "buffer" member with a
flexible array.

Cc: John Johansen <john.johansen@canonical.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
One thing I notice here is that it may be rare for "buffer" to ever change
for a given kernel. Could this just be made PATH_MAX * 2 directly and
remove the module parameter, etc, etc?
---
 security/apparmor/lsm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index d6cc4812ca53..35eb41bb9e3a 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -46,7 +46,7 @@ int apparmor_initialized;
 
 union aa_buffer {
 	struct list_head list;
-	char buffer[1];
+	DECLARE_FLEX_ARRAY(char, buffer);
 };
 
 #define RESERVE_COUNT 2
@@ -1647,7 +1647,7 @@ char *aa_get_buffer(bool in_atomic)
 		list_del(&aa_buf->list);
 		buffer_count--;
 		spin_unlock(&aa_buffers_lock);
-		return &aa_buf->buffer[0];
+		return aa_buf->buffer;
 	}
 	if (in_atomic) {
 		/*
@@ -1670,7 +1670,7 @@ char *aa_get_buffer(bool in_atomic)
 		pr_warn_once("AppArmor: Failed to allocate a memory buffer.\n");
 		return NULL;
 	}
-	return &aa_buf->buffer[0];
+	return aa_buf->buffer;
 }
 
 void aa_put_buffer(char *buf)
@@ -1747,7 +1747,7 @@ static int __init alloc_buffers(void)
 			destroy_buffers();
 			return -ENOMEM;
 		}
-		aa_put_buffer(&aa_buf->buffer[0]);
+		aa_put_buffer(aa_buf->buffer);
 	}
 	return 0;
 }
-- 
2.34.1

