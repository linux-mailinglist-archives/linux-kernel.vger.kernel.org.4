Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D36CDB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjC2OC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjC2OC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:02:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B9349C7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id fb38so10354869pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680098549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqFkGHmM/dJ9kF1cZmCY3mrpL1ZG3gGE12XFAvwXSFw=;
        b=HisIVLRzBGWL4CTLcww9FAC1lhsk226n5Y41WJOtDooXQq5Mt/FuBCKZVe9LKUHeM6
         KOjnzJ4IF7WbCVXkRHYxkA//f8+WyCeVttTF9wSXc8bvBigOfPbV1+XPtgi8osHoF3vT
         ViY41U4S0hj29xCR1WWWk0ylrPzTtxBJuKvE3lIoZsH/a+WTP7ataKW+30i2GU2P0VIf
         Ec1hToZP79eigouQgKZOtwmzWnIdUv3Kse1/UH7G4912tD+dqaTgL6LLMQvBlPJgu80+
         W8wnUbhCXgxrv5Drk5Bo+c7eo6PXXTTvkuh0u6pt6ouCK3CyI/cUYVisjMuwhJAkUbVt
         xcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqFkGHmM/dJ9kF1cZmCY3mrpL1ZG3gGE12XFAvwXSFw=;
        b=j4etMBuk8ORjcbhVqJDvm1xWt2mY/yqX8QyVWlPzyUeO/Ucd/wrJLVRMv3A+yWOxjX
         dm8942G0/tJbRhrOdTnXxe7YMc4oJQd8cyQDU6F7zzn1O9GHJwOB2dPg40ln42SB+6vX
         S5fmz/SHndbMdb0+92XNfAECCgPSIkl83pgE31FLcHwzWnsHdoMJI2zPYqKZRkYEiUiV
         x1nmeFetlSNzGjF26WKEkEjCgwvE9u5/F/LrqozMJkwKKs9kXA1s2l/V/KrkQ/rbXYqE
         8NTg3cVQACX6iRtUWiRwkSTHGM6uoLtAeTuLfB3mSH5sXAlhWwHY/nC8KchkIOIYKDSl
         XAEA==
X-Gm-Message-State: AAQBX9ep43bspq71NdBibVVHf88b45b0+2aUPzwuLTkHzcNH4qTK84p8
        Loiye8ZFg5LidBugf1iaCClTpw==
X-Google-Smtp-Source: AKy350aIQGtdpdkmlvis3jdpff7WI8LKw5KfGcE0+/FdziyL8/vsa6HJF3dMnqGEngmO2GEwEv/E+A==
X-Received: by 2002:a62:cfc1:0:b0:625:ebc3:b26c with SMTP id b184-20020a62cfc1000000b00625ebc3b26cmr15854390pfg.22.1680098549382;
        Wed, 29 Mar 2023 07:02:29 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b006288ca3cadfsm5399468pfm.35.2023.03.29.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:02:28 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, hsiangkao@linux.alibaba.com,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Wed, 29 Mar 2023 22:01:55 +0800
Message-Id: <20230329140155.53272-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230329140155.53272-1-zhujia.zj@bytedance.com>
References: <20230329140155.53272-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 86892f471e761..b0f4dd6384128 100644
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
index 26e5f8f123ef1..4a87c9d714a94 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 8e130de952f7d..b8fbbb1961bbc 100644
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

