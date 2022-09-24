Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92E5E880F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 05:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiIXDwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 23:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiIXDwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 23:52:33 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F1DED4A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:52:29 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso1944812pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=3G1VrrLvYJ7MrbsK19m22XFQRvd7YcWq9IeFy6ACQL8=;
        b=ZGVol1yELnKxk4dcEnCedM7bJb/8peWOv3+7+hiWKQwLeztgyVcfkwVQreKRbVccXK
         JngNzDQVyqvPU+pSQoMSuEfT5jOn2lmjRVSWmaKYsc50NcAe1qcsVsij7rwik5PliFov
         191rStdu4autyXYfBDxuuxq5RSsqW86+qWqhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=3G1VrrLvYJ7MrbsK19m22XFQRvd7YcWq9IeFy6ACQL8=;
        b=LY4bQ98prbt8RokHUNeuClF5B0X8AY6dUiBJmQgtTjqp2/cZ83ELNN+C9YBXQuSk35
         CEnzH8pBEiuGMfZFxwN7JOGbtk0JNhsx4B4TxUpCFSOBMXohuC3t/98+RE2luw9Q7E+t
         8Oymx5Fm+9Ck0hJ8VsSpp6w55lKyKIWkm3M8ZW4VQmQCPyWaa+x5OZFgkXJ28r7om8qg
         fgIgO/Bvud8vHGTK9oGydYSnEal/cqzXOfINQwfB5ttR1HyQfUEBqLcSwu+SZNqj9oMa
         3hIQeQIf7S9Tgy88URuJEv0AnubMU+REQUZGuzWWfo/n0a0iEs4tITW30tsJTQDdjKWt
         mrnQ==
X-Gm-Message-State: ACrzQf14i85DyPnOYPkcIgwQ2+huCLblnRGUDqX/7NqYh0LTvBvoOxGW
        TCgezaFG8iOqUpkiAJOgv/9C9w==
X-Google-Smtp-Source: AMsMyM7rnV2yIjKRf0nltcgFw8A9YXNZErvQrcy80Et2nD0M74m5fnkvIhGCvlr8i5XgmYrnMTnW2Q==
X-Received: by 2002:a17:90b:4f90:b0:202:9be9:2c92 with SMTP id qe16-20020a17090b4f9000b002029be92c92mr24644365pjb.140.1663991548677;
        Fri, 23 Sep 2022 20:52:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6-20020aa795a6000000b0053abb15b3d9sm7492138pfk.19.2022.09.23.20.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 20:52:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christine Caulfield <ccaulfie@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] dlm: Split memcpy() of struct dlm_message flexible array
Date:   Fri, 23 Sep 2022 20:52:26 -0700
Message-Id: <20220924035226.3359297-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; h=from:subject; bh=e/Y6GTN0SCVQ259nA/pYwlFozQeGo0Cl6K1VpFhG2NE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjLn75X8LVs9287oq0AOqk6fbfl+f5Dh2O94OSeNFT BKSCt3iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYy5++QAKCRCJcvTf3G3AJtFrD/ 9Auvgp4BKi9bKLLuhvLc/e/O1WDJsOFfuNo6xlL0Xxa1D97BC+ujNjbyj/GdCB94rJesYm9EjqgR9r pElxGT9NyZ+UiAThiQZEwy7SLXa2Yo6qq5eR99rppLpm1JtU/SduOCUqUEc06k6AqNBizpJyLwwTXz t12Mn9xZYWjzZrgr7syXWkFSjQAIqiy3xmDbYeFZzRc3SyWbu/K3jCrJwZfRFnxCngJ9dKHtvLBsCU 4lFASXpkFsPGvWy51J3wAFTccWeqg7u/mJLIq6sG8N+MWUXVqOkdSBReA/koc21tIknyinJKvhcxc1 vy9iRiQrEhG4czlnJStU2wv/YK48Jrz9jpvPWGgioWkGeHj9GX9IvcN5vJES/4uyJRe+y3QGops8Ch m3Vtm9AviVzNO6hkLBFgNbE9QyFjp6DfNJerwNrn9X4TN9M0heZmNkLDtM9wEMzFa/2ebOUauYzcIk llXFIXE74Xmfn+hAs2gwW8CI6CDVe7pQsC8Eew2fri1vXFtJjwV/Lg3/wzpxxKKixCoN/J1Z/ZoFqz OmE08kuUfMPGbCE+dfkMRt5a7aD0xuSrbTzIhnLa4R1r6m2y/j2/RBofyLao1CpX1tRBbVmka+bLBh BpYILJHURIleLwR3p8UBMg5WMtI9M+UzAFy4NhXoWCkDr12hhvS3tpk1BiEQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To work around a misbehavior of the compiler's ability to see into
composite flexible array structs (as detailed in the coming memcpy()
hardening series[1]), split the memcpy() of the header and the payload
so no false positive run-time overflow warning will be generated.

[1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org/

Cc: Christine Caulfield <ccaulfie@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Cc: cluster-devel@redhat.com
Reported-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/dlm/requestqueue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/requestqueue.c b/fs/dlm/requestqueue.c
index 036a9a0078f6..63f45c3c53a2 100644
--- a/fs/dlm/requestqueue.c
+++ b/fs/dlm/requestqueue.c
@@ -44,7 +44,8 @@ void dlm_add_requestqueue(struct dlm_ls *ls, int nodeid, struct dlm_message *ms)
 
 	e->recover_seq = ls->ls_recover_seq & 0xFFFFFFFF;
 	e->nodeid = nodeid;
-	memcpy(&e->request, ms, le16_to_cpu(ms->m_header.h_length));
+	e->request = *ms;
+	memcpy(&e->request.m_extra, ms->m_extra, length);
 
 	atomic_inc(&ls->ls_requestqueue_cnt);
 	mutex_lock(&ls->ls_requestqueue_mutex);
-- 
2.34.1

