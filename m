Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D80870038E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbjELJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbjELJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:22:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93EA10E49;
        Fri, 12 May 2023 02:22:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so87572154a12.0;
        Fri, 12 May 2023 02:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683883328; x=1686475328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8e0icE3DzwJ0q8S0zcOAvv0mzDXd8pUb6FlHP/5Hbs=;
        b=nmiRftXjqQhVsLaaVEh29GEPTMdH1oQnJjUYlAb9EVI8kGPkrhtuRizWKHDwoI2mJq
         31BNopRs6JUYawn4vmKKbXmZuMAynwPfcmPBr3NoPo7gRMR/FmR8kOV74ghR2NYTOShr
         liZpb8TYT8++f4o53s58EVmJgRiofghgJqAz7g2U3De9nXfr5CuKn5ms5wo+FfHf19Ik
         ZycZWEIFhAKmARcB+j5iLxnYtaHJ2iST9A96a8YgAYiJ3bvNPxqWsYcmQXaZHNIx91Fx
         bRE6s+/TZX0MfqOOWBkQmuUIz/xljjA50cOEELl8UcxATogE9miVoTdNNscKECva6hLl
         UKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683883328; x=1686475328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8e0icE3DzwJ0q8S0zcOAvv0mzDXd8pUb6FlHP/5Hbs=;
        b=lFLt3kA3FnsdBFZ8Yp3Z91zqDrg4oQ2xya5Q+BWjIC5xJaYS+osMuWjbRwcuBsIw4M
         nxf1tMDV3zzl/y/RHyx2ZFAiVM73kAo8Mw6jnwHFfeqoUKcjDeOIc1TZJh+h0W/4V/ih
         sCusECGgctdL46y7E8S5dEjbFIzb4uwZ7Ky3YvY90IDgLZVyhSD7Es2nPpkoK0lx8lCM
         3zHBZU0z9VjJFz0HRXrVgvY3qo/TMLZTmZU3myyh/wMX1fB8bXUXjZ1C1H+i9OZkPWvq
         FdNmZpP60OF64RKHSzpgr3f7c5yEIjdD/3mJeZUCGq5obdMqKTgUUtXWS0Ht4cCEyTQv
         itUA==
X-Gm-Message-State: AC+VfDzWKAvO+WtH2uFgSVPIK+IesPdXvgu4k+4ciA34WnANQ9VUYafC
        gb0NhHeaVQYcWs9HNqf31g7EgSYSdJon1w==
X-Google-Smtp-Source: ACHHUZ6hCIZYsmx8Q7LZJC5KojKvD9cjYZvXRxbpQHewlOkgeAot5A783VEo7hsNohO71WM7nb2yEA==
X-Received: by 2002:aa7:ccc6:0:b0:50b:dfe2:91 with SMTP id y6-20020aa7ccc6000000b0050bdfe20091mr21351040edt.7.1683883327825;
        Fri, 12 May 2023 02:22:07 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-181-041.95.116.pool.telefonica.de. [95.116.181.41])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7cc8f000000b0050bcca2e459sm3652156edt.8.2023.05.12.02.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 02:22:07 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] selinux: make header files self-including
Date:   Fri, 12 May 2023 11:21:55 +0200
Message-Id: <20230512092157.41850-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511123236.723025-1-cgzones@googlemail.com>
References: <20230511123236.723025-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include all necessary headers in header files to enable third party
applications, like LSP servers, to resolve all used symbols.

ibpkey.h: include "flask.h" for SECINITSID_UNLABELED
initial_sid_to_string.h: include <linux/stddef.h> for NULL

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
    use raw flask.h instead of ../flask.h
    Link: https://lore.kernel.org/oe-kbuild-all/202305121044.Q88iF2NQ-lkp@intel.com/
---
 security/selinux/include/ibpkey.h                | 1 +
 security/selinux/include/initial_sid_to_string.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/security/selinux/include/ibpkey.h b/security/selinux/include/ibpkey.h
index c992f83b0aae..875b055849e1 100644
--- a/security/selinux/include/ibpkey.h
+++ b/security/selinux/include/ibpkey.h
@@ -15,6 +15,7 @@
 #define _SELINUX_IB_PKEY_H
 
 #include <linux/types.h>
+#include "flask.h"
 
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

