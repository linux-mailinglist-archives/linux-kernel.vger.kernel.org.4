Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1B6FF191
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbjEKMc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238002AbjEKMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:32:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8358749CC;
        Thu, 11 May 2023 05:32:43 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965ac4dd11bso1696294066b.2;
        Thu, 11 May 2023 05:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683808362; x=1686400362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UgBzRU2uzV6XtIpRwtsK9Z2OAn4rY86ByIz0hF5YH7o=;
        b=fKCyLvQpJWN+ijF8GWDrLH9ehTGQE0KsXkAjZxM35ki3X3vx59D0pIqoph9fKAHmNn
         l0ME89DxdGx2vpOhdNI1Azj8YNlRJBQerZkMcC0YUi2hcDJ8Wq1GX3tPoOU2F504Ednw
         /IdLt0jb1+O+tgKST3w+4mIKcPZBExmI17Tnm49TDZNwLamqbAIYnxYD8eZAV3fHJU6D
         JVEdXCcNpXSagdQ0YwoCQ7mbtENDsAwk6uYAcbqdkHL7yhrRoNcF2FP6DqWTXc8PkWS1
         5xlDkLHR/bDifLxBpyO2tP+7ZhLkG37NJBbDy2oQIQj5sNffA8BgKQ8Pf60DhcrqBqpg
         Ktbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808362; x=1686400362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgBzRU2uzV6XtIpRwtsK9Z2OAn4rY86ByIz0hF5YH7o=;
        b=VqIxBRLGLNENMb5s7RJZrHJhX5J0RezW5qhtcpKavP/v5h17lY87KDOjYU6KIT2eyz
         TBiaf4ML9eh/KQl8cKnKuqPFYwsxKqGPOqyqxBJYbEP2SUjevjaBiV6HX+V/qpLIWD8q
         2snG5AUnrE74xmJ48XJCd882B8pZrN7HtxfuhBebrVBVFjknIryS1nsW033HDUQoMxLe
         Qwydp6S91GR3fxQE1/H+ylqTtJE4EFEfROi5JtqWGdjRH1ND0byOR3IgG09Fy2MFp3SA
         c5SvrBBPsyPJbK/jSmgdsW83d1UefNgZUUB71oGTxy9BQ94WOXnur3jyXn1+Y1QQ2LCY
         pyng==
X-Gm-Message-State: AC+VfDwPmnPY28B192v/kBrKnZN0Ssaww5LM94rXgvE0ty92i7MWA2TM
        am4cKfn83VHEGthOFaW9OSn4AoLszpI=
X-Google-Smtp-Source: ACHHUZ4Hw0BvIywoUdS8T4+40B48lJk0jGBfqwzfbOZrikpfDpqi3VmFOGmP3duVEiEO4h985xFPLQ==
X-Received: by 2002:a17:907:6e0a:b0:967:e015:f542 with SMTP id sd10-20020a1709076e0a00b00967e015f542mr12764969ejc.44.1683808361963;
        Thu, 11 May 2023 05:32:41 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id s24-20020aa7d798000000b0050bc37ff74asm2950213edq.44.2023.05.11.05.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:32:41 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: make header files self-including
Date:   Thu, 11 May 2023 14:32:35 +0200
Message-Id: <20230511123236.723025-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
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

Include all necessary headers in header files to enable third party
applications, like LSP servers, to resolve all used symbols.

ibpkey.h: include "../flask.h" for SECINITSID_UNLABELED
initial_sid_to_string.h: include <linux/stddef.h> for NULL

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/ibpkey.h                | 1 +
 security/selinux/include/initial_sid_to_string.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
index c992f83b0aae..f8a791b07092 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -15,6 +15,7 @@
 #define _SELINUX_IB_PKEY_H
 
 #include <linux/types.h>
+#include "../flask.h"
 
 #ifdef CONFIG_SECURITY_INFINIBAND
 void sel_ib_pkey_flush(void);
diff --git a/security/selinux/include/initial_sid_to_string.h b/security/selinux/include/initial_sid_to_string.h
index 60820517aa43..ecc6e74fa09b 100644
--- a/security/selinux/include/initial_sid_to_string.h
+++ b/security/selinux/include/initial_sid_to_string.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/stddef.h>
+
 static const char *const initial_sid_to_string[] = {
 	NULL,
 	"kernel",
-- 
2.40.1

