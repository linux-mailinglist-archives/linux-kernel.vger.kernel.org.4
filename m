Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6EB749D74
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjGFNYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGFNX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:23:56 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CEF19B2;
        Thu,  6 Jul 2023 06:23:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99357737980so86757066b.2;
        Thu, 06 Jul 2023 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688649833; x=1691241833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfq6WYxVSO9JeB8ozbXX3nHOjEAETuGaBGIng4Pfbz0=;
        b=e31PJQYujr3guQn3Cv+W7D/al3dKcNleToEpFiYWrRtTlBF8sB9PfVpte2Y7xdjhP8
         H6fbafj22OHyDemnVEGo0gi4roik7NweiIMFQSqlwiKiP2y4lMnpL01Mw3sZIHuw2Rj2
         14n+V5UwYkdrrTWbaBcegz0lRI+9MhdNhYW63lQ6Es/yPX1E3I+ZelDgUpanZGshPdXT
         h3U+MfzfOOrFRpTffhFzpt7EHprJwb1c9NSgr1V4aeW5kJ8M1dZhvIrAT3wCts86Rb8a
         VNI47X0R+SuWsTJ+qVSmVlgHVLQd+tfvUEBDVh0dkFoJtXl+mwir9F0YsRMccV4B6Vn/
         e9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649833; x=1691241833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfq6WYxVSO9JeB8ozbXX3nHOjEAETuGaBGIng4Pfbz0=;
        b=DjZ4D1/mM924btCyEkxE9NeNiOup0Fn2ExNlBVENOllRqj4YqshWffOZ/3eL4nV7h3
         F7p6J30ESEEOKrkz/KJaB7l9/B5S3Uj1PZgBTmWUmP10HxjHFn5efegczIJ9URg3rjQA
         PWWtkGZoHs83x/CZlKC+8+3xijavOJXiXtruShOGXqj3JTqUjFCD0eHdcx1/Y1K58Pic
         OmEoFMro4CzUIQhecT4bTiGpvdQ3hNZGLEM58jkXUqelvwYBimGrul0kRohDfllUP7Mb
         +6NNAZ581qhi0N7AD6l95jJSoEqlSc3i0FEiLs+pVvIK5Qh19wK5yKRYHgz2WP8TpZDI
         75BA==
X-Gm-Message-State: ABy/qLa3feTNpwptDhk8Q3ntIBxgZQhQoDBUBpSlZXLXK15d/Ers10jA
        8TAr1R+7uUB7PI+H6OcaXwMjanJ4aP5VHnct
X-Google-Smtp-Source: APBJJlHL6DEX2HS00rwi3YugSfpPimVTvX9szr0T8h0aG4Eix+fyb+06sCjw/rJr6KNEN3K2O5VgdQ==
X-Received: by 2002:a17:907:d8d:b0:973:fd02:a41f with SMTP id go13-20020a1709070d8d00b00973fd02a41fmr1897793ejc.40.1688649833214;
        Thu, 06 Jul 2023 06:23:53 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-008-088-179.77.8.pool.telefonica.de. [77.8.88.179])
        by smtp.gmail.com with ESMTPSA id r2-20020a170906364200b00988dbbd1f7esm808024ejb.213.2023.07.06.06.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 06:23:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 09/20] selinux: status: consistently use u32 as sequence number type
Date:   Thu,  6 Jul 2023 15:23:24 +0200
Message-Id: <20230706132337.15924-9-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230706132337.15924-1-cgzones@googlemail.com>
References: <20230706132337.15924-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the type with the one used in selinux_notify_policy_change() and
the sequence member of struct selinux_kernel_status.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/security.h | 2 +-
 security/selinux/status.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 0f93fd019bb4..a16c52d553e1 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -376,7 +376,7 @@ struct selinux_kernel_status {
 } __packed;
 
 extern void selinux_status_update_setenforce(int enforcing);
-extern void selinux_status_update_policyload(int seqno);
+extern void selinux_status_update_policyload(u32 seqno);
 extern void selinux_complete_init(void);
 extern struct path selinux_null;
 extern void selnl_notify_setenforce(int val);
diff --git a/security/selinux/status.c b/security/selinux/status.c
index 19ef929a075c..e436e4975adc 100644
--- a/security/selinux/status.c
+++ b/security/selinux/status.c
@@ -101,7 +101,7 @@ void selinux_status_update_setenforce(int enforcing)
  * It updates status of the times of policy reloaded, and current
  * setting of deny_unknown.
  */
-void selinux_status_update_policyload(int seqno)
+void selinux_status_update_policyload(u32 seqno)
 {
 	struct selinux_kernel_status   *status;
 
-- 
2.40.1

