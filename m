Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5F72A826
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjFJCMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFJCMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:12:09 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E4035A9;
        Fri,  9 Jun 2023 19:12:08 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2565a9107d2so1203580a91.0;
        Fri, 09 Jun 2023 19:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686363128; x=1688955128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uono/nwyy6EGIB3S/PXdMtEwaggYlfpIknOEvbCtnJ4=;
        b=UxlLTjG1QwkpLJVlI0Dsn428ZEpU0RdVaf61Qj9hrqOjHsrNaVnDoWnbH/yH4B/raU
         DF6/Mza4cqkPEQBWcViDkU84GeTfSTpd1v1Kt4m00JPc7JPF73mjbeEp1RrJPpkoge+Q
         e52Eo6tds8EIjK+zlaw6xFK2U1mO8aWUxnsNH3uFm7ZWGaKGC2UXCn9Vjzcc1gbpZy/i
         xfnxgc6aR2UqfOgbHdsSdt/n89CaueXaSRf7gtKM+HyIl7Ig8ZgnphnPcVwnI3uQSiu5
         h4CJLQcTlMJA5eq7waqspv+CgW9x2KyKK49E2Dgbo+2wg6PQfbnmLbqB+XOyymNyhjqf
         qY/g==
X-Gm-Message-State: AC+VfDzZ9hlp/Vt79NPY1qzvGwChCJOWuZvZ6Ijs/nMhMAXNI55JnOnG
        0yYPTBmim5PhdsKFenOB5UzbpOh/VUnMtA==
X-Google-Smtp-Source: ACHHUZ7kZJrNmG7xjdOyI7pxuUk8NTtD/i0/zWXZuSVbn+d7hXEyrJ5OvyyJkKllNX9KQXL6tEPrWA==
X-Received: by 2002:a17:90a:7104:b0:255:d878:704a with SMTP id h4-20020a17090a710400b00255d878704amr2882029pjk.4.1686363127368;
        Fri, 09 Jun 2023 19:12:07 -0700 (PDT)
Received: from dev-linux.lan (cpe-70-95-21-110.san.res.rr.com. [70.95.21.110])
        by smtp.gmail.com with ESMTPSA id pq8-20020a17090b3d8800b00258bb7e8b47sm5251594pjb.50.2023.06.09.19.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 19:12:07 -0700 (PDT)
From:   Sukrut Bellary <sukrut.bellary@linux.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Sukrut Bellary <sukrut.bellary@linux.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] accel/qaic: Fix dereferencing freed memory
Date:   Fri,  9 Jun 2023 19:12:00 -0700
Message-Id: <20230610021200.377452-1-sukrut.bellary@linux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch warning:
	drivers/accel/qaic/qaic_data.c:620 qaic_free_object() error:
		dereferencing freed memory 'obj->import_attach'

obj->import_attach is detached and freed using dma_buf_detach().
But used after free to decrease the dmabuf ref count using
dma_buf_put().

Fixes: ff13be830333 ("accel/qaic: Add datapath")
Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
---
 drivers/accel/qaic/qaic_data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index e42c1f9ffff8..7cba4d680ea8 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -613,11 +613,13 @@ static int qaic_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struc
 static void qaic_free_object(struct drm_gem_object *obj)
 {
 	struct qaic_bo *bo = to_qaic_bo(obj);
+	struct dma_buf *dmabuf;
 
 	if (obj->import_attach) {
 		/* DMABUF/PRIME Path */
+		dmabuf = obj->import_attach->dmabuf;
 		dma_buf_detach(obj->import_attach->dmabuf, obj->import_attach);
-		dma_buf_put(obj->import_attach->dmabuf);
+		dma_buf_put(dmabuf);
 	} else {
 		/* Private buffer allocation path */
 		qaic_free_sgt(bo->sgt);
-- 
2.34.1

