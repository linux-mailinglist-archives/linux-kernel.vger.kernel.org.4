Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BC76653C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbjAKFiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbjAKFgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:36:54 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0FE11157
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:25:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso15911996pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIpHcwHuLOh4SwnFnBbeF8LhMIZd7B1uohTZsNHDUqE=;
        b=lSpQZ5Nl1oGZSNpIMCryP8PrFoR67A6GlkkwW9vZo8CD5btOX8PPc93muHthaWNoKy
         D7CXmW0L+PtqlbTMaYsKksxeEXV2J8Jtlorc6bsUuGpLizxf7K7risMkBcP7+WH8b4d9
         cmYK91t3GBHw7IxZT/XQM/4Bv0vbcGPGoMvsNB167guolV2JvVEHqur5YyX67Zk2uC+5
         9iNih8DPSpq0lJeRqR3bo99I4HxVwMdBli9ioY5G6clMrBrOWbm53/xq9j/SZtwlfpgh
         SLY8jNvHJbxEAnHLYa/sF6JQItsls4Pvnu846zRgjyotBkLOpjMHwXFe+ZI6VsWsBBNZ
         bOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIpHcwHuLOh4SwnFnBbeF8LhMIZd7B1uohTZsNHDUqE=;
        b=46txjF7TMjFXesbagIAKLWcgLyiUdShRiubb0D/c8+BckpkldV7LLtqgCMYAcH8KHD
         LpiH1U2HOi3j9AoxiZjG6usQHGgmoGgWPyqT9YUoaLmTJ7xopbwz8EsLQa4vAKXVZ9qG
         2xAR66AL64CgMMJHi/LkjW5fzgN7oeN/o2Pp+k7I/Vr+JMWiiXbJkT4wVYbwxJ2rFu3U
         uHPoUnl+BwamTf5PBn3TRIm+YJdwnYlBsmZveJYE+WDIUqYZgsL2VKZWEiDsJxCgI1lr
         tWFjniIRQPjbtZvGinr/TprnUD7kn7J3sXQeB7OrupQs/4tPNU/vCW9yPf2os9ShKI2t
         R71g==
X-Gm-Message-State: AFqh2krOh42yRvUoH7OZf88ESKIafqpYcPa9/LO9qo2GRhekqr09uOOp
        ddVIGP5VKZ/EtHDwfQa7L1Cz9Q==
X-Google-Smtp-Source: AMrXdXvB7/2u85kjEwGxlcNYhbcb8dmOh3QsdpsZJEqb49naEuncdonDNg0WEQwkdPL58RcJMt18ZA==
X-Received: by 2002:a17:902:9a0b:b0:189:d3dc:a9c4 with SMTP id v11-20020a1709029a0b00b00189d3dca9c4mr65777152plp.36.1673414746818;
        Tue, 10 Jan 2023 21:25:46 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm4934520pls.244.2023.01.10.21.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 21:25:46 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH V4 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Wed, 11 Jan 2023 13:25:15 +0800
Message-Id: <20230111052515.53941-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230111052515.53941-1-zhujia.zj@bytedance.com>
References: <20230111052515.53941-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, in ondemand read scenario, if the anonymous fd was closed by
user daemon, inflight and subsequent read requests would return EIO.
As long as the device connection is not released, user daemon can hold
and restore inflight requests by setting the request flag to
CACHEFILES_REQ_NEW.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   |  1 +
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index b8d8f280fb7a..5d9ec62cdd5e 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
 #endif
 	{ "",		NULL				}
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 3d94990a8b38..e1f8bd47a315 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -301,6 +301,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 8e7f8c152a5b..711b47448c85 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -182,6 +182,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	return ret;
 }
 
+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
+	 * requests have been processed halfway before the crash of the
+	 * user daemon could be reprocessed after the recovery.
+	 */
+	xas_lock(&xas);
+	xas_for_each(&xas, req, ULONG_MAX)
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	xas_unlock(&xas);
+
+	wake_up_all(&cache->daemon_pollwq);
+	return 0;
+}
+
 static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_object *object;
-- 
2.20.1

