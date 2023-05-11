Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535E16FF18C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbjEKMc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjEKMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:32:24 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567D40F7;
        Thu, 11 May 2023 05:32:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-965e93f915aso1421923266b.2;
        Thu, 11 May 2023 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683808339; x=1686400339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpFCNWYEoyxGLamlVtGBTAfhhqfRF4QezHpbobxA/FY=;
        b=fWk5CuRJg8SYKLgZdauP3BRsmpVS4LnfF9rI9/Sf343SLC8KtoXqjDWemvr9da8Qk5
         0iq2yY9biC4KpgoP09qQKJN87l0ovf11apQukRf1cMMMQ06ykxXjHevCZ1g8JfioKqxB
         c4PbvJKiUTEGbMIceJzcMuTEQCczkUNAiiIK6qSU8eZ9G0NWQ74VCluNKnEOmJ1DXnm6
         AUMFpSoXG5sXDbULn+2h06ujQAu7wha4QQKrd9rKpvP0V6xkQ9O3+Vbn/eWcdYTz3Fag
         KKQhw62AhnlM9NCKEhLSwpXPkL/L+Ay5k0Ie5EnYcDr/xQbquLcjDAK61kkZycvY78S2
         ibDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683808339; x=1686400339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpFCNWYEoyxGLamlVtGBTAfhhqfRF4QezHpbobxA/FY=;
        b=VZIWWOrNV2oTNQetfEIby/+qCTvji15TlkfJeTsbHaxvaosurtT39guujX2Lied6Dp
         +Zx700XSApbC64juOV99av43tSCYJ6pgl1v2cEfPchlwa6sj8HUZbheZCekag0HduKKd
         0ZqJOKE2qaOmTdQCLYAYYSn2RVBKLvFOY8wEKuF5tLtiGtSeTHo1sVyCqZSrjwICPUrL
         kv0GOscqlWYETeYHe05VIB3qJ6uZon/54/doQApb1uLKMzPCiEwbomN3MdU8//8HtDNe
         Oe/8WsXD4w6Yympmd0u+FJ0XW+5peCrXzpHQXQXxI6LBlqC6i+Hidch3dFehVbZj+0vL
         z7Pw==
X-Gm-Message-State: AC+VfDyKViYPihSHjCQsHLn9f5zB+/4v05yBCMl8MBzc4KJ1ei1AWbQA
        WM4CGYKrHeeWgaam3HsxnmM/QOwoeIk=
X-Google-Smtp-Source: ACHHUZ674fyUEpydXaf0GXLzIdR3ik3AJS2+i+ffWrsiKAgqDfyHIDuOVT3a2SN+zHozm6Fa+G+Ucg==
X-Received: by 2002:a17:907:629e:b0:946:be05:ed7a with SMTP id nd30-20020a170907629e00b00946be05ed7amr19143790ejc.70.1683808338695;
        Thu, 11 May 2023 05:32:18 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709060a4400b0095ed3befbedsm3949057ejf.54.2023.05.11.05.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 05:32:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selinux: deprecated fs ocon
Date:   Thu, 11 May 2023 14:32:12 +0200
Message-Id: <20230511123213.722912-1-cgzones@googlemail.com>
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

The object context type `fs`, not to be confused with the well used
object context type `fscon`, was introduced in the initial git commit
1da177e4c3f4 ("Linux-2.6.12-rc2") but never actually used since.

The paper "A Security Policy Configuration for the Security-Enhanced
Linux" [1] mentions it under `7.2 File System Contexts` but also states:

    Currently, this configuration is unused.

The policy statement defining such object contexts is `fscon`, e.g.:

    fscon 2 3 gen_context(system_u:object_r:conA_t,s0) gen_context(system_u:object_r:conB_t,s0)

It is not documented at selinuxproject.org or in the SELinux notebook
and not supported by the Reference Policy buildsystem - the statement is
not properly sorted - and thus not used in the Reference or Fedora
Policy.

Print a warning message at policy load for each such object context:

    SELinux:  void and deprecated fs ocon 02:03

This topic was initially highlighted by Nicolas Iooss [2].

[1]: https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
[2]: https://lore.kernel.org/selinux/CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com/

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/policydb.c | 4 ++++
 security/selinux/ss/policydb.h | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 97c0074f9312..31b08b34c722 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2257,6 +2257,10 @@ static int ocontext_read(struct policydb *p, const struct policydb_compat_info *
 				if (rc)
 					goto out;
 
+				if (i == OCON_FS)
+					pr_warn("SELinux:  void and deprecated fs ocon %s\n",
+						c->u.name);
+
 				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
 					goto out;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index ffc4e7bad205..39cd6222e1a8 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -225,7 +225,7 @@ struct genfs {
 
 /* object context array indices */
 #define OCON_ISID	0 /* initial SIDs */
-#define OCON_FS		1 /* unlabeled file systems */
+#define OCON_FS		1 /* unlabeled file systems (deprecated in 6.5) */
 #define OCON_PORT	2 /* TCP and UDP port numbers */
 #define OCON_NETIF	3 /* network interfaces */
 #define OCON_NODE	4 /* nodes */
-- 
2.40.1

